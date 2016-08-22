# Modules represent the top-level structure in an LLVM program.

export Module, dispose,
       target, target!, datalayout, datalayout!

import Base: show

immutable Module
    handle::API.LLVMModuleRef

    Module(name::String) = new(API.LLVMModuleCreateWithName(name))
    Module(name::String, ctx::Context) = new(API.LLVMModuleCreateWithNameInContext(name, ctx.handle))
    Module(mod::Module) = new(API.LLVMCloneModule(mod.handle))
end

dispose(mod::Module) = API.LLVMDisposeModule(mod.handle)

function show(io::IO, mod::Module)
    output = unsafe_string(API.LLVMPrintModuleToString(mod.handle))
    print(io, output)
end

target(mod::Module) = unsafe_string(API.LLVMGetTarget(mod.handle))
target!(mod::Module, triple) = API.LLVMSetTarget(mod.handle, triple)

datalayout(mod::Module) = unsafe_string(API.LLVMGetDataLayout(mod.handle))
datalayout!(mod::Module, layout) = API.LLVMSetDataLayout(mod.handle, layout)

inline_asm!(mod::Module, asm::String) = API.LLVMSetModuleInlineAsm(mod.handle, asm)

context(mod::Module) = Context(API.LLVMGetModuleContext(mod.handle))


## type iteration

export types

import Base: haskey, get

immutable ModuleTypeIterator
    mod::Module
end

types(mod::Module) = ModuleTypeIterator(mod)

function haskey(types::ModuleTypeIterator, name::String)
    return API.LLVMGetTypeByName(types.mod.handle, name) != C_NULL
end

function get(types::ModuleTypeIterator, name::String)
    typ = API.LLVMGetTypeByName(types.mod.handle, name)
    typ == C_NULL && throw(KeyError(name))
    return LLVMType(ptr)
end


## metadata iteration

export metadata, add!

import Base: haskey, get

immutable ModuleMetadataIterator
    mod::Module
end

metadata(mod::Module) = ModuleMetadataIterator(mod)

function haskey(md::ModuleMetadataIterator, name::String)
    return API.LLVMGetNamedMetadataNumOperands(md.mod.handle, name) != 0
end

function get(md::ModuleMetadataIterator, name::String)
    nops = API.LLVMGetNamedMetadataNumOperands(md.mod.handle, name)
    nops == 0 && throw(KeyError(name))
    ops = Vector{API.LLVMValueRef}(nops)
    LLVMType(API.LLVMGetNamedMetadataOperands(md.mod.handle, )name, ops)
    return map(t->Value(t), ops)
end

add!(md::ModuleMetadataIterator, name::String, val::Value) =
    API.LLVMAddNamedMetadataOperand(md.mod.handle, name, val.handle)



## function iteration

export functions, add!

import Base: haskey, get,
             start, next, done, eltype, last

immutable ModuleFunctionIterator
    mod::Module
end

functions(mod::Module) = ModuleFunctionIterator(mod)

function haskey(funcs::ModuleFunctionIterator, name::String)
    return API.LLVMGetNamedFunction(funcs.mod.handle, name) != C_NULL
end

function get(funcs::ModuleFunctionIterator, name::String)
    func = API.LLVMGetNamedFunction(funcs.mod.handle, name)
    func == C_NULL && throw(KeyError(name))
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
