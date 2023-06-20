## context management

# LLVM contexts are maintained as a stack in task local store

export context, activate, deactivate, context!

function context()
    if !haskey(task_local_storage(), :LLVMContext)
        error("No LLVM context is active")
    end
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
    haskey(task_local_storage(), :LLVMContext) || error("No LLVM context is active")
    ctx == last(task_local_storage(:LLVMContext)) || error("Deactivating wrong context")
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
