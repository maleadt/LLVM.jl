# Modules represent the top-level structure in an LLVM program.

export LLVMModule, dispose,
       target, target!, datalayout, datalayout!, context, inline_asm!

import Base: show

# @reftypedef immutable LLVMModule end

LLVMModule(name::String) = LLVMModule(API.LLVMModuleCreateWithName(name))
LLVMModule(name::String, ctx::Context) = LLVMModule(API.LLVMModuleCreateWithNameInContext(name, ref(Context, ctx)))
LLVMModule(mod::LLVMModule) = LLVMModule(API.LLVMCloneModule(ref(LLVMModule, mod)))

dispose(mod::LLVMModule) = API.LLVMDisposeModule(ref(LLVMModule, mod))

function show(io::IO, mod::LLVMModule)
    output = unsafe_string(API.LLVMPrintModuleToString(ref(LLVMModule, mod)))
    print(io, output)
end

target(mod::LLVMModule) = unsafe_string(API.LLVMGetTarget(ref(LLVMModule, mod)))
target!(mod::LLVMModule, triple) = API.LLVMSetTarget(ref(LLVMModule, mod), triple)

datalayout(mod::LLVMModule) = unsafe_string(API.LLVMGetDataLayout(ref(LLVMModule, mod)))
datalayout!(mod::LLVMModule, layout) = API.LLVMSetDataLayout(ref(LLVMModule, mod), layout)

inline_asm!(mod::LLVMModule, asm::String) = API.LLVMSetModuleInlineAsm(ref(LLVMModule, mod), asm)

context(mod::LLVMModule) = Context(API.LLVMGetModuleContext(ref(LLVMModule, mod)))


## type iteration

export types

import Base: haskey, get

immutable ModuleTypeIterator
    mod::LLVMModule
end

types(mod::LLVMModule) = ModuleTypeIterator(mod)

function haskey(it::ModuleTypeIterator, name::String)
    return API.LLVMGetTypeByName(ref(LLVMModule, it.mod), name) != C_NULL
end

function get(it::ModuleTypeIterator, name::String)
    objref = API.LLVMGetTypeByName(ref(LLVMModule, it.mod), name)
    objref == C_NULL && throw(KeyError(name))
    return dynamic_convert(LLVMType, objref)
end


## metadata iteration

export metadata, add!

import Base: haskey, get

immutable ModuleMetadataIterator
    mod::LLVMModule
end

metadata(mod::LLVMModule) = ModuleMetadataIterator(mod)

function haskey(it::ModuleMetadataIterator, name::String)
    return API.LLVMGetNamedMetadataNumOperands(ref(LLVMModule, it.mod), name) != 0
end

function get(it::ModuleMetadataIterator, name::String)
    nops = API.LLVMGetNamedMetadataNumOperands(ref(LLVMModule, it.mod), name)
    nops == 0 && throw(KeyError(name))
    ops = Vector{API.LLVMValueRef}(nops)
    API.LLVMGetNamedMetadataOperands(ref(LLVMModule, it.mod), name, ops)
    return map(t->dynamic_convert(Value, t), ops)
end

add!(it::ModuleMetadataIterator, name::String, val::Value) =
    API.LLVMAddNamedMetadataOperand(ref(LLVMModule, it.mod), name, ref(Value, val))


## function iteration

export functions, add!

import Base: haskey, get,
             start, next, done, eltype, last

immutable ModuleFunctionIterator
    mod::LLVMModule
end

functions(mod::LLVMModule) = ModuleFunctionIterator(mod)

function haskey(it::ModuleFunctionIterator, name::String)
    return API.LLVMGetNamedFunction(ref(LLVMModule, it.mod), name) != C_NULL
end

function get(it::ModuleFunctionIterator, name::String)
    objref = API.LLVMGetNamedFunction(ref(LLVMModule, it.mod), name)
    objref == C_NULL && throw(KeyError(name))
    return construct(LLVMFunction, objref)
end

add!(it::ModuleFunctionIterator, name::String, ft::FunctionType) =
    construct(LLVMFunction,
              API.LLVMAddFunction(ref(LLVMModule, it.mod), name,
                                  ref(LLVMType, ft)))

start(it::ModuleFunctionIterator) = API.LLVMGetFirstFunction(ref(LLVMModule, it.mod))

next(it::ModuleFunctionIterator, state) =
    (construct(LLVMFunction,state), API.LLVMGetNextFunction(state))

done(it::ModuleFunctionIterator, state) = state == C_NULL

eltype(it::ModuleFunctionIterator) = LLVMFunction

# NOTE: lacking `endof`, we override `last`
last(it::ModuleFunctionIterator) =
    construct(LLVMFunction, API.LLVMGetLastFunction(ref(LLVMModule, it.mod)))
