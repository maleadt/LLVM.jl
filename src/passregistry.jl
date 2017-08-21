@checked immutable PassRegistry
    ref::API.LLVMPassRegistryRef
end
reftype(::Type{PassRegistry}) = API.LLVMPassRegistryRef

export GlobalPassRegistry

GlobalPassRegistry() = PassRegistry(API.LLVMGetGlobalPassRegistry())
