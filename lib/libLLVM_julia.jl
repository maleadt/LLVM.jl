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
