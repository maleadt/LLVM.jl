# Modules represent the top-level structure in an LLVM program.

export dispose,
       name, name!,
       triple, triple!,
       datalayout, datalayout!,
       context, inline_asm!,
       set_used!, set_compiler_used!

# forward definition of Module in src/core/value/constant.jl

function Base.unsafe_convert(::Type{API.LLVMModuleRef}, mod::Module)
    # modules can get destroyed, so be sure to check for validity
    mod.ref == C_NULL && throw(UndefRefError())
    mod.ref
end

Base.:(==)(x::Module, y::Module) = (x.ref === y.ref)

# forward declarations
@checked struct DataLayout
    ref::API.LLVMTargetDataRef
end

Module(name::String) = Module(API.LLVMModuleCreateWithName(name))
Module(name::String, ctx::Context) =
    Module(API.LLVMModuleCreateWithNameInContext(name, ctx))
Module(mod::Module) = Module(API.LLVMCloneModule(mod))

dispose(mod::Module) = API.LLVMDisposeModule(mod)

function Module(f::Core.Function, args...)
    mod = Module(args...)
    try
        f(mod)
    finally
        dispose(mod)
    end
end

function Base.show(io::IO, mod::Module)
    output = unsafe_message(API.LLVMPrintModuleToString(mod))
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

inline_asm!(mod::Module, asm::String) =
    API.LLVMSetModuleInlineAsm(mod, asm)

context(mod::Module) = Context(API.LLVMGetModuleContext(mod))

if VERSION >= v"1.5" && !(v"1.6-" <= VERSION < v"1.6.0-DEV.90")

set_used!(mod::Module, values::GlobalVariable...) =
    API.LLVMExtraAppendToUsed(mod, collect(values), length(values))

set_compiler_used!(mod::Module, values::GlobalVariable...) =
    API.LLVMExtraAppendToCompilerUsed(mod, collect(values), length(values))

else
set_used!(mod::Module, values::GlobalVariable...) = nothing
set_compiler_used!(mod::Module, values::GlobalVariable...) = nothing
end

## type iteration

export types

struct ModuleTypeDict <: AbstractDict{String,LLVMType}
    mod::Module
end

types(mod::Module) = ModuleTypeDict(mod)

function Base.haskey(iter::ModuleTypeDict, name::String)
    return API.LLVMGetTypeByName(iter.mod, name) != C_NULL
end

function Base.getindex(iter::ModuleTypeDict, name::String)
    objref = API.LLVMGetTypeByName(iter.mod, name)
    objref == C_NULL && throw(KeyError(name))
    return LLVMType(objref)
end


## metadata iteration

export metadata

struct ModuleMetadataDict <: AbstractDict{String,Vector{MetadataAsValue}}
    mod::Module
end

metadata(mod::Module) = ModuleMetadataDict(mod)

function Base.haskey(iter::ModuleMetadataDict, name::String)
    return API.LLVMGetNamedMetadataNumOperands(iter.mod, name) != 0
end

function Base.getindex(iter::ModuleMetadataDict, name::String)
    nops = API.LLVMGetNamedMetadataNumOperands(iter.mod, name)
    nops == 0 && throw(KeyError(name))
    ops = Vector{API.LLVMValueRef}(undef, nops)
    API.LLVMGetNamedMetadataOperands(iter.mod, name, ops)
    return MetadataAsValue[MetadataAsValue(op) for op in ops]
end

Base.push!(iter::ModuleMetadataDict, name::String, val::MetadataAsValue) =
    API.LLVMAddNamedMetadataOperand(iter.mod, name, val)


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

if version() >= v"8.0"

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

end
