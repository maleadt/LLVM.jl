# Modules represent the top-level structure in an LLVM program.

export dispose, context,
       name, name!,
       triple, triple!,
       datalayout, datalayout!,
       inline_asm, inline_asm!,
       set_used!, set_compiler_used!

# forward definition of Module in src/core/value/constant.jl

Base.unsafe_convert(::Type{API.LLVMModuleRef}, mod::Module) = mark_use(mod).ref

Base.:(==)(x::Module, y::Module) = (x.ref === y.ref)

# forward declarations
@checked struct DataLayout
    ref::API.LLVMTargetDataRef
end

Module(name::String) =
    mark_alloc(Module(API.LLVMModuleCreateWithNameInContext(name, context())))

Module(mod::Module) = mark_alloc(Module(API.LLVMCloneModule(mod)))
Base.copy(mod::Module) = Module(mod)

dispose(mod::Module) = mark_dispose(API.LLVMDisposeModule, mod)

function Module(f::Core.Function, args...; kwargs...)
    mod = Module(args...; kwargs...)
    try
        f(mod)
    finally
        dispose(mod)
    end
end

function Base.show(io::IO, mod::Module)
    print(io, "LLVM.Module(\"", name(mod), "\")")
end

function Base.show(io::IO, ::MIME"text/plain", mod::Module)
    output = string(mod)
    print(io, output)
end

function name(mod::Module)
    out_len = Ref{Csize_t}()
    ptr = convert(Ptr{UInt8}, API.LLVMGetModuleIdentifier(mod, out_len))
    return unsafe_string(ptr, out_len[])
end
name!(mod::Module, str::String) =
    API.LLVMSetModuleIdentifier(mod, str, Csize_t(length(str)))

triple(mod::Module) = unsafe_string(API.LLVMGetTarget(mod))
triple!(mod::Module, triple) = API.LLVMSetTarget(mod, triple)

datalayout(mod::Module) = DataLayout(API.LLVMGetModuleDataLayout(mod))
datalayout!(mod::Module, layout::String) = API.LLVMSetDataLayout(mod, layout)
datalayout!(mod::Module, layout::DataLayout) =
    API.LLVMSetModuleDataLayout(mod, layout)

function inline_asm!(mod::Module, asm::String; overwrite::Bool=false)
    if overwrite
        API.LLVMSetModuleInlineAsm2(mod, asm, length(asm))
    else
        API.LLVMAppendModuleInlineAsm(mod, asm, length(asm))
    end
end

function inline_asm(mod::Module)
    out_len = Ref{Csize_t}()
    ptr = convert(Ptr{UInt8}, API.LLVMGetModuleInlineAsm(mod, out_len))
    return unsafe_string(ptr, out_len[])
end

context(mod::Module) = Context(API.LLVMGetModuleContext(mod))

set_used!(mod::Module, values::GlobalVariable...) =
    API.LLVMAppendToUsed(mod, collect(values), length(values))

set_compiler_used!(mod::Module, values::GlobalVariable...) =
    API.LLVMAppendToCompilerUsed(mod, collect(values), length(values))


## global variable iteration

export globals

struct ModuleGlobalSet
    mod::Module
end

globals(mod::Module) = ModuleGlobalSet(mod)

Base.eltype(::ModuleGlobalSet) = GlobalVariable

function Base.iterate(iter::ModuleGlobalSet, state=API.LLVMGetFirstGlobal(iter.mod))
    state == C_NULL ? nothing : (GlobalVariable(state), API.LLVMGetNextGlobal(state))
end

Base.last(iter::ModuleGlobalSet) =
    GlobalVariable(API.LLVMGetLastGlobal(iter.mod))

Base.isempty(iter::ModuleGlobalSet) =
    API.LLVMGetLastGlobal(iter.mod) == C_NULL

Base.IteratorSize(::ModuleGlobalSet) = Base.SizeUnknown()

# partial associative interface

function Base.haskey(iter::ModuleGlobalSet, name::String)
    return API.LLVMGetNamedGlobal(iter.mod, name) != C_NULL
end

function Base.getindex(iter::ModuleGlobalSet, name::String)
    objref = API.LLVMGetNamedGlobal(iter.mod, name)
    objref == C_NULL && throw(KeyError(name))
    return GlobalVariable(objref)
end


## function iteration

export functions

struct ModuleFunctionSet
    mod::Module
end

functions(mod::Module) = ModuleFunctionSet(mod)

Base.eltype(::ModuleFunctionSet) = Function

function Base.iterate(iter::ModuleFunctionSet, state=API.LLVMGetFirstFunction(iter.mod))
    state == C_NULL ? nothing : (Function(state), API.LLVMGetNextFunction(state))
end

Base.last(iter::ModuleFunctionSet) =
    Function(API.LLVMGetLastFunction(iter.mod))

Base.isempty(iter::ModuleFunctionSet) =
    API.LLVMGetLastFunction(iter.mod) == C_NULL

Base.IteratorSize(::ModuleFunctionSet) = Base.SizeUnknown()

# partial associative interface

function Base.haskey(iter::ModuleFunctionSet, name::String)
    return API.LLVMGetNamedFunction(iter.mod, name) != C_NULL
end

function Base.getindex(iter::ModuleFunctionSet, name::String)
    objref = API.LLVMGetNamedFunction(iter.mod, name)
    objref == C_NULL && throw(KeyError(name))
    return Function(objref)
end


## module flag iteration
# TODO: doesn't actually iterate, since we can't list the available keys

export flags

struct ModuleFlagDict <: AbstractDict{String,Metadata}
    mod::Module
end

flags(mod::Module) = ModuleFlagDict(mod)

Base.haskey(iter::ModuleFlagDict, name::String) =
    API.LLVMGetModuleFlag(iter.mod, name, length(name)) != C_NULL

function Base.getindex(iter::ModuleFlagDict, name::String)
    objref = API.LLVMGetModuleFlag(iter.mod, name, length(name))
    objref == C_NULL && throw(KeyError(name))
    return Metadata(objref)
end

function Base.setindex!(iter::ModuleFlagDict, val::Metadata,
                        (name, behavior)::Tuple{String, API.LLVMModuleFlagBehavior})
    API.LLVMAddModuleFlag(iter.mod, behavior, name, length(name), val)
end


## sdk version

export sdk_version, sdk_version!

function sdk_version!(mod::Module, version::VersionNumber)
    entries = Int32[version.major]
    if version.minor != 0 || version.patch != 0
        push!(entries, version.minor)
        if version.patch != 0
            push!(entries, version.patch)
        end
        # cannot represent prerelease or build metadata
    end
    md = context!(context(mod)) do
        Metadata(ConstantDataArray(entries))
    end

    flags(mod)["SDK Version", LLVM.API.LLVMModuleFlagBehaviorWarning] = md
end

function sdk_version(mod::Module)
    haskey(flags(mod), "SDK Version") || return nothing
    md = flags(mod)["SDK Version"]
    c = context!(context(mod)) do
        Value(md)
    end
    entries = collect(c)
    VersionNumber(map(val->convert(Int, val), entries)...)
end
