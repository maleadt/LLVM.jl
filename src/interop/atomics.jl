const MEMORY_ORDERING_EXPLANATION = """
specified as a symbol (e.g., `:sequentially_consistent`) or a `Val` of a symbol (e.g.,
`Val(:sequentially_consistent)`)
"""

"""
    LLVM.Interop.atomic_pointerref(pointer::LLVMPtr{T}, ordering) -> value::T

Load a `value` from `pointer` with the given memory `ordering` atomically.

`ordering` is a Julia atomic ordering $MEMORY_ORDERING_EXPLANATION.

See also: `getproperty`, `getfield`
"""
atomic_pointerref

"""
    LLVM.Interop.atomic_pointerset(pointer::LLVMPtr{T}, x::T, ordering) -> pointer

Store a value `x` in `pointer` with the given memory `ordering` atomically.

`ordering` is a Julia atomic ordering $MEMORY_ORDERING_EXPLANATION.

See also: `setproperty!`, `setfield!`
"""
atomic_pointerset

"""
    LLVM.Interop.atomic_pointermodify(
        pointer::LLVMPtr{T},
        op,
        x::T,
        ordering,
    ) -> (old => new)::Pair{T,T}

Replace an `old` value stored at `pointer` with a `new` value comped as `new = op(old, x)`
with the given memory `ordering` atomically.  Return a pair `old => new`.

`ordering` is a Julia atomic ordering $MEMORY_ORDERING_EXPLANATION.

See also: `modifyproperty!`, `modifyfield!`
"""
atomic_pointermodify

"""
    LLVM.Interop.atomic_pointerswap(pointer::LLVMPtr{T}, op, new::T, ordering) -> old::T

Replace an `old` value stored at `pointer` with a `new` value with the given memory
`ordering` atomically.  Return the `old` value.

`ordering` is a Julia atomic ordering $MEMORY_ORDERING_EXPLANATION.

See also: `modifyproperty!`, `modifyfield!`
"""
atomic_pointerswap

"""
    LLVM.Interop.atomic_pointerreplace(
        pointer::LLVMPtr{T},
        expected::T,
        desired::T,
        success_ordering,
        fail_ordering,
    ) -> (; old::T, success::Bool)

Try to replace the value of `pointer` from an `expected` value to a `desired` value
atomically with the ordering `success_ordering`.  The property `old` of the returned value
is the value stored in the `pointer`.  The property `success` of the returned value
indicates if the replacement was successful.  The ordering `fail_ordering` specifies the
ordering used for loading the `old` value.

`success_ordering` and `fail_ordering` are Julia atomic orderings
$MEMORY_ORDERING_EXPLANATION.

See also: `replaceproperty!`, `replacefield!`
"""
atomic_pointerreplace

const _llvm_from_julia_ordering = (
    not_atomic = LLVM.API.LLVMAtomicOrderingNotAtomic,
    unordered = LLVM.API.LLVMAtomicOrderingUnordered,
    monotonic = LLVM.API.LLVMAtomicOrderingMonotonic,
    acquire = LLVM.API.LLVMAtomicOrderingAcquire,
    release = LLVM.API.LLVMAtomicOrderingRelease,
    acquire_release = LLVM.API.LLVMAtomicOrderingAcquireRelease,
    sequentially_consistent = LLVM.API.LLVMAtomicOrderingSequentiallyConsistent,
)

_julia_ordering(p) =
    Union{map(x -> p(x) ? Val{x} : Union{}, keys(_llvm_from_julia_ordering))...}

const AllOrdering = _julia_ordering(_ -> true)
const AtomicOrdering = _julia_ordering(!=(:not_atomic))

const LLVMOrderingVal = Union{map(x -> Val{x}, values(_llvm_from_julia_ordering))...}

is_stronger_than_monotonic(order::Symbol) =
    !(order === :monotonic || order === :unordered || order === :not_atomic)

for (julia, llvm) in pairs(_llvm_from_julia_ordering)
    @eval llvm_from_julia_ordering(::Val{$(QuoteNode(julia))}) = Val{$llvm}()
end

"""
    @dynamic_order(order) do order
        ... use order ...
    end

It is expanded to an expression similar to:

    if order === :not_atomic
        let order = Val(:not_atomic)
            ... use order ...
        end
    elseif order === :unordered
        let order = Val(:unordered)
            ... use order ...
        end
    elseif ...
        ...
    else
        throw(ConcurrencyViolationError(...))
    end

This is used for helping the compiler to optimize expressions such as
`atomic_pointerref(ptr, :monotonic)` and also to avoid abstract run-time dispatch.
"""
macro dynamic_order(thunk, order)
    @assert Meta.isexpr(thunk, :->, 2) && Meta.isexpr(thunk.args[1], :tuple, 1)
    ordervar = esc(thunk.args[1].args[1])
    body = esc(thunk.args[2])
    expr = foldr(
        keys(_llvm_from_julia_ordering),
        init = :(throw(ConcurrencyViolationError("invalid atomic ordering: ", order))),
    ) do key, r
        quote
            if order === $(QuoteNode(key))
                let $ordervar = Val{$(QuoteNode(key))}()
                    $body
                end
            else
                $r
            end
        end
    end
    quote
        order = $(esc(order))
        $expr
    end
end

_valueof(::Val{x}) where {x} = x

@inline function atomic_pointerref(pointer, order::Symbol)
    @dynamic_order(order) do order
        atomic_pointerref(pointer, order)
    end
end

@inline function atomic_pointerset(pointer, x, order::Symbol)
    @dynamic_order(order) do order
        atomic_pointerset(pointer, x, order)
    end
end

@generated function atomic_pointerref(ptr::LLVMPtr{T,A}, order::AllOrdering) where {T,A}
    sizeof(T) == 0 && return T.instance
    llvm_order = _valueof(llvm_from_julia_ordering(order()))
    @dispose ctx=Context() begin
        eltyp = convert(LLVMType, T; ctx)

        T_ptr = convert(LLVMType, ptr; ctx)

        T_typed_ptr = LLVM.PointerType(eltyp, A)

        # create a function
        param_types = [T_ptr]
        llvm_f, _ = create_function(eltyp, param_types)

        # generate IR
        @dispose builder=Builder(ctx) begin
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)
            if !LLVM.has_opaque_ptr()
                typed_ptr = bitcast!(builder, parameters(llvm_f)[1], T_typed_ptr)
                ld = load!(builder, typed_ptr)
            else
                ld = load!(builder, eltyp, parameters(llvm_f)[1])
            end
            ordering!(ld, llvm_order)

            if A != 0
                metadata(ld)[LLVM.MD_tbaa] = tbaa_addrspace(A; ctx)
            end
            alignment!(ld, sizeof(T))

            ret!(builder, ld)
        end

        call_function(llvm_f, T, Tuple{LLVMPtr{T,A}}, :ptr)
    end
end

@generated function atomic_pointerset(
    ptr::LLVMPtr{T,A},
    x::T,
    order::AllOrdering,
) where {T,A}
    if sizeof(T) == 0
        # Mimicking what `Core.Intrinsics.atomic_pointerset` generates.
        # See: https://github.com/JuliaLang/julia/blob/v1.7.2/src/cgutils.cpp#L1570-L1572
        is_stronger_than_monotonic(order) || return :ptr
        return quote
            Core.Intrinsics.fence($(QuoteNode(order)))
            ptr
        end
    end
    llvm_order = _valueof(llvm_from_julia_ordering(order()))
    @dispose ctx=Context() begin
        eltyp = convert(LLVMType, T; ctx)
        T_ptr = convert(LLVMType, ptr; ctx)
        T_typed_ptr = LLVM.PointerType(eltyp, A)

        # create a function
        param_types = [T_ptr, eltyp]
        llvm_f, _ = create_function(LLVM.VoidType(ctx), param_types)

        # generate IR
        @dispose builder=Builder(ctx) begin
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)

            typed_ptr = bitcast!(builder, parameters(llvm_f)[1], T_typed_ptr)
            val = parameters(llvm_f)[2]
            st = store!(builder, val, typed_ptr)
            ordering!(st, llvm_order)

            if A != 0
                metadata(st)[LLVM.MD_tbaa] = tbaa_addrspace(A; ctx)
            end
            alignment!(st, sizeof(T))

            ret!(builder)
        end

        call = call_function(llvm_f, Cvoid, Tuple{LLVMPtr{T,A},T}, :ptr, :x)
        quote
            $call
            ptr
        end
    end
end

right(_, r) = r

const binoptable = [
    (:xchg, right, LLVM.API.LLVMAtomicRMWBinOpXchg),
    (:add, +, LLVM.API.LLVMAtomicRMWBinOpAdd),
    (:sub, -, LLVM.API.LLVMAtomicRMWBinOpSub),
    (:and, &, LLVM.API.LLVMAtomicRMWBinOpAnd),
    (:or, |, LLVM.API.LLVMAtomicRMWBinOpOr),
    (:xor, xor, LLVM.API.LLVMAtomicRMWBinOpXor),
    (:max, max, LLVM.API.LLVMAtomicRMWBinOpMax),
    (:min, min, LLVM.API.LLVMAtomicRMWBinOpMin),
    (:umax, max, LLVM.API.LLVMAtomicRMWBinOpUMax),
    (:umin, min, LLVM.API.LLVMAtomicRMWBinOpUMin),
    (:fadd, +, LLVM.API.LLVMAtomicRMWBinOpFAdd),
    (:fsub, -, LLVM.API.LLVMAtomicRMWBinOpFSub),
]

const AtomicRMWBinOpVal = Union{(Val{binop} for (_, _, binop) in binoptable)...}

@generated function llvm_atomic_op(
    binop::AtomicRMWBinOpVal,
    ptr::LLVMPtr{T,A},
    val::T,
    order::LLVMOrderingVal,
) where {T,A}
    @dispose ctx=Context() begin
        T_val = convert(LLVMType, T; ctx)
        T_ptr = convert(LLVMType, ptr; ctx)

        T_typed_ptr = LLVM.PointerType(T_val, A)

        llvm_f, _ = create_function(T_val, [T_ptr, T_val])

        @dispose builder=Builder(ctx) begin
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)

            typed_ptr = bitcast!(builder, parameters(llvm_f)[1], T_typed_ptr)

            single_threaded = false
            rv = atomic_rmw!(
                builder,
                _valueof(binop()),
                typed_ptr,
                parameters(llvm_f)[2],
                _valueof(order()),
                single_threaded,
            )

            ret!(builder, rv)
        end

        call_function(llvm_f, T, Tuple{LLVMPtr{T,A},T}, :ptr, :val)
    end
end

@inline function atomic_pointermodify(pointer, op::OP, x, order::Symbol) where {OP}
    @dynamic_order(order) do order
        atomic_pointermodify(pointer, op, x, order)
    end
end

@inline function atomic_pointermodify(
    ptr::LLVMPtr{T},
    op,
    x::T,
    ::Val{:not_atomic},
) where {T}
    old = atomic_pointerref(ptr, Val(:not_atomic))
    new = op(old, x)
    atomic_pointerset(ptr, new, Val(:not_atomic))
    return old => new
end

@inline function atomic_pointermodify(
    ptr::LLVMPtr{T},
    ::typeof(right),
    x::T,
    order::AtomicOrdering,
) where {T}
    old = llvm_atomic_op(
        Val(LLVM.API.LLVMAtomicRMWBinOpXchg),
        ptr,
        x,
        llvm_from_julia_ordering(order),
    )
    return old => x
end

const atomictypes = Any[
    Int8,
    Int16,
    Int32,
    Int64,
    Int128,
    UInt8,
    UInt16,
    UInt32,
    UInt64,
    UInt128,
    Float16,
    Float32,
    Float64,
]

for (opname, op, llvmop) in binoptable
    opname === :xchg && continue
    types = if opname in (:min, :max)
        filter(t -> t <: Signed, atomictypes)
    elseif opname in (:umin, :umax)
        filter(t -> t <: Unsigned, atomictypes)
    elseif opname in (:fadd, :fsub)
        filter(t -> t <: AbstractFloat, atomictypes)
    else
        filter(t -> t <: Integer, atomictypes)
    end
    for T in types
        @eval @inline function atomic_pointermodify(
            ptr::LLVMPtr{$T},
            ::$(typeof(op)),
            x::$T,
            order::AtomicOrdering,
        )
            old = llvm_atomic_op($(Val(llvmop)), ptr, x, llvm_from_julia_ordering(order))
            return old => $op(old, x)
        end
    end
end

@inline atomic_pointerswap(pointer, new) = first(atomic_pointermodify(pointer, right, new))
@inline atomic_pointerswap(pointer, new, order) =
    first(atomic_pointermodify(pointer, right, new, order))

@inline function atomic_pointermodify(
    ptr::LLVMPtr{T},
    op,
    x::T,
    order::AllOrdering,
) where {T}
    # Should `fail_order` be stronger?  Ref: https://github.com/JuliaLang/julia/issues/45256
    fail_order = Val(:monotonic)
    old = atomic_pointerref(ptr, fail_order)
    while true
        new = op(old, x)
        (old, success) = atomic_pointerreplace(ptr, old, new, order, fail_order)
        success && return old => new
    end
end

@generated function llvm_atomic_cas(
    ptr::LLVMPtr{T,A},
    cmp::T,
    val::T,
    success_order::LLVMOrderingVal,
    fail_order::LLVMOrderingVal,
) where {T,A}
    llvm_success = _valueof(success_order())
    llvm_fail = _valueof(fail_order())
    @dispose ctx=Context() begin
        T_val = convert(LLVMType, T; ctx)
        T_pointee = T_val
        if T_val isa LLVM.FloatingPointType
            T_pointee = LLVM.IntType(sizeof(T) * 8; ctx)
        end
        T_ptr = convert(LLVMType, ptr; ctx)
        T_success = convert(LLVMType, Ptr{Int8}; ctx)

        T_typed_ptr = LLVM.PointerType(T_pointee, A)
        T_ok_ptr = LLVM.PointerType(convert(LLVMType, Int8; ctx))

        llvm_f, _ = create_function(T_val, [T_ptr, T_val, T_val, T_success])

        @dispose builder=Builder(ctx) begin
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)

            typed_ptr = bitcast!(builder, parameters(llvm_f)[1], T_typed_ptr)
            ok_ptr = inttoptr!(builder, parameters(llvm_f)[4], T_ok_ptr)

            cmp_int = parameters(llvm_f)[2]
            if T_val isa LLVM.FloatingPointType
                cmp_int = bitcast!(builder, cmp_int, T_pointee)
            end

            val_int = parameters(llvm_f)[3]
            if T_val isa LLVM.FloatingPointType
                val_int = bitcast!(builder, val_int, T_pointee)
            end

            single_threaded = false
            res = atomic_cmpxchg!(
                builder,
                typed_ptr,
                cmp_int,
                val_int,
                llvm_success,
                llvm_fail,
                single_threaded,
            )

            rv = extract_value!(builder, res, 0)
            ok = extract_value!(builder, res, 1)
            ok = zext!(builder, ok, LLVM.Int8Type(ctx))
            store!(builder, ok, ok_ptr)

            if T_val isa LLVM.FloatingPointType
                rv = bitcast!(builder, rv, T_val)
            end

            ret!(builder, rv)
        end

        expr = call_function(
            llvm_f,
            T,
            Tuple{LLVMPtr{T,A},T,T,Ptr{Int8}},
            :ptr,
            :cmp,
            :val,
            :success_ptr,
        )
        quote
            success = Ref{Int8}()
            old = GC.@preserve success begin
                success_ptr = Ptr{Int8}(pointer_from_objref(success))
                $expr
            end
            (; old, success = success[] != zero(Int8))
        end
    end
end

@inline function atomic_pointerreplace(
    pointer,
    expected,
    desired,
    success_order::Symbol,
    fail_order::Symbol,
)
    # This avoids abstract dispatch at run-time but probably too much codegen?
    #=
    @dynamic_order(success_order) do success_order
        @dynamic_order(fail_order) do fail_order
            atomic_pointerreplace(pointer, expected, desired, success_order, fail_order)
        end
    end
    =#

    # This avoids excessive codegen while hopefully imposes no cost when const-prop works:
    so = @dynamic_order(success_order) do success_order
        success_order
    end
    fo = @dynamic_order(fail_order) do fail_order
        fail_order
    end
    return atomic_pointerreplace(pointer, expected, desired, so, fo)
end

@inline function atomic_pointerreplace(
    ptr::LLVMPtr{T},
    expected::T,
    desired::T,
    ::Val{:not_atomic},
    ::Val{:not_atomic},
) where {T}
    old = atomic_pointerref(ptr, Val(:not_atomic))
    if old === expected
        atomic_pointerset(ptr, desired, Val(:not_atomic))
        success = true
    else
        success = false
    end
    return (; old, success)
end

@inline atomic_pointerreplace(
    ptr::LLVMPtr{T},
    expected::T,
    desired::T,
    success_order::_julia_ordering(∉((:not_atomic, :unordered))),
    fail_order::_julia_ordering(∉((:not_atomic, :unordered, :release, :acquire_release))),
) where {T} = llvm_atomic_cas(
    ptr,
    expected,
    desired,
    llvm_from_julia_ordering(success_order),
    llvm_from_julia_ordering(fail_order),
)
