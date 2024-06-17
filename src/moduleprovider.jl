export ModuleProvider, dispose

# TODO: use this class implicitly? ie. when passing Modules to functions expecting a
#       ModuleProvider. Especially because dispose(mp) destroys the underlying mod.

@checked struct ModuleProvider
    ref::API.LLVMModuleProviderRef
    mod::Module
end

Base.unsafe_convert(::Type{API.LLVMModuleProviderRef}, mp::ModuleProvider) =
    mark_use(mp).ref

ModuleProvider(mod::Module) =
    mark_alloc(ModuleProvider(API.LLVMCreateModuleProviderForExistingModule(mod), mod))

function ModuleProvider(f::Core.Function, args...; kwargs...)
    mp = ModuleProvider(args...; kwargs...)
    try
        f(mp)
    finally
        dispose(mp)
    end
end

function dispose(mp::ModuleProvider)
    # NOTE: this destroys the underlying module
    mark_dispose(mp.mod)

    mark_dispose(API.LLVMDisposeModuleProvider, mp)
end
