# Julia wrapper for source: LLVMExtra_jll

# initialization functions

function LLVMInitializeAllTargetInfos()
    ccall((:LLVMExtraInitializeAllTargetInfos, libLLVMExtra),Cvoid,())
end

function LLVMInitializeAllTargets()
    ccall((:LLVMExtraInitializeAllTargets, libLLVMExtra),Cvoid,())
end

function LLVMInitializeAllTargetMCs()
    ccall((:LLVMExtraInitializeAllTargetMCs, libLLVMExtra),Cvoid,())
end

function LLVMInitializeAllAsmPrinters()
    ccall((:LLVMExtraInitializeAllAsmPrinters, libLLVMExtra),Cvoid,())
end

function LLVMInitializeAllAsmParsers()
    ccall((:LLVMExtraInitializeAllAsmParsers, libLLVMExtra),Cvoid,())
end

function LLVMInitializeAllDisassemblers()
    ccall((:LLVMExtraInitializeAllDisassemblers, libLLVMExtra),Cvoid,())
end

function LLVMInitializeNativeTarget()
    ccall((:LLVMExtraInitializeNativeTarget, libLLVMExtra),LLVMBool,())
end

function LLVMInitializeNativeAsmPrinter()
    ccall((:LLVMExtraInitializeNativeAsmPrinter, libLLVMExtra),LLVMBool,())
end

function LLVMInitializeNativeAsmParser()
    ccall((:LLVMExtraInitializeNativeAsmParser, libLLVMExtra),LLVMBool,())
end

function LLVMInitializeNativeDisassembler()
    ccall((:LLVMExtraInitializeNativeDisassembler, libLLVMExtra),LLVMBool,())
end

# infrastructure for writing LLVM passes in Julia

mutable struct LLVMOpaquePass
end

const LLVMPassRef = Ptr{LLVMOpaquePass}

function LLVMAddPass(PM, P)
    ccall((:LLVMExtraAddPass, libLLVMExtra),Cvoid,
        (LLVMPassManagerRef, LLVMPassRef),
        PM, P)
end

function LLVMCreateModulePass(Name, Callback)
    ccall((:LLVMExtraCreateModulePass, libLLVMExtra),LLVMPassRef,
        (Cstring, Any),
        Name, Callback)
end

function LLVMCreateFunctionPass(Name, Callback)
    ccall((:LLVMExtraCreateFunctionPass, libLLVMExtra),LLVMPassRef,
        (Cstring, Any),
        Name, Callback)
end

function LLVMCreateModulePass2(Name, Callback, Data)
    ccall((:LLVMExtraCreateModulePass2, libLLVMExtra),LLVMPassRef,
        (Cstring, Ptr{Cvoid}, Ptr{Cvoid}),
        Name, Callback, Data)
end

function LLVMCreateFunctionPass2(Name, Callback, Data)
    ccall((:LLVMExtraCreateFunctionPass2, libLLVMExtra),LLVMPassRef,
        (Cstring, Ptr{Cvoid}, Ptr{Cvoid}),
        Name, Callback, Data)
end


# various missing functions

function LLVMAddInternalizePassWithExportList(PM, ExportList, Length)
    ccall((:LLVMExtraAddInternalizePassWithExportList, libLLVMExtra),Cvoid,(LLVMPassManagerRef,Ptr{Cstring},Csize_t), PM, ExportList, Length)
end

function LLVMAddTargetLibraryInfoByTriple(Triple, PM)
    ccall((:LLVMExtraAddTargetLibraryInfoByTiple, libLLVMExtra),Cvoid,(Cstring, LLVMPassManagerRef), Triple, PM)
end

function LLVMAddNVVMReflectPass(PM, smversion)
    ccall((:LLVMExtraAddNVVMReflectFunctionPass, libLLVMExtra),Cvoid,(LLVMPassManagerRef, Cuint), PM, smversion)
end

function LLVMAddBarrierNoopPass(PM)
    ccall((:LLVMExtraAddBarrierNoopPass, libLLVMExtra),Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddDivRemPairsPass(PM)
    ccall((:LLVMExtraAddDivRemPairsPass, libLLVMExtra),Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddLoopDistributePass(PM)
    ccall((:LLVMExtraAddLoopDistributePass, libLLVMExtra),Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddLoopFusePass(PM)
    ccall((:LLVMExtraAddLoopFusePass, libLLVMExtra),Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddLoopLoadEliminationPass(PM)
    ccall((:LLVMExtraLoopLoadEliminationPass, libLLVMExtra),Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddLoadStoreVectorizerPass(PM)
    ccall((:LLVMExtraAddLoadStoreVectorizerPass, libLLVMExtra),Cvoid,(LLVMPassManagerRef,), PM)
end

if LLVM.version() < v"12"
function LLVMAddInstSimplifyPass(PM)
    ccall((:LLVMExtraAddInstructionSimplifyPass, libLLVMExtra),Cvoid,(LLVMPassManagerRef,), PM)
end
end

function LLVMGetValueContext(V)
    ccall((:LLVMExtraGetValueContext, libLLVMExtra),LLVMContextRef,(LLVMValueRef,),V)
end

function LLVMExtraAppendToUsed(Mod, Values, Count)
    ccall((:LLVMExtraAppendToUsed, libLLVMExtra),Cvoid,(LLVMModuleRef,Ptr{LLVMValueRef},Csize_t), Mod, Values, Count)
end

function LLVMExtraAppendToCompilerUsed(Mod, Values, Count)
    ccall((:LLVMExtraAppendToCompilerUsed, libLLVMExtra),Cvoid,(LLVMModuleRef,Ptr{LLVMValueRef},Csize_t), Mod, Values, Count)
end

function LLVMExtraAddGenericAnalysisPasses(PM)
    ccall((:LLVMExtraAddGenericAnalysisPasses, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

@cenum(LLVMDebugEmissionKind,
    LLVMDebugEmissionKindNoDebug = 0,
    LLVMDebugEmissionKindFullDebug = 1,
    LLVMDebugEmissionKindLineTablesOnly = 2,
    LLVMDebugEmissionKindDebugDirectivesOnly = 3,
)

function LLVMExtraDumpMetadata(MD)
    ccall((:LLVMExtraDumpMetadata, libLLVMExtra), Cvoid, (LLVMMetadataRef,), MD)
end

function LLVMExtraPrintMetadataToString(MD)
    ccall((:LLVMExtraPrintMetadataToString, libLLVMExtra), Cstring, (LLVMMetadataRef,), MD)
end

function LLVMExtraDIScopeGetName(Scope, Len)
    ccall((:LLVMExtraDIScopeGetName, libLLVMExtra), Cstring, (LLVMMetadataRef, Ptr{Cuint}), Scope, Len)
end

function LLVMExtraGetMDString2(MD, Len)
    ccall((:LLVMExtraGetMDString2, libLLVMExtra), Cstring, (LLVMMetadataRef, Ptr{Cuint}), MD, Len)
end

function LLVMExtraGetMDNodeNumOperands2(MD)
    ccall((:LLVMExtraGetMDNodeNumOperands2, libLLVMExtra), Cuint, (LLVMMetadataRef,), MD)
end

function LLVMExtraGetMDNodeOperands2(MD, Dest)
    ccall((:LLVMExtraGetMDNodeOperands2, libLLVMExtra), Cvoid, (LLVMMetadataRef, Ptr{LLVMMetadataRef}), MD, Dest)
end

function LLVMExtraGetNamedMetadataNumOperands2(NMD)
    ccall((:LLVMExtraGetNamedMetadataNumOperands2, libLLVMExtra), Cuint, (LLVMNamedMDNodeRef,), NMD)
end

function LLVMExtraGetNamedMetadataOperands2(NMD, Dest)
    ccall((:LLVMExtraGetNamedMetadataOperands2, libLLVMExtra), Cvoid, (LLVMNamedMDNodeRef, Ptr{LLVMMetadataRef}), NMD, Dest)
end

function LLVMExtraAddNamedMetadataOperand2(NMD, Val)
    ccall((:LLVMExtraAddNamedMetadataOperand2, libLLVMExtra), Cvoid, (LLVMNamedMDNodeRef, LLVMMetadataRef), NMD, Val)
end


# bug fixes

# TODO: upstream

function LLVMExtraSetInitializer(GlobalVar, ConstantVal)
    ccall((:LLVMExtraSetInitializer, libLLVMExtra), Cvoid, (LLVMValueRef, LLVMValueRef), GlobalVar, ConstantVal)
end

function LLVMExtraSetPersonalityFn(Fn, PersonalityFn)
    ccall((:LLVMExtraSetPersonalityFn, libLLVMExtra), Cvoid, (LLVMValueRef, LLVMValueRef), Fn, PersonalityFn)
end
