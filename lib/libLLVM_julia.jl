# Julia wrapper for source: julia/src/llvm-api.cpp

function LLVMAddAllocOptPass(PM)
    ccall(:LLVMExtraAddAllocOptPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddGCInvariantVerifierPass(PM, Strong)
    ccall(:LLVMExtraAddGCInvariantVerifierPass,Cvoid,(LLVMPassManagerRef,LLVMBool), PM, Strong)
end

function LLVMAddLowerExcHandlersPass(PM)
    ccall(:LLVMExtraAddLowerExcHandlersPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddCombineMulAddPass(PM)
    ccall(:LLVMExtraAddCombineMulAddPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddMultiVersioningPass(PM)
    ccall(:LLVMExtraAddMultiVersioningPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddPropagateJuliaAddrspaces(PM)
    ccall(:LLVMExtraAddPropagateJuliaAddrspaces,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddLowerPTLSPass(PM, imaging_mode)
    ccall(:LLVMExtraAddLowerPTLSPass,Cvoid,(LLVMPassManagerRef,LLVMBool), PM, imaging_mode)
end

function LLVMAddLowerSimdLoopPass(PM)
    ccall(:LLVMExtraAddLowerSimdLoopPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddLateLowerGCFramePass(PM)
    ccall(:LLVMExtraAddLateLowerGCFramePass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddFinalLowerGCPass(PM)
    ccall(:LLVMExtraAddFinalLowerGCPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddRemoveJuliaAddrspacesPass(PM)
    ccall(:LLVMExtraAddRemoveJuliaAddrspacesPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddDemoteFloat16Pass(PM)
    ccall(:LLVMExtraAddDemoteFloat16Pass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddRemoveNIPass(PM)
    ccall(:LLVMExtraAddRemoveNIPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddJuliaLICMPass(PM)
    ccall(:LLVMExtraJuliaLICMPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddCPUFeaturesPass(PM)
    ccall(:LLVMExtraAddCPUFeaturesPass,Cvoid,(LLVMPassManagerRef,), PM)
end


if VERSION >= v"1.10.0-DEV.1622"

struct PipelineConfig
    Speedup::Cint
    Size::Cint
    lower_intrinsics::Cint
    dump_native::Cint
    external_use::Cint
    llvm_only::Cint
    always_inline::Cint
    enable_early_simplifications::Cint
    enable_early_optimizations::Cint
    enable_scalar_optimizations::Cint
    enable_loop_optimizations::Cint
    enable_vector_pipeline::Cint
    remove_ni::Cint
    cleanup::Cint
end

end


if VERSION >= v"1.10.0-DEV.1395"

mutable struct JLOpaqueJuliaOJIT end

const JuliaOJITRef = Ptr{JLOpaqueJuliaOJIT}

function JLJITGetJuliaOJIT()
    ccall(:JLJITGetJuliaOJIT, JuliaOJITRef, ())
end

function JLJITGetLLVMOrcExecutionSession(JIT)
    ccall(:JLJITGetLLVMOrcExecutionSession, LLVMOrcExecutionSessionRef, (JuliaOJITRef,), JIT)
end

function JLJITGetExternalJITDylib(JIT)
    ccall(:JLJITGetExternalJITDylib, LLVMOrcJITDylibRef, (JuliaOJITRef,), JIT)
end

function JLJITAddObjectFile(JIT, JD, ObjBuffer)
    ccall(:JLJITAddObjectFile, LLVMErrorRef, (JuliaOJITRef, LLVMOrcJITDylibRef, LLVMMemoryBufferRef), JIT, JD, ObjBuffer)
end

function JLJITAddLLVMIRModule(JIT, JD, TSM)
    ccall(:JLJITAddLLVMIRModule, LLVMErrorRef, (JuliaOJITRef, LLVMOrcJITDylibRef,  LLVMOrcThreadSafeModuleRef), JIT, JD, TSM)
end

function JLJITLookup(JIT, Result, Name, ExternalJDOnly)
    ccall(:JLJITLookup, LLVMErrorRef, (JuliaOJITRef, Ptr{LLVMOrcExecutorAddress}, Cstring, Cint), JIT, Result, Name, ExternalJDOnly)
end

function JLJITMangleAndIntern(JIT, UnmangledName)
    ccall(:JLJITMangleAndIntern, LLVMOrcSymbolStringPoolEntryRef, (JuliaOJITRef, Cstring), JIT, UnmangledName)
end

function JLJITGetTripleString(JIT)
    ccall(:JLJITGetTripleString, Cstring, (JuliaOJITRef,), JIT)
end

function JLJITGetGlobalPrefix(JIT)
    ccall(:JLJITGetGlobalPrefix, Cchar, (JuliaOJITRef,), JIT)
end

function JLJITGetDataLayoutString(JIT)
    ccall(:JLJITGetDataLayoutString, Cstring, (JuliaOJITRef,), JIT)
end

function JLJITGetIRCompileLayer(JIT)
    ccall(:JLJITGetIRCompileLayer, LLVMOrcIRCompileLayerRef, (JuliaOJITRef,), JIT)
end

end
