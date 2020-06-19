# Modules represent the top-level structure in an LLVM program.

export dispose,
       name, name!,
       triple, triple!,
       datalayout, datalayout!,
       context, inline_asm!,
       set_used!, set_compiler_used!

# forward definition of Module in src/core/value/constant.jl
reftype(::Type{Module}) = API.LLVMModuleRef

# forward declarations
@checked struct DataLayout
    ref::API.LLVMTargetDataRef
end

Module(name::String) = Module(API.LLVMModuleCreateWithName(name))
Module(name::String, ctx::Context) =
    Module(API.LLVMModuleCreateWithNameInContext(name, ref(ctx)))
Module(mod::Module) = Module(API.LLVMCloneModule(ref(mod)))

dispose(mod::Module) = API.LLVMDisposeModule(ref(mod))

function Module(f::Core.Function, args...)
    mod = Module(args...)
    try
        f(mod)
    finally
        dispose(mod)
    end
end

function Base.show(io::IO, mod::Module)
    output = unsafe_message(API.LLVMPrintModuleToString(ref(mod)))
    print(io, output)
end

function name(mod::Module)
    out_len = Ref{Csize_t}()
    ptr = convert(Ptr{UInt8}, API.LLVMGetModuleIdentifier(ref(mod), out_len))
    return unsafe_string(ptr, out_len[])
end
name!(mod::Module, str::String) =
    API.LLVMSetModuleIdentifier(ref(mod), str, Csize_t(length(str)))

triple(mod::Module) = unsafe_string(API.LLVMGetTarget(ref(mod)))
triple!(mod::Module, triple) = API.LLVMSetTarget(ref(mod), triple)

datalayout(mod::Module) = DataLayout(API.LLVMGetModuleDataLayout(ref(mod)))
datalayout!(mod::Module, layout::String) = API.LLVMSetDataLayout(ref(mod), layout)
datalayout!(mod::Module, layout::DataLayout) =
    API.LLVMSetModuleDataLayout(ref(mod), ref(layout))

inline_asm!(mod::Module, asm::String) =
    API.LLVMSetModuleInlineAsm(ref(mod), asm)

context(mod::Module) = Context(API.LLVMGetModuleContext(ref(mod)))

if VERSION >= v"1.5" && !(v"1.6-" <= VERSION < v"1.6.0-DEV.90")

set_used!(mod::Module, values::GlobalVariable...) =
    API.LLVMExtraAppendToUsed(ref(mod), collect(ref.(values)), length(values))

set_compiler_used!(mod::Module, values::GlobalVariable...) =
    API.LLVMExtraAppendToCompilerUsed(ref(mod), collect(ref.(values)), length(values))

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
    return API.LLVMGetTypeByName(ref(iter.mod), name) != C_NULL
end

function Base.getindex(iter::ModuleTypeDict, name::String)
    objref = API.LLVMGetTypeByName(ref(iter.mod), name)
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
    return API.LLVMGetNamedMetadataNumOperands(ref(iter.mod), name) != 0
end

function Base.getindex(iter::ModuleMetadataDict, name::String)
    nops = API.LLVMGetNamedMetadataNumOperands(ref(iter.mod), name)
    nops == 0 && throw(KeyError(name))
    ops = Vector{API.LLVMValueRef}(undef, nops)
    API.LLVMGetNamedMetadataOperands(ref(iter.mod), name, ops)
    return MetadataAsValue[MetadataAsValue(op) for op in ops]
end

Base.push!(iter::ModuleMetadataDict, name::String, val::MetadataAsValue) =
    API.LLVMAddNamedMetadataOperand(ref(iter.mod), name, ref(val))


## global variable iteration

export globals

struct ModuleGlobalSet
    mod::Module
end

globals(mod::Module) = ModuleGlobalSet(mod)

Base.eltype(::ModuleGlobalSet) = GlobalVariable

function Base.iterate(iter::ModuleGlobalSet, state=API.LLVMGetFirstGlobal(ref(iter.mod)))
    state == C_NULL ? nothing : (GlobalVariable(state), API.LLVMGetNextGlobal(state))
end

Base.last(iter::ModuleGlobalSet) =
    GlobalVariable(API.LLVMGetLastGlobal(ref(iter.mod)))

Base.isempty(iter::ModuleGlobalSet) =
    API.LLVMGetLastGlobal(ref(iter.mod)) == C_NULL

Base.IteratorSize(::ModuleGlobalSet) = Base.SizeUnknown()

# partial associative interface

function Base.haskey(iter::ModuleGlobalSet, name::String)
    return API.LLVMGetNamedGlobal(ref(iter.mod), name) != C_NULL
end

function Base.getindex(iter::ModuleGlobalSet, name::String)
    objref = API.LLVMGetNamedGlobal(ref(iter.mod), name)
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

function Base.iterate(iter::ModuleFunctionSet, state=API.LLVMGetFirstFunction(ref(iter.mod)))
    state == C_NULL ? nothing : (Function(state), API.LLVMGetNextFunction(state))
end

Base.last(iter::ModuleFunctionSet) =
    Function(API.LLVMGetLastFunction(ref(iter.mod)))

Base.isempty(iter::ModuleFunctionSet) =
    API.LLVMGetLastFunction(ref(iter.mod)) == C_NULL

Base.IteratorSize(::ModuleFunctionSet) = Base.SizeUnknown()

# partial associative interface

function Base.haskey(iter::ModuleFunctionSet, name::String)
    return API.LLVMGetNamedFunction(ref(iter.mod), name) != C_NULL
end

function Base.getindex(iter::ModuleFunctionSet, name::String)
    objref = API.LLVMGetNamedFunction(ref(iter.mod), name)
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
    API.LLVMGetModuleFlag(ref(iter.mod), name, length(name)) != C_NULL

function Base.getindex(iter::ModuleFlagDict, name::String)
    objref = API.LLVMGetModuleFlag(ref(iter.mod), name, length(name))
    objref == C_NULL && throw(KeyError(name))
    return Metadata(objref)
end

function Base.setindex!(iter::ModuleFlagDict, val::Metadata,
                        (name, behavior)::Tuple{String, LLVM.API.LLVMModuleFlagBehavior})
    API.LLVMAddModuleFlag(ref(iter.mod), behavior, name, length(name), ref(val))
end

end
