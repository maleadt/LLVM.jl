# Contexts are execution states for the core LLVM IR system.

export Context, dispose, GlobalContext

@reftypedef ref=LLVMContextRef immutable Context end

Context() = Context(API.LLVMContextCreate())

dispose(ctx::Context) = API.LLVMContextDispose(ref(ctx))

function Context(f::Function)
    ctx = Context()
    try
        f(ctx)
    finally
        dispose(ctx)
    end
end

GlobalContext() = Context(API.LLVMGetGlobalContext())
