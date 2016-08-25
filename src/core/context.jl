# Contexts are execution states for the core LLVM IR system.

export Context, dispose, GlobalContext

@reftypedef reftype=LLVMContextRef immutable Context end

Context() = Context(API.LLVMContextCreate())

function Context(f::Function)
    ctx = Context()
    try
        f(ctx)
    finally
        dispose(ctx)
    end
end

dispose(ctx::Context) = API.LLVMContextDispose(ref(Context, ctx))

GlobalContext() = Context(API.LLVMGetGlobalContext())
