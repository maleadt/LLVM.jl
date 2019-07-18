export DEBUG_METADATA_VERSION, strip_debuginfo!

DEBUG_METADATA_VERSION() = API.LLVMDebugMetadataVersion()

strip_debuginfo!(mod::Module) = API.LLVMStripModuleDebugInfo(ref(mod))

if libllvm_version >= v"8.0"
set_subprogram!(func::Function, sp::Metadata) = LLVM.API.LLVMSetSubprogram(ref(func), ref(sp))
get_subprogram(func::Function) = Metadata(LLVM.API.LLVMGetSubprogram(ref(func)))
end
