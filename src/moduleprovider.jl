export ModuleProvider

# TODO: use this class implicitly? ie. when passing Modules to functions expecting a
#       ModuleProvider. Especially because unsafe_dispose!(mp) destroys the underlying mod.

@checked mutable struct ModuleProvider
    ref::API.LLVMModuleProviderRef
    mod::Module
end

Base.unsafe_convert(::Type{API.LLVMModuleProviderRef}, mp::ModuleProvider) = mp.ref

function ModuleProvider(mod::Module)
    mp = ModuleProvider(API.LLVMCreateModuleProviderForExistingModule(mod), mod)
    finalizer(unsafe_dispose!, mp)
end

function unsafe_dispose!(mp::ModuleProvider)
    API.LLVMDisposeModuleProvider(mp)
    # NOTE: this destroys the underlying module
    mp.mod.ref = C_NULL
end
