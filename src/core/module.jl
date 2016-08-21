# Modules represent the top-level structure in an LLVM program.

export Module, dispose,
       target, target!, datalayout, datalayout!

import Base: show

immutable Module
    handle::API.LLVMModuleRef

    Module(name::String) = new(API.LLVMModuleCreateWithName(name))
    Module(name::String, ctx::Context) = new(API.LLVMModuleCreateWithNameInContext(name, ctx.handle))
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
