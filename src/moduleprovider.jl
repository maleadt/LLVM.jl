export ModuleProvider, dispose

# TODO: use this class implicitly? ie. when passing Modules to functions expecting a
#       ModuleProvider. Especially because dispose(mp) destroys the underlying mod.

@reftypedef ref=LLVMModuleProviderRef immutable ModuleProvider end

ModuleProvider(mod::Module) =
    ModuleProvider(API.LLVMCreateModuleProviderForExistingModule(ref(mod)))

function ModuleProvider(f::Core.Function, args...)
    mp = ModuleProvider(args...)
    try
        f(mp)
    finally
        dispose(mp)
    end
end

# NOTE: this destroys the underlying module
dispose(mp::ModuleProvider) = API.LLVMDisposeModuleProvider(ref(mp))
