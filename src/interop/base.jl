export JuliaContext, create_function, call_function

"""
    JuliaContext()

Returns the (session-bound) LLVM context used by the Julia compiler.
"""
JuliaContext() = jlctx[]

"""
    create_function(rettyp::LLVMType, argtyp::Vector{LLVMType}, [name::String])

Create an LLVM function, given its return type `rettyp` and a vector of argument types
`argtyp`. The function is marked for inlining, to be embedded in the caller's body.
Returns both the newly created function, and its type.
"""
function create_function(rettyp::LLVMType=LLVM.VoidType(JuliaContext()),
                         argtyp::Vector{<:LLVMType}=LLVMType[],
                         name::String="")
    mod = LLVM.Module("llvmcall", JuliaContext())

    ft = LLVM.FunctionType(rettyp, argtyp)
    f = LLVM.Function(mod, name, ft)
    push!(function_attributes(f), EnumAttribute("alwaysinline"))
    linkage!(f, LLVM.API.LLVMPrivateLinkage)

    return f, ft
end

"""
    call_function(f::LLVM.Function, rettyp::Type, argtyp::Type, args::Expr)

Generate a call to an LLVM function `f`, given its return type `rettyp` and a tuple-type for
the arguments. The arguments should be passed as an expression yielding a tuple of the
argument values (eg. `:((1,2))`), which will be splatted into the call to the function.
"""

# call an LLVM function, given its return (Julia) type, a tuple-type for the arguments,
# and an expression yielding a tuple of the actual argument values.
function call_function(llvmf::LLVM.Function, rettyp::Type=Void, argtyp::Type=Tuple{},
                       args::Expr=:())
    quote
        Base.@_inline_meta
        Base.llvmcall(LLVM.ref($llvmf), $rettyp, $argtyp, $args...)
    end
end

"""
    convert(LLVMType, typ::Type)

Convert a Julia type `typ` to its LLVM representation. Fails if the type would be boxed.
"""
function Base.convert(::Type{LLVMType}, typ::Type)
    isboxed_ref = Ref{Bool}()
    llvmtyp = LLVMType(ccall(:julia_type_to_llvm, LLVM.API.LLVMTypeRef,
                             (Any, Ptr{Bool}), typ, isboxed_ref))
    @assert !isboxed_ref[]
    return llvmtyp
end
