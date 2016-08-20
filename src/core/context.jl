# Contexts are execution states for the core LLVM IR system.

export Context, dispose, getGlobalContext

immutable Context
    handle::API.LLVMContextRef

    Context(handle::API.LLVMContextRef) = new(handle)
    Context() = new(API.LLVMContextCreate())
end

dispose(ctx::Context) = API.LLVMContextDispose(ctx.handle)

getGlobalContext() = Context(API.LLVMGetGlobalContext())
