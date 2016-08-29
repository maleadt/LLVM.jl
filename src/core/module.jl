# Modules represent the top-level structure in an LLVM program.

export LLVMModule, dispose,
       target, target!, datalayout, datalayout!, context, inline_asm!

import Base: show

LLVMModule(name::String) = LLVMModule(API.LLVMModuleCreateWithName(name))
LLVMModule(name::String, ctx::Context) =
    LLVMModule(API.LLVMModuleCreateWithNameInContext(name, ref(ctx)))
LLVMModule(mod::LLVMModule) = LLVMModule(API.LLVMCloneModule(ref(mod)))

dispose(mod::LLVMModule) = API.LLVMDisposeModule(ref(mod))

function LLVMModule(f::Function, args...)
    mod = LLVMModule(args...)
    try
        f(mod)
    finally
        dispose(mod)
    end
end

function show(io::IO, mod::LLVMModule)
    output = unsafe_string(API.LLVMPrintModuleToString(ref(mod)))
    print(io, output)
end

target(mod::LLVMModule) = unsafe_string(API.LLVMGetTarget(ref(mod)))
target!(mod::LLVMModule, triple) = API.LLVMSetTarget(ref(mod), triple)

datalayout(mod::LLVMModule) = unsafe_string(API.LLVMGetDataLayout(ref(mod)))
datalayout!(mod::LLVMModule, layout) = API.LLVMSetDataLayout(ref(mod), layout)

inline_asm!(mod::LLVMModule, asm::String) =
    API.LLVMSetModuleInlineAsm(ref(mod), asm)

context(mod::LLVMModule) = Context(API.LLVMGetModuleContext(ref(mod)))


## type iteration

export types

import Base: haskey, get

immutable ModuleTypeSet
    mod::LLVMModule
end

types(mod::LLVMModule) = ModuleTypeSet(mod)

function haskey(iter::ModuleTypeSet, name::String)
    return API.LLVMGetTypeByName(ref(iter.mod), name) != C_NULL
end

function get(iter::ModuleTypeSet, name::String)
    objref = API.LLVMGetTypeByName(ref(iter.mod), name)
    objref == C_NULL && throw(KeyError(name))
    return dynamic_construct(LLVMType, objref)
end


## metadata iteration

export metadata

import Base: haskey, get, push!

immutable ModuleMetadataSet
    mod::LLVMModule
end

metadata(mod::LLVMModule) = ModuleMetadataSet(mod)

function haskey(iter::ModuleMetadataSet, name::String)
    return API.LLVMGetNamedMetadataNumOperands(ref(iter.mod), name) != 0
end

function get(iter::ModuleMetadataSet, name::String)
    nops = API.LLVMGetNamedMetadataNumOperands(ref(iter.mod), name)
    nops == 0 && throw(KeyError(name))
    ops = Vector{API.LLVMValueRef}(nops)
    API.LLVMGetNamedMetadataOperands(ref(iter.mod), name, ops)
    return map(t->dynamic_construct(Value, t), ops)
end

push!(iter::ModuleMetadataSet, name::String, val::Value) =
    API.LLVMAddNamedMetadataOperand(ref(iter.mod), name, ref(val))


## global variable iteration

export globals

import Base: eltype, haskey, get, start, next, done, last

immutable ModuleGlobalSet
    mod::LLVMModule
end

globals(mod::LLVMModule) = ModuleGlobalSet(mod)

eltype(::ModuleGlobalSet) = GlobalVariable

function haskey(iter::ModuleGlobalSet, name::String)
    return API.LLVMGetNamedGlobal(ref(iter.mod), name) != C_NULL
end

function get(iter::ModuleGlobalSet, name::String)
    objref = API.LLVMGetNamedGlobal(ref(iter.mod), name)
    objref == C_NULL && throw(KeyError(name))
    return construct(GlobalVariable, objref)
end

start(iter::ModuleGlobalSet) = API.LLVMGetFirstGlobal(ref(iter.mod))

next(::ModuleGlobalSet, state) =
    (construct(GlobalVariable,state), API.LLVMGetNextGlobal(state))

done(::ModuleGlobalSet, state) = state == C_NULL

last(iter::ModuleGlobalSet) =
    construct(GlobalVariable, API.LLVMGetLastGlobal(ref(iter.mod)))

# NOTE: this is expensive, but the iteration interface requires it to be implemented
function length(iter::ModuleGlobalSet)
    count = 0
    for inst in iter
        count += 1
    end
    return count
end


## function iteration

export functions

import Base: eltype, haskey, get, start, next, done, last, length

immutable ModuleFunctionSet
    mod::LLVMModule
end

functions(mod::LLVMModule) = ModuleFunctionSet(mod)

eltype(iter::ModuleFunctionSet) = LLVMFunction

function haskey(iter::ModuleFunctionSet, name::String)
    return API.LLVMGetNamedFunction(ref(iter.mod), name) != C_NULL
end

function get(iter::ModuleFunctionSet, name::String)
    objref = API.LLVMGetNamedFunction(ref(iter.mod), name)
    objref == C_NULL && throw(KeyError(name))
    return construct(LLVMFunction, objref)
end

start(iter::ModuleFunctionSet) = API.LLVMGetFirstFunction(ref(iter.mod))

next(iter::ModuleFunctionSet, state) =
    (construct(LLVMFunction,state), API.LLVMGetNextFunction(state))

done(iter::ModuleFunctionSet, state) = state == C_NULL

last(iter::ModuleFunctionSet) =
    construct(LLVMFunction, API.LLVMGetLastFunction(ref(iter.mod)))

# NOTE: this is expensive, but the iteration interface requires it to be implemented
function length(iter::ModuleFunctionSet)
    count = 0
    for inst in iter
        count += 1
    end
    return count
end
