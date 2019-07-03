# Julia wrapper for source: julia/src/llvm-api.cpp


# initialization functions

function LLVMInitializeAllTargetInfos()
    @apicall(:LLVMExtraInitializeAllTargetInfos,Cvoid,())
end

function LLVMInitializeAllTargets()
    @apicall(:LLVMExtraInitializeAllTargets,Cvoid,())
end

function LLVMInitializeAllTargetMCs()
    @apicall(:LLVMExtraInitializeAllTargetMCs,Cvoid,())
end

function LLVMInitializeAllAsmPrinters()
    @apicall(:LLVMExtraInitializeAllAsmPrinters,Cvoid,())
end

function LLVMInitializeAllAsmParsers()
    @apicall(:LLVMExtraInitializeAllAsmParsers,Cvoid,())
end

function LLVMInitializeAllDisassemblers()
    @apicall(:LLVMExtraInitializeAllDisassemblers,Cvoid,())
end

function LLVMInitializeNativeTarget()
    @apicall(:LLVMExtraInitializeNativeTarget,LLVMBool,())
end

function LLVMInitializeNativeAsmPrinter()
    @apicall(:LLVMExtraInitializeNativeAsmPrinter,LLVMBool,())
end

function LLVMInitializeNativeAsmParser()
    @apicall(:LLVMExtraInitializeNativeAsmParser,LLVMBool,())
end

function LLVMInitializeNativeDisassembler()
    @apicall(:LLVMExtraInitializeNativeDisassembler,LLVMBool,())
end


# infrastructure for writing LLVM passes in Julia

mutable struct LLVMOpaquePass
end

const LLVMPassRef = Ptr{LLVMOpaquePass}

function LLVMAddPass(PM::LLVMPassManagerRef, P::LLVMPassRef)
    @apicall(:LLVMExtraAddPass,Cvoid,
        (LLVMPassManagerRef, LLVMPassRef),
        PM, P)
end

function LLVMCreateModulePass(Name, Callback)
    @apicall(:LLVMExtraCreateModulePass,LLVMPassRef,
        (Cstring, Any),
        Name, Callback)
end

function LLVMCreateFunctionPass(Name, Callback)
    @apicall(:LLVMExtraCreateFunctionPass,LLVMPassRef,
        (Cstring, Any),
        Name, Callback)
end

function LLVMCreateBasicBlockPass(Name, Callback)
    @apicall(:LLVMExtraCreateBasicBlockPass,LLVMPassRef,
        (Cstring, Any),
        Name, Callback)
end


# various missing functions

function LLVMAddInternalizePassWithExportList(PM::LLVMPassManagerRef, ExportList, Length)
    @apicall(:LLVMExtraAddInternalizePassWithExportList,Cvoid,(LLVMPassManagerRef,Ptr{Cstring},Csize_t), PM, ExportList, Length)
end

function LLVMAddTargetLibraryInfoByTriple(Triple, PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddTargetLibraryInfoByTiple,Cvoid,(Cstring, LLVMPassManagerRef), Triple, PM)
end

if VERSION < v"1.2.0-DEV.531"

function LLVMAddNVVMReflectPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddMVVMReflectPass,Cvoid,(LLVMPassManagerRef,), PM)
end

else

if LLVM.libllvm_version < v"8.0.0"

function LLVMAddNVVMReflectPass(PM::LLVMPassManagerRef, smversion)
    @apicall(:LLVMExtraAddNVVMReflectPass,Cvoid,(LLVMPassManagerRef,), PM)
end

else

function LLVMAddNVVMReflectPass(PM::LLVMPassManagerRef, smversion)
    @apicall(:LLVMExtraAddNVVMReflectFunctionPass,Cvoid,(LLVMPassManagerRef, Cuint), PM, smversion)
end

end

function LLVMAddAllocOptPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddAllocOptPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddBarrierNoopPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddBarrierNoopPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddGCInvariantVerifierPass(PM::LLVMPassManagerRef, Strong)
    @apicall(:LLVMExtraAddGCInvariantVerifierPass,Cvoid,(LLVMPassManagerRef,LLVMBool), PM, Strong)
end

function LLVMAddLowerExcHandlersPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddLowerExcHandlersPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddCombineMulAddPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddCombineMulAddPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddMultiVersioningPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddMultiVersioningPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddPropagateJuliaAddrspaces(PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddPropagateJuliaAddrspaces,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddLowerPTLSPass(PM::LLVMPassManagerRef, imaging_mode)
    @apicall(:LLVMExtraAddLowerPTLSPass,Cvoid,(LLVMPassManagerRef,LLVMBool), PM, imaging_mode)
end

function LLVMAddLowerSimdLoopPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddLowerSimdLoopPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddLateLowerGCFramePass(PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddLateLowerGCFramePass,Cvoid,(LLVMPassManagerRef,), PM)
end

end

function LLVMGetValueContext(V::LLVMValueRef)
    @apicall(:LLVMExtraGetValueContext,LLVMContextRef,(LLVMValueRef,),V)
end

if VERSION >= v"0.7.0-alpha.37"

function LLVMGetSourceLocation(V::LLVMValueRef, index, Name, Filename, Line, Column)
    @apicall(:LLVMExtraGetSourceLocation,Cint,(LLVMValueRef,Cint,Ptr{Cstring},Ptr{Cstring},Ptr{Cuint},Ptr{Cuint}), V, index, Name, Filename, Line, Column)
end

end
