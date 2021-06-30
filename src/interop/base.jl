export create_function, call_function, isboxed, isghosttype

"""
    create_function(rettyp::LLVMType, argtyp::Vector{LLVMType}, [name::String])

Create an LLVM function, given its return type `rettyp` and a vector of argument types
`argtyp`. The function is marked for inlining, to be embedded in the caller's body.
Returns both the newly created function, and its type.
"""
function create_function(rettyp::LLVMType=LLVM.VoidType(Context()),
                         argtyp::Vector{<:LLVMType}=LLVMType[],
                         name::String="entry")
    ctx = context(rettyp)
    mod = LLVM.Module("llvmcall", ctx)
    isempty(name) && throw(ArgumentError("Function name cannot be empty"))

    ft = LLVM.FunctionType(rettyp, argtyp)
    f = LLVM.Function(mod, name, ft)
    push!(function_attributes(f), EnumAttribute("alwaysinline", 0, ctx))

    return f, ft
end

"""
    call_function(f::LLVM.Function, rettyp::Type, argtyp::Type, args...)

Generate a call to an LLVM function `f`, given its return type `rettyp` and a tuple-type for
the arguments. The arguments should be passed as a tuple expression containing the argument
values (eg. `:((1,2))`), which will be splatted into the call to the function.
"""
function call_function(llvmf::LLVM.Function, rettyp::Type=Nothing, argtyp::Type=Tuple{},
                       args...)
    mod = LLVM.parent(llvmf)
    ir = string(mod)
    fn = LLVM.name(llvmf)
    @assert !isempty(fn)
    quote
        Base.@_inline_meta
        Base.llvmcall(($ir,$fn), $rettyp, $argtyp, $(args...))
    end
end

"""
    isboxed(typ::Type)

Return if a type would be boxed when instantiated in the code generator.
"""
function isboxed(typ::Type)
    isboxed_ref = Ref{Bool}()
    ccall(:jl_type_to_llvm, LLVM.API.LLVMTypeRef, (Any, Ptr{Bool}), typ, isboxed_ref)
    return isboxed_ref[]
end

"""
    convert(LLVMType, typ::Type, [ctx::Context]; allow_boxed=true)

Convert a Julia type `typ` to its LLVM representation. Fails if the type would be boxed.
If `ctx` is specified, the return LLVM type will be valid in that context.
"""
function Base.convert(::Type{LLVMType}, typ::Type, ctx::Union{Nothing,Context}=nothing;
                      allow_boxed::Bool=false)
    isboxed_ref = Ref{Bool}()
    llvmtyp = LLVMType(ccall(:jl_type_to_llvm, LLVM.API.LLVMTypeRef,
                             (Any, Ptr{Bool}), typ, isboxed_ref))
    if !allow_boxed && isboxed_ref[]
        error("Conversion of boxed type $typ is not allowed")
    end

    if ctx !== nothing && ctx != context(llvmtyp)
        # FIXME: Julia currently doesn't offer an API to fetch types in a specific context

        if llvmtyp == LLVM.VoidType(context(llvmtyp))
            return LLVM.VoidType(ctx)
        end

        # serialize
        buf = let
            mod = LLVM.Module("")
            gv = LLVM.GlobalVariable(mod, llvmtyp, "")
            convert(MemoryBuffer, mod)
        end

        # deserialize in different context
        llvmtyp = let
            mod = parse(LLVM.Module, buf, ctx)
            gv = first(globals(mod))
            eltype(llvmtype(gv))
        end
    end

    return llvmtyp
end

"""
    isghosttype(t::Type, [ctx::Context])
    isghosttype(T::LLVMType)

Check if a type is a ghost type, implying it would not be emitted by the Julia compiler.
This only works for types created by the Julia compiler (living in its LLVM context).
"""
isghosttype(@nospecialize(T::LLVMType)) = T == LLVM.VoidType(context(T)) || isempty(T)
isghosttype(@nospecialize(t::Type), ctx::Context) =
    isghosttype(convert(LLVMType, t, ctx; allow_boxed=true))
function isghosttype(@nospecialize(t::Type))
    Context() do ctx
        isghosttype(t, ctx)
    end
end
