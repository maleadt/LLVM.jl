## generic value

# TODO: this is a _very_ ugly wrapper, but hard to improve since we can't deduce the type
#       of a GenericValue, and need to pass concrete LLVM type objects to the API

export GenericValue, dispose,
       intwidth

import Base: convert

@reftypedef ref=LLVMGenericValueRef immutable GenericValue end

GenericValue(typ::IntegerType, N::Signed) =
    GenericValue(
        API.LLVMCreateGenericValueOfInt(ref(typ),
                                        reinterpret(Culonglong, convert(Int64, N)), True))

GenericValue(typ::IntegerType, N::Unsigned) =
    GenericValue(
        API.LLVMCreateGenericValueOfInt(ref(typ),
                                        reinterpret(Culonglong, convert(UInt64, N)), False))

intwidth(val::GenericValue) = API.LLVMGenericValueIntWidth(ref(val))

convert{T<:Signed}(::Type{T}, val::GenericValue) =
    convert(T, reinterpret(Clonglong, API.LLVMGenericValueToInt(ref(val), True)))

convert{T<:Unsigned}(::Type{T}, val::GenericValue) =
    convert(T, API.LLVMGenericValueToInt(ref(val), False))

GenericValue(typ::FloatingPointType, N::AbstractFloat) =
    GenericValue(API.LLVMCreateGenericValueOfFloat(ref(typ), convert(Cdouble, N)))

# NOTE: this ugly-three arg convert is needed to match the C API,
#       which uses the type to call the correct C++ function.

convert{T<:AbstractFloat}(::Type{T}, val::GenericValue, typ::LLVMType) =
    convert(T, API.LLVMGenericValueToFloat(ref(typ), ref(val)))

GenericValue(ptr::Ptr) =
    GenericValue(API.LLVMCreateGenericValueOfPointer(convert(Ptr{Void}, ptr)))

convert{T}(::Type{Ptr{T}}, val::GenericValue) =
    convert(Ptr{T}, API.LLVMGenericValueToPointer(ref(val)))

dispose(val::GenericValue) = API.LLVMDisposeGenericValue(ref(val))


## execution engine

export ExecutionEngine, Interpreter, JIT,
       run

@reftypedef ref=LLVMExecutionEngineRef immutable ExecutionEngine end

# NOTE: these takes ownership of the module
function ExecutionEngine(mod::Module)
    out_ref = Ref{API.LLVMExecutionEngineRef}()
    out_error = Ref{Cstring}()
    status = convert(Core.Bool, API.LLVMCreateExecutionEngineForModule(out_ref, ref(mod),
                                                                 out_error))

    if status
        error = unsafe_string(out_error[])
        API.LLVMDisposeMessage(out_error[])
        throw(LLVMException(error))
    end

    return ExecutionEngine(out_ref[])
end
function Interpreter(mod::Module)
    API.LLVMLinkInInterpreter()

    out_ref = Ref{API.LLVMExecutionEngineRef}()
    out_error = Ref{Cstring}()
    status = convert(Core.Bool, API.LLVMCreateInterpreterForModule(out_ref, ref(mod),
                                                             out_error))

    if status
        error = unsafe_string(out_error[])
        API.LLVMDisposeMessage(out_error[])
        throw(LLVMException(error))
    end

    return ExecutionEngine(out_ref[])
end
function JIT(mod::Module, optlevel::API.LLVMCodeGenOptLevel=API.LLVMCodeGenLevelDefault)
    API.LLVMLinkInMCJIT()

    out_ref = Ref{API.LLVMExecutionEngineRef}()
    out_error = Ref{Cstring}()
    status = convert(Core.Bool, API.LLVMCreateJITCompilerForModule(out_ref, ref(mod),
                                                             Cuint(optlevel), out_error))

    if status
        error = unsafe_string(out_error[])
        API.LLVMDisposeMessage(out_error[])
        throw(LLVMException(error))
    end

    return ExecutionEngine(out_ref[])
end

dispose(engine::ExecutionEngine) = API.LLVMDisposeExecutionEngine(ref(engine))

for x in [:ExecutionEngine, :Interpreter, :JIT]
    @eval function $x(f::Core.Function, args...)
        engine = $x(args...)
        try
            f(engine)
        finally
            dispose(engine)
        end
    end
end

run(engine::ExecutionEngine, f::Function, args::Vector{GenericValue}=GenericValue[]) =
    GenericValue(API.LLVMRunFunction(ref(engine), ref(f),
                                     Cuint(length(args)), ref.(args)))
