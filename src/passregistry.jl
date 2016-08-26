@reftypedef ref=LLVMPassRegistryRef immutable PassRegistry end

export GlobalPassRegistry

GlobalPassRegistry() = PassRegistry(API.LLVMGetGlobalPassRegistry())
