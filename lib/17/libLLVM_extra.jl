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

function LLVMAddLoadStoreVectorizerPass(PM)
    ccall((:LLVMAddLoadStoreVectorizerPass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddSpeculativeExecutionIfHasBranchDivergencePass(PM)
    ccall((:LLVMAddSpeculativeExecutionIfHasBranchDivergencePass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
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

function LLVMAddCFGSimplificationPass2(PM, BonusInstThreshold, ForwardSwitchCondToPhi, ConvertSwitchToLookupTable, NeedCanonicalLoop, HoistCommonInsts, SinkCommonInsts, SimplifyCondBranch, SpeculateBlocks)
    ccall((:LLVMAddCFGSimplificationPass2, libLLVMExtra), Cvoid, (LLVMPassManagerRef, Cint, LLVMBool, LLVMBool, LLVMBool, LLVMBool, LLVMBool, LLVMBool, LLVMBool), PM, BonusInstThreshold, ForwardSwitchCondToPhi, ConvertSwitchToLookupTable, NeedCanonicalLoop, HoistCommonInsts, SinkCommonInsts, SimplifyCondBranch, SpeculateBlocks)
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

function LLVMConstDataArray(ElementTy, Data, NumElements)
    ccall((:LLVMConstDataArray, libLLVMExtra), LLVMValueRef, (LLVMTypeRef, Ptr{Cvoid}, Cuint), ElementTy, Data, NumElements)
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

mutable struct LLVMOpaquePassBuilderExtensions end

const LLVMPassBuilderExtensionsRef = Ptr{LLVMOpaquePassBuilderExtensions}

function LLVMCreatePassBuilderExtensions()
    ccall((:LLVMCreatePassBuilderExtensions, libLLVMExtra), LLVMPassBuilderExtensionsRef, ())
end

function LLVMDisposePassBuilderExtensions(Extensions)
    ccall((:LLVMDisposePassBuilderExtensions, libLLVMExtra), Cvoid, (LLVMPassBuilderExtensionsRef,), Extensions)
end

function LLVMPassBuilderExtensionsSetRegistrationCallback(Options, RegistrationCallback)
    ccall((:LLVMPassBuilderExtensionsSetRegistrationCallback, libLLVMExtra), Cvoid, (LLVMPassBuilderExtensionsRef, Ptr{Cvoid}), Options, RegistrationCallback)
end

# typedef LLVMBool ( * LLVMJuliaModulePassCallback ) ( LLVMModuleRef M , void * Thunk )
const LLVMJuliaModulePassCallback = Ptr{Cvoid}

# typedef LLVMBool ( * LLVMJuliaFunctionPassCallback ) ( LLVMValueRef F , void * Thunk )
const LLVMJuliaFunctionPassCallback = Ptr{Cvoid}

function LLVMPassBuilderExtensionsRegisterModulePass(Options, PassName, Callback, Thunk)
    ccall((:LLVMPassBuilderExtensionsRegisterModulePass, libLLVMExtra), Cvoid, (LLVMPassBuilderExtensionsRef, Cstring, LLVMJuliaModulePassCallback, Ptr{Cvoid}), Options, PassName, Callback, Thunk)
end

function LLVMPassBuilderExtensionsRegisterFunctionPass(Options, PassName, Callback, Thunk)
    ccall((:LLVMPassBuilderExtensionsRegisterFunctionPass, libLLVMExtra), Cvoid, (LLVMPassBuilderExtensionsRef, Cstring, LLVMJuliaFunctionPassCallback, Ptr{Cvoid}), Options, PassName, Callback, Thunk)
end

function LLVMRunJuliaPasses(M, Passes, TM, Options, Extensions)
    ccall((:LLVMRunJuliaPasses, libLLVMExtra), LLVMErrorRef, (LLVMModuleRef, Cstring, LLVMTargetMachineRef, LLVMPassBuilderOptionsRef, LLVMPassBuilderExtensionsRef), M, Passes, TM, Options, Extensions)
end

