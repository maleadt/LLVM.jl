using CEnum

function LLVMInitializeNativeTarget()
    ccall((:LLVMExtraInitializeNativeTarget, libLLVMExtra), LLVMBool, ())
end

function LLVMInitializeNativeAsmParser()
    ccall((:LLVMExtraInitializeNativeAsmParser, libLLVMExtra), LLVMBool, ())
end

function LLVMInitializeNativeAsmPrinter()
    ccall((:LLVMExtraInitializeNativeAsmPrinter, libLLVMExtra), LLVMBool, ())
end

function LLVMInitializeNativeDisassembler()
    ccall((:LLVMExtraInitializeNativeDisassembler, libLLVMExtra), LLVMBool, ())
end

@cenum(LLVMDebugEmissionKind,
    LLVMDebugEmissionKindNoDebug = 0,
    LLVMDebugEmissionKindFullDebug = 1,
    LLVMDebugEmissionKindLineTablesOnly = 2,
    LLVMDebugEmissionKindDebugDirectivesOnly = 3,
)

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

if version() < v"12"
function LLVMAddInstructionSimplifyPass(PM)
    ccall((:LLVMAddInstructionSimplifyPass, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end
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

function LLVMGetValueContext(V)
    ccall((:LLVMGetValueContext, libLLVMExtra), LLVMContextRef, (LLVMValueRef,), V)
end

function LLVMAddTargetLibraryInfoByTriple(T, PM)
    ccall((:LLVMAddTargetLibraryInfoByTriple, libLLVMExtra), Cvoid, (Cstring, LLVMPassManagerRef), T, PM)
end

function LLVMAddInternalizePassWithExportList(PM, ExportList, Length)
    ccall((:LLVMAddInternalizePassWithExportList, libLLVMExtra), Cvoid, (LLVMPassManagerRef, Ptr{Cstring}, Csize_t), PM, ExportList, Length)
end

function LLVMExtraAppendToUsed(Mod, Values, Count)
    ccall((:LLVMExtraAppendToUsed, libLLVMExtra), Cvoid, (LLVMModuleRef, Ptr{LLVMValueRef}, Csize_t), Mod, Values, Count)
end

function LLVMExtraAppendToCompilerUsed(Mod, Values, Count)
    ccall((:LLVMExtraAppendToCompilerUsed, libLLVMExtra), Cvoid, (LLVMModuleRef, Ptr{LLVMValueRef}, Csize_t), Mod, Values, Count)
end

function LLVMExtraAddGenericAnalysisPasses(PM)
    ccall((:LLVMExtraAddGenericAnalysisPasses, libLLVMExtra), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMExtraSetInitializer(GlobalVar, ConstantVal)
    ccall((:LLVMExtraSetInitializer, libLLVMExtra), Cvoid, (LLVMValueRef, LLVMValueRef), GlobalVar, ConstantVal)
end

function LLVMExtraSetPersonalityFn(Fn, PersonalityFn)
    ccall((:LLVMExtraSetPersonalityFn, libLLVMExtra), Cvoid, (LLVMValueRef, LLVMValueRef), Fn, PersonalityFn)
end

function LLVMExtraDIScopeGetName(Scope, Len)
    ccall((:LLVMExtraDIScopeGetName, libLLVMExtra), Cstring, (LLVMMetadataRef, Ptr{Cuint}), Scope, Len)
end

function LLVMAddCFGSimplificationPass2(PM, BonusInstThreshold, ForwardSwitchCondToPhi,
                                       ConvertSwitchToLookupTable, NeedCanonicalLoop,
                                       HoistCommonInsts, SinkCommonInsts,
                                       SimplifyCondBranch, FoldTwoEntryPHINode)
    ccall((:LLVMAddCFGSimplificationPass2, libLLVMExtra), Cvoid,
          (LLVMPassManagerRef, Cint, LLVMBool, LLVMBool, LLVMBool, LLVMBool, LLVMBool, LLVMBool, LLVMBool),
          PM, BonusInstThreshold, ForwardSwitchCondToPhi, ConvertSwitchToLookupTable, NeedCanonicalLoop,
          HoistCommonInsts, SinkCommonInsts, SimplifyCondBranch, FoldTwoEntryPHINode)
end

# bug fixes

# TODO: upstream

function LLVMExtraDumpMetadata(MD)
    ccall((:LLVMExtraDumpMetadata, libLLVMExtra), Cvoid, (LLVMMetadataRef,), MD)
end

function LLVMExtraPrintMetadataToString(MD)
    ccall((:LLVMExtraPrintMetadataToString, libLLVMExtra), Cstring, (LLVMMetadataRef,), MD)
end

function LLVMExtraGetMDNodeNumOperands2(MD)
    ccall((:LLVMExtraGetMDNodeNumOperands2, libLLVMExtra), Cuint, (LLVMMetadataRef,), MD)
end

function LLVMExtraGetMDString2(MD, Len)
    ccall((:LLVMExtraGetMDString2, libLLVMExtra), Cstring, (LLVMMetadataRef, Ptr{Cuint}), MD, Len)
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

if v"12" <= version() < v"13"

function LLVMCreateTypeAttribute(C, KindID, type_ref)
    ccall((:LLVMCreateTypeAttribute, libLLVMExtra), LLVMAttributeRef, (LLVMContextRef, Cuint, LLVMTypeRef), C, KindID, type_ref)
end

function LLVMGetTypeAttributeValue(A)
    ccall((:LLVMGetTypeAttributeValue, libLLVMExtra), LLVMTypeRef, (LLVMAttributeRef,), A)
end

function LLVMIsTypeAttribute(A)
    ccall((:LLVMIsTypeAttribute, libLLVMExtra), LLVMBool, (LLVMAttributeRef,), A)
end

struct LLVMOrcCSymbolFlagsMapPair
    Name::LLVMOrcSymbolStringPoolEntryRef
    Flags::LLVMJITSymbolFlags
end

const LLVMOrcCSymbolFlagsMapPairs = Ptr{LLVMOrcCSymbolFlagsMapPair}

struct LLVMOrcCSymbolAliasMapEntry
    Name::LLVMOrcSymbolStringPoolEntryRef
    Flags::LLVMJITSymbolFlags
end

struct LLVMOrcCSymbolAliasMapPair
    Name::LLVMOrcSymbolStringPoolEntryRef
    Entry::LLVMOrcCSymbolAliasMapEntry
end

const LLVMOrcCSymbolAliasMapPairs = Ptr{LLVMOrcCSymbolAliasMapPair}

mutable struct LLVMOrcOpaqueMaterializationResponsibility end

const LLVMOrcMaterializationResponsibilityRef = Ptr{LLVMOrcOpaqueMaterializationResponsibility}

# typedef void ( * LLVMOrcMaterializationUnitMaterializeFunction ) ( void * Ctx , LLVMOrcMaterializationResponsibilityRef MR )
const LLVMOrcMaterializationUnitMaterializeFunction = Ptr{Cvoid}

# typedef void ( * LLVMOrcMaterializationUnitDiscardFunction ) ( void * Ctx , LLVMOrcJITDylibRef JD , LLVMOrcSymbolStringPoolEntryRef Symbol )
const LLVMOrcMaterializationUnitDiscardFunction = Ptr{Cvoid}

# typedef void ( * LLVMOrcMaterializationUnitDestroyFunction ) ( void * Ctx )
const LLVMOrcMaterializationUnitDestroyFunction = Ptr{Cvoid}

# typedef LLVMErrorRef ( * LLVMOrcGenericIRModuleOperationFunction ) ( void * Ctx , LLVMModuleRef M )
const LLVMOrcGenericIRModuleOperationFunction = Ptr{Cvoid}

mutable struct LLVMOrcOpaqueIRTransformLayer end

const LLVMOrcIRTransformLayerRef = Ptr{LLVMOrcOpaqueIRTransformLayer}

# typedef LLVMErrorRef ( * LLVMOrcIRTransformLayerTransformFunction ) ( void * Ctx , LLVMOrcThreadSafeModuleRef * ModInOut , LLVMOrcMaterializationResponsibilityRef MR )
const LLVMOrcIRTransformLayerTransformFunction = Ptr{Cvoid}

mutable struct LLVMOrcOpaqueIndirectStubsManager end

const LLVMOrcIndirectStubsManagerRef = Ptr{LLVMOrcOpaqueIndirectStubsManager}

mutable struct LLVMOrcOpaqueLazyCallThroughManager end

const LLVMOrcLazyCallThroughManagerRef = Ptr{LLVMOrcOpaqueLazyCallThroughManager}

function LLVMOrcCreateCustomMaterializationUnit(Name, Ctx, Syms, NumSyms, InitSym, Materialize, Discard, Destroy)
    ccall((:LLVMOrcCreateCustomMaterializationUnit, libLLVMExtra), LLVMOrcMaterializationUnitRef, (Cstring, Ptr{Cvoid}, LLVMOrcCSymbolFlagsMapPairs, Csize_t, LLVMOrcSymbolStringPoolEntryRef, LLVMOrcMaterializationUnitMaterializeFunction, LLVMOrcMaterializationUnitDiscardFunction, LLVMOrcMaterializationUnitDestroyFunction), Name, Ctx, Syms, NumSyms, InitSym, Materialize, Discard, Destroy)
end

function LLVMOrcLazyReexports(LCTM, ISM, SourceRef, CallableAliases, NumPairs)
    ccall((:LLVMOrcLazyReexports, libLLVMExtra), LLVMOrcMaterializationUnitRef, (LLVMOrcLazyCallThroughManagerRef, LLVMOrcIndirectStubsManagerRef, LLVMOrcJITDylibRef, LLVMOrcCSymbolAliasMapPairs, Csize_t), LCTM, ISM, SourceRef, CallableAliases, NumPairs)
end

function LLVMOrcMaterializationResponsibilityGetTargetDylib(MR)
    ccall((:LLVMOrcMaterializationResponsibilityGetTargetDylib, libLLVMExtra), LLVMOrcJITDylibRef, (LLVMOrcMaterializationResponsibilityRef,), MR)
end

function LLVMOrcMaterializationResponsibilityGetExecutionSession(MR)
    ccall((:LLVMOrcMaterializationResponsibilityGetExecutionSession, libLLVMExtra), LLVMOrcExecutionSessionRef, (LLVMOrcMaterializationResponsibilityRef,), MR)
end

function LLVMOrcMaterializationResponsibilityGetInitializerSymbol(MR)
    ccall((:LLVMOrcMaterializationResponsibilityGetInitializerSymbol, libLLVMExtra), LLVMOrcSymbolStringPoolEntryRef, (LLVMOrcMaterializationResponsibilityRef,), MR)
end

function LLVMOrcMaterializationResponsibilityGetRequestedSymbols(MR, NumSymbols)
    ccall((:LLVMOrcMaterializationResponsibilityGetRequestedSymbols, libLLVMExtra), Ptr{LLVMOrcSymbolStringPoolEntryRef}, (LLVMOrcMaterializationResponsibilityRef, Ptr{Csize_t}), MR, NumSymbols)
end

function LLVMOrcDisposeSymbols(Symbols)
    ccall((:LLVMOrcDisposeSymbols, libLLVMExtra), Cvoid, (Ptr{LLVMOrcSymbolStringPoolEntryRef},), Symbols)
end

function LLVMOrcMaterializationResponsibilityNotifyResolved(MR, Symbols, NumPairs)
    ccall((:LLVMOrcMaterializationResponsibilityNotifyResolved, libLLVMExtra), LLVMErrorRef, (LLVMOrcMaterializationResponsibilityRef, LLVMOrcCSymbolMapPairs, Csize_t), MR, Symbols, NumPairs)
end

function LLVMOrcMaterializationResponsibilityNotifyEmitted(MR)
    ccall((:LLVMOrcMaterializationResponsibilityNotifyEmitted, libLLVMExtra), LLVMErrorRef, (LLVMOrcMaterializationResponsibilityRef,), MR)
end

function LLVMOrcMaterializationResponsibilityFailMaterialization(MR)
    ccall((:LLVMOrcMaterializationResponsibilityFailMaterialization, libLLVMExtra), Cvoid, (LLVMOrcMaterializationResponsibilityRef,), MR)
end

function LLVMOrcThreadSafeModuleWithModuleDo(TSM, F, Ctx)
    ccall((:LLVMOrcThreadSafeModuleWithModuleDo, libLLVMExtra), LLVMErrorRef, (LLVMOrcThreadSafeModuleRef, LLVMOrcGenericIRModuleOperationFunction, Ptr{Cvoid}), TSM, F, Ctx)
end

function LLVMOrcIRTransformLayerEmit(IRTransformLayer, MR, TSM)
    ccall((:LLVMOrcIRTransformLayerEmit, libLLVMExtra), Cvoid, (LLVMOrcIRTransformLayerRef, LLVMOrcMaterializationResponsibilityRef, LLVMOrcThreadSafeModuleRef), IRTransformLayer, MR, TSM)
end

function LLVMOrcCreateLocalIndirectStubsManager(TargetTriple)
    ccall((:LLVMOrcCreateLocalIndirectStubsManager, libLLVMExtra), LLVMOrcIndirectStubsManagerRef, (Cstring,), TargetTriple)
end

function LLVMOrcDisposeIndirectStubsManager(ISM)
    ccall((:LLVMOrcDisposeIndirectStubsManager, libLLVMExtra), Cvoid, (LLVMOrcIndirectStubsManagerRef,), ISM)
end

function LLVMOrcCreateLocalLazyCallThroughManager(TargetTriple, ES, ErrorHandlerAddr, Result)
    ccall((:LLVMOrcCreateLocalLazyCallThroughManager, libLLVMExtra), LLVMErrorRef, (Cstring, LLVMOrcExecutionSessionRef, LLVMOrcJITTargetAddress, Ptr{LLVMOrcLazyCallThroughManagerRef}), TargetTriple, ES, ErrorHandlerAddr, Result)
end

function LLVMOrcDisposeLazyCallThroughManager(LCM)
    ccall((:LLVMOrcDisposeLazyCallThroughManager, libLLVMExtra), Cvoid, (LLVMOrcLazyCallThroughManagerRef,), LCM)
end

function LLVMOrcLLJITGetIRTransformLayer(J)
    ccall((:LLVMOrcLLJITGetIRTransformLayer, libLLVMExtra), LLVMOrcIRTransformLayerRef, (LLVMOrcLLJITRef,), J)
end

function LLVMOrcLLJITApplyDataLayout(J, Mod)
    ccall((:LLVMOrcLLJITApplyDataLayout, libLLVMExtra), LLVMErrorRef, (LLVMOrcLLJITRef, LLVMModuleRef), J, Mod)
end

end # version

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

function LLVMMetadataAsValue2(C, MD)
    ccall((:LLVMMetadataAsValue2, libLLVMExtra), LLVMValueRef, (LLVMContextRef, LLVMMetadataRef), C, MD)
end

function LLVMReplaceAllMetadataUsesWith(OldVal, NewVal)
    ccall((:LLVMReplaceAllMetadataUsesWith, libLLVMExtra), Cvoid, (LLVMValueRef, LLVMValueRef), OldVal, NewVal)
end

function LLVMReplaceMDNodeOperandWith(MD, I, New)
    ccall((:LLVMReplaceMDNodeOperandWith, libLLVMExtra), Cvoid, (LLVMMetadataRef, Cuint, LLVMMetadataRef), MD, I, New)
end

mutable struct LLVMOpaqueDominatorTree end

const LLVMDominatorTreeRef = Ptr{LLVMOpaqueDominatorTree}

function LLVMCreateDominatorTree(Fn)
    ccall((:LLVMCreateDominatorTree, libLLVMExtra), LLVMDominatorTreeRef, (LLVMValueRef, ), Fn)
end

function LLVMDisposeDominatorTree(Tree)
    ccall((:LLVMDisposeDominatorTree, libLLVMExtra), Cvoid, (LLVMDominatorTreeRef, ), Tree)
end

function LLVMDominatorTreeInstructionDominates(Tree, InstA, InstB)
    ccall((:LLVMDominatorTreeInstructionDominates, libLLVMExtra), LLVMBool, (LLVMDominatorTreeRef, LLVMValueRef, LLVMValueRef), Tree, InstA, InstB)
end

mutable struct LLVMOpaquePostDominatorTree end

const LLVMPostDominatorTreeRef = Ptr{LLVMOpaquePostDominatorTree}

function LLVMCreatePostDominatorTree(Fn)
    ccall((:LLVMCreatePostDominatorTree, libLLVMExtra), LLVMPostDominatorTreeRef, (LLVMValueRef, ), Fn)
end

function LLVMDisposePostDominatorTree(Tree)
    ccall((:LLVMDisposePostDominatorTree, libLLVMExtra), Cvoid, (LLVMPostDominatorTreeRef, ), Tree)
end

function LLVMPostDominatorTreeInstructionDominates(Tree, InstA, InstB)
    ccall((:LLVMPostDominatorTreeInstructionDominates, libLLVMExtra), LLVMBool, (LLVMPostDominatorTreeRef, LLVMValueRef, LLVMValueRef), Tree, InstA, InstB)
end

if version() > v"12"
function LLVMContextSupportsTypedPointers(Ctx)
    ccall((:LLVMContextSupportsTypedPointers, libLLVMExtra), LLVMBool, (LLVMContextRef,), Ctx)
end
end

function LLVMConstDataArray(ElementTy, Data, NumElements)
    ccall((:LLVMConstDataArray, libLLVMExtra), LLVMValueRef, (LLVMTypeRef, Ptr{Cvoid}, Cuint), ElementTy, Data, NumElements)
end

function LLVMGetFunctionType(Fn)
    ccall((:LLVMGetFunctionType,libLLVMExtra), LLVMTypeRef, (LLVMValueRef,), Fn)
end

function LLVMGetGlobalValueType(Fn)
    ccall((:LLVMGetGlobalValueType,libLLVMExtra), LLVMTypeRef, (LLVMValueRef,), Fn)
end

function LLVMGetBuilderContext(B)
    ccall((:LLVMGetBuilderContext, libLLVMExtra), LLVMContextRef, (LLVMBuilderRef,), B)
end

if v"13" <= version() < v"15"
function LLVMPointerTypeIsOpaque(Ty)
    ccall((:LLVMPointerTypeIsOpaque, libLLVMExtra), LLVMBool, (LLVMTypeRef,), Ty)
end
function LLVMPointerTypeInContext(C, AddressSpace)
    ccall((:LLVMPointerTypeInContext, libLLVMExtra), LLVMTypeRef, (LLVMContextRef, Cuint), C, AddressSpace)
end
end

if version() >= v"13"
function LLVMExtraDumpJitDylibToString(JD)
    ccall((:LLVMExtraDumpJitDylibToString, libLLVMExtra),  Cstring, (LLVMOrcJITDylibRef,), JD)
end

mutable struct LLVMOrcOpaqueIRCompileLayer end

const LLVMOrcIRCompileLayerRef = Ptr{LLVMOrcOpaqueIRCompileLayer}

function LLVMExtraOrcIRCompileLayerEmit(IRCompileLayer, MR, TSM)
    ccall((:LLVMExtraOrcIRCompileLayerEmit, libLLVMExtra), Cvoid, (LLVMOrcIRCompileLayerRef, LLVMOrcMaterializationResponsibilityRef, LLVMOrcThreadSafeModuleRef), IRCompileLayer, MR, TSM)
end
end # version() >= v"13"

if v"15" <= version()
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
    convert(Core.Bool, ccall((:LLVMAreAllAnalysesPreserved, libLLVMExtra), LLVMBool, (LLVMPreservedAnalysesRef,), PA))
end

function LLVMAreCFGAnalysesPreserved(PA)
    convert(Core.Bool, ccall((:LLVMAreCFGAnalysesPreserved, libLLVMExtra), LLVMBool, (LLVMPreservedAnalysesRef,), PA))
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

function LLVMCreateStandardInstrumentations()
    ccall((:LLVMCreateStandardInstrumentations, libLLVMExtra), LLVMStandardInstrumentationsRef, ())
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
end # v"15" <= version()
