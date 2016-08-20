# Contexts are execution states for the core LLVM IR system.

export Context, dispose, GlobalContext

immutable Context
    handle::API.LLVMContextRef

    Context(handle::API.LLVMContextRef) = new(handle)
    Context() = new(API.LLVMContextCreate())
end

dispose(ctx::Context) = API.LLVMContextDispose(ctx.handle)

GlobalContext() = Context(API.LLVMGetGlobalContext())
