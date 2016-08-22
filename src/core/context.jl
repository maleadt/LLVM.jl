# Contexts are execution states for the core LLVM IR system.

export Context, dispose, GlobalContext

immutable Context
    handle::API.LLVMContextRef

    Context(handle::API.LLVMContextRef) = new(handle)
    Context() = new(API.LLVMContextCreate())
end

function Context(f::Function)
    ctx = Context()
    try
        f(ctx)
    finally
        dispose(ctx)
    end
end

dispose(ctx::Context) = API.LLVMContextDispose(ctx.handle)

GlobalContext() = Context(API.LLVMGetGlobalContext())
