export JuliaContext, create_function, call_function, isboxed, isghosttype

"""
    JuliaContext()

Returns the (session-bound) LLVM context used by the Julia compiler.
"""
function JuliaContext()
    ptr = cglobal(:jl_LLVMContext)
    ref = if VERSION >= v"1.3.0-DEV.550"
        ptr = convert(Ptr{LLVM.API.LLVMContextRef}, ptr)
        unsafe_load(ptr)
    else
        convert(LLVM.API.LLVMContextRef, ptr)
    end
    LLVM.Context(ref)
end

"""
    create_function(rettyp::LLVMType, argtyp::Vector{LLVMType}, [name::String])

Create an LLVM function, given its return type `rettyp` and a vector of argument types
`argtyp`. The function is marked for inlining, to be embedded in the caller's body.
Returns both the newly created function, and its type.
"""
function create_function(rettyp::LLVMType=LLVM.VoidType(JuliaContext()),
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
    call_function(f::LLVM.Function, rettyp::Type, argtyp::Type, args::Expr)

Generate a call to an LLVM function `f`, given its return type `rettyp` and a tuple-type for
the arguments. The arguments should be passed as an expression yielding a tuple of the
argument values (eg. `:((1,2))`), which will be splatted into the call to the function.
"""
function call_function(llvmf::LLVM.Function, rettyp::Type=Nothing, argtyp::Type=Tuple{},
                       args::Expr=:())
    mod = LLVM.parent(llvmf)
    ir = convert(String, mod)
    fn = LLVM.name(llvmf)
    @assert !isempty(fn)
    quote
        Base.@_inline_meta
        Base.llvmcall(($ir,$fn), $rettyp, $argtyp, $args...)
    end
end

"""
    isboxed(typ::Type)

Return if a type would be boxed when instantiated in the code generator.
"""
function isboxed(typ::Type)
    isboxed_ref = Ref{Bool}()
    if VERSION >= v"1.5.0-DEV.393"
        ccall(:jl_type_to_llvm, LLVM.API.LLVMTypeRef, (Any, Ptr{Bool}), typ, isboxed_ref)
    else
        ccall(:julia_type_to_llvm, LLVM.API.LLVMTypeRef, (Any, Ptr{Bool}), typ, isboxed_ref)
    end
    return isboxed_ref[]
end

"""
    convert(LLVMType, typ::Type)

Convert a Julia type `typ` to its LLVM representation. Fails if the type would be boxed.
"""
function Base.convert(::Type{LLVMType}, typ::Type, allow_boxed::Bool=false)
    isboxed_ref = Ref{Bool}()
    if VERSION >= v"1.5.0-DEV.393"
        llvmtyp = LLVMType(ccall(:jl_type_to_llvm, LLVM.API.LLVMTypeRef,
                                 (Any, Ptr{Bool}), typ, isboxed_ref))
    else
        llvmtyp = LLVMType(ccall(:julia_type_to_llvm, LLVM.API.LLVMTypeRef,
                                 (Any, Ptr{Bool}), typ, isboxed_ref))
    end
    if !allow_boxed && isboxed_ref[]
        error("Conversion of boxed type $typ is not allowed")
    end
    return llvmtyp
end

"""
    isghosttype(t::Type)
    isghosttype(T::LLVMType)

Check if a type is a ghost type, implying it would not be emitted by the Julia compiler.
This only works for types created by the Julia compiler (living in its LLVM context).
"""
isghosttype(@nospecialize(T::LLVMType)) = T == LLVM.VoidType(JuliaContext()) || isempty(T)
isghosttype(@nospecialize(t::Type)) = isghosttype(convert(LLVMType, t, true))
