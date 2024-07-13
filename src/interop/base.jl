export create_function, call_function, isboxed, isghosttype

"""
    create_function(rettyp::LLVMType, argtyp::Vector{LLVMType}, [name::String])

Create an LLVM function, given its return type `rettyp` and a vector of argument types
`argtyp`. The function is marked for inlining, to be embedded in the caller's body.
Returns both the newly created function, and its type.
"""
function create_function(rettyp::LLVMType=LLVM.VoidType(),
                         argtyp::Vector{<:LLVMType}=LLVMType[],
                         name::String="entry")
    mod = LLVM.Module("llvmcall")
    isempty(name) && throw(ArgumentError("Function name cannot be empty"))

    ft = LLVM.FunctionType(rettyp, argtyp)
    f = LLVM.Function(mod, name, ft)
    push!(function_attributes(f), EnumAttribute("alwaysinline", 0))

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
    dispose(mod)
    quote
        Base.@inline
        Base.llvmcall(($ir,$fn), $rettyp, $argtyp, $(args...))
    end
end


"""
    isboxed(typ::Type)

Return if a type would be boxed when instantiated in the code generator.
"""
function isboxed(typ::Type)
    if context(; throw_error=false) === nothing
        LLVM.Context() do _
            _isboxed(typ)
        end
    else
        _isboxed(typ)
    end
end
function _isboxed(typ::Type)
    isboxed_ref = Ref{Bool}()
    ccall(:jl_type_to_llvm, LLVM.API.LLVMTypeRef,
           (Any, LLVM.API.LLVMContextRef, Ptr{Bool}), typ, context(), isboxed_ref)
    return isboxed_ref[]
end

"""
    convert(LLVMType, typ::Type; allow_boxed=true)

Convert a Julia type `typ` to its LLVM representation in the current context.
The `allow_boxed` argument determines whether boxed types are allowed.
"""
function Base.convert(::Type{LLVMType}, typ::Type; allow_boxed::Bool=false)
    isboxed_ref = Ref{Bool}()
    llvmtyp =
        LLVMType(ccall(:jl_type_to_llvm, LLVM.API.LLVMTypeRef,
                        (Any, Context, Ptr{Bool}), typ, context(), isboxed_ref))
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
isghosttype(@nospecialize(T::LLVMType)) = T == LLVM.VoidType() || isempty(T)
function isghosttype(@nospecialize(t::Type))
    if context(; throw_error=false) === nothing
        LLVM.Context() do _
            T = convert(LLVMType, t; allow_boxed=true)
            isghosttype(T)
        end
    else
        T = convert(LLVMType, t; allow_boxed=true)
        isghosttype(T)
    end
end
