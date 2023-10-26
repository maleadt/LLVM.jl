# Global state

# to simplify the API, we maintain a stack of contexts in task local storage
# and pass them implicitly to LLVM API's that require them.


## plain contexts

export context, activate, deactivate, context!

_has_context() = haskey(task_local_storage(), :LLVMContext) &&
                 !isempty(task_local_storage(:LLVMContext))

function context(; throw_error::Bool=true)
    if !_has_context()
        throw_error && error("No LLVM context is active")
        return nothing
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


## thread-safe contexts

export ts_context, activate, deactivate, ts_context!

_has_ts_context() = haskey(task_local_storage(), :LLVMTSContext) &&
                    !isempty(task_local_storage(:LLVMTSContext))

function ts_context(; throw_error::Bool=true)
    if !_has_ts_context()
        throw_error && error("No LLVM thread-safe context is active")
        return nothing
    end
    last(task_local_storage(:LLVMTSContext))
end

function activate(ts_ctx::ThreadSafeContext)
    stack = get!(task_local_storage(), :LLVMTSContext) do
        ThreadSafeContext[]
    end
    push!(stack, ts_ctx)
    return
end

function deactivate(ts_ctx::ThreadSafeContext)
    ts_context() == ts_ctx || error("Deactivating wrong thread-safe context")
    pop!(task_local_storage(:LLVMTSContext))
end

function ts_context!(f, ts_ctx::ThreadSafeContext)
    activate(ts_ctx)
    try
        f()
    finally
        deactivate(ts_ctx)
    end
end
