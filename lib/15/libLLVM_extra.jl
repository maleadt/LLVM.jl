using CEnum

function LLVMExtraInitializeNativeTarget()
    ccall((:LLVMExtraInitializeNativeTarget, libLLVMExtra), LLVMBool, ())
end

function LLVMExtraInitializeNativeAsmParser()
    ccall((:LLVMExtraInitializeNativeAsmParser, libLLVMExtra), LLVMBool, ())
end

function LLVMExtraInitializeNativeAsmPrinter()
    ccall((:LLVMExtraInitializeNativeAsmPrinter, libLLVMExtra), LLVMBool, ())
end

function LLVMExtraInitializeNativeDisassembler()
    ccall((:LLVMExtraInitializeNativeDisassembler, libLLVMExtra), LLVMBool, ())
end

@cenum LLVMDebugEmissionKind::UInt32 begin
    LLVMDebugEmissionKindNoDebug = 0
    LLVMDebugEmissionKindFullDebug = 1
    LLVMDebugEmissionKindLineTablesOnly = 2
    LLVMDebugEmissionKindDebugDirectivesOnly = 3
end

function LLVMAddBarrierNoopPass(PM)
    ccall((:LLVMAddBarrierNoopPass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddDivRemPairsPass(PM)
    ccall((:LLVMAddDivRemPairsPass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopDistributePass(PM)
    ccall((:LLVMAddLoopDistributePass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopFusePass(PM)
    ccall((:LLVMAddLoopFusePass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopLoadEliminationPass(PM)
    ccall((:LLVMAddLoopLoadEliminationPass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoadStoreVectorizerPass(PM)
    ccall((:LLVMAddLoadStoreVectorizerPass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddVectorCombinePass(PM)
    ccall((:LLVMAddVectorCombinePass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddSpeculativeExecutionIfHasBranchDivergencePass(PM)
    ccall((:LLVMAddSpeculativeExecutionIfHasBranchDivergencePass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddSimpleLoopUnrollPass(PM)
    ccall((:LLVMAddSimpleLoopUnrollPass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddInductiveRangeCheckEliminationPass(PM)
    ccall((:LLVMAddInductiveRangeCheckEliminationPass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddSimpleLoopUnswitchLegacyPass(PM)
    ccall((:LLVMAddSimpleLoopUnswitchLegacyPass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddExpandReductionsPass(PM)
    ccall((:LLVMAddExpandReductionsPass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

mutable struct LLVMOpaquePass end

const LLVMPassRef = Ptr{LLVMOpaquePass}

function LLVMAddPass(PM, P)
    ccall((:LLVMAddPass, libLLVMExtra), Cvoid, (LLVMPassManagerRef, LLVMPassRef), PM, P)
end

# typedef LLVMBool ( * LLVMPassCallback ) ( void * Ref , void * Data )
const LLVMPassCallback = Ptr{Cvoid}

function LLVMCreateModulePass2(Name, Callback, Data)
    ccall((:LLVMCreateModulePass2, libLLVMExtra), LLVMPassRef, (Cstring, LLVMPassCallback, Ptr{Cvoid}), Name, Callback, Data)
end

function LLVMCreateFunctionPass2(Name, Callback, Data)
    ccall((:LLVMCreateFunctionPass2, libLLVMExtra), LLVMPassRef, (Cstring, LLVMPassCallback, Ptr{Cvoid}), Name, Callback, Data)
end

function LLVMGetDebugMDVersion()
    ccall((:LLVMGetDebugMDVersion, libLLVMExtra), Cuint, ())
end

function LLVMGetBuilderContext(B)
    ccall((:LLVMGetBuilderContext, libLLVMExtra), LLVMContextRef, (LLVMBuilderRef,), B)
end

function LLVMGetValueContext(V)
    ccall((:LLVMGetValueContext, libLLVMExtra), LLVMContextRef, (LLVMValueRef,), V)
end

function LLVMAddTargetLibraryInfoByTriple(T, PM)
    ccall((:LLVMAddTargetLibraryInfoByTriple, libLLVMExtra), Cvoid, (Cstring, LLVMPassManagerRef), T, PM)
end

function LLVMAddInternalizePassWithExportList(PM, ExportList, Length)
    ccall((:LLVMAddInternalizePassWithExportList, libLLVMExtra), Cvoid, (LLVMPassManagerRef, Ptr{Cstring}, Csize_t), PM, ExportList, Length)
end

function LLVMAppendToUsed(Mod, Values, Count)
    ccall((:LLVMAppendToUsed, libLLVMExtra), Cvoid, (LLVMModuleRef, Ptr{LLVMValueRef}, Csize_t), Mod, Values, Count)
end

function LLVMAppendToCompilerUsed(Mod, Values, Count)
    ccall((:LLVMAppendToCompilerUsed, libLLVMExtra), Cvoid, (LLVMModuleRef, Ptr{LLVMValueRef}, Csize_t), Mod, Values, Count)
end

function LLVMAddGenericAnalysisPasses(PM)
    ccall((:LLVMAddGenericAnalysisPasses, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMDumpMetadata(MD)
    ccall((:LLVMDumpMetadata, libLLVMExtra), Cvoid, (LLVMMetadataRef,), MD)
end

function LLVMPrintMetadataToString(MD)
    ccall((:LLVMPrintMetadataToString, libLLVMExtra), Cstring, (LLVMMetadataRef,), MD)
end

function LLVMDIScopeGetName(File, Len)
    ccall((:LLVMDIScopeGetName, libLLVMExtra), Cstring, (LLVMMetadataRef, Ptr{Cuint}), File, Len)
end

function LLVMGetMDString2(MD, Length)
    ccall((:LLVMGetMDString2, libLLVMExtra), Cstring, (LLVMMetadataRef, Ptr{Cuint}), MD, Length)
end

function LLVMGetMDNodeNumOperands2(MD)
    ccall((:LLVMGetMDNodeNumOperands2, libLLVMExtra), Cuint, (LLVMMetadataRef,), MD)
end

function LLVMGetMDNodeOperands2(MD, Dest)
    ccall((:LLVMGetMDNodeOperands2, libLLVMExtra), Cvoid, (LLVMMetadataRef, Ptr{LLVMMetadataRef}), MD, Dest)
end

function LLVMGetNamedMetadataNumOperands2(NMD)
    ccall((:LLVMGetNamedMetadataNumOperands2, libLLVMExtra), Cuint, (LLVMNamedMDNodeRef,), NMD)
end

function LLVMGetNamedMetadataOperands2(NMD, Dest)
    ccall((:LLVMGetNamedMetadataOperands2, libLLVMExtra), Cvoid, (LLVMNamedMDNodeRef, Ptr{LLVMMetadataRef}), NMD, Dest)
end

function LLVMAddNamedMetadataOperand2(NMD, Val)
    ccall((:LLVMAddNamedMetadataOperand2, libLLVMExtra), Cvoid, (LLVMNamedMDNodeRef, LLVMMetadataRef), NMD, Val)
end

function LLVMReplaceMDNodeOperandWith2(MD, I, New)
    ccall((:LLVMReplaceMDNodeOperandWith2, libLLVMExtra), Cvoid, (LLVMMetadataRef, Cuint, LLVMMetadataRef), MD, I, New)
end

mutable struct LLVMOrcOpaqueIRCompileLayer end

const LLVMOrcIRCompileLayerRef = Ptr{LLVMOrcOpaqueIRCompileLayer}

function LLVMOrcIRCompileLayerEmit(IRLayer, MR, TSM)
    ccall((:LLVMOrcIRCompileLayerEmit, libLLVMExtra), Cvoid, (LLVMOrcIRCompileLayerRef, LLVMOrcMaterializationResponsibilityRef, LLVMOrcThreadSafeModuleRef), IRLayer, MR, TSM)
end

function LLVMDumpJitDylibToString(JD)
    ccall((:LLVMDumpJitDylibToString, libLLVMExtra), Cstring, (LLVMOrcJITDylibRef,), JD)
end

function LLVMGetFunctionType(Fn)
    ccall((:LLVMGetFunctionType, libLLVMExtra), LLVMTypeRef, (LLVMValueRef,), Fn)
end

function LLVMGetGlobalValueType(Fn)
    ccall((:LLVMGetGlobalValueType, libLLVMExtra), LLVMTypeRef, (LLVMValueRef,), Fn)
end

function LLVMAddCFGSimplificationPass2(PM, BonusInstThreshold, ForwardSwitchCondToPhi, ConvertSwitchToLookupTable, NeedCanonicalLoop, HoistCommonInsts, SinkCommonInsts, SimplifyCondBranch, FoldTwoEntryPHINode)
    ccall((:LLVMAddCFGSimplificationPass2, libLLVMExtra), Cvoid, (LLVMPassManagerRef, Cint, LLVMBool, LLVMBool, LLVMBool, LLVMBool, LLVMBool, LLVMBool, LLVMBool), PM, BonusInstThreshold, ForwardSwitchCondToPhi, ConvertSwitchToLookupTable, NeedCanonicalLoop, HoistCommonInsts, SinkCommonInsts, SimplifyCondBranch, FoldTwoEntryPHINode)
end

function LLVMSetInitializer2(GlobalVar, ConstantVal)
    ccall((:LLVMSetInitializer2, libLLVMExtra), Cvoid, (LLVMValueRef, LLVMValueRef), GlobalVar, ConstantVal)
end

function LLVMSetPersonalityFn2(Fn, PersonalityFn)
    ccall((:LLVMSetPersonalityFn2, libLLVMExtra), Cvoid, (LLVMValueRef, LLVMValueRef), Fn, PersonalityFn)
end

@cenum LLVMCloneFunctionChangeType::UInt32 begin
    LLVMCloneFunctionChangeTypeLocalChangesOnly = 0
    LLVMCloneFunctionChangeTypeGlobalChanges = 1
    LLVMCloneFunctionChangeTypeDifferentModule = 2
    LLVMCloneFunctionChangeTypeClonedModule = 3
end

function LLVMCloneFunctionInto(NewFunc, OldFunc, ValueMap, ValueMapElements, Changes, NameSuffix, TypeMapper, TypeMapperData, Materializer, MaterializerData)
    ccall((:LLVMCloneFunctionInto, libLLVMExtra), Cvoid, (LLVMValueRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, LLVMCloneFunctionChangeType, Cstring, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), NewFunc, OldFunc, ValueMap, ValueMapElements, Changes, NameSuffix, TypeMapper, TypeMapperData, Materializer, MaterializerData)
end

function LLVMCloneBasicBlock(BB, NameSuffix, ValueMap, ValueMapElements, F)
    ccall((:LLVMCloneBasicBlock, libLLVMExtra), LLVMBasicBlockRef, (LLVMBasicBlockRef, Cstring, Ptr{LLVMValueRef}, Cuint, LLVMValueRef), BB, NameSuffix, ValueMap, ValueMapElements, F)
end

function LLVMFunctionDeleteBody(Func)
    ccall((:LLVMFunctionDeleteBody, libLLVMExtra), Cvoid, (LLVMValueRef,), Func)
end

function LLVMDestroyConstant(Const)
    ccall((:LLVMDestroyConstant, libLLVMExtra), Cvoid, (LLVMValueRef,), Const)
end

mutable struct LLVMOpaqueOperandBundleUse end

const LLVMOperandBundleUseRef = Ptr{LLVMOpaqueOperandBundleUse}

function LLVMGetNumOperandBundles(Instr)
    ccall((:LLVMGetNumOperandBundles, libLLVMExtra), Cuint, (LLVMValueRef,), Instr)
end

function LLVMGetOperandBundle(Val, Index)
    ccall((:LLVMGetOperandBundle, libLLVMExtra), LLVMOperandBundleUseRef, (LLVMValueRef, Cuint), Val, Index)
end

function LLVMDisposeOperandBundleUse(Bundle)
    ccall((:LLVMDisposeOperandBundleUse, libLLVMExtra), Cvoid, (LLVMOperandBundleUseRef,), Bundle)
end

function LLVMGetOperandBundleUseTagID(Bundle)
    ccall((:LLVMGetOperandBundleUseTagID, libLLVMExtra), UInt32, (LLVMOperandBundleUseRef,), Bundle)
end

function LLVMGetOperandBundleUseTagName(Bundle, Length)
    ccall((:LLVMGetOperandBundleUseTagName, libLLVMExtra), Cstring, (LLVMOperandBundleUseRef, Ptr{Cuint}), Bundle, Length)
end

function LLVMGetOperandBundleUseNumInputs(Bundle)
    ccall((:LLVMGetOperandBundleUseNumInputs, libLLVMExtra), Cuint, (LLVMOperandBundleUseRef,), Bundle)
end

function LLVMGetOperandBundleUseInputs(Bundle, Dest)
    ccall((:LLVMGetOperandBundleUseInputs, libLLVMExtra), Cvoid, (LLVMOperandBundleUseRef, Ptr{LLVMValueRef}), Bundle, Dest)
end

mutable struct LLVMOpaqueOperandBundleDef end

const LLVMOperandBundleDefRef = Ptr{LLVMOpaqueOperandBundleDef}

function LLVMOperandBundleDefFromUse(Bundle)
    ccall((:LLVMOperandBundleDefFromUse, libLLVMExtra), LLVMOperandBundleDefRef, (LLVMOperandBundleUseRef,), Bundle)
end

function LLVMCreateOperandBundleDef(Tag, Inputs, NumInputs)
    ccall((:LLVMCreateOperandBundleDef, libLLVMExtra), LLVMOperandBundleDefRef, (Cstring, Ptr{LLVMValueRef}, Cuint), Tag, Inputs, NumInputs)
end

function LLVMDisposeOperandBundleDef(Bundle)
    ccall((:LLVMDisposeOperandBundleDef, libLLVMExtra), Cvoid, (LLVMOperandBundleDefRef,), Bundle)
end

function LLVMGetOperandBundleDefTag(Bundle, Length)
    ccall((:LLVMGetOperandBundleDefTag, libLLVMExtra), Cstring, (LLVMOperandBundleDefRef, Ptr{Cuint}), Bundle, Length)
end

function LLVMGetOperandBundleDefNumInputs(Bundle)
    ccall((:LLVMGetOperandBundleDefNumInputs, libLLVMExtra), Cuint, (LLVMOperandBundleDefRef,), Bundle)
end

function LLVMGetOperandBundleDefInputs(Bundle, Dest)
    ccall((:LLVMGetOperandBundleDefInputs, libLLVMExtra), Cvoid, (LLVMOperandBundleDefRef, Ptr{LLVMValueRef}), Bundle, Dest)
end

function LLVMBuildCallWithOpBundle(B, Fn, Args, NumArgs, Bundles, NumBundles, Name)
    ccall((:LLVMBuildCallWithOpBundle, libLLVMExtra), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Ptr{LLVMOperandBundleDefRef}, Cuint, Cstring), B, Fn, Args, NumArgs, Bundles, NumBundles, Name)
end

function LLVMBuildCallWithOpBundle2(B, Ty, Fn, Args, NumArgs, Bundles, NumBundles, Name)
    ccall((:LLVMBuildCallWithOpBundle2, libLLVMExtra), LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Ptr{LLVMOperandBundleDefRef}, Cuint, Cstring), B, Ty, Fn, Args, NumArgs, Bundles, NumBundles, Name)
end

function LLVMMetadataAsValue2(C, Metadata)
    ccall((:LLVMMetadataAsValue2, libLLVMExtra), LLVMValueRef, (LLVMContextRef, LLVMMetadataRef), C, Metadata)
end

function LLVMReplaceAllMetadataUsesWith(Old, New)
    ccall((:LLVMReplaceAllMetadataUsesWith, libLLVMExtra), Cvoid, (LLVMValueRef, LLVMValueRef), Old, New)
end

function LLVMReplaceMDNodeOperandWith(V, Index, Replacement)
    ccall((:LLVMReplaceMDNodeOperandWith, libLLVMExtra), Cvoid, (LLVMValueRef, Cuint, LLVMMetadataRef), V, Index, Replacement)
end

function LLVMConstDataArray(ElementTy, Data, NumElements)
    ccall((:LLVMConstDataArray, libLLVMExtra), LLVMValueRef, (LLVMTypeRef, Ptr{Cvoid}, Cuint), ElementTy, Data, NumElements)
end

function LLVMContextSupportsTypedPointers(C)
    ccall((:LLVMContextSupportsTypedPointers, libLLVMExtra), LLVMBool, (LLVMContextRef,), C)
end

mutable struct LLVMOpaqueDominatorTree end

const LLVMDominatorTreeRef = Ptr{LLVMOpaqueDominatorTree}

function LLVMCreateDominatorTree(Fn)
    ccall((:LLVMCreateDominatorTree, libLLVMExtra), LLVMDominatorTreeRef, (LLVMValueRef,), Fn)
end

function LLVMDisposeDominatorTree(Tree)
    ccall((:LLVMDisposeDominatorTree, libLLVMExtra), Cvoid, (LLVMDominatorTreeRef,), Tree)
end

function LLVMDominatorTreeInstructionDominates(Tree, InstA, InstB)
    ccall((:LLVMDominatorTreeInstructionDominates, libLLVMExtra), LLVMBool, (LLVMDominatorTreeRef, LLVMValueRef, LLVMValueRef), Tree, InstA, InstB)
end

mutable struct LLVMOpaquePostDominatorTree end

const LLVMPostDominatorTreeRef = Ptr{LLVMOpaquePostDominatorTree}

function LLVMCreatePostDominatorTree(Fn)
    ccall((:LLVMCreatePostDominatorTree, libLLVMExtra), LLVMPostDominatorTreeRef, (LLVMValueRef,), Fn)
end

function LLVMDisposePostDominatorTree(Tree)
    ccall((:LLVMDisposePostDominatorTree, libLLVMExtra), Cvoid, (LLVMPostDominatorTreeRef,), Tree)
end

function LLVMPostDominatorTreeInstructionDominates(Tree, InstA, InstB)
    ccall((:LLVMPostDominatorTreeInstructionDominates, libLLVMExtra), LLVMBool, (LLVMPostDominatorTreeRef, LLVMValueRef, LLVMValueRef), Tree, InstA, InstB)
end

@cenum __JL_Ctag_53::UInt32 begin
    LLVMFastMathAllowReassoc = 1
    LLVMFastMathNoNaNs = 2
    LLVMFastMathNoInfs = 4
    LLVMFastMathNoSignedZeros = 8
    LLVMFastMathAllowReciprocal = 16
    LLVMFastMathAllowContract = 32
    LLVMFastMathApproxFunc = 64
    LLVMFastMathNone = 0
    LLVMFastMathAll = 127
end

const LLVMFastMathFlags = Cuint

function LLVMGetFastMathFlags(FPMathInst)
    ccall((:LLVMGetFastMathFlags, libLLVMExtra), LLVMFastMathFlags, (LLVMValueRef,), FPMathInst)
end

function LLVMSetFastMathFlags(FPMathInst, FMF)
    ccall((:LLVMSetFastMathFlags, libLLVMExtra), Cvoid, (LLVMValueRef, LLVMFastMathFlags), FPMathInst, FMF)
end

function LLVMCanValueUseFastMathFlags(Inst)
    ccall((:LLVMCanValueUseFastMathFlags, libLLVMExtra), LLVMBool, (LLVMValueRef,), Inst)
end

function LLVMHasMetadata2(Inst)
    ccall((:LLVMHasMetadata2, libLLVMExtra), Cint, (LLVMValueRef,), Inst)
end

function LLVMGetMetadata2(Inst, KindID)
    ccall((:LLVMGetMetadata2, libLLVMExtra), LLVMValueRef, (LLVMValueRef, Cuint), Inst, KindID)
end

function LLVMSetMetadata2(Inst, KindID, Val)
    ccall((:LLVMSetMetadata2, libLLVMExtra), Cvoid, (LLVMValueRef, Cuint, LLVMValueRef), Inst, KindID, Val)
end

mutable struct LLVMOpaquePreservedAnalyses end

const LLVMPreservedAnalysesRef = Ptr{LLVMOpaquePreservedAnalyses}

function LLVMCreatePreservedAnalysesNone()
    ccall((:LLVMCreatePreservedAnalysesNone, libLLVMExtra), LLVMPreservedAnalysesRef, ())
end

function LLVMCreatePreservedAnalysesAll()
    ccall((:LLVMCreatePreservedAnalysesAll, libLLVMExtra), LLVMPreservedAnalysesRef, ())
end

function LLVMCreatePreservedAnalysesCFG()
    ccall((:LLVMCreatePreservedAnalysesCFG, libLLVMExtra), LLVMPreservedAnalysesRef, ())
end

function LLVMDisposePreservedAnalyses(PA)
    ccall((:LLVMDisposePreservedAnalyses, libLLVMExtra), Cvoid, (LLVMPreservedAnalysesRef,), PA)
end

function LLVMAreAllAnalysesPreserved(PA)
    ccall((:LLVMAreAllAnalysesPreserved, libLLVMExtra), LLVMBool, (LLVMPreservedAnalysesRef,), PA)
end

function LLVMAreCFGAnalysesPreserved(PA)
    ccall((:LLVMAreCFGAnalysesPreserved, libLLVMExtra), LLVMBool, (LLVMPreservedAnalysesRef,), PA)
end

mutable struct LLVMOpaqueModuleAnalysisManager end

const LLVMModuleAnalysisManagerRef = Ptr{LLVMOpaqueModuleAnalysisManager}

mutable struct LLVMOpaqueCGSCCAnalysisManager end

const LLVMCGSCCAnalysisManagerRef = Ptr{LLVMOpaqueCGSCCAnalysisManager}

mutable struct LLVMOpaqueFunctionAnalysisManager end

const LLVMFunctionAnalysisManagerRef = Ptr{LLVMOpaqueFunctionAnalysisManager}

mutable struct LLVMOpaqueLoopAnalysisManager end

const LLVMLoopAnalysisManagerRef = Ptr{LLVMOpaqueLoopAnalysisManager}

function LLVMCreateNewPMModuleAnalysisManager()
    ccall((:LLVMCreateNewPMModuleAnalysisManager, libLLVMExtra), LLVMModuleAnalysisManagerRef, ())
end

function LLVMCreateNewPMCGSCCAnalysisManager()
    ccall((:LLVMCreateNewPMCGSCCAnalysisManager, libLLVMExtra), LLVMCGSCCAnalysisManagerRef, ())
end

function LLVMCreateNewPMFunctionAnalysisManager()
    ccall((:LLVMCreateNewPMFunctionAnalysisManager, libLLVMExtra), LLVMFunctionAnalysisManagerRef, ())
end

function LLVMCreateNewPMLoopAnalysisManager()
    ccall((:LLVMCreateNewPMLoopAnalysisManager, libLLVMExtra), LLVMLoopAnalysisManagerRef, ())
end

function LLVMDisposeNewPMModuleAnalysisManager(AM)
    ccall((:LLVMDisposeNewPMModuleAnalysisManager, libLLVMExtra), Cvoid, (LLVMModuleAnalysisManagerRef,), AM)
end

function LLVMDisposeNewPMCGSCCAnalysisManager(AM)
    ccall((:LLVMDisposeNewPMCGSCCAnalysisManager, libLLVMExtra), Cvoid, (LLVMCGSCCAnalysisManagerRef,), AM)
end

function LLVMDisposeNewPMFunctionAnalysisManager(AM)
    ccall((:LLVMDisposeNewPMFunctionAnalysisManager, libLLVMExtra), Cvoid, (LLVMFunctionAnalysisManagerRef,), AM)
end

function LLVMDisposeNewPMLoopAnalysisManager(AM)
    ccall((:LLVMDisposeNewPMLoopAnalysisManager, libLLVMExtra), Cvoid, (LLVMLoopAnalysisManagerRef,), AM)
end

mutable struct LLVMOpaqueModulePassManager end

const LLVMModulePassManagerRef = Ptr{LLVMOpaqueModulePassManager}

mutable struct LLVMOpaqueCGSCCPassManager end

const LLVMCGSCCPassManagerRef = Ptr{LLVMOpaqueCGSCCPassManager}

mutable struct LLVMOpaqueFunctionPassManager end

const LLVMFunctionPassManagerRef = Ptr{LLVMOpaqueFunctionPassManager}

mutable struct LLVMOpaqueLoopPassManager end

const LLVMLoopPassManagerRef = Ptr{LLVMOpaqueLoopPassManager}

function LLVMCreateNewPMModulePassManager()
    ccall((:LLVMCreateNewPMModulePassManager, libLLVMExtra), LLVMModulePassManagerRef, ())
end

function LLVMCreateNewPMCGSCCPassManager()
    ccall((:LLVMCreateNewPMCGSCCPassManager, libLLVMExtra), LLVMCGSCCPassManagerRef, ())
end

function LLVMCreateNewPMFunctionPassManager()
    ccall((:LLVMCreateNewPMFunctionPassManager, libLLVMExtra), LLVMFunctionPassManagerRef, ())
end

function LLVMCreateNewPMLoopPassManager()
    ccall((:LLVMCreateNewPMLoopPassManager, libLLVMExtra), LLVMLoopPassManagerRef, ())
end

function LLVMDisposeNewPMModulePassManager(PM)
    ccall((:LLVMDisposeNewPMModulePassManager, libLLVMExtra), Cvoid, (LLVMModulePassManagerRef,), PM)
end

function LLVMDisposeNewPMCGSCCPassManager(PM)
    ccall((:LLVMDisposeNewPMCGSCCPassManager, libLLVMExtra), Cvoid, (LLVMCGSCCPassManagerRef,), PM)
end

function LLVMDisposeNewPMFunctionPassManager(PM)
    ccall((:LLVMDisposeNewPMFunctionPassManager, libLLVMExtra), Cvoid, (LLVMFunctionPassManagerRef,), PM)
end

function LLVMDisposeNewPMLoopPassManager(PM)
    ccall((:LLVMDisposeNewPMLoopPassManager, libLLVMExtra), Cvoid, (LLVMLoopPassManagerRef,), PM)
end

function LLVMRunNewPMModulePassManager(PM, M, AM)
    ccall((:LLVMRunNewPMModulePassManager, libLLVMExtra), LLVMPreservedAnalysesRef, (LLVMModulePassManagerRef, LLVMModuleRef, LLVMModuleAnalysisManagerRef), PM, M, AM)
end

function LLVMRunNewPMFunctionPassManager(PM, F, AM)
    ccall((:LLVMRunNewPMFunctionPassManager, libLLVMExtra), LLVMPreservedAnalysesRef, (LLVMFunctionPassManagerRef, LLVMValueRef, LLVMFunctionAnalysisManagerRef), PM, F, AM)
end

mutable struct LLVMOpaqueStandardInstrumentations end

const LLVMStandardInstrumentationsRef = Ptr{LLVMOpaqueStandardInstrumentations}

mutable struct LLVMOpaquePassInstrumentationCallbacks end

const LLVMPassInstrumentationCallbacksRef = Ptr{LLVMOpaquePassInstrumentationCallbacks}

function LLVMCreateStandardInstrumentations(C, DebugLogging, VerifyEach)
    ccall((:LLVMCreateStandardInstrumentations, libLLVMExtra), LLVMStandardInstrumentationsRef, (LLVMContextRef, LLVMBool, LLVMBool), C, DebugLogging, VerifyEach)
end

function LLVMCreatePassInstrumentationCallbacks()
    ccall((:LLVMCreatePassInstrumentationCallbacks, libLLVMExtra), LLVMPassInstrumentationCallbacksRef, ())
end

function LLVMDisposeStandardInstrumentations(SI)
    ccall((:LLVMDisposeStandardInstrumentations, libLLVMExtra), Cvoid, (LLVMStandardInstrumentationsRef,), SI)
end

function LLVMDisposePassInstrumentationCallbacks(PIC)
    ccall((:LLVMDisposePassInstrumentationCallbacks, libLLVMExtra), Cvoid, (LLVMPassInstrumentationCallbacksRef,), PIC)
end

function LLVMAddStandardInstrumentations(PIC, SI)
    ccall((:LLVMAddStandardInstrumentations, libLLVMExtra), Cvoid, (LLVMPassInstrumentationCallbacksRef, LLVMStandardInstrumentationsRef), PIC, SI)
end

mutable struct LLVMOpaquePassBuilder end

const LLVMPassBuilderRef = Ptr{LLVMOpaquePassBuilder}

function LLVMCreatePassBuilder(TM, PIC)
    ccall((:LLVMCreatePassBuilder, libLLVMExtra), LLVMPassBuilderRef, (LLVMTargetMachineRef, LLVMPassInstrumentationCallbacksRef), TM, PIC)
end

function LLVMDisposePassBuilder(PB)
    ccall((:LLVMDisposePassBuilder, libLLVMExtra), Cvoid, (LLVMPassBuilderRef,), PB)
end

function LLVMPassBuilderParseModulePassPipeline(PB, PM, PipelineText, PipelineTextLength)
    ccall((:LLVMPassBuilderParseModulePassPipeline, libLLVMExtra), LLVMErrorRef, (LLVMPassBuilderRef, LLVMModulePassManagerRef, Cstring, Csize_t), PB, PM, PipelineText, PipelineTextLength)
end

function LLVMPassBuilderParseCGSCCPassPipeline(PB, PM, PipelineText, PipelineTextLength)
    ccall((:LLVMPassBuilderParseCGSCCPassPipeline, libLLVMExtra), LLVMErrorRef, (LLVMPassBuilderRef, LLVMCGSCCPassManagerRef, Cstring, Csize_t), PB, PM, PipelineText, PipelineTextLength)
end

function LLVMPassBuilderParseFunctionPassPipeline(PB, PM, PipelineText, PipelineTextLength)
    ccall((:LLVMPassBuilderParseFunctionPassPipeline, libLLVMExtra), LLVMErrorRef, (LLVMPassBuilderRef, LLVMFunctionPassManagerRef, Cstring, Csize_t), PB, PM, PipelineText, PipelineTextLength)
end

function LLVMPassBuilderParseLoopPassPipeline(PB, PM, PipelineText, PipelineTextLength)
    ccall((:LLVMPassBuilderParseLoopPassPipeline, libLLVMExtra), LLVMErrorRef, (LLVMPassBuilderRef, LLVMLoopPassManagerRef, Cstring, Csize_t), PB, PM, PipelineText, PipelineTextLength)
end

function LLVMPassBuilderRegisterModuleAnalyses(PB, AM)
    ccall((:LLVMPassBuilderRegisterModuleAnalyses, libLLVMExtra), Cvoid, (LLVMPassBuilderRef, LLVMModuleAnalysisManagerRef), PB, AM)
end

function LLVMPassBuilderRegisterCGSCCAnalyses(PB, AM)
    ccall((:LLVMPassBuilderRegisterCGSCCAnalyses, libLLVMExtra), Cvoid, (LLVMPassBuilderRef, LLVMCGSCCAnalysisManagerRef), PB, AM)
end

function LLVMPassBuilderRegisterFunctionAnalyses(PB, AM)
    ccall((:LLVMPassBuilderRegisterFunctionAnalyses, libLLVMExtra), Cvoid, (LLVMPassBuilderRef, LLVMFunctionAnalysisManagerRef), PB, AM)
end

function LLVMPassBuilderRegisterLoopAnalyses(PB, AM)
    ccall((:LLVMPassBuilderRegisterLoopAnalyses, libLLVMExtra), Cvoid, (LLVMPassBuilderRef, LLVMLoopAnalysisManagerRef), PB, AM)
end

function LLVMPassBuilderCrossRegisterProxies(PB, LAM, FAM, CGAM, MAM)
    ccall((:LLVMPassBuilderCrossRegisterProxies, libLLVMExtra), Cvoid, (LLVMPassBuilderRef, LLVMLoopAnalysisManagerRef, LLVMFunctionAnalysisManagerRef, LLVMCGSCCAnalysisManagerRef, LLVMModuleAnalysisManagerRef), PB, LAM, FAM, CGAM, MAM)
end

function LLVMMPMAddMPM(PM, NestedPM)
    ccall((:LLVMMPMAddMPM, libLLVMExtra), Cvoid, (LLVMModulePassManagerRef, LLVMModulePassManagerRef), PM, NestedPM)
end

function LLVMCGPMAddCGPM(PM, NestedPM)
    ccall((:LLVMCGPMAddCGPM, libLLVMExtra), Cvoid, (LLVMCGSCCPassManagerRef, LLVMCGSCCPassManagerRef), PM, NestedPM)
end

function LLVMFPMAddFPM(PM, NestedPM)
    ccall((:LLVMFPMAddFPM, libLLVMExtra), Cvoid, (LLVMFunctionPassManagerRef, LLVMFunctionPassManagerRef), PM, NestedPM)
end

function LLVMLPMAddLPM(PM, NestedPM)
    ccall((:LLVMLPMAddLPM, libLLVMExtra), Cvoid, (LLVMLoopPassManagerRef, LLVMLoopPassManagerRef), PM, NestedPM)
end

function LLVMMPMAddCGPM(PM, NestedPM)
    ccall((:LLVMMPMAddCGPM, libLLVMExtra), Cvoid, (LLVMModulePassManagerRef, LLVMCGSCCPassManagerRef), PM, NestedPM)
end

function LLVMCGPMAddFPM(PM, NestedPM)
    ccall((:LLVMCGPMAddFPM, libLLVMExtra), Cvoid, (LLVMCGSCCPassManagerRef, LLVMFunctionPassManagerRef), PM, NestedPM)
end

function LLVMFPMAddLPM(PM, NestedPM, UseMemorySSA)
    ccall((:LLVMFPMAddLPM, libLLVMExtra), Cvoid, (LLVMFunctionPassManagerRef, LLVMLoopPassManagerRef, LLVMBool), PM, NestedPM, UseMemorySSA)
end

function LLVMMPMAddFPM(PM, NestedPM)
    ccall((:LLVMMPMAddFPM, libLLVMExtra), Cvoid, (LLVMModulePassManagerRef, LLVMFunctionPassManagerRef), PM, NestedPM)
end

# typedef LLVMPreservedAnalysesRef ( * LLVMJuliaModulePassCallback ) ( LLVMModuleRef M , LLVMModuleAnalysisManagerRef AM , void * Thunk )
const LLVMJuliaModulePassCallback = Ptr{Cvoid}

# typedef LLVMPreservedAnalysesRef ( * LLVMJuliaFunctionPassCallback ) ( LLVMValueRef F , LLVMFunctionAnalysisManagerRef AM , void * Thunk )
const LLVMJuliaFunctionPassCallback = Ptr{Cvoid}

function LLVMMPMAddJuliaPass(PM, Callback, Thunk)
    ccall((:LLVMMPMAddJuliaPass, libLLVMExtra), Cvoid, (LLVMModulePassManagerRef, LLVMJuliaModulePassCallback, Ptr{Cvoid}), PM, Callback, Thunk)
end

function LLVMFPMAddJuliaPass(PM, Callback, Thunk)
    ccall((:LLVMFPMAddJuliaPass, libLLVMExtra), Cvoid, (LLVMFunctionPassManagerRef, LLVMJuliaFunctionPassCallback, Ptr{Cvoid}), PM, Callback, Thunk)
end

function LLVMRegisterTargetIRAnalysis(FAM, TM)
    ccall((:LLVMRegisterTargetIRAnalysis, libLLVMExtra), LLVMBool, (LLVMFunctionAnalysisManagerRef, LLVMTargetMachineRef), FAM, TM)
end

function LLVMRegisterTargetLibraryAnalysis(FAM, Triple, TripleLength)
    ccall((:LLVMRegisterTargetLibraryAnalysis, libLLVMExtra), LLVMBool, (LLVMFunctionAnalysisManagerRef, Cstring, Csize_t), FAM, Triple, TripleLength)
end

function LLVMRegisterAliasAnalyses(FAM, PB, TM, Analyses, AnalysesLength)
    ccall((:LLVMRegisterAliasAnalyses, libLLVMExtra), LLVMErrorRef, (LLVMFunctionAnalysisManagerRef, LLVMPassBuilderRef, LLVMTargetMachineRef, Cstring, Csize_t), FAM, PB, TM, Analyses, AnalysesLength)
end

