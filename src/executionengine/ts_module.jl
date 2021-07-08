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
    ThreadSafeContext() do ctx
        mod = LLVM.Module(name; ctx=context(ctx))
        ThreadSafeModule(mod; ctx)
    end
end

function dispose(mod::ThreadSafeModule)
    API.LLVMOrcDisposeThreadSafeModule(mod)
end

mutable struct ThreadSafeModuleCallback
    callback
end

function tsm_callback(ctx::Ptr{Cvoid}, ref::API.LLVMModuleRef)
    try
        cb = Base.unsafe_pointer_to_objref(ctx)::ThreadSafeModuleCallback
        cb.callback(LLVM.Module(ref))
    catch err
        msg = sprint(Base.display_error, err, Base.catch_backtrace())
        return API.LLVMCreateStringError(msg)
    end
    return convert(API.LLVMErrorRef, C_NULL)
end

"""
    (mod::ThreadSafeModule)(f)

Apply `f` to the LLVM.Module contained within `mod`, after locking the module.
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
