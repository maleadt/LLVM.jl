export DEBUG_METADATA_VERSION, strip_debuginfo!

DEBUG_METADATA_VERSION() = API.LLVMDebugMetadataVersion()

strip_debuginfo!(mod::Module) = API.LLVMStripModuleDebugInfo(mod)

function get_subprogram(func::Function)
    ref = API.LLVMGetSubprogram(func)
    ref==C_NULL ? nothing : Metadata(ref)
end
set_subprogram!(func::Function, sp::Metadata) = API.LLVMSetSubprogram(func, sp)
