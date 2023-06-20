@checked struct ThreadSafeContext
    ref::API.LLVMOrcThreadSafeContextRef
end
Base.unsafe_convert(::Type{API.LLVMOrcThreadSafeContextRef}, ctx::ThreadSafeContext) = ctx.ref

function ThreadSafeContext()
    ref = API.LLVMOrcCreateNewThreadSafeContext()
    ThreadSafeContext(ref)
end

function ThreadSafeContext(f::Core.Function)
    ctx = ThreadSafeContext()
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
    API.LLVMOrcDisposeThreadSafeContext(ctx)
end

@checked struct ThreadSafeModule
    ref::API.LLVMOrcThreadSafeModuleRef
end
Base.unsafe_convert(::Type{API.LLVMOrcThreadSafeModuleRef}, mod::ThreadSafeModule) = mod.ref

function ThreadSafeModule(mod::Module; ctx::ThreadSafeContext)
    ref = API.LLVMOrcCreateNewThreadSafeModule(mod, ctx)
    ThreadSafeModule(ref)
end

"""
    ThreadSafeModule(name::String)

Construct a ThreadSafeModule from a fresh LLVM.Module and a private context.
"""
function ThreadSafeModule(name::String)
    @dispose ctx=ThreadSafeContext() begin
        mod = context!(context(ctx)) do
            Module(name)
        end
        # NOTE: this creates a new context, so we can dispose the old one
        ThreadSafeModule(mod; ctx)
    end
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
