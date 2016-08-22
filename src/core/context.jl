# Contexts are execution states for the core LLVM IR system.

export Context, dispose, GlobalContext

@llvmtype immutable Context end

Context() = Context(API.LLVMContextCreate())

function Context(f::Function)
    ctx = Context()
    try
        f(ctx)
    finally
        dispose(ctx)
    end
end

dispose(ctx::Context) = API.LLVMContextDispose(convert(API.LLVMContextRef, ctx))

GlobalContext() = Context(API.LLVMGetGlobalContext())
