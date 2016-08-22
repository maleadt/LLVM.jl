# Modules represent the top-level structure in an LLVM program.

export LLVMModule, dispose,
       target, target!, datalayout, datalayout!, context, inline_asm!

import Base: show

immutable LLVMModule
    handle::API.LLVMModuleRef

    LLVMModule(name::String) = new(API.LLVMModuleCreateWithName(name))
    LLVMModule(name::String, ctx::Context) = new(API.LLVMModuleCreateWithNameInContext(name, ctx.handle))
    LLVMModule(mod::LLVMModule) = new(API.LLVMCloneModule(mod.handle))
end

dispose(mod::LLVMModule) = API.LLVMDisposeModule(mod.handle)

function show(io::IO, mod::LLVMModule)
    output = unsafe_string(API.LLVMPrintModuleToString(mod.handle))
    print(io, output)
end

target(mod::LLVMModule) = unsafe_string(API.LLVMGetTarget(mod.handle))
target!(mod::LLVMModule, triple) = API.LLVMSetTarget(mod.handle, triple)

datalayout(mod::LLVMModule) = unsafe_string(API.LLVMGetDataLayout(mod.handle))
datalayout!(mod::LLVMModule, layout) = API.LLVMSetDataLayout(mod.handle, layout)

inline_asm!(mod::LLVMModule, asm::String) = API.LLVMSetModuleInlineAsm(mod.handle, asm)

context(mod::LLVMModule) = Context(API.LLVMGetModuleContext(mod.handle))


## type iteration

export types

import Base: haskey, get

immutable ModuleTypeIterator
    mod::LLVMModule
end

types(mod::LLVMModule) = ModuleTypeIterator(mod)

function haskey(types::ModuleTypeIterator, name::String)
    return API.LLVMGetTypeByName(types.mod.handle, name) != C_NULL
end

function get(types::ModuleTypeIterator, name::String)
    ptr = API.LLVMGetTypeByName(types.mod.handle, name)
    ptr == C_NULL && throw(KeyError(name))
    return LLVMType(ptr)
end


## metadata iteration

export metadata, add!

import Base: haskey, get

immutable ModuleMetadataIterator
    mod::LLVMModule
end

metadata(mod::LLVMModule) = ModuleMetadataIterator(mod)

function haskey(md::ModuleMetadataIterator, name::String)
    return API.LLVMGetNamedMetadataNumOperands(md.mod.handle, name) != 0
end

function get(md::ModuleMetadataIterator, name::String)
    nops = API.LLVMGetNamedMetadataNumOperands(md.mod.handle, name)
    nops == 0 && throw(KeyError(name))
    ops = Vector{API.LLVMValueRef}(nops)
    API.LLVMGetNamedMetadataOperands(md.mod.handle, name, ops)
    return map(t->Value(t), ops)
end

add!(md::ModuleMetadataIterator, name::String, val::Value) =
    API.LLVMAddNamedMetadataOperand(md.mod.handle, name, val.handle)


## function iteration

export functions, add!

import Base: haskey, get,
             start, next, done, eltype, last

immutable ModuleFunctionIterator
    mod::LLVMModule
end

functions(mod::LLVMModule) = ModuleFunctionIterator(mod)

function haskey(funcs::ModuleFunctionIterator, name::String)
    return API.LLVMGetNamedFunction(funcs.mod.handle, name) != C_NULL
end

function get(funcs::ModuleFunctionIterator, name::String)
    ptr = API.LLVMGetNamedFunction(funcs.mod.handle, name)
    ptr == C_NULL && throw(KeyError(name))
    return LLVM.Value(ptr)
end

add!(funcs::ModuleFunctionIterator, name::String, ftyp::LLVMType) =
    LLVM.Value(API.LLVMAddFunction(funcs.mod.handle, name, ftyp.handle))

start(funcs::ModuleFunctionIterator) = API.LLVMGetFirstFunction(funcs.mod.handle)

next(funcs::ModuleFunctionIterator, state) =
    (Value(state), API.LLVMGetNextFunction(state))

done(funcs::ModuleFunctionIterator, state) = state == C_NULL

eltype(funcs::ModuleFunctionIterator) = Value

# NOTE: lacking `endof`, we override `last`
last(funcs::ModuleFunctionIterator) = LLVM.Value(API.LLVMGetLastFunction(funcs.mod.handle))
