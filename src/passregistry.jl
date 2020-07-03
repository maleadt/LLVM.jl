@checked struct PassRegistry
    ref::API.LLVMPassRegistryRef
end

Base.unsafe_convert(::Type{API.LLVMPassRegistryRef}, pr::PassRegistry) = pr.ref

export GlobalPassRegistry

GlobalPassRegistry() = PassRegistry(API.LLVMGetGlobalPassRegistry())
