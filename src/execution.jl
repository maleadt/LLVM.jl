## generic value

export GenericValue, dispose

import Base: convert

@reftypedef ref=LLVMGenericValueRef immutable GenericValue end

GenericValue(typ::LLVMInteger, N::Int) =
    GenericValue(API.LLVMCreateGenericValueOfInt(ref(typ),
                                                 reinterpret(Culonglong, N), LLVMTrue))

GenericValue(typ::LLVMInteger, N::UInt) =
    GenericValue(API.LLVMCreateGenericValueOfInt(ref(typ),
                                                 reinterpret(Culonglong, N), LLVMFalse))

convert(::Type{Int}, val::GenericValue) =
    reinterpret(Clonglong, API.LLVMGenericValueToInt(ref(val), LLVMTrue))

convert(::Type{UInt}, val::GenericValue) =
    API.LLVMGenericValueToInt(ref(val), LLVMFalse)

GenericValue(typ::LLVMFloatingPoint, N::Float64) =
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

export link_jit, link_interpreter,
       ExecutionEngine,
       run

link_jit() = API.LLVMLinkInMCJIT()
link_interpreter() = API.LLVMLinkInInterpreter()

@reftypedef ref=LLVMExecutionEngineRef immutable ExecutionEngine end

function ExecutionEngine(mod::Module)
    outref = Ref{API.LLVMExecutionEngineRef}()
    outerror = Ref{Cstring}()
    status = BoolFromLLVM(API.LLVMCreateInterpreterForModule(outref, ref(mod), outerror))

    if status
        error = unsafe_string(outerror[])
        API.LLVMDisposeMessage(outerror[])
        throw(error)
    else
        API.LLVMDisposeMessage(outerror[])
        return ExecutionEngine(outref[])
    end
end

run(engine::ExecutionEngine, fn::Function, args::Vector{GenericValue}) =
    GenericValue(API.LLVMRunFunction(ref(engine), ref(fn),
                                     Cuint(length(args)), ref.(args)))
