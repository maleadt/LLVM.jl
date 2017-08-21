# Modules represent the top-level structure in an LLVM program.

export dispose,
       name, name!,
       triple, triple!,
       datalayout, datalayout!,
       context, inline_asm!

import Base: show

# forward definition of Module in src/core/value/constant.jl

# forward declarations
@checked immutable DataLayout
    ref::API.LLVMTargetDataRef
end
reftype(::Type{DataLayout}) = API.LLVMTargetDataRef

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

function show(io::IO, mod::Module)
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

import Base: haskey, get

immutable ModuleTypeSet
    mod::Module
end

types(mod::Module) = ModuleTypeSet(mod)

function haskey(iter::ModuleTypeSet, name::String)
    return API.LLVMGetTypeByName(ref(iter.mod), name) != C_NULL
end

function get(iter::ModuleTypeSet, name::String)
    objref = API.LLVMGetTypeByName(ref(iter.mod), name)
    objref == C_NULL && throw(KeyError(name))
    return LLVMType(objref)
end


## metadata iteration

export metadata

import Base: haskey, get, push!

immutable ModuleMetadataSet
    mod::Module
end

metadata(mod::Module) = ModuleMetadataSet(mod)

function haskey(iter::ModuleMetadataSet, name::String)
    return API.LLVMGetNamedMetadataNumOperands(ref(iter.mod), name) != 0
end

function get(iter::ModuleMetadataSet, name::String)
    nops = API.LLVMGetNamedMetadataNumOperands(ref(iter.mod), name)
    nops == 0 && throw(KeyError(name))
    ops = Vector{API.LLVMValueRef}(nops)
    API.LLVMGetNamedMetadataOperands(ref(iter.mod), name, ops)
    return Value.(ops)
end

push!(iter::ModuleMetadataSet, name::String, val::Value) =
    API.LLVMAddNamedMetadataOperand(ref(iter.mod), name, ref(val))


## global variable iteration

export globals

import Base: eltype, haskey, get, start, next, done, last, iteratorsize

immutable ModuleGlobalSet
    mod::Module
end

globals(mod::Module) = ModuleGlobalSet(mod)

eltype(::ModuleGlobalSet) = GlobalVariable

function haskey(iter::ModuleGlobalSet, name::String)
    return API.LLVMGetNamedGlobal(ref(iter.mod), name) != C_NULL
end

function get(iter::ModuleGlobalSet, name::String)
    objref = API.LLVMGetNamedGlobal(ref(iter.mod), name)
    objref == C_NULL && throw(KeyError(name))
    return GlobalVariable(objref)
end

start(iter::ModuleGlobalSet) = API.LLVMGetFirstGlobal(ref(iter.mod))

next(::ModuleGlobalSet, state) =
    (GlobalVariable(state), API.LLVMGetNextGlobal(state))

done(::ModuleGlobalSet, state) = state == C_NULL

last(iter::ModuleGlobalSet) =
    GlobalVariable(API.LLVMGetLastGlobal(ref(iter.mod)))

iteratorsize(::ModuleGlobalSet) = Base.SizeUnknown()


## function iteration

export functions

import Base: eltype, haskey, get, start, next, done, iteratorsize

immutable ModuleFunctionSet
    mod::Module
end

functions(mod::Module) = ModuleFunctionSet(mod)

eltype(::ModuleFunctionSet) = Function

function haskey(iter::ModuleFunctionSet, name::String)
    return API.LLVMGetNamedFunction(ref(iter.mod), name) != C_NULL
end

function get(iter::ModuleFunctionSet, name::String)
    objref = API.LLVMGetNamedFunction(ref(iter.mod), name)
    objref == C_NULL && throw(KeyError(name))
    return Function(objref)
end

start(iter::ModuleFunctionSet) = API.LLVMGetFirstFunction(ref(iter.mod))

next(::ModuleFunctionSet, state) =
    (Function(state), API.LLVMGetNextFunction(state))

done(::ModuleFunctionSet, state) = state == C_NULL

last(iter::ModuleFunctionSet) =
    Function(API.LLVMGetLastFunction(ref(iter.mod)))

iteratorsize(::ModuleFunctionSet) = Base.SizeUnknown()
