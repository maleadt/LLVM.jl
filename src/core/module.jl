# Modules represent the top-level structure in an LLVM program.

export dispose,
       name, name!,
       triple, triple!,
       datalayout, datalayout!,
       context, inline_asm!

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
    output = unsafe_string(API.LLVMPrintModuleToString(ref(mod)))
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


## type iteration

export types

struct ModuleTypeDict <: Associative{String,LLVMType}
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

struct ModuleMetadataDict <: Associative{String,Vector{MetadataAsValue}}
    mod::Module
end

metadata(mod::Module) = ModuleMetadataDict(mod)

function Base.haskey(iter::ModuleMetadataDict, name::String)
    return API.LLVMGetNamedMetadataNumOperands(ref(iter.mod), name) != 0
end

function Base.getindex(iter::ModuleMetadataDict, name::String)
    nops = API.LLVMGetNamedMetadataNumOperands(ref(iter.mod), name)
    nops == 0 && throw(KeyError(name))
    ops = Vector{API.LLVMValueRef}(uninitialized, nops)
    API.LLVMGetNamedMetadataOperands(ref(iter.mod), name, ops)
    return MetadataAsValue.(ops)
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

Base.start(iter::ModuleGlobalSet) = API.LLVMGetFirstGlobal(ref(iter.mod))

Base.next(::ModuleGlobalSet, state) =
    (GlobalVariable(state), API.LLVMGetNextGlobal(state))

Base.done(::ModuleGlobalSet, state) = state == C_NULL

Base.last(iter::ModuleGlobalSet) =
    GlobalVariable(API.LLVMGetLastGlobal(ref(iter.mod)))

Base.iteratorsize(::ModuleGlobalSet) = Base.SizeUnknown()

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

Base.start(iter::ModuleFunctionSet) = API.LLVMGetFirstFunction(ref(iter.mod))

Base.next(::ModuleFunctionSet, state) =
    (Function(state), API.LLVMGetNextFunction(state))

Base.done(::ModuleFunctionSet, state) = state == C_NULL

Base.last(iter::ModuleFunctionSet) =
    Function(API.LLVMGetLastFunction(ref(iter.mod)))

Base.iteratorsize(::ModuleFunctionSet) = Base.SizeUnknown()

# partial associative interface

function Base.haskey(iter::ModuleFunctionSet, name::String)
    return API.LLVMGetNamedFunction(ref(iter.mod), name) != C_NULL
end

function Base.getindex(iter::ModuleFunctionSet, name::String)
    objref = API.LLVMGetNamedFunction(ref(iter.mod), name)
    objref == C_NULL && throw(KeyError(name))
    return Function(objref)
end
