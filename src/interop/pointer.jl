# pointer intrinsics

export @typed_ccall

# TODO: can we use constant propagation instead of passing the alignment as a Val?

using Core: LLVMPtr

@generated function pointerref(ptr::LLVMPtr{T,A}, i::Int, ::Val{align}) where {T,A,align}
    sizeof(T) == 0 && return T.instance
    Context() do ctx
        eltyp = convert(LLVMType, T, ctx)

        T_int = convert(LLVMType, Int, ctx)
        T_ptr = convert(LLVMType, ptr, ctx)

        T_typed_ptr = LLVM.PointerType(eltyp, A)

        # create a function
        param_types = [T_ptr, T_int]
        llvm_f, _ = create_function(eltyp, param_types)

        # generate IR
        Builder(ctx) do builder
            entry = BasicBlock(llvm_f, "entry", ctx)
            position!(builder, entry)

            typed_ptr = bitcast!(builder, parameters(llvm_f)[1], T_typed_ptr)
            typed_ptr = inbounds_gep!(builder, typed_ptr, [parameters(llvm_f)[2]])
            ld = load!(builder, typed_ptr)

            if A != 0
                metadata(ld)[LLVM.MD_tbaa] = tbaa_addrspace(A, ctx)
            end
            alignment!(ld, align)

            ret!(builder, ld)
        end

        call_function(llvm_f, T, Tuple{LLVMPtr{T,A}, Int}, :((ptr, Int(i-one(i)))))
    end
end

@generated function pointerset(ptr::LLVMPtr{T,A}, x::T, i::Int, ::Val{align}) where {T,A,align}
    sizeof(T) == 0 && return
    Context() do ctx
        eltyp = convert(LLVMType, T, ctx)

        T_int = convert(LLVMType, Int, ctx)
        T_ptr = convert(LLVMType, ptr, ctx)

        T_typed_ptr = LLVM.PointerType(eltyp, A)

        # create a function
        param_types = [T_ptr, eltyp, T_int]
        llvm_f, _ = create_function(LLVM.VoidType(ctx), param_types)

        # generate IR
        Builder(ctx) do builder
            entry = BasicBlock(llvm_f, "entry", ctx)
            position!(builder, entry)

            typed_ptr = bitcast!(builder, parameters(llvm_f)[1], T_typed_ptr)
            typed_ptr = inbounds_gep!(builder, typed_ptr, [parameters(llvm_f)[3]])
            val = parameters(llvm_f)[2]
            st = store!(builder, val, typed_ptr)

            if A != 0
                metadata(st)[LLVM.MD_tbaa] = tbaa_addrspace(A, ctx)
            end
            alignment!(st, align)

            ret!(builder)
        end

        call_function(llvm_f, Cvoid, Tuple{LLVMPtr{T,A}, T, Int},
                      :((ptr, convert(T,x), Int(i-one(i)))))
    end
end

Base.unsafe_load(ptr::Core.LLVMPtr, i::Integer=1, align::Val=Val(1)) =
    pointerref(ptr, Int(i), align)

Base.unsafe_store!(ptr::Core.LLVMPtr{T}, x, i::Integer=1, align::Val=Val(1)) where {T} =
    pointerset(ptr, convert(T, x), Int(i), align)


# pointer operations

# NOTE: this is type-pirating; move functionality upstream

LLVMPtr{T,A}(x::Union{Int,UInt,Ptr}) where {T,A} = reinterpret(LLVMPtr{T,A}, x)
LLVMPtr{T,A}() where {T,A} = LLVMPtr{T,A}(0)

# conversions from and to integers
Base.UInt(x::LLVMPtr) = reinterpret(UInt, x)
Base.Int(x::LLVMPtr) = reinterpret(Int, x)
Base.convert(::Type{LLVMPtr{T,A}}, x::Union{Int,UInt}) where {T,A} =
    reinterpret(LLVMPtr{T,A}, x)

Base.isequal(x::LLVMPtr, y::LLVMPtr) = (x === y)
Base.isless(x::LLVMPtr{T,A}, y::LLVMPtr{T,A}) where {T,A} = x < y

Base.:(==)(x::LLVMPtr{<:Any,A}, y::LLVMPtr{<:Any,A}) where {A} = UInt(x) == UInt(y)
Base.:(<)(x::LLVMPtr{<:Any,A},  y::LLVMPtr{<:Any,A}) where {A} = UInt(x) < UInt(y)
Base.:(==)(x::LLVMPtr, y::LLVMPtr) = false

Base.:(-)(x::LLVMPtr{<:Any,A},  y::LLVMPtr{<:Any,A}) where {A} = UInt(x) - UInt(y)

Base.:(+)(x::LLVMPtr, y::Integer) = oftype(x, Base.add_ptr(UInt(x), (y % UInt) % UInt))
Base.:(-)(x::LLVMPtr, y::Integer) = oftype(x, Base.sub_ptr(UInt(x), (y % UInt) % UInt))
Base.:(+)(x::Integer, y::LLVMPtr) = y + x

Base.unsigned(x::LLVMPtr) = UInt(x)
Base.signed(x::LLVMPtr) = Int(x)


# pointer type-preserving ccall

@generated function _typed_llvmcall(::Val{intr}, rettyp, argtt, args...) where {intr}
    # make types available for direct use in this generator
    rettyp = rettyp.parameters[1]
    argtt = argtt.parameters[1]
    argtyps = DataType[argtt.parameters...]
    argexprs = Expr[:(args[$i]) for i in 1:length(args)]

    # build IR that calls the intrinsic, casting types if necessary
    Context() do ctx
        T_ret = convert(LLVMType, rettyp, ctx)
        T_args = LLVMType[convert(LLVMType, typ, ctx) for typ in argtyps]

        llvm_f, _ = create_function(T_ret, T_args)
        mod = LLVM.parent(llvm_f)

        Builder(ctx) do builder
            entry = BasicBlock(llvm_f, "entry", ctx)
            position!(builder, entry)

            # Julia's compiler strips pointers of their element type.
            # reconstruct those so that we can accurately look up intrinsics.
            T_actual_args = LLVMType[]
            actual_args = LLVM.Value[]
            for (arg, argtyp) in zip(parameters(llvm_f),argtyps)
                if argtyp <: LLVMPtr
                    # passed as i8*
                    T,AS = argtyp.parameters
                    actual_typ = LLVM.PointerType(convert(LLVMType, T, ctx), AS)
                    actual_arg = bitcast!(builder, arg, actual_typ)
                elseif argtyp <: Ptr
                    # passed as i64
                    T = eltype(argtyp)
                    actual_typ = LLVM.PointerType(convert(LLVMType, T, ctx))
                    actual_arg = inttoptr!(builder, arg, actual_typ)
                else
                    actual_typ = convert(LLVMType, argtyp, ctx)
                    actual_arg = arg
                end
                push!(T_actual_args, actual_typ)
                push!(actual_args, actual_arg)
            end

            # same for the return type
            if rettyp <: LLVMPtr
                T,AS = rettyp.parameters
                T_ret_actual = LLVM.PointerType(convert(LLVMType, T, ctx), AS)
            elseif rettyp <: Ptr
                T = eltype(rettyp)
                T_ret_actual = LLVM.PointerType(convert(LLVMType, T, ctx))
            else
                T_ret_actual = T_ret
            end

            intr_ft = LLVM.FunctionType(T_ret_actual, T_actual_args)
            intr_f = LLVM.Function(mod, String(intr), intr_ft)

            rv = call!(builder, intr_f, actual_args)

            if T_ret_actual == LLVM.VoidType(ctx)
                ret!(builder)
            else
                # also convert the return value
                if rettyp <: LLVMPtr
                    rv = bitcast!(builder, rv, T_ret)
                elseif rettyp <: Ptr
                    rv = ptrtoint!(builder, rv, T_ret)
                end

                ret!(builder, rv)
            end
        end

        call_function(llvm_f, rettyp, argtt, :(($(argexprs...),)))
    end
end

# perform a `ccall(intrinsic, llvmcall)` with accurate pointer types for calling intrinsic.
# this may be needed when selecting LLVM intrinsics, to avoid assertion failures, or when
# the back-end actually emits different code depending on types (e.g. SPIR-V and atomics).
#
# NOTE: this will become unnecessary when LLVM switches to typeless pointers,
#       or if and when Julia goes back to emitting exact types when passing pointers.
macro typed_ccall(intrinsic, cc, rettyp, argtyps, args...)
    # destructure and validate the arguments
    cc == :llvmcall || error("Can only use @typed_ccall with the llvmcall calling convention")
    Meta.isexpr(argtyps, :tuple) || error("@typed_ccall expects a tuple of argument types")

    # assign arguments to variables and unsafe_convert/cconvert them as per ccall behavior
    vars = Tuple(gensym() for arg in args)
    var_exprs = map(zip(vars, args)) do (var,arg)
        :($var = $arg)
    end
    arg_exprs = map(zip(vars,argtyps.args)) do (var,typ)
        :(Base.unsafe_convert($typ, Base.cconvert($typ, $var)))
    end

    esc(quote
        $(var_exprs...)
        GC.@preserve $(vars...) begin
            $_typed_llvmcall($(Val(Symbol(intrinsic))), $rettyp, Tuple{$(argtyps.args...)}, $(arg_exprs...))
        end
    end)
end
