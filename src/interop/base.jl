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
    mod = LLVM.Module("llvmcall"; ctx)
    isempty(name) && throw(ArgumentError("Function name cannot be empty"))

    ft = LLVM.FunctionType(rettyp, argtyp)
    f = LLVM.Function(mod, name, ft)
    push!(function_attributes(f), EnumAttribute("alwaysinline", 0; ctx))

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
    if VERSION >= v"1.8.0-DEV.410"
        quote
            Base.@inline
            Base.llvmcall(($ir,$fn), $rettyp, $argtyp, $(args...))
        end
    else
        quote
            Base.@_inline_meta
            Base.llvmcall(($ir,$fn), $rettyp, $argtyp, $(args...))
        end
    end
end


"""
    isboxed(typ::Type; [ctx::Context])

Return if a type would be boxed when instantiated in the code generator.
"""
function isboxed(typ::Type; ctx::Union{Nothing,Context}=nothing)
    isboxed_ref = Ref{Bool}()
    if VERSION >= v"1.9.0-DEV.115"
        if ctx === nothing
            @dispose ctx=Context() begin
                ccall(:jl_type_to_llvm, LLVM.API.LLVMTypeRef,
                      (Any, LLVM.API.LLVMContextRef, Ptr{Bool}), typ, ctx, isboxed_ref)
            end
        else
            ccall(:jl_type_to_llvm, LLVM.API.LLVMTypeRef,
                  (Any, LLVM.API.LLVMContextRef, Ptr{Bool}), typ, ctx, isboxed_ref)
        end
    else
        ccall(:jl_type_to_llvm, LLVM.API.LLVMTypeRef,
              (Any, Ptr{Bool}), typ, isboxed_ref)
    end
    return isboxed_ref[]
end

"""
    convert(LLVMType, typ::Type, ctx::Context; allow_boxed=true)

Convert a Julia type `typ` to its LLVM representation in context `ctx`.
The `allow_boxed` argument determines whether boxed types are allowed.
"""
function Base.convert(::Type{LLVMType}, typ::Type; ctx::Context,
                      allow_boxed::Bool=false)
    isboxed_ref = Ref{Bool}()
    llvmtyp = if VERSION >= v"1.9.0-DEV.115"
        LLVMType(ccall(:jl_type_to_llvm, LLVM.API.LLVMTypeRef,
                        (Any, Context, Ptr{Bool}), typ, ctx, isboxed_ref))
    else
        LLVMType(ccall(:jl_type_to_llvm, LLVM.API.LLVMTypeRef,
                        (Any, Ptr{Bool}), typ, isboxed_ref))
    end
    if !allow_boxed && isboxed_ref[]
        error("Conversion of boxed type $typ is not allowed")
    end

    # HACK: older versions of Julia don't offer an API to fetch types in a specific context
    if VERSION < v"1.9.0-DEV.115" && ctx != context(llvmtyp)
        if llvmtyp == LLVM.VoidType(context(llvmtyp))
            return LLVM.VoidType(ctx)
        end

        # serialize
        buf = let
            mod = LLVM.Module(""; ctx=context(llvmtyp))
            gv = LLVM.GlobalVariable(mod, llvmtyp, "")
            convert(MemoryBuffer, mod)
        end

        # deserialize in different context
        llvmtyp = let
            mod = parse(LLVM.Module, buf; ctx)
            gv = first(globals(mod))
            eltype(value_type(gv))
        end
    end

    return llvmtyp
end

"""
    isghosttype(t::Type; [ctx::Context])
    isghosttype(T::LLVMType)

Check if a type is a ghost type, implying it would not be emitted by the Julia compiler.
This only works for types created by the Julia compiler (living in its LLVM context).
"""
isghosttype(@nospecialize(T::LLVMType)) = T == LLVM.VoidType(context(T)) || isempty(T)
function isghosttype(@nospecialize(t::Type); ctx::Union{Nothing,Context}=nothing)
    if ctx === nothing
        @dispose ctx′=Context() begin
            T = convert(LLVMType, t; ctx=ctx′, allow_boxed=true)
            isghosttype(T)
        end
    else
        T = convert(LLVMType, t; ctx, allow_boxed=true)
        isghosttype(T)
    end
end
