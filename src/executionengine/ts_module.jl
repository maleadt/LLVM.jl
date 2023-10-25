@checked struct ThreadSafeContext
    ref::API.LLVMOrcThreadSafeContextRef
end
Base.unsafe_convert(::Type{API.LLVMOrcThreadSafeContextRef}, ctx::ThreadSafeContext) = ctx.ref

function ThreadSafeContext(; opaque_pointers=false)
    ts_ctx = ThreadSafeContext(API.LLVMOrcCreateNewThreadSafeContext())
    @static if v"13" <= version() < v"17"
        ctx = context(ts_ctx)
        if opaque_pointers !== nothing && !has_set_opaque_pointers_value(ctx)
            opaque_pointers!(ctx, opaque_pointers)
        end
    end
    activate(ts_ctx)
    ts_ctx
end

function ThreadSafeContext(f::Core.Function; kwargs...)
    ctx = ThreadSafeContext(; kwargs...)
    try
        f(ctx)
    finally
        dispose(ctx)
    end
end

function context(ctx::ThreadSafeContext)
    ref = API.LLVMOrcThreadSafeContextGetContext(ctx)
    Context(ref)
end

function dispose(ctx::ThreadSafeContext)
    deactivate(ctx)
    API.LLVMOrcDisposeThreadSafeContext(ctx)
end

@checked struct ThreadSafeModule
    ref::API.LLVMOrcThreadSafeModuleRef
end
Base.unsafe_convert(::Type{API.LLVMOrcThreadSafeModuleRef}, mod::ThreadSafeModule) = mod.ref

function ThreadSafeModule(mod::Module)
    ref = API.LLVMOrcCreateNewThreadSafeModule(mod, ts_context())
    ThreadSafeModule(ref)
end

function ThreadSafeModule(name::String)
    ts_ctx = ts_context()
    # XXX: we should lock the context here
    ctx = context(ts_ctx)
    mod = context!(ctx) do
        Module(name)
    end
    ThreadSafeModule(mod)
end

function dispose(mod::ThreadSafeModule)
    API.LLVMOrcDisposeThreadSafeModule(mod)
end

mutable struct ThreadSafeModuleCallback
    callback
end

function tsm_callback(data::Ptr{Cvoid}, ref::API.LLVMModuleRef)
    cb = Base.unsafe_pointer_to_objref(data)::ThreadSafeModuleCallback
    mod = Module(ref)
    ctx = context(mod)
    activate(ctx)
    try
        cb.callback(Module(ref))
    catch err
        msg = sprint(Base.display_error, err, Base.catch_backtrace())
        return API.LLVMCreateStringError(msg)
    finally
        deactivate(ctx)
    end
    return convert(API.LLVMErrorRef, C_NULL)
end

"""
    (mod::ThreadSafeModule)(f)

Apply `f` to the LLVM module contained within `mod`, after locking the module and activating
its context.
"""
function (mod::ThreadSafeModule)(f)
    cb = ThreadSafeModuleCallback(f)
    GC.@preserve cb begin
        @check API.LLVMOrcThreadSafeModuleWithModuleDo(
            mod,
            @cfunction(tsm_callback, API.LLVMErrorRef, (Ptr{Cvoid}, API.LLVMModuleRef)),
            Base.pointer_from_objref(cb))
    end
    return mod
end
