## context management

# LLVM contexts are maintained as a stack in task local store

export hascontext, context, activate, deactivate, context!

hascontext() = haskey(task_local_storage(), :LLVMContext) &&
               !isempty(task_local_storage(:LLVMContext))

function context()
    hascontext() || error("No LLVM context is active")
    last(task_local_storage(:LLVMContext))
end

function activate(ctx::Context)
    stack = get!(task_local_storage(), :LLVMContext) do
        Context[]
    end
    push!(stack, ctx)
    return
end

function deactivate(ctx::Context)
    context() == ctx || error("Deactivating wrong context")
    pop!(task_local_storage(:LLVMContext))
end

function context!(f, ctx::Context)
    activate(ctx)
    try
        f()
    finally
        deactivate(ctx)
    end
end
