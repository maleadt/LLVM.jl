## generic value

# TODO: this is a _very_ ugly wrapper, but hard to improve since we can't deduce the type
#       of a GenericValue, and need to pass concrete LLVM type objects to the API

export GenericValue, dispose,
       intwidth

@checked struct GenericValue
    ref::API.LLVMGenericValueRef
end

Base.unsafe_convert(::Type{API.LLVMGenericValueRef}, val::GenericValue) = val.ref

GenericValue(typ::IntegerType, N::Signed) =
    GenericValue(
        API.LLVMCreateGenericValueOfInt(typ,
                                        reinterpret(Culonglong, convert(Int64, N)), True))

GenericValue(typ::IntegerType, N::Unsigned) =
    GenericValue(
        API.LLVMCreateGenericValueOfInt(typ,
                                        reinterpret(Culonglong, convert(UInt64, N)), False))

intwidth(val::GenericValue) = API.LLVMGenericValueIntWidth(val)

Base.convert(::Type{T}, val::GenericValue) where {T<:Signed} =
    convert(T, reinterpret(Clonglong, API.LLVMGenericValueToInt(val, True)))

Base.convert(::Type{T}, val::GenericValue) where {T<:Unsigned} =
    convert(T, API.LLVMGenericValueToInt(val, False))

GenericValue(typ::FloatingPointType, N::AbstractFloat) =
    GenericValue(API.LLVMCreateGenericValueOfFloat(typ, convert(Cdouble, N)))

# NOTE: this ugly three-arg convert is needed to match the C API,
#       which uses the type to call the correct C++ function.

Base.convert(::Type{T}, val::GenericValue, typ::LLVMType) where {T<:AbstractFloat} =
    convert(T, API.LLVMGenericValueToFloat(typ, val))

GenericValue(ptr::Ptr) =
    GenericValue(API.LLVMCreateGenericValueOfPointer(convert(Ptr{Cvoid}, ptr)))

Base.convert(::Type{Ptr{T}}, val::GenericValue) where {T} =
    convert(Ptr{T}, API.LLVMGenericValueToPointer(val))

dispose(val::GenericValue) = API.LLVMDisposeGenericValue(val)


## execution engine

export ExecutionEngine, Interpreter, JIT,
       run

@checked struct ExecutionEngine
    ref::API.LLVMExecutionEngineRef
end

Base.unsafe_convert(::Type{API.LLVMExecutionEngineRef}, engine::ExecutionEngine) = engine.ref

# NOTE: these takes ownership of the module
function ExecutionEngine(mod::Module)
    out_ref = Ref{API.LLVMExecutionEngineRef}()
    out_error = Ref{Cstring}()
    status = convert(Core.Bool, API.LLVMCreateExecutionEngineForModule(out_ref, mod,
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
    status = convert(Core.Bool, API.LLVMCreateInterpreterForModule(out_ref, mod,
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
    status = convert(Core.Bool, API.LLVMCreateJITCompilerForModule(out_ref, mod,
                                                                   optlevel, out_error))

    if status
        error = unsafe_string(out_error[])
        API.LLVMDisposeMessage(out_error[])
        throw(LLVMException(error))
    end

    return ExecutionEngine(out_ref[])
end

dispose(engine::ExecutionEngine) = API.LLVMDisposeExecutionEngine(engine)

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

Base.push!(engine::ExecutionEngine, mod::Module) = API.LLVMAddModule(engine.ref, mod.ref)

# up to user to free the deleted module
function Base.delete!(engine::ExecutionEngine, mod::Module)
    out_ref = Ref{API.LLVMModuleRef}()
    API.LLVMRemoveModule(engine.ref, mod.ref, out_ref, Ref{Cstring}()) # out string is not used
    return Module(out_ref[])
end

Base.run(engine::ExecutionEngine, f::Function, args::Vector{GenericValue}=GenericValue[]) =
    GenericValue(API.LLVMRunFunction(engine, f,
                                     length(args), args))


# ExectutionEngine function lookup

export functions

struct ExecutionEngineFunctionSet
    engine::ExecutionEngine
end

functions(engine::ExecutionEngine) = ExecutionEngineFunctionSet(engine)

Base.IteratorSize(::ExecutionEngineFunctionSet) = Base.SizeUnknown()
Base.iterate(::ExecutionEngineFunctionSet) =
    error("Iteration of functions in the execution engine is not supported")

function Base.get(functionset::ExecutionEngineFunctionSet, name::String, default)
    out_ref = Ref{API.LLVMValueRef}()
    API.LLVMFindFunction(functionset.engine.ref, name, out_ref)
    status = convert(Core.Bool, API.LLVMFindFunction(functionset.engine.ref, name, out_ref))
    return status == 0 ? Function(out_ref[]) : default
end

function Base.haskey(functionset::ExecutionEngineFunctionSet, name::String)
    f = get(functionset, name, nothing)
    return f != nothing
end

function Base.getindex(functionset::ExecutionEngineFunctionSet, name::String)
    f = get(functionset, name, nothing)
    return f == nothing ? throw(KeyError(name)) : f
end
