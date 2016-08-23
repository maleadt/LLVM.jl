# Modules represent the top-level structure in an LLVM program.

export LLVMModule, dispose,
       target, target!, datalayout, datalayout!, context, inline_asm!

import Base: show

@llvmtype immutable LLVMModule end

LLVMModule(name::String) = LLVMModule(API.LLVMModuleCreateWithName(name))
LLVMModule(name::String, ctx::Context) = LLVMModule(API.LLVMModuleCreateWithNameInContext(name, convert(API.LLVMContextRef, ctx)))
LLVMModule(mod::LLVMModule) = LLVMModule(API.LLVMCloneModule(convert(API.LLVMModuleRef, mod)))

dispose(mod::LLVMModule) = API.LLVMDisposeModule(convert(API.LLVMModuleRef, mod))

function show(io::IO, mod::LLVMModule)
    output = unsafe_string(API.LLVMPrintModuleToString(convert(API.LLVMModuleRef, mod)))
    print(io, output)
end

target(mod::LLVMModule) = unsafe_string(API.LLVMGetTarget(convert(API.LLVMModuleRef, mod)))
target!(mod::LLVMModule, triple) = API.LLVMSetTarget(convert(API.LLVMModuleRef, mod), triple)

datalayout(mod::LLVMModule) = unsafe_string(API.LLVMGetDataLayout(convert(API.LLVMModuleRef, mod)))
datalayout!(mod::LLVMModule, layout) = API.LLVMSetDataLayout(convert(API.LLVMModuleRef, mod), layout)

inline_asm!(mod::LLVMModule, asm::String) = API.LLVMSetModuleInlineAsm(convert(API.LLVMModuleRef, mod), asm)

context(mod::LLVMModule) = Context(API.LLVMGetModuleContext(convert(API.LLVMModuleRef, mod)))


## type iteration

export types

import Base: haskey, get

immutable ModuleTypeIterator
    mod::LLVMModule
end

types(mod::LLVMModule) = ModuleTypeIterator(mod)

function haskey(it::ModuleTypeIterator, name::String)
    return API.LLVMGetTypeByName(convert(API.LLVMModuleRef, it.mod), name) != C_NULL
end

function get(it::ModuleTypeIterator, name::String)
    ref = API.LLVMGetTypeByName(convert(API.LLVMModuleRef, it.mod), name)
    ref == C_NULL && throw(KeyError(name))
    return dynamic_convert(LLVMType, ref)
end


## metadata iteration

export metadata, add!

import Base: haskey, get

immutable ModuleMetadataIterator
    mod::LLVMModule
end

metadata(mod::LLVMModule) = ModuleMetadataIterator(mod)

function haskey(it::ModuleMetadataIterator, name::String)
    return API.LLVMGetNamedMetadataNumOperands(convert(API.LLVMModuleRef, it.mod), name) != 0
end

function get(it::ModuleMetadataIterator, name::String)
    nops = API.LLVMGetNamedMetadataNumOperands(convert(API.LLVMModuleRef, it.mod), name)
    nops == 0 && throw(KeyError(name))
    ops = Vector{API.LLVMValueRef}(nops)
    API.LLVMGetNamedMetadataOperands(convert(API.LLVMModuleRef, it.mod), name, ops)
    return map(t->dynamic_convert(Value, t), ops)
end

add!(it::ModuleMetadataIterator, name::String, val::Value) =
    API.LLVMAddNamedMetadataOperand(convert(API.LLVMModuleRef, it.mod), name, convert(API.LLVMValueRef, val))


## function iteration

export functions, add!

import Base: haskey, get,
             start, next, done, eltype, last

immutable ModuleFunctionIterator
    mod::LLVMModule
end

functions(mod::LLVMModule) = ModuleFunctionIterator(mod)

function haskey(it::ModuleFunctionIterator, name::String)
    return API.LLVMGetNamedFunction(convert(API.LLVMModuleRef, it.mod), name) != C_NULL
end

function get(it::ModuleFunctionIterator, name::String)
    ref = API.LLVMGetNamedFunction(convert(API.LLVMModuleRef, it.mod), name)
    ref == C_NULL && throw(KeyError(name))
    return LLVMFunction(ref)
end

add!(it::ModuleFunctionIterator, name::String, ft::FunctionType) =
    LLVMFunction(API.LLVMAddFunction(convert(API.LLVMModuleRef, it.mod), name, convert(API.LLVMTypeRef, ft)))

start(it::ModuleFunctionIterator) = API.LLVMGetFirstFunction(convert(API.LLVMModuleRef, it.mod))

next(it::ModuleFunctionIterator, state) =
    (LLVMFunction(state), API.LLVMGetNextFunction(state))

done(it::ModuleFunctionIterator, state) = state == C_NULL

eltype(it::ModuleFunctionIterator) = LLVMFunction

# NOTE: lacking `endof`, we override `last`
last(it::ModuleFunctionIterator) =
    LLVMFunction(API.LLVMGetLastFunction(convert(API.LLVMModuleRef, it.mod)))
