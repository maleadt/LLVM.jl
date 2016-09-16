## generic value

export GenericValue, dispose

import Base: convert

@reftypedef ref=LLVMGenericValueRef immutable GenericValue end

GenericValue(typ::IntegerType, N::Int) =
    GenericValue(API.LLVMCreateGenericValueOfInt(ref(typ),
                                                 reinterpret(Culonglong, N), LLVMTrue))

GenericValue(typ::IntegerType, N::UInt) =
    GenericValue(API.LLVMCreateGenericValueOfInt(ref(typ),
                                                 reinterpret(Culonglong, N), LLVMFalse))

convert(::Type{Int}, val::GenericValue) =
    reinterpret(Clonglong, API.LLVMGenericValueToInt(ref(val), LLVMTrue))

convert(::Type{UInt}, val::GenericValue) =
    API.LLVMGenericValueToInt(ref(val), LLVMFalse)

GenericValue(typ::FloatingPointType, N::Float64) =
    GenericValue(API.LLVMCreateGenericValueOfFloat(ref(typ), Cdouble(N)))

# NOTE: this ugly-three arg convert is needed to match the C API,
#       which uses the type to call the correct C++ function.

convert(::Type{Float64}, val::GenericValue, typ::LLVMType) =
    API.LLVMGenericValueToFloat(ref(typ), ref(val))

GenericValue{T}(ptr::Ptr{T}) =
    GenericValue(API.LLVMCreateGenericValueOfPointer(convert(Ptr{Void}, ptr)))

convert{T}(::Type{Ptr{T}}, val::GenericValue) =
    convert(Ptr{T}, API.LLVMGenericValueToPointer(ref(val)))

dispose(val::GenericValue) =
    API.LLVMDisposeGenericValue(ref(val))


## execution engine

export ExecutionEngine, Interpreter, JIT,
       run

@reftypedef ref=LLVMExecutionEngineRef immutable ExecutionEngine end

# NOTE: these takes ownership of the module
function ExecutionEngine(mod::Module)
    out_ref = Ref{API.LLVMExecutionEngineRef}()
    out_error = Ref{Cstring}()
    status = BoolFromLLVM(API.LLVMCreateExecutionEngineForModule(out_ref, ref(mod),
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
    status = BoolFromLLVM(API.LLVMCreateInterpreterForModule(out_ref, ref(mod),
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
    status = BoolFromLLVM(API.LLVMCreateJITCompilerForModule(out_ref, ref(mod),
                                                             Cuint(optlevel), out_error))

    if status
        error = unsafe_string(out_error[])
        API.LLVMDisposeMessage(out_error[])
        throw(LLVMException(error))
    end

    return ExecutionEngine(out_ref[])
end

dispose(engine::ExecutionEngine) = API.LLVMDisposeExecutionEngine(ref(engine))

for kind in [:ExecutionEngine, :Interpreter, :JIT]
    @eval function $kind(f::Core.Function, args...)
        engine = $kind(args...)
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
