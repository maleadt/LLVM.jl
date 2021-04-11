using CEnum

const off_t = Csize_t


@cenum LLVMVerifierFailureAction::UInt32 begin
    LLVMAbortProcessAction = 0
    LLVMPrintMessageAction = 1
    LLVMReturnStatusAction = 2
end

mutable struct LLVMOpaqueModule end

const LLVMModuleRef = Ptr{LLVMOpaqueModule}

const LLVMBool = Cint

function LLVMVerifyModule(M, Action, OutMessage)
    @runtime_ccall (:LLVMVerifyModule, libllvm[]) LLVMBool (LLVMModuleRef, LLVMVerifierFailureAction, Ptr{Cstring}) M Action OutMessage
end

mutable struct LLVMOpaqueValue end

const LLVMValueRef = Ptr{LLVMOpaqueValue}

function LLVMVerifyFunction(Fn, Action)
    @runtime_ccall (:LLVMVerifyFunction, libllvm[]) LLVMBool (LLVMValueRef, LLVMVerifierFailureAction) Fn Action
end

function LLVMViewFunctionCFG(Fn)
    @runtime_ccall (:LLVMViewFunctionCFG, libllvm[]) Cvoid (LLVMValueRef,) Fn
end

function LLVMViewFunctionCFGOnly(Fn)
    @runtime_ccall (:LLVMViewFunctionCFGOnly, libllvm[]) Cvoid (LLVMValueRef,) Fn
end

mutable struct LLVMOpaqueMemoryBuffer end

const LLVMMemoryBufferRef = Ptr{LLVMOpaqueMemoryBuffer}

function LLVMParseBitcode(MemBuf, OutModule, OutMessage)
    @runtime_ccall (:LLVMParseBitcode, libllvm[]) LLVMBool (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}) MemBuf OutModule OutMessage
end

function LLVMParseBitcode2(MemBuf, OutModule)
    @runtime_ccall (:LLVMParseBitcode2, libllvm[]) LLVMBool (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}) MemBuf OutModule
end

mutable struct LLVMOpaqueContext end

const LLVMContextRef = Ptr{LLVMOpaqueContext}

function LLVMParseBitcodeInContext(ContextRef, MemBuf, OutModule, OutMessage)
    @runtime_ccall (:LLVMParseBitcodeInContext, libllvm[]) LLVMBool (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}) ContextRef MemBuf OutModule OutMessage
end

function LLVMParseBitcodeInContext2(ContextRef, MemBuf, OutModule)
    @runtime_ccall (:LLVMParseBitcodeInContext2, libllvm[]) LLVMBool (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}) ContextRef MemBuf OutModule
end

function LLVMGetBitcodeModuleInContext(ContextRef, MemBuf, OutM, OutMessage)
    @runtime_ccall (:LLVMGetBitcodeModuleInContext, libllvm[]) LLVMBool (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}) ContextRef MemBuf OutM OutMessage
end

function LLVMGetBitcodeModuleInContext2(ContextRef, MemBuf, OutM)
    @runtime_ccall (:LLVMGetBitcodeModuleInContext2, libllvm[]) LLVMBool (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}) ContextRef MemBuf OutM
end

function LLVMGetBitcodeModule(MemBuf, OutM, OutMessage)
    @runtime_ccall (:LLVMGetBitcodeModule, libllvm[]) LLVMBool (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}) MemBuf OutM OutMessage
end

function LLVMGetBitcodeModule2(MemBuf, OutM)
    @runtime_ccall (:LLVMGetBitcodeModule2, libllvm[]) LLVMBool (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}) MemBuf OutM
end

function LLVMWriteBitcodeToFile(M, Path)
    @runtime_ccall (:LLVMWriteBitcodeToFile, libllvm[]) Cint (LLVMModuleRef, Cstring) M Path
end

function LLVMWriteBitcodeToFD(M, FD, ShouldClose, Unbuffered)
    @runtime_ccall (:LLVMWriteBitcodeToFD, libllvm[]) Cint (LLVMModuleRef, Cint, Cint, Cint) M FD ShouldClose Unbuffered
end

function LLVMWriteBitcodeToFileHandle(M, Handle)
    @runtime_ccall (:LLVMWriteBitcodeToFileHandle, libllvm[]) Cint (LLVMModuleRef, Cint) M Handle
end

function LLVMWriteBitcodeToMemoryBuffer(M)
    @runtime_ccall (:LLVMWriteBitcodeToMemoryBuffer, libllvm[]) LLVMMemoryBufferRef (LLVMModuleRef,) M
end

@cenum LLVMComdatSelectionKind::UInt32 begin
    LLVMAnyComdatSelectionKind = 0
    LLVMExactMatchComdatSelectionKind = 1
    LLVMLargestComdatSelectionKind = 2
    LLVMNoDuplicatesComdatSelectionKind = 3
    LLVMSameSizeComdatSelectionKind = 4
end

mutable struct LLVMComdat end

const LLVMComdatRef = Ptr{LLVMComdat}

function LLVMGetOrInsertComdat(M, Name)
    @runtime_ccall (:LLVMGetOrInsertComdat, libllvm[]) LLVMComdatRef (LLVMModuleRef, Cstring) M Name
end

function LLVMGetComdat(V)
    @runtime_ccall (:LLVMGetComdat, libllvm[]) LLVMComdatRef (LLVMValueRef,) V
end

function LLVMSetComdat(V, C)
    @runtime_ccall (:LLVMSetComdat, libllvm[]) Cvoid (LLVMValueRef, LLVMComdatRef) V C
end

function LLVMGetComdatSelectionKind(C)
    @runtime_ccall (:LLVMGetComdatSelectionKind, libllvm[]) LLVMComdatSelectionKind (LLVMComdatRef,) C
end

function LLVMSetComdatSelectionKind(C, Kind)
    @runtime_ccall (:LLVMSetComdatSelectionKind, libllvm[]) Cvoid (LLVMComdatRef, LLVMComdatSelectionKind) C Kind
end

@cenum LLVMOpcode::UInt32 begin
    LLVMRet = 1
    LLVMBr = 2
    LLVMSwitch = 3
    LLVMIndirectBr = 4
    LLVMInvoke = 5
    LLVMUnreachable = 7
    LLVMCallBr = 67
    LLVMFNeg = 66
    LLVMAdd = 8
    LLVMFAdd = 9
    LLVMSub = 10
    LLVMFSub = 11
    LLVMMul = 12
    LLVMFMul = 13
    LLVMUDiv = 14
    LLVMSDiv = 15
    LLVMFDiv = 16
    LLVMURem = 17
    LLVMSRem = 18
    LLVMFRem = 19
    LLVMShl = 20
    LLVMLShr = 21
    LLVMAShr = 22
    LLVMAnd = 23
    LLVMOr = 24
    LLVMXor = 25
    LLVMAlloca = 26
    LLVMLoad = 27
    LLVMStore = 28
    LLVMGetElementPtr = 29
    LLVMTrunc = 30
    LLVMZExt = 31
    LLVMSExt = 32
    LLVMFPToUI = 33
    LLVMFPToSI = 34
    LLVMUIToFP = 35
    LLVMSIToFP = 36
    LLVMFPTrunc = 37
    LLVMFPExt = 38
    LLVMPtrToInt = 39
    LLVMIntToPtr = 40
    LLVMBitCast = 41
    LLVMAddrSpaceCast = 60
    LLVMICmp = 42
    LLVMFCmp = 43
    LLVMPHI = 44
    LLVMCall = 45
    LLVMSelect = 46
    LLVMUserOp1 = 47
    LLVMUserOp2 = 48
    LLVMVAArg = 49
    LLVMExtractElement = 50
    LLVMInsertElement = 51
    LLVMShuffleVector = 52
    LLVMExtractValue = 53
    LLVMInsertValue = 54
    LLVMFreeze = 68
    LLVMFence = 55
    LLVMAtomicCmpXchg = 56
    LLVMAtomicRMW = 57
    LLVMResume = 58
    LLVMLandingPad = 59
    LLVMCleanupRet = 61
    LLVMCatchRet = 62
    LLVMCatchPad = 63
    LLVMCleanupPad = 64
    LLVMCatchSwitch = 65
end

@cenum LLVMTypeKind::UInt32 begin
    LLVMVoidTypeKind = 0
    LLVMHalfTypeKind = 1
    LLVMFloatTypeKind = 2
    LLVMDoubleTypeKind = 3
    LLVMX86_FP80TypeKind = 4
    LLVMFP128TypeKind = 5
    LLVMPPC_FP128TypeKind = 6
    LLVMLabelTypeKind = 7
    LLVMIntegerTypeKind = 8
    LLVMFunctionTypeKind = 9
    LLVMStructTypeKind = 10
    LLVMArrayTypeKind = 11
    LLVMPointerTypeKind = 12
    LLVMVectorTypeKind = 13
    LLVMMetadataTypeKind = 14
    LLVMX86_MMXTypeKind = 15
    LLVMTokenTypeKind = 16
    LLVMScalableVectorTypeKind = 17
    LLVMBFloatTypeKind = 18
end

@cenum LLVMLinkage::UInt32 begin
    LLVMExternalLinkage = 0
    LLVMAvailableExternallyLinkage = 1
    LLVMLinkOnceAnyLinkage = 2
    LLVMLinkOnceODRLinkage = 3
    LLVMLinkOnceODRAutoHideLinkage = 4
    LLVMWeakAnyLinkage = 5
    LLVMWeakODRLinkage = 6
    LLVMAppendingLinkage = 7
    LLVMInternalLinkage = 8
    LLVMPrivateLinkage = 9
    LLVMDLLImportLinkage = 10
    LLVMDLLExportLinkage = 11
    LLVMExternalWeakLinkage = 12
    LLVMGhostLinkage = 13
    LLVMCommonLinkage = 14
    LLVMLinkerPrivateLinkage = 15
    LLVMLinkerPrivateWeakLinkage = 16
end

@cenum LLVMVisibility::UInt32 begin
    LLVMDefaultVisibility = 0
    LLVMHiddenVisibility = 1
    LLVMProtectedVisibility = 2
end

@cenum LLVMUnnamedAddr::UInt32 begin
    LLVMNoUnnamedAddr = 0
    LLVMLocalUnnamedAddr = 1
    LLVMGlobalUnnamedAddr = 2
end

@cenum LLVMDLLStorageClass::UInt32 begin
    LLVMDefaultStorageClass = 0
    LLVMDLLImportStorageClass = 1
    LLVMDLLExportStorageClass = 2
end

@cenum LLVMCallConv::UInt32 begin
    LLVMCCallConv = 0
    LLVMFastCallConv = 8
    LLVMColdCallConv = 9
    LLVMGHCCallConv = 10
    LLVMHiPECallConv = 11
    LLVMWebKitJSCallConv = 12
    LLVMAnyRegCallConv = 13
    LLVMPreserveMostCallConv = 14
    LLVMPreserveAllCallConv = 15
    LLVMSwiftCallConv = 16
    LLVMCXXFASTTLSCallConv = 17
    LLVMX86StdcallCallConv = 64
    LLVMX86FastcallCallConv = 65
    LLVMARMAPCSCallConv = 66
    LLVMARMAAPCSCallConv = 67
    LLVMARMAAPCSVFPCallConv = 68
    LLVMMSP430INTRCallConv = 69
    LLVMX86ThisCallCallConv = 70
    LLVMPTXKernelCallConv = 71
    LLVMPTXDeviceCallConv = 72
    LLVMSPIRFUNCCallConv = 75
    LLVMSPIRKERNELCallConv = 76
    LLVMIntelOCLBICallConv = 77
    LLVMX8664SysVCallConv = 78
    LLVMWin64CallConv = 79
    LLVMX86VectorCallCallConv = 80
    LLVMHHVMCallConv = 81
    LLVMHHVMCCallConv = 82
    LLVMX86INTRCallConv = 83
    LLVMAVRINTRCallConv = 84
    LLVMAVRSIGNALCallConv = 85
    LLVMAVRBUILTINCallConv = 86
    LLVMAMDGPUVSCallConv = 87
    LLVMAMDGPUGSCallConv = 88
    LLVMAMDGPUPSCallConv = 89
    LLVMAMDGPUCSCallConv = 90
    LLVMAMDGPUKERNELCallConv = 91
    LLVMX86RegCallCallConv = 92
    LLVMAMDGPUHSCallConv = 93
    LLVMMSP430BUILTINCallConv = 94
    LLVMAMDGPULSCallConv = 95
    LLVMAMDGPUESCallConv = 96
end

@cenum LLVMValueKind::UInt32 begin
    LLVMArgumentValueKind = 0
    LLVMBasicBlockValueKind = 1
    LLVMMemoryUseValueKind = 2
    LLVMMemoryDefValueKind = 3
    LLVMMemoryPhiValueKind = 4
    LLVMFunctionValueKind = 5
    LLVMGlobalAliasValueKind = 6
    LLVMGlobalIFuncValueKind = 7
    LLVMGlobalVariableValueKind = 8
    LLVMBlockAddressValueKind = 9
    LLVMConstantExprValueKind = 10
    LLVMConstantArrayValueKind = 11
    LLVMConstantStructValueKind = 12
    LLVMConstantVectorValueKind = 13
    LLVMUndefValueValueKind = 14
    LLVMConstantAggregateZeroValueKind = 15
    LLVMConstantDataArrayValueKind = 16
    LLVMConstantDataVectorValueKind = 17
    LLVMConstantIntValueKind = 18
    LLVMConstantFPValueKind = 19
    LLVMConstantPointerNullValueKind = 20
    LLVMConstantTokenNoneValueKind = 21
    LLVMMetadataAsValueValueKind = 22
    LLVMInlineAsmValueKind = 23
    LLVMInstructionValueKind = 24
end

@cenum LLVMIntPredicate::UInt32 begin
    LLVMIntEQ = 32
    LLVMIntNE = 33
    LLVMIntUGT = 34
    LLVMIntUGE = 35
    LLVMIntULT = 36
    LLVMIntULE = 37
    LLVMIntSGT = 38
    LLVMIntSGE = 39
    LLVMIntSLT = 40
    LLVMIntSLE = 41
end

@cenum LLVMRealPredicate::UInt32 begin
    LLVMRealPredicateFalse = 0
    LLVMRealOEQ = 1
    LLVMRealOGT = 2
    LLVMRealOGE = 3
    LLVMRealOLT = 4
    LLVMRealOLE = 5
    LLVMRealONE = 6
    LLVMRealORD = 7
    LLVMRealUNO = 8
    LLVMRealUEQ = 9
    LLVMRealUGT = 10
    LLVMRealUGE = 11
    LLVMRealULT = 12
    LLVMRealULE = 13
    LLVMRealUNE = 14
    LLVMRealPredicateTrue = 15
end

@cenum LLVMLandingPadClauseTy::UInt32 begin
    LLVMLandingPadCatch = 0
    LLVMLandingPadFilter = 1
end

@cenum LLVMThreadLocalMode::UInt32 begin
    LLVMNotThreadLocal = 0
    LLVMGeneralDynamicTLSModel = 1
    LLVMLocalDynamicTLSModel = 2
    LLVMInitialExecTLSModel = 3
    LLVMLocalExecTLSModel = 4
end

@cenum LLVMAtomicOrdering::UInt32 begin
    LLVMAtomicOrderingNotAtomic = 0
    LLVMAtomicOrderingUnordered = 1
    LLVMAtomicOrderingMonotonic = 2
    LLVMAtomicOrderingAcquire = 4
    LLVMAtomicOrderingRelease = 5
    LLVMAtomicOrderingAcquireRelease = 6
    LLVMAtomicOrderingSequentiallyConsistent = 7
end

@cenum LLVMAtomicRMWBinOp::UInt32 begin
    LLVMAtomicRMWBinOpXchg = 0
    LLVMAtomicRMWBinOpAdd = 1
    LLVMAtomicRMWBinOpSub = 2
    LLVMAtomicRMWBinOpAnd = 3
    LLVMAtomicRMWBinOpNand = 4
    LLVMAtomicRMWBinOpOr = 5
    LLVMAtomicRMWBinOpXor = 6
    LLVMAtomicRMWBinOpMax = 7
    LLVMAtomicRMWBinOpMin = 8
    LLVMAtomicRMWBinOpUMax = 9
    LLVMAtomicRMWBinOpUMin = 10
    LLVMAtomicRMWBinOpFAdd = 11
    LLVMAtomicRMWBinOpFSub = 12
end

@cenum LLVMDiagnosticSeverity::UInt32 begin
    LLVMDSError = 0
    LLVMDSWarning = 1
    LLVMDSRemark = 2
    LLVMDSNote = 3
end

@cenum LLVMInlineAsmDialect::UInt32 begin
    LLVMInlineAsmDialectATT = 0
    LLVMInlineAsmDialectIntel = 1
end

@cenum LLVMModuleFlagBehavior::UInt32 begin
    LLVMModuleFlagBehaviorError = 0
    LLVMModuleFlagBehaviorWarning = 1
    LLVMModuleFlagBehaviorRequire = 2
    LLVMModuleFlagBehaviorOverride = 3
    LLVMModuleFlagBehaviorAppend = 4
    LLVMModuleFlagBehaviorAppendUnique = 5
end

@cenum __JL_Ctag_20::Int32 begin
    LLVMAttributeReturnIndex = 0
    LLVMAttributeFunctionIndex = -1
end

const LLVMAttributeIndex = Cuint

mutable struct LLVMOpaquePassRegistry end

const LLVMPassRegistryRef = Ptr{LLVMOpaquePassRegistry}

function LLVMInitializeCore(R)
    @runtime_ccall (:LLVMInitializeCore, libllvm[]) Cvoid (LLVMPassRegistryRef,) R
end

function LLVMShutdown()
    @runtime_ccall (:LLVMShutdown, libllvm[]) Cvoid ()
end

function LLVMCreateMessage(Message)
    @runtime_ccall (:LLVMCreateMessage, libllvm[]) Cstring (Cstring,) Message
end

function LLVMDisposeMessage(Message)
    @runtime_ccall (:LLVMDisposeMessage, libllvm[]) Cvoid (Cstring,) Message
end

# typedef void ( * LLVMDiagnosticHandler ) ( LLVMDiagnosticInfoRef , void * )
const LLVMDiagnosticHandler = Ptr{Cvoid}

# typedef void ( * LLVMYieldCallback ) ( LLVMContextRef , void * )
const LLVMYieldCallback = Ptr{Cvoid}

function LLVMContextCreate()
    @runtime_ccall (:LLVMContextCreate, libllvm[]) LLVMContextRef ()
end

function LLVMGetGlobalContext()
    @runtime_ccall (:LLVMGetGlobalContext, libllvm[]) LLVMContextRef ()
end

function LLVMContextSetDiagnosticHandler(C, Handler, DiagnosticContext)
    @runtime_ccall (:LLVMContextSetDiagnosticHandler, libllvm[]) Cvoid (LLVMContextRef, LLVMDiagnosticHandler, Ptr{Cvoid}) C Handler DiagnosticContext
end

function LLVMContextGetDiagnosticHandler(C)
    @runtime_ccall (:LLVMContextGetDiagnosticHandler, libllvm[]) LLVMDiagnosticHandler (LLVMContextRef,) C
end

function LLVMContextGetDiagnosticContext(C)
    @runtime_ccall (:LLVMContextGetDiagnosticContext, libllvm[]) Ptr{Cvoid} (LLVMContextRef,) C
end

function LLVMContextSetYieldCallback(C, Callback, OpaqueHandle)
    @runtime_ccall (:LLVMContextSetYieldCallback, libllvm[]) Cvoid (LLVMContextRef, LLVMYieldCallback, Ptr{Cvoid}) C Callback OpaqueHandle
end

function LLVMContextShouldDiscardValueNames(C)
    @runtime_ccall (:LLVMContextShouldDiscardValueNames, libllvm[]) LLVMBool (LLVMContextRef,) C
end

function LLVMContextSetDiscardValueNames(C, Discard)
    @runtime_ccall (:LLVMContextSetDiscardValueNames, libllvm[]) Cvoid (LLVMContextRef, LLVMBool) C Discard
end

function LLVMContextDispose(C)
    @runtime_ccall (:LLVMContextDispose, libllvm[]) Cvoid (LLVMContextRef,) C
end

mutable struct LLVMOpaqueDiagnosticInfo end

const LLVMDiagnosticInfoRef = Ptr{LLVMOpaqueDiagnosticInfo}

function LLVMGetDiagInfoDescription(DI)
    @runtime_ccall (:LLVMGetDiagInfoDescription, libllvm[]) Cstring (LLVMDiagnosticInfoRef,) DI
end

function LLVMGetDiagInfoSeverity(DI)
    @runtime_ccall (:LLVMGetDiagInfoSeverity, libllvm[]) LLVMDiagnosticSeverity (LLVMDiagnosticInfoRef,) DI
end

function LLVMGetMDKindIDInContext(C, Name, SLen)
    @runtime_ccall (:LLVMGetMDKindIDInContext, libllvm[]) Cuint (LLVMContextRef, Cstring, Cuint) C Name SLen
end

function LLVMGetMDKindID(Name, SLen)
    @runtime_ccall (:LLVMGetMDKindID, libllvm[]) Cuint (Cstring, Cuint) Name SLen
end

function LLVMGetEnumAttributeKindForName(Name, SLen)
    @runtime_ccall (:LLVMGetEnumAttributeKindForName, libllvm[]) Cuint (Cstring, Csize_t) Name SLen
end

function LLVMGetLastEnumAttributeKind()
    @runtime_ccall (:LLVMGetLastEnumAttributeKind, libllvm[]) Cuint ()
end

mutable struct LLVMOpaqueAttributeRef end

const LLVMAttributeRef = Ptr{LLVMOpaqueAttributeRef}

function LLVMCreateEnumAttribute(C, KindID, Val)
    @runtime_ccall (:LLVMCreateEnumAttribute, libllvm[]) LLVMAttributeRef (LLVMContextRef, Cuint, UInt64) C KindID Val
end

function LLVMGetEnumAttributeKind(A)
    @runtime_ccall (:LLVMGetEnumAttributeKind, libllvm[]) Cuint (LLVMAttributeRef,) A
end

function LLVMGetEnumAttributeValue(A)
    @runtime_ccall (:LLVMGetEnumAttributeValue, libllvm[]) UInt64 (LLVMAttributeRef,) A
end

function LLVMCreateStringAttribute(C, K, KLength, V, VLength)
    @runtime_ccall (:LLVMCreateStringAttribute, libllvm[]) LLVMAttributeRef (LLVMContextRef, Cstring, Cuint, Cstring, Cuint) C K KLength V VLength
end

function LLVMGetStringAttributeKind(A, Length)
    @runtime_ccall (:LLVMGetStringAttributeKind, libllvm[]) Cstring (LLVMAttributeRef, Ptr{Cuint}) A Length
end

function LLVMGetStringAttributeValue(A, Length)
    @runtime_ccall (:LLVMGetStringAttributeValue, libllvm[]) Cstring (LLVMAttributeRef, Ptr{Cuint}) A Length
end

function LLVMIsEnumAttribute(A)
    @runtime_ccall (:LLVMIsEnumAttribute, libllvm[]) LLVMBool (LLVMAttributeRef,) A
end

function LLVMIsStringAttribute(A)
    @runtime_ccall (:LLVMIsStringAttribute, libllvm[]) LLVMBool (LLVMAttributeRef,) A
end

function LLVMModuleCreateWithName(ModuleID)
    @runtime_ccall (:LLVMModuleCreateWithName, libllvm[]) LLVMModuleRef (Cstring,) ModuleID
end

function LLVMModuleCreateWithNameInContext(ModuleID, C)
    @runtime_ccall (:LLVMModuleCreateWithNameInContext, libllvm[]) LLVMModuleRef (Cstring, LLVMContextRef) ModuleID C
end

function LLVMCloneModule(M)
    @runtime_ccall (:LLVMCloneModule, libllvm[]) LLVMModuleRef (LLVMModuleRef,) M
end

function LLVMDisposeModule(M)
    @runtime_ccall (:LLVMDisposeModule, libllvm[]) Cvoid (LLVMModuleRef,) M
end

function LLVMGetModuleIdentifier(M, Len)
    @runtime_ccall (:LLVMGetModuleIdentifier, libllvm[]) Cstring (LLVMModuleRef, Ptr{Csize_t}) M Len
end

function LLVMSetModuleIdentifier(M, Ident, Len)
    @runtime_ccall (:LLVMSetModuleIdentifier, libllvm[]) Cvoid (LLVMModuleRef, Cstring, Csize_t) M Ident Len
end

function LLVMGetSourceFileName(M, Len)
    @runtime_ccall (:LLVMGetSourceFileName, libllvm[]) Cstring (LLVMModuleRef, Ptr{Csize_t}) M Len
end

function LLVMSetSourceFileName(M, Name, Len)
    @runtime_ccall (:LLVMSetSourceFileName, libllvm[]) Cvoid (LLVMModuleRef, Cstring, Csize_t) M Name Len
end

function LLVMGetDataLayoutStr(M)
    @runtime_ccall (:LLVMGetDataLayoutStr, libllvm[]) Cstring (LLVMModuleRef,) M
end

function LLVMGetDataLayout(M)
    @runtime_ccall (:LLVMGetDataLayout, libllvm[]) Cstring (LLVMModuleRef,) M
end

function LLVMSetDataLayout(M, DataLayoutStr)
    @runtime_ccall (:LLVMSetDataLayout, libllvm[]) Cvoid (LLVMModuleRef, Cstring) M DataLayoutStr
end

function LLVMGetTarget(M)
    @runtime_ccall (:LLVMGetTarget, libllvm[]) Cstring (LLVMModuleRef,) M
end

function LLVMSetTarget(M, Triple)
    @runtime_ccall (:LLVMSetTarget, libllvm[]) Cvoid (LLVMModuleRef, Cstring) M Triple
end

mutable struct LLVMOpaqueModuleFlagEntry end

const LLVMModuleFlagEntry = LLVMOpaqueModuleFlagEntry

function LLVMCopyModuleFlagsMetadata(M, Len)
    @runtime_ccall (:LLVMCopyModuleFlagsMetadata, libllvm[]) Ptr{LLVMModuleFlagEntry} (LLVMModuleRef, Ptr{Csize_t}) M Len
end

function LLVMDisposeModuleFlagsMetadata(Entries)
    @runtime_ccall (:LLVMDisposeModuleFlagsMetadata, libllvm[]) Cvoid (Ptr{LLVMModuleFlagEntry},) Entries
end

function LLVMModuleFlagEntriesGetFlagBehavior(Entries, Index)
    @runtime_ccall (:LLVMModuleFlagEntriesGetFlagBehavior, libllvm[]) LLVMModuleFlagBehavior (Ptr{LLVMModuleFlagEntry}, Cuint) Entries Index
end

function LLVMModuleFlagEntriesGetKey(Entries, Index, Len)
    @runtime_ccall (:LLVMModuleFlagEntriesGetKey, libllvm[]) Cstring (Ptr{LLVMModuleFlagEntry}, Cuint, Ptr{Csize_t}) Entries Index Len
end

mutable struct LLVMOpaqueMetadata end

const LLVMMetadataRef = Ptr{LLVMOpaqueMetadata}

function LLVMModuleFlagEntriesGetMetadata(Entries, Index)
    @runtime_ccall (:LLVMModuleFlagEntriesGetMetadata, libllvm[]) LLVMMetadataRef (Ptr{LLVMModuleFlagEntry}, Cuint) Entries Index
end

function LLVMGetModuleFlag(M, Key, KeyLen)
    @runtime_ccall (:LLVMGetModuleFlag, libllvm[]) LLVMMetadataRef (LLVMModuleRef, Cstring, Csize_t) M Key KeyLen
end

function LLVMAddModuleFlag(M, Behavior, Key, KeyLen, Val)
    @runtime_ccall (:LLVMAddModuleFlag, libllvm[]) Cvoid (LLVMModuleRef, LLVMModuleFlagBehavior, Cstring, Csize_t, LLVMMetadataRef) M Behavior Key KeyLen Val
end

function LLVMDumpModule(M)
    @runtime_ccall (:LLVMDumpModule, libllvm[]) Cvoid (LLVMModuleRef,) M
end

function LLVMPrintModuleToFile(M, Filename, ErrorMessage)
    @runtime_ccall (:LLVMPrintModuleToFile, libllvm[]) LLVMBool (LLVMModuleRef, Cstring, Ptr{Cstring}) M Filename ErrorMessage
end

function LLVMPrintModuleToString(M)
    @runtime_ccall (:LLVMPrintModuleToString, libllvm[]) Cstring (LLVMModuleRef,) M
end

function LLVMGetModuleInlineAsm(M, Len)
    @runtime_ccall (:LLVMGetModuleInlineAsm, libllvm[]) Cstring (LLVMModuleRef, Ptr{Csize_t}) M Len
end

function LLVMSetModuleInlineAsm2(M, Asm, Len)
    @runtime_ccall (:LLVMSetModuleInlineAsm2, libllvm[]) Cvoid (LLVMModuleRef, Cstring, Csize_t) M Asm Len
end

function LLVMAppendModuleInlineAsm(M, Asm, Len)
    @runtime_ccall (:LLVMAppendModuleInlineAsm, libllvm[]) Cvoid (LLVMModuleRef, Cstring, Csize_t) M Asm Len
end

mutable struct LLVMOpaqueType end

const LLVMTypeRef = Ptr{LLVMOpaqueType}

function LLVMGetInlineAsm(Ty, AsmString, AsmStringSize, Constraints, ConstraintsSize, HasSideEffects, IsAlignStack, Dialect)
    @runtime_ccall (:LLVMGetInlineAsm, libllvm[]) LLVMValueRef (LLVMTypeRef, Cstring, Csize_t, Cstring, Csize_t, LLVMBool, LLVMBool, LLVMInlineAsmDialect) Ty AsmString AsmStringSize Constraints ConstraintsSize HasSideEffects IsAlignStack Dialect
end

function LLVMGetModuleContext(M)
    @runtime_ccall (:LLVMGetModuleContext, libllvm[]) LLVMContextRef (LLVMModuleRef,) M
end

function LLVMGetTypeByName(M, Name)
    @runtime_ccall (:LLVMGetTypeByName, libllvm[]) LLVMTypeRef (LLVMModuleRef, Cstring) M Name
end

mutable struct LLVMOpaqueNamedMDNode end

const LLVMNamedMDNodeRef = Ptr{LLVMOpaqueNamedMDNode}

function LLVMGetFirstNamedMetadata(M)
    @runtime_ccall (:LLVMGetFirstNamedMetadata, libllvm[]) LLVMNamedMDNodeRef (LLVMModuleRef,) M
end

function LLVMGetLastNamedMetadata(M)
    @runtime_ccall (:LLVMGetLastNamedMetadata, libllvm[]) LLVMNamedMDNodeRef (LLVMModuleRef,) M
end

function LLVMGetNextNamedMetadata(NamedMDNode)
    @runtime_ccall (:LLVMGetNextNamedMetadata, libllvm[]) LLVMNamedMDNodeRef (LLVMNamedMDNodeRef,) NamedMDNode
end

function LLVMGetPreviousNamedMetadata(NamedMDNode)
    @runtime_ccall (:LLVMGetPreviousNamedMetadata, libllvm[]) LLVMNamedMDNodeRef (LLVMNamedMDNodeRef,) NamedMDNode
end

function LLVMGetNamedMetadata(M, Name, NameLen)
    @runtime_ccall (:LLVMGetNamedMetadata, libllvm[]) LLVMNamedMDNodeRef (LLVMModuleRef, Cstring, Csize_t) M Name NameLen
end

function LLVMGetOrInsertNamedMetadata(M, Name, NameLen)
    @runtime_ccall (:LLVMGetOrInsertNamedMetadata, libllvm[]) LLVMNamedMDNodeRef (LLVMModuleRef, Cstring, Csize_t) M Name NameLen
end

function LLVMGetNamedMetadataName(NamedMD, NameLen)
    @runtime_ccall (:LLVMGetNamedMetadataName, libllvm[]) Cstring (LLVMNamedMDNodeRef, Ptr{Csize_t}) NamedMD NameLen
end

function LLVMGetNamedMetadataNumOperands(M, Name)
    @runtime_ccall (:LLVMGetNamedMetadataNumOperands, libllvm[]) Cuint (LLVMModuleRef, Cstring) M Name
end

function LLVMGetNamedMetadataOperands(M, Name, Dest)
    @runtime_ccall (:LLVMGetNamedMetadataOperands, libllvm[]) Cvoid (LLVMModuleRef, Cstring, Ptr{LLVMValueRef}) M Name Dest
end

function LLVMAddNamedMetadataOperand(M, Name, Val)
    @runtime_ccall (:LLVMAddNamedMetadataOperand, libllvm[]) Cvoid (LLVMModuleRef, Cstring, LLVMValueRef) M Name Val
end

function LLVMGetDebugLocDirectory(Val, Length)
    @runtime_ccall (:LLVMGetDebugLocDirectory, libllvm[]) Cstring (LLVMValueRef, Ptr{Cuint}) Val Length
end

function LLVMGetDebugLocFilename(Val, Length)
    @runtime_ccall (:LLVMGetDebugLocFilename, libllvm[]) Cstring (LLVMValueRef, Ptr{Cuint}) Val Length
end

function LLVMGetDebugLocLine(Val)
    @runtime_ccall (:LLVMGetDebugLocLine, libllvm[]) Cuint (LLVMValueRef,) Val
end

function LLVMGetDebugLocColumn(Val)
    @runtime_ccall (:LLVMGetDebugLocColumn, libllvm[]) Cuint (LLVMValueRef,) Val
end

function LLVMAddFunction(M, Name, FunctionTy)
    @runtime_ccall (:LLVMAddFunction, libllvm[]) LLVMValueRef (LLVMModuleRef, Cstring, LLVMTypeRef) M Name FunctionTy
end

function LLVMGetNamedFunction(M, Name)
    @runtime_ccall (:LLVMGetNamedFunction, libllvm[]) LLVMValueRef (LLVMModuleRef, Cstring) M Name
end

function LLVMGetFirstFunction(M)
    @runtime_ccall (:LLVMGetFirstFunction, libllvm[]) LLVMValueRef (LLVMModuleRef,) M
end

function LLVMGetLastFunction(M)
    @runtime_ccall (:LLVMGetLastFunction, libllvm[]) LLVMValueRef (LLVMModuleRef,) M
end

function LLVMGetNextFunction(Fn)
    @runtime_ccall (:LLVMGetNextFunction, libllvm[]) LLVMValueRef (LLVMValueRef,) Fn
end

function LLVMGetPreviousFunction(Fn)
    @runtime_ccall (:LLVMGetPreviousFunction, libllvm[]) LLVMValueRef (LLVMValueRef,) Fn
end

function LLVMSetModuleInlineAsm(M, Asm)
    @runtime_ccall (:LLVMSetModuleInlineAsm, libllvm[]) Cvoid (LLVMModuleRef, Cstring) M Asm
end

function LLVMGetTypeKind(Ty)
    @runtime_ccall (:LLVMGetTypeKind, libllvm[]) LLVMTypeKind (LLVMTypeRef,) Ty
end

function LLVMTypeIsSized(Ty)
    @runtime_ccall (:LLVMTypeIsSized, libllvm[]) LLVMBool (LLVMTypeRef,) Ty
end

function LLVMGetTypeContext(Ty)
    @runtime_ccall (:LLVMGetTypeContext, libllvm[]) LLVMContextRef (LLVMTypeRef,) Ty
end

function LLVMDumpType(Val)
    @runtime_ccall (:LLVMDumpType, libllvm[]) Cvoid (LLVMTypeRef,) Val
end

function LLVMPrintTypeToString(Val)
    @runtime_ccall (:LLVMPrintTypeToString, libllvm[]) Cstring (LLVMTypeRef,) Val
end

function LLVMInt1TypeInContext(C)
    @runtime_ccall (:LLVMInt1TypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMInt8TypeInContext(C)
    @runtime_ccall (:LLVMInt8TypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMInt16TypeInContext(C)
    @runtime_ccall (:LLVMInt16TypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMInt32TypeInContext(C)
    @runtime_ccall (:LLVMInt32TypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMInt64TypeInContext(C)
    @runtime_ccall (:LLVMInt64TypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMInt128TypeInContext(C)
    @runtime_ccall (:LLVMInt128TypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMIntTypeInContext(C, NumBits)
    @runtime_ccall (:LLVMIntTypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef, Cuint) C NumBits
end

function LLVMInt1Type()
    @runtime_ccall (:LLVMInt1Type, libllvm[]) LLVMTypeRef ()
end

function LLVMInt8Type()
    @runtime_ccall (:LLVMInt8Type, libllvm[]) LLVMTypeRef ()
end

function LLVMInt16Type()
    @runtime_ccall (:LLVMInt16Type, libllvm[]) LLVMTypeRef ()
end

function LLVMInt32Type()
    @runtime_ccall (:LLVMInt32Type, libllvm[]) LLVMTypeRef ()
end

function LLVMInt64Type()
    @runtime_ccall (:LLVMInt64Type, libllvm[]) LLVMTypeRef ()
end

function LLVMInt128Type()
    @runtime_ccall (:LLVMInt128Type, libllvm[]) LLVMTypeRef ()
end

function LLVMIntType(NumBits)
    @runtime_ccall (:LLVMIntType, libllvm[]) LLVMTypeRef (Cuint,) NumBits
end

function LLVMGetIntTypeWidth(IntegerTy)
    @runtime_ccall (:LLVMGetIntTypeWidth, libllvm[]) Cuint (LLVMTypeRef,) IntegerTy
end

function LLVMHalfTypeInContext(C)
    @runtime_ccall (:LLVMHalfTypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMBFloatTypeInContext(C)
    @runtime_ccall (:LLVMBFloatTypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMFloatTypeInContext(C)
    @runtime_ccall (:LLVMFloatTypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMDoubleTypeInContext(C)
    @runtime_ccall (:LLVMDoubleTypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMX86FP80TypeInContext(C)
    @runtime_ccall (:LLVMX86FP80TypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMFP128TypeInContext(C)
    @runtime_ccall (:LLVMFP128TypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMPPCFP128TypeInContext(C)
    @runtime_ccall (:LLVMPPCFP128TypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMHalfType()
    @runtime_ccall (:LLVMHalfType, libllvm[]) LLVMTypeRef ()
end

function LLVMBFloatType()
    @runtime_ccall (:LLVMBFloatType, libllvm[]) LLVMTypeRef ()
end

function LLVMFloatType()
    @runtime_ccall (:LLVMFloatType, libllvm[]) LLVMTypeRef ()
end

function LLVMDoubleType()
    @runtime_ccall (:LLVMDoubleType, libllvm[]) LLVMTypeRef ()
end

function LLVMX86FP80Type()
    @runtime_ccall (:LLVMX86FP80Type, libllvm[]) LLVMTypeRef ()
end

function LLVMFP128Type()
    @runtime_ccall (:LLVMFP128Type, libllvm[]) LLVMTypeRef ()
end

function LLVMPPCFP128Type()
    @runtime_ccall (:LLVMPPCFP128Type, libllvm[]) LLVMTypeRef ()
end

function LLVMFunctionType(ReturnType, ParamTypes, ParamCount, IsVarArg)
    @runtime_ccall (:LLVMFunctionType, libllvm[]) LLVMTypeRef (LLVMTypeRef, Ptr{LLVMTypeRef}, Cuint, LLVMBool) ReturnType ParamTypes ParamCount IsVarArg
end

function LLVMIsFunctionVarArg(FunctionTy)
    @runtime_ccall (:LLVMIsFunctionVarArg, libllvm[]) LLVMBool (LLVMTypeRef,) FunctionTy
end

function LLVMGetReturnType(FunctionTy)
    @runtime_ccall (:LLVMGetReturnType, libllvm[]) LLVMTypeRef (LLVMTypeRef,) FunctionTy
end

function LLVMCountParamTypes(FunctionTy)
    @runtime_ccall (:LLVMCountParamTypes, libllvm[]) Cuint (LLVMTypeRef,) FunctionTy
end

function LLVMGetParamTypes(FunctionTy, Dest)
    @runtime_ccall (:LLVMGetParamTypes, libllvm[]) Cvoid (LLVMTypeRef, Ptr{LLVMTypeRef}) FunctionTy Dest
end

function LLVMStructTypeInContext(C, ElementTypes, ElementCount, Packed)
    @runtime_ccall (:LLVMStructTypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef, Ptr{LLVMTypeRef}, Cuint, LLVMBool) C ElementTypes ElementCount Packed
end

function LLVMStructType(ElementTypes, ElementCount, Packed)
    @runtime_ccall (:LLVMStructType, libllvm[]) LLVMTypeRef (Ptr{LLVMTypeRef}, Cuint, LLVMBool) ElementTypes ElementCount Packed
end

function LLVMStructCreateNamed(C, Name)
    @runtime_ccall (:LLVMStructCreateNamed, libllvm[]) LLVMTypeRef (LLVMContextRef, Cstring) C Name
end

function LLVMGetStructName(Ty)
    @runtime_ccall (:LLVMGetStructName, libllvm[]) Cstring (LLVMTypeRef,) Ty
end

function LLVMStructSetBody(StructTy, ElementTypes, ElementCount, Packed)
    @runtime_ccall (:LLVMStructSetBody, libllvm[]) Cvoid (LLVMTypeRef, Ptr{LLVMTypeRef}, Cuint, LLVMBool) StructTy ElementTypes ElementCount Packed
end

function LLVMCountStructElementTypes(StructTy)
    @runtime_ccall (:LLVMCountStructElementTypes, libllvm[]) Cuint (LLVMTypeRef,) StructTy
end

function LLVMGetStructElementTypes(StructTy, Dest)
    @runtime_ccall (:LLVMGetStructElementTypes, libllvm[]) Cvoid (LLVMTypeRef, Ptr{LLVMTypeRef}) StructTy Dest
end

function LLVMStructGetTypeAtIndex(StructTy, i)
    @runtime_ccall (:LLVMStructGetTypeAtIndex, libllvm[]) LLVMTypeRef (LLVMTypeRef, Cuint) StructTy i
end

function LLVMIsPackedStruct(StructTy)
    @runtime_ccall (:LLVMIsPackedStruct, libllvm[]) LLVMBool (LLVMTypeRef,) StructTy
end

function LLVMIsOpaqueStruct(StructTy)
    @runtime_ccall (:LLVMIsOpaqueStruct, libllvm[]) LLVMBool (LLVMTypeRef,) StructTy
end

function LLVMIsLiteralStruct(StructTy)
    @runtime_ccall (:LLVMIsLiteralStruct, libllvm[]) LLVMBool (LLVMTypeRef,) StructTy
end

function LLVMGetElementType(Ty)
    @runtime_ccall (:LLVMGetElementType, libllvm[]) LLVMTypeRef (LLVMTypeRef,) Ty
end

function LLVMGetSubtypes(Tp, Arr)
    @runtime_ccall (:LLVMGetSubtypes, libllvm[]) Cvoid (LLVMTypeRef, Ptr{LLVMTypeRef}) Tp Arr
end

function LLVMGetNumContainedTypes(Tp)
    @runtime_ccall (:LLVMGetNumContainedTypes, libllvm[]) Cuint (LLVMTypeRef,) Tp
end

function LLVMArrayType(ElementType, ElementCount)
    @runtime_ccall (:LLVMArrayType, libllvm[]) LLVMTypeRef (LLVMTypeRef, Cuint) ElementType ElementCount
end

function LLVMGetArrayLength(ArrayTy)
    @runtime_ccall (:LLVMGetArrayLength, libllvm[]) Cuint (LLVMTypeRef,) ArrayTy
end

function LLVMPointerType(ElementType, AddressSpace)
    @runtime_ccall (:LLVMPointerType, libllvm[]) LLVMTypeRef (LLVMTypeRef, Cuint) ElementType AddressSpace
end

function LLVMGetPointerAddressSpace(PointerTy)
    @runtime_ccall (:LLVMGetPointerAddressSpace, libllvm[]) Cuint (LLVMTypeRef,) PointerTy
end

function LLVMVectorType(ElementType, ElementCount)
    @runtime_ccall (:LLVMVectorType, libllvm[]) LLVMTypeRef (LLVMTypeRef, Cuint) ElementType ElementCount
end

function LLVMGetVectorSize(VectorTy)
    @runtime_ccall (:LLVMGetVectorSize, libllvm[]) Cuint (LLVMTypeRef,) VectorTy
end

function LLVMVoidTypeInContext(C)
    @runtime_ccall (:LLVMVoidTypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMLabelTypeInContext(C)
    @runtime_ccall (:LLVMLabelTypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMX86MMXTypeInContext(C)
    @runtime_ccall (:LLVMX86MMXTypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMTokenTypeInContext(C)
    @runtime_ccall (:LLVMTokenTypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMMetadataTypeInContext(C)
    @runtime_ccall (:LLVMMetadataTypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef,) C
end

function LLVMVoidType()
    @runtime_ccall (:LLVMVoidType, libllvm[]) LLVMTypeRef ()
end

function LLVMLabelType()
    @runtime_ccall (:LLVMLabelType, libllvm[]) LLVMTypeRef ()
end

function LLVMX86MMXType()
    @runtime_ccall (:LLVMX86MMXType, libllvm[]) LLVMTypeRef ()
end

function LLVMTypeOf(Val)
    @runtime_ccall (:LLVMTypeOf, libllvm[]) LLVMTypeRef (LLVMValueRef,) Val
end

function LLVMGetValueKind(Val)
    @runtime_ccall (:LLVMGetValueKind, libllvm[]) LLVMValueKind (LLVMValueRef,) Val
end

function LLVMGetValueName2(Val, Length)
    @runtime_ccall (:LLVMGetValueName2, libllvm[]) Cstring (LLVMValueRef, Ptr{Csize_t}) Val Length
end

function LLVMSetValueName2(Val, Name, NameLen)
    @runtime_ccall (:LLVMSetValueName2, libllvm[]) Cvoid (LLVMValueRef, Cstring, Csize_t) Val Name NameLen
end

function LLVMDumpValue(Val)
    @runtime_ccall (:LLVMDumpValue, libllvm[]) Cvoid (LLVMValueRef,) Val
end

function LLVMPrintValueToString(Val)
    @runtime_ccall (:LLVMPrintValueToString, libllvm[]) Cstring (LLVMValueRef,) Val
end

function LLVMReplaceAllUsesWith(OldVal, NewVal)
    @runtime_ccall (:LLVMReplaceAllUsesWith, libllvm[]) Cvoid (LLVMValueRef, LLVMValueRef) OldVal NewVal
end

function LLVMIsConstant(Val)
    @runtime_ccall (:LLVMIsConstant, libllvm[]) LLVMBool (LLVMValueRef,) Val
end

function LLVMIsUndef(Val)
    @runtime_ccall (:LLVMIsUndef, libllvm[]) LLVMBool (LLVMValueRef,) Val
end

function LLVMIsAArgument(Val)
    @runtime_ccall (:LLVMIsAArgument, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsABasicBlock(Val)
    @runtime_ccall (:LLVMIsABasicBlock, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAInlineAsm(Val)
    @runtime_ccall (:LLVMIsAInlineAsm, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAUser(Val)
    @runtime_ccall (:LLVMIsAUser, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAConstant(Val)
    @runtime_ccall (:LLVMIsAConstant, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsABlockAddress(Val)
    @runtime_ccall (:LLVMIsABlockAddress, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAConstantAggregateZero(Val)
    @runtime_ccall (:LLVMIsAConstantAggregateZero, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAConstantArray(Val)
    @runtime_ccall (:LLVMIsAConstantArray, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAConstantDataSequential(Val)
    @runtime_ccall (:LLVMIsAConstantDataSequential, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAConstantDataArray(Val)
    @runtime_ccall (:LLVMIsAConstantDataArray, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAConstantDataVector(Val)
    @runtime_ccall (:LLVMIsAConstantDataVector, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAConstantExpr(Val)
    @runtime_ccall (:LLVMIsAConstantExpr, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAConstantFP(Val)
    @runtime_ccall (:LLVMIsAConstantFP, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAConstantInt(Val)
    @runtime_ccall (:LLVMIsAConstantInt, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAConstantPointerNull(Val)
    @runtime_ccall (:LLVMIsAConstantPointerNull, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAConstantStruct(Val)
    @runtime_ccall (:LLVMIsAConstantStruct, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAConstantTokenNone(Val)
    @runtime_ccall (:LLVMIsAConstantTokenNone, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAConstantVector(Val)
    @runtime_ccall (:LLVMIsAConstantVector, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAGlobalValue(Val)
    @runtime_ccall (:LLVMIsAGlobalValue, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAGlobalAlias(Val)
    @runtime_ccall (:LLVMIsAGlobalAlias, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAGlobalIFunc(Val)
    @runtime_ccall (:LLVMIsAGlobalIFunc, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAGlobalObject(Val)
    @runtime_ccall (:LLVMIsAGlobalObject, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAFunction(Val)
    @runtime_ccall (:LLVMIsAFunction, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAGlobalVariable(Val)
    @runtime_ccall (:LLVMIsAGlobalVariable, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAUndefValue(Val)
    @runtime_ccall (:LLVMIsAUndefValue, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAInstruction(Val)
    @runtime_ccall (:LLVMIsAInstruction, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAUnaryOperator(Val)
    @runtime_ccall (:LLVMIsAUnaryOperator, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsABinaryOperator(Val)
    @runtime_ccall (:LLVMIsABinaryOperator, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsACallInst(Val)
    @runtime_ccall (:LLVMIsACallInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAIntrinsicInst(Val)
    @runtime_ccall (:LLVMIsAIntrinsicInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsADbgInfoIntrinsic(Val)
    @runtime_ccall (:LLVMIsADbgInfoIntrinsic, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsADbgVariableIntrinsic(Val)
    @runtime_ccall (:LLVMIsADbgVariableIntrinsic, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsADbgDeclareInst(Val)
    @runtime_ccall (:LLVMIsADbgDeclareInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsADbgLabelInst(Val)
    @runtime_ccall (:LLVMIsADbgLabelInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAMemIntrinsic(Val)
    @runtime_ccall (:LLVMIsAMemIntrinsic, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAMemCpyInst(Val)
    @runtime_ccall (:LLVMIsAMemCpyInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAMemMoveInst(Val)
    @runtime_ccall (:LLVMIsAMemMoveInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAMemSetInst(Val)
    @runtime_ccall (:LLVMIsAMemSetInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsACmpInst(Val)
    @runtime_ccall (:LLVMIsACmpInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAFCmpInst(Val)
    @runtime_ccall (:LLVMIsAFCmpInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAICmpInst(Val)
    @runtime_ccall (:LLVMIsAICmpInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAExtractElementInst(Val)
    @runtime_ccall (:LLVMIsAExtractElementInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAGetElementPtrInst(Val)
    @runtime_ccall (:LLVMIsAGetElementPtrInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAInsertElementInst(Val)
    @runtime_ccall (:LLVMIsAInsertElementInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAInsertValueInst(Val)
    @runtime_ccall (:LLVMIsAInsertValueInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsALandingPadInst(Val)
    @runtime_ccall (:LLVMIsALandingPadInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAPHINode(Val)
    @runtime_ccall (:LLVMIsAPHINode, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsASelectInst(Val)
    @runtime_ccall (:LLVMIsASelectInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAShuffleVectorInst(Val)
    @runtime_ccall (:LLVMIsAShuffleVectorInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAStoreInst(Val)
    @runtime_ccall (:LLVMIsAStoreInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsABranchInst(Val)
    @runtime_ccall (:LLVMIsABranchInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAIndirectBrInst(Val)
    @runtime_ccall (:LLVMIsAIndirectBrInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAInvokeInst(Val)
    @runtime_ccall (:LLVMIsAInvokeInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAReturnInst(Val)
    @runtime_ccall (:LLVMIsAReturnInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsASwitchInst(Val)
    @runtime_ccall (:LLVMIsASwitchInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAUnreachableInst(Val)
    @runtime_ccall (:LLVMIsAUnreachableInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAResumeInst(Val)
    @runtime_ccall (:LLVMIsAResumeInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsACleanupReturnInst(Val)
    @runtime_ccall (:LLVMIsACleanupReturnInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsACatchReturnInst(Val)
    @runtime_ccall (:LLVMIsACatchReturnInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsACatchSwitchInst(Val)
    @runtime_ccall (:LLVMIsACatchSwitchInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsACallBrInst(Val)
    @runtime_ccall (:LLVMIsACallBrInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAFuncletPadInst(Val)
    @runtime_ccall (:LLVMIsAFuncletPadInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsACatchPadInst(Val)
    @runtime_ccall (:LLVMIsACatchPadInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsACleanupPadInst(Val)
    @runtime_ccall (:LLVMIsACleanupPadInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAUnaryInstruction(Val)
    @runtime_ccall (:LLVMIsAUnaryInstruction, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAAllocaInst(Val)
    @runtime_ccall (:LLVMIsAAllocaInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsACastInst(Val)
    @runtime_ccall (:LLVMIsACastInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAAddrSpaceCastInst(Val)
    @runtime_ccall (:LLVMIsAAddrSpaceCastInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsABitCastInst(Val)
    @runtime_ccall (:LLVMIsABitCastInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAFPExtInst(Val)
    @runtime_ccall (:LLVMIsAFPExtInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAFPToSIInst(Val)
    @runtime_ccall (:LLVMIsAFPToSIInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAFPToUIInst(Val)
    @runtime_ccall (:LLVMIsAFPToUIInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAFPTruncInst(Val)
    @runtime_ccall (:LLVMIsAFPTruncInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAIntToPtrInst(Val)
    @runtime_ccall (:LLVMIsAIntToPtrInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAPtrToIntInst(Val)
    @runtime_ccall (:LLVMIsAPtrToIntInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsASExtInst(Val)
    @runtime_ccall (:LLVMIsASExtInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsASIToFPInst(Val)
    @runtime_ccall (:LLVMIsASIToFPInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsATruncInst(Val)
    @runtime_ccall (:LLVMIsATruncInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAUIToFPInst(Val)
    @runtime_ccall (:LLVMIsAUIToFPInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAZExtInst(Val)
    @runtime_ccall (:LLVMIsAZExtInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAExtractValueInst(Val)
    @runtime_ccall (:LLVMIsAExtractValueInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsALoadInst(Val)
    @runtime_ccall (:LLVMIsALoadInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAVAArgInst(Val)
    @runtime_ccall (:LLVMIsAVAArgInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAFreezeInst(Val)
    @runtime_ccall (:LLVMIsAFreezeInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAAtomicCmpXchgInst(Val)
    @runtime_ccall (:LLVMIsAAtomicCmpXchgInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAAtomicRMWInst(Val)
    @runtime_ccall (:LLVMIsAAtomicRMWInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAFenceInst(Val)
    @runtime_ccall (:LLVMIsAFenceInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAMDNode(Val)
    @runtime_ccall (:LLVMIsAMDNode, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMIsAMDString(Val)
    @runtime_ccall (:LLVMIsAMDString, libllvm[]) LLVMValueRef (LLVMValueRef,) Val
end

function LLVMGetValueName(Val)
    @runtime_ccall (:LLVMGetValueName, libllvm[]) Cstring (LLVMValueRef,) Val
end

function LLVMSetValueName(Val, Name)
    @runtime_ccall (:LLVMSetValueName, libllvm[]) Cvoid (LLVMValueRef, Cstring) Val Name
end

mutable struct LLVMOpaqueUse end

const LLVMUseRef = Ptr{LLVMOpaqueUse}

function LLVMGetFirstUse(Val)
    @runtime_ccall (:LLVMGetFirstUse, libllvm[]) LLVMUseRef (LLVMValueRef,) Val
end

function LLVMGetNextUse(U)
    @runtime_ccall (:LLVMGetNextUse, libllvm[]) LLVMUseRef (LLVMUseRef,) U
end

function LLVMGetUser(U)
    @runtime_ccall (:LLVMGetUser, libllvm[]) LLVMValueRef (LLVMUseRef,) U
end

function LLVMGetUsedValue(U)
    @runtime_ccall (:LLVMGetUsedValue, libllvm[]) LLVMValueRef (LLVMUseRef,) U
end

function LLVMGetOperand(Val, Index)
    @runtime_ccall (:LLVMGetOperand, libllvm[]) LLVMValueRef (LLVMValueRef, Cuint) Val Index
end

function LLVMGetOperandUse(Val, Index)
    @runtime_ccall (:LLVMGetOperandUse, libllvm[]) LLVMUseRef (LLVMValueRef, Cuint) Val Index
end

function LLVMSetOperand(User, Index, Val)
    @runtime_ccall (:LLVMSetOperand, libllvm[]) Cvoid (LLVMValueRef, Cuint, LLVMValueRef) User Index Val
end

function LLVMGetNumOperands(Val)
    @runtime_ccall (:LLVMGetNumOperands, libllvm[]) Cint (LLVMValueRef,) Val
end

function LLVMConstNull(Ty)
    @runtime_ccall (:LLVMConstNull, libllvm[]) LLVMValueRef (LLVMTypeRef,) Ty
end

function LLVMConstAllOnes(Ty)
    @runtime_ccall (:LLVMConstAllOnes, libllvm[]) LLVMValueRef (LLVMTypeRef,) Ty
end

function LLVMGetUndef(Ty)
    @runtime_ccall (:LLVMGetUndef, libllvm[]) LLVMValueRef (LLVMTypeRef,) Ty
end

function LLVMIsNull(Val)
    @runtime_ccall (:LLVMIsNull, libllvm[]) LLVMBool (LLVMValueRef,) Val
end

function LLVMConstPointerNull(Ty)
    @runtime_ccall (:LLVMConstPointerNull, libllvm[]) LLVMValueRef (LLVMTypeRef,) Ty
end

function LLVMConstInt(IntTy, N, SignExtend)
    @runtime_ccall (:LLVMConstInt, libllvm[]) LLVMValueRef (LLVMTypeRef, Culonglong, LLVMBool) IntTy N SignExtend
end

function LLVMConstIntOfArbitraryPrecision(IntTy, NumWords, Words)
    @runtime_ccall (:LLVMConstIntOfArbitraryPrecision, libllvm[]) LLVMValueRef (LLVMTypeRef, Cuint, Ptr{UInt64}) IntTy NumWords Words
end

function LLVMConstIntOfString(IntTy, Text, Radix)
    @runtime_ccall (:LLVMConstIntOfString, libllvm[]) LLVMValueRef (LLVMTypeRef, Cstring, UInt8) IntTy Text Radix
end

function LLVMConstIntOfStringAndSize(IntTy, Text, SLen, Radix)
    @runtime_ccall (:LLVMConstIntOfStringAndSize, libllvm[]) LLVMValueRef (LLVMTypeRef, Cstring, Cuint, UInt8) IntTy Text SLen Radix
end

function LLVMConstReal(RealTy, N)
    @runtime_ccall (:LLVMConstReal, libllvm[]) LLVMValueRef (LLVMTypeRef, Cdouble) RealTy N
end

function LLVMConstRealOfString(RealTy, Text)
    @runtime_ccall (:LLVMConstRealOfString, libllvm[]) LLVMValueRef (LLVMTypeRef, Cstring) RealTy Text
end

function LLVMConstRealOfStringAndSize(RealTy, Text, SLen)
    @runtime_ccall (:LLVMConstRealOfStringAndSize, libllvm[]) LLVMValueRef (LLVMTypeRef, Cstring, Cuint) RealTy Text SLen
end

function LLVMConstIntGetZExtValue(ConstantVal)
    @runtime_ccall (:LLVMConstIntGetZExtValue, libllvm[]) Culonglong (LLVMValueRef,) ConstantVal
end

function LLVMConstIntGetSExtValue(ConstantVal)
    @runtime_ccall (:LLVMConstIntGetSExtValue, libllvm[]) Clonglong (LLVMValueRef,) ConstantVal
end

function LLVMConstRealGetDouble(ConstantVal, losesInfo)
    @runtime_ccall (:LLVMConstRealGetDouble, libllvm[]) Cdouble (LLVMValueRef, Ptr{LLVMBool}) ConstantVal losesInfo
end

function LLVMConstStringInContext(C, Str, Length, DontNullTerminate)
    @runtime_ccall (:LLVMConstStringInContext, libllvm[]) LLVMValueRef (LLVMContextRef, Cstring, Cuint, LLVMBool) C Str Length DontNullTerminate
end

function LLVMConstString(Str, Length, DontNullTerminate)
    @runtime_ccall (:LLVMConstString, libllvm[]) LLVMValueRef (Cstring, Cuint, LLVMBool) Str Length DontNullTerminate
end

function LLVMIsConstantString(c)
    @runtime_ccall (:LLVMIsConstantString, libllvm[]) LLVMBool (LLVMValueRef,) c
end

function LLVMGetAsString(c, Length)
    @runtime_ccall (:LLVMGetAsString, libllvm[]) Cstring (LLVMValueRef, Ptr{Csize_t}) c Length
end

function LLVMConstStructInContext(C, ConstantVals, Count, Packed)
    @runtime_ccall (:LLVMConstStructInContext, libllvm[]) LLVMValueRef (LLVMContextRef, Ptr{LLVMValueRef}, Cuint, LLVMBool) C ConstantVals Count Packed
end

function LLVMConstStruct(ConstantVals, Count, Packed)
    @runtime_ccall (:LLVMConstStruct, libllvm[]) LLVMValueRef (Ptr{LLVMValueRef}, Cuint, LLVMBool) ConstantVals Count Packed
end

function LLVMConstArray(ElementTy, ConstantVals, Length)
    @runtime_ccall (:LLVMConstArray, libllvm[]) LLVMValueRef (LLVMTypeRef, Ptr{LLVMValueRef}, Cuint) ElementTy ConstantVals Length
end

function LLVMConstNamedStruct(StructTy, ConstantVals, Count)
    @runtime_ccall (:LLVMConstNamedStruct, libllvm[]) LLVMValueRef (LLVMTypeRef, Ptr{LLVMValueRef}, Cuint) StructTy ConstantVals Count
end

function LLVMGetElementAsConstant(C, idx)
    @runtime_ccall (:LLVMGetElementAsConstant, libllvm[]) LLVMValueRef (LLVMValueRef, Cuint) C idx
end

function LLVMConstVector(ScalarConstantVals, Size)
    @runtime_ccall (:LLVMConstVector, libllvm[]) LLVMValueRef (Ptr{LLVMValueRef}, Cuint) ScalarConstantVals Size
end

function LLVMGetConstOpcode(ConstantVal)
    @runtime_ccall (:LLVMGetConstOpcode, libllvm[]) LLVMOpcode (LLVMValueRef,) ConstantVal
end

function LLVMAlignOf(Ty)
    @runtime_ccall (:LLVMAlignOf, libllvm[]) LLVMValueRef (LLVMTypeRef,) Ty
end

function LLVMSizeOf(Ty)
    @runtime_ccall (:LLVMSizeOf, libllvm[]) LLVMValueRef (LLVMTypeRef,) Ty
end

function LLVMConstNeg(ConstantVal)
    @runtime_ccall (:LLVMConstNeg, libllvm[]) LLVMValueRef (LLVMValueRef,) ConstantVal
end

function LLVMConstNSWNeg(ConstantVal)
    @runtime_ccall (:LLVMConstNSWNeg, libllvm[]) LLVMValueRef (LLVMValueRef,) ConstantVal
end

function LLVMConstNUWNeg(ConstantVal)
    @runtime_ccall (:LLVMConstNUWNeg, libllvm[]) LLVMValueRef (LLVMValueRef,) ConstantVal
end

function LLVMConstFNeg(ConstantVal)
    @runtime_ccall (:LLVMConstFNeg, libllvm[]) LLVMValueRef (LLVMValueRef,) ConstantVal
end

function LLVMConstNot(ConstantVal)
    @runtime_ccall (:LLVMConstNot, libllvm[]) LLVMValueRef (LLVMValueRef,) ConstantVal
end

function LLVMConstAdd(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstAdd, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstNSWAdd(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstNSWAdd, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstNUWAdd(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstNUWAdd, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstFAdd(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstFAdd, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstSub(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstSub, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstNSWSub(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstNSWSub, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstNUWSub(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstNUWSub, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstFSub(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstFSub, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstMul(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstMul, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstNSWMul(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstNSWMul, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstNUWMul(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstNUWMul, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstFMul(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstFMul, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstUDiv(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstUDiv, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstExactUDiv(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstExactUDiv, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstSDiv(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstSDiv, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstExactSDiv(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstExactSDiv, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstFDiv(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstFDiv, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstURem(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstURem, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstSRem(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstSRem, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstFRem(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstFRem, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstAnd(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstAnd, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstOr(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstOr, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstXor(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstXor, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstICmp(Predicate, LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstICmp, libllvm[]) LLVMValueRef (LLVMIntPredicate, LLVMValueRef, LLVMValueRef) Predicate LHSConstant RHSConstant
end

function LLVMConstFCmp(Predicate, LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstFCmp, libllvm[]) LLVMValueRef (LLVMRealPredicate, LLVMValueRef, LLVMValueRef) Predicate LHSConstant RHSConstant
end

function LLVMConstShl(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstShl, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstLShr(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstLShr, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstAShr(LHSConstant, RHSConstant)
    @runtime_ccall (:LLVMConstAShr, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) LHSConstant RHSConstant
end

function LLVMConstGEP(ConstantVal, ConstantIndices, NumIndices)
    @runtime_ccall (:LLVMConstGEP, libllvm[]) LLVMValueRef (LLVMValueRef, Ptr{LLVMValueRef}, Cuint) ConstantVal ConstantIndices NumIndices
end

function LLVMConstGEP2(Ty, ConstantVal, ConstantIndices, NumIndices)
    @runtime_ccall (:LLVMConstGEP2, libllvm[]) LLVMValueRef (LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint) Ty ConstantVal ConstantIndices NumIndices
end

function LLVMConstInBoundsGEP(ConstantVal, ConstantIndices, NumIndices)
    @runtime_ccall (:LLVMConstInBoundsGEP, libllvm[]) LLVMValueRef (LLVMValueRef, Ptr{LLVMValueRef}, Cuint) ConstantVal ConstantIndices NumIndices
end

function LLVMConstInBoundsGEP2(Ty, ConstantVal, ConstantIndices, NumIndices)
    @runtime_ccall (:LLVMConstInBoundsGEP2, libllvm[]) LLVMValueRef (LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint) Ty ConstantVal ConstantIndices NumIndices
end

function LLVMConstTrunc(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstTrunc, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstSExt(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstSExt, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstZExt(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstZExt, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstFPTrunc(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstFPTrunc, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstFPExt(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstFPExt, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstUIToFP(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstUIToFP, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstSIToFP(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstSIToFP, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstFPToUI(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstFPToUI, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstFPToSI(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstFPToSI, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstPtrToInt(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstPtrToInt, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstIntToPtr(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstIntToPtr, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstBitCast(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstBitCast, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstAddrSpaceCast(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstAddrSpaceCast, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstZExtOrBitCast(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstZExtOrBitCast, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstSExtOrBitCast(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstSExtOrBitCast, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstTruncOrBitCast(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstTruncOrBitCast, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstPointerCast(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstPointerCast, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstIntCast(ConstantVal, ToType, isSigned)
    @runtime_ccall (:LLVMConstIntCast, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef, LLVMBool) ConstantVal ToType isSigned
end

function LLVMConstFPCast(ConstantVal, ToType)
    @runtime_ccall (:LLVMConstFPCast, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMTypeRef) ConstantVal ToType
end

function LLVMConstSelect(ConstantCondition, ConstantIfTrue, ConstantIfFalse)
    @runtime_ccall (:LLVMConstSelect, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef, LLVMValueRef) ConstantCondition ConstantIfTrue ConstantIfFalse
end

function LLVMConstExtractElement(VectorConstant, IndexConstant)
    @runtime_ccall (:LLVMConstExtractElement, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef) VectorConstant IndexConstant
end

function LLVMConstInsertElement(VectorConstant, ElementValueConstant, IndexConstant)
    @runtime_ccall (:LLVMConstInsertElement, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef, LLVMValueRef) VectorConstant ElementValueConstant IndexConstant
end

function LLVMConstShuffleVector(VectorAConstant, VectorBConstant, MaskConstant)
    @runtime_ccall (:LLVMConstShuffleVector, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef, LLVMValueRef) VectorAConstant VectorBConstant MaskConstant
end

function LLVMConstExtractValue(AggConstant, IdxList, NumIdx)
    @runtime_ccall (:LLVMConstExtractValue, libllvm[]) LLVMValueRef (LLVMValueRef, Ptr{Cuint}, Cuint) AggConstant IdxList NumIdx
end

function LLVMConstInsertValue(AggConstant, ElementValueConstant, IdxList, NumIdx)
    @runtime_ccall (:LLVMConstInsertValue, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMValueRef, Ptr{Cuint}, Cuint) AggConstant ElementValueConstant IdxList NumIdx
end

mutable struct LLVMOpaqueBasicBlock end

const LLVMBasicBlockRef = Ptr{LLVMOpaqueBasicBlock}

function LLVMBlockAddress(F, BB)
    @runtime_ccall (:LLVMBlockAddress, libllvm[]) LLVMValueRef (LLVMValueRef, LLVMBasicBlockRef) F BB
end

function LLVMConstInlineAsm(Ty, AsmString, Constraints, HasSideEffects, IsAlignStack)
    @runtime_ccall (:LLVMConstInlineAsm, libllvm[]) LLVMValueRef (LLVMTypeRef, Cstring, Cstring, LLVMBool, LLVMBool) Ty AsmString Constraints HasSideEffects IsAlignStack
end

function LLVMGetGlobalParent(Global)
    @runtime_ccall (:LLVMGetGlobalParent, libllvm[]) LLVMModuleRef (LLVMValueRef,) Global
end

function LLVMIsDeclaration(Global)
    @runtime_ccall (:LLVMIsDeclaration, libllvm[]) LLVMBool (LLVMValueRef,) Global
end

function LLVMGetLinkage(Global)
    @runtime_ccall (:LLVMGetLinkage, libllvm[]) LLVMLinkage (LLVMValueRef,) Global
end

function LLVMSetLinkage(Global, Linkage)
    @runtime_ccall (:LLVMSetLinkage, libllvm[]) Cvoid (LLVMValueRef, LLVMLinkage) Global Linkage
end

function LLVMGetSection(Global)
    @runtime_ccall (:LLVMGetSection, libllvm[]) Cstring (LLVMValueRef,) Global
end

function LLVMSetSection(Global, Section)
    @runtime_ccall (:LLVMSetSection, libllvm[]) Cvoid (LLVMValueRef, Cstring) Global Section
end

function LLVMGetVisibility(Global)
    @runtime_ccall (:LLVMGetVisibility, libllvm[]) LLVMVisibility (LLVMValueRef,) Global
end

function LLVMSetVisibility(Global, Viz)
    @runtime_ccall (:LLVMSetVisibility, libllvm[]) Cvoid (LLVMValueRef, LLVMVisibility) Global Viz
end

function LLVMGetDLLStorageClass(Global)
    @runtime_ccall (:LLVMGetDLLStorageClass, libllvm[]) LLVMDLLStorageClass (LLVMValueRef,) Global
end

function LLVMSetDLLStorageClass(Global, Class)
    @runtime_ccall (:LLVMSetDLLStorageClass, libllvm[]) Cvoid (LLVMValueRef, LLVMDLLStorageClass) Global Class
end

function LLVMGetUnnamedAddress(Global)
    @runtime_ccall (:LLVMGetUnnamedAddress, libllvm[]) LLVMUnnamedAddr (LLVMValueRef,) Global
end

function LLVMSetUnnamedAddress(Global, UnnamedAddr)
    @runtime_ccall (:LLVMSetUnnamedAddress, libllvm[]) Cvoid (LLVMValueRef, LLVMUnnamedAddr) Global UnnamedAddr
end

function LLVMGlobalGetValueType(Global)
    @runtime_ccall (:LLVMGlobalGetValueType, libllvm[]) LLVMTypeRef (LLVMValueRef,) Global
end

function LLVMHasUnnamedAddr(Global)
    @runtime_ccall (:LLVMHasUnnamedAddr, libllvm[]) LLVMBool (LLVMValueRef,) Global
end

function LLVMSetUnnamedAddr(Global, HasUnnamedAddr)
    @runtime_ccall (:LLVMSetUnnamedAddr, libllvm[]) Cvoid (LLVMValueRef, LLVMBool) Global HasUnnamedAddr
end

function LLVMGetAlignment(V)
    @runtime_ccall (:LLVMGetAlignment, libllvm[]) Cuint (LLVMValueRef,) V
end

function LLVMSetAlignment(V, Bytes)
    @runtime_ccall (:LLVMSetAlignment, libllvm[]) Cvoid (LLVMValueRef, Cuint) V Bytes
end

function LLVMGlobalSetMetadata(Global, Kind, MD)
    @runtime_ccall (:LLVMGlobalSetMetadata, libllvm[]) Cvoid (LLVMValueRef, Cuint, LLVMMetadataRef) Global Kind MD
end

function LLVMGlobalEraseMetadata(Global, Kind)
    @runtime_ccall (:LLVMGlobalEraseMetadata, libllvm[]) Cvoid (LLVMValueRef, Cuint) Global Kind
end

function LLVMGlobalClearMetadata(Global)
    @runtime_ccall (:LLVMGlobalClearMetadata, libllvm[]) Cvoid (LLVMValueRef,) Global
end

mutable struct LLVMOpaqueValueMetadataEntry end

const LLVMValueMetadataEntry = LLVMOpaqueValueMetadataEntry

function LLVMGlobalCopyAllMetadata(Value, NumEntries)
    @runtime_ccall (:LLVMGlobalCopyAllMetadata, libllvm[]) Ptr{LLVMValueMetadataEntry} (LLVMValueRef, Ptr{Csize_t}) Value NumEntries
end

function LLVMDisposeValueMetadataEntries(Entries)
    @runtime_ccall (:LLVMDisposeValueMetadataEntries, libllvm[]) Cvoid (Ptr{LLVMValueMetadataEntry},) Entries
end

function LLVMValueMetadataEntriesGetKind(Entries, Index)
    @runtime_ccall (:LLVMValueMetadataEntriesGetKind, libllvm[]) Cuint (Ptr{LLVMValueMetadataEntry}, Cuint) Entries Index
end

function LLVMValueMetadataEntriesGetMetadata(Entries, Index)
    @runtime_ccall (:LLVMValueMetadataEntriesGetMetadata, libllvm[]) LLVMMetadataRef (Ptr{LLVMValueMetadataEntry}, Cuint) Entries Index
end

function LLVMAddGlobal(M, Ty, Name)
    @runtime_ccall (:LLVMAddGlobal, libllvm[]) LLVMValueRef (LLVMModuleRef, LLVMTypeRef, Cstring) M Ty Name
end

function LLVMAddGlobalInAddressSpace(M, Ty, Name, AddressSpace)
    @runtime_ccall (:LLVMAddGlobalInAddressSpace, libllvm[]) LLVMValueRef (LLVMModuleRef, LLVMTypeRef, Cstring, Cuint) M Ty Name AddressSpace
end

function LLVMGetNamedGlobal(M, Name)
    @runtime_ccall (:LLVMGetNamedGlobal, libllvm[]) LLVMValueRef (LLVMModuleRef, Cstring) M Name
end

function LLVMGetFirstGlobal(M)
    @runtime_ccall (:LLVMGetFirstGlobal, libllvm[]) LLVMValueRef (LLVMModuleRef,) M
end

function LLVMGetLastGlobal(M)
    @runtime_ccall (:LLVMGetLastGlobal, libllvm[]) LLVMValueRef (LLVMModuleRef,) M
end

function LLVMGetNextGlobal(GlobalVar)
    @runtime_ccall (:LLVMGetNextGlobal, libllvm[]) LLVMValueRef (LLVMValueRef,) GlobalVar
end

function LLVMGetPreviousGlobal(GlobalVar)
    @runtime_ccall (:LLVMGetPreviousGlobal, libllvm[]) LLVMValueRef (LLVMValueRef,) GlobalVar
end

function LLVMDeleteGlobal(GlobalVar)
    @runtime_ccall (:LLVMDeleteGlobal, libllvm[]) Cvoid (LLVMValueRef,) GlobalVar
end

function LLVMGetInitializer(GlobalVar)
    @runtime_ccall (:LLVMGetInitializer, libllvm[]) LLVMValueRef (LLVMValueRef,) GlobalVar
end

function LLVMSetInitializer(GlobalVar, ConstantVal)
    @runtime_ccall (:LLVMSetInitializer, libllvm[]) Cvoid (LLVMValueRef, LLVMValueRef) GlobalVar ConstantVal
end

function LLVMIsThreadLocal(GlobalVar)
    @runtime_ccall (:LLVMIsThreadLocal, libllvm[]) LLVMBool (LLVMValueRef,) GlobalVar
end

function LLVMSetThreadLocal(GlobalVar, IsThreadLocal)
    @runtime_ccall (:LLVMSetThreadLocal, libllvm[]) Cvoid (LLVMValueRef, LLVMBool) GlobalVar IsThreadLocal
end

function LLVMIsGlobalConstant(GlobalVar)
    @runtime_ccall (:LLVMIsGlobalConstant, libllvm[]) LLVMBool (LLVMValueRef,) GlobalVar
end

function LLVMSetGlobalConstant(GlobalVar, IsConstant)
    @runtime_ccall (:LLVMSetGlobalConstant, libllvm[]) Cvoid (LLVMValueRef, LLVMBool) GlobalVar IsConstant
end

function LLVMGetThreadLocalMode(GlobalVar)
    @runtime_ccall (:LLVMGetThreadLocalMode, libllvm[]) LLVMThreadLocalMode (LLVMValueRef,) GlobalVar
end

function LLVMSetThreadLocalMode(GlobalVar, Mode)
    @runtime_ccall (:LLVMSetThreadLocalMode, libllvm[]) Cvoid (LLVMValueRef, LLVMThreadLocalMode) GlobalVar Mode
end

function LLVMIsExternallyInitialized(GlobalVar)
    @runtime_ccall (:LLVMIsExternallyInitialized, libllvm[]) LLVMBool (LLVMValueRef,) GlobalVar
end

function LLVMSetExternallyInitialized(GlobalVar, IsExtInit)
    @runtime_ccall (:LLVMSetExternallyInitialized, libllvm[]) Cvoid (LLVMValueRef, LLVMBool) GlobalVar IsExtInit
end

function LLVMAddAlias(M, Ty, Aliasee, Name)
    @runtime_ccall (:LLVMAddAlias, libllvm[]) LLVMValueRef (LLVMModuleRef, LLVMTypeRef, LLVMValueRef, Cstring) M Ty Aliasee Name
end

function LLVMGetNamedGlobalAlias(M, Name, NameLen)
    @runtime_ccall (:LLVMGetNamedGlobalAlias, libllvm[]) LLVMValueRef (LLVMModuleRef, Cstring, Csize_t) M Name NameLen
end

function LLVMGetFirstGlobalAlias(M)
    @runtime_ccall (:LLVMGetFirstGlobalAlias, libllvm[]) LLVMValueRef (LLVMModuleRef,) M
end

function LLVMGetLastGlobalAlias(M)
    @runtime_ccall (:LLVMGetLastGlobalAlias, libllvm[]) LLVMValueRef (LLVMModuleRef,) M
end

function LLVMGetNextGlobalAlias(GA)
    @runtime_ccall (:LLVMGetNextGlobalAlias, libllvm[]) LLVMValueRef (LLVMValueRef,) GA
end

function LLVMGetPreviousGlobalAlias(GA)
    @runtime_ccall (:LLVMGetPreviousGlobalAlias, libllvm[]) LLVMValueRef (LLVMValueRef,) GA
end

function LLVMAliasGetAliasee(Alias)
    @runtime_ccall (:LLVMAliasGetAliasee, libllvm[]) LLVMValueRef (LLVMValueRef,) Alias
end

function LLVMAliasSetAliasee(Alias, Aliasee)
    @runtime_ccall (:LLVMAliasSetAliasee, libllvm[]) Cvoid (LLVMValueRef, LLVMValueRef) Alias Aliasee
end

function LLVMDeleteFunction(Fn)
    @runtime_ccall (:LLVMDeleteFunction, libllvm[]) Cvoid (LLVMValueRef,) Fn
end

function LLVMHasPersonalityFn(Fn)
    @runtime_ccall (:LLVMHasPersonalityFn, libllvm[]) LLVMBool (LLVMValueRef,) Fn
end

function LLVMGetPersonalityFn(Fn)
    @runtime_ccall (:LLVMGetPersonalityFn, libllvm[]) LLVMValueRef (LLVMValueRef,) Fn
end

function LLVMSetPersonalityFn(Fn, PersonalityFn)
    @runtime_ccall (:LLVMSetPersonalityFn, libllvm[]) Cvoid (LLVMValueRef, LLVMValueRef) Fn PersonalityFn
end

function LLVMLookupIntrinsicID(Name, NameLen)
    @runtime_ccall (:LLVMLookupIntrinsicID, libllvm[]) Cuint (Cstring, Csize_t) Name NameLen
end

function LLVMGetIntrinsicID(Fn)
    @runtime_ccall (:LLVMGetIntrinsicID, libllvm[]) Cuint (LLVMValueRef,) Fn
end

function LLVMGetIntrinsicDeclaration(Mod, ID, ParamTypes, ParamCount)
    @runtime_ccall (:LLVMGetIntrinsicDeclaration, libllvm[]) LLVMValueRef (LLVMModuleRef, Cuint, Ptr{LLVMTypeRef}, Csize_t) Mod ID ParamTypes ParamCount
end

function LLVMIntrinsicGetType(Ctx, ID, ParamTypes, ParamCount)
    @runtime_ccall (:LLVMIntrinsicGetType, libllvm[]) LLVMTypeRef (LLVMContextRef, Cuint, Ptr{LLVMTypeRef}, Csize_t) Ctx ID ParamTypes ParamCount
end

function LLVMIntrinsicGetName(ID, NameLength)
    @runtime_ccall (:LLVMIntrinsicGetName, libllvm[]) Cstring (Cuint, Ptr{Csize_t}) ID NameLength
end

function LLVMIntrinsicCopyOverloadedName(ID, ParamTypes, ParamCount, NameLength)
    @runtime_ccall (:LLVMIntrinsicCopyOverloadedName, libllvm[]) Cstring (Cuint, Ptr{LLVMTypeRef}, Csize_t, Ptr{Csize_t}) ID ParamTypes ParamCount NameLength
end

function LLVMIntrinsicIsOverloaded(ID)
    @runtime_ccall (:LLVMIntrinsicIsOverloaded, libllvm[]) LLVMBool (Cuint,) ID
end

function LLVMGetFunctionCallConv(Fn)
    @runtime_ccall (:LLVMGetFunctionCallConv, libllvm[]) Cuint (LLVMValueRef,) Fn
end

function LLVMSetFunctionCallConv(Fn, CC)
    @runtime_ccall (:LLVMSetFunctionCallConv, libllvm[]) Cvoid (LLVMValueRef, Cuint) Fn CC
end

function LLVMGetGC(Fn)
    @runtime_ccall (:LLVMGetGC, libllvm[]) Cstring (LLVMValueRef,) Fn
end

function LLVMSetGC(Fn, Name)
    @runtime_ccall (:LLVMSetGC, libllvm[]) Cvoid (LLVMValueRef, Cstring) Fn Name
end

function LLVMAddAttributeAtIndex(F, Idx, A)
    @runtime_ccall (:LLVMAddAttributeAtIndex, libllvm[]) Cvoid (LLVMValueRef, LLVMAttributeIndex, LLVMAttributeRef) F Idx A
end

function LLVMGetAttributeCountAtIndex(F, Idx)
    @runtime_ccall (:LLVMGetAttributeCountAtIndex, libllvm[]) Cuint (LLVMValueRef, LLVMAttributeIndex) F Idx
end

function LLVMGetAttributesAtIndex(F, Idx, Attrs)
    @runtime_ccall (:LLVMGetAttributesAtIndex, libllvm[]) Cvoid (LLVMValueRef, LLVMAttributeIndex, Ptr{LLVMAttributeRef}) F Idx Attrs
end

function LLVMGetEnumAttributeAtIndex(F, Idx, KindID)
    @runtime_ccall (:LLVMGetEnumAttributeAtIndex, libllvm[]) LLVMAttributeRef (LLVMValueRef, LLVMAttributeIndex, Cuint) F Idx KindID
end

function LLVMGetStringAttributeAtIndex(F, Idx, K, KLen)
    @runtime_ccall (:LLVMGetStringAttributeAtIndex, libllvm[]) LLVMAttributeRef (LLVMValueRef, LLVMAttributeIndex, Cstring, Cuint) F Idx K KLen
end

function LLVMRemoveEnumAttributeAtIndex(F, Idx, KindID)
    @runtime_ccall (:LLVMRemoveEnumAttributeAtIndex, libllvm[]) Cvoid (LLVMValueRef, LLVMAttributeIndex, Cuint) F Idx KindID
end

function LLVMRemoveStringAttributeAtIndex(F, Idx, K, KLen)
    @runtime_ccall (:LLVMRemoveStringAttributeAtIndex, libllvm[]) Cvoid (LLVMValueRef, LLVMAttributeIndex, Cstring, Cuint) F Idx K KLen
end

function LLVMAddTargetDependentFunctionAttr(Fn, A, V)
    @runtime_ccall (:LLVMAddTargetDependentFunctionAttr, libllvm[]) Cvoid (LLVMValueRef, Cstring, Cstring) Fn A V
end

function LLVMCountParams(Fn)
    @runtime_ccall (:LLVMCountParams, libllvm[]) Cuint (LLVMValueRef,) Fn
end

function LLVMGetParams(Fn, Params)
    @runtime_ccall (:LLVMGetParams, libllvm[]) Cvoid (LLVMValueRef, Ptr{LLVMValueRef}) Fn Params
end

function LLVMGetParam(Fn, Index)
    @runtime_ccall (:LLVMGetParam, libllvm[]) LLVMValueRef (LLVMValueRef, Cuint) Fn Index
end

function LLVMGetParamParent(Inst)
    @runtime_ccall (:LLVMGetParamParent, libllvm[]) LLVMValueRef (LLVMValueRef,) Inst
end

function LLVMGetFirstParam(Fn)
    @runtime_ccall (:LLVMGetFirstParam, libllvm[]) LLVMValueRef (LLVMValueRef,) Fn
end

function LLVMGetLastParam(Fn)
    @runtime_ccall (:LLVMGetLastParam, libllvm[]) LLVMValueRef (LLVMValueRef,) Fn
end

function LLVMGetNextParam(Arg)
    @runtime_ccall (:LLVMGetNextParam, libllvm[]) LLVMValueRef (LLVMValueRef,) Arg
end

function LLVMGetPreviousParam(Arg)
    @runtime_ccall (:LLVMGetPreviousParam, libllvm[]) LLVMValueRef (LLVMValueRef,) Arg
end

function LLVMSetParamAlignment(Arg, Align)
    @runtime_ccall (:LLVMSetParamAlignment, libllvm[]) Cvoid (LLVMValueRef, Cuint) Arg Align
end

function LLVMAddGlobalIFunc(M, Name, NameLen, Ty, AddrSpace, Resolver)
    @runtime_ccall (:LLVMAddGlobalIFunc, libllvm[]) LLVMValueRef (LLVMModuleRef, Cstring, Csize_t, LLVMTypeRef, Cuint, LLVMValueRef) M Name NameLen Ty AddrSpace Resolver
end

function LLVMGetNamedGlobalIFunc(M, Name, NameLen)
    @runtime_ccall (:LLVMGetNamedGlobalIFunc, libllvm[]) LLVMValueRef (LLVMModuleRef, Cstring, Csize_t) M Name NameLen
end

function LLVMGetFirstGlobalIFunc(M)
    @runtime_ccall (:LLVMGetFirstGlobalIFunc, libllvm[]) LLVMValueRef (LLVMModuleRef,) M
end

function LLVMGetLastGlobalIFunc(M)
    @runtime_ccall (:LLVMGetLastGlobalIFunc, libllvm[]) LLVMValueRef (LLVMModuleRef,) M
end

function LLVMGetNextGlobalIFunc(IFunc)
    @runtime_ccall (:LLVMGetNextGlobalIFunc, libllvm[]) LLVMValueRef (LLVMValueRef,) IFunc
end

function LLVMGetPreviousGlobalIFunc(IFunc)
    @runtime_ccall (:LLVMGetPreviousGlobalIFunc, libllvm[]) LLVMValueRef (LLVMValueRef,) IFunc
end

function LLVMGetGlobalIFuncResolver(IFunc)
    @runtime_ccall (:LLVMGetGlobalIFuncResolver, libllvm[]) LLVMValueRef (LLVMValueRef,) IFunc
end

function LLVMSetGlobalIFuncResolver(IFunc, Resolver)
    @runtime_ccall (:LLVMSetGlobalIFuncResolver, libllvm[]) Cvoid (LLVMValueRef, LLVMValueRef) IFunc Resolver
end

function LLVMEraseGlobalIFunc(IFunc)
    @runtime_ccall (:LLVMEraseGlobalIFunc, libllvm[]) Cvoid (LLVMValueRef,) IFunc
end

function LLVMRemoveGlobalIFunc(IFunc)
    @runtime_ccall (:LLVMRemoveGlobalIFunc, libllvm[]) Cvoid (LLVMValueRef,) IFunc
end

function LLVMMDStringInContext2(C, Str, SLen)
    @runtime_ccall (:LLVMMDStringInContext2, libllvm[]) LLVMMetadataRef (LLVMContextRef, Cstring, Csize_t) C Str SLen
end

function LLVMMDNodeInContext2(C, MDs, Count)
    @runtime_ccall (:LLVMMDNodeInContext2, libllvm[]) LLVMMetadataRef (LLVMContextRef, Ptr{LLVMMetadataRef}, Csize_t) C MDs Count
end

function LLVMMetadataAsValue(C, MD)
    @runtime_ccall (:LLVMMetadataAsValue, libllvm[]) LLVMValueRef (LLVMContextRef, LLVMMetadataRef) C MD
end

function LLVMValueAsMetadata(Val)
    @runtime_ccall (:LLVMValueAsMetadata, libllvm[]) LLVMMetadataRef (LLVMValueRef,) Val
end

function LLVMGetMDString(V, Length)
    @runtime_ccall (:LLVMGetMDString, libllvm[]) Cstring (LLVMValueRef, Ptr{Cuint}) V Length
end

function LLVMGetMDNodeNumOperands(V)
    @runtime_ccall (:LLVMGetMDNodeNumOperands, libllvm[]) Cuint (LLVMValueRef,) V
end

function LLVMGetMDNodeOperands(V, Dest)
    @runtime_ccall (:LLVMGetMDNodeOperands, libllvm[]) Cvoid (LLVMValueRef, Ptr{LLVMValueRef}) V Dest
end

function LLVMMDStringInContext(C, Str, SLen)
    @runtime_ccall (:LLVMMDStringInContext, libllvm[]) LLVMValueRef (LLVMContextRef, Cstring, Cuint) C Str SLen
end

function LLVMMDString(Str, SLen)
    @runtime_ccall (:LLVMMDString, libllvm[]) LLVMValueRef (Cstring, Cuint) Str SLen
end

function LLVMMDNodeInContext(C, Vals, Count)
    @runtime_ccall (:LLVMMDNodeInContext, libllvm[]) LLVMValueRef (LLVMContextRef, Ptr{LLVMValueRef}, Cuint) C Vals Count
end

function LLVMMDNode(Vals, Count)
    @runtime_ccall (:LLVMMDNode, libllvm[]) LLVMValueRef (Ptr{LLVMValueRef}, Cuint) Vals Count
end

function LLVMBasicBlockAsValue(BB)
    @runtime_ccall (:LLVMBasicBlockAsValue, libllvm[]) LLVMValueRef (LLVMBasicBlockRef,) BB
end

function LLVMValueIsBasicBlock(Val)
    @runtime_ccall (:LLVMValueIsBasicBlock, libllvm[]) LLVMBool (LLVMValueRef,) Val
end

function LLVMValueAsBasicBlock(Val)
    @runtime_ccall (:LLVMValueAsBasicBlock, libllvm[]) LLVMBasicBlockRef (LLVMValueRef,) Val
end

function LLVMGetBasicBlockName(BB)
    @runtime_ccall (:LLVMGetBasicBlockName, libllvm[]) Cstring (LLVMBasicBlockRef,) BB
end

function LLVMGetBasicBlockParent(BB)
    @runtime_ccall (:LLVMGetBasicBlockParent, libllvm[]) LLVMValueRef (LLVMBasicBlockRef,) BB
end

function LLVMGetBasicBlockTerminator(BB)
    @runtime_ccall (:LLVMGetBasicBlockTerminator, libllvm[]) LLVMValueRef (LLVMBasicBlockRef,) BB
end

function LLVMCountBasicBlocks(Fn)
    @runtime_ccall (:LLVMCountBasicBlocks, libllvm[]) Cuint (LLVMValueRef,) Fn
end

function LLVMGetBasicBlocks(Fn, BasicBlocks)
    @runtime_ccall (:LLVMGetBasicBlocks, libllvm[]) Cvoid (LLVMValueRef, Ptr{LLVMBasicBlockRef}) Fn BasicBlocks
end

function LLVMGetFirstBasicBlock(Fn)
    @runtime_ccall (:LLVMGetFirstBasicBlock, libllvm[]) LLVMBasicBlockRef (LLVMValueRef,) Fn
end

function LLVMGetLastBasicBlock(Fn)
    @runtime_ccall (:LLVMGetLastBasicBlock, libllvm[]) LLVMBasicBlockRef (LLVMValueRef,) Fn
end

function LLVMGetNextBasicBlock(BB)
    @runtime_ccall (:LLVMGetNextBasicBlock, libllvm[]) LLVMBasicBlockRef (LLVMBasicBlockRef,) BB
end

function LLVMGetPreviousBasicBlock(BB)
    @runtime_ccall (:LLVMGetPreviousBasicBlock, libllvm[]) LLVMBasicBlockRef (LLVMBasicBlockRef,) BB
end

function LLVMGetEntryBasicBlock(Fn)
    @runtime_ccall (:LLVMGetEntryBasicBlock, libllvm[]) LLVMBasicBlockRef (LLVMValueRef,) Fn
end

mutable struct LLVMOpaqueBuilder end

const LLVMBuilderRef = Ptr{LLVMOpaqueBuilder}

function LLVMInsertExistingBasicBlockAfterInsertBlock(Builder, BB)
    @runtime_ccall (:LLVMInsertExistingBasicBlockAfterInsertBlock, libllvm[]) Cvoid (LLVMBuilderRef, LLVMBasicBlockRef) Builder BB
end

function LLVMAppendExistingBasicBlock(Fn, BB)
    @runtime_ccall (:LLVMAppendExistingBasicBlock, libllvm[]) Cvoid (LLVMValueRef, LLVMBasicBlockRef) Fn BB
end

function LLVMCreateBasicBlockInContext(C, Name)
    @runtime_ccall (:LLVMCreateBasicBlockInContext, libllvm[]) LLVMBasicBlockRef (LLVMContextRef, Cstring) C Name
end

function LLVMAppendBasicBlockInContext(C, Fn, Name)
    @runtime_ccall (:LLVMAppendBasicBlockInContext, libllvm[]) LLVMBasicBlockRef (LLVMContextRef, LLVMValueRef, Cstring) C Fn Name
end

function LLVMAppendBasicBlock(Fn, Name)
    @runtime_ccall (:LLVMAppendBasicBlock, libllvm[]) LLVMBasicBlockRef (LLVMValueRef, Cstring) Fn Name
end

function LLVMInsertBasicBlockInContext(C, BB, Name)
    @runtime_ccall (:LLVMInsertBasicBlockInContext, libllvm[]) LLVMBasicBlockRef (LLVMContextRef, LLVMBasicBlockRef, Cstring) C BB Name
end

function LLVMInsertBasicBlock(InsertBeforeBB, Name)
    @runtime_ccall (:LLVMInsertBasicBlock, libllvm[]) LLVMBasicBlockRef (LLVMBasicBlockRef, Cstring) InsertBeforeBB Name
end

function LLVMDeleteBasicBlock(BB)
    @runtime_ccall (:LLVMDeleteBasicBlock, libllvm[]) Cvoid (LLVMBasicBlockRef,) BB
end

function LLVMRemoveBasicBlockFromParent(BB)
    @runtime_ccall (:LLVMRemoveBasicBlockFromParent, libllvm[]) Cvoid (LLVMBasicBlockRef,) BB
end

function LLVMMoveBasicBlockBefore(BB, MovePos)
    @runtime_ccall (:LLVMMoveBasicBlockBefore, libllvm[]) Cvoid (LLVMBasicBlockRef, LLVMBasicBlockRef) BB MovePos
end

function LLVMMoveBasicBlockAfter(BB, MovePos)
    @runtime_ccall (:LLVMMoveBasicBlockAfter, libllvm[]) Cvoid (LLVMBasicBlockRef, LLVMBasicBlockRef) BB MovePos
end

function LLVMGetFirstInstruction(BB)
    @runtime_ccall (:LLVMGetFirstInstruction, libllvm[]) LLVMValueRef (LLVMBasicBlockRef,) BB
end

function LLVMGetLastInstruction(BB)
    @runtime_ccall (:LLVMGetLastInstruction, libllvm[]) LLVMValueRef (LLVMBasicBlockRef,) BB
end

function LLVMHasMetadata(Val)
    @runtime_ccall (:LLVMHasMetadata, libllvm[]) Cint (LLVMValueRef,) Val
end

function LLVMGetMetadata(Val, KindID)
    @runtime_ccall (:LLVMGetMetadata, libllvm[]) LLVMValueRef (LLVMValueRef, Cuint) Val KindID
end

function LLVMSetMetadata(Val, KindID, Node)
    @runtime_ccall (:LLVMSetMetadata, libllvm[]) Cvoid (LLVMValueRef, Cuint, LLVMValueRef) Val KindID Node
end

function LLVMInstructionGetAllMetadataOtherThanDebugLoc(Instr, NumEntries)
    @runtime_ccall (:LLVMInstructionGetAllMetadataOtherThanDebugLoc, libllvm[]) Ptr{LLVMValueMetadataEntry} (LLVMValueRef, Ptr{Csize_t}) Instr NumEntries
end

function LLVMGetInstructionParent(Inst)
    @runtime_ccall (:LLVMGetInstructionParent, libllvm[]) LLVMBasicBlockRef (LLVMValueRef,) Inst
end

function LLVMGetNextInstruction(Inst)
    @runtime_ccall (:LLVMGetNextInstruction, libllvm[]) LLVMValueRef (LLVMValueRef,) Inst
end

function LLVMGetPreviousInstruction(Inst)
    @runtime_ccall (:LLVMGetPreviousInstruction, libllvm[]) LLVMValueRef (LLVMValueRef,) Inst
end

function LLVMInstructionRemoveFromParent(Inst)
    @runtime_ccall (:LLVMInstructionRemoveFromParent, libllvm[]) Cvoid (LLVMValueRef,) Inst
end

function LLVMInstructionEraseFromParent(Inst)
    @runtime_ccall (:LLVMInstructionEraseFromParent, libllvm[]) Cvoid (LLVMValueRef,) Inst
end

function LLVMGetInstructionOpcode(Inst)
    @runtime_ccall (:LLVMGetInstructionOpcode, libllvm[]) LLVMOpcode (LLVMValueRef,) Inst
end

function LLVMGetICmpPredicate(Inst)
    @runtime_ccall (:LLVMGetICmpPredicate, libllvm[]) LLVMIntPredicate (LLVMValueRef,) Inst
end

function LLVMGetFCmpPredicate(Inst)
    @runtime_ccall (:LLVMGetFCmpPredicate, libllvm[]) LLVMRealPredicate (LLVMValueRef,) Inst
end

function LLVMInstructionClone(Inst)
    @runtime_ccall (:LLVMInstructionClone, libllvm[]) LLVMValueRef (LLVMValueRef,) Inst
end

function LLVMIsATerminatorInst(Inst)
    @runtime_ccall (:LLVMIsATerminatorInst, libllvm[]) LLVMValueRef (LLVMValueRef,) Inst
end

function LLVMGetNumArgOperands(Instr)
    @runtime_ccall (:LLVMGetNumArgOperands, libllvm[]) Cuint (LLVMValueRef,) Instr
end

function LLVMSetInstructionCallConv(Instr, CC)
    @runtime_ccall (:LLVMSetInstructionCallConv, libllvm[]) Cvoid (LLVMValueRef, Cuint) Instr CC
end

function LLVMGetInstructionCallConv(Instr)
    @runtime_ccall (:LLVMGetInstructionCallConv, libllvm[]) Cuint (LLVMValueRef,) Instr
end

function LLVMSetInstrParamAlignment(Instr, index, Align)
    @runtime_ccall (:LLVMSetInstrParamAlignment, libllvm[]) Cvoid (LLVMValueRef, Cuint, Cuint) Instr index Align
end

function LLVMAddCallSiteAttribute(C, Idx, A)
    @runtime_ccall (:LLVMAddCallSiteAttribute, libllvm[]) Cvoid (LLVMValueRef, LLVMAttributeIndex, LLVMAttributeRef) C Idx A
end

function LLVMGetCallSiteAttributeCount(C, Idx)
    @runtime_ccall (:LLVMGetCallSiteAttributeCount, libllvm[]) Cuint (LLVMValueRef, LLVMAttributeIndex) C Idx
end

function LLVMGetCallSiteAttributes(C, Idx, Attrs)
    @runtime_ccall (:LLVMGetCallSiteAttributes, libllvm[]) Cvoid (LLVMValueRef, LLVMAttributeIndex, Ptr{LLVMAttributeRef}) C Idx Attrs
end

function LLVMGetCallSiteEnumAttribute(C, Idx, KindID)
    @runtime_ccall (:LLVMGetCallSiteEnumAttribute, libllvm[]) LLVMAttributeRef (LLVMValueRef, LLVMAttributeIndex, Cuint) C Idx KindID
end

function LLVMGetCallSiteStringAttribute(C, Idx, K, KLen)
    @runtime_ccall (:LLVMGetCallSiteStringAttribute, libllvm[]) LLVMAttributeRef (LLVMValueRef, LLVMAttributeIndex, Cstring, Cuint) C Idx K KLen
end

function LLVMRemoveCallSiteEnumAttribute(C, Idx, KindID)
    @runtime_ccall (:LLVMRemoveCallSiteEnumAttribute, libllvm[]) Cvoid (LLVMValueRef, LLVMAttributeIndex, Cuint) C Idx KindID
end

function LLVMRemoveCallSiteStringAttribute(C, Idx, K, KLen)
    @runtime_ccall (:LLVMRemoveCallSiteStringAttribute, libllvm[]) Cvoid (LLVMValueRef, LLVMAttributeIndex, Cstring, Cuint) C Idx K KLen
end

function LLVMGetCalledFunctionType(C)
    @runtime_ccall (:LLVMGetCalledFunctionType, libllvm[]) LLVMTypeRef (LLVMValueRef,) C
end

function LLVMGetCalledValue(Instr)
    @runtime_ccall (:LLVMGetCalledValue, libllvm[]) LLVMValueRef (LLVMValueRef,) Instr
end

function LLVMIsTailCall(CallInst)
    @runtime_ccall (:LLVMIsTailCall, libllvm[]) LLVMBool (LLVMValueRef,) CallInst
end

function LLVMSetTailCall(CallInst, IsTailCall)
    @runtime_ccall (:LLVMSetTailCall, libllvm[]) Cvoid (LLVMValueRef, LLVMBool) CallInst IsTailCall
end

function LLVMGetNormalDest(InvokeInst)
    @runtime_ccall (:LLVMGetNormalDest, libllvm[]) LLVMBasicBlockRef (LLVMValueRef,) InvokeInst
end

function LLVMGetUnwindDest(InvokeInst)
    @runtime_ccall (:LLVMGetUnwindDest, libllvm[]) LLVMBasicBlockRef (LLVMValueRef,) InvokeInst
end

function LLVMSetNormalDest(InvokeInst, B)
    @runtime_ccall (:LLVMSetNormalDest, libllvm[]) Cvoid (LLVMValueRef, LLVMBasicBlockRef) InvokeInst B
end

function LLVMSetUnwindDest(InvokeInst, B)
    @runtime_ccall (:LLVMSetUnwindDest, libllvm[]) Cvoid (LLVMValueRef, LLVMBasicBlockRef) InvokeInst B
end

function LLVMGetNumSuccessors(Term)
    @runtime_ccall (:LLVMGetNumSuccessors, libllvm[]) Cuint (LLVMValueRef,) Term
end

function LLVMGetSuccessor(Term, i)
    @runtime_ccall (:LLVMGetSuccessor, libllvm[]) LLVMBasicBlockRef (LLVMValueRef, Cuint) Term i
end

function LLVMSetSuccessor(Term, i, block)
    @runtime_ccall (:LLVMSetSuccessor, libllvm[]) Cvoid (LLVMValueRef, Cuint, LLVMBasicBlockRef) Term i block
end

function LLVMIsConditional(Branch)
    @runtime_ccall (:LLVMIsConditional, libllvm[]) LLVMBool (LLVMValueRef,) Branch
end

function LLVMGetCondition(Branch)
    @runtime_ccall (:LLVMGetCondition, libllvm[]) LLVMValueRef (LLVMValueRef,) Branch
end

function LLVMSetCondition(Branch, Cond)
    @runtime_ccall (:LLVMSetCondition, libllvm[]) Cvoid (LLVMValueRef, LLVMValueRef) Branch Cond
end

function LLVMGetSwitchDefaultDest(SwitchInstr)
    @runtime_ccall (:LLVMGetSwitchDefaultDest, libllvm[]) LLVMBasicBlockRef (LLVMValueRef,) SwitchInstr
end

function LLVMGetAllocatedType(Alloca)
    @runtime_ccall (:LLVMGetAllocatedType, libllvm[]) LLVMTypeRef (LLVMValueRef,) Alloca
end

function LLVMIsInBounds(GEP)
    @runtime_ccall (:LLVMIsInBounds, libllvm[]) LLVMBool (LLVMValueRef,) GEP
end

function LLVMSetIsInBounds(GEP, InBounds)
    @runtime_ccall (:LLVMSetIsInBounds, libllvm[]) Cvoid (LLVMValueRef, LLVMBool) GEP InBounds
end

function LLVMAddIncoming(PhiNode, IncomingValues, IncomingBlocks, Count)
    @runtime_ccall (:LLVMAddIncoming, libllvm[]) Cvoid (LLVMValueRef, Ptr{LLVMValueRef}, Ptr{LLVMBasicBlockRef}, Cuint) PhiNode IncomingValues IncomingBlocks Count
end

function LLVMCountIncoming(PhiNode)
    @runtime_ccall (:LLVMCountIncoming, libllvm[]) Cuint (LLVMValueRef,) PhiNode
end

function LLVMGetIncomingValue(PhiNode, Index)
    @runtime_ccall (:LLVMGetIncomingValue, libllvm[]) LLVMValueRef (LLVMValueRef, Cuint) PhiNode Index
end

function LLVMGetIncomingBlock(PhiNode, Index)
    @runtime_ccall (:LLVMGetIncomingBlock, libllvm[]) LLVMBasicBlockRef (LLVMValueRef, Cuint) PhiNode Index
end

function LLVMGetNumIndices(Inst)
    @runtime_ccall (:LLVMGetNumIndices, libllvm[]) Cuint (LLVMValueRef,) Inst
end

function LLVMGetIndices(Inst)
    @runtime_ccall (:LLVMGetIndices, libllvm[]) Ptr{Cuint} (LLVMValueRef,) Inst
end

function LLVMCreateBuilderInContext(C)
    @runtime_ccall (:LLVMCreateBuilderInContext, libllvm[]) LLVMBuilderRef (LLVMContextRef,) C
end

function LLVMCreateBuilder()
    @runtime_ccall (:LLVMCreateBuilder, libllvm[]) LLVMBuilderRef ()
end

function LLVMPositionBuilder(Builder, Block, Instr)
    @runtime_ccall (:LLVMPositionBuilder, libllvm[]) Cvoid (LLVMBuilderRef, LLVMBasicBlockRef, LLVMValueRef) Builder Block Instr
end

function LLVMPositionBuilderBefore(Builder, Instr)
    @runtime_ccall (:LLVMPositionBuilderBefore, libllvm[]) Cvoid (LLVMBuilderRef, LLVMValueRef) Builder Instr
end

function LLVMPositionBuilderAtEnd(Builder, Block)
    @runtime_ccall (:LLVMPositionBuilderAtEnd, libllvm[]) Cvoid (LLVMBuilderRef, LLVMBasicBlockRef) Builder Block
end

function LLVMGetInsertBlock(Builder)
    @runtime_ccall (:LLVMGetInsertBlock, libllvm[]) LLVMBasicBlockRef (LLVMBuilderRef,) Builder
end

function LLVMClearInsertionPosition(Builder)
    @runtime_ccall (:LLVMClearInsertionPosition, libllvm[]) Cvoid (LLVMBuilderRef,) Builder
end

function LLVMInsertIntoBuilder(Builder, Instr)
    @runtime_ccall (:LLVMInsertIntoBuilder, libllvm[]) Cvoid (LLVMBuilderRef, LLVMValueRef) Builder Instr
end

function LLVMInsertIntoBuilderWithName(Builder, Instr, Name)
    @runtime_ccall (:LLVMInsertIntoBuilderWithName, libllvm[]) Cvoid (LLVMBuilderRef, LLVMValueRef, Cstring) Builder Instr Name
end

function LLVMDisposeBuilder(Builder)
    @runtime_ccall (:LLVMDisposeBuilder, libllvm[]) Cvoid (LLVMBuilderRef,) Builder
end

function LLVMGetCurrentDebugLocation2(Builder)
    @runtime_ccall (:LLVMGetCurrentDebugLocation2, libllvm[]) LLVMMetadataRef (LLVMBuilderRef,) Builder
end

function LLVMSetCurrentDebugLocation2(Builder, Loc)
    @runtime_ccall (:LLVMSetCurrentDebugLocation2, libllvm[]) Cvoid (LLVMBuilderRef, LLVMMetadataRef) Builder Loc
end

function LLVMSetInstDebugLocation(Builder, Inst)
    @runtime_ccall (:LLVMSetInstDebugLocation, libllvm[]) Cvoid (LLVMBuilderRef, LLVMValueRef) Builder Inst
end

function LLVMBuilderGetDefaultFPMathTag(Builder)
    @runtime_ccall (:LLVMBuilderGetDefaultFPMathTag, libllvm[]) LLVMMetadataRef (LLVMBuilderRef,) Builder
end

function LLVMBuilderSetDefaultFPMathTag(Builder, FPMathTag)
    @runtime_ccall (:LLVMBuilderSetDefaultFPMathTag, libllvm[]) Cvoid (LLVMBuilderRef, LLVMMetadataRef) Builder FPMathTag
end

function LLVMSetCurrentDebugLocation(Builder, L)
    @runtime_ccall (:LLVMSetCurrentDebugLocation, libllvm[]) Cvoid (LLVMBuilderRef, LLVMValueRef) Builder L
end

function LLVMGetCurrentDebugLocation(Builder)
    @runtime_ccall (:LLVMGetCurrentDebugLocation, libllvm[]) LLVMValueRef (LLVMBuilderRef,) Builder
end

function LLVMBuildRetVoid(arg1)
    @runtime_ccall (:LLVMBuildRetVoid, libllvm[]) LLVMValueRef (LLVMBuilderRef,) arg1
end

function LLVMBuildRet(arg1, V)
    @runtime_ccall (:LLVMBuildRet, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef) arg1 V
end

function LLVMBuildAggregateRet(arg1, RetVals, N)
    @runtime_ccall (:LLVMBuildAggregateRet, libllvm[]) LLVMValueRef (LLVMBuilderRef, Ptr{LLVMValueRef}, Cuint) arg1 RetVals N
end

function LLVMBuildBr(arg1, Dest)
    @runtime_ccall (:LLVMBuildBr, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMBasicBlockRef) arg1 Dest
end

function LLVMBuildCondBr(arg1, If, Then, Else)
    @runtime_ccall (:LLVMBuildCondBr, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, LLVMBasicBlockRef) arg1 If Then Else
end

function LLVMBuildSwitch(arg1, V, Else, NumCases)
    @runtime_ccall (:LLVMBuildSwitch, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, Cuint) arg1 V Else NumCases
end

function LLVMBuildIndirectBr(B, Addr, NumDests)
    @runtime_ccall (:LLVMBuildIndirectBr, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Cuint) B Addr NumDests
end

function LLVMBuildInvoke(arg1, Fn, Args, NumArgs, Then, Catch, Name)
    @runtime_ccall (:LLVMBuildInvoke, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, LLVMBasicBlockRef, LLVMBasicBlockRef, Cstring) arg1 Fn Args NumArgs Then Catch Name
end

function LLVMBuildInvoke2(arg1, Ty, Fn, Args, NumArgs, Then, Catch, Name)
    @runtime_ccall (:LLVMBuildInvoke2, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, LLVMBasicBlockRef, LLVMBasicBlockRef, Cstring) arg1 Ty Fn Args NumArgs Then Catch Name
end

function LLVMBuildUnreachable(arg1)
    @runtime_ccall (:LLVMBuildUnreachable, libllvm[]) LLVMValueRef (LLVMBuilderRef,) arg1
end

function LLVMBuildResume(B, Exn)
    @runtime_ccall (:LLVMBuildResume, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef) B Exn
end

function LLVMBuildLandingPad(B, Ty, PersFn, NumClauses, Name)
    @runtime_ccall (:LLVMBuildLandingPad, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cuint, Cstring) B Ty PersFn NumClauses Name
end

function LLVMBuildCleanupRet(B, CatchPad, BB)
    @runtime_ccall (:LLVMBuildCleanupRet, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef) B CatchPad BB
end

function LLVMBuildCatchRet(B, CatchPad, BB)
    @runtime_ccall (:LLVMBuildCatchRet, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef) B CatchPad BB
end

function LLVMBuildCatchPad(B, ParentPad, Args, NumArgs, Name)
    @runtime_ccall (:LLVMBuildCatchPad, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring) B ParentPad Args NumArgs Name
end

function LLVMBuildCleanupPad(B, ParentPad, Args, NumArgs, Name)
    @runtime_ccall (:LLVMBuildCleanupPad, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring) B ParentPad Args NumArgs Name
end

function LLVMBuildCatchSwitch(B, ParentPad, UnwindBB, NumHandlers, Name)
    @runtime_ccall (:LLVMBuildCatchSwitch, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, Cuint, Cstring) B ParentPad UnwindBB NumHandlers Name
end

function LLVMAddCase(Switch, OnVal, Dest)
    @runtime_ccall (:LLVMAddCase, libllvm[]) Cvoid (LLVMValueRef, LLVMValueRef, LLVMBasicBlockRef) Switch OnVal Dest
end

function LLVMAddDestination(IndirectBr, Dest)
    @runtime_ccall (:LLVMAddDestination, libllvm[]) Cvoid (LLVMValueRef, LLVMBasicBlockRef) IndirectBr Dest
end

function LLVMGetNumClauses(LandingPad)
    @runtime_ccall (:LLVMGetNumClauses, libllvm[]) Cuint (LLVMValueRef,) LandingPad
end

function LLVMGetClause(LandingPad, Idx)
    @runtime_ccall (:LLVMGetClause, libllvm[]) LLVMValueRef (LLVMValueRef, Cuint) LandingPad Idx
end

function LLVMAddClause(LandingPad, ClauseVal)
    @runtime_ccall (:LLVMAddClause, libllvm[]) Cvoid (LLVMValueRef, LLVMValueRef) LandingPad ClauseVal
end

function LLVMIsCleanup(LandingPad)
    @runtime_ccall (:LLVMIsCleanup, libllvm[]) LLVMBool (LLVMValueRef,) LandingPad
end

function LLVMSetCleanup(LandingPad, Val)
    @runtime_ccall (:LLVMSetCleanup, libllvm[]) Cvoid (LLVMValueRef, LLVMBool) LandingPad Val
end

function LLVMAddHandler(CatchSwitch, Dest)
    @runtime_ccall (:LLVMAddHandler, libllvm[]) Cvoid (LLVMValueRef, LLVMBasicBlockRef) CatchSwitch Dest
end

function LLVMGetNumHandlers(CatchSwitch)
    @runtime_ccall (:LLVMGetNumHandlers, libllvm[]) Cuint (LLVMValueRef,) CatchSwitch
end

function LLVMGetHandlers(CatchSwitch, Handlers)
    @runtime_ccall (:LLVMGetHandlers, libllvm[]) Cvoid (LLVMValueRef, Ptr{LLVMBasicBlockRef}) CatchSwitch Handlers
end

function LLVMGetArgOperand(Funclet, i)
    @runtime_ccall (:LLVMGetArgOperand, libllvm[]) LLVMValueRef (LLVMValueRef, Cuint) Funclet i
end

function LLVMSetArgOperand(Funclet, i, value)
    @runtime_ccall (:LLVMSetArgOperand, libllvm[]) Cvoid (LLVMValueRef, Cuint, LLVMValueRef) Funclet i value
end

function LLVMGetParentCatchSwitch(CatchPad)
    @runtime_ccall (:LLVMGetParentCatchSwitch, libllvm[]) LLVMValueRef (LLVMValueRef,) CatchPad
end

function LLVMSetParentCatchSwitch(CatchPad, CatchSwitch)
    @runtime_ccall (:LLVMSetParentCatchSwitch, libllvm[]) Cvoid (LLVMValueRef, LLVMValueRef) CatchPad CatchSwitch
end

function LLVMBuildAdd(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildAdd, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildNSWAdd(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildNSWAdd, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildNUWAdd(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildNUWAdd, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildFAdd(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildFAdd, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildSub(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildSub, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildNSWSub(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildNSWSub, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildNUWSub(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildNUWSub, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildFSub(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildFSub, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildMul(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildMul, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildNSWMul(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildNSWMul, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildNUWMul(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildNUWMul, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildFMul(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildFMul, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildUDiv(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildUDiv, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildExactUDiv(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildExactUDiv, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildSDiv(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildSDiv, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildExactSDiv(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildExactSDiv, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildFDiv(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildFDiv, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildURem(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildURem, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildSRem(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildSRem, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildFRem(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildFRem, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildShl(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildShl, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildLShr(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildLShr, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildAShr(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildAShr, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildAnd(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildAnd, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildOr(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildOr, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildXor(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildXor, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildBinOp(B, Op, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildBinOp, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMOpcode, LLVMValueRef, LLVMValueRef, Cstring) B Op LHS RHS Name
end

function LLVMBuildNeg(arg1, V, Name)
    @runtime_ccall (:LLVMBuildNeg, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Cstring) arg1 V Name
end

function LLVMBuildNSWNeg(B, V, Name)
    @runtime_ccall (:LLVMBuildNSWNeg, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Cstring) B V Name
end

function LLVMBuildNUWNeg(B, V, Name)
    @runtime_ccall (:LLVMBuildNUWNeg, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Cstring) B V Name
end

function LLVMBuildFNeg(arg1, V, Name)
    @runtime_ccall (:LLVMBuildFNeg, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Cstring) arg1 V Name
end

function LLVMBuildNot(arg1, V, Name)
    @runtime_ccall (:LLVMBuildNot, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Cstring) arg1 V Name
end

function LLVMBuildMalloc(arg1, Ty, Name)
    @runtime_ccall (:LLVMBuildMalloc, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMTypeRef, Cstring) arg1 Ty Name
end

function LLVMBuildArrayMalloc(arg1, Ty, Val, Name)
    @runtime_ccall (:LLVMBuildArrayMalloc, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring) arg1 Ty Val Name
end

function LLVMBuildMemSet(B, Ptr, Val, Len, Align)
    @runtime_ccall (:LLVMBuildMemSet, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cuint) B Ptr Val Len Align
end

function LLVMBuildMemCpy(B, Dst, DstAlign, Src, SrcAlign, Size)
    @runtime_ccall (:LLVMBuildMemCpy, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Cuint, LLVMValueRef, Cuint, LLVMValueRef) B Dst DstAlign Src SrcAlign Size
end

function LLVMBuildMemMove(B, Dst, DstAlign, Src, SrcAlign, Size)
    @runtime_ccall (:LLVMBuildMemMove, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Cuint, LLVMValueRef, Cuint, LLVMValueRef) B Dst DstAlign Src SrcAlign Size
end

function LLVMBuildAlloca(arg1, Ty, Name)
    @runtime_ccall (:LLVMBuildAlloca, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMTypeRef, Cstring) arg1 Ty Name
end

function LLVMBuildArrayAlloca(arg1, Ty, Val, Name)
    @runtime_ccall (:LLVMBuildArrayAlloca, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring) arg1 Ty Val Name
end

function LLVMBuildFree(arg1, PointerVal)
    @runtime_ccall (:LLVMBuildFree, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef) arg1 PointerVal
end

function LLVMBuildLoad(arg1, PointerVal, Name)
    @runtime_ccall (:LLVMBuildLoad, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Cstring) arg1 PointerVal Name
end

function LLVMBuildLoad2(arg1, Ty, PointerVal, Name)
    @runtime_ccall (:LLVMBuildLoad2, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring) arg1 Ty PointerVal Name
end

function LLVMBuildStore(arg1, Val, Ptr)
    @runtime_ccall (:LLVMBuildStore, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef) arg1 Val Ptr
end

function LLVMBuildGEP(B, Pointer, Indices, NumIndices, Name)
    @runtime_ccall (:LLVMBuildGEP, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring) B Pointer Indices NumIndices Name
end

function LLVMBuildInBoundsGEP(B, Pointer, Indices, NumIndices, Name)
    @runtime_ccall (:LLVMBuildInBoundsGEP, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring) B Pointer Indices NumIndices Name
end

function LLVMBuildStructGEP(B, Pointer, Idx, Name)
    @runtime_ccall (:LLVMBuildStructGEP, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Cuint, Cstring) B Pointer Idx Name
end

function LLVMBuildGEP2(B, Ty, Pointer, Indices, NumIndices, Name)
    @runtime_ccall (:LLVMBuildGEP2, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring) B Ty Pointer Indices NumIndices Name
end

function LLVMBuildInBoundsGEP2(B, Ty, Pointer, Indices, NumIndices, Name)
    @runtime_ccall (:LLVMBuildInBoundsGEP2, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring) B Ty Pointer Indices NumIndices Name
end

function LLVMBuildStructGEP2(B, Ty, Pointer, Idx, Name)
    @runtime_ccall (:LLVMBuildStructGEP2, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cuint, Cstring) B Ty Pointer Idx Name
end

function LLVMBuildGlobalString(B, Str, Name)
    @runtime_ccall (:LLVMBuildGlobalString, libllvm[]) LLVMValueRef (LLVMBuilderRef, Cstring, Cstring) B Str Name
end

function LLVMBuildGlobalStringPtr(B, Str, Name)
    @runtime_ccall (:LLVMBuildGlobalStringPtr, libllvm[]) LLVMValueRef (LLVMBuilderRef, Cstring, Cstring) B Str Name
end

function LLVMGetVolatile(MemoryAccessInst)
    @runtime_ccall (:LLVMGetVolatile, libllvm[]) LLVMBool (LLVMValueRef,) MemoryAccessInst
end

function LLVMSetVolatile(MemoryAccessInst, IsVolatile)
    @runtime_ccall (:LLVMSetVolatile, libllvm[]) Cvoid (LLVMValueRef, LLVMBool) MemoryAccessInst IsVolatile
end

function LLVMGetWeak(CmpXchgInst)
    @runtime_ccall (:LLVMGetWeak, libllvm[]) LLVMBool (LLVMValueRef,) CmpXchgInst
end

function LLVMSetWeak(CmpXchgInst, IsWeak)
    @runtime_ccall (:LLVMSetWeak, libllvm[]) Cvoid (LLVMValueRef, LLVMBool) CmpXchgInst IsWeak
end

function LLVMGetOrdering(MemoryAccessInst)
    @runtime_ccall (:LLVMGetOrdering, libllvm[]) LLVMAtomicOrdering (LLVMValueRef,) MemoryAccessInst
end

function LLVMSetOrdering(MemoryAccessInst, Ordering)
    @runtime_ccall (:LLVMSetOrdering, libllvm[]) Cvoid (LLVMValueRef, LLVMAtomicOrdering) MemoryAccessInst Ordering
end

function LLVMGetAtomicRMWBinOp(AtomicRMWInst)
    @runtime_ccall (:LLVMGetAtomicRMWBinOp, libllvm[]) LLVMAtomicRMWBinOp (LLVMValueRef,) AtomicRMWInst
end

function LLVMSetAtomicRMWBinOp(AtomicRMWInst, BinOp)
    @runtime_ccall (:LLVMSetAtomicRMWBinOp, libllvm[]) Cvoid (LLVMValueRef, LLVMAtomicRMWBinOp) AtomicRMWInst BinOp
end

function LLVMBuildTrunc(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildTrunc, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildZExt(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildZExt, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildSExt(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildSExt, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildFPToUI(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildFPToUI, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildFPToSI(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildFPToSI, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildUIToFP(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildUIToFP, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildSIToFP(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildSIToFP, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildFPTrunc(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildFPTrunc, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildFPExt(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildFPExt, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildPtrToInt(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildPtrToInt, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildIntToPtr(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildIntToPtr, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildBitCast(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildBitCast, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildAddrSpaceCast(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildAddrSpaceCast, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildZExtOrBitCast(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildZExtOrBitCast, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildSExtOrBitCast(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildSExtOrBitCast, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildTruncOrBitCast(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildTruncOrBitCast, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildCast(B, Op, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildCast, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMOpcode, LLVMValueRef, LLVMTypeRef, Cstring) B Op Val DestTy Name
end

function LLVMBuildPointerCast(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildPointerCast, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildIntCast2(arg1, Val, DestTy, IsSigned, Name)
    @runtime_ccall (:LLVMBuildIntCast2, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, LLVMBool, Cstring) arg1 Val DestTy IsSigned Name
end

function LLVMBuildFPCast(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildFPCast, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildIntCast(arg1, Val, DestTy, Name)
    @runtime_ccall (:LLVMBuildIntCast, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 Val DestTy Name
end

function LLVMBuildICmp(arg1, Op, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildICmp, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMIntPredicate, LLVMValueRef, LLVMValueRef, Cstring) arg1 Op LHS RHS Name
end

function LLVMBuildFCmp(arg1, Op, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildFCmp, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMRealPredicate, LLVMValueRef, LLVMValueRef, Cstring) arg1 Op LHS RHS Name
end

function LLVMBuildPhi(arg1, Ty, Name)
    @runtime_ccall (:LLVMBuildPhi, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMTypeRef, Cstring) arg1 Ty Name
end

function LLVMBuildCall(arg1, Fn, Args, NumArgs, Name)
    @runtime_ccall (:LLVMBuildCall, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring) arg1 Fn Args NumArgs Name
end

function LLVMBuildCall2(arg1, arg2, Fn, Args, NumArgs, Name)
    @runtime_ccall (:LLVMBuildCall2, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring) arg1 arg2 Fn Args NumArgs Name
end

function LLVMBuildSelect(arg1, If, Then, Else, Name)
    @runtime_ccall (:LLVMBuildSelect, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 If Then Else Name
end

function LLVMBuildVAArg(arg1, List, Ty, Name)
    @runtime_ccall (:LLVMBuildVAArg, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring) arg1 List Ty Name
end

function LLVMBuildExtractElement(arg1, VecVal, Index, Name)
    @runtime_ccall (:LLVMBuildExtractElement, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 VecVal Index Name
end

function LLVMBuildInsertElement(arg1, VecVal, EltVal, Index, Name)
    @runtime_ccall (:LLVMBuildInsertElement, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 VecVal EltVal Index Name
end

function LLVMBuildShuffleVector(arg1, V1, V2, Mask, Name)
    @runtime_ccall (:LLVMBuildShuffleVector, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 V1 V2 Mask Name
end

function LLVMBuildExtractValue(arg1, AggVal, Index, Name)
    @runtime_ccall (:LLVMBuildExtractValue, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Cuint, Cstring) arg1 AggVal Index Name
end

function LLVMBuildInsertValue(arg1, AggVal, EltVal, Index, Name)
    @runtime_ccall (:LLVMBuildInsertValue, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cuint, Cstring) arg1 AggVal EltVal Index Name
end

function LLVMBuildFreeze(arg1, Val, Name)
    @runtime_ccall (:LLVMBuildFreeze, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Cstring) arg1 Val Name
end

function LLVMBuildIsNull(arg1, Val, Name)
    @runtime_ccall (:LLVMBuildIsNull, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Cstring) arg1 Val Name
end

function LLVMBuildIsNotNull(arg1, Val, Name)
    @runtime_ccall (:LLVMBuildIsNotNull, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, Cstring) arg1 Val Name
end

function LLVMBuildPtrDiff(arg1, LHS, RHS, Name)
    @runtime_ccall (:LLVMBuildPtrDiff, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring) arg1 LHS RHS Name
end

function LLVMBuildFence(B, ordering, singleThread, Name)
    @runtime_ccall (:LLVMBuildFence, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMAtomicOrdering, LLVMBool, Cstring) B ordering singleThread Name
end

function LLVMBuildAtomicRMW(B, op, PTR, Val, ordering, singleThread)
    @runtime_ccall (:LLVMBuildAtomicRMW, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMAtomicRMWBinOp, LLVMValueRef, LLVMValueRef, LLVMAtomicOrdering, LLVMBool) B op PTR Val ordering singleThread
end

function LLVMBuildAtomicCmpXchg(B, Ptr, Cmp, New, SuccessOrdering, FailureOrdering, SingleThread)
    @runtime_ccall (:LLVMBuildAtomicCmpXchg, libllvm[]) LLVMValueRef (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, LLVMAtomicOrdering, LLVMAtomicOrdering, LLVMBool) B Ptr Cmp New SuccessOrdering FailureOrdering SingleThread
end

function LLVMGetNumMaskElements(ShuffleVectorInst)
    @runtime_ccall (:LLVMGetNumMaskElements, libllvm[]) Cuint (LLVMValueRef,) ShuffleVectorInst
end

function LLVMGetUndefMaskElem()
    @runtime_ccall (:LLVMGetUndefMaskElem, libllvm[]) Cint ()
end

function LLVMGetMaskValue(ShuffleVectorInst, Elt)
    @runtime_ccall (:LLVMGetMaskValue, libllvm[]) Cint (LLVMValueRef, Cuint) ShuffleVectorInst Elt
end

function LLVMIsAtomicSingleThread(AtomicInst)
    @runtime_ccall (:LLVMIsAtomicSingleThread, libllvm[]) LLVMBool (LLVMValueRef,) AtomicInst
end

function LLVMSetAtomicSingleThread(AtomicInst, SingleThread)
    @runtime_ccall (:LLVMSetAtomicSingleThread, libllvm[]) Cvoid (LLVMValueRef, LLVMBool) AtomicInst SingleThread
end

function LLVMGetCmpXchgSuccessOrdering(CmpXchgInst)
    @runtime_ccall (:LLVMGetCmpXchgSuccessOrdering, libllvm[]) LLVMAtomicOrdering (LLVMValueRef,) CmpXchgInst
end

function LLVMSetCmpXchgSuccessOrdering(CmpXchgInst, Ordering)
    @runtime_ccall (:LLVMSetCmpXchgSuccessOrdering, libllvm[]) Cvoid (LLVMValueRef, LLVMAtomicOrdering) CmpXchgInst Ordering
end

function LLVMGetCmpXchgFailureOrdering(CmpXchgInst)
    @runtime_ccall (:LLVMGetCmpXchgFailureOrdering, libllvm[]) LLVMAtomicOrdering (LLVMValueRef,) CmpXchgInst
end

function LLVMSetCmpXchgFailureOrdering(CmpXchgInst, Ordering)
    @runtime_ccall (:LLVMSetCmpXchgFailureOrdering, libllvm[]) Cvoid (LLVMValueRef, LLVMAtomicOrdering) CmpXchgInst Ordering
end

mutable struct LLVMOpaqueModuleProvider end

const LLVMModuleProviderRef = Ptr{LLVMOpaqueModuleProvider}

function LLVMCreateModuleProviderForExistingModule(M)
    @runtime_ccall (:LLVMCreateModuleProviderForExistingModule, libllvm[]) LLVMModuleProviderRef (LLVMModuleRef,) M
end

function LLVMDisposeModuleProvider(M)
    @runtime_ccall (:LLVMDisposeModuleProvider, libllvm[]) Cvoid (LLVMModuleProviderRef,) M
end

function LLVMCreateMemoryBufferWithContentsOfFile(Path, OutMemBuf, OutMessage)
    @runtime_ccall (:LLVMCreateMemoryBufferWithContentsOfFile, libllvm[]) LLVMBool (Cstring, Ptr{LLVMMemoryBufferRef}, Ptr{Cstring}) Path OutMemBuf OutMessage
end

function LLVMCreateMemoryBufferWithSTDIN(OutMemBuf, OutMessage)
    @runtime_ccall (:LLVMCreateMemoryBufferWithSTDIN, libllvm[]) LLVMBool (Ptr{LLVMMemoryBufferRef}, Ptr{Cstring}) OutMemBuf OutMessage
end

function LLVMCreateMemoryBufferWithMemoryRange(InputData, InputDataLength, BufferName, RequiresNullTerminator)
    @runtime_ccall (:LLVMCreateMemoryBufferWithMemoryRange, libllvm[]) LLVMMemoryBufferRef (Cstring, Csize_t, Cstring, LLVMBool) InputData InputDataLength BufferName RequiresNullTerminator
end

function LLVMCreateMemoryBufferWithMemoryRangeCopy(InputData, InputDataLength, BufferName)
    @runtime_ccall (:LLVMCreateMemoryBufferWithMemoryRangeCopy, libllvm[]) LLVMMemoryBufferRef (Cstring, Csize_t, Cstring) InputData InputDataLength BufferName
end

function LLVMGetBufferStart(MemBuf)
    @runtime_ccall (:LLVMGetBufferStart, libllvm[]) Cstring (LLVMMemoryBufferRef,) MemBuf
end

function LLVMGetBufferSize(MemBuf)
    @runtime_ccall (:LLVMGetBufferSize, libllvm[]) Csize_t (LLVMMemoryBufferRef,) MemBuf
end

function LLVMDisposeMemoryBuffer(MemBuf)
    @runtime_ccall (:LLVMDisposeMemoryBuffer, libllvm[]) Cvoid (LLVMMemoryBufferRef,) MemBuf
end

function LLVMGetGlobalPassRegistry()
    @runtime_ccall (:LLVMGetGlobalPassRegistry, libllvm[]) LLVMPassRegistryRef ()
end

mutable struct LLVMOpaquePassManager end

const LLVMPassManagerRef = Ptr{LLVMOpaquePassManager}

function LLVMCreatePassManager()
    @runtime_ccall (:LLVMCreatePassManager, libllvm[]) LLVMPassManagerRef ()
end

function LLVMCreateFunctionPassManagerForModule(M)
    @runtime_ccall (:LLVMCreateFunctionPassManagerForModule, libllvm[]) LLVMPassManagerRef (LLVMModuleRef,) M
end

function LLVMCreateFunctionPassManager(MP)
    @runtime_ccall (:LLVMCreateFunctionPassManager, libllvm[]) LLVMPassManagerRef (LLVMModuleProviderRef,) MP
end

function LLVMRunPassManager(PM, M)
    @runtime_ccall (:LLVMRunPassManager, libllvm[]) LLVMBool (LLVMPassManagerRef, LLVMModuleRef) PM M
end

function LLVMInitializeFunctionPassManager(FPM)
    @runtime_ccall (:LLVMInitializeFunctionPassManager, libllvm[]) LLVMBool (LLVMPassManagerRef,) FPM
end

function LLVMRunFunctionPassManager(FPM, F)
    @runtime_ccall (:LLVMRunFunctionPassManager, libllvm[]) LLVMBool (LLVMPassManagerRef, LLVMValueRef) FPM F
end

function LLVMFinalizeFunctionPassManager(FPM)
    @runtime_ccall (:LLVMFinalizeFunctionPassManager, libllvm[]) LLVMBool (LLVMPassManagerRef,) FPM
end

function LLVMDisposePassManager(PM)
    @runtime_ccall (:LLVMDisposePassManager, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMStartMultithreaded()
    @runtime_ccall (:LLVMStartMultithreaded, libllvm[]) LLVMBool ()
end

function LLVMStopMultithreaded()
    @runtime_ccall (:LLVMStopMultithreaded, libllvm[]) Cvoid ()
end

function LLVMIsMultithreaded()
    @runtime_ccall (:LLVMIsMultithreaded, libllvm[]) LLVMBool ()
end

@cenum LLVMDIFlags::UInt32 begin
    LLVMDIFlagZero = 0
    LLVMDIFlagPrivate = 1
    LLVMDIFlagProtected = 2
    LLVMDIFlagPublic = 3
    LLVMDIFlagFwdDecl = 4
    LLVMDIFlagAppleBlock = 8
    LLVMDIFlagReservedBit4 = 16
    LLVMDIFlagVirtual = 32
    LLVMDIFlagArtificial = 64
    LLVMDIFlagExplicit = 128
    LLVMDIFlagPrototyped = 256
    LLVMDIFlagObjcClassComplete = 512
    LLVMDIFlagObjectPointer = 1024
    LLVMDIFlagVector = 2048
    LLVMDIFlagStaticMember = 4096
    LLVMDIFlagLValueReference = 8192
    LLVMDIFlagRValueReference = 16384
    LLVMDIFlagReserved = 32768
    LLVMDIFlagSingleInheritance = 65536
    LLVMDIFlagMultipleInheritance = 131072
    LLVMDIFlagVirtualInheritance = 196608
    LLVMDIFlagIntroducedVirtual = 262144
    LLVMDIFlagBitField = 524288
    LLVMDIFlagNoReturn = 1048576
    LLVMDIFlagTypePassByValue = 4194304
    LLVMDIFlagTypePassByReference = 8388608
    LLVMDIFlagEnumClass = 16777216
    LLVMDIFlagFixedEnum = 16777216
    LLVMDIFlagThunk = 33554432
    LLVMDIFlagNonTrivial = 67108864
    LLVMDIFlagBigEndian = 134217728
    LLVMDIFlagLittleEndian = 268435456
    LLVMDIFlagIndirectVirtualBase = 36
    LLVMDIFlagAccessibility = 3
    LLVMDIFlagPtrToMemberRep = 196608
end

@cenum LLVMDWARFSourceLanguage::UInt32 begin
    LLVMDWARFSourceLanguageC89 = 0
    LLVMDWARFSourceLanguageC = 1
    LLVMDWARFSourceLanguageAda83 = 2
    LLVMDWARFSourceLanguageC_plus_plus = 3
    LLVMDWARFSourceLanguageCobol74 = 4
    LLVMDWARFSourceLanguageCobol85 = 5
    LLVMDWARFSourceLanguageFortran77 = 6
    LLVMDWARFSourceLanguageFortran90 = 7
    LLVMDWARFSourceLanguagePascal83 = 8
    LLVMDWARFSourceLanguageModula2 = 9
    LLVMDWARFSourceLanguageJava = 10
    LLVMDWARFSourceLanguageC99 = 11
    LLVMDWARFSourceLanguageAda95 = 12
    LLVMDWARFSourceLanguageFortran95 = 13
    LLVMDWARFSourceLanguagePLI = 14
    LLVMDWARFSourceLanguageObjC = 15
    LLVMDWARFSourceLanguageObjC_plus_plus = 16
    LLVMDWARFSourceLanguageUPC = 17
    LLVMDWARFSourceLanguageD = 18
    LLVMDWARFSourceLanguagePython = 19
    LLVMDWARFSourceLanguageOpenCL = 20
    LLVMDWARFSourceLanguageGo = 21
    LLVMDWARFSourceLanguageModula3 = 22
    LLVMDWARFSourceLanguageHaskell = 23
    LLVMDWARFSourceLanguageC_plus_plus_03 = 24
    LLVMDWARFSourceLanguageC_plus_plus_11 = 25
    LLVMDWARFSourceLanguageOCaml = 26
    LLVMDWARFSourceLanguageRust = 27
    LLVMDWARFSourceLanguageC11 = 28
    LLVMDWARFSourceLanguageSwift = 29
    LLVMDWARFSourceLanguageJulia = 30
    LLVMDWARFSourceLanguageDylan = 31
    LLVMDWARFSourceLanguageC_plus_plus_14 = 32
    LLVMDWARFSourceLanguageFortran03 = 33
    LLVMDWARFSourceLanguageFortran08 = 34
    LLVMDWARFSourceLanguageRenderScript = 35
    LLVMDWARFSourceLanguageBLISS = 36
    LLVMDWARFSourceLanguageMips_Assembler = 37
    LLVMDWARFSourceLanguageGOOGLE_RenderScript = 38
    LLVMDWARFSourceLanguageBORLAND_Delphi = 39
end

@cenum LLVMDWARFEmissionKind::UInt32 begin
    LLVMDWARFEmissionNone = 0
    LLVMDWARFEmissionFull = 1
    LLVMDWARFEmissionLineTablesOnly = 2
end

@cenum __JL_Ctag_24::UInt32 begin
    LLVMMDStringMetadataKind = 0
    LLVMConstantAsMetadataMetadataKind = 1
    LLVMLocalAsMetadataMetadataKind = 2
    LLVMDistinctMDOperandPlaceholderMetadataKind = 3
    LLVMMDTupleMetadataKind = 4
    LLVMDILocationMetadataKind = 5
    LLVMDIExpressionMetadataKind = 6
    LLVMDIGlobalVariableExpressionMetadataKind = 7
    LLVMGenericDINodeMetadataKind = 8
    LLVMDISubrangeMetadataKind = 9
    LLVMDIEnumeratorMetadataKind = 10
    LLVMDIBasicTypeMetadataKind = 11
    LLVMDIDerivedTypeMetadataKind = 12
    LLVMDICompositeTypeMetadataKind = 13
    LLVMDISubroutineTypeMetadataKind = 14
    LLVMDIFileMetadataKind = 15
    LLVMDICompileUnitMetadataKind = 16
    LLVMDISubprogramMetadataKind = 17
    LLVMDILexicalBlockMetadataKind = 18
    LLVMDILexicalBlockFileMetadataKind = 19
    LLVMDINamespaceMetadataKind = 20
    LLVMDIModuleMetadataKind = 21
    LLVMDITemplateTypeParameterMetadataKind = 22
    LLVMDITemplateValueParameterMetadataKind = 23
    LLVMDIGlobalVariableMetadataKind = 24
    LLVMDILocalVariableMetadataKind = 25
    LLVMDILabelMetadataKind = 26
    LLVMDIObjCPropertyMetadataKind = 27
    LLVMDIImportedEntityMetadataKind = 28
    LLVMDIMacroMetadataKind = 29
    LLVMDIMacroFileMetadataKind = 30
    LLVMDICommonBlockMetadataKind = 31
end

const LLVMMetadataKind = Cuint

const LLVMDWARFTypeEncoding = Cuint

@cenum LLVMDWARFMacinfoRecordType::UInt32 begin
    LLVMDWARFMacinfoRecordTypeDefine = 1
    LLVMDWARFMacinfoRecordTypeMacro = 2
    LLVMDWARFMacinfoRecordTypeStartFile = 3
    LLVMDWARFMacinfoRecordTypeEndFile = 4
    LLVMDWARFMacinfoRecordTypeVendorExt = 255
end

function LLVMDebugMetadataVersion()
    @runtime_ccall (:LLVMDebugMetadataVersion, libllvm[]) Cuint ()
end

function LLVMGetModuleDebugMetadataVersion(Module)
    @runtime_ccall (:LLVMGetModuleDebugMetadataVersion, libllvm[]) Cuint (LLVMModuleRef,) Module
end

function LLVMStripModuleDebugInfo(Module)
    @runtime_ccall (:LLVMStripModuleDebugInfo, libllvm[]) LLVMBool (LLVMModuleRef,) Module
end

mutable struct LLVMOpaqueDIBuilder end

const LLVMDIBuilderRef = Ptr{LLVMOpaqueDIBuilder}

function LLVMCreateDIBuilderDisallowUnresolved(M)
    @runtime_ccall (:LLVMCreateDIBuilderDisallowUnresolved, libllvm[]) LLVMDIBuilderRef (LLVMModuleRef,) M
end

function LLVMCreateDIBuilder(M)
    @runtime_ccall (:LLVMCreateDIBuilder, libllvm[]) LLVMDIBuilderRef (LLVMModuleRef,) M
end

function LLVMDisposeDIBuilder(Builder)
    @runtime_ccall (:LLVMDisposeDIBuilder, libllvm[]) Cvoid (LLVMDIBuilderRef,) Builder
end

function LLVMDIBuilderFinalize(Builder)
    @runtime_ccall (:LLVMDIBuilderFinalize, libllvm[]) Cvoid (LLVMDIBuilderRef,) Builder
end

function LLVMDIBuilderCreateCompileUnit(Builder, Lang, FileRef, Producer, ProducerLen, isOptimized, Flags, FlagsLen, RuntimeVer, SplitName, SplitNameLen, Kind, DWOId, SplitDebugInlining, DebugInfoForProfiling, SysRoot, SysRootLen, SDK, SDKLen)
    @runtime_ccall (:LLVMDIBuilderCreateCompileUnit, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMDWARFSourceLanguage, LLVMMetadataRef, Cstring, Csize_t, LLVMBool, Cstring, Csize_t, Cuint, Cstring, Csize_t, LLVMDWARFEmissionKind, Cuint, LLVMBool, LLVMBool, Cstring, Csize_t, Cstring, Csize_t) Builder Lang FileRef Producer ProducerLen isOptimized Flags FlagsLen RuntimeVer SplitName SplitNameLen Kind DWOId SplitDebugInlining DebugInfoForProfiling SysRoot SysRootLen SDK SDKLen
end

function LLVMDIBuilderCreateFile(Builder, Filename, FilenameLen, Directory, DirectoryLen)
    @runtime_ccall (:LLVMDIBuilderCreateFile, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Cstring, Csize_t, Cstring, Csize_t) Builder Filename FilenameLen Directory DirectoryLen
end

function LLVMDIBuilderCreateModule(Builder, ParentScope, Name, NameLen, ConfigMacros, ConfigMacrosLen, IncludePath, IncludePathLen, APINotesFile, APINotesFileLen)
    @runtime_ccall (:LLVMDIBuilderCreateModule, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, Cstring, Csize_t, Cstring, Csize_t, Cstring, Csize_t) Builder ParentScope Name NameLen ConfigMacros ConfigMacrosLen IncludePath IncludePathLen APINotesFile APINotesFileLen
end

function LLVMDIBuilderCreateNameSpace(Builder, ParentScope, Name, NameLen, ExportSymbols)
    @runtime_ccall (:LLVMDIBuilderCreateNameSpace, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMBool) Builder ParentScope Name NameLen ExportSymbols
end

function LLVMDIBuilderCreateFunction(Builder, Scope, Name, NameLen, LinkageName, LinkageNameLen, File, LineNo, Ty, IsLocalToUnit, IsDefinition, ScopeLine, Flags, IsOptimized)
    @runtime_ccall (:LLVMDIBuilderCreateFunction, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, Cstring, Csize_t, LLVMMetadataRef, Cuint, LLVMMetadataRef, LLVMBool, LLVMBool, Cuint, LLVMDIFlags, LLVMBool) Builder Scope Name NameLen LinkageName LinkageNameLen File LineNo Ty IsLocalToUnit IsDefinition ScopeLine Flags IsOptimized
end

function LLVMDIBuilderCreateLexicalBlock(Builder, Scope, File, Line, Column)
    @runtime_ccall (:LLVMDIBuilderCreateLexicalBlock, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, Cuint, Cuint) Builder Scope File Line Column
end

function LLVMDIBuilderCreateLexicalBlockFile(Builder, Scope, File, Discriminator)
    @runtime_ccall (:LLVMDIBuilderCreateLexicalBlockFile, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, Cuint) Builder Scope File Discriminator
end

function LLVMDIBuilderCreateImportedModuleFromNamespace(Builder, Scope, NS, File, Line)
    @runtime_ccall (:LLVMDIBuilderCreateImportedModuleFromNamespace, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, Cuint) Builder Scope NS File Line
end

function LLVMDIBuilderCreateImportedModuleFromAlias(Builder, Scope, ImportedEntity, File, Line)
    @runtime_ccall (:LLVMDIBuilderCreateImportedModuleFromAlias, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, Cuint) Builder Scope ImportedEntity File Line
end

function LLVMDIBuilderCreateImportedModuleFromModule(Builder, Scope, M, File, Line)
    @runtime_ccall (:LLVMDIBuilderCreateImportedModuleFromModule, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, Cuint) Builder Scope M File Line
end

function LLVMDIBuilderCreateImportedDeclaration(Builder, Scope, Decl, File, Line, Name, NameLen)
    @runtime_ccall (:LLVMDIBuilderCreateImportedDeclaration, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, Cuint, Cstring, Csize_t) Builder Scope Decl File Line Name NameLen
end

function LLVMDIBuilderCreateDebugLocation(Ctx, Line, Column, Scope, InlinedAt)
    @runtime_ccall (:LLVMDIBuilderCreateDebugLocation, libllvm[]) LLVMMetadataRef (LLVMContextRef, Cuint, Cuint, LLVMMetadataRef, LLVMMetadataRef) Ctx Line Column Scope InlinedAt
end

function LLVMDILocationGetLine(Location)
    @runtime_ccall (:LLVMDILocationGetLine, libllvm[]) Cuint (LLVMMetadataRef,) Location
end

function LLVMDILocationGetColumn(Location)
    @runtime_ccall (:LLVMDILocationGetColumn, libllvm[]) Cuint (LLVMMetadataRef,) Location
end

function LLVMDILocationGetScope(Location)
    @runtime_ccall (:LLVMDILocationGetScope, libllvm[]) LLVMMetadataRef (LLVMMetadataRef,) Location
end

function LLVMDILocationGetInlinedAt(Location)
    @runtime_ccall (:LLVMDILocationGetInlinedAt, libllvm[]) LLVMMetadataRef (LLVMMetadataRef,) Location
end

function LLVMDIScopeGetFile(Scope)
    @runtime_ccall (:LLVMDIScopeGetFile, libllvm[]) LLVMMetadataRef (LLVMMetadataRef,) Scope
end

function LLVMDIFileGetDirectory(File, Len)
    @runtime_ccall (:LLVMDIFileGetDirectory, libllvm[]) Cstring (LLVMMetadataRef, Ptr{Cuint}) File Len
end

function LLVMDIFileGetFilename(File, Len)
    @runtime_ccall (:LLVMDIFileGetFilename, libllvm[]) Cstring (LLVMMetadataRef, Ptr{Cuint}) File Len
end

function LLVMDIFileGetSource(File, Len)
    @runtime_ccall (:LLVMDIFileGetSource, libllvm[]) Cstring (LLVMMetadataRef, Ptr{Cuint}) File Len
end

function LLVMDIBuilderGetOrCreateTypeArray(Builder, Data, NumElements)
    @runtime_ccall (:LLVMDIBuilderGetOrCreateTypeArray, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Ptr{LLVMMetadataRef}, Csize_t) Builder Data NumElements
end

function LLVMDIBuilderCreateSubroutineType(Builder, File, ParameterTypes, NumParameterTypes, Flags)
    @runtime_ccall (:LLVMDIBuilderCreateSubroutineType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Ptr{LLVMMetadataRef}, Cuint, LLVMDIFlags) Builder File ParameterTypes NumParameterTypes Flags
end

function LLVMDIBuilderCreateMacro(Builder, ParentMacroFile, Line, RecordType, Name, NameLen, Value, ValueLen)
    @runtime_ccall (:LLVMDIBuilderCreateMacro, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cuint, LLVMDWARFMacinfoRecordType, Cstring, Csize_t, Cstring, Csize_t) Builder ParentMacroFile Line RecordType Name NameLen Value ValueLen
end

function LLVMDIBuilderCreateTempMacroFile(Builder, ParentMacroFile, Line, File)
    @runtime_ccall (:LLVMDIBuilderCreateTempMacroFile, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cuint, LLVMMetadataRef) Builder ParentMacroFile Line File
end

function LLVMDIBuilderCreateEnumerator(Builder, Name, NameLen, Value, IsUnsigned)
    @runtime_ccall (:LLVMDIBuilderCreateEnumerator, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Cstring, Csize_t, Int64, LLVMBool) Builder Name NameLen Value IsUnsigned
end

function LLVMDIBuilderCreateEnumerationType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Elements, NumElements, ClassTy)
    @runtime_ccall (:LLVMDIBuilderCreateEnumerationType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, UInt64, UInt32, Ptr{LLVMMetadataRef}, Cuint, LLVMMetadataRef) Builder Scope Name NameLen File LineNumber SizeInBits AlignInBits Elements NumElements ClassTy
end

function LLVMDIBuilderCreateUnionType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Flags, Elements, NumElements, RunTimeLang, UniqueId, UniqueIdLen)
    @runtime_ccall (:LLVMDIBuilderCreateUnionType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, UInt64, UInt32, LLVMDIFlags, Ptr{LLVMMetadataRef}, Cuint, Cuint, Cstring, Csize_t) Builder Scope Name NameLen File LineNumber SizeInBits AlignInBits Flags Elements NumElements RunTimeLang UniqueId UniqueIdLen
end

function LLVMDIBuilderCreateArrayType(Builder, Size, AlignInBits, Ty, Subscripts, NumSubscripts)
    @runtime_ccall (:LLVMDIBuilderCreateArrayType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, UInt64, UInt32, LLVMMetadataRef, Ptr{LLVMMetadataRef}, Cuint) Builder Size AlignInBits Ty Subscripts NumSubscripts
end

function LLVMDIBuilderCreateVectorType(Builder, Size, AlignInBits, Ty, Subscripts, NumSubscripts)
    @runtime_ccall (:LLVMDIBuilderCreateVectorType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, UInt64, UInt32, LLVMMetadataRef, Ptr{LLVMMetadataRef}, Cuint) Builder Size AlignInBits Ty Subscripts NumSubscripts
end

function LLVMDIBuilderCreateUnspecifiedType(Builder, Name, NameLen)
    @runtime_ccall (:LLVMDIBuilderCreateUnspecifiedType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Cstring, Csize_t) Builder Name NameLen
end

function LLVMDIBuilderCreateBasicType(Builder, Name, NameLen, SizeInBits, Encoding, Flags)
    @runtime_ccall (:LLVMDIBuilderCreateBasicType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Cstring, Csize_t, UInt64, LLVMDWARFTypeEncoding, LLVMDIFlags) Builder Name NameLen SizeInBits Encoding Flags
end

function LLVMDIBuilderCreatePointerType(Builder, PointeeTy, SizeInBits, AlignInBits, AddressSpace, Name, NameLen)
    @runtime_ccall (:LLVMDIBuilderCreatePointerType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, UInt64, UInt32, Cuint, Cstring, Csize_t) Builder PointeeTy SizeInBits AlignInBits AddressSpace Name NameLen
end

function LLVMDIBuilderCreateStructType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Flags, DerivedFrom, Elements, NumElements, RunTimeLang, VTableHolder, UniqueId, UniqueIdLen)
    @runtime_ccall (:LLVMDIBuilderCreateStructType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, UInt64, UInt32, LLVMDIFlags, LLVMMetadataRef, Ptr{LLVMMetadataRef}, Cuint, Cuint, LLVMMetadataRef, Cstring, Csize_t) Builder Scope Name NameLen File LineNumber SizeInBits AlignInBits Flags DerivedFrom Elements NumElements RunTimeLang VTableHolder UniqueId UniqueIdLen
end

function LLVMDIBuilderCreateMemberType(Builder, Scope, Name, NameLen, File, LineNo, SizeInBits, AlignInBits, OffsetInBits, Flags, Ty)
    @runtime_ccall (:LLVMDIBuilderCreateMemberType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, UInt64, UInt32, UInt64, LLVMDIFlags, LLVMMetadataRef) Builder Scope Name NameLen File LineNo SizeInBits AlignInBits OffsetInBits Flags Ty
end

function LLVMDIBuilderCreateStaticMemberType(Builder, Scope, Name, NameLen, File, LineNumber, Type, Flags, ConstantVal, AlignInBits)
    @runtime_ccall (:LLVMDIBuilderCreateStaticMemberType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, LLVMMetadataRef, LLVMDIFlags, LLVMValueRef, UInt32) Builder Scope Name NameLen File LineNumber Type Flags ConstantVal AlignInBits
end

function LLVMDIBuilderCreateMemberPointerType(Builder, PointeeType, ClassType, SizeInBits, AlignInBits, Flags)
    @runtime_ccall (:LLVMDIBuilderCreateMemberPointerType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, UInt64, UInt32, LLVMDIFlags) Builder PointeeType ClassType SizeInBits AlignInBits Flags
end

function LLVMDIBuilderCreateObjCIVar(Builder, Name, NameLen, File, LineNo, SizeInBits, AlignInBits, OffsetInBits, Flags, Ty, PropertyNode)
    @runtime_ccall (:LLVMDIBuilderCreateObjCIVar, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, UInt64, UInt32, UInt64, LLVMDIFlags, LLVMMetadataRef, LLVMMetadataRef) Builder Name NameLen File LineNo SizeInBits AlignInBits OffsetInBits Flags Ty PropertyNode
end

function LLVMDIBuilderCreateObjCProperty(Builder, Name, NameLen, File, LineNo, GetterName, GetterNameLen, SetterName, SetterNameLen, PropertyAttributes, Ty)
    @runtime_ccall (:LLVMDIBuilderCreateObjCProperty, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, Cstring, Csize_t, Cstring, Csize_t, Cuint, LLVMMetadataRef) Builder Name NameLen File LineNo GetterName GetterNameLen SetterName SetterNameLen PropertyAttributes Ty
end

function LLVMDIBuilderCreateObjectPointerType(Builder, Type)
    @runtime_ccall (:LLVMDIBuilderCreateObjectPointerType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef) Builder Type
end

function LLVMDIBuilderCreateQualifiedType(Builder, Tag, Type)
    @runtime_ccall (:LLVMDIBuilderCreateQualifiedType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Cuint, LLVMMetadataRef) Builder Tag Type
end

function LLVMDIBuilderCreateReferenceType(Builder, Tag, Type)
    @runtime_ccall (:LLVMDIBuilderCreateReferenceType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Cuint, LLVMMetadataRef) Builder Tag Type
end

function LLVMDIBuilderCreateNullPtrType(Builder)
    @runtime_ccall (:LLVMDIBuilderCreateNullPtrType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef,) Builder
end

function LLVMDIBuilderCreateTypedef(Builder, Type, Name, NameLen, File, LineNo, Scope, AlignInBits)
    @runtime_ccall (:LLVMDIBuilderCreateTypedef, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, LLVMMetadataRef, UInt32) Builder Type Name NameLen File LineNo Scope AlignInBits
end

function LLVMDIBuilderCreateInheritance(Builder, Ty, BaseTy, BaseOffset, VBPtrOffset, Flags)
    @runtime_ccall (:LLVMDIBuilderCreateInheritance, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, UInt64, UInt32, LLVMDIFlags) Builder Ty BaseTy BaseOffset VBPtrOffset Flags
end

function LLVMDIBuilderCreateForwardDecl(Builder, Tag, Name, NameLen, Scope, File, Line, RuntimeLang, SizeInBits, AlignInBits, UniqueIdentifier, UniqueIdentifierLen)
    @runtime_ccall (:LLVMDIBuilderCreateForwardDecl, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Cuint, Cstring, Csize_t, LLVMMetadataRef, LLVMMetadataRef, Cuint, Cuint, UInt64, UInt32, Cstring, Csize_t) Builder Tag Name NameLen Scope File Line RuntimeLang SizeInBits AlignInBits UniqueIdentifier UniqueIdentifierLen
end

function LLVMDIBuilderCreateReplaceableCompositeType(Builder, Tag, Name, NameLen, Scope, File, Line, RuntimeLang, SizeInBits, AlignInBits, Flags, UniqueIdentifier, UniqueIdentifierLen)
    @runtime_ccall (:LLVMDIBuilderCreateReplaceableCompositeType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Cuint, Cstring, Csize_t, LLVMMetadataRef, LLVMMetadataRef, Cuint, Cuint, UInt64, UInt32, LLVMDIFlags, Cstring, Csize_t) Builder Tag Name NameLen Scope File Line RuntimeLang SizeInBits AlignInBits Flags UniqueIdentifier UniqueIdentifierLen
end

function LLVMDIBuilderCreateBitFieldMemberType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, OffsetInBits, StorageOffsetInBits, Flags, Type)
    @runtime_ccall (:LLVMDIBuilderCreateBitFieldMemberType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, UInt64, UInt64, UInt64, LLVMDIFlags, LLVMMetadataRef) Builder Scope Name NameLen File LineNumber SizeInBits OffsetInBits StorageOffsetInBits Flags Type
end

function LLVMDIBuilderCreateClassType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, OffsetInBits, Flags, DerivedFrom, Elements, NumElements, VTableHolder, TemplateParamsNode, UniqueIdentifier, UniqueIdentifierLen)
    @runtime_ccall (:LLVMDIBuilderCreateClassType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, UInt64, UInt32, UInt64, LLVMDIFlags, LLVMMetadataRef, Ptr{LLVMMetadataRef}, Cuint, LLVMMetadataRef, LLVMMetadataRef, Cstring, Csize_t) Builder Scope Name NameLen File LineNumber SizeInBits AlignInBits OffsetInBits Flags DerivedFrom Elements NumElements VTableHolder TemplateParamsNode UniqueIdentifier UniqueIdentifierLen
end

function LLVMDIBuilderCreateArtificialType(Builder, Type)
    @runtime_ccall (:LLVMDIBuilderCreateArtificialType, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef) Builder Type
end

function LLVMDITypeGetName(DType, Length)
    @runtime_ccall (:LLVMDITypeGetName, libllvm[]) Cstring (LLVMMetadataRef, Ptr{Csize_t}) DType Length
end

function LLVMDITypeGetSizeInBits(DType)
    @runtime_ccall (:LLVMDITypeGetSizeInBits, libllvm[]) UInt64 (LLVMMetadataRef,) DType
end

function LLVMDITypeGetOffsetInBits(DType)
    @runtime_ccall (:LLVMDITypeGetOffsetInBits, libllvm[]) UInt64 (LLVMMetadataRef,) DType
end

function LLVMDITypeGetAlignInBits(DType)
    @runtime_ccall (:LLVMDITypeGetAlignInBits, libllvm[]) UInt32 (LLVMMetadataRef,) DType
end

function LLVMDITypeGetLine(DType)
    @runtime_ccall (:LLVMDITypeGetLine, libllvm[]) Cuint (LLVMMetadataRef,) DType
end

function LLVMDITypeGetFlags(DType)
    @runtime_ccall (:LLVMDITypeGetFlags, libllvm[]) LLVMDIFlags (LLVMMetadataRef,) DType
end

function LLVMDIBuilderGetOrCreateSubrange(Builder, LowerBound, Count)
    @runtime_ccall (:LLVMDIBuilderGetOrCreateSubrange, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Int64, Int64) Builder LowerBound Count
end

function LLVMDIBuilderGetOrCreateArray(Builder, Data, NumElements)
    @runtime_ccall (:LLVMDIBuilderGetOrCreateArray, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Ptr{LLVMMetadataRef}, Csize_t) Builder Data NumElements
end

function LLVMDIBuilderCreateExpression(Builder, Addr, Length)
    @runtime_ccall (:LLVMDIBuilderCreateExpression, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Ptr{Int64}, Csize_t) Builder Addr Length
end

function LLVMDIBuilderCreateConstantValueExpression(Builder, Value)
    @runtime_ccall (:LLVMDIBuilderCreateConstantValueExpression, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, Int64) Builder Value
end

function LLVMDIBuilderCreateGlobalVariableExpression(Builder, Scope, Name, NameLen, Linkage, LinkLen, File, LineNo, Ty, LocalToUnit, Expr, Decl, AlignInBits)
    @runtime_ccall (:LLVMDIBuilderCreateGlobalVariableExpression, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, Cstring, Csize_t, LLVMMetadataRef, Cuint, LLVMMetadataRef, LLVMBool, LLVMMetadataRef, LLVMMetadataRef, UInt32) Builder Scope Name NameLen Linkage LinkLen File LineNo Ty LocalToUnit Expr Decl AlignInBits
end

function LLVMDIGlobalVariableExpressionGetVariable(GVE)
    @runtime_ccall (:LLVMDIGlobalVariableExpressionGetVariable, libllvm[]) LLVMMetadataRef (LLVMMetadataRef,) GVE
end

function LLVMDIGlobalVariableExpressionGetExpression(GVE)
    @runtime_ccall (:LLVMDIGlobalVariableExpressionGetExpression, libllvm[]) LLVMMetadataRef (LLVMMetadataRef,) GVE
end

function LLVMDIVariableGetFile(Var)
    @runtime_ccall (:LLVMDIVariableGetFile, libllvm[]) LLVMMetadataRef (LLVMMetadataRef,) Var
end

function LLVMDIVariableGetScope(Var)
    @runtime_ccall (:LLVMDIVariableGetScope, libllvm[]) LLVMMetadataRef (LLVMMetadataRef,) Var
end

function LLVMDIVariableGetLine(Var)
    @runtime_ccall (:LLVMDIVariableGetLine, libllvm[]) Cuint (LLVMMetadataRef,) Var
end

function LLVMTemporaryMDNode(Ctx, Data, NumElements)
    @runtime_ccall (:LLVMTemporaryMDNode, libllvm[]) LLVMMetadataRef (LLVMContextRef, Ptr{LLVMMetadataRef}, Csize_t) Ctx Data NumElements
end

function LLVMDisposeTemporaryMDNode(TempNode)
    @runtime_ccall (:LLVMDisposeTemporaryMDNode, libllvm[]) Cvoid (LLVMMetadataRef,) TempNode
end

function LLVMMetadataReplaceAllUsesWith(TempTargetMetadata, Replacement)
    @runtime_ccall (:LLVMMetadataReplaceAllUsesWith, libllvm[]) Cvoid (LLVMMetadataRef, LLVMMetadataRef) TempTargetMetadata Replacement
end

function LLVMDIBuilderCreateTempGlobalVariableFwdDecl(Builder, Scope, Name, NameLen, Linkage, LnkLen, File, LineNo, Ty, LocalToUnit, Decl, AlignInBits)
    @runtime_ccall (:LLVMDIBuilderCreateTempGlobalVariableFwdDecl, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, Cstring, Csize_t, LLVMMetadataRef, Cuint, LLVMMetadataRef, LLVMBool, LLVMMetadataRef, UInt32) Builder Scope Name NameLen Linkage LnkLen File LineNo Ty LocalToUnit Decl AlignInBits
end

function LLVMDIBuilderInsertDeclareBefore(Builder, Storage, VarInfo, Expr, DebugLoc, Instr)
    @runtime_ccall (:LLVMDIBuilderInsertDeclareBefore, libllvm[]) LLVMValueRef (LLVMDIBuilderRef, LLVMValueRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, LLVMValueRef) Builder Storage VarInfo Expr DebugLoc Instr
end

function LLVMDIBuilderInsertDeclareAtEnd(Builder, Storage, VarInfo, Expr, DebugLoc, Block)
    @runtime_ccall (:LLVMDIBuilderInsertDeclareAtEnd, libllvm[]) LLVMValueRef (LLVMDIBuilderRef, LLVMValueRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, LLVMBasicBlockRef) Builder Storage VarInfo Expr DebugLoc Block
end

function LLVMDIBuilderInsertDbgValueBefore(Builder, Val, VarInfo, Expr, DebugLoc, Instr)
    @runtime_ccall (:LLVMDIBuilderInsertDbgValueBefore, libllvm[]) LLVMValueRef (LLVMDIBuilderRef, LLVMValueRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, LLVMValueRef) Builder Val VarInfo Expr DebugLoc Instr
end

function LLVMDIBuilderInsertDbgValueAtEnd(Builder, Val, VarInfo, Expr, DebugLoc, Block)
    @runtime_ccall (:LLVMDIBuilderInsertDbgValueAtEnd, libllvm[]) LLVMValueRef (LLVMDIBuilderRef, LLVMValueRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, LLVMBasicBlockRef) Builder Val VarInfo Expr DebugLoc Block
end

function LLVMDIBuilderCreateAutoVariable(Builder, Scope, Name, NameLen, File, LineNo, Ty, AlwaysPreserve, Flags, AlignInBits)
    @runtime_ccall (:LLVMDIBuilderCreateAutoVariable, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, LLVMMetadataRef, LLVMBool, LLVMDIFlags, UInt32) Builder Scope Name NameLen File LineNo Ty AlwaysPreserve Flags AlignInBits
end

function LLVMDIBuilderCreateParameterVariable(Builder, Scope, Name, NameLen, ArgNo, File, LineNo, Ty, AlwaysPreserve, Flags)
    @runtime_ccall (:LLVMDIBuilderCreateParameterVariable, libllvm[]) LLVMMetadataRef (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, Cuint, LLVMMetadataRef, Cuint, LLVMMetadataRef, LLVMBool, LLVMDIFlags) Builder Scope Name NameLen ArgNo File LineNo Ty AlwaysPreserve Flags
end

function LLVMGetSubprogram(Func)
    @runtime_ccall (:LLVMGetSubprogram, libllvm[]) LLVMMetadataRef (LLVMValueRef,) Func
end

function LLVMSetSubprogram(Func, SP)
    @runtime_ccall (:LLVMSetSubprogram, libllvm[]) Cvoid (LLVMValueRef, LLVMMetadataRef) Func SP
end

function LLVMDISubprogramGetLine(Subprogram)
    @runtime_ccall (:LLVMDISubprogramGetLine, libllvm[]) Cuint (LLVMMetadataRef,) Subprogram
end

function LLVMInstructionGetDebugLoc(Inst)
    @runtime_ccall (:LLVMInstructionGetDebugLoc, libllvm[]) LLVMMetadataRef (LLVMValueRef,) Inst
end

function LLVMInstructionSetDebugLoc(Inst, Loc)
    @runtime_ccall (:LLVMInstructionSetDebugLoc, libllvm[]) Cvoid (LLVMValueRef, LLVMMetadataRef) Inst Loc
end

function LLVMGetMetadataKind(Metadata)
    @runtime_ccall (:LLVMGetMetadataKind, libllvm[]) LLVMMetadataKind (LLVMMetadataRef,) Metadata
end

# typedef int ( * LLVMOpInfoCallback ) ( void * DisInfo , uint64_t PC , uint64_t Offset , uint64_t Size , int TagType , void * TagBuf )
const LLVMOpInfoCallback = Ptr{Cvoid}

# typedef const char * ( * LLVMSymbolLookupCallback ) ( void * DisInfo , uint64_t ReferenceValue , uint64_t * ReferenceType , uint64_t ReferencePC , const char * * ReferenceName )
const LLVMSymbolLookupCallback = Ptr{Cvoid}

const LLVMDisasmContextRef = Ptr{Cvoid}

function LLVMCreateDisasm(TripleName, DisInfo, TagType, GetOpInfo, SymbolLookUp)
    @runtime_ccall (:LLVMCreateDisasm, libllvm[]) LLVMDisasmContextRef (Cstring, Ptr{Cvoid}, Cint, LLVMOpInfoCallback, LLVMSymbolLookupCallback) TripleName DisInfo TagType GetOpInfo SymbolLookUp
end

function LLVMCreateDisasmCPU(Triple, CPU, DisInfo, TagType, GetOpInfo, SymbolLookUp)
    @runtime_ccall (:LLVMCreateDisasmCPU, libllvm[]) LLVMDisasmContextRef (Cstring, Cstring, Ptr{Cvoid}, Cint, LLVMOpInfoCallback, LLVMSymbolLookupCallback) Triple CPU DisInfo TagType GetOpInfo SymbolLookUp
end

function LLVMCreateDisasmCPUFeatures(Triple, CPU, Features, DisInfo, TagType, GetOpInfo, SymbolLookUp)
    @runtime_ccall (:LLVMCreateDisasmCPUFeatures, libllvm[]) LLVMDisasmContextRef (Cstring, Cstring, Cstring, Ptr{Cvoid}, Cint, LLVMOpInfoCallback, LLVMSymbolLookupCallback) Triple CPU Features DisInfo TagType GetOpInfo SymbolLookUp
end

function LLVMSetDisasmOptions(DC, Options)
    @runtime_ccall (:LLVMSetDisasmOptions, libllvm[]) Cint (LLVMDisasmContextRef, UInt64) DC Options
end

function LLVMDisasmDispose(DC)
    @runtime_ccall (:LLVMDisasmDispose, libllvm[]) Cvoid (LLVMDisasmContextRef,) DC
end

function LLVMDisasmInstruction(DC, Bytes, BytesSize, PC, OutString, OutStringSize)
    @runtime_ccall (:LLVMDisasmInstruction, libllvm[]) Csize_t (LLVMDisasmContextRef, Ptr{UInt8}, UInt64, UInt64, Cstring, Csize_t) DC Bytes BytesSize PC OutString OutStringSize
end

struct LLVMOpInfoSymbol1
    Present::UInt64
    Name::Cstring
    Value::UInt64
end

struct LLVMOpInfo1
    AddSymbol::LLVMOpInfoSymbol1
    SubtractSymbol::LLVMOpInfoSymbol1
    Value::UInt64
    VariantKind::UInt64
end

mutable struct LLVMOpaqueError end

const LLVMErrorRef = Ptr{LLVMOpaqueError}

const LLVMErrorTypeId = Ptr{Cvoid}

function LLVMGetErrorTypeId(Err)
    @runtime_ccall (:LLVMGetErrorTypeId, libllvm[]) LLVMErrorTypeId (LLVMErrorRef,) Err
end

function LLVMConsumeError(Err)
    @runtime_ccall (:LLVMConsumeError, libllvm[]) Cvoid (LLVMErrorRef,) Err
end

function LLVMGetErrorMessage(Err)
    @runtime_ccall (:LLVMGetErrorMessage, libllvm[]) Cstring (LLVMErrorRef,) Err
end

function LLVMDisposeErrorMessage(ErrMsg)
    @runtime_ccall (:LLVMDisposeErrorMessage, libllvm[]) Cvoid (Cstring,) ErrMsg
end

function LLVMGetStringErrorTypeId()
    @runtime_ccall (:LLVMGetStringErrorTypeId, libllvm[]) LLVMErrorTypeId ()
end

# typedef void ( * LLVMFatalErrorHandler ) ( const char * Reason )
const LLVMFatalErrorHandler = Ptr{Cvoid}

function LLVMInstallFatalErrorHandler(Handler)
    @runtime_ccall (:LLVMInstallFatalErrorHandler, libllvm[]) Cvoid (LLVMFatalErrorHandler,) Handler
end

function LLVMResetFatalErrorHandler()
    @runtime_ccall (:LLVMResetFatalErrorHandler, libllvm[]) Cvoid ()
end

function LLVMEnablePrettyStackTrace()
    @runtime_ccall (:LLVMEnablePrettyStackTrace, libllvm[]) Cvoid ()
end

function LLVMLinkInMCJIT()
    @runtime_ccall (:LLVMLinkInMCJIT, libllvm[]) Cvoid ()
end

function LLVMLinkInInterpreter()
    @runtime_ccall (:LLVMLinkInInterpreter, libllvm[]) Cvoid ()
end

mutable struct LLVMOpaqueGenericValue end

const LLVMGenericValueRef = Ptr{LLVMOpaqueGenericValue}

mutable struct LLVMOpaqueExecutionEngine end

const LLVMExecutionEngineRef = Ptr{LLVMOpaqueExecutionEngine}

mutable struct LLVMOpaqueMCJITMemoryManager end

const LLVMMCJITMemoryManagerRef = Ptr{LLVMOpaqueMCJITMemoryManager}

@cenum LLVMCodeModel::UInt32 begin
    LLVMCodeModelDefault = 0
    LLVMCodeModelJITDefault = 1
    LLVMCodeModelTiny = 2
    LLVMCodeModelSmall = 3
    LLVMCodeModelKernel = 4
    LLVMCodeModelMedium = 5
    LLVMCodeModelLarge = 6
end

struct LLVMMCJITCompilerOptions
    OptLevel::Cuint
    CodeModel::LLVMCodeModel
    NoFramePointerElim::LLVMBool
    EnableFastISel::LLVMBool
    MCJMM::LLVMMCJITMemoryManagerRef
end

function LLVMCreateGenericValueOfInt(Ty, N, IsSigned)
    @runtime_ccall (:LLVMCreateGenericValueOfInt, libllvm[]) LLVMGenericValueRef (LLVMTypeRef, Culonglong, LLVMBool) Ty N IsSigned
end

function LLVMCreateGenericValueOfPointer(P)
    @runtime_ccall (:LLVMCreateGenericValueOfPointer, libllvm[]) LLVMGenericValueRef (Ptr{Cvoid},) P
end

function LLVMCreateGenericValueOfFloat(Ty, N)
    @runtime_ccall (:LLVMCreateGenericValueOfFloat, libllvm[]) LLVMGenericValueRef (LLVMTypeRef, Cdouble) Ty N
end

function LLVMGenericValueIntWidth(GenValRef)
    @runtime_ccall (:LLVMGenericValueIntWidth, libllvm[]) Cuint (LLVMGenericValueRef,) GenValRef
end

function LLVMGenericValueToInt(GenVal, IsSigned)
    @runtime_ccall (:LLVMGenericValueToInt, libllvm[]) Culonglong (LLVMGenericValueRef, LLVMBool) GenVal IsSigned
end

function LLVMGenericValueToPointer(GenVal)
    @runtime_ccall (:LLVMGenericValueToPointer, libllvm[]) Ptr{Cvoid} (LLVMGenericValueRef,) GenVal
end

function LLVMGenericValueToFloat(TyRef, GenVal)
    @runtime_ccall (:LLVMGenericValueToFloat, libllvm[]) Cdouble (LLVMTypeRef, LLVMGenericValueRef) TyRef GenVal
end

function LLVMDisposeGenericValue(GenVal)
    @runtime_ccall (:LLVMDisposeGenericValue, libllvm[]) Cvoid (LLVMGenericValueRef,) GenVal
end

function LLVMCreateExecutionEngineForModule(OutEE, M, OutError)
    @runtime_ccall (:LLVMCreateExecutionEngineForModule, libllvm[]) LLVMBool (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, Ptr{Cstring}) OutEE M OutError
end

function LLVMCreateInterpreterForModule(OutInterp, M, OutError)
    @runtime_ccall (:LLVMCreateInterpreterForModule, libllvm[]) LLVMBool (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, Ptr{Cstring}) OutInterp M OutError
end

function LLVMCreateJITCompilerForModule(OutJIT, M, OptLevel, OutError)
    @runtime_ccall (:LLVMCreateJITCompilerForModule, libllvm[]) LLVMBool (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, Cuint, Ptr{Cstring}) OutJIT M OptLevel OutError
end

function LLVMInitializeMCJITCompilerOptions(Options, SizeOfOptions)
    @runtime_ccall (:LLVMInitializeMCJITCompilerOptions, libllvm[]) Cvoid (Ptr{LLVMMCJITCompilerOptions}, Csize_t) Options SizeOfOptions
end

function LLVMCreateMCJITCompilerForModule(OutJIT, M, Options, SizeOfOptions, OutError)
    @runtime_ccall (:LLVMCreateMCJITCompilerForModule, libllvm[]) LLVMBool (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, Ptr{LLVMMCJITCompilerOptions}, Csize_t, Ptr{Cstring}) OutJIT M Options SizeOfOptions OutError
end

function LLVMDisposeExecutionEngine(EE)
    @runtime_ccall (:LLVMDisposeExecutionEngine, libllvm[]) Cvoid (LLVMExecutionEngineRef,) EE
end

function LLVMRunStaticConstructors(EE)
    @runtime_ccall (:LLVMRunStaticConstructors, libllvm[]) Cvoid (LLVMExecutionEngineRef,) EE
end

function LLVMRunStaticDestructors(EE)
    @runtime_ccall (:LLVMRunStaticDestructors, libllvm[]) Cvoid (LLVMExecutionEngineRef,) EE
end

function LLVMRunFunctionAsMain(EE, F, ArgC, ArgV, EnvP)
    @runtime_ccall (:LLVMRunFunctionAsMain, libllvm[]) Cint (LLVMExecutionEngineRef, LLVMValueRef, Cuint, Ptr{Cstring}, Ptr{Cstring}) EE F ArgC ArgV EnvP
end

function LLVMRunFunction(EE, F, NumArgs, Args)
    @runtime_ccall (:LLVMRunFunction, libllvm[]) LLVMGenericValueRef (LLVMExecutionEngineRef, LLVMValueRef, Cuint, Ptr{LLVMGenericValueRef}) EE F NumArgs Args
end

function LLVMFreeMachineCodeForFunction(EE, F)
    @runtime_ccall (:LLVMFreeMachineCodeForFunction, libllvm[]) Cvoid (LLVMExecutionEngineRef, LLVMValueRef) EE F
end

function LLVMAddModule(EE, M)
    @runtime_ccall (:LLVMAddModule, libllvm[]) Cvoid (LLVMExecutionEngineRef, LLVMModuleRef) EE M
end

function LLVMRemoveModule(EE, M, OutMod, OutError)
    @runtime_ccall (:LLVMRemoveModule, libllvm[]) LLVMBool (LLVMExecutionEngineRef, LLVMModuleRef, Ptr{LLVMModuleRef}, Ptr{Cstring}) EE M OutMod OutError
end

function LLVMFindFunction(EE, Name, OutFn)
    @runtime_ccall (:LLVMFindFunction, libllvm[]) LLVMBool (LLVMExecutionEngineRef, Cstring, Ptr{LLVMValueRef}) EE Name OutFn
end

function LLVMRecompileAndRelinkFunction(EE, Fn)
    @runtime_ccall (:LLVMRecompileAndRelinkFunction, libllvm[]) Ptr{Cvoid} (LLVMExecutionEngineRef, LLVMValueRef) EE Fn
end

mutable struct LLVMOpaqueTargetData end

const LLVMTargetDataRef = Ptr{LLVMOpaqueTargetData}

function LLVMGetExecutionEngineTargetData(EE)
    @runtime_ccall (:LLVMGetExecutionEngineTargetData, libllvm[]) LLVMTargetDataRef (LLVMExecutionEngineRef,) EE
end

mutable struct LLVMOpaqueTargetMachine end

const LLVMTargetMachineRef = Ptr{LLVMOpaqueTargetMachine}

function LLVMGetExecutionEngineTargetMachine(EE)
    @runtime_ccall (:LLVMGetExecutionEngineTargetMachine, libllvm[]) LLVMTargetMachineRef (LLVMExecutionEngineRef,) EE
end

function LLVMAddGlobalMapping(EE, Global, Addr)
    @runtime_ccall (:LLVMAddGlobalMapping, libllvm[]) Cvoid (LLVMExecutionEngineRef, LLVMValueRef, Ptr{Cvoid}) EE Global Addr
end

function LLVMGetPointerToGlobal(EE, Global)
    @runtime_ccall (:LLVMGetPointerToGlobal, libllvm[]) Ptr{Cvoid} (LLVMExecutionEngineRef, LLVMValueRef) EE Global
end

function LLVMGetGlobalValueAddress(EE, Name)
    @runtime_ccall (:LLVMGetGlobalValueAddress, libllvm[]) UInt64 (LLVMExecutionEngineRef, Cstring) EE Name
end

function LLVMGetFunctionAddress(EE, Name)
    @runtime_ccall (:LLVMGetFunctionAddress, libllvm[]) UInt64 (LLVMExecutionEngineRef, Cstring) EE Name
end

function LLVMExecutionEngineGetErrMsg(EE, OutError)
    @runtime_ccall (:LLVMExecutionEngineGetErrMsg, libllvm[]) LLVMBool (LLVMExecutionEngineRef, Ptr{Cstring}) EE OutError
end

# typedef uint8_t * ( * LLVMMemoryManagerAllocateCodeSectionCallback ) ( void * Opaque , uintptr_t Size , unsigned Alignment , unsigned SectionID , const char * SectionName )
const LLVMMemoryManagerAllocateCodeSectionCallback = Ptr{Cvoid}

# typedef uint8_t * ( * LLVMMemoryManagerAllocateDataSectionCallback ) ( void * Opaque , uintptr_t Size , unsigned Alignment , unsigned SectionID , const char * SectionName , LLVMBool IsReadOnly )
const LLVMMemoryManagerAllocateDataSectionCallback = Ptr{Cvoid}

# typedef LLVMBool ( * LLVMMemoryManagerFinalizeMemoryCallback ) ( void * Opaque , char * * ErrMsg )
const LLVMMemoryManagerFinalizeMemoryCallback = Ptr{Cvoid}

# typedef void ( * LLVMMemoryManagerDestroyCallback ) ( void * Opaque )
const LLVMMemoryManagerDestroyCallback = Ptr{Cvoid}

function LLVMCreateSimpleMCJITMemoryManager(Opaque, AllocateCodeSection, AllocateDataSection, FinalizeMemory, Destroy)
    @runtime_ccall (:LLVMCreateSimpleMCJITMemoryManager, libllvm[]) LLVMMCJITMemoryManagerRef (Ptr{Cvoid}, LLVMMemoryManagerAllocateCodeSectionCallback, LLVMMemoryManagerAllocateDataSectionCallback, LLVMMemoryManagerFinalizeMemoryCallback, LLVMMemoryManagerDestroyCallback) Opaque AllocateCodeSection AllocateDataSection FinalizeMemory Destroy
end

function LLVMDisposeMCJITMemoryManager(MM)
    @runtime_ccall (:LLVMDisposeMCJITMemoryManager, libllvm[]) Cvoid (LLVMMCJITMemoryManagerRef,) MM
end

mutable struct LLVMOpaqueJITEventListener end

const LLVMJITEventListenerRef = Ptr{LLVMOpaqueJITEventListener}

function LLVMCreateGDBRegistrationListener()
    @runtime_ccall (:LLVMCreateGDBRegistrationListener, libllvm[]) LLVMJITEventListenerRef ()
end

function LLVMCreateIntelJITEventListener()
    @runtime_ccall (:LLVMCreateIntelJITEventListener, libllvm[]) LLVMJITEventListenerRef ()
end

function LLVMCreateOProfileJITEventListener()
    @runtime_ccall (:LLVMCreateOProfileJITEventListener, libllvm[]) LLVMJITEventListenerRef ()
end

function LLVMCreatePerfJITEventListener()
    @runtime_ccall (:LLVMCreatePerfJITEventListener, libllvm[]) LLVMJITEventListenerRef ()
end

function LLVMParseIRInContext(ContextRef, MemBuf, OutM, OutMessage)
    @runtime_ccall (:LLVMParseIRInContext, libllvm[]) LLVMBool (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}) ContextRef MemBuf OutM OutMessage
end

function LLVMInitializeTransformUtils(R)
    @runtime_ccall (:LLVMInitializeTransformUtils, libllvm[]) Cvoid (LLVMPassRegistryRef,) R
end

function LLVMInitializeScalarOpts(R)
    @runtime_ccall (:LLVMInitializeScalarOpts, libllvm[]) Cvoid (LLVMPassRegistryRef,) R
end

function LLVMInitializeObjCARCOpts(R)
    @runtime_ccall (:LLVMInitializeObjCARCOpts, libllvm[]) Cvoid (LLVMPassRegistryRef,) R
end

function LLVMInitializeVectorization(R)
    @runtime_ccall (:LLVMInitializeVectorization, libllvm[]) Cvoid (LLVMPassRegistryRef,) R
end

function LLVMInitializeInstCombine(R)
    @runtime_ccall (:LLVMInitializeInstCombine, libllvm[]) Cvoid (LLVMPassRegistryRef,) R
end

function LLVMInitializeAggressiveInstCombiner(R)
    @runtime_ccall (:LLVMInitializeAggressiveInstCombiner, libllvm[]) Cvoid (LLVMPassRegistryRef,) R
end

function LLVMInitializeIPO(R)
    @runtime_ccall (:LLVMInitializeIPO, libllvm[]) Cvoid (LLVMPassRegistryRef,) R
end

function LLVMInitializeInstrumentation(R)
    @runtime_ccall (:LLVMInitializeInstrumentation, libllvm[]) Cvoid (LLVMPassRegistryRef,) R
end

function LLVMInitializeAnalysis(R)
    @runtime_ccall (:LLVMInitializeAnalysis, libllvm[]) Cvoid (LLVMPassRegistryRef,) R
end

function LLVMInitializeIPA(R)
    @runtime_ccall (:LLVMInitializeIPA, libllvm[]) Cvoid (LLVMPassRegistryRef,) R
end

function LLVMInitializeCodeGen(R)
    @runtime_ccall (:LLVMInitializeCodeGen, libllvm[]) Cvoid (LLVMPassRegistryRef,) R
end

function LLVMInitializeTarget(R)
    @runtime_ccall (:LLVMInitializeTarget, libllvm[]) Cvoid (LLVMPassRegistryRef,) R
end

const llvm_lto_t = Ptr{Cvoid}

@cenum llvm_lto_status::UInt32 begin
    LLVM_LTO_UNKNOWN = 0
    LLVM_LTO_OPT_SUCCESS = 1
    LLVM_LTO_READ_SUCCESS = 2
    LLVM_LTO_READ_FAILURE = 3
    LLVM_LTO_WRITE_FAILURE = 4
    LLVM_LTO_NO_TARGET = 5
    LLVM_LTO_NO_WORK = 6
    LLVM_LTO_MODULE_MERGE_FAILURE = 7
    LLVM_LTO_ASM_FAILURE = 8
    LLVM_LTO_NULL_OBJECT = 9
end

const llvm_lto_status_t = llvm_lto_status

function llvm_create_optimizer()
    @runtime_ccall (:llvm_create_optimizer, libllvm[]) llvm_lto_t ()
end

function llvm_destroy_optimizer(lto)
    @runtime_ccall (:llvm_destroy_optimizer, libllvm[]) Cvoid (llvm_lto_t,) lto
end

function llvm_read_object_file(lto, input_filename)
    @runtime_ccall (:llvm_read_object_file, libllvm[]) llvm_lto_status_t (llvm_lto_t, Cstring) lto input_filename
end

function llvm_optimize_modules(lto, output_filename)
    @runtime_ccall (:llvm_optimize_modules, libllvm[]) llvm_lto_status_t (llvm_lto_t, Cstring) lto output_filename
end

@cenum LLVMLinkerMode::UInt32 begin
    LLVMLinkerDestroySource = 0
    LLVMLinkerPreserveSource_Removed = 1
end

function LLVMLinkModules2(Dest, Src)
    @runtime_ccall (:LLVMLinkModules2, libllvm[]) LLVMBool (LLVMModuleRef, LLVMModuleRef) Dest Src
end

mutable struct LLVMOpaqueSectionIterator end

const LLVMSectionIteratorRef = Ptr{LLVMOpaqueSectionIterator}

mutable struct LLVMOpaqueSymbolIterator end

const LLVMSymbolIteratorRef = Ptr{LLVMOpaqueSymbolIterator}

mutable struct LLVMOpaqueRelocationIterator end

const LLVMRelocationIteratorRef = Ptr{LLVMOpaqueRelocationIterator}

@cenum LLVMBinaryType::UInt32 begin
    LLVMBinaryTypeArchive = 0
    LLVMBinaryTypeMachOUniversalBinary = 1
    LLVMBinaryTypeCOFFImportFile = 2
    LLVMBinaryTypeIR = 3
    LLVMBinaryTypeWinRes = 4
    LLVMBinaryTypeCOFF = 5
    LLVMBinaryTypeELF32L = 6
    LLVMBinaryTypeELF32B = 7
    LLVMBinaryTypeELF64L = 8
    LLVMBinaryTypeELF64B = 9
    LLVMBinaryTypeMachO32L = 10
    LLVMBinaryTypeMachO32B = 11
    LLVMBinaryTypeMachO64L = 12
    LLVMBinaryTypeMachO64B = 13
    LLVMBinaryTypeWasm = 14
end

mutable struct LLVMOpaqueBinary end

const LLVMBinaryRef = Ptr{LLVMOpaqueBinary}

function LLVMCreateBinary(MemBuf, Context, ErrorMessage)
    @runtime_ccall (:LLVMCreateBinary, libllvm[]) LLVMBinaryRef (LLVMMemoryBufferRef, LLVMContextRef, Ptr{Cstring}) MemBuf Context ErrorMessage
end

function LLVMDisposeBinary(BR)
    @runtime_ccall (:LLVMDisposeBinary, libllvm[]) Cvoid (LLVMBinaryRef,) BR
end

function LLVMBinaryCopyMemoryBuffer(BR)
    @runtime_ccall (:LLVMBinaryCopyMemoryBuffer, libllvm[]) LLVMMemoryBufferRef (LLVMBinaryRef,) BR
end

function LLVMBinaryGetType(BR)
    @runtime_ccall (:LLVMBinaryGetType, libllvm[]) LLVMBinaryType (LLVMBinaryRef,) BR
end

function LLVMMachOUniversalBinaryCopyObjectForArch(BR, Arch, ArchLen, ErrorMessage)
    @runtime_ccall (:LLVMMachOUniversalBinaryCopyObjectForArch, libllvm[]) LLVMBinaryRef (LLVMBinaryRef, Cstring, Csize_t, Ptr{Cstring}) BR Arch ArchLen ErrorMessage
end

function LLVMObjectFileCopySectionIterator(BR)
    @runtime_ccall (:LLVMObjectFileCopySectionIterator, libllvm[]) LLVMSectionIteratorRef (LLVMBinaryRef,) BR
end

function LLVMObjectFileIsSectionIteratorAtEnd(BR, SI)
    @runtime_ccall (:LLVMObjectFileIsSectionIteratorAtEnd, libllvm[]) LLVMBool (LLVMBinaryRef, LLVMSectionIteratorRef) BR SI
end

function LLVMObjectFileCopySymbolIterator(BR)
    @runtime_ccall (:LLVMObjectFileCopySymbolIterator, libllvm[]) LLVMSymbolIteratorRef (LLVMBinaryRef,) BR
end

function LLVMObjectFileIsSymbolIteratorAtEnd(BR, SI)
    @runtime_ccall (:LLVMObjectFileIsSymbolIteratorAtEnd, libllvm[]) LLVMBool (LLVMBinaryRef, LLVMSymbolIteratorRef) BR SI
end

function LLVMDisposeSectionIterator(SI)
    @runtime_ccall (:LLVMDisposeSectionIterator, libllvm[]) Cvoid (LLVMSectionIteratorRef,) SI
end

function LLVMMoveToNextSection(SI)
    @runtime_ccall (:LLVMMoveToNextSection, libllvm[]) Cvoid (LLVMSectionIteratorRef,) SI
end

function LLVMMoveToContainingSection(Sect, Sym)
    @runtime_ccall (:LLVMMoveToContainingSection, libllvm[]) Cvoid (LLVMSectionIteratorRef, LLVMSymbolIteratorRef) Sect Sym
end

function LLVMDisposeSymbolIterator(SI)
    @runtime_ccall (:LLVMDisposeSymbolIterator, libllvm[]) Cvoid (LLVMSymbolIteratorRef,) SI
end

function LLVMMoveToNextSymbol(SI)
    @runtime_ccall (:LLVMMoveToNextSymbol, libllvm[]) Cvoid (LLVMSymbolIteratorRef,) SI
end

function LLVMGetSectionName(SI)
    @runtime_ccall (:LLVMGetSectionName, libllvm[]) Cstring (LLVMSectionIteratorRef,) SI
end

function LLVMGetSectionSize(SI)
    @runtime_ccall (:LLVMGetSectionSize, libllvm[]) UInt64 (LLVMSectionIteratorRef,) SI
end

function LLVMGetSectionContents(SI)
    @runtime_ccall (:LLVMGetSectionContents, libllvm[]) Cstring (LLVMSectionIteratorRef,) SI
end

function LLVMGetSectionAddress(SI)
    @runtime_ccall (:LLVMGetSectionAddress, libllvm[]) UInt64 (LLVMSectionIteratorRef,) SI
end

function LLVMGetSectionContainsSymbol(SI, Sym)
    @runtime_ccall (:LLVMGetSectionContainsSymbol, libllvm[]) LLVMBool (LLVMSectionIteratorRef, LLVMSymbolIteratorRef) SI Sym
end

function LLVMGetRelocations(Section)
    @runtime_ccall (:LLVMGetRelocations, libllvm[]) LLVMRelocationIteratorRef (LLVMSectionIteratorRef,) Section
end

function LLVMDisposeRelocationIterator(RI)
    @runtime_ccall (:LLVMDisposeRelocationIterator, libllvm[]) Cvoid (LLVMRelocationIteratorRef,) RI
end

function LLVMIsRelocationIteratorAtEnd(Section, RI)
    @runtime_ccall (:LLVMIsRelocationIteratorAtEnd, libllvm[]) LLVMBool (LLVMSectionIteratorRef, LLVMRelocationIteratorRef) Section RI
end

function LLVMMoveToNextRelocation(RI)
    @runtime_ccall (:LLVMMoveToNextRelocation, libllvm[]) Cvoid (LLVMRelocationIteratorRef,) RI
end

function LLVMGetSymbolName(SI)
    @runtime_ccall (:LLVMGetSymbolName, libllvm[]) Cstring (LLVMSymbolIteratorRef,) SI
end

function LLVMGetSymbolAddress(SI)
    @runtime_ccall (:LLVMGetSymbolAddress, libllvm[]) UInt64 (LLVMSymbolIteratorRef,) SI
end

function LLVMGetSymbolSize(SI)
    @runtime_ccall (:LLVMGetSymbolSize, libllvm[]) UInt64 (LLVMSymbolIteratorRef,) SI
end

function LLVMGetRelocationOffset(RI)
    @runtime_ccall (:LLVMGetRelocationOffset, libllvm[]) UInt64 (LLVMRelocationIteratorRef,) RI
end

function LLVMGetRelocationSymbol(RI)
    @runtime_ccall (:LLVMGetRelocationSymbol, libllvm[]) LLVMSymbolIteratorRef (LLVMRelocationIteratorRef,) RI
end

function LLVMGetRelocationType(RI)
    @runtime_ccall (:LLVMGetRelocationType, libllvm[]) UInt64 (LLVMRelocationIteratorRef,) RI
end

function LLVMGetRelocationTypeName(RI)
    @runtime_ccall (:LLVMGetRelocationTypeName, libllvm[]) Cstring (LLVMRelocationIteratorRef,) RI
end

function LLVMGetRelocationValueString(RI)
    @runtime_ccall (:LLVMGetRelocationValueString, libllvm[]) Cstring (LLVMRelocationIteratorRef,) RI
end

mutable struct LLVMOpaqueObjectFile end

const LLVMObjectFileRef = Ptr{LLVMOpaqueObjectFile}

function LLVMCreateObjectFile(MemBuf)
    @runtime_ccall (:LLVMCreateObjectFile, libllvm[]) LLVMObjectFileRef (LLVMMemoryBufferRef,) MemBuf
end

function LLVMDisposeObjectFile(ObjectFile)
    @runtime_ccall (:LLVMDisposeObjectFile, libllvm[]) Cvoid (LLVMObjectFileRef,) ObjectFile
end

function LLVMGetSections(ObjectFile)
    @runtime_ccall (:LLVMGetSections, libllvm[]) LLVMSectionIteratorRef (LLVMObjectFileRef,) ObjectFile
end

function LLVMIsSectionIteratorAtEnd(ObjectFile, SI)
    @runtime_ccall (:LLVMIsSectionIteratorAtEnd, libllvm[]) LLVMBool (LLVMObjectFileRef, LLVMSectionIteratorRef) ObjectFile SI
end

function LLVMGetSymbols(ObjectFile)
    @runtime_ccall (:LLVMGetSymbols, libllvm[]) LLVMSymbolIteratorRef (LLVMObjectFileRef,) ObjectFile
end

function LLVMIsSymbolIteratorAtEnd(ObjectFile, SI)
    @runtime_ccall (:LLVMIsSymbolIteratorAtEnd, libllvm[]) LLVMBool (LLVMObjectFileRef, LLVMSymbolIteratorRef) ObjectFile SI
end

const LLVMOrcJITTargetAddress = UInt64

mutable struct LLVMOrcOpaqueExecutionSession end

const LLVMOrcExecutionSessionRef = Ptr{LLVMOrcOpaqueExecutionSession}

mutable struct LLVMOrcQuaqueSymbolStringPoolEntryPtr end

const LLVMOrcSymbolStringPoolEntryRef = Ptr{LLVMOrcQuaqueSymbolStringPoolEntryPtr}

mutable struct LLVMOrcOpaqueJITDylib end

const LLVMOrcJITDylibRef = Ptr{LLVMOrcOpaqueJITDylib}

mutable struct LLVMOrcOpaqueJITDylibDefinitionGenerator end

const LLVMOrcJITDylibDefinitionGeneratorRef = Ptr{LLVMOrcOpaqueJITDylibDefinitionGenerator}

# typedef int ( * LLVMOrcSymbolPredicate ) ( LLVMOrcSymbolStringPoolEntryRef Sym , void * Ctx )
const LLVMOrcSymbolPredicate = Ptr{Cvoid}

mutable struct LLVMOrcOpaqueThreadSafeContext end

const LLVMOrcThreadSafeContextRef = Ptr{LLVMOrcOpaqueThreadSafeContext}

mutable struct LLVMOrcOpaqueThreadSafeModule end

const LLVMOrcThreadSafeModuleRef = Ptr{LLVMOrcOpaqueThreadSafeModule}

mutable struct LLVMOrcOpaqueJITTargetMachineBuilder end

const LLVMOrcJITTargetMachineBuilderRef = Ptr{LLVMOrcOpaqueJITTargetMachineBuilder}

mutable struct LLVMOrcOpaqueLLJITBuilder end

const LLVMOrcLLJITBuilderRef = Ptr{LLVMOrcOpaqueLLJITBuilder}

mutable struct LLVMOrcOpaqueLLJIT end

const LLVMOrcLLJITRef = Ptr{LLVMOrcOpaqueLLJIT}

function LLVMOrcExecutionSessionIntern(ES, Name)
    @runtime_ccall (:LLVMOrcExecutionSessionIntern, libllvm[]) LLVMOrcSymbolStringPoolEntryRef (LLVMOrcExecutionSessionRef, Cstring) ES Name
end

function LLVMOrcReleaseSymbolStringPoolEntry(S)
    @runtime_ccall (:LLVMOrcReleaseSymbolStringPoolEntry, libllvm[]) Cvoid (LLVMOrcSymbolStringPoolEntryRef,) S
end

function LLVMOrcDisposeJITDylibDefinitionGenerator(DG)
    @runtime_ccall (:LLVMOrcDisposeJITDylibDefinitionGenerator, libllvm[]) Cvoid (LLVMOrcJITDylibDefinitionGeneratorRef,) DG
end

function LLVMOrcJITDylibAddGenerator(JD, DG)
    @runtime_ccall (:LLVMOrcJITDylibAddGenerator, libllvm[]) Cvoid (LLVMOrcJITDylibRef, LLVMOrcJITDylibDefinitionGeneratorRef) JD DG
end

function LLVMOrcCreateDynamicLibrarySearchGeneratorForProcess(Result, GlobalPrefx, Filter, FilterCtx)
    @runtime_ccall (:LLVMOrcCreateDynamicLibrarySearchGeneratorForProcess, libllvm[]) LLVMErrorRef (Ptr{LLVMOrcJITDylibDefinitionGeneratorRef}, Cchar, LLVMOrcSymbolPredicate, Ptr{Cvoid}) Result GlobalPrefx Filter FilterCtx
end

function LLVMOrcCreateNewThreadSafeContext()
    @runtime_ccall (:LLVMOrcCreateNewThreadSafeContext, libllvm[]) LLVMOrcThreadSafeContextRef ()
end

function LLVMOrcThreadSafeContextGetContext(TSCtx)
    @runtime_ccall (:LLVMOrcThreadSafeContextGetContext, libllvm[]) LLVMContextRef (LLVMOrcThreadSafeContextRef,) TSCtx
end

function LLVMOrcDisposeThreadSafeContext(TSCtx)
    @runtime_ccall (:LLVMOrcDisposeThreadSafeContext, libllvm[]) Cvoid (LLVMOrcThreadSafeContextRef,) TSCtx
end

function LLVMOrcCreateNewThreadSafeModule(M, TSCtx)
    @runtime_ccall (:LLVMOrcCreateNewThreadSafeModule, libllvm[]) LLVMOrcThreadSafeModuleRef (LLVMModuleRef, LLVMOrcThreadSafeContextRef) M TSCtx
end

function LLVMOrcDisposeThreadSafeModule(TSM)
    @runtime_ccall (:LLVMOrcDisposeThreadSafeModule, libllvm[]) Cvoid (LLVMOrcThreadSafeModuleRef,) TSM
end

function LLVMOrcJITTargetMachineBuilderDetectHost(Result)
    @runtime_ccall (:LLVMOrcJITTargetMachineBuilderDetectHost, libllvm[]) LLVMErrorRef (Ptr{LLVMOrcJITTargetMachineBuilderRef},) Result
end

function LLVMOrcJITTargetMachineBuilderCreateFromTargetMachine(TM)
    @runtime_ccall (:LLVMOrcJITTargetMachineBuilderCreateFromTargetMachine, libllvm[]) LLVMOrcJITTargetMachineBuilderRef (LLVMTargetMachineRef,) TM
end

function LLVMOrcDisposeJITTargetMachineBuilder(JTMB)
    @runtime_ccall (:LLVMOrcDisposeJITTargetMachineBuilder, libllvm[]) Cvoid (LLVMOrcJITTargetMachineBuilderRef,) JTMB
end

function LLVMOrcCreateLLJITBuilder()
    @runtime_ccall (:LLVMOrcCreateLLJITBuilder, libllvm[]) LLVMOrcLLJITBuilderRef ()
end

function LLVMOrcDisposeLLJITBuilder(Builder)
    @runtime_ccall (:LLVMOrcDisposeLLJITBuilder, libllvm[]) Cvoid (LLVMOrcLLJITBuilderRef,) Builder
end

function LLVMOrcLLJITBuilderSetJITTargetMachineBuilder(Builder, JTMB)
    @runtime_ccall (:LLVMOrcLLJITBuilderSetJITTargetMachineBuilder, libllvm[]) Cvoid (LLVMOrcLLJITBuilderRef, LLVMOrcJITTargetMachineBuilderRef) Builder JTMB
end

function LLVMOrcCreateLLJIT(Result, Builder)
    @runtime_ccall (:LLVMOrcCreateLLJIT, libllvm[]) LLVMErrorRef (Ptr{LLVMOrcLLJITRef}, LLVMOrcLLJITBuilderRef) Result Builder
end

function LLVMOrcDisposeLLJIT(J)
    @runtime_ccall (:LLVMOrcDisposeLLJIT, libllvm[]) LLVMErrorRef (LLVMOrcLLJITRef,) J
end

function LLVMOrcLLJITGetExecutionSession(J)
    @runtime_ccall (:LLVMOrcLLJITGetExecutionSession, libllvm[]) LLVMOrcExecutionSessionRef (LLVMOrcLLJITRef,) J
end

function LLVMOrcLLJITGetMainJITDylib(J)
    @runtime_ccall (:LLVMOrcLLJITGetMainJITDylib, libllvm[]) LLVMOrcJITDylibRef (LLVMOrcLLJITRef,) J
end

function LLVMOrcLLJITGetTripleString(J)
    @runtime_ccall (:LLVMOrcLLJITGetTripleString, libllvm[]) Cstring (LLVMOrcLLJITRef,) J
end

function LLVMOrcLLJITGetGlobalPrefix(J)
    @runtime_ccall (:LLVMOrcLLJITGetGlobalPrefix, libllvm[]) Cchar (LLVMOrcLLJITRef,) J
end

function LLVMOrcLLJITMangleAndIntern(J, UnmangledName)
    @runtime_ccall (:LLVMOrcLLJITMangleAndIntern, libllvm[]) LLVMOrcSymbolStringPoolEntryRef (LLVMOrcLLJITRef, Cstring) J UnmangledName
end

function LLVMOrcLLJITAddObjectFile(J, JD, ObjBuffer)
    @runtime_ccall (:LLVMOrcLLJITAddObjectFile, libllvm[]) LLVMErrorRef (LLVMOrcLLJITRef, LLVMOrcJITDylibRef, LLVMMemoryBufferRef) J JD ObjBuffer
end

function LLVMOrcLLJITAddLLVMIRModule(J, JD, TSM)
    @runtime_ccall (:LLVMOrcLLJITAddLLVMIRModule, libllvm[]) LLVMErrorRef (LLVMOrcLLJITRef, LLVMOrcJITDylibRef, LLVMOrcThreadSafeModuleRef) J JD TSM
end

function LLVMOrcLLJITLookup(J, Result, Name)
    @runtime_ccall (:LLVMOrcLLJITLookup, libllvm[]) LLVMErrorRef (LLVMOrcLLJITRef, Ptr{LLVMOrcJITTargetAddress}, Cstring) J Result Name
end

mutable struct LLVMOrcOpaqueJITStack end

const LLVMOrcJITStackRef = Ptr{LLVMOrcOpaqueJITStack}

const LLVMOrcModuleHandle = UInt64

const LLVMOrcTargetAddress = UInt64

# typedef uint64_t ( * LLVMOrcSymbolResolverFn ) ( const char * Name , void * LookupCtx )
const LLVMOrcSymbolResolverFn = Ptr{Cvoid}

# typedef uint64_t ( * LLVMOrcLazyCompileCallbackFn ) ( LLVMOrcJITStackRef JITStack , void * CallbackCtx )
const LLVMOrcLazyCompileCallbackFn = Ptr{Cvoid}

function LLVMOrcCreateInstance(TM)
    @runtime_ccall (:LLVMOrcCreateInstance, libllvm[]) LLVMOrcJITStackRef (LLVMTargetMachineRef,) TM
end

function LLVMOrcGetErrorMsg(JITStack)
    @runtime_ccall (:LLVMOrcGetErrorMsg, libllvm[]) Cstring (LLVMOrcJITStackRef,) JITStack
end

function LLVMOrcGetMangledSymbol(JITStack, MangledSymbol, Symbol)
    @runtime_ccall (:LLVMOrcGetMangledSymbol, libllvm[]) Cvoid (LLVMOrcJITStackRef, Ptr{Cstring}, Cstring) JITStack MangledSymbol Symbol
end

function LLVMOrcDisposeMangledSymbol(MangledSymbol)
    @runtime_ccall (:LLVMOrcDisposeMangledSymbol, libllvm[]) Cvoid (Cstring,) MangledSymbol
end

function LLVMOrcCreateLazyCompileCallback(JITStack, RetAddr, Callback, CallbackCtx)
    @runtime_ccall (:LLVMOrcCreateLazyCompileCallback, libllvm[]) LLVMErrorRef (LLVMOrcJITStackRef, Ptr{LLVMOrcTargetAddress}, LLVMOrcLazyCompileCallbackFn, Ptr{Cvoid}) JITStack RetAddr Callback CallbackCtx
end

function LLVMOrcCreateIndirectStub(JITStack, StubName, InitAddr)
    @runtime_ccall (:LLVMOrcCreateIndirectStub, libllvm[]) LLVMErrorRef (LLVMOrcJITStackRef, Cstring, LLVMOrcTargetAddress) JITStack StubName InitAddr
end

function LLVMOrcSetIndirectStubPointer(JITStack, StubName, NewAddr)
    @runtime_ccall (:LLVMOrcSetIndirectStubPointer, libllvm[]) LLVMErrorRef (LLVMOrcJITStackRef, Cstring, LLVMOrcTargetAddress) JITStack StubName NewAddr
end

function LLVMOrcAddEagerlyCompiledIR(JITStack, RetHandle, Mod, SymbolResolver, SymbolResolverCtx)
    @runtime_ccall (:LLVMOrcAddEagerlyCompiledIR, libllvm[]) LLVMErrorRef (LLVMOrcJITStackRef, Ptr{LLVMOrcModuleHandle}, LLVMModuleRef, LLVMOrcSymbolResolverFn, Ptr{Cvoid}) JITStack RetHandle Mod SymbolResolver SymbolResolverCtx
end

function LLVMOrcAddLazilyCompiledIR(JITStack, RetHandle, Mod, SymbolResolver, SymbolResolverCtx)
    @runtime_ccall (:LLVMOrcAddLazilyCompiledIR, libllvm[]) LLVMErrorRef (LLVMOrcJITStackRef, Ptr{LLVMOrcModuleHandle}, LLVMModuleRef, LLVMOrcSymbolResolverFn, Ptr{Cvoid}) JITStack RetHandle Mod SymbolResolver SymbolResolverCtx
end

function LLVMOrcAddObjectFile(JITStack, RetHandle, Obj, SymbolResolver, SymbolResolverCtx)
    @runtime_ccall (:LLVMOrcAddObjectFile, libllvm[]) LLVMErrorRef (LLVMOrcJITStackRef, Ptr{LLVMOrcModuleHandle}, LLVMMemoryBufferRef, LLVMOrcSymbolResolverFn, Ptr{Cvoid}) JITStack RetHandle Obj SymbolResolver SymbolResolverCtx
end

function LLVMOrcRemoveModule(JITStack, H)
    @runtime_ccall (:LLVMOrcRemoveModule, libllvm[]) LLVMErrorRef (LLVMOrcJITStackRef, LLVMOrcModuleHandle) JITStack H
end

function LLVMOrcGetSymbolAddress(JITStack, RetAddr, SymbolName)
    @runtime_ccall (:LLVMOrcGetSymbolAddress, libllvm[]) LLVMErrorRef (LLVMOrcJITStackRef, Ptr{LLVMOrcTargetAddress}, Cstring) JITStack RetAddr SymbolName
end

function LLVMOrcGetSymbolAddressIn(JITStack, RetAddr, H, SymbolName)
    @runtime_ccall (:LLVMOrcGetSymbolAddressIn, libllvm[]) LLVMErrorRef (LLVMOrcJITStackRef, Ptr{LLVMOrcTargetAddress}, LLVMOrcModuleHandle, Cstring) JITStack RetAddr H SymbolName
end

function LLVMOrcDisposeInstance(JITStack)
    @runtime_ccall (:LLVMOrcDisposeInstance, libllvm[]) LLVMErrorRef (LLVMOrcJITStackRef,) JITStack
end

function LLVMOrcRegisterJITEventListener(JITStack, L)
    @runtime_ccall (:LLVMOrcRegisterJITEventListener, libllvm[]) Cvoid (LLVMOrcJITStackRef, LLVMJITEventListenerRef) JITStack L
end

function LLVMOrcUnregisterJITEventListener(JITStack, L)
    @runtime_ccall (:LLVMOrcUnregisterJITEventListener, libllvm[]) Cvoid (LLVMOrcJITStackRef, LLVMJITEventListenerRef) JITStack L
end

@cenum LLVMRemarkType::UInt32 begin
    LLVMRemarkTypeUnknown = 0
    LLVMRemarkTypePassed = 1
    LLVMRemarkTypeMissed = 2
    LLVMRemarkTypeAnalysis = 3
    LLVMRemarkTypeAnalysisFPCommute = 4
    LLVMRemarkTypeAnalysisAliasing = 5
    LLVMRemarkTypeFailure = 6
end

mutable struct LLVMRemarkOpaqueString end

const LLVMRemarkStringRef = Ptr{LLVMRemarkOpaqueString}

function LLVMRemarkStringGetData(String)
    @runtime_ccall (:LLVMRemarkStringGetData, libllvm[]) Cstring (LLVMRemarkStringRef,) String
end

function LLVMRemarkStringGetLen(String)
    @runtime_ccall (:LLVMRemarkStringGetLen, libllvm[]) UInt32 (LLVMRemarkStringRef,) String
end

mutable struct LLVMRemarkOpaqueDebugLoc end

const LLVMRemarkDebugLocRef = Ptr{LLVMRemarkOpaqueDebugLoc}

function LLVMRemarkDebugLocGetSourceFilePath(DL)
    @runtime_ccall (:LLVMRemarkDebugLocGetSourceFilePath, libllvm[]) LLVMRemarkStringRef (LLVMRemarkDebugLocRef,) DL
end

function LLVMRemarkDebugLocGetSourceLine(DL)
    @runtime_ccall (:LLVMRemarkDebugLocGetSourceLine, libllvm[]) UInt32 (LLVMRemarkDebugLocRef,) DL
end

function LLVMRemarkDebugLocGetSourceColumn(DL)
    @runtime_ccall (:LLVMRemarkDebugLocGetSourceColumn, libllvm[]) UInt32 (LLVMRemarkDebugLocRef,) DL
end

mutable struct LLVMRemarkOpaqueArg end

const LLVMRemarkArgRef = Ptr{LLVMRemarkOpaqueArg}

function LLVMRemarkArgGetKey(Arg)
    @runtime_ccall (:LLVMRemarkArgGetKey, libllvm[]) LLVMRemarkStringRef (LLVMRemarkArgRef,) Arg
end

function LLVMRemarkArgGetValue(Arg)
    @runtime_ccall (:LLVMRemarkArgGetValue, libllvm[]) LLVMRemarkStringRef (LLVMRemarkArgRef,) Arg
end

function LLVMRemarkArgGetDebugLoc(Arg)
    @runtime_ccall (:LLVMRemarkArgGetDebugLoc, libllvm[]) LLVMRemarkDebugLocRef (LLVMRemarkArgRef,) Arg
end

mutable struct LLVMRemarkOpaqueEntry end

const LLVMRemarkEntryRef = Ptr{LLVMRemarkOpaqueEntry}

function LLVMRemarkEntryDispose(Remark)
    @runtime_ccall (:LLVMRemarkEntryDispose, libllvm[]) Cvoid (LLVMRemarkEntryRef,) Remark
end

function LLVMRemarkEntryGetType(Remark)
    @runtime_ccall (:LLVMRemarkEntryGetType, libllvm[]) LLVMRemarkType (LLVMRemarkEntryRef,) Remark
end

function LLVMRemarkEntryGetPassName(Remark)
    @runtime_ccall (:LLVMRemarkEntryGetPassName, libllvm[]) LLVMRemarkStringRef (LLVMRemarkEntryRef,) Remark
end

function LLVMRemarkEntryGetRemarkName(Remark)
    @runtime_ccall (:LLVMRemarkEntryGetRemarkName, libllvm[]) LLVMRemarkStringRef (LLVMRemarkEntryRef,) Remark
end

function LLVMRemarkEntryGetFunctionName(Remark)
    @runtime_ccall (:LLVMRemarkEntryGetFunctionName, libllvm[]) LLVMRemarkStringRef (LLVMRemarkEntryRef,) Remark
end

function LLVMRemarkEntryGetDebugLoc(Remark)
    @runtime_ccall (:LLVMRemarkEntryGetDebugLoc, libllvm[]) LLVMRemarkDebugLocRef (LLVMRemarkEntryRef,) Remark
end

function LLVMRemarkEntryGetHotness(Remark)
    @runtime_ccall (:LLVMRemarkEntryGetHotness, libllvm[]) UInt64 (LLVMRemarkEntryRef,) Remark
end

function LLVMRemarkEntryGetNumArgs(Remark)
    @runtime_ccall (:LLVMRemarkEntryGetNumArgs, libllvm[]) UInt32 (LLVMRemarkEntryRef,) Remark
end

function LLVMRemarkEntryGetFirstArg(Remark)
    @runtime_ccall (:LLVMRemarkEntryGetFirstArg, libllvm[]) LLVMRemarkArgRef (LLVMRemarkEntryRef,) Remark
end

function LLVMRemarkEntryGetNextArg(It, Remark)
    @runtime_ccall (:LLVMRemarkEntryGetNextArg, libllvm[]) LLVMRemarkArgRef (LLVMRemarkArgRef, LLVMRemarkEntryRef) It Remark
end

mutable struct LLVMRemarkOpaqueParser end

const LLVMRemarkParserRef = Ptr{LLVMRemarkOpaqueParser}

function LLVMRemarkParserCreateYAML(Buf, Size)
    @runtime_ccall (:LLVMRemarkParserCreateYAML, libllvm[]) LLVMRemarkParserRef (Ptr{Cvoid}, UInt64) Buf Size
end

function LLVMRemarkParserCreateBitstream(Buf, Size)
    @runtime_ccall (:LLVMRemarkParserCreateBitstream, libllvm[]) LLVMRemarkParserRef (Ptr{Cvoid}, UInt64) Buf Size
end

function LLVMRemarkParserGetNext(Parser)
    @runtime_ccall (:LLVMRemarkParserGetNext, libllvm[]) LLVMRemarkEntryRef (LLVMRemarkParserRef,) Parser
end

function LLVMRemarkParserHasError(Parser)
    @runtime_ccall (:LLVMRemarkParserHasError, libllvm[]) LLVMBool (LLVMRemarkParserRef,) Parser
end

function LLVMRemarkParserGetErrorMessage(Parser)
    @runtime_ccall (:LLVMRemarkParserGetErrorMessage, libllvm[]) Cstring (LLVMRemarkParserRef,) Parser
end

function LLVMRemarkParserDispose(Parser)
    @runtime_ccall (:LLVMRemarkParserDispose, libllvm[]) Cvoid (LLVMRemarkParserRef,) Parser
end

function LLVMRemarkVersion()
    @runtime_ccall (:LLVMRemarkVersion, libllvm[]) UInt32 ()
end

function LLVMLoadLibraryPermanently(Filename)
    @runtime_ccall (:LLVMLoadLibraryPermanently, libllvm[]) LLVMBool (Cstring,) Filename
end

function LLVMParseCommandLineOptions(argc, argv, Overview)
    @runtime_ccall (:LLVMParseCommandLineOptions, libllvm[]) Cvoid (Cint, Ptr{Cstring}, Cstring) argc argv Overview
end

function LLVMSearchForAddressOfSymbol(symbolName)
    @runtime_ccall (:LLVMSearchForAddressOfSymbol, libllvm[]) Ptr{Cvoid} (Cstring,) symbolName
end

function LLVMAddSymbol(symbolName, symbolValue)
    @runtime_ccall (:LLVMAddSymbol, libllvm[]) Cvoid (Cstring, Ptr{Cvoid}) symbolName symbolValue
end

@cenum LLVMByteOrdering::UInt32 begin
    LLVMBigEndian = 0
    LLVMLittleEndian = 1
end

mutable struct LLVMOpaqueTargetLibraryInfotData end

const LLVMTargetLibraryInfoRef = Ptr{LLVMOpaqueTargetLibraryInfotData}

function LLVMGetModuleDataLayout(M)
    @runtime_ccall (:LLVMGetModuleDataLayout, libllvm[]) LLVMTargetDataRef (LLVMModuleRef,) M
end

function LLVMSetModuleDataLayout(M, DL)
    @runtime_ccall (:LLVMSetModuleDataLayout, libllvm[]) Cvoid (LLVMModuleRef, LLVMTargetDataRef) M DL
end

function LLVMCreateTargetData(StringRep)
    @runtime_ccall (:LLVMCreateTargetData, libllvm[]) LLVMTargetDataRef (Cstring,) StringRep
end

function LLVMDisposeTargetData(TD)
    @runtime_ccall (:LLVMDisposeTargetData, libllvm[]) Cvoid (LLVMTargetDataRef,) TD
end

function LLVMAddTargetLibraryInfo(TLI, PM)
    @runtime_ccall (:LLVMAddTargetLibraryInfo, libllvm[]) Cvoid (LLVMTargetLibraryInfoRef, LLVMPassManagerRef) TLI PM
end

function LLVMCopyStringRepOfTargetData(TD)
    @runtime_ccall (:LLVMCopyStringRepOfTargetData, libllvm[]) Cstring (LLVMTargetDataRef,) TD
end

function LLVMByteOrder(TD)
    @runtime_ccall (:LLVMByteOrder, libllvm[]) LLVMByteOrdering (LLVMTargetDataRef,) TD
end

function LLVMPointerSize(TD)
    @runtime_ccall (:LLVMPointerSize, libllvm[]) Cuint (LLVMTargetDataRef,) TD
end

function LLVMPointerSizeForAS(TD, AS)
    @runtime_ccall (:LLVMPointerSizeForAS, libllvm[]) Cuint (LLVMTargetDataRef, Cuint) TD AS
end

function LLVMIntPtrType(TD)
    @runtime_ccall (:LLVMIntPtrType, libllvm[]) LLVMTypeRef (LLVMTargetDataRef,) TD
end

function LLVMIntPtrTypeForAS(TD, AS)
    @runtime_ccall (:LLVMIntPtrTypeForAS, libllvm[]) LLVMTypeRef (LLVMTargetDataRef, Cuint) TD AS
end

function LLVMIntPtrTypeInContext(C, TD)
    @runtime_ccall (:LLVMIntPtrTypeInContext, libllvm[]) LLVMTypeRef (LLVMContextRef, LLVMTargetDataRef) C TD
end

function LLVMIntPtrTypeForASInContext(C, TD, AS)
    @runtime_ccall (:LLVMIntPtrTypeForASInContext, libllvm[]) LLVMTypeRef (LLVMContextRef, LLVMTargetDataRef, Cuint) C TD AS
end

function LLVMSizeOfTypeInBits(TD, Ty)
    @runtime_ccall (:LLVMSizeOfTypeInBits, libllvm[]) Culonglong (LLVMTargetDataRef, LLVMTypeRef) TD Ty
end

function LLVMStoreSizeOfType(TD, Ty)
    @runtime_ccall (:LLVMStoreSizeOfType, libllvm[]) Culonglong (LLVMTargetDataRef, LLVMTypeRef) TD Ty
end

function LLVMABISizeOfType(TD, Ty)
    @runtime_ccall (:LLVMABISizeOfType, libllvm[]) Culonglong (LLVMTargetDataRef, LLVMTypeRef) TD Ty
end

function LLVMABIAlignmentOfType(TD, Ty)
    @runtime_ccall (:LLVMABIAlignmentOfType, libllvm[]) Cuint (LLVMTargetDataRef, LLVMTypeRef) TD Ty
end

function LLVMCallFrameAlignmentOfType(TD, Ty)
    @runtime_ccall (:LLVMCallFrameAlignmentOfType, libllvm[]) Cuint (LLVMTargetDataRef, LLVMTypeRef) TD Ty
end

function LLVMPreferredAlignmentOfType(TD, Ty)
    @runtime_ccall (:LLVMPreferredAlignmentOfType, libllvm[]) Cuint (LLVMTargetDataRef, LLVMTypeRef) TD Ty
end

function LLVMPreferredAlignmentOfGlobal(TD, GlobalVar)
    @runtime_ccall (:LLVMPreferredAlignmentOfGlobal, libllvm[]) Cuint (LLVMTargetDataRef, LLVMValueRef) TD GlobalVar
end

function LLVMElementAtOffset(TD, StructTy, Offset)
    @runtime_ccall (:LLVMElementAtOffset, libllvm[]) Cuint (LLVMTargetDataRef, LLVMTypeRef, Culonglong) TD StructTy Offset
end

function LLVMOffsetOfElement(TD, StructTy, Element)
    @runtime_ccall (:LLVMOffsetOfElement, libllvm[]) Culonglong (LLVMTargetDataRef, LLVMTypeRef, Cuint) TD StructTy Element
end

mutable struct LLVMTarget end

const LLVMTargetRef = Ptr{LLVMTarget}

@cenum LLVMCodeGenOptLevel::UInt32 begin
    LLVMCodeGenLevelNone = 0
    LLVMCodeGenLevelLess = 1
    LLVMCodeGenLevelDefault = 2
    LLVMCodeGenLevelAggressive = 3
end

@cenum LLVMRelocMode::UInt32 begin
    LLVMRelocDefault = 0
    LLVMRelocStatic = 1
    LLVMRelocPIC = 2
    LLVMRelocDynamicNoPic = 3
    LLVMRelocROPI = 4
    LLVMRelocRWPI = 5
    LLVMRelocROPI_RWPI = 6
end

@cenum LLVMCodeGenFileType::UInt32 begin
    LLVMAssemblyFile = 0
    LLVMObjectFile = 1
end

function LLVMGetFirstTarget()
    @runtime_ccall (:LLVMGetFirstTarget, libllvm[]) LLVMTargetRef ()
end

function LLVMGetNextTarget(T)
    @runtime_ccall (:LLVMGetNextTarget, libllvm[]) LLVMTargetRef (LLVMTargetRef,) T
end

function LLVMGetTargetFromName(Name)
    @runtime_ccall (:LLVMGetTargetFromName, libllvm[]) LLVMTargetRef (Cstring,) Name
end

function LLVMGetTargetFromTriple(Triple, T, ErrorMessage)
    @runtime_ccall (:LLVMGetTargetFromTriple, libllvm[]) LLVMBool (Cstring, Ptr{LLVMTargetRef}, Ptr{Cstring}) Triple T ErrorMessage
end

function LLVMGetTargetName(T)
    @runtime_ccall (:LLVMGetTargetName, libllvm[]) Cstring (LLVMTargetRef,) T
end

function LLVMGetTargetDescription(T)
    @runtime_ccall (:LLVMGetTargetDescription, libllvm[]) Cstring (LLVMTargetRef,) T
end

function LLVMTargetHasJIT(T)
    @runtime_ccall (:LLVMTargetHasJIT, libllvm[]) LLVMBool (LLVMTargetRef,) T
end

function LLVMTargetHasTargetMachine(T)
    @runtime_ccall (:LLVMTargetHasTargetMachine, libllvm[]) LLVMBool (LLVMTargetRef,) T
end

function LLVMTargetHasAsmBackend(T)
    @runtime_ccall (:LLVMTargetHasAsmBackend, libllvm[]) LLVMBool (LLVMTargetRef,) T
end

function LLVMCreateTargetMachine(T, Triple, CPU, Features, Level, Reloc, CodeModel)
    @runtime_ccall (:LLVMCreateTargetMachine, libllvm[]) LLVMTargetMachineRef (LLVMTargetRef, Cstring, Cstring, Cstring, LLVMCodeGenOptLevel, LLVMRelocMode, LLVMCodeModel) T Triple CPU Features Level Reloc CodeModel
end

function LLVMDisposeTargetMachine(T)
    @runtime_ccall (:LLVMDisposeTargetMachine, libllvm[]) Cvoid (LLVMTargetMachineRef,) T
end

function LLVMGetTargetMachineTarget(T)
    @runtime_ccall (:LLVMGetTargetMachineTarget, libllvm[]) LLVMTargetRef (LLVMTargetMachineRef,) T
end

function LLVMGetTargetMachineTriple(T)
    @runtime_ccall (:LLVMGetTargetMachineTriple, libllvm[]) Cstring (LLVMTargetMachineRef,) T
end

function LLVMGetTargetMachineCPU(T)
    @runtime_ccall (:LLVMGetTargetMachineCPU, libllvm[]) Cstring (LLVMTargetMachineRef,) T
end

function LLVMGetTargetMachineFeatureString(T)
    @runtime_ccall (:LLVMGetTargetMachineFeatureString, libllvm[]) Cstring (LLVMTargetMachineRef,) T
end

function LLVMCreateTargetDataLayout(T)
    @runtime_ccall (:LLVMCreateTargetDataLayout, libllvm[]) LLVMTargetDataRef (LLVMTargetMachineRef,) T
end

function LLVMSetTargetMachineAsmVerbosity(T, VerboseAsm)
    @runtime_ccall (:LLVMSetTargetMachineAsmVerbosity, libllvm[]) Cvoid (LLVMTargetMachineRef, LLVMBool) T VerboseAsm
end

function LLVMTargetMachineEmitToFile(T, M, Filename, codegen, ErrorMessage)
    @runtime_ccall (:LLVMTargetMachineEmitToFile, libllvm[]) LLVMBool (LLVMTargetMachineRef, LLVMModuleRef, Cstring, LLVMCodeGenFileType, Ptr{Cstring}) T M Filename codegen ErrorMessage
end

function LLVMTargetMachineEmitToMemoryBuffer(T, M, codegen, ErrorMessage, OutMemBuf)
    @runtime_ccall (:LLVMTargetMachineEmitToMemoryBuffer, libllvm[]) LLVMBool (LLVMTargetMachineRef, LLVMModuleRef, LLVMCodeGenFileType, Ptr{Cstring}, Ptr{LLVMMemoryBufferRef}) T M codegen ErrorMessage OutMemBuf
end

function LLVMGetDefaultTargetTriple()
    @runtime_ccall (:LLVMGetDefaultTargetTriple, libllvm[]) Cstring ()
end

function LLVMNormalizeTargetTriple(triple)
    @runtime_ccall (:LLVMNormalizeTargetTriple, libllvm[]) Cstring (Cstring,) triple
end

function LLVMGetHostCPUName()
    @runtime_ccall (:LLVMGetHostCPUName, libllvm[]) Cstring ()
end

function LLVMGetHostCPUFeatures()
    @runtime_ccall (:LLVMGetHostCPUFeatures, libllvm[]) Cstring ()
end

function LLVMAddAnalysisPasses(T, PM)
    @runtime_ccall (:LLVMAddAnalysisPasses, libllvm[]) Cvoid (LLVMTargetMachineRef, LLVMPassManagerRef) T PM
end

const lto_bool_t = Bool

@cenum lto_symbol_attributes::UInt32 begin
    LTO_SYMBOL_ALIGNMENT_MASK = 31
    LTO_SYMBOL_PERMISSIONS_MASK = 224
    LTO_SYMBOL_PERMISSIONS_CODE = 160
    LTO_SYMBOL_PERMISSIONS_DATA = 192
    LTO_SYMBOL_PERMISSIONS_RODATA = 128
    LTO_SYMBOL_DEFINITION_MASK = 1792
    LTO_SYMBOL_DEFINITION_REGULAR = 256
    LTO_SYMBOL_DEFINITION_TENTATIVE = 512
    LTO_SYMBOL_DEFINITION_WEAK = 768
    LTO_SYMBOL_DEFINITION_UNDEFINED = 1024
    LTO_SYMBOL_DEFINITION_WEAKUNDEF = 1280
    LTO_SYMBOL_SCOPE_MASK = 14336
    LTO_SYMBOL_SCOPE_INTERNAL = 2048
    LTO_SYMBOL_SCOPE_HIDDEN = 4096
    LTO_SYMBOL_SCOPE_PROTECTED = 8192
    LTO_SYMBOL_SCOPE_DEFAULT = 6144
    LTO_SYMBOL_SCOPE_DEFAULT_CAN_BE_HIDDEN = 10240
    LTO_SYMBOL_COMDAT = 16384
    LTO_SYMBOL_ALIAS = 32768
end

@cenum lto_debug_model::UInt32 begin
    LTO_DEBUG_MODEL_NONE = 0
    LTO_DEBUG_MODEL_DWARF = 1
end

@cenum lto_codegen_model::UInt32 begin
    LTO_CODEGEN_PIC_MODEL_STATIC = 0
    LTO_CODEGEN_PIC_MODEL_DYNAMIC = 1
    LTO_CODEGEN_PIC_MODEL_DYNAMIC_NO_PIC = 2
    LTO_CODEGEN_PIC_MODEL_DEFAULT = 3
end

mutable struct LLVMOpaqueLTOModule end

const lto_module_t = Ptr{LLVMOpaqueLTOModule}

mutable struct LLVMOpaqueLTOCodeGenerator end

const lto_code_gen_t = Ptr{LLVMOpaqueLTOCodeGenerator}

mutable struct LLVMOpaqueThinLTOCodeGenerator end

const thinlto_code_gen_t = Ptr{LLVMOpaqueThinLTOCodeGenerator}

function lto_get_version()
    @runtime_ccall (:lto_get_version, libllvm[]) Cstring ()
end

function lto_get_error_message()
    @runtime_ccall (:lto_get_error_message, libllvm[]) Cstring ()
end

function lto_module_is_object_file(path)
    @runtime_ccall (:lto_module_is_object_file, libllvm[]) lto_bool_t (Cstring,) path
end

function lto_module_is_object_file_for_target(path, target_triple_prefix)
    @runtime_ccall (:lto_module_is_object_file_for_target, libllvm[]) lto_bool_t (Cstring, Cstring) path target_triple_prefix
end

function lto_module_has_objc_category(mem, length)
    @runtime_ccall (:lto_module_has_objc_category, libllvm[]) lto_bool_t (Ptr{Cvoid}, Csize_t) mem length
end

function lto_module_is_object_file_in_memory(mem, length)
    @runtime_ccall (:lto_module_is_object_file_in_memory, libllvm[]) lto_bool_t (Ptr{Cvoid}, Csize_t) mem length
end

function lto_module_is_object_file_in_memory_for_target(mem, length, target_triple_prefix)
    @runtime_ccall (:lto_module_is_object_file_in_memory_for_target, libllvm[]) lto_bool_t (Ptr{Cvoid}, Csize_t, Cstring) mem length target_triple_prefix
end

function lto_module_create(path)
    @runtime_ccall (:lto_module_create, libllvm[]) lto_module_t (Cstring,) path
end

function lto_module_create_from_memory(mem, length)
    @runtime_ccall (:lto_module_create_from_memory, libllvm[]) lto_module_t (Ptr{Cvoid}, Csize_t) mem length
end

function lto_module_create_from_memory_with_path(mem, length, path)
    @runtime_ccall (:lto_module_create_from_memory_with_path, libllvm[]) lto_module_t (Ptr{Cvoid}, Csize_t, Cstring) mem length path
end

function lto_module_create_in_local_context(mem, length, path)
    @runtime_ccall (:lto_module_create_in_local_context, libllvm[]) lto_module_t (Ptr{Cvoid}, Csize_t, Cstring) mem length path
end

function lto_module_create_in_codegen_context(mem, length, path, cg)
    @runtime_ccall (:lto_module_create_in_codegen_context, libllvm[]) lto_module_t (Ptr{Cvoid}, Csize_t, Cstring, lto_code_gen_t) mem length path cg
end

function lto_module_create_from_fd(fd, path, file_size)
    @runtime_ccall (:lto_module_create_from_fd, libllvm[]) lto_module_t (Cint, Cstring, Csize_t) fd path file_size
end

function lto_module_create_from_fd_at_offset(fd, path, file_size, map_size, offset)
    @runtime_ccall (:lto_module_create_from_fd_at_offset, libllvm[]) lto_module_t (Cint, Cstring, Csize_t, Csize_t, off_t) fd path file_size map_size offset
end

function lto_module_dispose(mod)
    @runtime_ccall (:lto_module_dispose, libllvm[]) Cvoid (lto_module_t,) mod
end

function lto_module_get_target_triple(mod)
    @runtime_ccall (:lto_module_get_target_triple, libllvm[]) Cstring (lto_module_t,) mod
end

function lto_module_set_target_triple(mod, triple)
    @runtime_ccall (:lto_module_set_target_triple, libllvm[]) Cvoid (lto_module_t, Cstring) mod triple
end

function lto_module_get_num_symbols(mod)
    @runtime_ccall (:lto_module_get_num_symbols, libllvm[]) Cuint (lto_module_t,) mod
end

function lto_module_get_symbol_name(mod, index)
    @runtime_ccall (:lto_module_get_symbol_name, libllvm[]) Cstring (lto_module_t, Cuint) mod index
end

function lto_module_get_symbol_attribute(mod, index)
    @runtime_ccall (:lto_module_get_symbol_attribute, libllvm[]) lto_symbol_attributes (lto_module_t, Cuint) mod index
end

function lto_module_get_linkeropts(mod)
    @runtime_ccall (:lto_module_get_linkeropts, libllvm[]) Cstring (lto_module_t,) mod
end

function lto_module_get_macho_cputype(mod, out_cputype, out_cpusubtype)
    @runtime_ccall (:lto_module_get_macho_cputype, libllvm[]) lto_bool_t (lto_module_t, Ptr{Cuint}, Ptr{Cuint}) mod out_cputype out_cpusubtype
end

@cenum lto_codegen_diagnostic_severity_t::UInt32 begin
    LTO_DS_ERROR = 0
    LTO_DS_WARNING = 1
    LTO_DS_REMARK = 3
    LTO_DS_NOTE = 2
end

# typedef void ( * lto_diagnostic_handler_t ) ( lto_codegen_diagnostic_severity_t severity , const char * diag , void * ctxt )
const lto_diagnostic_handler_t = Ptr{Cvoid}

function lto_codegen_set_diagnostic_handler(arg1, arg2, arg3)
    @runtime_ccall (:lto_codegen_set_diagnostic_handler, libllvm[]) Cvoid (lto_code_gen_t, lto_diagnostic_handler_t, Ptr{Cvoid}) arg1 arg2 arg3
end

function lto_codegen_create()
    @runtime_ccall (:lto_codegen_create, libllvm[]) lto_code_gen_t ()
end

function lto_codegen_create_in_local_context()
    @runtime_ccall (:lto_codegen_create_in_local_context, libllvm[]) lto_code_gen_t ()
end

function lto_codegen_dispose(arg1)
    @runtime_ccall (:lto_codegen_dispose, libllvm[]) Cvoid (lto_code_gen_t,) arg1
end

function lto_codegen_add_module(cg, mod)
    @runtime_ccall (:lto_codegen_add_module, libllvm[]) lto_bool_t (lto_code_gen_t, lto_module_t) cg mod
end

function lto_codegen_set_module(cg, mod)
    @runtime_ccall (:lto_codegen_set_module, libllvm[]) Cvoid (lto_code_gen_t, lto_module_t) cg mod
end

function lto_codegen_set_debug_model(cg, arg2)
    @runtime_ccall (:lto_codegen_set_debug_model, libllvm[]) lto_bool_t (lto_code_gen_t, lto_debug_model) cg arg2
end

function lto_codegen_set_pic_model(cg, arg2)
    @runtime_ccall (:lto_codegen_set_pic_model, libllvm[]) lto_bool_t (lto_code_gen_t, lto_codegen_model) cg arg2
end

function lto_codegen_set_cpu(cg, cpu)
    @runtime_ccall (:lto_codegen_set_cpu, libllvm[]) Cvoid (lto_code_gen_t, Cstring) cg cpu
end

function lto_codegen_set_assembler_path(cg, path)
    @runtime_ccall (:lto_codegen_set_assembler_path, libllvm[]) Cvoid (lto_code_gen_t, Cstring) cg path
end

function lto_codegen_set_assembler_args(cg, args, nargs)
    @runtime_ccall (:lto_codegen_set_assembler_args, libllvm[]) Cvoid (lto_code_gen_t, Ptr{Cstring}, Cint) cg args nargs
end

function lto_codegen_add_must_preserve_symbol(cg, symbol)
    @runtime_ccall (:lto_codegen_add_must_preserve_symbol, libllvm[]) Cvoid (lto_code_gen_t, Cstring) cg symbol
end

function lto_codegen_write_merged_modules(cg, path)
    @runtime_ccall (:lto_codegen_write_merged_modules, libllvm[]) lto_bool_t (lto_code_gen_t, Cstring) cg path
end

function lto_codegen_compile(cg, length)
    @runtime_ccall (:lto_codegen_compile, libllvm[]) Ptr{Cvoid} (lto_code_gen_t, Ptr{Csize_t}) cg length
end

function lto_codegen_compile_to_file(cg, name)
    @runtime_ccall (:lto_codegen_compile_to_file, libllvm[]) lto_bool_t (lto_code_gen_t, Ptr{Cstring}) cg name
end

function lto_codegen_optimize(cg)
    @runtime_ccall (:lto_codegen_optimize, libllvm[]) lto_bool_t (lto_code_gen_t,) cg
end

function lto_codegen_compile_optimized(cg, length)
    @runtime_ccall (:lto_codegen_compile_optimized, libllvm[]) Ptr{Cvoid} (lto_code_gen_t, Ptr{Csize_t}) cg length
end

function lto_api_version()
    @runtime_ccall (:lto_api_version, libllvm[]) Cuint ()
end

function lto_codegen_debug_options(cg, arg2)
    @runtime_ccall (:lto_codegen_debug_options, libllvm[]) Cvoid (lto_code_gen_t, Cstring) cg arg2
end

function lto_codegen_debug_options_array(cg, arg2, number)
    @runtime_ccall (:lto_codegen_debug_options_array, libllvm[]) Cvoid (lto_code_gen_t, Ptr{Cstring}, Cint) cg arg2 number
end

function lto_initialize_disassembler()
    @runtime_ccall (:lto_initialize_disassembler, libllvm[]) Cvoid ()
end

function lto_codegen_set_should_internalize(cg, ShouldInternalize)
    @runtime_ccall (:lto_codegen_set_should_internalize, libllvm[]) Cvoid (lto_code_gen_t, lto_bool_t) cg ShouldInternalize
end

function lto_codegen_set_should_embed_uselists(cg, ShouldEmbedUselists)
    @runtime_ccall (:lto_codegen_set_should_embed_uselists, libllvm[]) Cvoid (lto_code_gen_t, lto_bool_t) cg ShouldEmbedUselists
end

mutable struct LLVMOpaqueLTOInput end

const lto_input_t = Ptr{LLVMOpaqueLTOInput}

function lto_input_create(buffer, buffer_size, path)
    @runtime_ccall (:lto_input_create, libllvm[]) lto_input_t (Ptr{Cvoid}, Csize_t, Cstring) buffer buffer_size path
end

function lto_input_dispose(input)
    @runtime_ccall (:lto_input_dispose, libllvm[]) Cvoid (lto_input_t,) input
end

function lto_input_get_num_dependent_libraries(input)
    @runtime_ccall (:lto_input_get_num_dependent_libraries, libllvm[]) Cuint (lto_input_t,) input
end

function lto_input_get_dependent_library(input, index, size)
    @runtime_ccall (:lto_input_get_dependent_library, libllvm[]) Cstring (lto_input_t, Csize_t, Ptr{Csize_t}) input index size
end

function lto_runtime_lib_symbols_list(size)
    @runtime_ccall (:lto_runtime_lib_symbols_list, libllvm[]) Ptr{Cstring} (Ptr{Csize_t},) size
end

struct LTOObjectBuffer
    Buffer::Cstring
    Size::Csize_t
end

function thinlto_create_codegen()
    @runtime_ccall (:thinlto_create_codegen, libllvm[]) thinlto_code_gen_t ()
end

function thinlto_codegen_dispose(cg)
    @runtime_ccall (:thinlto_codegen_dispose, libllvm[]) Cvoid (thinlto_code_gen_t,) cg
end

function thinlto_codegen_add_module(cg, identifier, data, length)
    @runtime_ccall (:thinlto_codegen_add_module, libllvm[]) Cvoid (thinlto_code_gen_t, Cstring, Cstring, Cint) cg identifier data length
end

function thinlto_codegen_process(cg)
    @runtime_ccall (:thinlto_codegen_process, libllvm[]) Cvoid (thinlto_code_gen_t,) cg
end

function thinlto_module_get_num_objects(cg)
    @runtime_ccall (:thinlto_module_get_num_objects, libllvm[]) Cuint (thinlto_code_gen_t,) cg
end

function thinlto_module_get_object(cg, index)
    @runtime_ccall (:thinlto_module_get_object, libllvm[]) LTOObjectBuffer (thinlto_code_gen_t, Cuint) cg index
end

function thinlto_module_get_num_object_files(cg)
    @runtime_ccall (:thinlto_module_get_num_object_files, libllvm[]) Cuint (thinlto_code_gen_t,) cg
end

function thinlto_module_get_object_file(cg, index)
    @runtime_ccall (:thinlto_module_get_object_file, libllvm[]) Cstring (thinlto_code_gen_t, Cuint) cg index
end

function thinlto_codegen_set_pic_model(cg, arg2)
    @runtime_ccall (:thinlto_codegen_set_pic_model, libllvm[]) lto_bool_t (thinlto_code_gen_t, lto_codegen_model) cg arg2
end

function thinlto_codegen_set_savetemps_dir(cg, save_temps_dir)
    @runtime_ccall (:thinlto_codegen_set_savetemps_dir, libllvm[]) Cvoid (thinlto_code_gen_t, Cstring) cg save_temps_dir
end

function thinlto_set_generated_objects_dir(cg, save_temps_dir)
    @runtime_ccall (:thinlto_set_generated_objects_dir, libllvm[]) Cvoid (thinlto_code_gen_t, Cstring) cg save_temps_dir
end

function thinlto_codegen_set_cpu(cg, cpu)
    @runtime_ccall (:thinlto_codegen_set_cpu, libllvm[]) Cvoid (thinlto_code_gen_t, Cstring) cg cpu
end

function thinlto_codegen_disable_codegen(cg, disable)
    @runtime_ccall (:thinlto_codegen_disable_codegen, libllvm[]) Cvoid (thinlto_code_gen_t, lto_bool_t) cg disable
end

function thinlto_codegen_set_codegen_only(cg, codegen_only)
    @runtime_ccall (:thinlto_codegen_set_codegen_only, libllvm[]) Cvoid (thinlto_code_gen_t, lto_bool_t) cg codegen_only
end

function thinlto_debug_options(options, number)
    @runtime_ccall (:thinlto_debug_options, libllvm[]) Cvoid (Ptr{Cstring}, Cint) options number
end

function lto_module_is_thinlto(mod)
    @runtime_ccall (:lto_module_is_thinlto, libllvm[]) lto_bool_t (lto_module_t,) mod
end

function thinlto_codegen_add_must_preserve_symbol(cg, name, length)
    @runtime_ccall (:thinlto_codegen_add_must_preserve_symbol, libllvm[]) Cvoid (thinlto_code_gen_t, Cstring, Cint) cg name length
end

function thinlto_codegen_add_cross_referenced_symbol(cg, name, length)
    @runtime_ccall (:thinlto_codegen_add_cross_referenced_symbol, libllvm[]) Cvoid (thinlto_code_gen_t, Cstring, Cint) cg name length
end

function thinlto_codegen_set_cache_dir(cg, cache_dir)
    @runtime_ccall (:thinlto_codegen_set_cache_dir, libllvm[]) Cvoid (thinlto_code_gen_t, Cstring) cg cache_dir
end

function thinlto_codegen_set_cache_pruning_interval(cg, interval)
    @runtime_ccall (:thinlto_codegen_set_cache_pruning_interval, libllvm[]) Cvoid (thinlto_code_gen_t, Cint) cg interval
end

function thinlto_codegen_set_final_cache_size_relative_to_available_space(cg, percentage)
    @runtime_ccall (:thinlto_codegen_set_final_cache_size_relative_to_available_space, libllvm[]) Cvoid (thinlto_code_gen_t, Cuint) cg percentage
end

function thinlto_codegen_set_cache_entry_expiration(cg, expiration)
    @runtime_ccall (:thinlto_codegen_set_cache_entry_expiration, libllvm[]) Cvoid (thinlto_code_gen_t, Cuint) cg expiration
end

function thinlto_codegen_set_cache_size_bytes(cg, max_size_bytes)
    @runtime_ccall (:thinlto_codegen_set_cache_size_bytes, libllvm[]) Cvoid (thinlto_code_gen_t, Cuint) cg max_size_bytes
end

function thinlto_codegen_set_cache_size_megabytes(cg, max_size_megabytes)
    @runtime_ccall (:thinlto_codegen_set_cache_size_megabytes, libllvm[]) Cvoid (thinlto_code_gen_t, Cuint) cg max_size_megabytes
end

function thinlto_codegen_set_cache_size_files(cg, max_size_files)
    @runtime_ccall (:thinlto_codegen_set_cache_size_files, libllvm[]) Cvoid (thinlto_code_gen_t, Cuint) cg max_size_files
end

function LLVMAddAggressiveInstCombinerPass(PM)
    @runtime_ccall (:LLVMAddAggressiveInstCombinerPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddCoroEarlyPass(PM)
    @runtime_ccall (:LLVMAddCoroEarlyPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddCoroSplitPass(PM)
    @runtime_ccall (:LLVMAddCoroSplitPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddCoroElidePass(PM)
    @runtime_ccall (:LLVMAddCoroElidePass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddCoroCleanupPass(PM)
    @runtime_ccall (:LLVMAddCoroCleanupPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

mutable struct LLVMOpaquePassManagerBuilder end

const LLVMPassManagerBuilderRef = Ptr{LLVMOpaquePassManagerBuilder}

function LLVMPassManagerBuilderAddCoroutinePassesToExtensionPoints(PMB)
    @runtime_ccall (:LLVMPassManagerBuilderAddCoroutinePassesToExtensionPoints, libllvm[]) Cvoid (LLVMPassManagerBuilderRef,) PMB
end

function LLVMAddArgumentPromotionPass(PM)
    @runtime_ccall (:LLVMAddArgumentPromotionPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddConstantMergePass(PM)
    @runtime_ccall (:LLVMAddConstantMergePass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddMergeFunctionsPass(PM)
    @runtime_ccall (:LLVMAddMergeFunctionsPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddCalledValuePropagationPass(PM)
    @runtime_ccall (:LLVMAddCalledValuePropagationPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddDeadArgEliminationPass(PM)
    @runtime_ccall (:LLVMAddDeadArgEliminationPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddFunctionAttrsPass(PM)
    @runtime_ccall (:LLVMAddFunctionAttrsPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddFunctionInliningPass(PM)
    @runtime_ccall (:LLVMAddFunctionInliningPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddAlwaysInlinerPass(PM)
    @runtime_ccall (:LLVMAddAlwaysInlinerPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddGlobalDCEPass(PM)
    @runtime_ccall (:LLVMAddGlobalDCEPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddGlobalOptimizerPass(PM)
    @runtime_ccall (:LLVMAddGlobalOptimizerPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddIPConstantPropagationPass(PM)
    @runtime_ccall (:LLVMAddIPConstantPropagationPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddPruneEHPass(PM)
    @runtime_ccall (:LLVMAddPruneEHPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddIPSCCPPass(PM)
    @runtime_ccall (:LLVMAddIPSCCPPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddInternalizePass(arg1, AllButMain)
    @runtime_ccall (:LLVMAddInternalizePass, libllvm[]) Cvoid (LLVMPassManagerRef, Cuint) arg1 AllButMain
end

function LLVMAddInternalizePassWithMustPreservePredicate(PM, Context, MustPreserve)
    @runtime_ccall (:LLVMAddInternalizePassWithMustPreservePredicate, libllvm[]) Cvoid (LLVMPassManagerRef, Ptr{Cvoid}, Ptr{Cvoid}) PM Context MustPreserve
end

function LLVMAddStripDeadPrototypesPass(PM)
    @runtime_ccall (:LLVMAddStripDeadPrototypesPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddStripSymbolsPass(PM)
    @runtime_ccall (:LLVMAddStripSymbolsPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddInstructionCombiningPass(PM)
    @runtime_ccall (:LLVMAddInstructionCombiningPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMPassManagerBuilderCreate()
    @runtime_ccall (:LLVMPassManagerBuilderCreate, libllvm[]) LLVMPassManagerBuilderRef ()
end

function LLVMPassManagerBuilderDispose(PMB)
    @runtime_ccall (:LLVMPassManagerBuilderDispose, libllvm[]) Cvoid (LLVMPassManagerBuilderRef,) PMB
end

function LLVMPassManagerBuilderSetOptLevel(PMB, OptLevel)
    @runtime_ccall (:LLVMPassManagerBuilderSetOptLevel, libllvm[]) Cvoid (LLVMPassManagerBuilderRef, Cuint) PMB OptLevel
end

function LLVMPassManagerBuilderSetSizeLevel(PMB, SizeLevel)
    @runtime_ccall (:LLVMPassManagerBuilderSetSizeLevel, libllvm[]) Cvoid (LLVMPassManagerBuilderRef, Cuint) PMB SizeLevel
end

function LLVMPassManagerBuilderSetDisableUnitAtATime(PMB, Value)
    @runtime_ccall (:LLVMPassManagerBuilderSetDisableUnitAtATime, libllvm[]) Cvoid (LLVMPassManagerBuilderRef, LLVMBool) PMB Value
end

function LLVMPassManagerBuilderSetDisableUnrollLoops(PMB, Value)
    @runtime_ccall (:LLVMPassManagerBuilderSetDisableUnrollLoops, libllvm[]) Cvoid (LLVMPassManagerBuilderRef, LLVMBool) PMB Value
end

function LLVMPassManagerBuilderSetDisableSimplifyLibCalls(PMB, Value)
    @runtime_ccall (:LLVMPassManagerBuilderSetDisableSimplifyLibCalls, libllvm[]) Cvoid (LLVMPassManagerBuilderRef, LLVMBool) PMB Value
end

function LLVMPassManagerBuilderUseInlinerWithThreshold(PMB, Threshold)
    @runtime_ccall (:LLVMPassManagerBuilderUseInlinerWithThreshold, libllvm[]) Cvoid (LLVMPassManagerBuilderRef, Cuint) PMB Threshold
end

function LLVMPassManagerBuilderPopulateFunctionPassManager(PMB, PM)
    @runtime_ccall (:LLVMPassManagerBuilderPopulateFunctionPassManager, libllvm[]) Cvoid (LLVMPassManagerBuilderRef, LLVMPassManagerRef) PMB PM
end

function LLVMPassManagerBuilderPopulateModulePassManager(PMB, PM)
    @runtime_ccall (:LLVMPassManagerBuilderPopulateModulePassManager, libllvm[]) Cvoid (LLVMPassManagerBuilderRef, LLVMPassManagerRef) PMB PM
end

function LLVMPassManagerBuilderPopulateLTOPassManager(PMB, PM, Internalize, RunInliner)
    @runtime_ccall (:LLVMPassManagerBuilderPopulateLTOPassManager, libllvm[]) Cvoid (LLVMPassManagerBuilderRef, LLVMPassManagerRef, LLVMBool, LLVMBool) PMB PM Internalize RunInliner
end

function LLVMAddAggressiveDCEPass(PM)
    @runtime_ccall (:LLVMAddAggressiveDCEPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddDCEPass(PM)
    @runtime_ccall (:LLVMAddDCEPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddBitTrackingDCEPass(PM)
    @runtime_ccall (:LLVMAddBitTrackingDCEPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddAlignmentFromAssumptionsPass(PM)
    @runtime_ccall (:LLVMAddAlignmentFromAssumptionsPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddCFGSimplificationPass(PM)
    @runtime_ccall (:LLVMAddCFGSimplificationPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddDeadStoreEliminationPass(PM)
    @runtime_ccall (:LLVMAddDeadStoreEliminationPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddScalarizerPass(PM)
    @runtime_ccall (:LLVMAddScalarizerPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddMergedLoadStoreMotionPass(PM)
    @runtime_ccall (:LLVMAddMergedLoadStoreMotionPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddGVNPass(PM)
    @runtime_ccall (:LLVMAddGVNPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddNewGVNPass(PM)
    @runtime_ccall (:LLVMAddNewGVNPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddIndVarSimplifyPass(PM)
    @runtime_ccall (:LLVMAddIndVarSimplifyPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddJumpThreadingPass(PM)
    @runtime_ccall (:LLVMAddJumpThreadingPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLICMPass(PM)
    @runtime_ccall (:LLVMAddLICMPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLoopDeletionPass(PM)
    @runtime_ccall (:LLVMAddLoopDeletionPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLoopIdiomPass(PM)
    @runtime_ccall (:LLVMAddLoopIdiomPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLoopRotatePass(PM)
    @runtime_ccall (:LLVMAddLoopRotatePass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLoopRerollPass(PM)
    @runtime_ccall (:LLVMAddLoopRerollPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLoopUnrollPass(PM)
    @runtime_ccall (:LLVMAddLoopUnrollPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLoopUnrollAndJamPass(PM)
    @runtime_ccall (:LLVMAddLoopUnrollAndJamPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLoopUnswitchPass(PM)
    @runtime_ccall (:LLVMAddLoopUnswitchPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLowerAtomicPass(PM)
    @runtime_ccall (:LLVMAddLowerAtomicPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddMemCpyOptPass(PM)
    @runtime_ccall (:LLVMAddMemCpyOptPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddPartiallyInlineLibCallsPass(PM)
    @runtime_ccall (:LLVMAddPartiallyInlineLibCallsPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddReassociatePass(PM)
    @runtime_ccall (:LLVMAddReassociatePass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddSCCPPass(PM)
    @runtime_ccall (:LLVMAddSCCPPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddScalarReplAggregatesPass(PM)
    @runtime_ccall (:LLVMAddScalarReplAggregatesPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddScalarReplAggregatesPassSSA(PM)
    @runtime_ccall (:LLVMAddScalarReplAggregatesPassSSA, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddScalarReplAggregatesPassWithThreshold(PM, Threshold)
    @runtime_ccall (:LLVMAddScalarReplAggregatesPassWithThreshold, libllvm[]) Cvoid (LLVMPassManagerRef, Cint) PM Threshold
end

function LLVMAddSimplifyLibCallsPass(PM)
    @runtime_ccall (:LLVMAddSimplifyLibCallsPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddTailCallEliminationPass(PM)
    @runtime_ccall (:LLVMAddTailCallEliminationPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddConstantPropagationPass(PM)
    @runtime_ccall (:LLVMAddConstantPropagationPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddDemoteMemoryToRegisterPass(PM)
    @runtime_ccall (:LLVMAddDemoteMemoryToRegisterPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddVerifierPass(PM)
    @runtime_ccall (:LLVMAddVerifierPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddCorrelatedValuePropagationPass(PM)
    @runtime_ccall (:LLVMAddCorrelatedValuePropagationPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddEarlyCSEPass(PM)
    @runtime_ccall (:LLVMAddEarlyCSEPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddEarlyCSEMemSSAPass(PM)
    @runtime_ccall (:LLVMAddEarlyCSEMemSSAPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLowerExpectIntrinsicPass(PM)
    @runtime_ccall (:LLVMAddLowerExpectIntrinsicPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLowerConstantIntrinsicsPass(PM)
    @runtime_ccall (:LLVMAddLowerConstantIntrinsicsPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddTypeBasedAliasAnalysisPass(PM)
    @runtime_ccall (:LLVMAddTypeBasedAliasAnalysisPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddScopedNoAliasAAPass(PM)
    @runtime_ccall (:LLVMAddScopedNoAliasAAPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddBasicAliasAnalysisPass(PM)
    @runtime_ccall (:LLVMAddBasicAliasAnalysisPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddUnifyFunctionExitNodesPass(PM)
    @runtime_ccall (:LLVMAddUnifyFunctionExitNodesPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLowerSwitchPass(PM)
    @runtime_ccall (:LLVMAddLowerSwitchPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddPromoteMemoryToRegisterPass(PM)
    @runtime_ccall (:LLVMAddPromoteMemoryToRegisterPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddAddDiscriminatorsPass(PM)
    @runtime_ccall (:LLVMAddAddDiscriminatorsPass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLoopVectorizePass(PM)
    @runtime_ccall (:LLVMAddLoopVectorizePass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddSLPVectorizePass(PM)
    @runtime_ccall (:LLVMAddSLPVectorizePass, libllvm[]) Cvoid (LLVMPassManagerRef,) PM
end

const LLVMDisassembler_Option_UseMarkup = 1

const LLVMDisassembler_Option_PrintImmHex = 2

const LLVMDisassembler_Option_AsmPrinterVariant = 4

const LLVMDisassembler_Option_SetInstrComments = 8

const LLVMDisassembler_Option_PrintLatency = 16

const LLVMDisassembler_VariantKind_None = 0

const LLVMDisassembler_VariantKind_ARM_HI16 = 1

const LLVMDisassembler_VariantKind_ARM_LO16 = 2

const LLVMDisassembler_VariantKind_ARM64_PAGE = 1

const LLVMDisassembler_VariantKind_ARM64_PAGEOFF = 2

const LLVMDisassembler_VariantKind_ARM64_GOTPAGE = 3

const LLVMDisassembler_VariantKind_ARM64_GOTPAGEOFF = 4

const LLVMDisassembler_VariantKind_ARM64_TLVP = 5

const LLVMDisassembler_VariantKind_ARM64_TLVOFF = 6

const LLVMDisassembler_ReferenceType_InOut_None = 0

const LLVMDisassembler_ReferenceType_In_Branch = 1

const LLVMDisassembler_ReferenceType_In_PCrel_Load = 2

const LLVMDisassembler_ReferenceType_In_ARM64_ADRP = 0x0000000100000001

const LLVMDisassembler_ReferenceType_In_ARM64_ADDXri = 0x0000000100000002

const LLVMDisassembler_ReferenceType_In_ARM64_LDRXui = 0x0000000100000003

const LLVMDisassembler_ReferenceType_In_ARM64_LDRXl = 0x0000000100000004

const LLVMDisassembler_ReferenceType_In_ARM64_ADR = 0x0000000100000005

const LLVMDisassembler_ReferenceType_Out_SymbolStub = 1

const LLVMDisassembler_ReferenceType_Out_LitPool_SymAddr = 2

const LLVMDisassembler_ReferenceType_Out_LitPool_CstrAddr = 3

const LLVMDisassembler_ReferenceType_Out_Objc_CFString_Ref = 4

const LLVMDisassembler_ReferenceType_Out_Objc_Message = 5

const LLVMDisassembler_ReferenceType_Out_Objc_Message_Ref = 6

const LLVMDisassembler_ReferenceType_Out_Objc_Selector_Ref = 7

const LLVMDisassembler_ReferenceType_Out_Objc_Class_Ref = 8

const LLVMDisassembler_ReferenceType_DeMangled_Name = 9

const LLVMErrorSuccess = 0

const REMARKS_API_VERSION = 1

const LTO_API_VERSION = 27

