## generic value

# TODO: this is a _very_ ugly wrapper, but hard to improve since we can't deduce the type
#       of a GenericValue, and need to pass concrete LLVM type objects to the API

export GenericValue, dispose,
       intwidth

@checked struct GenericValue
    ref::API.LLVMGenericValueRef
end

Base.unsafe_convert(::Type{API.LLVMGenericValueRef}, val::GenericValue) = mark_use(val).ref

GenericValue(typ::IntegerType, N::Signed) =
    mark_alloc(GenericValue(
        API.LLVMCreateGenericValueOfInt(typ,
                                        reinterpret(Culonglong, convert(Int64, N)), true)))

GenericValue(typ::IntegerType, N::Unsigned) =
    mark_alloc(GenericValue(
        API.LLVMCreateGenericValueOfInt(typ,
                                        reinterpret(Culonglong, convert(UInt64, N)), false)))

intwidth(val::GenericValue) = API.LLVMGenericValueIntWidth(val)

Base.convert(::Type{T}, val::GenericValue) where {T<:Signed} =
    convert(T, reinterpret(Clonglong, API.LLVMGenericValueToInt(val, true)))

Base.convert(::Type{T}, val::GenericValue) where {T<:Unsigned} =
    convert(T, API.LLVMGenericValueToInt(val, false))

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

dispose(val::GenericValue) = mark_dispose(API.LLVMDisposeGenericValue, val)


## execution engine

export ExecutionEngine, Interpreter, JIT,
       run

@checked struct ExecutionEngine
    ref::API.LLVMExecutionEngineRef
    mods::Set{Module}
end

Base.unsafe_convert(::Type{API.LLVMExecutionEngineRef}, engine::ExecutionEngine) =
    mark_use(engine).ref

# NOTE: these takes ownership of the module
function ExecutionEngine(mod::Module)
    out_ref = Ref{API.LLVMExecutionEngineRef}()
    out_error = Ref{Cstring}()
    status = API.LLVMCreateExecutionEngineForModule(out_ref, mod, out_error) |> Bool

    if status
        error = unsafe_message(out_error[])
        throw(LLVMException(error))
    end

    return mark_alloc(ExecutionEngine(out_ref[], Set([mod])))
end
function Interpreter(mod::Module)
    API.LLVMLinkInInterpreter()

    out_ref = Ref{API.LLVMExecutionEngineRef}()
    out_error = Ref{Cstring}()
    status = API.LLVMCreateInterpreterForModule(out_ref, mod, out_error) |> Bool

    if status
        error = unsafe_message(out_error[])
        throw(LLVMException(error))
    end

    return mark_alloc(ExecutionEngine(out_ref[], Set([mod])))
end
function JIT(mod::Module, optlevel::API.LLVMCodeGenOptLevel=API.LLVMCodeGenLevelDefault)
    API.LLVMLinkInMCJIT()

    out_ref = Ref{API.LLVMExecutionEngineRef}()
    out_error = Ref{Cstring}()
    status = API.LLVMCreateJITCompilerForModule(out_ref, mod, optlevel, out_error) |> Bool

    if status
        error = unsafe_message(out_error[])
        throw(LLVMException(error))
    end

    return mark_alloc(ExecutionEngine(out_ref[], Set([mod])))
end

function dispose(engine::ExecutionEngine)
    mark_dispose.(engine.mods)
    mark_dispose(API.LLVMDisposeExecutionEngine, engine)
end

for x in [:ExecutionEngine, :Interpreter, :JIT]
    @eval function $x(f::Core.Function, args...; kwargs...)
        engine = $x(args...; kwargs...)
        try
            f(engine)
        finally
            dispose(engine)
        end
    end
end

function Base.push!(engine::ExecutionEngine, mod::Module)
    push!(engine.mods, mod)
    API.LLVMAddModule(engine.ref, mod.ref)
end

# up to user to free the deleted module
function Base.delete!(engine::ExecutionEngine, mod::Module)
    out_ref = Ref{API.LLVMModuleRef}()
    API.LLVMRemoveModule(engine.ref, mod.ref, out_ref, Ref{Cstring}()) # out string is not used
    @assert mod == Module(out_ref[])
    delete!(engine.mods, mod)
    return
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
    status = API.LLVMFindFunction(functionset.engine.ref, name, out_ref) |> Bool
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
