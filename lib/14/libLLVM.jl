using CEnum

const IS_LIBC_MUSL = occursin("musl", Base.MACHINE)

if Sys.islinux() && Sys.ARCH === :aarch64 && !IS_LIBC_MUSL
    const __off_t = Clong
    const off_t = __off_t
elseif Sys.islinux() && Sys.ARCH === :aarch64 && IS_LIBC_MUSL
    const off_t = Clong
elseif Sys.islinux() && startswith(string(Sys.ARCH), "arm") && !IS_LIBC_MUSL
    const __off_t = Clong
    const off_t = __off_t
elseif Sys.islinux() && startswith(string(Sys.ARCH), "arm") && IS_LIBC_MUSL
    const off_t = Clonglong
elseif Sys.islinux() && Sys.ARCH === :i686 && !IS_LIBC_MUSL
    const __off_t = Clong
    const off_t = __off_t
elseif Sys.islinux() && Sys.ARCH === :i686 && IS_LIBC_MUSL
    const off_t = Clonglong
elseif Sys.iswindows() && Sys.ARCH === :i686
    const off32_t = Clong
    const off_t = off32_t
elseif Sys.islinux() && Sys.ARCH === :powerpc64le
    const __off_t = Clong
    const off_t = __off_t
elseif Sys.isapple()
    const __darwin_off_t = Int64
    const off_t = __darwin_off_t
elseif Sys.islinux() && Sys.ARCH === :x86_64 && !IS_LIBC_MUSL
    const __off_t = Clong
    const off_t = __off_t
elseif Sys.islinux() && Sys.ARCH === :x86_64 && IS_LIBC_MUSL
    const off_t = Clong
elseif Sys.isbsd() && !Sys.isapple()
    const __off_t = Int64
    const off_t = __off_t
elseif Sys.iswindows() && Sys.ARCH === :x86_64
    const off32_t = Clong
    const off_t = off32_t
end



mutable struct LLVMOpaqueMemoryBuffer end

mutable struct LLVMOpaqueContext end

mutable struct LLVMOpaqueModule end

mutable struct LLVMOpaqueType end

mutable struct LLVMOpaqueValue end

mutable struct LLVMOpaqueBasicBlock end

mutable struct LLVMOpaqueMetadata end

mutable struct LLVMOpaqueNamedMDNode end

mutable struct LLVMOpaqueValueMetadataEntry end

mutable struct LLVMOpaqueBuilder end

mutable struct LLVMOpaqueDIBuilder end

mutable struct LLVMOpaqueModuleProvider end

mutable struct LLVMOpaquePassManager end

mutable struct LLVMOpaquePassRegistry end

mutable struct LLVMOpaqueUse end

mutable struct LLVMOpaqueAttributeRef end

mutable struct LLVMOpaqueDiagnosticInfo end

mutable struct LLVMComdat end

mutable struct LLVMOpaqueModuleFlagEntry end

mutable struct LLVMOpaqueJITEventListener end

mutable struct LLVMOpaqueBinary end

mutable struct LLVMOpaqueTargetData end

mutable struct LLVMOpaqueTargetLibraryInfotData end

mutable struct LLVMOpaqueTargetMachine end

mutable struct LLVMTarget end

mutable struct LLVMOpaqueError end

mutable struct LLVMOrcOpaqueExecutionSession end

mutable struct LLVMOrcOpaqueSymbolStringPool end

mutable struct LLVMOrcOpaqueSymbolStringPoolEntry end

mutable struct LLVMOrcOpaqueJITDylib end

mutable struct LLVMOrcOpaqueMaterializationUnit end

mutable struct LLVMOrcOpaqueMaterializationResponsibility end

mutable struct LLVMOrcOpaqueResourceTracker end

mutable struct LLVMOrcOpaqueDefinitionGenerator end

mutable struct LLVMOrcOpaqueLookupState end

mutable struct LLVMOrcOpaqueThreadSafeContext end

mutable struct LLVMOrcOpaqueThreadSafeModule end

mutable struct LLVMOrcOpaqueJITTargetMachineBuilder end

mutable struct LLVMOrcOpaqueObjectLayer end

mutable struct LLVMOrcOpaqueObjectLinkingLayer end

mutable struct LLVMOrcOpaqueIRTransformLayer end

mutable struct LLVMOrcOpaqueObjectTransformLayer end

mutable struct LLVMOrcOpaqueIndirectStubsManager end

mutable struct LLVMOrcOpaqueLazyCallThroughManager end

mutable struct LLVMOrcOpaqueDumpObjects end

mutable struct LLVMOpaqueGenericValue end

mutable struct LLVMOpaqueExecutionEngine end

mutable struct LLVMOpaqueMCJITMemoryManager end

mutable struct LLVMOpaquePassManagerBuilder end

@cenum LLVMVerifierFailureAction::UInt32 begin
    LLVMAbortProcessAction = 0
    LLVMPrintMessageAction = 1
    LLVMReturnStatusAction = 2
end

const LLVMModuleRef = Ptr{LLVMOpaqueModule}

const LLVMBool = Cint

function LLVMVerifyModule(M, Action, OutMessage)
    ccall((:LLVMVerifyModule, libllvm), LLVMBool, (LLVMModuleRef, LLVMVerifierFailureAction, Ptr{Cstring}), M, Action, OutMessage)
end

const LLVMValueRef = Ptr{LLVMOpaqueValue}

function LLVMVerifyFunction(Fn, Action)
    ccall((:LLVMVerifyFunction, libllvm), LLVMBool, (LLVMValueRef, LLVMVerifierFailureAction), Fn, Action)
end

function LLVMViewFunctionCFG(Fn)
    ccall((:LLVMViewFunctionCFG, libllvm), Cvoid, (LLVMValueRef,), Fn)
end

function LLVMViewFunctionCFGOnly(Fn)
    ccall((:LLVMViewFunctionCFGOnly, libllvm), Cvoid, (LLVMValueRef,), Fn)
end

const LLVMMemoryBufferRef = Ptr{LLVMOpaqueMemoryBuffer}

function LLVMParseBitcode(MemBuf, OutModule, OutMessage)
    ccall((:LLVMParseBitcode, libllvm), LLVMBool, (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), MemBuf, OutModule, OutMessage)
end

function LLVMParseBitcode2(MemBuf, OutModule)
    ccall((:LLVMParseBitcode2, libllvm), LLVMBool, (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}), MemBuf, OutModule)
end

const LLVMContextRef = Ptr{LLVMOpaqueContext}

function LLVMParseBitcodeInContext(ContextRef, MemBuf, OutModule, OutMessage)
    ccall((:LLVMParseBitcodeInContext, libllvm), LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), ContextRef, MemBuf, OutModule, OutMessage)
end

function LLVMParseBitcodeInContext2(ContextRef, MemBuf, OutModule)
    ccall((:LLVMParseBitcodeInContext2, libllvm), LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}), ContextRef, MemBuf, OutModule)
end

function LLVMGetBitcodeModuleInContext(ContextRef, MemBuf, OutM, OutMessage)
    ccall((:LLVMGetBitcodeModuleInContext, libllvm), LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), ContextRef, MemBuf, OutM, OutMessage)
end

function LLVMGetBitcodeModuleInContext2(ContextRef, MemBuf, OutM)
    ccall((:LLVMGetBitcodeModuleInContext2, libllvm), LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}), ContextRef, MemBuf, OutM)
end

function LLVMGetBitcodeModule(MemBuf, OutM, OutMessage)
    ccall((:LLVMGetBitcodeModule, libllvm), LLVMBool, (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), MemBuf, OutM, OutMessage)
end

function LLVMGetBitcodeModule2(MemBuf, OutM)
    ccall((:LLVMGetBitcodeModule2, libllvm), LLVMBool, (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}), MemBuf, OutM)
end

function LLVMWriteBitcodeToFile(M, Path)
    ccall((:LLVMWriteBitcodeToFile, libllvm), Cint, (LLVMModuleRef, Cstring), M, Path)
end

function LLVMWriteBitcodeToFD(M, FD, ShouldClose, Unbuffered)
    ccall((:LLVMWriteBitcodeToFD, libllvm), Cint, (LLVMModuleRef, Cint, Cint, Cint), M, FD, ShouldClose, Unbuffered)
end

function LLVMWriteBitcodeToFileHandle(M, Handle)
    ccall((:LLVMWriteBitcodeToFileHandle, libllvm), Cint, (LLVMModuleRef, Cint), M, Handle)
end

function LLVMWriteBitcodeToMemoryBuffer(M)
    ccall((:LLVMWriteBitcodeToMemoryBuffer, libllvm), LLVMMemoryBufferRef, (LLVMModuleRef,), M)
end

@cenum LLVMComdatSelectionKind::UInt32 begin
    LLVMAnyComdatSelectionKind = 0
    LLVMExactMatchComdatSelectionKind = 1
    LLVMLargestComdatSelectionKind = 2
    LLVMNoDeduplicateComdatSelectionKind = 3
    LLVMSameSizeComdatSelectionKind = 4
end

const LLVMComdatRef = Ptr{LLVMComdat}

function LLVMGetOrInsertComdat(M, Name)
    ccall((:LLVMGetOrInsertComdat, libllvm), LLVMComdatRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetComdat(V)
    ccall((:LLVMGetComdat, libllvm), LLVMComdatRef, (LLVMValueRef,), V)
end

function LLVMSetComdat(V, C)
    ccall((:LLVMSetComdat, libllvm), Cvoid, (LLVMValueRef, LLVMComdatRef), V, C)
end

function LLVMGetComdatSelectionKind(C)
    ccall((:LLVMGetComdatSelectionKind, libllvm), LLVMComdatSelectionKind, (LLVMComdatRef,), C)
end

function LLVMSetComdatSelectionKind(C, Kind)
    ccall((:LLVMSetComdatSelectionKind, libllvm), Cvoid, (LLVMComdatRef, LLVMComdatSelectionKind), C, Kind)
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
    LLVMX86_AMXTypeKind = 19
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
    LLVMPoisonValueValueKind = 25
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

@cenum __JL_Ctag_85::Int32 begin
    LLVMAttributeReturnIndex = 0
    LLVMAttributeFunctionIndex = -1
end

const LLVMAttributeIndex = Cuint

const LLVMPassRegistryRef = Ptr{LLVMOpaquePassRegistry}

function LLVMInitializeCore(R)
    ccall((:LLVMInitializeCore, libllvm), Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMShutdown()
    ccall((:LLVMShutdown, libllvm), Cvoid, ())
end

function LLVMCreateMessage(Message)
    ccall((:LLVMCreateMessage, libllvm), Cstring, (Cstring,), Message)
end

function LLVMDisposeMessage(Message)
    ccall((:LLVMDisposeMessage, libllvm), Cvoid, (Cstring,), Message)
end

# typedef void ( * LLVMDiagnosticHandler ) ( LLVMDiagnosticInfoRef , void * )
const LLVMDiagnosticHandler = Ptr{Cvoid}

# typedef void ( * LLVMYieldCallback ) ( LLVMContextRef , void * )
const LLVMYieldCallback = Ptr{Cvoid}

function LLVMContextCreate()
    ccall((:LLVMContextCreate, libllvm), LLVMContextRef, ())
end

function LLVMGetGlobalContext()
    ccall((:LLVMGetGlobalContext, libllvm), LLVMContextRef, ())
end

function LLVMContextSetDiagnosticHandler(C, Handler, DiagnosticContext)
    ccall((:LLVMContextSetDiagnosticHandler, libllvm), Cvoid, (LLVMContextRef, LLVMDiagnosticHandler, Ptr{Cvoid}), C, Handler, DiagnosticContext)
end

function LLVMContextGetDiagnosticHandler(C)
    ccall((:LLVMContextGetDiagnosticHandler, libllvm), LLVMDiagnosticHandler, (LLVMContextRef,), C)
end

function LLVMContextGetDiagnosticContext(C)
    ccall((:LLVMContextGetDiagnosticContext, libllvm), Ptr{Cvoid}, (LLVMContextRef,), C)
end

function LLVMContextSetYieldCallback(C, Callback, OpaqueHandle)
    ccall((:LLVMContextSetYieldCallback, libllvm), Cvoid, (LLVMContextRef, LLVMYieldCallback, Ptr{Cvoid}), C, Callback, OpaqueHandle)
end

function LLVMContextShouldDiscardValueNames(C)
    ccall((:LLVMContextShouldDiscardValueNames, libllvm), LLVMBool, (LLVMContextRef,), C)
end

function LLVMContextSetDiscardValueNames(C, Discard)
    ccall((:LLVMContextSetDiscardValueNames, libllvm), Cvoid, (LLVMContextRef, LLVMBool), C, Discard)
end

function LLVMContextDispose(C)
    ccall((:LLVMContextDispose, libllvm), Cvoid, (LLVMContextRef,), C)
end

const LLVMDiagnosticInfoRef = Ptr{LLVMOpaqueDiagnosticInfo}

function LLVMGetDiagInfoDescription(DI)
    ccall((:LLVMGetDiagInfoDescription, libllvm), Cstring, (LLVMDiagnosticInfoRef,), DI)
end

function LLVMGetDiagInfoSeverity(DI)
    ccall((:LLVMGetDiagInfoSeverity, libllvm), LLVMDiagnosticSeverity, (LLVMDiagnosticInfoRef,), DI)
end

function LLVMGetMDKindIDInContext(C, Name, SLen)
    ccall((:LLVMGetMDKindIDInContext, libllvm), Cuint, (LLVMContextRef, Cstring, Cuint), C, Name, SLen)
end

function LLVMGetMDKindID(Name, SLen)
    ccall((:LLVMGetMDKindID, libllvm), Cuint, (Cstring, Cuint), Name, SLen)
end

function LLVMGetEnumAttributeKindForName(Name, SLen)
    ccall((:LLVMGetEnumAttributeKindForName, libllvm), Cuint, (Cstring, Csize_t), Name, SLen)
end

function LLVMGetLastEnumAttributeKind()
    ccall((:LLVMGetLastEnumAttributeKind, libllvm), Cuint, ())
end

const LLVMAttributeRef = Ptr{LLVMOpaqueAttributeRef}

function LLVMCreateEnumAttribute(C, KindID, Val)
    ccall((:LLVMCreateEnumAttribute, libllvm), LLVMAttributeRef, (LLVMContextRef, Cuint, UInt64), C, KindID, Val)
end

function LLVMGetEnumAttributeKind(A)
    ccall((:LLVMGetEnumAttributeKind, libllvm), Cuint, (LLVMAttributeRef,), A)
end

function LLVMGetEnumAttributeValue(A)
    ccall((:LLVMGetEnumAttributeValue, libllvm), UInt64, (LLVMAttributeRef,), A)
end

const LLVMTypeRef = Ptr{LLVMOpaqueType}

function LLVMCreateTypeAttribute(C, KindID, type_ref)
    ccall((:LLVMCreateTypeAttribute, libllvm), LLVMAttributeRef, (LLVMContextRef, Cuint, LLVMTypeRef), C, KindID, type_ref)
end

function LLVMGetTypeAttributeValue(A)
    ccall((:LLVMGetTypeAttributeValue, libllvm), LLVMTypeRef, (LLVMAttributeRef,), A)
end

function LLVMCreateStringAttribute(C, K, KLength, V, VLength)
    ccall((:LLVMCreateStringAttribute, libllvm), LLVMAttributeRef, (LLVMContextRef, Cstring, Cuint, Cstring, Cuint), C, K, KLength, V, VLength)
end

function LLVMGetStringAttributeKind(A, Length)
    ccall((:LLVMGetStringAttributeKind, libllvm), Cstring, (LLVMAttributeRef, Ptr{Cuint}), A, Length)
end

function LLVMGetStringAttributeValue(A, Length)
    ccall((:LLVMGetStringAttributeValue, libllvm), Cstring, (LLVMAttributeRef, Ptr{Cuint}), A, Length)
end

function LLVMIsEnumAttribute(A)
    ccall((:LLVMIsEnumAttribute, libllvm), LLVMBool, (LLVMAttributeRef,), A)
end

function LLVMIsStringAttribute(A)
    ccall((:LLVMIsStringAttribute, libllvm), LLVMBool, (LLVMAttributeRef,), A)
end

function LLVMIsTypeAttribute(A)
    ccall((:LLVMIsTypeAttribute, libllvm), LLVMBool, (LLVMAttributeRef,), A)
end

function LLVMGetTypeByName2(C, Name)
    ccall((:LLVMGetTypeByName2, libllvm), LLVMTypeRef, (LLVMContextRef, Cstring), C, Name)
end

function LLVMModuleCreateWithName(ModuleID)
    ccall((:LLVMModuleCreateWithName, libllvm), LLVMModuleRef, (Cstring,), ModuleID)
end

function LLVMModuleCreateWithNameInContext(ModuleID, C)
    ccall((:LLVMModuleCreateWithNameInContext, libllvm), LLVMModuleRef, (Cstring, LLVMContextRef), ModuleID, C)
end

function LLVMCloneModule(M)
    ccall((:LLVMCloneModule, libllvm), LLVMModuleRef, (LLVMModuleRef,), M)
end

function LLVMDisposeModule(M)
    ccall((:LLVMDisposeModule, libllvm), Cvoid, (LLVMModuleRef,), M)
end

function LLVMGetModuleIdentifier(M, Len)
    ccall((:LLVMGetModuleIdentifier, libllvm), Cstring, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMSetModuleIdentifier(M, Ident, Len)
    ccall((:LLVMSetModuleIdentifier, libllvm), Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Ident, Len)
end

function LLVMGetSourceFileName(M, Len)
    ccall((:LLVMGetSourceFileName, libllvm), Cstring, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMSetSourceFileName(M, Name, Len)
    ccall((:LLVMSetSourceFileName, libllvm), Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Name, Len)
end

function LLVMGetDataLayoutStr(M)
    ccall((:LLVMGetDataLayoutStr, libllvm), Cstring, (LLVMModuleRef,), M)
end

function LLVMGetDataLayout(M)
    ccall((:LLVMGetDataLayout, libllvm), Cstring, (LLVMModuleRef,), M)
end

function LLVMSetDataLayout(M, DataLayoutStr)
    ccall((:LLVMSetDataLayout, libllvm), Cvoid, (LLVMModuleRef, Cstring), M, DataLayoutStr)
end

function LLVMGetTarget(M)
    ccall((:LLVMGetTarget, libllvm), Cstring, (LLVMModuleRef,), M)
end

function LLVMSetTarget(M, Triple)
    ccall((:LLVMSetTarget, libllvm), Cvoid, (LLVMModuleRef, Cstring), M, Triple)
end

const LLVMModuleFlagEntry = LLVMOpaqueModuleFlagEntry

function LLVMCopyModuleFlagsMetadata(M, Len)
    ccall((:LLVMCopyModuleFlagsMetadata, libllvm), Ptr{LLVMModuleFlagEntry}, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMDisposeModuleFlagsMetadata(Entries)
    ccall((:LLVMDisposeModuleFlagsMetadata, libllvm), Cvoid, (Ptr{LLVMModuleFlagEntry},), Entries)
end

function LLVMModuleFlagEntriesGetFlagBehavior(Entries, Index)
    ccall((:LLVMModuleFlagEntriesGetFlagBehavior, libllvm), LLVMModuleFlagBehavior, (Ptr{LLVMModuleFlagEntry}, Cuint), Entries, Index)
end

function LLVMModuleFlagEntriesGetKey(Entries, Index, Len)
    ccall((:LLVMModuleFlagEntriesGetKey, libllvm), Cstring, (Ptr{LLVMModuleFlagEntry}, Cuint, Ptr{Csize_t}), Entries, Index, Len)
end

const LLVMMetadataRef = Ptr{LLVMOpaqueMetadata}

function LLVMModuleFlagEntriesGetMetadata(Entries, Index)
    ccall((:LLVMModuleFlagEntriesGetMetadata, libllvm), LLVMMetadataRef, (Ptr{LLVMModuleFlagEntry}, Cuint), Entries, Index)
end

function LLVMGetModuleFlag(M, Key, KeyLen)
    ccall((:LLVMGetModuleFlag, libllvm), LLVMMetadataRef, (LLVMModuleRef, Cstring, Csize_t), M, Key, KeyLen)
end

function LLVMAddModuleFlag(M, Behavior, Key, KeyLen, Val)
    ccall((:LLVMAddModuleFlag, libllvm), Cvoid, (LLVMModuleRef, LLVMModuleFlagBehavior, Cstring, Csize_t, LLVMMetadataRef), M, Behavior, Key, KeyLen, Val)
end

function LLVMDumpModule(M)
    ccall((:LLVMDumpModule, libllvm), Cvoid, (LLVMModuleRef,), M)
end

function LLVMPrintModuleToFile(M, Filename, ErrorMessage)
    ccall((:LLVMPrintModuleToFile, libllvm), LLVMBool, (LLVMModuleRef, Cstring, Ptr{Cstring}), M, Filename, ErrorMessage)
end

function LLVMPrintModuleToString(M)
    ccall((:LLVMPrintModuleToString, libllvm), Cstring, (LLVMModuleRef,), M)
end

function LLVMGetModuleInlineAsm(M, Len)
    ccall((:LLVMGetModuleInlineAsm, libllvm), Cstring, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMSetModuleInlineAsm2(M, Asm, Len)
    ccall((:LLVMSetModuleInlineAsm2, libllvm), Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Asm, Len)
end

function LLVMAppendModuleInlineAsm(M, Asm, Len)
    ccall((:LLVMAppendModuleInlineAsm, libllvm), Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Asm, Len)
end

function LLVMGetInlineAsm(Ty, AsmString, AsmStringSize, Constraints, ConstraintsSize, HasSideEffects, IsAlignStack, Dialect, CanThrow)
    ccall((:LLVMGetInlineAsm, libllvm), LLVMValueRef, (LLVMTypeRef, Cstring, Csize_t, Cstring, Csize_t, LLVMBool, LLVMBool, LLVMInlineAsmDialect, LLVMBool), Ty, AsmString, AsmStringSize, Constraints, ConstraintsSize, HasSideEffects, IsAlignStack, Dialect, CanThrow)
end

function LLVMGetModuleContext(M)
    ccall((:LLVMGetModuleContext, libllvm), LLVMContextRef, (LLVMModuleRef,), M)
end

function LLVMGetTypeByName(M, Name)
    ccall((:LLVMGetTypeByName, libllvm), LLVMTypeRef, (LLVMModuleRef, Cstring), M, Name)
end

const LLVMNamedMDNodeRef = Ptr{LLVMOpaqueNamedMDNode}

function LLVMGetFirstNamedMetadata(M)
    ccall((:LLVMGetFirstNamedMetadata, libllvm), LLVMNamedMDNodeRef, (LLVMModuleRef,), M)
end

function LLVMGetLastNamedMetadata(M)
    ccall((:LLVMGetLastNamedMetadata, libllvm), LLVMNamedMDNodeRef, (LLVMModuleRef,), M)
end

function LLVMGetNextNamedMetadata(NamedMDNode)
    ccall((:LLVMGetNextNamedMetadata, libllvm), LLVMNamedMDNodeRef, (LLVMNamedMDNodeRef,), NamedMDNode)
end

function LLVMGetPreviousNamedMetadata(NamedMDNode)
    ccall((:LLVMGetPreviousNamedMetadata, libllvm), LLVMNamedMDNodeRef, (LLVMNamedMDNodeRef,), NamedMDNode)
end

function LLVMGetNamedMetadata(M, Name, NameLen)
    ccall((:LLVMGetNamedMetadata, libllvm), LLVMNamedMDNodeRef, (LLVMModuleRef, Cstring, Csize_t), M, Name, NameLen)
end

function LLVMGetOrInsertNamedMetadata(M, Name, NameLen)
    ccall((:LLVMGetOrInsertNamedMetadata, libllvm), LLVMNamedMDNodeRef, (LLVMModuleRef, Cstring, Csize_t), M, Name, NameLen)
end

function LLVMGetNamedMetadataName(NamedMD, NameLen)
    ccall((:LLVMGetNamedMetadataName, libllvm), Cstring, (LLVMNamedMDNodeRef, Ptr{Csize_t}), NamedMD, NameLen)
end

function LLVMGetNamedMetadataNumOperands(M, Name)
    ccall((:LLVMGetNamedMetadataNumOperands, libllvm), Cuint, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetNamedMetadataOperands(M, Name, Dest)
    ccall((:LLVMGetNamedMetadataOperands, libllvm), Cvoid, (LLVMModuleRef, Cstring, Ptr{LLVMValueRef}), M, Name, Dest)
end

function LLVMAddNamedMetadataOperand(M, Name, Val)
    ccall((:LLVMAddNamedMetadataOperand, libllvm), Cvoid, (LLVMModuleRef, Cstring, LLVMValueRef), M, Name, Val)
end

function LLVMGetDebugLocDirectory(Val, Length)
    ccall((:LLVMGetDebugLocDirectory, libllvm), Cstring, (LLVMValueRef, Ptr{Cuint}), Val, Length)
end

function LLVMGetDebugLocFilename(Val, Length)
    ccall((:LLVMGetDebugLocFilename, libllvm), Cstring, (LLVMValueRef, Ptr{Cuint}), Val, Length)
end

function LLVMGetDebugLocLine(Val)
    ccall((:LLVMGetDebugLocLine, libllvm), Cuint, (LLVMValueRef,), Val)
end

function LLVMGetDebugLocColumn(Val)
    ccall((:LLVMGetDebugLocColumn, libllvm), Cuint, (LLVMValueRef,), Val)
end

function LLVMAddFunction(M, Name, FunctionTy)
    ccall((:LLVMAddFunction, libllvm), LLVMValueRef, (LLVMModuleRef, Cstring, LLVMTypeRef), M, Name, FunctionTy)
end

function LLVMGetNamedFunction(M, Name)
    ccall((:LLVMGetNamedFunction, libllvm), LLVMValueRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetFirstFunction(M)
    ccall((:LLVMGetFirstFunction, libllvm), LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastFunction(M)
    ccall((:LLVMGetLastFunction, libllvm), LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextFunction(Fn)
    ccall((:LLVMGetNextFunction, libllvm), LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetPreviousFunction(Fn)
    ccall((:LLVMGetPreviousFunction, libllvm), LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMSetModuleInlineAsm(M, Asm)
    ccall((:LLVMSetModuleInlineAsm, libllvm), Cvoid, (LLVMModuleRef, Cstring), M, Asm)
end

function LLVMGetTypeKind(Ty)
    ccall((:LLVMGetTypeKind, libllvm), LLVMTypeKind, (LLVMTypeRef,), Ty)
end

function LLVMTypeIsSized(Ty)
    ccall((:LLVMTypeIsSized, libllvm), LLVMBool, (LLVMTypeRef,), Ty)
end

function LLVMGetTypeContext(Ty)
    ccall((:LLVMGetTypeContext, libllvm), LLVMContextRef, (LLVMTypeRef,), Ty)
end

function LLVMDumpType(Val)
    ccall((:LLVMDumpType, libllvm), Cvoid, (LLVMTypeRef,), Val)
end

function LLVMPrintTypeToString(Val)
    ccall((:LLVMPrintTypeToString, libllvm), Cstring, (LLVMTypeRef,), Val)
end

function LLVMInt1TypeInContext(C)
    ccall((:LLVMInt1TypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt8TypeInContext(C)
    ccall((:LLVMInt8TypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt16TypeInContext(C)
    ccall((:LLVMInt16TypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt32TypeInContext(C)
    ccall((:LLVMInt32TypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt64TypeInContext(C)
    ccall((:LLVMInt64TypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt128TypeInContext(C)
    ccall((:LLVMInt128TypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMIntTypeInContext(C, NumBits)
    ccall((:LLVMIntTypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef, Cuint), C, NumBits)
end

function LLVMInt1Type()
    ccall((:LLVMInt1Type, libllvm), LLVMTypeRef, ())
end

function LLVMInt8Type()
    ccall((:LLVMInt8Type, libllvm), LLVMTypeRef, ())
end

function LLVMInt16Type()
    ccall((:LLVMInt16Type, libllvm), LLVMTypeRef, ())
end

function LLVMInt32Type()
    ccall((:LLVMInt32Type, libllvm), LLVMTypeRef, ())
end

function LLVMInt64Type()
    ccall((:LLVMInt64Type, libllvm), LLVMTypeRef, ())
end

function LLVMInt128Type()
    ccall((:LLVMInt128Type, libllvm), LLVMTypeRef, ())
end

function LLVMIntType(NumBits)
    ccall((:LLVMIntType, libllvm), LLVMTypeRef, (Cuint,), NumBits)
end

function LLVMGetIntTypeWidth(IntegerTy)
    ccall((:LLVMGetIntTypeWidth, libllvm), Cuint, (LLVMTypeRef,), IntegerTy)
end

function LLVMHalfTypeInContext(C)
    ccall((:LLVMHalfTypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMBFloatTypeInContext(C)
    ccall((:LLVMBFloatTypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMFloatTypeInContext(C)
    ccall((:LLVMFloatTypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMDoubleTypeInContext(C)
    ccall((:LLVMDoubleTypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMX86FP80TypeInContext(C)
    ccall((:LLVMX86FP80TypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMFP128TypeInContext(C)
    ccall((:LLVMFP128TypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMPPCFP128TypeInContext(C)
    ccall((:LLVMPPCFP128TypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMHalfType()
    ccall((:LLVMHalfType, libllvm), LLVMTypeRef, ())
end

function LLVMBFloatType()
    ccall((:LLVMBFloatType, libllvm), LLVMTypeRef, ())
end

function LLVMFloatType()
    ccall((:LLVMFloatType, libllvm), LLVMTypeRef, ())
end

function LLVMDoubleType()
    ccall((:LLVMDoubleType, libllvm), LLVMTypeRef, ())
end

function LLVMX86FP80Type()
    ccall((:LLVMX86FP80Type, libllvm), LLVMTypeRef, ())
end

function LLVMFP128Type()
    ccall((:LLVMFP128Type, libllvm), LLVMTypeRef, ())
end

function LLVMPPCFP128Type()
    ccall((:LLVMPPCFP128Type, libllvm), LLVMTypeRef, ())
end

function LLVMFunctionType(ReturnType, ParamTypes, ParamCount, IsVarArg)
    ccall((:LLVMFunctionType, libllvm), LLVMTypeRef, (LLVMTypeRef, Ptr{LLVMTypeRef}, Cuint, LLVMBool), ReturnType, ParamTypes, ParamCount, IsVarArg)
end

function LLVMIsFunctionVarArg(FunctionTy)
    ccall((:LLVMIsFunctionVarArg, libllvm), LLVMBool, (LLVMTypeRef,), FunctionTy)
end

function LLVMGetReturnType(FunctionTy)
    ccall((:LLVMGetReturnType, libllvm), LLVMTypeRef, (LLVMTypeRef,), FunctionTy)
end

function LLVMCountParamTypes(FunctionTy)
    ccall((:LLVMCountParamTypes, libllvm), Cuint, (LLVMTypeRef,), FunctionTy)
end

function LLVMGetParamTypes(FunctionTy, Dest)
    ccall((:LLVMGetParamTypes, libllvm), Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), FunctionTy, Dest)
end

function LLVMStructTypeInContext(C, ElementTypes, ElementCount, Packed)
    ccall((:LLVMStructTypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef, Ptr{LLVMTypeRef}, Cuint, LLVMBool), C, ElementTypes, ElementCount, Packed)
end

function LLVMStructType(ElementTypes, ElementCount, Packed)
    ccall((:LLVMStructType, libllvm), LLVMTypeRef, (Ptr{LLVMTypeRef}, Cuint, LLVMBool), ElementTypes, ElementCount, Packed)
end

function LLVMStructCreateNamed(C, Name)
    ccall((:LLVMStructCreateNamed, libllvm), LLVMTypeRef, (LLVMContextRef, Cstring), C, Name)
end

function LLVMGetStructName(Ty)
    ccall((:LLVMGetStructName, libllvm), Cstring, (LLVMTypeRef,), Ty)
end

function LLVMStructSetBody(StructTy, ElementTypes, ElementCount, Packed)
    ccall((:LLVMStructSetBody, libllvm), Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}, Cuint, LLVMBool), StructTy, ElementTypes, ElementCount, Packed)
end

function LLVMCountStructElementTypes(StructTy)
    ccall((:LLVMCountStructElementTypes, libllvm), Cuint, (LLVMTypeRef,), StructTy)
end

function LLVMGetStructElementTypes(StructTy, Dest)
    ccall((:LLVMGetStructElementTypes, libllvm), Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), StructTy, Dest)
end

function LLVMStructGetTypeAtIndex(StructTy, i)
    ccall((:LLVMStructGetTypeAtIndex, libllvm), LLVMTypeRef, (LLVMTypeRef, Cuint), StructTy, i)
end

function LLVMIsPackedStruct(StructTy)
    ccall((:LLVMIsPackedStruct, libllvm), LLVMBool, (LLVMTypeRef,), StructTy)
end

function LLVMIsOpaqueStruct(StructTy)
    ccall((:LLVMIsOpaqueStruct, libllvm), LLVMBool, (LLVMTypeRef,), StructTy)
end

function LLVMIsLiteralStruct(StructTy)
    ccall((:LLVMIsLiteralStruct, libllvm), LLVMBool, (LLVMTypeRef,), StructTy)
end

function LLVMGetElementType(Ty)
    ccall((:LLVMGetElementType, libllvm), LLVMTypeRef, (LLVMTypeRef,), Ty)
end

function LLVMGetSubtypes(Tp, Arr)
    ccall((:LLVMGetSubtypes, libllvm), Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), Tp, Arr)
end

function LLVMGetNumContainedTypes(Tp)
    ccall((:LLVMGetNumContainedTypes, libllvm), Cuint, (LLVMTypeRef,), Tp)
end

function LLVMArrayType(ElementType, ElementCount)
    ccall((:LLVMArrayType, libllvm), LLVMTypeRef, (LLVMTypeRef, Cuint), ElementType, ElementCount)
end

function LLVMGetArrayLength(ArrayTy)
    ccall((:LLVMGetArrayLength, libllvm), Cuint, (LLVMTypeRef,), ArrayTy)
end

function LLVMPointerType(ElementType, AddressSpace)
    ccall((:LLVMPointerType, libllvm), LLVMTypeRef, (LLVMTypeRef, Cuint), ElementType, AddressSpace)
end

function LLVMGetPointerAddressSpace(PointerTy)
    ccall((:LLVMGetPointerAddressSpace, libllvm), Cuint, (LLVMTypeRef,), PointerTy)
end

function LLVMVectorType(ElementType, ElementCount)
    ccall((:LLVMVectorType, libllvm), LLVMTypeRef, (LLVMTypeRef, Cuint), ElementType, ElementCount)
end

function LLVMScalableVectorType(ElementType, ElementCount)
    ccall((:LLVMScalableVectorType, libllvm), LLVMTypeRef, (LLVMTypeRef, Cuint), ElementType, ElementCount)
end

function LLVMGetVectorSize(VectorTy)
    ccall((:LLVMGetVectorSize, libllvm), Cuint, (LLVMTypeRef,), VectorTy)
end

function LLVMVoidTypeInContext(C)
    ccall((:LLVMVoidTypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMLabelTypeInContext(C)
    ccall((:LLVMLabelTypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMX86MMXTypeInContext(C)
    ccall((:LLVMX86MMXTypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMX86AMXTypeInContext(C)
    ccall((:LLVMX86AMXTypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMTokenTypeInContext(C)
    ccall((:LLVMTokenTypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMMetadataTypeInContext(C)
    ccall((:LLVMMetadataTypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMVoidType()
    ccall((:LLVMVoidType, libllvm), LLVMTypeRef, ())
end

function LLVMLabelType()
    ccall((:LLVMLabelType, libllvm), LLVMTypeRef, ())
end

function LLVMX86MMXType()
    ccall((:LLVMX86MMXType, libllvm), LLVMTypeRef, ())
end

function LLVMX86AMXType()
    ccall((:LLVMX86AMXType, libllvm), LLVMTypeRef, ())
end

function LLVMTypeOf(Val)
    ccall((:LLVMTypeOf, libllvm), LLVMTypeRef, (LLVMValueRef,), Val)
end

function LLVMGetValueKind(Val)
    ccall((:LLVMGetValueKind, libllvm), LLVMValueKind, (LLVMValueRef,), Val)
end

function LLVMGetValueName2(Val, Length)
    ccall((:LLVMGetValueName2, libllvm), Cstring, (LLVMValueRef, Ptr{Csize_t}), Val, Length)
end

function LLVMSetValueName2(Val, Name, NameLen)
    ccall((:LLVMSetValueName2, libllvm), Cvoid, (LLVMValueRef, Cstring, Csize_t), Val, Name, NameLen)
end

function LLVMDumpValue(Val)
    ccall((:LLVMDumpValue, libllvm), Cvoid, (LLVMValueRef,), Val)
end

function LLVMPrintValueToString(Val)
    ccall((:LLVMPrintValueToString, libllvm), Cstring, (LLVMValueRef,), Val)
end

function LLVMReplaceAllUsesWith(OldVal, NewVal)
    ccall((:LLVMReplaceAllUsesWith, libllvm), Cvoid, (LLVMValueRef, LLVMValueRef), OldVal, NewVal)
end

function LLVMIsConstant(Val)
    ccall((:LLVMIsConstant, libllvm), LLVMBool, (LLVMValueRef,), Val)
end

function LLVMIsUndef(Val)
    ccall((:LLVMIsUndef, libllvm), LLVMBool, (LLVMValueRef,), Val)
end

function LLVMIsPoison(Val)
    ccall((:LLVMIsPoison, libllvm), LLVMBool, (LLVMValueRef,), Val)
end

function LLVMIsAArgument(Val)
    ccall((:LLVMIsAArgument, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABasicBlock(Val)
    ccall((:LLVMIsABasicBlock, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInlineAsm(Val)
    ccall((:LLVMIsAInlineAsm, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUser(Val)
    ccall((:LLVMIsAUser, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstant(Val)
    ccall((:LLVMIsAConstant, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABlockAddress(Val)
    ccall((:LLVMIsABlockAddress, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantAggregateZero(Val)
    ccall((:LLVMIsAConstantAggregateZero, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantArray(Val)
    ccall((:LLVMIsAConstantArray, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataSequential(Val)
    ccall((:LLVMIsAConstantDataSequential, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataArray(Val)
    ccall((:LLVMIsAConstantDataArray, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataVector(Val)
    ccall((:LLVMIsAConstantDataVector, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantExpr(Val)
    ccall((:LLVMIsAConstantExpr, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantFP(Val)
    ccall((:LLVMIsAConstantFP, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantInt(Val)
    ccall((:LLVMIsAConstantInt, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantPointerNull(Val)
    ccall((:LLVMIsAConstantPointerNull, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantStruct(Val)
    ccall((:LLVMIsAConstantStruct, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantTokenNone(Val)
    ccall((:LLVMIsAConstantTokenNone, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantVector(Val)
    ccall((:LLVMIsAConstantVector, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalValue(Val)
    ccall((:LLVMIsAGlobalValue, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalAlias(Val)
    ccall((:LLVMIsAGlobalAlias, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalObject(Val)
    ccall((:LLVMIsAGlobalObject, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFunction(Val)
    ccall((:LLVMIsAFunction, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalVariable(Val)
    ccall((:LLVMIsAGlobalVariable, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalIFunc(Val)
    ccall((:LLVMIsAGlobalIFunc, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUndefValue(Val)
    ccall((:LLVMIsAUndefValue, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAPoisonValue(Val)
    ccall((:LLVMIsAPoisonValue, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInstruction(Val)
    ccall((:LLVMIsAInstruction, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUnaryOperator(Val)
    ccall((:LLVMIsAUnaryOperator, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABinaryOperator(Val)
    ccall((:LLVMIsABinaryOperator, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACallInst(Val)
    ccall((:LLVMIsACallInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIntrinsicInst(Val)
    ccall((:LLVMIsAIntrinsicInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgInfoIntrinsic(Val)
    ccall((:LLVMIsADbgInfoIntrinsic, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgVariableIntrinsic(Val)
    ccall((:LLVMIsADbgVariableIntrinsic, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgDeclareInst(Val)
    ccall((:LLVMIsADbgDeclareInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgLabelInst(Val)
    ccall((:LLVMIsADbgLabelInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemIntrinsic(Val)
    ccall((:LLVMIsAMemIntrinsic, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemCpyInst(Val)
    ccall((:LLVMIsAMemCpyInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemMoveInst(Val)
    ccall((:LLVMIsAMemMoveInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemSetInst(Val)
    ccall((:LLVMIsAMemSetInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACmpInst(Val)
    ccall((:LLVMIsACmpInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFCmpInst(Val)
    ccall((:LLVMIsAFCmpInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAICmpInst(Val)
    ccall((:LLVMIsAICmpInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAExtractElementInst(Val)
    ccall((:LLVMIsAExtractElementInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGetElementPtrInst(Val)
    ccall((:LLVMIsAGetElementPtrInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInsertElementInst(Val)
    ccall((:LLVMIsAInsertElementInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInsertValueInst(Val)
    ccall((:LLVMIsAInsertValueInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsALandingPadInst(Val)
    ccall((:LLVMIsALandingPadInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAPHINode(Val)
    ccall((:LLVMIsAPHINode, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASelectInst(Val)
    ccall((:LLVMIsASelectInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAShuffleVectorInst(Val)
    ccall((:LLVMIsAShuffleVectorInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAStoreInst(Val)
    ccall((:LLVMIsAStoreInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABranchInst(Val)
    ccall((:LLVMIsABranchInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIndirectBrInst(Val)
    ccall((:LLVMIsAIndirectBrInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInvokeInst(Val)
    ccall((:LLVMIsAInvokeInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAReturnInst(Val)
    ccall((:LLVMIsAReturnInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASwitchInst(Val)
    ccall((:LLVMIsASwitchInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUnreachableInst(Val)
    ccall((:LLVMIsAUnreachableInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAResumeInst(Val)
    ccall((:LLVMIsAResumeInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACleanupReturnInst(Val)
    ccall((:LLVMIsACleanupReturnInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACatchReturnInst(Val)
    ccall((:LLVMIsACatchReturnInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACatchSwitchInst(Val)
    ccall((:LLVMIsACatchSwitchInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACallBrInst(Val)
    ccall((:LLVMIsACallBrInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFuncletPadInst(Val)
    ccall((:LLVMIsAFuncletPadInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACatchPadInst(Val)
    ccall((:LLVMIsACatchPadInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACleanupPadInst(Val)
    ccall((:LLVMIsACleanupPadInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUnaryInstruction(Val)
    ccall((:LLVMIsAUnaryInstruction, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAAllocaInst(Val)
    ccall((:LLVMIsAAllocaInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACastInst(Val)
    ccall((:LLVMIsACastInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAAddrSpaceCastInst(Val)
    ccall((:LLVMIsAAddrSpaceCastInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABitCastInst(Val)
    ccall((:LLVMIsABitCastInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPExtInst(Val)
    ccall((:LLVMIsAFPExtInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPToSIInst(Val)
    ccall((:LLVMIsAFPToSIInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPToUIInst(Val)
    ccall((:LLVMIsAFPToUIInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPTruncInst(Val)
    ccall((:LLVMIsAFPTruncInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIntToPtrInst(Val)
    ccall((:LLVMIsAIntToPtrInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAPtrToIntInst(Val)
    ccall((:LLVMIsAPtrToIntInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASExtInst(Val)
    ccall((:LLVMIsASExtInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASIToFPInst(Val)
    ccall((:LLVMIsASIToFPInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsATruncInst(Val)
    ccall((:LLVMIsATruncInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUIToFPInst(Val)
    ccall((:LLVMIsAUIToFPInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAZExtInst(Val)
    ccall((:LLVMIsAZExtInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAExtractValueInst(Val)
    ccall((:LLVMIsAExtractValueInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsALoadInst(Val)
    ccall((:LLVMIsALoadInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAVAArgInst(Val)
    ccall((:LLVMIsAVAArgInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFreezeInst(Val)
    ccall((:LLVMIsAFreezeInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAAtomicCmpXchgInst(Val)
    ccall((:LLVMIsAAtomicCmpXchgInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAAtomicRMWInst(Val)
    ccall((:LLVMIsAAtomicRMWInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFenceInst(Val)
    ccall((:LLVMIsAFenceInst, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMDNode(Val)
    ccall((:LLVMIsAMDNode, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMDString(Val)
    ccall((:LLVMIsAMDString, libllvm), LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMGetValueName(Val)
    ccall((:LLVMGetValueName, libllvm), Cstring, (LLVMValueRef,), Val)
end

function LLVMSetValueName(Val, Name)
    ccall((:LLVMSetValueName, libllvm), Cvoid, (LLVMValueRef, Cstring), Val, Name)
end

const LLVMUseRef = Ptr{LLVMOpaqueUse}

function LLVMGetFirstUse(Val)
    ccall((:LLVMGetFirstUse, libllvm), LLVMUseRef, (LLVMValueRef,), Val)
end

function LLVMGetNextUse(U)
    ccall((:LLVMGetNextUse, libllvm), LLVMUseRef, (LLVMUseRef,), U)
end

function LLVMGetUser(U)
    ccall((:LLVMGetUser, libllvm), LLVMValueRef, (LLVMUseRef,), U)
end

function LLVMGetUsedValue(U)
    ccall((:LLVMGetUsedValue, libllvm), LLVMValueRef, (LLVMUseRef,), U)
end

function LLVMGetOperand(Val, Index)
    ccall((:LLVMGetOperand, libllvm), LLVMValueRef, (LLVMValueRef, Cuint), Val, Index)
end

function LLVMGetOperandUse(Val, Index)
    ccall((:LLVMGetOperandUse, libllvm), LLVMUseRef, (LLVMValueRef, Cuint), Val, Index)
end

function LLVMSetOperand(User, Index, Val)
    ccall((:LLVMSetOperand, libllvm), Cvoid, (LLVMValueRef, Cuint, LLVMValueRef), User, Index, Val)
end

function LLVMGetNumOperands(Val)
    ccall((:LLVMGetNumOperands, libllvm), Cint, (LLVMValueRef,), Val)
end

function LLVMConstNull(Ty)
    ccall((:LLVMConstNull, libllvm), LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstAllOnes(Ty)
    ccall((:LLVMConstAllOnes, libllvm), LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMGetUndef(Ty)
    ccall((:LLVMGetUndef, libllvm), LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMGetPoison(Ty)
    ccall((:LLVMGetPoison, libllvm), LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMIsNull(Val)
    ccall((:LLVMIsNull, libllvm), LLVMBool, (LLVMValueRef,), Val)
end

function LLVMConstPointerNull(Ty)
    ccall((:LLVMConstPointerNull, libllvm), LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstInt(IntTy, N, SignExtend)
    ccall((:LLVMConstInt, libllvm), LLVMValueRef, (LLVMTypeRef, Culonglong, LLVMBool), IntTy, N, SignExtend)
end

function LLVMConstIntOfArbitraryPrecision(IntTy, NumWords, Words)
    ccall((:LLVMConstIntOfArbitraryPrecision, libllvm), LLVMValueRef, (LLVMTypeRef, Cuint, Ptr{UInt64}), IntTy, NumWords, Words)
end

function LLVMConstIntOfString(IntTy, Text, Radix)
    ccall((:LLVMConstIntOfString, libllvm), LLVMValueRef, (LLVMTypeRef, Cstring, UInt8), IntTy, Text, Radix)
end

function LLVMConstIntOfStringAndSize(IntTy, Text, SLen, Radix)
    ccall((:LLVMConstIntOfStringAndSize, libllvm), LLVMValueRef, (LLVMTypeRef, Cstring, Cuint, UInt8), IntTy, Text, SLen, Radix)
end

function LLVMConstReal(RealTy, N)
    ccall((:LLVMConstReal, libllvm), LLVMValueRef, (LLVMTypeRef, Cdouble), RealTy, N)
end

function LLVMConstRealOfString(RealTy, Text)
    ccall((:LLVMConstRealOfString, libllvm), LLVMValueRef, (LLVMTypeRef, Cstring), RealTy, Text)
end

function LLVMConstRealOfStringAndSize(RealTy, Text, SLen)
    ccall((:LLVMConstRealOfStringAndSize, libllvm), LLVMValueRef, (LLVMTypeRef, Cstring, Cuint), RealTy, Text, SLen)
end

function LLVMConstIntGetZExtValue(ConstantVal)
    ccall((:LLVMConstIntGetZExtValue, libllvm), Culonglong, (LLVMValueRef,), ConstantVal)
end

function LLVMConstIntGetSExtValue(ConstantVal)
    ccall((:LLVMConstIntGetSExtValue, libllvm), Clonglong, (LLVMValueRef,), ConstantVal)
end

function LLVMConstRealGetDouble(ConstantVal, losesInfo)
    ccall((:LLVMConstRealGetDouble, libllvm), Cdouble, (LLVMValueRef, Ptr{LLVMBool}), ConstantVal, losesInfo)
end

function LLVMConstStringInContext(C, Str, Length, DontNullTerminate)
    ccall((:LLVMConstStringInContext, libllvm), LLVMValueRef, (LLVMContextRef, Cstring, Cuint, LLVMBool), C, Str, Length, DontNullTerminate)
end

function LLVMConstString(Str, Length, DontNullTerminate)
    ccall((:LLVMConstString, libllvm), LLVMValueRef, (Cstring, Cuint, LLVMBool), Str, Length, DontNullTerminate)
end

function LLVMIsConstantString(c)
    ccall((:LLVMIsConstantString, libllvm), LLVMBool, (LLVMValueRef,), c)
end

function LLVMGetAsString(c, Length)
    ccall((:LLVMGetAsString, libllvm), Cstring, (LLVMValueRef, Ptr{Csize_t}), c, Length)
end

function LLVMConstStructInContext(C, ConstantVals, Count, Packed)
    ccall((:LLVMConstStructInContext, libllvm), LLVMValueRef, (LLVMContextRef, Ptr{LLVMValueRef}, Cuint, LLVMBool), C, ConstantVals, Count, Packed)
end

function LLVMConstStruct(ConstantVals, Count, Packed)
    ccall((:LLVMConstStruct, libllvm), LLVMValueRef, (Ptr{LLVMValueRef}, Cuint, LLVMBool), ConstantVals, Count, Packed)
end

function LLVMConstArray(ElementTy, ConstantVals, Length)
    ccall((:LLVMConstArray, libllvm), LLVMValueRef, (LLVMTypeRef, Ptr{LLVMValueRef}, Cuint), ElementTy, ConstantVals, Length)
end

function LLVMConstNamedStruct(StructTy, ConstantVals, Count)
    ccall((:LLVMConstNamedStruct, libllvm), LLVMValueRef, (LLVMTypeRef, Ptr{LLVMValueRef}, Cuint), StructTy, ConstantVals, Count)
end

function LLVMGetElementAsConstant(C, idx)
    ccall((:LLVMGetElementAsConstant, libllvm), LLVMValueRef, (LLVMValueRef, Cuint), C, idx)
end

function LLVMConstVector(ScalarConstantVals, Size)
    ccall((:LLVMConstVector, libllvm), LLVMValueRef, (Ptr{LLVMValueRef}, Cuint), ScalarConstantVals, Size)
end

function LLVMGetConstOpcode(ConstantVal)
    ccall((:LLVMGetConstOpcode, libllvm), LLVMOpcode, (LLVMValueRef,), ConstantVal)
end

function LLVMAlignOf(Ty)
    ccall((:LLVMAlignOf, libllvm), LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMSizeOf(Ty)
    ccall((:LLVMSizeOf, libllvm), LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstNeg(ConstantVal)
    ccall((:LLVMConstNeg, libllvm), LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNSWNeg(ConstantVal)
    ccall((:LLVMConstNSWNeg, libllvm), LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNUWNeg(ConstantVal)
    ccall((:LLVMConstNUWNeg, libllvm), LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstFNeg(ConstantVal)
    ccall((:LLVMConstFNeg, libllvm), LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNot(ConstantVal)
    ccall((:LLVMConstNot, libllvm), LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstAdd(LHSConstant, RHSConstant)
    ccall((:LLVMConstAdd, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWAdd(LHSConstant, RHSConstant)
    ccall((:LLVMConstNSWAdd, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWAdd(LHSConstant, RHSConstant)
    ccall((:LLVMConstNUWAdd, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFAdd(LHSConstant, RHSConstant)
    ccall((:LLVMConstFAdd, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSub(LHSConstant, RHSConstant)
    ccall((:LLVMConstSub, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWSub(LHSConstant, RHSConstant)
    ccall((:LLVMConstNSWSub, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWSub(LHSConstant, RHSConstant)
    ccall((:LLVMConstNUWSub, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFSub(LHSConstant, RHSConstant)
    ccall((:LLVMConstFSub, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstMul(LHSConstant, RHSConstant)
    ccall((:LLVMConstMul, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWMul(LHSConstant, RHSConstant)
    ccall((:LLVMConstNSWMul, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWMul(LHSConstant, RHSConstant)
    ccall((:LLVMConstNUWMul, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFMul(LHSConstant, RHSConstant)
    ccall((:LLVMConstFMul, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstUDiv(LHSConstant, RHSConstant)
    ccall((:LLVMConstUDiv, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstExactUDiv(LHSConstant, RHSConstant)
    ccall((:LLVMConstExactUDiv, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSDiv(LHSConstant, RHSConstant)
    ccall((:LLVMConstSDiv, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstExactSDiv(LHSConstant, RHSConstant)
    ccall((:LLVMConstExactSDiv, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFDiv(LHSConstant, RHSConstant)
    ccall((:LLVMConstFDiv, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstURem(LHSConstant, RHSConstant)
    ccall((:LLVMConstURem, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSRem(LHSConstant, RHSConstant)
    ccall((:LLVMConstSRem, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFRem(LHSConstant, RHSConstant)
    ccall((:LLVMConstFRem, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstAnd(LHSConstant, RHSConstant)
    ccall((:LLVMConstAnd, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstOr(LHSConstant, RHSConstant)
    ccall((:LLVMConstOr, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstXor(LHSConstant, RHSConstant)
    ccall((:LLVMConstXor, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstICmp(Predicate, LHSConstant, RHSConstant)
    ccall((:LLVMConstICmp, libllvm), LLVMValueRef, (LLVMIntPredicate, LLVMValueRef, LLVMValueRef), Predicate, LHSConstant, RHSConstant)
end

function LLVMConstFCmp(Predicate, LHSConstant, RHSConstant)
    ccall((:LLVMConstFCmp, libllvm), LLVMValueRef, (LLVMRealPredicate, LLVMValueRef, LLVMValueRef), Predicate, LHSConstant, RHSConstant)
end

function LLVMConstShl(LHSConstant, RHSConstant)
    ccall((:LLVMConstShl, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstLShr(LHSConstant, RHSConstant)
    ccall((:LLVMConstLShr, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstAShr(LHSConstant, RHSConstant)
    ccall((:LLVMConstAShr, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstGEP(ConstantVal, ConstantIndices, NumIndices)
    ccall((:LLVMConstGEP, libllvm), LLVMValueRef, (LLVMValueRef, Ptr{LLVMValueRef}, Cuint), ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstGEP2(Ty, ConstantVal, ConstantIndices, NumIndices)
    ccall((:LLVMConstGEP2, libllvm), LLVMValueRef, (LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint), Ty, ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstInBoundsGEP(ConstantVal, ConstantIndices, NumIndices)
    ccall((:LLVMConstInBoundsGEP, libllvm), LLVMValueRef, (LLVMValueRef, Ptr{LLVMValueRef}, Cuint), ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstInBoundsGEP2(Ty, ConstantVal, ConstantIndices, NumIndices)
    ccall((:LLVMConstInBoundsGEP2, libllvm), LLVMValueRef, (LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint), Ty, ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstTrunc(ConstantVal, ToType)
    ccall((:LLVMConstTrunc, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSExt(ConstantVal, ToType)
    ccall((:LLVMConstSExt, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstZExt(ConstantVal, ToType)
    ccall((:LLVMConstZExt, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPTrunc(ConstantVal, ToType)
    ccall((:LLVMConstFPTrunc, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPExt(ConstantVal, ToType)
    ccall((:LLVMConstFPExt, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstUIToFP(ConstantVal, ToType)
    ccall((:LLVMConstUIToFP, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSIToFP(ConstantVal, ToType)
    ccall((:LLVMConstSIToFP, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPToUI(ConstantVal, ToType)
    ccall((:LLVMConstFPToUI, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPToSI(ConstantVal, ToType)
    ccall((:LLVMConstFPToSI, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstPtrToInt(ConstantVal, ToType)
    ccall((:LLVMConstPtrToInt, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstIntToPtr(ConstantVal, ToType)
    ccall((:LLVMConstIntToPtr, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstBitCast(ConstantVal, ToType)
    ccall((:LLVMConstBitCast, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstAddrSpaceCast(ConstantVal, ToType)
    ccall((:LLVMConstAddrSpaceCast, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstZExtOrBitCast(ConstantVal, ToType)
    ccall((:LLVMConstZExtOrBitCast, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSExtOrBitCast(ConstantVal, ToType)
    ccall((:LLVMConstSExtOrBitCast, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstTruncOrBitCast(ConstantVal, ToType)
    ccall((:LLVMConstTruncOrBitCast, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstPointerCast(ConstantVal, ToType)
    ccall((:LLVMConstPointerCast, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstIntCast(ConstantVal, ToType, isSigned)
    ccall((:LLVMConstIntCast, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef, LLVMBool), ConstantVal, ToType, isSigned)
end

function LLVMConstFPCast(ConstantVal, ToType)
    ccall((:LLVMConstFPCast, libllvm), LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSelect(ConstantCondition, ConstantIfTrue, ConstantIfFalse)
    ccall((:LLVMConstSelect, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), ConstantCondition, ConstantIfTrue, ConstantIfFalse)
end

function LLVMConstExtractElement(VectorConstant, IndexConstant)
    ccall((:LLVMConstExtractElement, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef), VectorConstant, IndexConstant)
end

function LLVMConstInsertElement(VectorConstant, ElementValueConstant, IndexConstant)
    ccall((:LLVMConstInsertElement, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), VectorConstant, ElementValueConstant, IndexConstant)
end

function LLVMConstShuffleVector(VectorAConstant, VectorBConstant, MaskConstant)
    ccall((:LLVMConstShuffleVector, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), VectorAConstant, VectorBConstant, MaskConstant)
end

function LLVMConstExtractValue(AggConstant, IdxList, NumIdx)
    ccall((:LLVMConstExtractValue, libllvm), LLVMValueRef, (LLVMValueRef, Ptr{Cuint}, Cuint), AggConstant, IdxList, NumIdx)
end

function LLVMConstInsertValue(AggConstant, ElementValueConstant, IdxList, NumIdx)
    ccall((:LLVMConstInsertValue, libllvm), LLVMValueRef, (LLVMValueRef, LLVMValueRef, Ptr{Cuint}, Cuint), AggConstant, ElementValueConstant, IdxList, NumIdx)
end

const LLVMBasicBlockRef = Ptr{LLVMOpaqueBasicBlock}

function LLVMBlockAddress(F, BB)
    ccall((:LLVMBlockAddress, libllvm), LLVMValueRef, (LLVMValueRef, LLVMBasicBlockRef), F, BB)
end

function LLVMConstInlineAsm(Ty, AsmString, Constraints, HasSideEffects, IsAlignStack)
    ccall((:LLVMConstInlineAsm, libllvm), LLVMValueRef, (LLVMTypeRef, Cstring, Cstring, LLVMBool, LLVMBool), Ty, AsmString, Constraints, HasSideEffects, IsAlignStack)
end

function LLVMGetGlobalParent(Global)
    ccall((:LLVMGetGlobalParent, libllvm), LLVMModuleRef, (LLVMValueRef,), Global)
end

function LLVMIsDeclaration(Global)
    ccall((:LLVMIsDeclaration, libllvm), LLVMBool, (LLVMValueRef,), Global)
end

function LLVMGetLinkage(Global)
    ccall((:LLVMGetLinkage, libllvm), LLVMLinkage, (LLVMValueRef,), Global)
end

function LLVMSetLinkage(Global, Linkage)
    ccall((:LLVMSetLinkage, libllvm), Cvoid, (LLVMValueRef, LLVMLinkage), Global, Linkage)
end

function LLVMGetSection(Global)
    ccall((:LLVMGetSection, libllvm), Cstring, (LLVMValueRef,), Global)
end

function LLVMSetSection(Global, Section)
    ccall((:LLVMSetSection, libllvm), Cvoid, (LLVMValueRef, Cstring), Global, Section)
end

function LLVMGetVisibility(Global)
    ccall((:LLVMGetVisibility, libllvm), LLVMVisibility, (LLVMValueRef,), Global)
end

function LLVMSetVisibility(Global, Viz)
    ccall((:LLVMSetVisibility, libllvm), Cvoid, (LLVMValueRef, LLVMVisibility), Global, Viz)
end

function LLVMGetDLLStorageClass(Global)
    ccall((:LLVMGetDLLStorageClass, libllvm), LLVMDLLStorageClass, (LLVMValueRef,), Global)
end

function LLVMSetDLLStorageClass(Global, Class)
    ccall((:LLVMSetDLLStorageClass, libllvm), Cvoid, (LLVMValueRef, LLVMDLLStorageClass), Global, Class)
end

function LLVMGetUnnamedAddress(Global)
    ccall((:LLVMGetUnnamedAddress, libllvm), LLVMUnnamedAddr, (LLVMValueRef,), Global)
end

function LLVMSetUnnamedAddress(Global, UnnamedAddr)
    ccall((:LLVMSetUnnamedAddress, libllvm), Cvoid, (LLVMValueRef, LLVMUnnamedAddr), Global, UnnamedAddr)
end

function LLVMGlobalGetValueType(Global)
    ccall((:LLVMGlobalGetValueType, libllvm), LLVMTypeRef, (LLVMValueRef,), Global)
end

function LLVMHasUnnamedAddr(Global)
    ccall((:LLVMHasUnnamedAddr, libllvm), LLVMBool, (LLVMValueRef,), Global)
end

function LLVMSetUnnamedAddr(Global, HasUnnamedAddr)
    ccall((:LLVMSetUnnamedAddr, libllvm), Cvoid, (LLVMValueRef, LLVMBool), Global, HasUnnamedAddr)
end

function LLVMGetAlignment(V)
    ccall((:LLVMGetAlignment, libllvm), Cuint, (LLVMValueRef,), V)
end

function LLVMSetAlignment(V, Bytes)
    ccall((:LLVMSetAlignment, libllvm), Cvoid, (LLVMValueRef, Cuint), V, Bytes)
end

function LLVMGlobalSetMetadata(Global, Kind, MD)
    ccall((:LLVMGlobalSetMetadata, libllvm), Cvoid, (LLVMValueRef, Cuint, LLVMMetadataRef), Global, Kind, MD)
end

function LLVMGlobalEraseMetadata(Global, Kind)
    ccall((:LLVMGlobalEraseMetadata, libllvm), Cvoid, (LLVMValueRef, Cuint), Global, Kind)
end

function LLVMGlobalClearMetadata(Global)
    ccall((:LLVMGlobalClearMetadata, libllvm), Cvoid, (LLVMValueRef,), Global)
end

const LLVMValueMetadataEntry = LLVMOpaqueValueMetadataEntry

function LLVMGlobalCopyAllMetadata(Value, NumEntries)
    ccall((:LLVMGlobalCopyAllMetadata, libllvm), Ptr{LLVMValueMetadataEntry}, (LLVMValueRef, Ptr{Csize_t}), Value, NumEntries)
end

function LLVMDisposeValueMetadataEntries(Entries)
    ccall((:LLVMDisposeValueMetadataEntries, libllvm), Cvoid, (Ptr{LLVMValueMetadataEntry},), Entries)
end

function LLVMValueMetadataEntriesGetKind(Entries, Index)
    ccall((:LLVMValueMetadataEntriesGetKind, libllvm), Cuint, (Ptr{LLVMValueMetadataEntry}, Cuint), Entries, Index)
end

function LLVMValueMetadataEntriesGetMetadata(Entries, Index)
    ccall((:LLVMValueMetadataEntriesGetMetadata, libllvm), LLVMMetadataRef, (Ptr{LLVMValueMetadataEntry}, Cuint), Entries, Index)
end

function LLVMAddGlobal(M, Ty, Name)
    ccall((:LLVMAddGlobal, libllvm), LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, Cstring), M, Ty, Name)
end

function LLVMAddGlobalInAddressSpace(M, Ty, Name, AddressSpace)
    ccall((:LLVMAddGlobalInAddressSpace, libllvm), LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, Cstring, Cuint), M, Ty, Name, AddressSpace)
end

function LLVMGetNamedGlobal(M, Name)
    ccall((:LLVMGetNamedGlobal, libllvm), LLVMValueRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetFirstGlobal(M)
    ccall((:LLVMGetFirstGlobal, libllvm), LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastGlobal(M)
    ccall((:LLVMGetLastGlobal, libllvm), LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextGlobal(GlobalVar)
    ccall((:LLVMGetNextGlobal, libllvm), LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMGetPreviousGlobal(GlobalVar)
    ccall((:LLVMGetPreviousGlobal, libllvm), LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMDeleteGlobal(GlobalVar)
    ccall((:LLVMDeleteGlobal, libllvm), Cvoid, (LLVMValueRef,), GlobalVar)
end

function LLVMGetInitializer(GlobalVar)
    ccall((:LLVMGetInitializer, libllvm), LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMSetInitializer(GlobalVar, ConstantVal)
    ccall((:LLVMSetInitializer, libllvm), Cvoid, (LLVMValueRef, LLVMValueRef), GlobalVar, ConstantVal)
end

function LLVMIsThreadLocal(GlobalVar)
    ccall((:LLVMIsThreadLocal, libllvm), LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetThreadLocal(GlobalVar, IsThreadLocal)
    ccall((:LLVMSetThreadLocal, libllvm), Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsThreadLocal)
end

function LLVMIsGlobalConstant(GlobalVar)
    ccall((:LLVMIsGlobalConstant, libllvm), LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetGlobalConstant(GlobalVar, IsConstant)
    ccall((:LLVMSetGlobalConstant, libllvm), Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsConstant)
end

function LLVMGetThreadLocalMode(GlobalVar)
    ccall((:LLVMGetThreadLocalMode, libllvm), LLVMThreadLocalMode, (LLVMValueRef,), GlobalVar)
end

function LLVMSetThreadLocalMode(GlobalVar, Mode)
    ccall((:LLVMSetThreadLocalMode, libllvm), Cvoid, (LLVMValueRef, LLVMThreadLocalMode), GlobalVar, Mode)
end

function LLVMIsExternallyInitialized(GlobalVar)
    ccall((:LLVMIsExternallyInitialized, libllvm), LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetExternallyInitialized(GlobalVar, IsExtInit)
    ccall((:LLVMSetExternallyInitialized, libllvm), Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsExtInit)
end

function LLVMAddAlias(M, Ty, Aliasee, Name)
    ccall((:LLVMAddAlias, libllvm), LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, LLVMValueRef, Cstring), M, Ty, Aliasee, Name)
end

function LLVMAddAlias2(M, ValueTy, AddrSpace, Aliasee, Name)
    ccall((:LLVMAddAlias2, libllvm), LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, Cuint, LLVMValueRef, Cstring), M, ValueTy, AddrSpace, Aliasee, Name)
end

function LLVMGetNamedGlobalAlias(M, Name, NameLen)
    ccall((:LLVMGetNamedGlobalAlias, libllvm), LLVMValueRef, (LLVMModuleRef, Cstring, Csize_t), M, Name, NameLen)
end

function LLVMGetFirstGlobalAlias(M)
    ccall((:LLVMGetFirstGlobalAlias, libllvm), LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastGlobalAlias(M)
    ccall((:LLVMGetLastGlobalAlias, libllvm), LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextGlobalAlias(GA)
    ccall((:LLVMGetNextGlobalAlias, libllvm), LLVMValueRef, (LLVMValueRef,), GA)
end

function LLVMGetPreviousGlobalAlias(GA)
    ccall((:LLVMGetPreviousGlobalAlias, libllvm), LLVMValueRef, (LLVMValueRef,), GA)
end

function LLVMAliasGetAliasee(Alias)
    ccall((:LLVMAliasGetAliasee, libllvm), LLVMValueRef, (LLVMValueRef,), Alias)
end

function LLVMAliasSetAliasee(Alias, Aliasee)
    ccall((:LLVMAliasSetAliasee, libllvm), Cvoid, (LLVMValueRef, LLVMValueRef), Alias, Aliasee)
end

function LLVMDeleteFunction(Fn)
    ccall((:LLVMDeleteFunction, libllvm), Cvoid, (LLVMValueRef,), Fn)
end

function LLVMHasPersonalityFn(Fn)
    ccall((:LLVMHasPersonalityFn, libllvm), LLVMBool, (LLVMValueRef,), Fn)
end

function LLVMGetPersonalityFn(Fn)
    ccall((:LLVMGetPersonalityFn, libllvm), LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMSetPersonalityFn(Fn, PersonalityFn)
    ccall((:LLVMSetPersonalityFn, libllvm), Cvoid, (LLVMValueRef, LLVMValueRef), Fn, PersonalityFn)
end

function LLVMLookupIntrinsicID(Name, NameLen)
    ccall((:LLVMLookupIntrinsicID, libllvm), Cuint, (Cstring, Csize_t), Name, NameLen)
end

function LLVMGetIntrinsicID(Fn)
    ccall((:LLVMGetIntrinsicID, libllvm), Cuint, (LLVMValueRef,), Fn)
end

function LLVMGetIntrinsicDeclaration(Mod, ID, ParamTypes, ParamCount)
    ccall((:LLVMGetIntrinsicDeclaration, libllvm), LLVMValueRef, (LLVMModuleRef, Cuint, Ptr{LLVMTypeRef}, Csize_t), Mod, ID, ParamTypes, ParamCount)
end

function LLVMIntrinsicGetType(Ctx, ID, ParamTypes, ParamCount)
    ccall((:LLVMIntrinsicGetType, libllvm), LLVMTypeRef, (LLVMContextRef, Cuint, Ptr{LLVMTypeRef}, Csize_t), Ctx, ID, ParamTypes, ParamCount)
end

function LLVMIntrinsicGetName(ID, NameLength)
    ccall((:LLVMIntrinsicGetName, libllvm), Cstring, (Cuint, Ptr{Csize_t}), ID, NameLength)
end

function LLVMIntrinsicCopyOverloadedName(ID, ParamTypes, ParamCount, NameLength)
    ccall((:LLVMIntrinsicCopyOverloadedName, libllvm), Cstring, (Cuint, Ptr{LLVMTypeRef}, Csize_t, Ptr{Csize_t}), ID, ParamTypes, ParamCount, NameLength)
end

function LLVMIntrinsicCopyOverloadedName2(Mod, ID, ParamTypes, ParamCount, NameLength)
    ccall((:LLVMIntrinsicCopyOverloadedName2, libllvm), Cstring, (LLVMModuleRef, Cuint, Ptr{LLVMTypeRef}, Csize_t, Ptr{Csize_t}), Mod, ID, ParamTypes, ParamCount, NameLength)
end

function LLVMIntrinsicIsOverloaded(ID)
    ccall((:LLVMIntrinsicIsOverloaded, libllvm), LLVMBool, (Cuint,), ID)
end

function LLVMGetFunctionCallConv(Fn)
    ccall((:LLVMGetFunctionCallConv, libllvm), Cuint, (LLVMValueRef,), Fn)
end

function LLVMSetFunctionCallConv(Fn, CC)
    ccall((:LLVMSetFunctionCallConv, libllvm), Cvoid, (LLVMValueRef, Cuint), Fn, CC)
end

function LLVMGetGC(Fn)
    ccall((:LLVMGetGC, libllvm), Cstring, (LLVMValueRef,), Fn)
end

function LLVMSetGC(Fn, Name)
    ccall((:LLVMSetGC, libllvm), Cvoid, (LLVMValueRef, Cstring), Fn, Name)
end

function LLVMAddAttributeAtIndex(F, Idx, A)
    ccall((:LLVMAddAttributeAtIndex, libllvm), Cvoid, (LLVMValueRef, LLVMAttributeIndex, LLVMAttributeRef), F, Idx, A)
end

function LLVMGetAttributeCountAtIndex(F, Idx)
    ccall((:LLVMGetAttributeCountAtIndex, libllvm), Cuint, (LLVMValueRef, LLVMAttributeIndex), F, Idx)
end

function LLVMGetAttributesAtIndex(F, Idx, Attrs)
    ccall((:LLVMGetAttributesAtIndex, libllvm), Cvoid, (LLVMValueRef, LLVMAttributeIndex, Ptr{LLVMAttributeRef}), F, Idx, Attrs)
end

function LLVMGetEnumAttributeAtIndex(F, Idx, KindID)
    ccall((:LLVMGetEnumAttributeAtIndex, libllvm), LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, Cuint), F, Idx, KindID)
end

function LLVMGetStringAttributeAtIndex(F, Idx, K, KLen)
    ccall((:LLVMGetStringAttributeAtIndex, libllvm), LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, Cstring, Cuint), F, Idx, K, KLen)
end

function LLVMRemoveEnumAttributeAtIndex(F, Idx, KindID)
    ccall((:LLVMRemoveEnumAttributeAtIndex, libllvm), Cvoid, (LLVMValueRef, LLVMAttributeIndex, Cuint), F, Idx, KindID)
end

function LLVMRemoveStringAttributeAtIndex(F, Idx, K, KLen)
    ccall((:LLVMRemoveStringAttributeAtIndex, libllvm), Cvoid, (LLVMValueRef, LLVMAttributeIndex, Cstring, Cuint), F, Idx, K, KLen)
end

function LLVMAddTargetDependentFunctionAttr(Fn, A, V)
    ccall((:LLVMAddTargetDependentFunctionAttr, libllvm), Cvoid, (LLVMValueRef, Cstring, Cstring), Fn, A, V)
end

function LLVMCountParams(Fn)
    ccall((:LLVMCountParams, libllvm), Cuint, (LLVMValueRef,), Fn)
end

function LLVMGetParams(Fn, Params)
    ccall((:LLVMGetParams, libllvm), Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}), Fn, Params)
end

function LLVMGetParam(Fn, Index)
    ccall((:LLVMGetParam, libllvm), LLVMValueRef, (LLVMValueRef, Cuint), Fn, Index)
end

function LLVMGetParamParent(Inst)
    ccall((:LLVMGetParamParent, libllvm), LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetFirstParam(Fn)
    ccall((:LLVMGetFirstParam, libllvm), LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetLastParam(Fn)
    ccall((:LLVMGetLastParam, libllvm), LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetNextParam(Arg)
    ccall((:LLVMGetNextParam, libllvm), LLVMValueRef, (LLVMValueRef,), Arg)
end

function LLVMGetPreviousParam(Arg)
    ccall((:LLVMGetPreviousParam, libllvm), LLVMValueRef, (LLVMValueRef,), Arg)
end

function LLVMSetParamAlignment(Arg, Align)
    ccall((:LLVMSetParamAlignment, libllvm), Cvoid, (LLVMValueRef, Cuint), Arg, Align)
end

function LLVMAddGlobalIFunc(M, Name, NameLen, Ty, AddrSpace, Resolver)
    ccall((:LLVMAddGlobalIFunc, libllvm), LLVMValueRef, (LLVMModuleRef, Cstring, Csize_t, LLVMTypeRef, Cuint, LLVMValueRef), M, Name, NameLen, Ty, AddrSpace, Resolver)
end

function LLVMGetNamedGlobalIFunc(M, Name, NameLen)
    ccall((:LLVMGetNamedGlobalIFunc, libllvm), LLVMValueRef, (LLVMModuleRef, Cstring, Csize_t), M, Name, NameLen)
end

function LLVMGetFirstGlobalIFunc(M)
    ccall((:LLVMGetFirstGlobalIFunc, libllvm), LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastGlobalIFunc(M)
    ccall((:LLVMGetLastGlobalIFunc, libllvm), LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextGlobalIFunc(IFunc)
    ccall((:LLVMGetNextGlobalIFunc, libllvm), LLVMValueRef, (LLVMValueRef,), IFunc)
end

function LLVMGetPreviousGlobalIFunc(IFunc)
    ccall((:LLVMGetPreviousGlobalIFunc, libllvm), LLVMValueRef, (LLVMValueRef,), IFunc)
end

function LLVMGetGlobalIFuncResolver(IFunc)
    ccall((:LLVMGetGlobalIFuncResolver, libllvm), LLVMValueRef, (LLVMValueRef,), IFunc)
end

function LLVMSetGlobalIFuncResolver(IFunc, Resolver)
    ccall((:LLVMSetGlobalIFuncResolver, libllvm), Cvoid, (LLVMValueRef, LLVMValueRef), IFunc, Resolver)
end

function LLVMEraseGlobalIFunc(IFunc)
    ccall((:LLVMEraseGlobalIFunc, libllvm), Cvoid, (LLVMValueRef,), IFunc)
end

function LLVMRemoveGlobalIFunc(IFunc)
    ccall((:LLVMRemoveGlobalIFunc, libllvm), Cvoid, (LLVMValueRef,), IFunc)
end

function LLVMMDStringInContext2(C, Str, SLen)
    ccall((:LLVMMDStringInContext2, libllvm), LLVMMetadataRef, (LLVMContextRef, Cstring, Csize_t), C, Str, SLen)
end

function LLVMMDNodeInContext2(C, MDs, Count)
    ccall((:LLVMMDNodeInContext2, libllvm), LLVMMetadataRef, (LLVMContextRef, Ptr{LLVMMetadataRef}, Csize_t), C, MDs, Count)
end

function LLVMMetadataAsValue(C, MD)
    ccall((:LLVMMetadataAsValue, libllvm), LLVMValueRef, (LLVMContextRef, LLVMMetadataRef), C, MD)
end

function LLVMValueAsMetadata(Val)
    ccall((:LLVMValueAsMetadata, libllvm), LLVMMetadataRef, (LLVMValueRef,), Val)
end

function LLVMGetMDString(V, Length)
    ccall((:LLVMGetMDString, libllvm), Cstring, (LLVMValueRef, Ptr{Cuint}), V, Length)
end

function LLVMGetMDNodeNumOperands(V)
    ccall((:LLVMGetMDNodeNumOperands, libllvm), Cuint, (LLVMValueRef,), V)
end

function LLVMGetMDNodeOperands(V, Dest)
    ccall((:LLVMGetMDNodeOperands, libllvm), Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}), V, Dest)
end

function LLVMMDStringInContext(C, Str, SLen)
    ccall((:LLVMMDStringInContext, libllvm), LLVMValueRef, (LLVMContextRef, Cstring, Cuint), C, Str, SLen)
end

function LLVMMDString(Str, SLen)
    ccall((:LLVMMDString, libllvm), LLVMValueRef, (Cstring, Cuint), Str, SLen)
end

function LLVMMDNodeInContext(C, Vals, Count)
    ccall((:LLVMMDNodeInContext, libllvm), LLVMValueRef, (LLVMContextRef, Ptr{LLVMValueRef}, Cuint), C, Vals, Count)
end

function LLVMMDNode(Vals, Count)
    ccall((:LLVMMDNode, libllvm), LLVMValueRef, (Ptr{LLVMValueRef}, Cuint), Vals, Count)
end

function LLVMBasicBlockAsValue(BB)
    ccall((:LLVMBasicBlockAsValue, libllvm), LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMValueIsBasicBlock(Val)
    ccall((:LLVMValueIsBasicBlock, libllvm), LLVMBool, (LLVMValueRef,), Val)
end

function LLVMValueAsBasicBlock(Val)
    ccall((:LLVMValueAsBasicBlock, libllvm), LLVMBasicBlockRef, (LLVMValueRef,), Val)
end

function LLVMGetBasicBlockName(BB)
    ccall((:LLVMGetBasicBlockName, libllvm), Cstring, (LLVMBasicBlockRef,), BB)
end

function LLVMGetBasicBlockParent(BB)
    ccall((:LLVMGetBasicBlockParent, libllvm), LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetBasicBlockTerminator(BB)
    ccall((:LLVMGetBasicBlockTerminator, libllvm), LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMCountBasicBlocks(Fn)
    ccall((:LLVMCountBasicBlocks, libllvm), Cuint, (LLVMValueRef,), Fn)
end

function LLVMGetBasicBlocks(Fn, BasicBlocks)
    ccall((:LLVMGetBasicBlocks, libllvm), Cvoid, (LLVMValueRef, Ptr{LLVMBasicBlockRef}), Fn, BasicBlocks)
end

function LLVMGetFirstBasicBlock(Fn)
    ccall((:LLVMGetFirstBasicBlock, libllvm), LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

function LLVMGetLastBasicBlock(Fn)
    ccall((:LLVMGetLastBasicBlock, libllvm), LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

function LLVMGetNextBasicBlock(BB)
    ccall((:LLVMGetNextBasicBlock, libllvm), LLVMBasicBlockRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetPreviousBasicBlock(BB)
    ccall((:LLVMGetPreviousBasicBlock, libllvm), LLVMBasicBlockRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetEntryBasicBlock(Fn)
    ccall((:LLVMGetEntryBasicBlock, libllvm), LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

const LLVMBuilderRef = Ptr{LLVMOpaqueBuilder}

function LLVMInsertExistingBasicBlockAfterInsertBlock(Builder, BB)
    ccall((:LLVMInsertExistingBasicBlockAfterInsertBlock, libllvm), Cvoid, (LLVMBuilderRef, LLVMBasicBlockRef), Builder, BB)
end

function LLVMAppendExistingBasicBlock(Fn, BB)
    ccall((:LLVMAppendExistingBasicBlock, libllvm), Cvoid, (LLVMValueRef, LLVMBasicBlockRef), Fn, BB)
end

function LLVMCreateBasicBlockInContext(C, Name)
    ccall((:LLVMCreateBasicBlockInContext, libllvm), LLVMBasicBlockRef, (LLVMContextRef, Cstring), C, Name)
end

function LLVMAppendBasicBlockInContext(C, Fn, Name)
    ccall((:LLVMAppendBasicBlockInContext, libllvm), LLVMBasicBlockRef, (LLVMContextRef, LLVMValueRef, Cstring), C, Fn, Name)
end

function LLVMAppendBasicBlock(Fn, Name)
    ccall((:LLVMAppendBasicBlock, libllvm), LLVMBasicBlockRef, (LLVMValueRef, Cstring), Fn, Name)
end

function LLVMInsertBasicBlockInContext(C, BB, Name)
    ccall((:LLVMInsertBasicBlockInContext, libllvm), LLVMBasicBlockRef, (LLVMContextRef, LLVMBasicBlockRef, Cstring), C, BB, Name)
end

function LLVMInsertBasicBlock(InsertBeforeBB, Name)
    ccall((:LLVMInsertBasicBlock, libllvm), LLVMBasicBlockRef, (LLVMBasicBlockRef, Cstring), InsertBeforeBB, Name)
end

function LLVMDeleteBasicBlock(BB)
    ccall((:LLVMDeleteBasicBlock, libllvm), Cvoid, (LLVMBasicBlockRef,), BB)
end

function LLVMRemoveBasicBlockFromParent(BB)
    ccall((:LLVMRemoveBasicBlockFromParent, libllvm), Cvoid, (LLVMBasicBlockRef,), BB)
end

function LLVMMoveBasicBlockBefore(BB, MovePos)
    ccall((:LLVMMoveBasicBlockBefore, libllvm), Cvoid, (LLVMBasicBlockRef, LLVMBasicBlockRef), BB, MovePos)
end

function LLVMMoveBasicBlockAfter(BB, MovePos)
    ccall((:LLVMMoveBasicBlockAfter, libllvm), Cvoid, (LLVMBasicBlockRef, LLVMBasicBlockRef), BB, MovePos)
end

function LLVMGetFirstInstruction(BB)
    ccall((:LLVMGetFirstInstruction, libllvm), LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetLastInstruction(BB)
    ccall((:LLVMGetLastInstruction, libllvm), LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMHasMetadata(Val)
    ccall((:LLVMHasMetadata, libllvm), Cint, (LLVMValueRef,), Val)
end

function LLVMGetMetadata(Val, KindID)
    ccall((:LLVMGetMetadata, libllvm), LLVMValueRef, (LLVMValueRef, Cuint), Val, KindID)
end

function LLVMSetMetadata(Val, KindID, Node)
    ccall((:LLVMSetMetadata, libllvm), Cvoid, (LLVMValueRef, Cuint, LLVMValueRef), Val, KindID, Node)
end

function LLVMInstructionGetAllMetadataOtherThanDebugLoc(Instr, NumEntries)
    ccall((:LLVMInstructionGetAllMetadataOtherThanDebugLoc, libllvm), Ptr{LLVMValueMetadataEntry}, (LLVMValueRef, Ptr{Csize_t}), Instr, NumEntries)
end

function LLVMGetInstructionParent(Inst)
    ccall((:LLVMGetInstructionParent, libllvm), LLVMBasicBlockRef, (LLVMValueRef,), Inst)
end

function LLVMGetNextInstruction(Inst)
    ccall((:LLVMGetNextInstruction, libllvm), LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetPreviousInstruction(Inst)
    ccall((:LLVMGetPreviousInstruction, libllvm), LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMInstructionRemoveFromParent(Inst)
    ccall((:LLVMInstructionRemoveFromParent, libllvm), Cvoid, (LLVMValueRef,), Inst)
end

function LLVMInstructionEraseFromParent(Inst)
    ccall((:LLVMInstructionEraseFromParent, libllvm), Cvoid, (LLVMValueRef,), Inst)
end

function LLVMGetInstructionOpcode(Inst)
    ccall((:LLVMGetInstructionOpcode, libllvm), LLVMOpcode, (LLVMValueRef,), Inst)
end

function LLVMGetICmpPredicate(Inst)
    ccall((:LLVMGetICmpPredicate, libllvm), LLVMIntPredicate, (LLVMValueRef,), Inst)
end

function LLVMGetFCmpPredicate(Inst)
    ccall((:LLVMGetFCmpPredicate, libllvm), LLVMRealPredicate, (LLVMValueRef,), Inst)
end

function LLVMInstructionClone(Inst)
    ccall((:LLVMInstructionClone, libllvm), LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMIsATerminatorInst(Inst)
    ccall((:LLVMIsATerminatorInst, libllvm), LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetNumArgOperands(Instr)
    ccall((:LLVMGetNumArgOperands, libllvm), Cuint, (LLVMValueRef,), Instr)
end

function LLVMSetInstructionCallConv(Instr, CC)
    ccall((:LLVMSetInstructionCallConv, libllvm), Cvoid, (LLVMValueRef, Cuint), Instr, CC)
end

function LLVMGetInstructionCallConv(Instr)
    ccall((:LLVMGetInstructionCallConv, libllvm), Cuint, (LLVMValueRef,), Instr)
end

function LLVMSetInstrParamAlignment(Instr, Idx, Align)
    ccall((:LLVMSetInstrParamAlignment, libllvm), Cvoid, (LLVMValueRef, LLVMAttributeIndex, Cuint), Instr, Idx, Align)
end

function LLVMAddCallSiteAttribute(C, Idx, A)
    ccall((:LLVMAddCallSiteAttribute, libllvm), Cvoid, (LLVMValueRef, LLVMAttributeIndex, LLVMAttributeRef), C, Idx, A)
end

function LLVMGetCallSiteAttributeCount(C, Idx)
    ccall((:LLVMGetCallSiteAttributeCount, libllvm), Cuint, (LLVMValueRef, LLVMAttributeIndex), C, Idx)
end

function LLVMGetCallSiteAttributes(C, Idx, Attrs)
    ccall((:LLVMGetCallSiteAttributes, libllvm), Cvoid, (LLVMValueRef, LLVMAttributeIndex, Ptr{LLVMAttributeRef}), C, Idx, Attrs)
end

function LLVMGetCallSiteEnumAttribute(C, Idx, KindID)
    ccall((:LLVMGetCallSiteEnumAttribute, libllvm), LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, Cuint), C, Idx, KindID)
end

function LLVMGetCallSiteStringAttribute(C, Idx, K, KLen)
    ccall((:LLVMGetCallSiteStringAttribute, libllvm), LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, Cstring, Cuint), C, Idx, K, KLen)
end

function LLVMRemoveCallSiteEnumAttribute(C, Idx, KindID)
    ccall((:LLVMRemoveCallSiteEnumAttribute, libllvm), Cvoid, (LLVMValueRef, LLVMAttributeIndex, Cuint), C, Idx, KindID)
end

function LLVMRemoveCallSiteStringAttribute(C, Idx, K, KLen)
    ccall((:LLVMRemoveCallSiteStringAttribute, libllvm), Cvoid, (LLVMValueRef, LLVMAttributeIndex, Cstring, Cuint), C, Idx, K, KLen)
end

function LLVMGetCalledFunctionType(C)
    ccall((:LLVMGetCalledFunctionType, libllvm), LLVMTypeRef, (LLVMValueRef,), C)
end

function LLVMGetCalledValue(Instr)
    ccall((:LLVMGetCalledValue, libllvm), LLVMValueRef, (LLVMValueRef,), Instr)
end

function LLVMIsTailCall(CallInst)
    ccall((:LLVMIsTailCall, libllvm), LLVMBool, (LLVMValueRef,), CallInst)
end

function LLVMSetTailCall(CallInst, IsTailCall)
    ccall((:LLVMSetTailCall, libllvm), Cvoid, (LLVMValueRef, LLVMBool), CallInst, IsTailCall)
end

function LLVMGetNormalDest(InvokeInst)
    ccall((:LLVMGetNormalDest, libllvm), LLVMBasicBlockRef, (LLVMValueRef,), InvokeInst)
end

function LLVMGetUnwindDest(InvokeInst)
    ccall((:LLVMGetUnwindDest, libllvm), LLVMBasicBlockRef, (LLVMValueRef,), InvokeInst)
end

function LLVMSetNormalDest(InvokeInst, B)
    ccall((:LLVMSetNormalDest, libllvm), Cvoid, (LLVMValueRef, LLVMBasicBlockRef), InvokeInst, B)
end

function LLVMSetUnwindDest(InvokeInst, B)
    ccall((:LLVMSetUnwindDest, libllvm), Cvoid, (LLVMValueRef, LLVMBasicBlockRef), InvokeInst, B)
end

function LLVMGetNumSuccessors(Term)
    ccall((:LLVMGetNumSuccessors, libllvm), Cuint, (LLVMValueRef,), Term)
end

function LLVMGetSuccessor(Term, i)
    ccall((:LLVMGetSuccessor, libllvm), LLVMBasicBlockRef, (LLVMValueRef, Cuint), Term, i)
end

function LLVMSetSuccessor(Term, i, block)
    ccall((:LLVMSetSuccessor, libllvm), Cvoid, (LLVMValueRef, Cuint, LLVMBasicBlockRef), Term, i, block)
end

function LLVMIsConditional(Branch)
    ccall((:LLVMIsConditional, libllvm), LLVMBool, (LLVMValueRef,), Branch)
end

function LLVMGetCondition(Branch)
    ccall((:LLVMGetCondition, libllvm), LLVMValueRef, (LLVMValueRef,), Branch)
end

function LLVMSetCondition(Branch, Cond)
    ccall((:LLVMSetCondition, libllvm), Cvoid, (LLVMValueRef, LLVMValueRef), Branch, Cond)
end

function LLVMGetSwitchDefaultDest(SwitchInstr)
    ccall((:LLVMGetSwitchDefaultDest, libllvm), LLVMBasicBlockRef, (LLVMValueRef,), SwitchInstr)
end

function LLVMGetAllocatedType(Alloca)
    ccall((:LLVMGetAllocatedType, libllvm), LLVMTypeRef, (LLVMValueRef,), Alloca)
end

function LLVMIsInBounds(GEP)
    ccall((:LLVMIsInBounds, libllvm), LLVMBool, (LLVMValueRef,), GEP)
end

function LLVMSetIsInBounds(GEP, InBounds)
    ccall((:LLVMSetIsInBounds, libllvm), Cvoid, (LLVMValueRef, LLVMBool), GEP, InBounds)
end

function LLVMGetGEPSourceElementType(GEP)
    ccall((:LLVMGetGEPSourceElementType, libllvm), LLVMTypeRef, (LLVMValueRef,), GEP)
end

function LLVMAddIncoming(PhiNode, IncomingValues, IncomingBlocks, Count)
    ccall((:LLVMAddIncoming, libllvm), Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}, Ptr{LLVMBasicBlockRef}, Cuint), PhiNode, IncomingValues, IncomingBlocks, Count)
end

function LLVMCountIncoming(PhiNode)
    ccall((:LLVMCountIncoming, libllvm), Cuint, (LLVMValueRef,), PhiNode)
end

function LLVMGetIncomingValue(PhiNode, Index)
    ccall((:LLVMGetIncomingValue, libllvm), LLVMValueRef, (LLVMValueRef, Cuint), PhiNode, Index)
end

function LLVMGetIncomingBlock(PhiNode, Index)
    ccall((:LLVMGetIncomingBlock, libllvm), LLVMBasicBlockRef, (LLVMValueRef, Cuint), PhiNode, Index)
end

function LLVMGetNumIndices(Inst)
    ccall((:LLVMGetNumIndices, libllvm), Cuint, (LLVMValueRef,), Inst)
end

function LLVMGetIndices(Inst)
    ccall((:LLVMGetIndices, libllvm), Ptr{Cuint}, (LLVMValueRef,), Inst)
end

function LLVMCreateBuilderInContext(C)
    ccall((:LLVMCreateBuilderInContext, libllvm), LLVMBuilderRef, (LLVMContextRef,), C)
end

function LLVMCreateBuilder()
    ccall((:LLVMCreateBuilder, libllvm), LLVMBuilderRef, ())
end

function LLVMPositionBuilder(Builder, Block, Instr)
    ccall((:LLVMPositionBuilder, libllvm), Cvoid, (LLVMBuilderRef, LLVMBasicBlockRef, LLVMValueRef), Builder, Block, Instr)
end

function LLVMPositionBuilderBefore(Builder, Instr)
    ccall((:LLVMPositionBuilderBefore, libllvm), Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Instr)
end

function LLVMPositionBuilderAtEnd(Builder, Block)
    ccall((:LLVMPositionBuilderAtEnd, libllvm), Cvoid, (LLVMBuilderRef, LLVMBasicBlockRef), Builder, Block)
end

function LLVMGetInsertBlock(Builder)
    ccall((:LLVMGetInsertBlock, libllvm), LLVMBasicBlockRef, (LLVMBuilderRef,), Builder)
end

function LLVMClearInsertionPosition(Builder)
    ccall((:LLVMClearInsertionPosition, libllvm), Cvoid, (LLVMBuilderRef,), Builder)
end

function LLVMInsertIntoBuilder(Builder, Instr)
    ccall((:LLVMInsertIntoBuilder, libllvm), Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Instr)
end

function LLVMInsertIntoBuilderWithName(Builder, Instr, Name)
    ccall((:LLVMInsertIntoBuilderWithName, libllvm), Cvoid, (LLVMBuilderRef, LLVMValueRef, Cstring), Builder, Instr, Name)
end

function LLVMDisposeBuilder(Builder)
    ccall((:LLVMDisposeBuilder, libllvm), Cvoid, (LLVMBuilderRef,), Builder)
end

function LLVMGetCurrentDebugLocation2(Builder)
    ccall((:LLVMGetCurrentDebugLocation2, libllvm), LLVMMetadataRef, (LLVMBuilderRef,), Builder)
end

function LLVMSetCurrentDebugLocation2(Builder, Loc)
    ccall((:LLVMSetCurrentDebugLocation2, libllvm), Cvoid, (LLVMBuilderRef, LLVMMetadataRef), Builder, Loc)
end

function LLVMSetInstDebugLocation(Builder, Inst)
    ccall((:LLVMSetInstDebugLocation, libllvm), Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Inst)
end

function LLVMAddMetadataToInst(Builder, Inst)
    ccall((:LLVMAddMetadataToInst, libllvm), Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Inst)
end

function LLVMBuilderGetDefaultFPMathTag(Builder)
    ccall((:LLVMBuilderGetDefaultFPMathTag, libllvm), LLVMMetadataRef, (LLVMBuilderRef,), Builder)
end

function LLVMBuilderSetDefaultFPMathTag(Builder, FPMathTag)
    ccall((:LLVMBuilderSetDefaultFPMathTag, libllvm), Cvoid, (LLVMBuilderRef, LLVMMetadataRef), Builder, FPMathTag)
end

function LLVMSetCurrentDebugLocation(Builder, L)
    ccall((:LLVMSetCurrentDebugLocation, libllvm), Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, L)
end

function LLVMGetCurrentDebugLocation(Builder)
    ccall((:LLVMGetCurrentDebugLocation, libllvm), LLVMValueRef, (LLVMBuilderRef,), Builder)
end

function LLVMBuildRetVoid(arg1)
    ccall((:LLVMBuildRetVoid, libllvm), LLVMValueRef, (LLVMBuilderRef,), arg1)
end

function LLVMBuildRet(arg1, V)
    ccall((:LLVMBuildRet, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), arg1, V)
end

function LLVMBuildAggregateRet(arg1, RetVals, N)
    ccall((:LLVMBuildAggregateRet, libllvm), LLVMValueRef, (LLVMBuilderRef, Ptr{LLVMValueRef}, Cuint), arg1, RetVals, N)
end

function LLVMBuildBr(arg1, Dest)
    ccall((:LLVMBuildBr, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMBasicBlockRef), arg1, Dest)
end

function LLVMBuildCondBr(arg1, If, Then, Else)
    ccall((:LLVMBuildCondBr, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, LLVMBasicBlockRef), arg1, If, Then, Else)
end

function LLVMBuildSwitch(arg1, V, Else, NumCases)
    ccall((:LLVMBuildSwitch, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, Cuint), arg1, V, Else, NumCases)
end

function LLVMBuildIndirectBr(B, Addr, NumDests)
    ccall((:LLVMBuildIndirectBr, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cuint), B, Addr, NumDests)
end

function LLVMBuildInvoke(arg1, Fn, Args, NumArgs, Then, Catch, Name)
    ccall((:LLVMBuildInvoke, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, LLVMBasicBlockRef, LLVMBasicBlockRef, Cstring), arg1, Fn, Args, NumArgs, Then, Catch, Name)
end

function LLVMBuildInvoke2(arg1, Ty, Fn, Args, NumArgs, Then, Catch, Name)
    ccall((:LLVMBuildInvoke2, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, LLVMBasicBlockRef, LLVMBasicBlockRef, Cstring), arg1, Ty, Fn, Args, NumArgs, Then, Catch, Name)
end

function LLVMBuildUnreachable(arg1)
    ccall((:LLVMBuildUnreachable, libllvm), LLVMValueRef, (LLVMBuilderRef,), arg1)
end

function LLVMBuildResume(B, Exn)
    ccall((:LLVMBuildResume, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), B, Exn)
end

function LLVMBuildLandingPad(B, Ty, PersFn, NumClauses, Name)
    ccall((:LLVMBuildLandingPad, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cuint, Cstring), B, Ty, PersFn, NumClauses, Name)
end

function LLVMBuildCleanupRet(B, CatchPad, BB)
    ccall((:LLVMBuildCleanupRet, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef), B, CatchPad, BB)
end

function LLVMBuildCatchRet(B, CatchPad, BB)
    ccall((:LLVMBuildCatchRet, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef), B, CatchPad, BB)
end

function LLVMBuildCatchPad(B, ParentPad, Args, NumArgs, Name)
    ccall((:LLVMBuildCatchPad, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring), B, ParentPad, Args, NumArgs, Name)
end

function LLVMBuildCleanupPad(B, ParentPad, Args, NumArgs, Name)
    ccall((:LLVMBuildCleanupPad, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring), B, ParentPad, Args, NumArgs, Name)
end

function LLVMBuildCatchSwitch(B, ParentPad, UnwindBB, NumHandlers, Name)
    ccall((:LLVMBuildCatchSwitch, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, Cuint, Cstring), B, ParentPad, UnwindBB, NumHandlers, Name)
end

function LLVMAddCase(Switch, OnVal, Dest)
    ccall((:LLVMAddCase, libllvm), Cvoid, (LLVMValueRef, LLVMValueRef, LLVMBasicBlockRef), Switch, OnVal, Dest)
end

function LLVMAddDestination(IndirectBr, Dest)
    ccall((:LLVMAddDestination, libllvm), Cvoid, (LLVMValueRef, LLVMBasicBlockRef), IndirectBr, Dest)
end

function LLVMGetNumClauses(LandingPad)
    ccall((:LLVMGetNumClauses, libllvm), Cuint, (LLVMValueRef,), LandingPad)
end

function LLVMGetClause(LandingPad, Idx)
    ccall((:LLVMGetClause, libllvm), LLVMValueRef, (LLVMValueRef, Cuint), LandingPad, Idx)
end

function LLVMAddClause(LandingPad, ClauseVal)
    ccall((:LLVMAddClause, libllvm), Cvoid, (LLVMValueRef, LLVMValueRef), LandingPad, ClauseVal)
end

function LLVMIsCleanup(LandingPad)
    ccall((:LLVMIsCleanup, libllvm), LLVMBool, (LLVMValueRef,), LandingPad)
end

function LLVMSetCleanup(LandingPad, Val)
    ccall((:LLVMSetCleanup, libllvm), Cvoid, (LLVMValueRef, LLVMBool), LandingPad, Val)
end

function LLVMAddHandler(CatchSwitch, Dest)
    ccall((:LLVMAddHandler, libllvm), Cvoid, (LLVMValueRef, LLVMBasicBlockRef), CatchSwitch, Dest)
end

function LLVMGetNumHandlers(CatchSwitch)
    ccall((:LLVMGetNumHandlers, libllvm), Cuint, (LLVMValueRef,), CatchSwitch)
end

function LLVMGetHandlers(CatchSwitch, Handlers)
    ccall((:LLVMGetHandlers, libllvm), Cvoid, (LLVMValueRef, Ptr{LLVMBasicBlockRef}), CatchSwitch, Handlers)
end

function LLVMGetArgOperand(Funclet, i)
    ccall((:LLVMGetArgOperand, libllvm), LLVMValueRef, (LLVMValueRef, Cuint), Funclet, i)
end

function LLVMSetArgOperand(Funclet, i, value)
    ccall((:LLVMSetArgOperand, libllvm), Cvoid, (LLVMValueRef, Cuint, LLVMValueRef), Funclet, i, value)
end

function LLVMGetParentCatchSwitch(CatchPad)
    ccall((:LLVMGetParentCatchSwitch, libllvm), LLVMValueRef, (LLVMValueRef,), CatchPad)
end

function LLVMSetParentCatchSwitch(CatchPad, CatchSwitch)
    ccall((:LLVMSetParentCatchSwitch, libllvm), Cvoid, (LLVMValueRef, LLVMValueRef), CatchPad, CatchSwitch)
end

function LLVMBuildAdd(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildAdd, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWAdd(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildNSWAdd, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWAdd(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildNUWAdd, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFAdd(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildFAdd, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSub(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildSub, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWSub(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildNSWSub, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWSub(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildNUWSub, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFSub(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildFSub, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildMul(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildMul, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWMul(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildNSWMul, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWMul(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildNUWMul, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFMul(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildFMul, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildUDiv(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildUDiv, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildExactUDiv(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildExactUDiv, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSDiv(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildSDiv, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildExactSDiv(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildExactSDiv, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFDiv(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildFDiv, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildURem(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildURem, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSRem(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildSRem, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFRem(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildFRem, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildShl(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildShl, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildLShr(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildLShr, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildAShr(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildAShr, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildAnd(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildAnd, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildOr(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildOr, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildXor(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildXor, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildBinOp(B, Op, LHS, RHS, Name)
    ccall((:LLVMBuildBinOp, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMOpcode, LLVMValueRef, LLVMValueRef, Cstring), B, Op, LHS, RHS, Name)
end

function LLVMBuildNeg(arg1, V, Name)
    ccall((:LLVMBuildNeg, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildNSWNeg(B, V, Name)
    ccall((:LLVMBuildNSWNeg, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), B, V, Name)
end

function LLVMBuildNUWNeg(B, V, Name)
    ccall((:LLVMBuildNUWNeg, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), B, V, Name)
end

function LLVMBuildFNeg(arg1, V, Name)
    ccall((:LLVMBuildFNeg, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildNot(arg1, V, Name)
    ccall((:LLVMBuildNot, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildMalloc(arg1, Ty, Name)
    ccall((:LLVMBuildMalloc, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildArrayMalloc(arg1, Ty, Val, Name)
    ccall((:LLVMBuildArrayMalloc, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring), arg1, Ty, Val, Name)
end

function LLVMBuildMemSet(B, Ptr, Val, Len, Align)
    ccall((:LLVMBuildMemSet, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cuint), B, Ptr, Val, Len, Align)
end

function LLVMBuildMemCpy(B, Dst, DstAlign, Src, SrcAlign, Size)
    ccall((:LLVMBuildMemCpy, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cuint, LLVMValueRef, Cuint, LLVMValueRef), B, Dst, DstAlign, Src, SrcAlign, Size)
end

function LLVMBuildMemMove(B, Dst, DstAlign, Src, SrcAlign, Size)
    ccall((:LLVMBuildMemMove, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cuint, LLVMValueRef, Cuint, LLVMValueRef), B, Dst, DstAlign, Src, SrcAlign, Size)
end

function LLVMBuildAlloca(arg1, Ty, Name)
    ccall((:LLVMBuildAlloca, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildArrayAlloca(arg1, Ty, Val, Name)
    ccall((:LLVMBuildArrayAlloca, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring), arg1, Ty, Val, Name)
end

function LLVMBuildFree(arg1, PointerVal)
    ccall((:LLVMBuildFree, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), arg1, PointerVal)
end

function LLVMBuildLoad(arg1, PointerVal, Name)
    ccall((:LLVMBuildLoad, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, PointerVal, Name)
end

function LLVMBuildLoad2(arg1, Ty, PointerVal, Name)
    ccall((:LLVMBuildLoad2, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring), arg1, Ty, PointerVal, Name)
end

function LLVMBuildStore(arg1, Val, Ptr)
    ccall((:LLVMBuildStore, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef), arg1, Val, Ptr)
end

function LLVMBuildGEP(B, Pointer, Indices, NumIndices, Name)
    ccall((:LLVMBuildGEP, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring), B, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildInBoundsGEP(B, Pointer, Indices, NumIndices, Name)
    ccall((:LLVMBuildInBoundsGEP, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring), B, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildStructGEP(B, Pointer, Idx, Name)
    ccall((:LLVMBuildStructGEP, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cuint, Cstring), B, Pointer, Idx, Name)
end

function LLVMBuildGEP2(B, Ty, Pointer, Indices, NumIndices, Name)
    ccall((:LLVMBuildGEP2, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring), B, Ty, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildInBoundsGEP2(B, Ty, Pointer, Indices, NumIndices, Name)
    ccall((:LLVMBuildInBoundsGEP2, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring), B, Ty, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildStructGEP2(B, Ty, Pointer, Idx, Name)
    ccall((:LLVMBuildStructGEP2, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cuint, Cstring), B, Ty, Pointer, Idx, Name)
end

function LLVMBuildGlobalString(B, Str, Name)
    ccall((:LLVMBuildGlobalString, libllvm), LLVMValueRef, (LLVMBuilderRef, Cstring, Cstring), B, Str, Name)
end

function LLVMBuildGlobalStringPtr(B, Str, Name)
    ccall((:LLVMBuildGlobalStringPtr, libllvm), LLVMValueRef, (LLVMBuilderRef, Cstring, Cstring), B, Str, Name)
end

function LLVMGetVolatile(MemoryAccessInst)
    ccall((:LLVMGetVolatile, libllvm), LLVMBool, (LLVMValueRef,), MemoryAccessInst)
end

function LLVMSetVolatile(MemoryAccessInst, IsVolatile)
    ccall((:LLVMSetVolatile, libllvm), Cvoid, (LLVMValueRef, LLVMBool), MemoryAccessInst, IsVolatile)
end

function LLVMGetWeak(CmpXchgInst)
    ccall((:LLVMGetWeak, libllvm), LLVMBool, (LLVMValueRef,), CmpXchgInst)
end

function LLVMSetWeak(CmpXchgInst, IsWeak)
    ccall((:LLVMSetWeak, libllvm), Cvoid, (LLVMValueRef, LLVMBool), CmpXchgInst, IsWeak)
end

function LLVMGetOrdering(MemoryAccessInst)
    ccall((:LLVMGetOrdering, libllvm), LLVMAtomicOrdering, (LLVMValueRef,), MemoryAccessInst)
end

function LLVMSetOrdering(MemoryAccessInst, Ordering)
    ccall((:LLVMSetOrdering, libllvm), Cvoid, (LLVMValueRef, LLVMAtomicOrdering), MemoryAccessInst, Ordering)
end

function LLVMGetAtomicRMWBinOp(AtomicRMWInst)
    ccall((:LLVMGetAtomicRMWBinOp, libllvm), LLVMAtomicRMWBinOp, (LLVMValueRef,), AtomicRMWInst)
end

function LLVMSetAtomicRMWBinOp(AtomicRMWInst, BinOp)
    ccall((:LLVMSetAtomicRMWBinOp, libllvm), Cvoid, (LLVMValueRef, LLVMAtomicRMWBinOp), AtomicRMWInst, BinOp)
end

function LLVMBuildTrunc(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildTrunc, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildZExt(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildZExt, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSExt(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildSExt, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPToUI(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildFPToUI, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPToSI(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildFPToSI, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildUIToFP(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildUIToFP, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSIToFP(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildSIToFP, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPTrunc(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildFPTrunc, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPExt(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildFPExt, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildPtrToInt(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildPtrToInt, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildIntToPtr(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildIntToPtr, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildBitCast(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildBitCast, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildAddrSpaceCast(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildAddrSpaceCast, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildZExtOrBitCast(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildZExtOrBitCast, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSExtOrBitCast(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildSExtOrBitCast, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildTruncOrBitCast(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildTruncOrBitCast, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildCast(B, Op, Val, DestTy, Name)
    ccall((:LLVMBuildCast, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMOpcode, LLVMValueRef, LLVMTypeRef, Cstring), B, Op, Val, DestTy, Name)
end

function LLVMBuildPointerCast(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildPointerCast, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildIntCast2(arg1, Val, DestTy, IsSigned, Name)
    ccall((:LLVMBuildIntCast2, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, LLVMBool, Cstring), arg1, Val, DestTy, IsSigned, Name)
end

function LLVMBuildFPCast(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildFPCast, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildIntCast(arg1, Val, DestTy, Name)
    ccall((:LLVMBuildIntCast, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildICmp(arg1, Op, LHS, RHS, Name)
    ccall((:LLVMBuildICmp, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMIntPredicate, LLVMValueRef, LLVMValueRef, Cstring), arg1, Op, LHS, RHS, Name)
end

function LLVMBuildFCmp(arg1, Op, LHS, RHS, Name)
    ccall((:LLVMBuildFCmp, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMRealPredicate, LLVMValueRef, LLVMValueRef, Cstring), arg1, Op, LHS, RHS, Name)
end

function LLVMBuildPhi(arg1, Ty, Name)
    ccall((:LLVMBuildPhi, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildCall(arg1, Fn, Args, NumArgs, Name)
    ccall((:LLVMBuildCall, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring), arg1, Fn, Args, NumArgs, Name)
end

function LLVMBuildCall2(arg1, arg2, Fn, Args, NumArgs, Name)
    ccall((:LLVMBuildCall2, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, Cuint, Cstring), arg1, arg2, Fn, Args, NumArgs, Name)
end

function LLVMBuildSelect(arg1, If, Then, Else, Name)
    ccall((:LLVMBuildSelect, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, If, Then, Else, Name)
end

function LLVMBuildVAArg(arg1, List, Ty, Name)
    ccall((:LLVMBuildVAArg, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, List, Ty, Name)
end

function LLVMBuildExtractElement(arg1, VecVal, Index, Name)
    ccall((:LLVMBuildExtractElement, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, VecVal, Index, Name)
end

function LLVMBuildInsertElement(arg1, VecVal, EltVal, Index, Name)
    ccall((:LLVMBuildInsertElement, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, VecVal, EltVal, Index, Name)
end

function LLVMBuildShuffleVector(arg1, V1, V2, Mask, Name)
    ccall((:LLVMBuildShuffleVector, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, V1, V2, Mask, Name)
end

function LLVMBuildExtractValue(arg1, AggVal, Index, Name)
    ccall((:LLVMBuildExtractValue, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cuint, Cstring), arg1, AggVal, Index, Name)
end

function LLVMBuildInsertValue(arg1, AggVal, EltVal, Index, Name)
    ccall((:LLVMBuildInsertValue, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cuint, Cstring), arg1, AggVal, EltVal, Index, Name)
end

function LLVMBuildFreeze(arg1, Val, Name)
    ccall((:LLVMBuildFreeze, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, Val, Name)
end

function LLVMBuildIsNull(arg1, Val, Name)
    ccall((:LLVMBuildIsNull, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, Val, Name)
end

function LLVMBuildIsNotNull(arg1, Val, Name)
    ccall((:LLVMBuildIsNotNull, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, Val, Name)
end

function LLVMBuildPtrDiff(arg1, LHS, RHS, Name)
    ccall((:LLVMBuildPtrDiff, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildPtrDiff2(arg1, ElemTy, LHS, RHS, Name)
    ccall((:LLVMBuildPtrDiff2, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, ElemTy, LHS, RHS, Name)
end

function LLVMBuildFence(B, ordering, singleThread, Name)
    ccall((:LLVMBuildFence, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMAtomicOrdering, LLVMBool, Cstring), B, ordering, singleThread, Name)
end

function LLVMBuildAtomicRMW(B, op, PTR, Val, ordering, singleThread)
    ccall((:LLVMBuildAtomicRMW, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMAtomicRMWBinOp, LLVMValueRef, LLVMValueRef, LLVMAtomicOrdering, LLVMBool), B, op, PTR, Val, ordering, singleThread)
end

function LLVMBuildAtomicCmpXchg(B, Ptr, Cmp, New, SuccessOrdering, FailureOrdering, SingleThread)
    ccall((:LLVMBuildAtomicCmpXchg, libllvm), LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, LLVMAtomicOrdering, LLVMAtomicOrdering, LLVMBool), B, Ptr, Cmp, New, SuccessOrdering, FailureOrdering, SingleThread)
end

function LLVMGetNumMaskElements(ShuffleVectorInst)
    ccall((:LLVMGetNumMaskElements, libllvm), Cuint, (LLVMValueRef,), ShuffleVectorInst)
end

function LLVMGetUndefMaskElem()
    ccall((:LLVMGetUndefMaskElem, libllvm), Cint, ())
end

function LLVMGetMaskValue(ShuffleVectorInst, Elt)
    ccall((:LLVMGetMaskValue, libllvm), Cint, (LLVMValueRef, Cuint), ShuffleVectorInst, Elt)
end

function LLVMIsAtomicSingleThread(AtomicInst)
    ccall((:LLVMIsAtomicSingleThread, libllvm), LLVMBool, (LLVMValueRef,), AtomicInst)
end

function LLVMSetAtomicSingleThread(AtomicInst, SingleThread)
    ccall((:LLVMSetAtomicSingleThread, libllvm), Cvoid, (LLVMValueRef, LLVMBool), AtomicInst, SingleThread)
end

function LLVMGetCmpXchgSuccessOrdering(CmpXchgInst)
    ccall((:LLVMGetCmpXchgSuccessOrdering, libllvm), LLVMAtomicOrdering, (LLVMValueRef,), CmpXchgInst)
end

function LLVMSetCmpXchgSuccessOrdering(CmpXchgInst, Ordering)
    ccall((:LLVMSetCmpXchgSuccessOrdering, libllvm), Cvoid, (LLVMValueRef, LLVMAtomicOrdering), CmpXchgInst, Ordering)
end

function LLVMGetCmpXchgFailureOrdering(CmpXchgInst)
    ccall((:LLVMGetCmpXchgFailureOrdering, libllvm), LLVMAtomicOrdering, (LLVMValueRef,), CmpXchgInst)
end

function LLVMSetCmpXchgFailureOrdering(CmpXchgInst, Ordering)
    ccall((:LLVMSetCmpXchgFailureOrdering, libllvm), Cvoid, (LLVMValueRef, LLVMAtomicOrdering), CmpXchgInst, Ordering)
end

const LLVMModuleProviderRef = Ptr{LLVMOpaqueModuleProvider}

function LLVMCreateModuleProviderForExistingModule(M)
    ccall((:LLVMCreateModuleProviderForExistingModule, libllvm), LLVMModuleProviderRef, (LLVMModuleRef,), M)
end

function LLVMDisposeModuleProvider(M)
    ccall((:LLVMDisposeModuleProvider, libllvm), Cvoid, (LLVMModuleProviderRef,), M)
end

function LLVMCreateMemoryBufferWithContentsOfFile(Path, OutMemBuf, OutMessage)
    ccall((:LLVMCreateMemoryBufferWithContentsOfFile, libllvm), LLVMBool, (Cstring, Ptr{LLVMMemoryBufferRef}, Ptr{Cstring}), Path, OutMemBuf, OutMessage)
end

function LLVMCreateMemoryBufferWithSTDIN(OutMemBuf, OutMessage)
    ccall((:LLVMCreateMemoryBufferWithSTDIN, libllvm), LLVMBool, (Ptr{LLVMMemoryBufferRef}, Ptr{Cstring}), OutMemBuf, OutMessage)
end

function LLVMCreateMemoryBufferWithMemoryRange(InputData, InputDataLength, BufferName, RequiresNullTerminator)
    ccall((:LLVMCreateMemoryBufferWithMemoryRange, libllvm), LLVMMemoryBufferRef, (Cstring, Csize_t, Cstring, LLVMBool), InputData, InputDataLength, BufferName, RequiresNullTerminator)
end

function LLVMCreateMemoryBufferWithMemoryRangeCopy(InputData, InputDataLength, BufferName)
    ccall((:LLVMCreateMemoryBufferWithMemoryRangeCopy, libllvm), LLVMMemoryBufferRef, (Cstring, Csize_t, Cstring), InputData, InputDataLength, BufferName)
end

function LLVMGetBufferStart(MemBuf)
    ccall((:LLVMGetBufferStart, libllvm), Cstring, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMGetBufferSize(MemBuf)
    ccall((:LLVMGetBufferSize, libllvm), Csize_t, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMDisposeMemoryBuffer(MemBuf)
    ccall((:LLVMDisposeMemoryBuffer, libllvm), Cvoid, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMGetGlobalPassRegistry()
    ccall((:LLVMGetGlobalPassRegistry, libllvm), LLVMPassRegistryRef, ())
end

const LLVMPassManagerRef = Ptr{LLVMOpaquePassManager}

function LLVMCreatePassManager()
    ccall((:LLVMCreatePassManager, libllvm), LLVMPassManagerRef, ())
end

function LLVMCreateFunctionPassManagerForModule(M)
    ccall((:LLVMCreateFunctionPassManagerForModule, libllvm), LLVMPassManagerRef, (LLVMModuleRef,), M)
end

function LLVMCreateFunctionPassManager(MP)
    ccall((:LLVMCreateFunctionPassManager, libllvm), LLVMPassManagerRef, (LLVMModuleProviderRef,), MP)
end

function LLVMRunPassManager(PM, M)
    ccall((:LLVMRunPassManager, libllvm), LLVMBool, (LLVMPassManagerRef, LLVMModuleRef), PM, M)
end

function LLVMInitializeFunctionPassManager(FPM)
    ccall((:LLVMInitializeFunctionPassManager, libllvm), LLVMBool, (LLVMPassManagerRef,), FPM)
end

function LLVMRunFunctionPassManager(FPM, F)
    ccall((:LLVMRunFunctionPassManager, libllvm), LLVMBool, (LLVMPassManagerRef, LLVMValueRef), FPM, F)
end

function LLVMFinalizeFunctionPassManager(FPM)
    ccall((:LLVMFinalizeFunctionPassManager, libllvm), LLVMBool, (LLVMPassManagerRef,), FPM)
end

function LLVMDisposePassManager(PM)
    ccall((:LLVMDisposePassManager, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMStartMultithreaded()
    ccall((:LLVMStartMultithreaded, libllvm), LLVMBool, ())
end

function LLVMStopMultithreaded()
    ccall((:LLVMStopMultithreaded, libllvm), Cvoid, ())
end

function LLVMIsMultithreaded()
    ccall((:LLVMIsMultithreaded, libllvm), LLVMBool, ())
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

@cenum __JL_Ctag_115::UInt32 begin
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
    LLVMDIStringTypeMetadataKind = 32
    LLVMDIGenericSubrangeMetadataKind = 33
    LLVMDIArgListMetadataKind = 34
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
    ccall((:LLVMDebugMetadataVersion, libllvm), Cuint, ())
end

function LLVMGetModuleDebugMetadataVersion(Module)
    ccall((:LLVMGetModuleDebugMetadataVersion, libllvm), Cuint, (LLVMModuleRef,), Module)
end

function LLVMStripModuleDebugInfo(Module)
    ccall((:LLVMStripModuleDebugInfo, libllvm), LLVMBool, (LLVMModuleRef,), Module)
end

const LLVMDIBuilderRef = Ptr{LLVMOpaqueDIBuilder}

function LLVMCreateDIBuilderDisallowUnresolved(M)
    ccall((:LLVMCreateDIBuilderDisallowUnresolved, libllvm), LLVMDIBuilderRef, (LLVMModuleRef,), M)
end

function LLVMCreateDIBuilder(M)
    ccall((:LLVMCreateDIBuilder, libllvm), LLVMDIBuilderRef, (LLVMModuleRef,), M)
end

function LLVMDisposeDIBuilder(Builder)
    ccall((:LLVMDisposeDIBuilder, libllvm), Cvoid, (LLVMDIBuilderRef,), Builder)
end

function LLVMDIBuilderFinalize(Builder)
    ccall((:LLVMDIBuilderFinalize, libllvm), Cvoid, (LLVMDIBuilderRef,), Builder)
end

function LLVMDIBuilderFinalizeSubprogram(Builder, Subprogram)
    ccall((:LLVMDIBuilderFinalizeSubprogram, libllvm), Cvoid, (LLVMDIBuilderRef, LLVMMetadataRef), Builder, Subprogram)
end

function LLVMDIBuilderCreateCompileUnit(Builder, Lang, FileRef, Producer, ProducerLen, isOptimized, Flags, FlagsLen, RuntimeVer, SplitName, SplitNameLen, Kind, DWOId, SplitDebugInlining, DebugInfoForProfiling, SysRoot, SysRootLen, SDK, SDKLen)
    ccall((:LLVMDIBuilderCreateCompileUnit, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMDWARFSourceLanguage, LLVMMetadataRef, Cstring, Csize_t, LLVMBool, Cstring, Csize_t, Cuint, Cstring, Csize_t, LLVMDWARFEmissionKind, Cuint, LLVMBool, LLVMBool, Cstring, Csize_t, Cstring, Csize_t), Builder, Lang, FileRef, Producer, ProducerLen, isOptimized, Flags, FlagsLen, RuntimeVer, SplitName, SplitNameLen, Kind, DWOId, SplitDebugInlining, DebugInfoForProfiling, SysRoot, SysRootLen, SDK, SDKLen)
end

function LLVMDIBuilderCreateFile(Builder, Filename, FilenameLen, Directory, DirectoryLen)
    ccall((:LLVMDIBuilderCreateFile, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, Cstring, Csize_t, Cstring, Csize_t), Builder, Filename, FilenameLen, Directory, DirectoryLen)
end

function LLVMDIBuilderCreateModule(Builder, ParentScope, Name, NameLen, ConfigMacros, ConfigMacrosLen, IncludePath, IncludePathLen, APINotesFile, APINotesFileLen)
    ccall((:LLVMDIBuilderCreateModule, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, Cstring, Csize_t, Cstring, Csize_t, Cstring, Csize_t), Builder, ParentScope, Name, NameLen, ConfigMacros, ConfigMacrosLen, IncludePath, IncludePathLen, APINotesFile, APINotesFileLen)
end

function LLVMDIBuilderCreateNameSpace(Builder, ParentScope, Name, NameLen, ExportSymbols)
    ccall((:LLVMDIBuilderCreateNameSpace, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMBool), Builder, ParentScope, Name, NameLen, ExportSymbols)
end

function LLVMDIBuilderCreateFunction(Builder, Scope, Name, NameLen, LinkageName, LinkageNameLen, File, LineNo, Ty, IsLocalToUnit, IsDefinition, ScopeLine, Flags, IsOptimized)
    ccall((:LLVMDIBuilderCreateFunction, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, Cstring, Csize_t, LLVMMetadataRef, Cuint, LLVMMetadataRef, LLVMBool, LLVMBool, Cuint, LLVMDIFlags, LLVMBool), Builder, Scope, Name, NameLen, LinkageName, LinkageNameLen, File, LineNo, Ty, IsLocalToUnit, IsDefinition, ScopeLine, Flags, IsOptimized)
end

function LLVMDIBuilderCreateLexicalBlock(Builder, Scope, File, Line, Column)
    ccall((:LLVMDIBuilderCreateLexicalBlock, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, Cuint, Cuint), Builder, Scope, File, Line, Column)
end

function LLVMDIBuilderCreateLexicalBlockFile(Builder, Scope, File, Discriminator)
    ccall((:LLVMDIBuilderCreateLexicalBlockFile, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, Cuint), Builder, Scope, File, Discriminator)
end

function LLVMDIBuilderCreateImportedModuleFromNamespace(Builder, Scope, NS, File, Line)
    ccall((:LLVMDIBuilderCreateImportedModuleFromNamespace, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, Cuint), Builder, Scope, NS, File, Line)
end

function LLVMDIBuilderCreateImportedModuleFromAlias(Builder, Scope, ImportedEntity, File, Line, Elements, NumElements)
    ccall((:LLVMDIBuilderCreateImportedModuleFromAlias, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, Cuint, Ptr{LLVMMetadataRef}, Cuint), Builder, Scope, ImportedEntity, File, Line, Elements, NumElements)
end

function LLVMDIBuilderCreateImportedModuleFromModule(Builder, Scope, M, File, Line, Elements, NumElements)
    ccall((:LLVMDIBuilderCreateImportedModuleFromModule, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, Cuint, Ptr{LLVMMetadataRef}, Cuint), Builder, Scope, M, File, Line, Elements, NumElements)
end

function LLVMDIBuilderCreateImportedDeclaration(Builder, Scope, Decl, File, Line, Name, NameLen, Elements, NumElements)
    ccall((:LLVMDIBuilderCreateImportedDeclaration, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, Cuint, Cstring, Csize_t, Ptr{LLVMMetadataRef}, Cuint), Builder, Scope, Decl, File, Line, Name, NameLen, Elements, NumElements)
end

function LLVMDIBuilderCreateDebugLocation(Ctx, Line, Column, Scope, InlinedAt)
    ccall((:LLVMDIBuilderCreateDebugLocation, libllvm), LLVMMetadataRef, (LLVMContextRef, Cuint, Cuint, LLVMMetadataRef, LLVMMetadataRef), Ctx, Line, Column, Scope, InlinedAt)
end

function LLVMDILocationGetLine(Location)
    ccall((:LLVMDILocationGetLine, libllvm), Cuint, (LLVMMetadataRef,), Location)
end

function LLVMDILocationGetColumn(Location)
    ccall((:LLVMDILocationGetColumn, libllvm), Cuint, (LLVMMetadataRef,), Location)
end

function LLVMDILocationGetScope(Location)
    ccall((:LLVMDILocationGetScope, libllvm), LLVMMetadataRef, (LLVMMetadataRef,), Location)
end

function LLVMDILocationGetInlinedAt(Location)
    ccall((:LLVMDILocationGetInlinedAt, libllvm), LLVMMetadataRef, (LLVMMetadataRef,), Location)
end

function LLVMDIScopeGetFile(Scope)
    ccall((:LLVMDIScopeGetFile, libllvm), LLVMMetadataRef, (LLVMMetadataRef,), Scope)
end

function LLVMDIFileGetDirectory(File, Len)
    ccall((:LLVMDIFileGetDirectory, libllvm), Cstring, (LLVMMetadataRef, Ptr{Cuint}), File, Len)
end

function LLVMDIFileGetFilename(File, Len)
    ccall((:LLVMDIFileGetFilename, libllvm), Cstring, (LLVMMetadataRef, Ptr{Cuint}), File, Len)
end

function LLVMDIFileGetSource(File, Len)
    ccall((:LLVMDIFileGetSource, libllvm), Cstring, (LLVMMetadataRef, Ptr{Cuint}), File, Len)
end

function LLVMDIBuilderGetOrCreateTypeArray(Builder, Data, NumElements)
    ccall((:LLVMDIBuilderGetOrCreateTypeArray, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, Ptr{LLVMMetadataRef}, Csize_t), Builder, Data, NumElements)
end

function LLVMDIBuilderCreateSubroutineType(Builder, File, ParameterTypes, NumParameterTypes, Flags)
    ccall((:LLVMDIBuilderCreateSubroutineType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Ptr{LLVMMetadataRef}, Cuint, LLVMDIFlags), Builder, File, ParameterTypes, NumParameterTypes, Flags)
end

function LLVMDIBuilderCreateMacro(Builder, ParentMacroFile, Line, RecordType, Name, NameLen, Value, ValueLen)
    ccall((:LLVMDIBuilderCreateMacro, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cuint, LLVMDWARFMacinfoRecordType, Cstring, Csize_t, Cstring, Csize_t), Builder, ParentMacroFile, Line, RecordType, Name, NameLen, Value, ValueLen)
end

function LLVMDIBuilderCreateTempMacroFile(Builder, ParentMacroFile, Line, File)
    ccall((:LLVMDIBuilderCreateTempMacroFile, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cuint, LLVMMetadataRef), Builder, ParentMacroFile, Line, File)
end

function LLVMDIBuilderCreateEnumerator(Builder, Name, NameLen, Value, IsUnsigned)
    ccall((:LLVMDIBuilderCreateEnumerator, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, Cstring, Csize_t, Int64, LLVMBool), Builder, Name, NameLen, Value, IsUnsigned)
end

function LLVMDIBuilderCreateEnumerationType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Elements, NumElements, ClassTy)
    ccall((:LLVMDIBuilderCreateEnumerationType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, UInt64, UInt32, Ptr{LLVMMetadataRef}, Cuint, LLVMMetadataRef), Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Elements, NumElements, ClassTy)
end

function LLVMDIBuilderCreateUnionType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Flags, Elements, NumElements, RunTimeLang, UniqueId, UniqueIdLen)
    ccall((:LLVMDIBuilderCreateUnionType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, UInt64, UInt32, LLVMDIFlags, Ptr{LLVMMetadataRef}, Cuint, Cuint, Cstring, Csize_t), Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Flags, Elements, NumElements, RunTimeLang, UniqueId, UniqueIdLen)
end

function LLVMDIBuilderCreateArrayType(Builder, Size, AlignInBits, Ty, Subscripts, NumSubscripts)
    ccall((:LLVMDIBuilderCreateArrayType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, UInt64, UInt32, LLVMMetadataRef, Ptr{LLVMMetadataRef}, Cuint), Builder, Size, AlignInBits, Ty, Subscripts, NumSubscripts)
end

function LLVMDIBuilderCreateVectorType(Builder, Size, AlignInBits, Ty, Subscripts, NumSubscripts)
    ccall((:LLVMDIBuilderCreateVectorType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, UInt64, UInt32, LLVMMetadataRef, Ptr{LLVMMetadataRef}, Cuint), Builder, Size, AlignInBits, Ty, Subscripts, NumSubscripts)
end

function LLVMDIBuilderCreateUnspecifiedType(Builder, Name, NameLen)
    ccall((:LLVMDIBuilderCreateUnspecifiedType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, Cstring, Csize_t), Builder, Name, NameLen)
end

function LLVMDIBuilderCreateBasicType(Builder, Name, NameLen, SizeInBits, Encoding, Flags)
    ccall((:LLVMDIBuilderCreateBasicType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, Cstring, Csize_t, UInt64, LLVMDWARFTypeEncoding, LLVMDIFlags), Builder, Name, NameLen, SizeInBits, Encoding, Flags)
end

function LLVMDIBuilderCreatePointerType(Builder, PointeeTy, SizeInBits, AlignInBits, AddressSpace, Name, NameLen)
    ccall((:LLVMDIBuilderCreatePointerType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, UInt64, UInt32, Cuint, Cstring, Csize_t), Builder, PointeeTy, SizeInBits, AlignInBits, AddressSpace, Name, NameLen)
end

function LLVMDIBuilderCreateStructType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Flags, DerivedFrom, Elements, NumElements, RunTimeLang, VTableHolder, UniqueId, UniqueIdLen)
    ccall((:LLVMDIBuilderCreateStructType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, UInt64, UInt32, LLVMDIFlags, LLVMMetadataRef, Ptr{LLVMMetadataRef}, Cuint, Cuint, LLVMMetadataRef, Cstring, Csize_t), Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Flags, DerivedFrom, Elements, NumElements, RunTimeLang, VTableHolder, UniqueId, UniqueIdLen)
end

function LLVMDIBuilderCreateMemberType(Builder, Scope, Name, NameLen, File, LineNo, SizeInBits, AlignInBits, OffsetInBits, Flags, Ty)
    ccall((:LLVMDIBuilderCreateMemberType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, UInt64, UInt32, UInt64, LLVMDIFlags, LLVMMetadataRef), Builder, Scope, Name, NameLen, File, LineNo, SizeInBits, AlignInBits, OffsetInBits, Flags, Ty)
end

function LLVMDIBuilderCreateStaticMemberType(Builder, Scope, Name, NameLen, File, LineNumber, Type, Flags, ConstantVal, AlignInBits)
    ccall((:LLVMDIBuilderCreateStaticMemberType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, LLVMMetadataRef, LLVMDIFlags, LLVMValueRef, UInt32), Builder, Scope, Name, NameLen, File, LineNumber, Type, Flags, ConstantVal, AlignInBits)
end

function LLVMDIBuilderCreateMemberPointerType(Builder, PointeeType, ClassType, SizeInBits, AlignInBits, Flags)
    ccall((:LLVMDIBuilderCreateMemberPointerType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, UInt64, UInt32, LLVMDIFlags), Builder, PointeeType, ClassType, SizeInBits, AlignInBits, Flags)
end

function LLVMDIBuilderCreateObjCIVar(Builder, Name, NameLen, File, LineNo, SizeInBits, AlignInBits, OffsetInBits, Flags, Ty, PropertyNode)
    ccall((:LLVMDIBuilderCreateObjCIVar, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, UInt64, UInt32, UInt64, LLVMDIFlags, LLVMMetadataRef, LLVMMetadataRef), Builder, Name, NameLen, File, LineNo, SizeInBits, AlignInBits, OffsetInBits, Flags, Ty, PropertyNode)
end

function LLVMDIBuilderCreateObjCProperty(Builder, Name, NameLen, File, LineNo, GetterName, GetterNameLen, SetterName, SetterNameLen, PropertyAttributes, Ty)
    ccall((:LLVMDIBuilderCreateObjCProperty, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, Cstring, Csize_t, Cstring, Csize_t, Cuint, LLVMMetadataRef), Builder, Name, NameLen, File, LineNo, GetterName, GetterNameLen, SetterName, SetterNameLen, PropertyAttributes, Ty)
end

function LLVMDIBuilderCreateObjectPointerType(Builder, Type)
    ccall((:LLVMDIBuilderCreateObjectPointerType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef), Builder, Type)
end

function LLVMDIBuilderCreateQualifiedType(Builder, Tag, Type)
    ccall((:LLVMDIBuilderCreateQualifiedType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, Cuint, LLVMMetadataRef), Builder, Tag, Type)
end

function LLVMDIBuilderCreateReferenceType(Builder, Tag, Type)
    ccall((:LLVMDIBuilderCreateReferenceType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, Cuint, LLVMMetadataRef), Builder, Tag, Type)
end

function LLVMDIBuilderCreateNullPtrType(Builder)
    ccall((:LLVMDIBuilderCreateNullPtrType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef,), Builder)
end

function LLVMDIBuilderCreateTypedef(Builder, Type, Name, NameLen, File, LineNo, Scope, AlignInBits)
    ccall((:LLVMDIBuilderCreateTypedef, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, LLVMMetadataRef, UInt32), Builder, Type, Name, NameLen, File, LineNo, Scope, AlignInBits)
end

function LLVMDIBuilderCreateInheritance(Builder, Ty, BaseTy, BaseOffset, VBPtrOffset, Flags)
    ccall((:LLVMDIBuilderCreateInheritance, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, UInt64, UInt32, LLVMDIFlags), Builder, Ty, BaseTy, BaseOffset, VBPtrOffset, Flags)
end

function LLVMDIBuilderCreateForwardDecl(Builder, Tag, Name, NameLen, Scope, File, Line, RuntimeLang, SizeInBits, AlignInBits, UniqueIdentifier, UniqueIdentifierLen)
    ccall((:LLVMDIBuilderCreateForwardDecl, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, Cuint, Cstring, Csize_t, LLVMMetadataRef, LLVMMetadataRef, Cuint, Cuint, UInt64, UInt32, Cstring, Csize_t), Builder, Tag, Name, NameLen, Scope, File, Line, RuntimeLang, SizeInBits, AlignInBits, UniqueIdentifier, UniqueIdentifierLen)
end

function LLVMDIBuilderCreateReplaceableCompositeType(Builder, Tag, Name, NameLen, Scope, File, Line, RuntimeLang, SizeInBits, AlignInBits, Flags, UniqueIdentifier, UniqueIdentifierLen)
    ccall((:LLVMDIBuilderCreateReplaceableCompositeType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, Cuint, Cstring, Csize_t, LLVMMetadataRef, LLVMMetadataRef, Cuint, Cuint, UInt64, UInt32, LLVMDIFlags, Cstring, Csize_t), Builder, Tag, Name, NameLen, Scope, File, Line, RuntimeLang, SizeInBits, AlignInBits, Flags, UniqueIdentifier, UniqueIdentifierLen)
end

function LLVMDIBuilderCreateBitFieldMemberType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, OffsetInBits, StorageOffsetInBits, Flags, Type)
    ccall((:LLVMDIBuilderCreateBitFieldMemberType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, UInt64, UInt64, UInt64, LLVMDIFlags, LLVMMetadataRef), Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, OffsetInBits, StorageOffsetInBits, Flags, Type)
end

function LLVMDIBuilderCreateClassType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, OffsetInBits, Flags, DerivedFrom, Elements, NumElements, VTableHolder, TemplateParamsNode, UniqueIdentifier, UniqueIdentifierLen)
    ccall((:LLVMDIBuilderCreateClassType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, UInt64, UInt32, UInt64, LLVMDIFlags, LLVMMetadataRef, Ptr{LLVMMetadataRef}, Cuint, LLVMMetadataRef, LLVMMetadataRef, Cstring, Csize_t), Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, OffsetInBits, Flags, DerivedFrom, Elements, NumElements, VTableHolder, TemplateParamsNode, UniqueIdentifier, UniqueIdentifierLen)
end

function LLVMDIBuilderCreateArtificialType(Builder, Type)
    ccall((:LLVMDIBuilderCreateArtificialType, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef), Builder, Type)
end

function LLVMDITypeGetName(DType, Length)
    ccall((:LLVMDITypeGetName, libllvm), Cstring, (LLVMMetadataRef, Ptr{Csize_t}), DType, Length)
end

function LLVMDITypeGetSizeInBits(DType)
    ccall((:LLVMDITypeGetSizeInBits, libllvm), UInt64, (LLVMMetadataRef,), DType)
end

function LLVMDITypeGetOffsetInBits(DType)
    ccall((:LLVMDITypeGetOffsetInBits, libllvm), UInt64, (LLVMMetadataRef,), DType)
end

function LLVMDITypeGetAlignInBits(DType)
    ccall((:LLVMDITypeGetAlignInBits, libllvm), UInt32, (LLVMMetadataRef,), DType)
end

function LLVMDITypeGetLine(DType)
    ccall((:LLVMDITypeGetLine, libllvm), Cuint, (LLVMMetadataRef,), DType)
end

function LLVMDITypeGetFlags(DType)
    ccall((:LLVMDITypeGetFlags, libllvm), LLVMDIFlags, (LLVMMetadataRef,), DType)
end

function LLVMDIBuilderGetOrCreateSubrange(Builder, LowerBound, Count)
    ccall((:LLVMDIBuilderGetOrCreateSubrange, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, Int64, Int64), Builder, LowerBound, Count)
end

function LLVMDIBuilderGetOrCreateArray(Builder, Data, NumElements)
    ccall((:LLVMDIBuilderGetOrCreateArray, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, Ptr{LLVMMetadataRef}, Csize_t), Builder, Data, NumElements)
end

function LLVMDIBuilderCreateExpression(Builder, Addr, Length)
    ccall((:LLVMDIBuilderCreateExpression, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, Ptr{UInt64}, Csize_t), Builder, Addr, Length)
end

function LLVMDIBuilderCreateConstantValueExpression(Builder, Value)
    ccall((:LLVMDIBuilderCreateConstantValueExpression, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, UInt64), Builder, Value)
end

function LLVMDIBuilderCreateGlobalVariableExpression(Builder, Scope, Name, NameLen, Linkage, LinkLen, File, LineNo, Ty, LocalToUnit, Expr, Decl, AlignInBits)
    ccall((:LLVMDIBuilderCreateGlobalVariableExpression, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, Cstring, Csize_t, LLVMMetadataRef, Cuint, LLVMMetadataRef, LLVMBool, LLVMMetadataRef, LLVMMetadataRef, UInt32), Builder, Scope, Name, NameLen, Linkage, LinkLen, File, LineNo, Ty, LocalToUnit, Expr, Decl, AlignInBits)
end

function LLVMDIGlobalVariableExpressionGetVariable(GVE)
    ccall((:LLVMDIGlobalVariableExpressionGetVariable, libllvm), LLVMMetadataRef, (LLVMMetadataRef,), GVE)
end

function LLVMDIGlobalVariableExpressionGetExpression(GVE)
    ccall((:LLVMDIGlobalVariableExpressionGetExpression, libllvm), LLVMMetadataRef, (LLVMMetadataRef,), GVE)
end

function LLVMDIVariableGetFile(Var)
    ccall((:LLVMDIVariableGetFile, libllvm), LLVMMetadataRef, (LLVMMetadataRef,), Var)
end

function LLVMDIVariableGetScope(Var)
    ccall((:LLVMDIVariableGetScope, libllvm), LLVMMetadataRef, (LLVMMetadataRef,), Var)
end

function LLVMDIVariableGetLine(Var)
    ccall((:LLVMDIVariableGetLine, libllvm), Cuint, (LLVMMetadataRef,), Var)
end

function LLVMTemporaryMDNode(Ctx, Data, NumElements)
    ccall((:LLVMTemporaryMDNode, libllvm), LLVMMetadataRef, (LLVMContextRef, Ptr{LLVMMetadataRef}, Csize_t), Ctx, Data, NumElements)
end

function LLVMDisposeTemporaryMDNode(TempNode)
    ccall((:LLVMDisposeTemporaryMDNode, libllvm), Cvoid, (LLVMMetadataRef,), TempNode)
end

function LLVMMetadataReplaceAllUsesWith(TempTargetMetadata, Replacement)
    ccall((:LLVMMetadataReplaceAllUsesWith, libllvm), Cvoid, (LLVMMetadataRef, LLVMMetadataRef), TempTargetMetadata, Replacement)
end

function LLVMDIBuilderCreateTempGlobalVariableFwdDecl(Builder, Scope, Name, NameLen, Linkage, LnkLen, File, LineNo, Ty, LocalToUnit, Decl, AlignInBits)
    ccall((:LLVMDIBuilderCreateTempGlobalVariableFwdDecl, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, Cstring, Csize_t, LLVMMetadataRef, Cuint, LLVMMetadataRef, LLVMBool, LLVMMetadataRef, UInt32), Builder, Scope, Name, NameLen, Linkage, LnkLen, File, LineNo, Ty, LocalToUnit, Decl, AlignInBits)
end

function LLVMDIBuilderInsertDeclareBefore(Builder, Storage, VarInfo, Expr, DebugLoc, Instr)
    ccall((:LLVMDIBuilderInsertDeclareBefore, libllvm), LLVMValueRef, (LLVMDIBuilderRef, LLVMValueRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, LLVMValueRef), Builder, Storage, VarInfo, Expr, DebugLoc, Instr)
end

function LLVMDIBuilderInsertDeclareAtEnd(Builder, Storage, VarInfo, Expr, DebugLoc, Block)
    ccall((:LLVMDIBuilderInsertDeclareAtEnd, libllvm), LLVMValueRef, (LLVMDIBuilderRef, LLVMValueRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, LLVMBasicBlockRef), Builder, Storage, VarInfo, Expr, DebugLoc, Block)
end

function LLVMDIBuilderInsertDbgValueBefore(Builder, Val, VarInfo, Expr, DebugLoc, Instr)
    ccall((:LLVMDIBuilderInsertDbgValueBefore, libllvm), LLVMValueRef, (LLVMDIBuilderRef, LLVMValueRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, LLVMValueRef), Builder, Val, VarInfo, Expr, DebugLoc, Instr)
end

function LLVMDIBuilderInsertDbgValueAtEnd(Builder, Val, VarInfo, Expr, DebugLoc, Block)
    ccall((:LLVMDIBuilderInsertDbgValueAtEnd, libllvm), LLVMValueRef, (LLVMDIBuilderRef, LLVMValueRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, LLVMBasicBlockRef), Builder, Val, VarInfo, Expr, DebugLoc, Block)
end

function LLVMDIBuilderCreateAutoVariable(Builder, Scope, Name, NameLen, File, LineNo, Ty, AlwaysPreserve, Flags, AlignInBits)
    ccall((:LLVMDIBuilderCreateAutoVariable, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, Cuint, LLVMMetadataRef, LLVMBool, LLVMDIFlags, UInt32), Builder, Scope, Name, NameLen, File, LineNo, Ty, AlwaysPreserve, Flags, AlignInBits)
end

function LLVMDIBuilderCreateParameterVariable(Builder, Scope, Name, NameLen, ArgNo, File, LineNo, Ty, AlwaysPreserve, Flags)
    ccall((:LLVMDIBuilderCreateParameterVariable, libllvm), LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, Cuint, LLVMMetadataRef, Cuint, LLVMMetadataRef, LLVMBool, LLVMDIFlags), Builder, Scope, Name, NameLen, ArgNo, File, LineNo, Ty, AlwaysPreserve, Flags)
end

function LLVMGetSubprogram(Func)
    ccall((:LLVMGetSubprogram, libllvm), LLVMMetadataRef, (LLVMValueRef,), Func)
end

function LLVMSetSubprogram(Func, SP)
    ccall((:LLVMSetSubprogram, libllvm), Cvoid, (LLVMValueRef, LLVMMetadataRef), Func, SP)
end

function LLVMDISubprogramGetLine(Subprogram)
    ccall((:LLVMDISubprogramGetLine, libllvm), Cuint, (LLVMMetadataRef,), Subprogram)
end

function LLVMInstructionGetDebugLoc(Inst)
    ccall((:LLVMInstructionGetDebugLoc, libllvm), LLVMMetadataRef, (LLVMValueRef,), Inst)
end

function LLVMInstructionSetDebugLoc(Inst, Loc)
    ccall((:LLVMInstructionSetDebugLoc, libllvm), Cvoid, (LLVMValueRef, LLVMMetadataRef), Inst, Loc)
end

function LLVMGetMetadataKind(Metadata)
    ccall((:LLVMGetMetadataKind, libllvm), LLVMMetadataKind, (LLVMMetadataRef,), Metadata)
end

# typedef int ( * LLVMOpInfoCallback ) ( void * DisInfo , uint64_t PC , uint64_t Offset , uint64_t Size , int TagType , void * TagBuf )
const LLVMOpInfoCallback = Ptr{Cvoid}

# typedef const char * ( * LLVMSymbolLookupCallback ) ( void * DisInfo , uint64_t ReferenceValue , uint64_t * ReferenceType , uint64_t ReferencePC , const char * * ReferenceName )
const LLVMSymbolLookupCallback = Ptr{Cvoid}

const LLVMDisasmContextRef = Ptr{Cvoid}

function LLVMCreateDisasm(TripleName, DisInfo, TagType, GetOpInfo, SymbolLookUp)
    ccall((:LLVMCreateDisasm, libllvm), LLVMDisasmContextRef, (Cstring, Ptr{Cvoid}, Cint, LLVMOpInfoCallback, LLVMSymbolLookupCallback), TripleName, DisInfo, TagType, GetOpInfo, SymbolLookUp)
end

function LLVMCreateDisasmCPU(Triple, CPU, DisInfo, TagType, GetOpInfo, SymbolLookUp)
    ccall((:LLVMCreateDisasmCPU, libllvm), LLVMDisasmContextRef, (Cstring, Cstring, Ptr{Cvoid}, Cint, LLVMOpInfoCallback, LLVMSymbolLookupCallback), Triple, CPU, DisInfo, TagType, GetOpInfo, SymbolLookUp)
end

function LLVMCreateDisasmCPUFeatures(Triple, CPU, Features, DisInfo, TagType, GetOpInfo, SymbolLookUp)
    ccall((:LLVMCreateDisasmCPUFeatures, libllvm), LLVMDisasmContextRef, (Cstring, Cstring, Cstring, Ptr{Cvoid}, Cint, LLVMOpInfoCallback, LLVMSymbolLookupCallback), Triple, CPU, Features, DisInfo, TagType, GetOpInfo, SymbolLookUp)
end

function LLVMSetDisasmOptions(DC, Options)
    ccall((:LLVMSetDisasmOptions, libllvm), Cint, (LLVMDisasmContextRef, UInt64), DC, Options)
end

function LLVMDisasmDispose(DC)
    ccall((:LLVMDisasmDispose, libllvm), Cvoid, (LLVMDisasmContextRef,), DC)
end

function LLVMDisasmInstruction(DC, Bytes, BytesSize, PC, OutString, OutStringSize)
    ccall((:LLVMDisasmInstruction, libllvm), Csize_t, (LLVMDisasmContextRef, Ptr{UInt8}, UInt64, UInt64, Cstring, Csize_t), DC, Bytes, BytesSize, PC, OutString, OutStringSize)
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

const LLVMErrorRef = Ptr{LLVMOpaqueError}

const LLVMErrorTypeId = Ptr{Cvoid}

function LLVMGetErrorTypeId(Err)
    ccall((:LLVMGetErrorTypeId, libllvm), LLVMErrorTypeId, (LLVMErrorRef,), Err)
end

function LLVMConsumeError(Err)
    ccall((:LLVMConsumeError, libllvm), Cvoid, (LLVMErrorRef,), Err)
end

function LLVMGetErrorMessage(Err)
    ccall((:LLVMGetErrorMessage, libllvm), Cstring, (LLVMErrorRef,), Err)
end

function LLVMDisposeErrorMessage(ErrMsg)
    ccall((:LLVMDisposeErrorMessage, libllvm), Cvoid, (Cstring,), ErrMsg)
end

function LLVMGetStringErrorTypeId()
    ccall((:LLVMGetStringErrorTypeId, libllvm), LLVMErrorTypeId, ())
end

function LLVMCreateStringError(ErrMsg)
    ccall((:LLVMCreateStringError, libllvm), LLVMErrorRef, (Cstring,), ErrMsg)
end

# typedef void ( * LLVMFatalErrorHandler ) ( const char * Reason )
const LLVMFatalErrorHandler = Ptr{Cvoid}

function LLVMInstallFatalErrorHandler(Handler)
    ccall((:LLVMInstallFatalErrorHandler, libllvm), Cvoid, (LLVMFatalErrorHandler,), Handler)
end

function LLVMResetFatalErrorHandler()
    ccall((:LLVMResetFatalErrorHandler, libllvm), Cvoid, ())
end

function LLVMEnablePrettyStackTrace()
    ccall((:LLVMEnablePrettyStackTrace, libllvm), Cvoid, ())
end

function LLVMLinkInMCJIT()
    ccall((:LLVMLinkInMCJIT, libllvm), Cvoid, ())
end

function LLVMLinkInInterpreter()
    ccall((:LLVMLinkInInterpreter, libllvm), Cvoid, ())
end

const LLVMGenericValueRef = Ptr{LLVMOpaqueGenericValue}

const LLVMExecutionEngineRef = Ptr{LLVMOpaqueExecutionEngine}

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
    ccall((:LLVMCreateGenericValueOfInt, libllvm), LLVMGenericValueRef, (LLVMTypeRef, Culonglong, LLVMBool), Ty, N, IsSigned)
end

function LLVMCreateGenericValueOfPointer(P)
    ccall((:LLVMCreateGenericValueOfPointer, libllvm), LLVMGenericValueRef, (Ptr{Cvoid},), P)
end

function LLVMCreateGenericValueOfFloat(Ty, N)
    ccall((:LLVMCreateGenericValueOfFloat, libllvm), LLVMGenericValueRef, (LLVMTypeRef, Cdouble), Ty, N)
end

function LLVMGenericValueIntWidth(GenValRef)
    ccall((:LLVMGenericValueIntWidth, libllvm), Cuint, (LLVMGenericValueRef,), GenValRef)
end

function LLVMGenericValueToInt(GenVal, IsSigned)
    ccall((:LLVMGenericValueToInt, libllvm), Culonglong, (LLVMGenericValueRef, LLVMBool), GenVal, IsSigned)
end

function LLVMGenericValueToPointer(GenVal)
    ccall((:LLVMGenericValueToPointer, libllvm), Ptr{Cvoid}, (LLVMGenericValueRef,), GenVal)
end

function LLVMGenericValueToFloat(TyRef, GenVal)
    ccall((:LLVMGenericValueToFloat, libllvm), Cdouble, (LLVMTypeRef, LLVMGenericValueRef), TyRef, GenVal)
end

function LLVMDisposeGenericValue(GenVal)
    ccall((:LLVMDisposeGenericValue, libllvm), Cvoid, (LLVMGenericValueRef,), GenVal)
end

function LLVMCreateExecutionEngineForModule(OutEE, M, OutError)
    ccall((:LLVMCreateExecutionEngineForModule, libllvm), LLVMBool, (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, Ptr{Cstring}), OutEE, M, OutError)
end

function LLVMCreateInterpreterForModule(OutInterp, M, OutError)
    ccall((:LLVMCreateInterpreterForModule, libllvm), LLVMBool, (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, Ptr{Cstring}), OutInterp, M, OutError)
end

function LLVMCreateJITCompilerForModule(OutJIT, M, OptLevel, OutError)
    ccall((:LLVMCreateJITCompilerForModule, libllvm), LLVMBool, (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, Cuint, Ptr{Cstring}), OutJIT, M, OptLevel, OutError)
end

function LLVMInitializeMCJITCompilerOptions(Options, SizeOfOptions)
    ccall((:LLVMInitializeMCJITCompilerOptions, libllvm), Cvoid, (Ptr{LLVMMCJITCompilerOptions}, Csize_t), Options, SizeOfOptions)
end

function LLVMCreateMCJITCompilerForModule(OutJIT, M, Options, SizeOfOptions, OutError)
    ccall((:LLVMCreateMCJITCompilerForModule, libllvm), LLVMBool, (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, Ptr{LLVMMCJITCompilerOptions}, Csize_t, Ptr{Cstring}), OutJIT, M, Options, SizeOfOptions, OutError)
end

function LLVMDisposeExecutionEngine(EE)
    ccall((:LLVMDisposeExecutionEngine, libllvm), Cvoid, (LLVMExecutionEngineRef,), EE)
end

function LLVMRunStaticConstructors(EE)
    ccall((:LLVMRunStaticConstructors, libllvm), Cvoid, (LLVMExecutionEngineRef,), EE)
end

function LLVMRunStaticDestructors(EE)
    ccall((:LLVMRunStaticDestructors, libllvm), Cvoid, (LLVMExecutionEngineRef,), EE)
end

function LLVMRunFunctionAsMain(EE, F, ArgC, ArgV, EnvP)
    ccall((:LLVMRunFunctionAsMain, libllvm), Cint, (LLVMExecutionEngineRef, LLVMValueRef, Cuint, Ptr{Cstring}, Ptr{Cstring}), EE, F, ArgC, ArgV, EnvP)
end

function LLVMRunFunction(EE, F, NumArgs, Args)
    ccall((:LLVMRunFunction, libllvm), LLVMGenericValueRef, (LLVMExecutionEngineRef, LLVMValueRef, Cuint, Ptr{LLVMGenericValueRef}), EE, F, NumArgs, Args)
end

function LLVMFreeMachineCodeForFunction(EE, F)
    ccall((:LLVMFreeMachineCodeForFunction, libllvm), Cvoid, (LLVMExecutionEngineRef, LLVMValueRef), EE, F)
end

function LLVMAddModule(EE, M)
    ccall((:LLVMAddModule, libllvm), Cvoid, (LLVMExecutionEngineRef, LLVMModuleRef), EE, M)
end

function LLVMRemoveModule(EE, M, OutMod, OutError)
    ccall((:LLVMRemoveModule, libllvm), LLVMBool, (LLVMExecutionEngineRef, LLVMModuleRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), EE, M, OutMod, OutError)
end

function LLVMFindFunction(EE, Name, OutFn)
    ccall((:LLVMFindFunction, libllvm), LLVMBool, (LLVMExecutionEngineRef, Cstring, Ptr{LLVMValueRef}), EE, Name, OutFn)
end

function LLVMRecompileAndRelinkFunction(EE, Fn)
    ccall((:LLVMRecompileAndRelinkFunction, libllvm), Ptr{Cvoid}, (LLVMExecutionEngineRef, LLVMValueRef), EE, Fn)
end

const LLVMTargetDataRef = Ptr{LLVMOpaqueTargetData}

function LLVMGetExecutionEngineTargetData(EE)
    ccall((:LLVMGetExecutionEngineTargetData, libllvm), LLVMTargetDataRef, (LLVMExecutionEngineRef,), EE)
end

const LLVMTargetMachineRef = Ptr{LLVMOpaqueTargetMachine}

function LLVMGetExecutionEngineTargetMachine(EE)
    ccall((:LLVMGetExecutionEngineTargetMachine, libllvm), LLVMTargetMachineRef, (LLVMExecutionEngineRef,), EE)
end

function LLVMAddGlobalMapping(EE, Global, Addr)
    ccall((:LLVMAddGlobalMapping, libllvm), Cvoid, (LLVMExecutionEngineRef, LLVMValueRef, Ptr{Cvoid}), EE, Global, Addr)
end

function LLVMGetPointerToGlobal(EE, Global)
    ccall((:LLVMGetPointerToGlobal, libllvm), Ptr{Cvoid}, (LLVMExecutionEngineRef, LLVMValueRef), EE, Global)
end

function LLVMGetGlobalValueAddress(EE, Name)
    ccall((:LLVMGetGlobalValueAddress, libllvm), UInt64, (LLVMExecutionEngineRef, Cstring), EE, Name)
end

function LLVMGetFunctionAddress(EE, Name)
    ccall((:LLVMGetFunctionAddress, libllvm), UInt64, (LLVMExecutionEngineRef, Cstring), EE, Name)
end

function LLVMExecutionEngineGetErrMsg(EE, OutError)
    ccall((:LLVMExecutionEngineGetErrMsg, libllvm), LLVMBool, (LLVMExecutionEngineRef, Ptr{Cstring}), EE, OutError)
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
    ccall((:LLVMCreateSimpleMCJITMemoryManager, libllvm), LLVMMCJITMemoryManagerRef, (Ptr{Cvoid}, LLVMMemoryManagerAllocateCodeSectionCallback, LLVMMemoryManagerAllocateDataSectionCallback, LLVMMemoryManagerFinalizeMemoryCallback, LLVMMemoryManagerDestroyCallback), Opaque, AllocateCodeSection, AllocateDataSection, FinalizeMemory, Destroy)
end

function LLVMDisposeMCJITMemoryManager(MM)
    ccall((:LLVMDisposeMCJITMemoryManager, libllvm), Cvoid, (LLVMMCJITMemoryManagerRef,), MM)
end

const LLVMJITEventListenerRef = Ptr{LLVMOpaqueJITEventListener}

function LLVMCreateGDBRegistrationListener()
    ccall((:LLVMCreateGDBRegistrationListener, libllvm), LLVMJITEventListenerRef, ())
end

function LLVMCreateIntelJITEventListener()
    ccall((:LLVMCreateIntelJITEventListener, libllvm), LLVMJITEventListenerRef, ())
end

function LLVMCreateOProfileJITEventListener()
    ccall((:LLVMCreateOProfileJITEventListener, libllvm), LLVMJITEventListenerRef, ())
end

function LLVMCreatePerfJITEventListener()
    ccall((:LLVMCreatePerfJITEventListener, libllvm), LLVMJITEventListenerRef, ())
end

function LLVMParseIRInContext(ContextRef, MemBuf, OutM, OutMessage)
    ccall((:LLVMParseIRInContext, libllvm), LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), ContextRef, MemBuf, OutM, OutMessage)
end

function LLVMInitializeTransformUtils(R)
    ccall((:LLVMInitializeTransformUtils, libllvm), Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeScalarOpts(R)
    ccall((:LLVMInitializeScalarOpts, libllvm), Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeObjCARCOpts(R)
    ccall((:LLVMInitializeObjCARCOpts, libllvm), Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeVectorization(R)
    ccall((:LLVMInitializeVectorization, libllvm), Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeInstCombine(R)
    ccall((:LLVMInitializeInstCombine, libllvm), Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeAggressiveInstCombiner(R)
    ccall((:LLVMInitializeAggressiveInstCombiner, libllvm), Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeIPO(R)
    ccall((:LLVMInitializeIPO, libllvm), Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeInstrumentation(R)
    ccall((:LLVMInitializeInstrumentation, libllvm), Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeAnalysis(R)
    ccall((:LLVMInitializeAnalysis, libllvm), Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeIPA(R)
    ccall((:LLVMInitializeIPA, libllvm), Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeCodeGen(R)
    ccall((:LLVMInitializeCodeGen, libllvm), Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeTarget(R)
    ccall((:LLVMInitializeTarget, libllvm), Cvoid, (LLVMPassRegistryRef,), R)
end

# typedef LLVMOrcObjectLayerRef ( * LLVMOrcLLJITBuilderObjectLinkingLayerCreatorFunction ) ( void * Ctx , LLVMOrcExecutionSessionRef ES , const char * Triple )
const LLVMOrcLLJITBuilderObjectLinkingLayerCreatorFunction = Ptr{Cvoid}

mutable struct LLVMOrcOpaqueLLJITBuilder end

const LLVMOrcLLJITBuilderRef = Ptr{LLVMOrcOpaqueLLJITBuilder}

mutable struct LLVMOrcOpaqueLLJIT end

const LLVMOrcLLJITRef = Ptr{LLVMOrcOpaqueLLJIT}

function LLVMOrcCreateLLJITBuilder()
    ccall((:LLVMOrcCreateLLJITBuilder, libllvm), LLVMOrcLLJITBuilderRef, ())
end

function LLVMOrcDisposeLLJITBuilder(Builder)
    ccall((:LLVMOrcDisposeLLJITBuilder, libllvm), Cvoid, (LLVMOrcLLJITBuilderRef,), Builder)
end

const LLVMOrcJITTargetMachineBuilderRef = Ptr{LLVMOrcOpaqueJITTargetMachineBuilder}

function LLVMOrcLLJITBuilderSetJITTargetMachineBuilder(Builder, JTMB)
    ccall((:LLVMOrcLLJITBuilderSetJITTargetMachineBuilder, libllvm), Cvoid, (LLVMOrcLLJITBuilderRef, LLVMOrcJITTargetMachineBuilderRef), Builder, JTMB)
end

function LLVMOrcLLJITBuilderSetObjectLinkingLayerCreator(Builder, F, Ctx)
    ccall((:LLVMOrcLLJITBuilderSetObjectLinkingLayerCreator, libllvm), Cvoid, (LLVMOrcLLJITBuilderRef, LLVMOrcLLJITBuilderObjectLinkingLayerCreatorFunction, Ptr{Cvoid}), Builder, F, Ctx)
end

function LLVMOrcCreateLLJIT(Result, Builder)
    ccall((:LLVMOrcCreateLLJIT, libllvm), LLVMErrorRef, (Ptr{LLVMOrcLLJITRef}, LLVMOrcLLJITBuilderRef), Result, Builder)
end

function LLVMOrcDisposeLLJIT(J)
    ccall((:LLVMOrcDisposeLLJIT, libllvm), LLVMErrorRef, (LLVMOrcLLJITRef,), J)
end

const LLVMOrcExecutionSessionRef = Ptr{LLVMOrcOpaqueExecutionSession}

function LLVMOrcLLJITGetExecutionSession(J)
    ccall((:LLVMOrcLLJITGetExecutionSession, libllvm), LLVMOrcExecutionSessionRef, (LLVMOrcLLJITRef,), J)
end

const LLVMOrcJITDylibRef = Ptr{LLVMOrcOpaqueJITDylib}

function LLVMOrcLLJITGetMainJITDylib(J)
    ccall((:LLVMOrcLLJITGetMainJITDylib, libllvm), LLVMOrcJITDylibRef, (LLVMOrcLLJITRef,), J)
end

function LLVMOrcLLJITGetTripleString(J)
    ccall((:LLVMOrcLLJITGetTripleString, libllvm), Cstring, (LLVMOrcLLJITRef,), J)
end

function LLVMOrcLLJITGetGlobalPrefix(J)
    ccall((:LLVMOrcLLJITGetGlobalPrefix, libllvm), Cchar, (LLVMOrcLLJITRef,), J)
end

const LLVMOrcSymbolStringPoolEntryRef = Ptr{LLVMOrcOpaqueSymbolStringPoolEntry}

function LLVMOrcLLJITMangleAndIntern(J, UnmangledName)
    ccall((:LLVMOrcLLJITMangleAndIntern, libllvm), LLVMOrcSymbolStringPoolEntryRef, (LLVMOrcLLJITRef, Cstring), J, UnmangledName)
end

function LLVMOrcLLJITAddObjectFile(J, JD, ObjBuffer)
    ccall((:LLVMOrcLLJITAddObjectFile, libllvm), LLVMErrorRef, (LLVMOrcLLJITRef, LLVMOrcJITDylibRef, LLVMMemoryBufferRef), J, JD, ObjBuffer)
end

const LLVMOrcResourceTrackerRef = Ptr{LLVMOrcOpaqueResourceTracker}

function LLVMOrcLLJITAddObjectFileWithRT(J, RT, ObjBuffer)
    ccall((:LLVMOrcLLJITAddObjectFileWithRT, libllvm), LLVMErrorRef, (LLVMOrcLLJITRef, LLVMOrcResourceTrackerRef, LLVMMemoryBufferRef), J, RT, ObjBuffer)
end

const LLVMOrcThreadSafeModuleRef = Ptr{LLVMOrcOpaqueThreadSafeModule}

function LLVMOrcLLJITAddLLVMIRModule(J, JD, TSM)
    ccall((:LLVMOrcLLJITAddLLVMIRModule, libllvm), LLVMErrorRef, (LLVMOrcLLJITRef, LLVMOrcJITDylibRef, LLVMOrcThreadSafeModuleRef), J, JD, TSM)
end

function LLVMOrcLLJITAddLLVMIRModuleWithRT(J, JD, TSM)
    ccall((:LLVMOrcLLJITAddLLVMIRModuleWithRT, libllvm), LLVMErrorRef, (LLVMOrcLLJITRef, LLVMOrcResourceTrackerRef, LLVMOrcThreadSafeModuleRef), J, JD, TSM)
end

const LLVMOrcExecutorAddress = UInt64

function LLVMOrcLLJITLookup(J, Result, Name)
    ccall((:LLVMOrcLLJITLookup, libllvm), LLVMErrorRef, (LLVMOrcLLJITRef, Ptr{LLVMOrcExecutorAddress}, Cstring), J, Result, Name)
end

const LLVMOrcObjectLayerRef = Ptr{LLVMOrcOpaqueObjectLayer}

function LLVMOrcLLJITGetObjLinkingLayer(J)
    ccall((:LLVMOrcLLJITGetObjLinkingLayer, libllvm), LLVMOrcObjectLayerRef, (LLVMOrcLLJITRef,), J)
end

const LLVMOrcObjectTransformLayerRef = Ptr{LLVMOrcOpaqueObjectTransformLayer}

function LLVMOrcLLJITGetObjTransformLayer(J)
    ccall((:LLVMOrcLLJITGetObjTransformLayer, libllvm), LLVMOrcObjectTransformLayerRef, (LLVMOrcLLJITRef,), J)
end

const LLVMOrcIRTransformLayerRef = Ptr{LLVMOrcOpaqueIRTransformLayer}

function LLVMOrcLLJITGetIRTransformLayer(J)
    ccall((:LLVMOrcLLJITGetIRTransformLayer, libllvm), LLVMOrcIRTransformLayerRef, (LLVMOrcLLJITRef,), J)
end

function LLVMOrcLLJITGetDataLayoutStr(J)
    ccall((:LLVMOrcLLJITGetDataLayoutStr, libllvm), Cstring, (LLVMOrcLLJITRef,), J)
end

@cenum LLVMLinkerMode::UInt32 begin
    LLVMLinkerDestroySource = 0
    LLVMLinkerPreserveSource_Removed = 1
end

function LLVMLinkModules2(Dest, Src)
    ccall((:LLVMLinkModules2, libllvm), LLVMBool, (LLVMModuleRef, LLVMModuleRef), Dest, Src)
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

const LLVMBinaryRef = Ptr{LLVMOpaqueBinary}

function LLVMCreateBinary(MemBuf, Context, ErrorMessage)
    ccall((:LLVMCreateBinary, libllvm), LLVMBinaryRef, (LLVMMemoryBufferRef, LLVMContextRef, Ptr{Cstring}), MemBuf, Context, ErrorMessage)
end

function LLVMDisposeBinary(BR)
    ccall((:LLVMDisposeBinary, libllvm), Cvoid, (LLVMBinaryRef,), BR)
end

function LLVMBinaryCopyMemoryBuffer(BR)
    ccall((:LLVMBinaryCopyMemoryBuffer, libllvm), LLVMMemoryBufferRef, (LLVMBinaryRef,), BR)
end

function LLVMBinaryGetType(BR)
    ccall((:LLVMBinaryGetType, libllvm), LLVMBinaryType, (LLVMBinaryRef,), BR)
end

function LLVMMachOUniversalBinaryCopyObjectForArch(BR, Arch, ArchLen, ErrorMessage)
    ccall((:LLVMMachOUniversalBinaryCopyObjectForArch, libllvm), LLVMBinaryRef, (LLVMBinaryRef, Cstring, Csize_t, Ptr{Cstring}), BR, Arch, ArchLen, ErrorMessage)
end

function LLVMObjectFileCopySectionIterator(BR)
    ccall((:LLVMObjectFileCopySectionIterator, libllvm), LLVMSectionIteratorRef, (LLVMBinaryRef,), BR)
end

function LLVMObjectFileIsSectionIteratorAtEnd(BR, SI)
    ccall((:LLVMObjectFileIsSectionIteratorAtEnd, libllvm), LLVMBool, (LLVMBinaryRef, LLVMSectionIteratorRef), BR, SI)
end

function LLVMObjectFileCopySymbolIterator(BR)
    ccall((:LLVMObjectFileCopySymbolIterator, libllvm), LLVMSymbolIteratorRef, (LLVMBinaryRef,), BR)
end

function LLVMObjectFileIsSymbolIteratorAtEnd(BR, SI)
    ccall((:LLVMObjectFileIsSymbolIteratorAtEnd, libllvm), LLVMBool, (LLVMBinaryRef, LLVMSymbolIteratorRef), BR, SI)
end

function LLVMDisposeSectionIterator(SI)
    ccall((:LLVMDisposeSectionIterator, libllvm), Cvoid, (LLVMSectionIteratorRef,), SI)
end

function LLVMMoveToNextSection(SI)
    ccall((:LLVMMoveToNextSection, libllvm), Cvoid, (LLVMSectionIteratorRef,), SI)
end

function LLVMMoveToContainingSection(Sect, Sym)
    ccall((:LLVMMoveToContainingSection, libllvm), Cvoid, (LLVMSectionIteratorRef, LLVMSymbolIteratorRef), Sect, Sym)
end

function LLVMDisposeSymbolIterator(SI)
    ccall((:LLVMDisposeSymbolIterator, libllvm), Cvoid, (LLVMSymbolIteratorRef,), SI)
end

function LLVMMoveToNextSymbol(SI)
    ccall((:LLVMMoveToNextSymbol, libllvm), Cvoid, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetSectionName(SI)
    ccall((:LLVMGetSectionName, libllvm), Cstring, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionSize(SI)
    ccall((:LLVMGetSectionSize, libllvm), UInt64, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionContents(SI)
    ccall((:LLVMGetSectionContents, libllvm), Cstring, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionAddress(SI)
    ccall((:LLVMGetSectionAddress, libllvm), UInt64, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionContainsSymbol(SI, Sym)
    ccall((:LLVMGetSectionContainsSymbol, libllvm), LLVMBool, (LLVMSectionIteratorRef, LLVMSymbolIteratorRef), SI, Sym)
end

function LLVMGetRelocations(Section)
    ccall((:LLVMGetRelocations, libllvm), LLVMRelocationIteratorRef, (LLVMSectionIteratorRef,), Section)
end

function LLVMDisposeRelocationIterator(RI)
    ccall((:LLVMDisposeRelocationIterator, libllvm), Cvoid, (LLVMRelocationIteratorRef,), RI)
end

function LLVMIsRelocationIteratorAtEnd(Section, RI)
    ccall((:LLVMIsRelocationIteratorAtEnd, libllvm), LLVMBool, (LLVMSectionIteratorRef, LLVMRelocationIteratorRef), Section, RI)
end

function LLVMMoveToNextRelocation(RI)
    ccall((:LLVMMoveToNextRelocation, libllvm), Cvoid, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetSymbolName(SI)
    ccall((:LLVMGetSymbolName, libllvm), Cstring, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetSymbolAddress(SI)
    ccall((:LLVMGetSymbolAddress, libllvm), UInt64, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetSymbolSize(SI)
    ccall((:LLVMGetSymbolSize, libllvm), UInt64, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetRelocationOffset(RI)
    ccall((:LLVMGetRelocationOffset, libllvm), UInt64, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationSymbol(RI)
    ccall((:LLVMGetRelocationSymbol, libllvm), LLVMSymbolIteratorRef, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationType(RI)
    ccall((:LLVMGetRelocationType, libllvm), UInt64, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationTypeName(RI)
    ccall((:LLVMGetRelocationTypeName, libllvm), Cstring, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationValueString(RI)
    ccall((:LLVMGetRelocationValueString, libllvm), Cstring, (LLVMRelocationIteratorRef,), RI)
end

mutable struct LLVMOpaqueObjectFile end

const LLVMObjectFileRef = Ptr{LLVMOpaqueObjectFile}

function LLVMCreateObjectFile(MemBuf)
    ccall((:LLVMCreateObjectFile, libllvm), LLVMObjectFileRef, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMDisposeObjectFile(ObjectFile)
    ccall((:LLVMDisposeObjectFile, libllvm), Cvoid, (LLVMObjectFileRef,), ObjectFile)
end

function LLVMGetSections(ObjectFile)
    ccall((:LLVMGetSections, libllvm), LLVMSectionIteratorRef, (LLVMObjectFileRef,), ObjectFile)
end

function LLVMIsSectionIteratorAtEnd(ObjectFile, SI)
    ccall((:LLVMIsSectionIteratorAtEnd, libllvm), LLVMBool, (LLVMObjectFileRef, LLVMSectionIteratorRef), ObjectFile, SI)
end

function LLVMGetSymbols(ObjectFile)
    ccall((:LLVMGetSymbols, libllvm), LLVMSymbolIteratorRef, (LLVMObjectFileRef,), ObjectFile)
end

function LLVMIsSymbolIteratorAtEnd(ObjectFile, SI)
    ccall((:LLVMIsSymbolIteratorAtEnd, libllvm), LLVMBool, (LLVMObjectFileRef, LLVMSymbolIteratorRef), ObjectFile, SI)
end

const LLVMOrcJITTargetAddress = UInt64

@cenum LLVMJITSymbolGenericFlags::UInt32 begin
    LLVMJITSymbolGenericFlagsExported = 1
    LLVMJITSymbolGenericFlagsWeak = 2
    LLVMJITSymbolGenericFlagsCallable = 4
    LLVMJITSymbolGenericFlagsMaterializationSideEffectsOnly = 8
end

const LLVMJITSymbolTargetFlags = UInt8

struct LLVMJITSymbolFlags
    GenericFlags::UInt8
    TargetFlags::UInt8
end

struct LLVMJITEvaluatedSymbol
    Address::LLVMOrcExecutorAddress
    Flags::LLVMJITSymbolFlags
end

# typedef void ( * LLVMOrcErrorReporterFunction ) ( void * Ctx , LLVMErrorRef Err )
const LLVMOrcErrorReporterFunction = Ptr{Cvoid}

const LLVMOrcSymbolStringPoolRef = Ptr{LLVMOrcOpaqueSymbolStringPool}

struct LLVMOrcCSymbolFlagsMapPair
    Name::LLVMOrcSymbolStringPoolEntryRef
    Flags::LLVMJITSymbolFlags
end

const LLVMOrcCSymbolFlagsMapPairs = Ptr{LLVMOrcCSymbolFlagsMapPair}

struct LLVMJITCSymbolMapPair
    Name::LLVMOrcSymbolStringPoolEntryRef
    Sym::LLVMJITEvaluatedSymbol
end

const LLVMOrcCSymbolMapPairs = Ptr{LLVMJITCSymbolMapPair}

struct LLVMOrcCSymbolAliasMapEntry
    Name::LLVMOrcSymbolStringPoolEntryRef
    Flags::LLVMJITSymbolFlags
end

struct LLVMOrcCSymbolAliasMapPair
    Name::LLVMOrcSymbolStringPoolEntryRef
    Entry::LLVMOrcCSymbolAliasMapEntry
end

const LLVMOrcCSymbolAliasMapPairs = Ptr{LLVMOrcCSymbolAliasMapPair}

struct LLVMOrcCSymbolsList
    Symbols::Ptr{LLVMOrcSymbolStringPoolEntryRef}
    Length::Csize_t
end

struct LLVMOrcCDependenceMapPair
    JD::LLVMOrcJITDylibRef
    Names::LLVMOrcCSymbolsList
end

const LLVMOrcCDependenceMapPairs = Ptr{LLVMOrcCDependenceMapPair}

@cenum LLVMOrcLookupKind::UInt32 begin
    LLVMOrcLookupKindStatic = 0
    LLVMOrcLookupKindDLSym = 1
end

@cenum LLVMOrcJITDylibLookupFlags::UInt32 begin
    LLVMOrcJITDylibLookupFlagsMatchExportedSymbolsOnly = 0
    LLVMOrcJITDylibLookupFlagsMatchAllSymbols = 1
end

@cenum LLVMOrcSymbolLookupFlags::UInt32 begin
    LLVMOrcSymbolLookupFlagsRequiredSymbol = 0
    LLVMOrcSymbolLookupFlagsWeaklyReferencedSymbol = 1
end

struct LLVMOrcCLookupSetElement
    Name::LLVMOrcSymbolStringPoolEntryRef
    LookupFlags::LLVMOrcSymbolLookupFlags
end

const LLVMOrcCLookupSet = Ptr{LLVMOrcCLookupSetElement}

const LLVMOrcMaterializationUnitRef = Ptr{LLVMOrcOpaqueMaterializationUnit}

const LLVMOrcMaterializationResponsibilityRef = Ptr{LLVMOrcOpaqueMaterializationResponsibility}

# typedef void ( * LLVMOrcMaterializationUnitMaterializeFunction ) ( void * Ctx , LLVMOrcMaterializationResponsibilityRef MR )
const LLVMOrcMaterializationUnitMaterializeFunction = Ptr{Cvoid}

# typedef void ( * LLVMOrcMaterializationUnitDiscardFunction ) ( void * Ctx , LLVMOrcJITDylibRef JD , LLVMOrcSymbolStringPoolEntryRef Symbol )
const LLVMOrcMaterializationUnitDiscardFunction = Ptr{Cvoid}

# typedef void ( * LLVMOrcMaterializationUnitDestroyFunction ) ( void * Ctx )
const LLVMOrcMaterializationUnitDestroyFunction = Ptr{Cvoid}

const LLVMOrcDefinitionGeneratorRef = Ptr{LLVMOrcOpaqueDefinitionGenerator}

const LLVMOrcLookupStateRef = Ptr{LLVMOrcOpaqueLookupState}

# typedef LLVMErrorRef ( * LLVMOrcCAPIDefinitionGeneratorTryToGenerateFunction ) ( LLVMOrcDefinitionGeneratorRef GeneratorObj , void * Ctx , LLVMOrcLookupStateRef * LookupState , LLVMOrcLookupKind Kind , LLVMOrcJITDylibRef JD , LLVMOrcJITDylibLookupFlags JDLookupFlags , LLVMOrcCLookupSet LookupSet , size_t LookupSetSize )
const LLVMOrcCAPIDefinitionGeneratorTryToGenerateFunction = Ptr{Cvoid}

# typedef int ( * LLVMOrcSymbolPredicate ) ( void * Ctx , LLVMOrcSymbolStringPoolEntryRef Sym )
const LLVMOrcSymbolPredicate = Ptr{Cvoid}

const LLVMOrcThreadSafeContextRef = Ptr{LLVMOrcOpaqueThreadSafeContext}

# typedef LLVMErrorRef ( * LLVMOrcGenericIRModuleOperationFunction ) ( void * Ctx , LLVMModuleRef M )
const LLVMOrcGenericIRModuleOperationFunction = Ptr{Cvoid}

const LLVMOrcObjectLinkingLayerRef = Ptr{LLVMOrcOpaqueObjectLinkingLayer}

# typedef LLVMErrorRef ( * LLVMOrcIRTransformLayerTransformFunction ) ( void * Ctx , LLVMOrcThreadSafeModuleRef * ModInOut , LLVMOrcMaterializationResponsibilityRef MR )
const LLVMOrcIRTransformLayerTransformFunction = Ptr{Cvoid}

# typedef LLVMErrorRef ( * LLVMOrcObjectTransformLayerTransformFunction ) ( void * Ctx , LLVMMemoryBufferRef * ObjInOut )
const LLVMOrcObjectTransformLayerTransformFunction = Ptr{Cvoid}

const LLVMOrcIndirectStubsManagerRef = Ptr{LLVMOrcOpaqueIndirectStubsManager}

const LLVMOrcLazyCallThroughManagerRef = Ptr{LLVMOrcOpaqueLazyCallThroughManager}

const LLVMOrcDumpObjectsRef = Ptr{LLVMOrcOpaqueDumpObjects}

function LLVMOrcExecutionSessionSetErrorReporter(ES, ReportError, Ctx)
    ccall((:LLVMOrcExecutionSessionSetErrorReporter, libllvm), Cvoid, (LLVMOrcExecutionSessionRef, LLVMOrcErrorReporterFunction, Ptr{Cvoid}), ES, ReportError, Ctx)
end

function LLVMOrcExecutionSessionGetSymbolStringPool(ES)
    ccall((:LLVMOrcExecutionSessionGetSymbolStringPool, libllvm), LLVMOrcSymbolStringPoolRef, (LLVMOrcExecutionSessionRef,), ES)
end

function LLVMOrcSymbolStringPoolClearDeadEntries(SSP)
    ccall((:LLVMOrcSymbolStringPoolClearDeadEntries, libllvm), Cvoid, (LLVMOrcSymbolStringPoolRef,), SSP)
end

function LLVMOrcExecutionSessionIntern(ES, Name)
    ccall((:LLVMOrcExecutionSessionIntern, libllvm), LLVMOrcSymbolStringPoolEntryRef, (LLVMOrcExecutionSessionRef, Cstring), ES, Name)
end

function LLVMOrcRetainSymbolStringPoolEntry(S)
    ccall((:LLVMOrcRetainSymbolStringPoolEntry, libllvm), Cvoid, (LLVMOrcSymbolStringPoolEntryRef,), S)
end

function LLVMOrcReleaseSymbolStringPoolEntry(S)
    ccall((:LLVMOrcReleaseSymbolStringPoolEntry, libllvm), Cvoid, (LLVMOrcSymbolStringPoolEntryRef,), S)
end

function LLVMOrcSymbolStringPoolEntryStr(S)
    ccall((:LLVMOrcSymbolStringPoolEntryStr, libllvm), Cstring, (LLVMOrcSymbolStringPoolEntryRef,), S)
end

function LLVMOrcReleaseResourceTracker(RT)
    ccall((:LLVMOrcReleaseResourceTracker, libllvm), Cvoid, (LLVMOrcResourceTrackerRef,), RT)
end

function LLVMOrcResourceTrackerTransferTo(SrcRT, DstRT)
    ccall((:LLVMOrcResourceTrackerTransferTo, libllvm), Cvoid, (LLVMOrcResourceTrackerRef, LLVMOrcResourceTrackerRef), SrcRT, DstRT)
end

function LLVMOrcResourceTrackerRemove(RT)
    ccall((:LLVMOrcResourceTrackerRemove, libllvm), LLVMErrorRef, (LLVMOrcResourceTrackerRef,), RT)
end

function LLVMOrcDisposeDefinitionGenerator(DG)
    ccall((:LLVMOrcDisposeDefinitionGenerator, libllvm), Cvoid, (LLVMOrcDefinitionGeneratorRef,), DG)
end

function LLVMOrcDisposeMaterializationUnit(MU)
    ccall((:LLVMOrcDisposeMaterializationUnit, libllvm), Cvoid, (LLVMOrcMaterializationUnitRef,), MU)
end

function LLVMOrcCreateCustomMaterializationUnit(Name, Ctx, Syms, NumSyms, InitSym, Materialize, Discard, Destroy)
    ccall((:LLVMOrcCreateCustomMaterializationUnit, libllvm), LLVMOrcMaterializationUnitRef, (Cstring, Ptr{Cvoid}, LLVMOrcCSymbolFlagsMapPairs, Csize_t, LLVMOrcSymbolStringPoolEntryRef, LLVMOrcMaterializationUnitMaterializeFunction, LLVMOrcMaterializationUnitDiscardFunction, LLVMOrcMaterializationUnitDestroyFunction), Name, Ctx, Syms, NumSyms, InitSym, Materialize, Discard, Destroy)
end

function LLVMOrcAbsoluteSymbols(Syms, NumPairs)
    ccall((:LLVMOrcAbsoluteSymbols, libllvm), LLVMOrcMaterializationUnitRef, (LLVMOrcCSymbolMapPairs, Csize_t), Syms, NumPairs)
end

function LLVMOrcLazyReexports(LCTM, ISM, SourceRef, CallableAliases, NumPairs)
    ccall((:LLVMOrcLazyReexports, libllvm), LLVMOrcMaterializationUnitRef, (LLVMOrcLazyCallThroughManagerRef, LLVMOrcIndirectStubsManagerRef, LLVMOrcJITDylibRef, LLVMOrcCSymbolAliasMapPairs, Csize_t), LCTM, ISM, SourceRef, CallableAliases, NumPairs)
end

function LLVMOrcDisposeMaterializationResponsibility(MR)
    ccall((:LLVMOrcDisposeMaterializationResponsibility, libllvm), Cvoid, (LLVMOrcMaterializationResponsibilityRef,), MR)
end

function LLVMOrcMaterializationResponsibilityGetTargetDylib(MR)
    ccall((:LLVMOrcMaterializationResponsibilityGetTargetDylib, libllvm), LLVMOrcJITDylibRef, (LLVMOrcMaterializationResponsibilityRef,), MR)
end

function LLVMOrcMaterializationResponsibilityGetExecutionSession(MR)
    ccall((:LLVMOrcMaterializationResponsibilityGetExecutionSession, libllvm), LLVMOrcExecutionSessionRef, (LLVMOrcMaterializationResponsibilityRef,), MR)
end

function LLVMOrcMaterializationResponsibilityGetSymbols(MR, NumPairs)
    ccall((:LLVMOrcMaterializationResponsibilityGetSymbols, libllvm), LLVMOrcCSymbolFlagsMapPairs, (LLVMOrcMaterializationResponsibilityRef, Ptr{Csize_t}), MR, NumPairs)
end

function LLVMOrcDisposeCSymbolFlagsMap(Pairs)
    ccall((:LLVMOrcDisposeCSymbolFlagsMap, libllvm), Cvoid, (LLVMOrcCSymbolFlagsMapPairs,), Pairs)
end

function LLVMOrcMaterializationResponsibilityGetInitializerSymbol(MR)
    ccall((:LLVMOrcMaterializationResponsibilityGetInitializerSymbol, libllvm), LLVMOrcSymbolStringPoolEntryRef, (LLVMOrcMaterializationResponsibilityRef,), MR)
end

function LLVMOrcMaterializationResponsibilityGetRequestedSymbols(MR, NumSymbols)
    ccall((:LLVMOrcMaterializationResponsibilityGetRequestedSymbols, libllvm), Ptr{LLVMOrcSymbolStringPoolEntryRef}, (LLVMOrcMaterializationResponsibilityRef, Ptr{Csize_t}), MR, NumSymbols)
end

function LLVMOrcDisposeSymbols(Symbols)
    ccall((:LLVMOrcDisposeSymbols, libllvm), Cvoid, (Ptr{LLVMOrcSymbolStringPoolEntryRef},), Symbols)
end

function LLVMOrcMaterializationResponsibilityNotifyResolved(MR, Symbols, NumPairs)
    ccall((:LLVMOrcMaterializationResponsibilityNotifyResolved, libllvm), LLVMErrorRef, (LLVMOrcMaterializationResponsibilityRef, LLVMOrcCSymbolMapPairs, Csize_t), MR, Symbols, NumPairs)
end

function LLVMOrcMaterializationResponsibilityNotifyEmitted(MR)
    ccall((:LLVMOrcMaterializationResponsibilityNotifyEmitted, libllvm), LLVMErrorRef, (LLVMOrcMaterializationResponsibilityRef,), MR)
end

function LLVMOrcMaterializationResponsibilityDefineMaterializing(MR, Pairs, NumPairs)
    ccall((:LLVMOrcMaterializationResponsibilityDefineMaterializing, libllvm), LLVMErrorRef, (LLVMOrcMaterializationResponsibilityRef, LLVMOrcCSymbolFlagsMapPairs, Csize_t), MR, Pairs, NumPairs)
end

function LLVMOrcMaterializationResponsibilityFailMaterialization(MR)
    ccall((:LLVMOrcMaterializationResponsibilityFailMaterialization, libllvm), Cvoid, (LLVMOrcMaterializationResponsibilityRef,), MR)
end

function LLVMOrcMaterializationResponsibilityReplace(MR, MU)
    ccall((:LLVMOrcMaterializationResponsibilityReplace, libllvm), LLVMErrorRef, (LLVMOrcMaterializationResponsibilityRef, LLVMOrcMaterializationUnitRef), MR, MU)
end

function LLVMOrcMaterializationResponsibilityDelegate(MR, Symbols, NumSymbols, Result)
    ccall((:LLVMOrcMaterializationResponsibilityDelegate, libllvm), LLVMErrorRef, (LLVMOrcMaterializationResponsibilityRef, Ptr{LLVMOrcSymbolStringPoolEntryRef}, Csize_t, Ptr{LLVMOrcMaterializationResponsibilityRef}), MR, Symbols, NumSymbols, Result)
end

function LLVMOrcMaterializationResponsibilityAddDependencies(MR, Name, Dependencies, NumPairs)
    ccall((:LLVMOrcMaterializationResponsibilityAddDependencies, libllvm), Cvoid, (LLVMOrcMaterializationResponsibilityRef, LLVMOrcSymbolStringPoolEntryRef, LLVMOrcCDependenceMapPairs, Csize_t), MR, Name, Dependencies, NumPairs)
end

function LLVMOrcMaterializationResponsibilityAddDependenciesForAll(MR, Dependencies, NumPairs)
    ccall((:LLVMOrcMaterializationResponsibilityAddDependenciesForAll, libllvm), Cvoid, (LLVMOrcMaterializationResponsibilityRef, LLVMOrcCDependenceMapPairs, Csize_t), MR, Dependencies, NumPairs)
end

function LLVMOrcExecutionSessionCreateBareJITDylib(ES, Name)
    ccall((:LLVMOrcExecutionSessionCreateBareJITDylib, libllvm), LLVMOrcJITDylibRef, (LLVMOrcExecutionSessionRef, Cstring), ES, Name)
end

function LLVMOrcExecutionSessionCreateJITDylib(ES, Result, Name)
    ccall((:LLVMOrcExecutionSessionCreateJITDylib, libllvm), LLVMErrorRef, (LLVMOrcExecutionSessionRef, Ptr{LLVMOrcJITDylibRef}, Cstring), ES, Result, Name)
end

function LLVMOrcExecutionSessionGetJITDylibByName(ES, Name)
    ccall((:LLVMOrcExecutionSessionGetJITDylibByName, libllvm), LLVMOrcJITDylibRef, (LLVMOrcExecutionSessionRef, Cstring), ES, Name)
end

function LLVMOrcJITDylibCreateResourceTracker(JD)
    ccall((:LLVMOrcJITDylibCreateResourceTracker, libllvm), LLVMOrcResourceTrackerRef, (LLVMOrcJITDylibRef,), JD)
end

function LLVMOrcJITDylibGetDefaultResourceTracker(JD)
    ccall((:LLVMOrcJITDylibGetDefaultResourceTracker, libllvm), LLVMOrcResourceTrackerRef, (LLVMOrcJITDylibRef,), JD)
end

function LLVMOrcJITDylibDefine(JD, MU)
    ccall((:LLVMOrcJITDylibDefine, libllvm), LLVMErrorRef, (LLVMOrcJITDylibRef, LLVMOrcMaterializationUnitRef), JD, MU)
end

function LLVMOrcJITDylibClear(JD)
    ccall((:LLVMOrcJITDylibClear, libllvm), LLVMErrorRef, (LLVMOrcJITDylibRef,), JD)
end

function LLVMOrcJITDylibAddGenerator(JD, DG)
    ccall((:LLVMOrcJITDylibAddGenerator, libllvm), Cvoid, (LLVMOrcJITDylibRef, LLVMOrcDefinitionGeneratorRef), JD, DG)
end

function LLVMOrcCreateCustomCAPIDefinitionGenerator(F, Ctx)
    ccall((:LLVMOrcCreateCustomCAPIDefinitionGenerator, libllvm), LLVMOrcDefinitionGeneratorRef, (LLVMOrcCAPIDefinitionGeneratorTryToGenerateFunction, Ptr{Cvoid}), F, Ctx)
end

function LLVMOrcCreateDynamicLibrarySearchGeneratorForProcess(Result, GlobalPrefx, Filter, FilterCtx)
    ccall((:LLVMOrcCreateDynamicLibrarySearchGeneratorForProcess, libllvm), LLVMErrorRef, (Ptr{LLVMOrcDefinitionGeneratorRef}, Cchar, LLVMOrcSymbolPredicate, Ptr{Cvoid}), Result, GlobalPrefx, Filter, FilterCtx)
end

function LLVMOrcCreateDynamicLibrarySearchGeneratorForPath(Result, FileName, GlobalPrefix, Filter, FilterCtx)
    ccall((:LLVMOrcCreateDynamicLibrarySearchGeneratorForPath, libllvm), LLVMErrorRef, (Ptr{LLVMOrcDefinitionGeneratorRef}, Cstring, Cchar, LLVMOrcSymbolPredicate, Ptr{Cvoid}), Result, FileName, GlobalPrefix, Filter, FilterCtx)
end

function LLVMOrcCreateStaticLibrarySearchGeneratorForPath(Result, ObjLayer, FileName, TargetTriple)
    ccall((:LLVMOrcCreateStaticLibrarySearchGeneratorForPath, libllvm), LLVMErrorRef, (Ptr{LLVMOrcDefinitionGeneratorRef}, LLVMOrcObjectLayerRef, Cstring, Cstring), Result, ObjLayer, FileName, TargetTriple)
end

function LLVMOrcCreateNewThreadSafeContext()
    ccall((:LLVMOrcCreateNewThreadSafeContext, libllvm), LLVMOrcThreadSafeContextRef, ())
end

function LLVMOrcThreadSafeContextGetContext(TSCtx)
    ccall((:LLVMOrcThreadSafeContextGetContext, libllvm), LLVMContextRef, (LLVMOrcThreadSafeContextRef,), TSCtx)
end

function LLVMOrcDisposeThreadSafeContext(TSCtx)
    ccall((:LLVMOrcDisposeThreadSafeContext, libllvm), Cvoid, (LLVMOrcThreadSafeContextRef,), TSCtx)
end

function LLVMOrcCreateNewThreadSafeModule(M, TSCtx)
    ccall((:LLVMOrcCreateNewThreadSafeModule, libllvm), LLVMOrcThreadSafeModuleRef, (LLVMModuleRef, LLVMOrcThreadSafeContextRef), M, TSCtx)
end

function LLVMOrcDisposeThreadSafeModule(TSM)
    ccall((:LLVMOrcDisposeThreadSafeModule, libllvm), Cvoid, (LLVMOrcThreadSafeModuleRef,), TSM)
end

function LLVMOrcThreadSafeModuleWithModuleDo(TSM, F, Ctx)
    ccall((:LLVMOrcThreadSafeModuleWithModuleDo, libllvm), LLVMErrorRef, (LLVMOrcThreadSafeModuleRef, LLVMOrcGenericIRModuleOperationFunction, Ptr{Cvoid}), TSM, F, Ctx)
end

function LLVMOrcJITTargetMachineBuilderDetectHost(Result)
    ccall((:LLVMOrcJITTargetMachineBuilderDetectHost, libllvm), LLVMErrorRef, (Ptr{LLVMOrcJITTargetMachineBuilderRef},), Result)
end

function LLVMOrcJITTargetMachineBuilderCreateFromTargetMachine(TM)
    ccall((:LLVMOrcJITTargetMachineBuilderCreateFromTargetMachine, libllvm), LLVMOrcJITTargetMachineBuilderRef, (LLVMTargetMachineRef,), TM)
end

function LLVMOrcDisposeJITTargetMachineBuilder(JTMB)
    ccall((:LLVMOrcDisposeJITTargetMachineBuilder, libllvm), Cvoid, (LLVMOrcJITTargetMachineBuilderRef,), JTMB)
end

function LLVMOrcJITTargetMachineBuilderGetTargetTriple(JTMB)
    ccall((:LLVMOrcJITTargetMachineBuilderGetTargetTriple, libllvm), Cstring, (LLVMOrcJITTargetMachineBuilderRef,), JTMB)
end

function LLVMOrcJITTargetMachineBuilderSetTargetTriple(JTMB, TargetTriple)
    ccall((:LLVMOrcJITTargetMachineBuilderSetTargetTriple, libllvm), Cvoid, (LLVMOrcJITTargetMachineBuilderRef, Cstring), JTMB, TargetTriple)
end

function LLVMOrcObjectLayerAddObjectFile(ObjLayer, JD, ObjBuffer)
    ccall((:LLVMOrcObjectLayerAddObjectFile, libllvm), LLVMErrorRef, (LLVMOrcObjectLayerRef, LLVMOrcJITDylibRef, LLVMMemoryBufferRef), ObjLayer, JD, ObjBuffer)
end

function LLVMOrcObjectLayerAddObjectFileWithRT(ObjLayer, RT, ObjBuffer)
    ccall((:LLVMOrcObjectLayerAddObjectFileWithRT, libllvm), LLVMErrorRef, (LLVMOrcObjectLayerRef, LLVMOrcResourceTrackerRef, LLVMMemoryBufferRef), ObjLayer, RT, ObjBuffer)
end

function LLVMOrcObjectLayerEmit(ObjLayer, R, ObjBuffer)
    ccall((:LLVMOrcObjectLayerEmit, libllvm), Cvoid, (LLVMOrcObjectLayerRef, LLVMOrcMaterializationResponsibilityRef, LLVMMemoryBufferRef), ObjLayer, R, ObjBuffer)
end

function LLVMOrcDisposeObjectLayer(ObjLayer)
    ccall((:LLVMOrcDisposeObjectLayer, libllvm), Cvoid, (LLVMOrcObjectLayerRef,), ObjLayer)
end

function LLVMOrcIRTransformLayerEmit(IRTransformLayer, MR, TSM)
    ccall((:LLVMOrcIRTransformLayerEmit, libllvm), Cvoid, (LLVMOrcIRTransformLayerRef, LLVMOrcMaterializationResponsibilityRef, LLVMOrcThreadSafeModuleRef), IRTransformLayer, MR, TSM)
end

function LLVMOrcIRTransformLayerSetTransform(IRTransformLayer, TransformFunction, Ctx)
    ccall((:LLVMOrcIRTransformLayerSetTransform, libllvm), Cvoid, (LLVMOrcIRTransformLayerRef, LLVMOrcIRTransformLayerTransformFunction, Ptr{Cvoid}), IRTransformLayer, TransformFunction, Ctx)
end

function LLVMOrcObjectTransformLayerSetTransform(ObjTransformLayer, TransformFunction, Ctx)
    ccall((:LLVMOrcObjectTransformLayerSetTransform, libllvm), Cvoid, (LLVMOrcObjectTransformLayerRef, LLVMOrcObjectTransformLayerTransformFunction, Ptr{Cvoid}), ObjTransformLayer, TransformFunction, Ctx)
end

function LLVMOrcCreateLocalIndirectStubsManager(TargetTriple)
    ccall((:LLVMOrcCreateLocalIndirectStubsManager, libllvm), LLVMOrcIndirectStubsManagerRef, (Cstring,), TargetTriple)
end

function LLVMOrcDisposeIndirectStubsManager(ISM)
    ccall((:LLVMOrcDisposeIndirectStubsManager, libllvm), Cvoid, (LLVMOrcIndirectStubsManagerRef,), ISM)
end

function LLVMOrcCreateLocalLazyCallThroughManager(TargetTriple, ES, ErrorHandlerAddr, LCTM)
    ccall((:LLVMOrcCreateLocalLazyCallThroughManager, libllvm), LLVMErrorRef, (Cstring, LLVMOrcExecutionSessionRef, LLVMOrcJITTargetAddress, Ptr{LLVMOrcLazyCallThroughManagerRef}), TargetTriple, ES, ErrorHandlerAddr, LCTM)
end

function LLVMOrcDisposeLazyCallThroughManager(LCTM)
    ccall((:LLVMOrcDisposeLazyCallThroughManager, libllvm), Cvoid, (LLVMOrcLazyCallThroughManagerRef,), LCTM)
end

function LLVMOrcCreateDumpObjects(DumpDir, IdentifierOverride)
    ccall((:LLVMOrcCreateDumpObjects, libllvm), LLVMOrcDumpObjectsRef, (Cstring, Cstring), DumpDir, IdentifierOverride)
end

function LLVMOrcDisposeDumpObjects(DumpObjects)
    ccall((:LLVMOrcDisposeDumpObjects, libllvm), Cvoid, (LLVMOrcDumpObjectsRef,), DumpObjects)
end

function LLVMOrcDumpObjects_CallOperator(DumpObjects, ObjBuffer)
    ccall((:LLVMOrcDumpObjects_CallOperator, libllvm), LLVMErrorRef, (LLVMOrcDumpObjectsRef, Ptr{LLVMMemoryBufferRef}), DumpObjects, ObjBuffer)
end

function LLVMOrcCreateRTDyldObjectLinkingLayerWithSectionMemoryManager(ES)
    ccall((:LLVMOrcCreateRTDyldObjectLinkingLayerWithSectionMemoryManager, libllvm), LLVMOrcObjectLayerRef, (LLVMOrcExecutionSessionRef,), ES)
end

function LLVMOrcRTDyldObjectLinkingLayerRegisterJITEventListener(RTDyldObjLinkingLayer, Listener)
    ccall((:LLVMOrcRTDyldObjectLinkingLayerRegisterJITEventListener, libllvm), Cvoid, (LLVMOrcObjectLayerRef, LLVMJITEventListenerRef), RTDyldObjLinkingLayer, Listener)
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
    ccall((:LLVMRemarkStringGetData, libllvm), Cstring, (LLVMRemarkStringRef,), String)
end

function LLVMRemarkStringGetLen(String)
    ccall((:LLVMRemarkStringGetLen, libllvm), UInt32, (LLVMRemarkStringRef,), String)
end

mutable struct LLVMRemarkOpaqueDebugLoc end

const LLVMRemarkDebugLocRef = Ptr{LLVMRemarkOpaqueDebugLoc}

function LLVMRemarkDebugLocGetSourceFilePath(DL)
    ccall((:LLVMRemarkDebugLocGetSourceFilePath, libllvm), LLVMRemarkStringRef, (LLVMRemarkDebugLocRef,), DL)
end

function LLVMRemarkDebugLocGetSourceLine(DL)
    ccall((:LLVMRemarkDebugLocGetSourceLine, libllvm), UInt32, (LLVMRemarkDebugLocRef,), DL)
end

function LLVMRemarkDebugLocGetSourceColumn(DL)
    ccall((:LLVMRemarkDebugLocGetSourceColumn, libllvm), UInt32, (LLVMRemarkDebugLocRef,), DL)
end

mutable struct LLVMRemarkOpaqueArg end

const LLVMRemarkArgRef = Ptr{LLVMRemarkOpaqueArg}

function LLVMRemarkArgGetKey(Arg)
    ccall((:LLVMRemarkArgGetKey, libllvm), LLVMRemarkStringRef, (LLVMRemarkArgRef,), Arg)
end

function LLVMRemarkArgGetValue(Arg)
    ccall((:LLVMRemarkArgGetValue, libllvm), LLVMRemarkStringRef, (LLVMRemarkArgRef,), Arg)
end

function LLVMRemarkArgGetDebugLoc(Arg)
    ccall((:LLVMRemarkArgGetDebugLoc, libllvm), LLVMRemarkDebugLocRef, (LLVMRemarkArgRef,), Arg)
end

mutable struct LLVMRemarkOpaqueEntry end

const LLVMRemarkEntryRef = Ptr{LLVMRemarkOpaqueEntry}

function LLVMRemarkEntryDispose(Remark)
    ccall((:LLVMRemarkEntryDispose, libllvm), Cvoid, (LLVMRemarkEntryRef,), Remark)
end

function LLVMRemarkEntryGetType(Remark)
    ccall((:LLVMRemarkEntryGetType, libllvm), LLVMRemarkType, (LLVMRemarkEntryRef,), Remark)
end

function LLVMRemarkEntryGetPassName(Remark)
    ccall((:LLVMRemarkEntryGetPassName, libllvm), LLVMRemarkStringRef, (LLVMRemarkEntryRef,), Remark)
end

function LLVMRemarkEntryGetRemarkName(Remark)
    ccall((:LLVMRemarkEntryGetRemarkName, libllvm), LLVMRemarkStringRef, (LLVMRemarkEntryRef,), Remark)
end

function LLVMRemarkEntryGetFunctionName(Remark)
    ccall((:LLVMRemarkEntryGetFunctionName, libllvm), LLVMRemarkStringRef, (LLVMRemarkEntryRef,), Remark)
end

function LLVMRemarkEntryGetDebugLoc(Remark)
    ccall((:LLVMRemarkEntryGetDebugLoc, libllvm), LLVMRemarkDebugLocRef, (LLVMRemarkEntryRef,), Remark)
end

function LLVMRemarkEntryGetHotness(Remark)
    ccall((:LLVMRemarkEntryGetHotness, libllvm), UInt64, (LLVMRemarkEntryRef,), Remark)
end

function LLVMRemarkEntryGetNumArgs(Remark)
    ccall((:LLVMRemarkEntryGetNumArgs, libllvm), UInt32, (LLVMRemarkEntryRef,), Remark)
end

function LLVMRemarkEntryGetFirstArg(Remark)
    ccall((:LLVMRemarkEntryGetFirstArg, libllvm), LLVMRemarkArgRef, (LLVMRemarkEntryRef,), Remark)
end

function LLVMRemarkEntryGetNextArg(It, Remark)
    ccall((:LLVMRemarkEntryGetNextArg, libllvm), LLVMRemarkArgRef, (LLVMRemarkArgRef, LLVMRemarkEntryRef), It, Remark)
end

mutable struct LLVMRemarkOpaqueParser end

const LLVMRemarkParserRef = Ptr{LLVMRemarkOpaqueParser}

function LLVMRemarkParserCreateYAML(Buf, Size)
    ccall((:LLVMRemarkParserCreateYAML, libllvm), LLVMRemarkParserRef, (Ptr{Cvoid}, UInt64), Buf, Size)
end

function LLVMRemarkParserCreateBitstream(Buf, Size)
    ccall((:LLVMRemarkParserCreateBitstream, libllvm), LLVMRemarkParserRef, (Ptr{Cvoid}, UInt64), Buf, Size)
end

function LLVMRemarkParserGetNext(Parser)
    ccall((:LLVMRemarkParserGetNext, libllvm), LLVMRemarkEntryRef, (LLVMRemarkParserRef,), Parser)
end

function LLVMRemarkParserHasError(Parser)
    ccall((:LLVMRemarkParserHasError, libllvm), LLVMBool, (LLVMRemarkParserRef,), Parser)
end

function LLVMRemarkParserGetErrorMessage(Parser)
    ccall((:LLVMRemarkParserGetErrorMessage, libllvm), Cstring, (LLVMRemarkParserRef,), Parser)
end

function LLVMRemarkParserDispose(Parser)
    ccall((:LLVMRemarkParserDispose, libllvm), Cvoid, (LLVMRemarkParserRef,), Parser)
end

function LLVMRemarkVersion()
    ccall((:LLVMRemarkVersion, libllvm), UInt32, ())
end

function LLVMLoadLibraryPermanently(Filename)
    ccall((:LLVMLoadLibraryPermanently, libllvm), LLVMBool, (Cstring,), Filename)
end

function LLVMParseCommandLineOptions(argc, argv, Overview)
    ccall((:LLVMParseCommandLineOptions, libllvm), Cvoid, (Cint, Ptr{Cstring}, Cstring), argc, argv, Overview)
end

function LLVMSearchForAddressOfSymbol(symbolName)
    ccall((:LLVMSearchForAddressOfSymbol, libllvm), Ptr{Cvoid}, (Cstring,), symbolName)
end

function LLVMAddSymbol(symbolName, symbolValue)
    ccall((:LLVMAddSymbol, libllvm), Cvoid, (Cstring, Ptr{Cvoid}), symbolName, symbolValue)
end

@cenum LLVMByteOrdering::UInt32 begin
    LLVMBigEndian = 0
    LLVMLittleEndian = 1
end

const LLVMTargetLibraryInfoRef = Ptr{LLVMOpaqueTargetLibraryInfotData}

function LLVMGetModuleDataLayout(M)
    ccall((:LLVMGetModuleDataLayout, libllvm), LLVMTargetDataRef, (LLVMModuleRef,), M)
end

function LLVMSetModuleDataLayout(M, DL)
    ccall((:LLVMSetModuleDataLayout, libllvm), Cvoid, (LLVMModuleRef, LLVMTargetDataRef), M, DL)
end

function LLVMCreateTargetData(StringRep)
    ccall((:LLVMCreateTargetData, libllvm), LLVMTargetDataRef, (Cstring,), StringRep)
end

function LLVMDisposeTargetData(TD)
    ccall((:LLVMDisposeTargetData, libllvm), Cvoid, (LLVMTargetDataRef,), TD)
end

function LLVMAddTargetLibraryInfo(TLI, PM)
    ccall((:LLVMAddTargetLibraryInfo, libllvm), Cvoid, (LLVMTargetLibraryInfoRef, LLVMPassManagerRef), TLI, PM)
end

function LLVMCopyStringRepOfTargetData(TD)
    ccall((:LLVMCopyStringRepOfTargetData, libllvm), Cstring, (LLVMTargetDataRef,), TD)
end

function LLVMByteOrder(TD)
    ccall((:LLVMByteOrder, libllvm), LLVMByteOrdering, (LLVMTargetDataRef,), TD)
end

function LLVMPointerSize(TD)
    ccall((:LLVMPointerSize, libllvm), Cuint, (LLVMTargetDataRef,), TD)
end

function LLVMPointerSizeForAS(TD, AS)
    ccall((:LLVMPointerSizeForAS, libllvm), Cuint, (LLVMTargetDataRef, Cuint), TD, AS)
end

function LLVMIntPtrType(TD)
    ccall((:LLVMIntPtrType, libllvm), LLVMTypeRef, (LLVMTargetDataRef,), TD)
end

function LLVMIntPtrTypeForAS(TD, AS)
    ccall((:LLVMIntPtrTypeForAS, libllvm), LLVMTypeRef, (LLVMTargetDataRef, Cuint), TD, AS)
end

function LLVMIntPtrTypeInContext(C, TD)
    ccall((:LLVMIntPtrTypeInContext, libllvm), LLVMTypeRef, (LLVMContextRef, LLVMTargetDataRef), C, TD)
end

function LLVMIntPtrTypeForASInContext(C, TD, AS)
    ccall((:LLVMIntPtrTypeForASInContext, libllvm), LLVMTypeRef, (LLVMContextRef, LLVMTargetDataRef, Cuint), C, TD, AS)
end

function LLVMSizeOfTypeInBits(TD, Ty)
    ccall((:LLVMSizeOfTypeInBits, libllvm), Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMStoreSizeOfType(TD, Ty)
    ccall((:LLVMStoreSizeOfType, libllvm), Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMABISizeOfType(TD, Ty)
    ccall((:LLVMABISizeOfType, libllvm), Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMABIAlignmentOfType(TD, Ty)
    ccall((:LLVMABIAlignmentOfType, libllvm), Cuint, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMCallFrameAlignmentOfType(TD, Ty)
    ccall((:LLVMCallFrameAlignmentOfType, libllvm), Cuint, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMPreferredAlignmentOfType(TD, Ty)
    ccall((:LLVMPreferredAlignmentOfType, libllvm), Cuint, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMPreferredAlignmentOfGlobal(TD, GlobalVar)
    ccall((:LLVMPreferredAlignmentOfGlobal, libllvm), Cuint, (LLVMTargetDataRef, LLVMValueRef), TD, GlobalVar)
end

function LLVMElementAtOffset(TD, StructTy, Offset)
    ccall((:LLVMElementAtOffset, libllvm), Cuint, (LLVMTargetDataRef, LLVMTypeRef, Culonglong), TD, StructTy, Offset)
end

function LLVMOffsetOfElement(TD, StructTy, Element)
    ccall((:LLVMOffsetOfElement, libllvm), Culonglong, (LLVMTargetDataRef, LLVMTypeRef, Cuint), TD, StructTy, Element)
end

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
    ccall((:LLVMGetFirstTarget, libllvm), LLVMTargetRef, ())
end

function LLVMGetNextTarget(T)
    ccall((:LLVMGetNextTarget, libllvm), LLVMTargetRef, (LLVMTargetRef,), T)
end

function LLVMGetTargetFromName(Name)
    ccall((:LLVMGetTargetFromName, libllvm), LLVMTargetRef, (Cstring,), Name)
end

function LLVMGetTargetFromTriple(Triple, T, ErrorMessage)
    ccall((:LLVMGetTargetFromTriple, libllvm), LLVMBool, (Cstring, Ptr{LLVMTargetRef}, Ptr{Cstring}), Triple, T, ErrorMessage)
end

function LLVMGetTargetName(T)
    ccall((:LLVMGetTargetName, libllvm), Cstring, (LLVMTargetRef,), T)
end

function LLVMGetTargetDescription(T)
    ccall((:LLVMGetTargetDescription, libllvm), Cstring, (LLVMTargetRef,), T)
end

function LLVMTargetHasJIT(T)
    ccall((:LLVMTargetHasJIT, libllvm), LLVMBool, (LLVMTargetRef,), T)
end

function LLVMTargetHasTargetMachine(T)
    ccall((:LLVMTargetHasTargetMachine, libllvm), LLVMBool, (LLVMTargetRef,), T)
end

function LLVMTargetHasAsmBackend(T)
    ccall((:LLVMTargetHasAsmBackend, libllvm), LLVMBool, (LLVMTargetRef,), T)
end

function LLVMCreateTargetMachine(T, Triple, CPU, Features, Level, Reloc, CodeModel)
    ccall((:LLVMCreateTargetMachine, libllvm), LLVMTargetMachineRef, (LLVMTargetRef, Cstring, Cstring, Cstring, LLVMCodeGenOptLevel, LLVMRelocMode, LLVMCodeModel), T, Triple, CPU, Features, Level, Reloc, CodeModel)
end

function LLVMDisposeTargetMachine(T)
    ccall((:LLVMDisposeTargetMachine, libllvm), Cvoid, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineTarget(T)
    ccall((:LLVMGetTargetMachineTarget, libllvm), LLVMTargetRef, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineTriple(T)
    ccall((:LLVMGetTargetMachineTriple, libllvm), Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineCPU(T)
    ccall((:LLVMGetTargetMachineCPU, libllvm), Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineFeatureString(T)
    ccall((:LLVMGetTargetMachineFeatureString, libllvm), Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMCreateTargetDataLayout(T)
    ccall((:LLVMCreateTargetDataLayout, libllvm), LLVMTargetDataRef, (LLVMTargetMachineRef,), T)
end

function LLVMSetTargetMachineAsmVerbosity(T, VerboseAsm)
    ccall((:LLVMSetTargetMachineAsmVerbosity, libllvm), Cvoid, (LLVMTargetMachineRef, LLVMBool), T, VerboseAsm)
end

function LLVMTargetMachineEmitToFile(T, M, Filename, codegen, ErrorMessage)
    ccall((:LLVMTargetMachineEmitToFile, libllvm), LLVMBool, (LLVMTargetMachineRef, LLVMModuleRef, Cstring, LLVMCodeGenFileType, Ptr{Cstring}), T, M, Filename, codegen, ErrorMessage)
end

function LLVMTargetMachineEmitToMemoryBuffer(T, M, codegen, ErrorMessage, OutMemBuf)
    ccall((:LLVMTargetMachineEmitToMemoryBuffer, libllvm), LLVMBool, (LLVMTargetMachineRef, LLVMModuleRef, LLVMCodeGenFileType, Ptr{Cstring}, Ptr{LLVMMemoryBufferRef}), T, M, codegen, ErrorMessage, OutMemBuf)
end

function LLVMGetDefaultTargetTriple()
    ccall((:LLVMGetDefaultTargetTriple, libllvm), Cstring, ())
end

function LLVMNormalizeTargetTriple(triple)
    ccall((:LLVMNormalizeTargetTriple, libllvm), Cstring, (Cstring,), triple)
end

function LLVMGetHostCPUName()
    ccall((:LLVMGetHostCPUName, libllvm), Cstring, ())
end

function LLVMGetHostCPUFeatures()
    ccall((:LLVMGetHostCPUFeatures, libllvm), Cstring, ())
end

function LLVMAddAnalysisPasses(T, PM)
    ccall((:LLVMAddAnalysisPasses, libllvm), Cvoid, (LLVMTargetMachineRef, LLVMPassManagerRef), T, PM)
end

function LLVMAddAggressiveInstCombinerPass(PM)
    ccall((:LLVMAddAggressiveInstCombinerPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCoroEarlyPass(PM)
    ccall((:LLVMAddCoroEarlyPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCoroSplitPass(PM)
    ccall((:LLVMAddCoroSplitPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCoroElidePass(PM)
    ccall((:LLVMAddCoroElidePass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCoroCleanupPass(PM)
    ccall((:LLVMAddCoroCleanupPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

const LLVMPassManagerBuilderRef = Ptr{LLVMOpaquePassManagerBuilder}

function LLVMPassManagerBuilderAddCoroutinePassesToExtensionPoints(PMB)
    ccall((:LLVMPassManagerBuilderAddCoroutinePassesToExtensionPoints, libllvm), Cvoid, (LLVMPassManagerBuilderRef,), PMB)
end

function LLVMAddArgumentPromotionPass(PM)
    ccall((:LLVMAddArgumentPromotionPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddConstantMergePass(PM)
    ccall((:LLVMAddConstantMergePass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddMergeFunctionsPass(PM)
    ccall((:LLVMAddMergeFunctionsPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCalledValuePropagationPass(PM)
    ccall((:LLVMAddCalledValuePropagationPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddDeadArgEliminationPass(PM)
    ccall((:LLVMAddDeadArgEliminationPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddFunctionAttrsPass(PM)
    ccall((:LLVMAddFunctionAttrsPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddFunctionInliningPass(PM)
    ccall((:LLVMAddFunctionInliningPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddAlwaysInlinerPass(PM)
    ccall((:LLVMAddAlwaysInlinerPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddGlobalDCEPass(PM)
    ccall((:LLVMAddGlobalDCEPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddGlobalOptimizerPass(PM)
    ccall((:LLVMAddGlobalOptimizerPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddPruneEHPass(PM)
    ccall((:LLVMAddPruneEHPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddIPSCCPPass(PM)
    ccall((:LLVMAddIPSCCPPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddInternalizePass(arg1, AllButMain)
    ccall((:LLVMAddInternalizePass, libllvm), Cvoid, (LLVMPassManagerRef, Cuint), arg1, AllButMain)
end

function LLVMAddInternalizePassWithMustPreservePredicate(PM, Context, MustPreserve)
    ccall((:LLVMAddInternalizePassWithMustPreservePredicate, libllvm), Cvoid, (LLVMPassManagerRef, Ptr{Cvoid}, Ptr{Cvoid}), PM, Context, MustPreserve)
end

function LLVMAddStripDeadPrototypesPass(PM)
    ccall((:LLVMAddStripDeadPrototypesPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddStripSymbolsPass(PM)
    ccall((:LLVMAddStripSymbolsPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddInstructionCombiningPass(PM)
    ccall((:LLVMAddInstructionCombiningPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

mutable struct LLVMOpaquePassBuilderOptions end

const LLVMPassBuilderOptionsRef = Ptr{LLVMOpaquePassBuilderOptions}

function LLVMRunPasses(M, Passes, TM, Options)
    ccall((:LLVMRunPasses, libllvm), LLVMErrorRef, (LLVMModuleRef, Cstring, LLVMTargetMachineRef, LLVMPassBuilderOptionsRef), M, Passes, TM, Options)
end

function LLVMCreatePassBuilderOptions()
    ccall((:LLVMCreatePassBuilderOptions, libllvm), LLVMPassBuilderOptionsRef, ())
end

function LLVMPassBuilderOptionsSetVerifyEach(Options, VerifyEach)
    ccall((:LLVMPassBuilderOptionsSetVerifyEach, libllvm), Cvoid, (LLVMPassBuilderOptionsRef, LLVMBool), Options, VerifyEach)
end

function LLVMPassBuilderOptionsSetDebugLogging(Options, DebugLogging)
    ccall((:LLVMPassBuilderOptionsSetDebugLogging, libllvm), Cvoid, (LLVMPassBuilderOptionsRef, LLVMBool), Options, DebugLogging)
end

function LLVMPassBuilderOptionsSetLoopInterleaving(Options, LoopInterleaving)
    ccall((:LLVMPassBuilderOptionsSetLoopInterleaving, libllvm), Cvoid, (LLVMPassBuilderOptionsRef, LLVMBool), Options, LoopInterleaving)
end

function LLVMPassBuilderOptionsSetLoopVectorization(Options, LoopVectorization)
    ccall((:LLVMPassBuilderOptionsSetLoopVectorization, libllvm), Cvoid, (LLVMPassBuilderOptionsRef, LLVMBool), Options, LoopVectorization)
end

function LLVMPassBuilderOptionsSetSLPVectorization(Options, SLPVectorization)
    ccall((:LLVMPassBuilderOptionsSetSLPVectorization, libllvm), Cvoid, (LLVMPassBuilderOptionsRef, LLVMBool), Options, SLPVectorization)
end

function LLVMPassBuilderOptionsSetLoopUnrolling(Options, LoopUnrolling)
    ccall((:LLVMPassBuilderOptionsSetLoopUnrolling, libllvm), Cvoid, (LLVMPassBuilderOptionsRef, LLVMBool), Options, LoopUnrolling)
end

function LLVMPassBuilderOptionsSetForgetAllSCEVInLoopUnroll(Options, ForgetAllSCEVInLoopUnroll)
    ccall((:LLVMPassBuilderOptionsSetForgetAllSCEVInLoopUnroll, libllvm), Cvoid, (LLVMPassBuilderOptionsRef, LLVMBool), Options, ForgetAllSCEVInLoopUnroll)
end

function LLVMPassBuilderOptionsSetLicmMssaOptCap(Options, LicmMssaOptCap)
    ccall((:LLVMPassBuilderOptionsSetLicmMssaOptCap, libllvm), Cvoid, (LLVMPassBuilderOptionsRef, Cuint), Options, LicmMssaOptCap)
end

function LLVMPassBuilderOptionsSetLicmMssaNoAccForPromotionCap(Options, LicmMssaNoAccForPromotionCap)
    ccall((:LLVMPassBuilderOptionsSetLicmMssaNoAccForPromotionCap, libllvm), Cvoid, (LLVMPassBuilderOptionsRef, Cuint), Options, LicmMssaNoAccForPromotionCap)
end

function LLVMPassBuilderOptionsSetCallGraphProfile(Options, CallGraphProfile)
    ccall((:LLVMPassBuilderOptionsSetCallGraphProfile, libllvm), Cvoid, (LLVMPassBuilderOptionsRef, LLVMBool), Options, CallGraphProfile)
end

function LLVMPassBuilderOptionsSetMergeFunctions(Options, MergeFunctions)
    ccall((:LLVMPassBuilderOptionsSetMergeFunctions, libllvm), Cvoid, (LLVMPassBuilderOptionsRef, LLVMBool), Options, MergeFunctions)
end

function LLVMDisposePassBuilderOptions(Options)
    ccall((:LLVMDisposePassBuilderOptions, libllvm), Cvoid, (LLVMPassBuilderOptionsRef,), Options)
end

function LLVMPassManagerBuilderCreate()
    ccall((:LLVMPassManagerBuilderCreate, libllvm), LLVMPassManagerBuilderRef, ())
end

function LLVMPassManagerBuilderDispose(PMB)
    ccall((:LLVMPassManagerBuilderDispose, libllvm), Cvoid, (LLVMPassManagerBuilderRef,), PMB)
end

function LLVMPassManagerBuilderSetOptLevel(PMB, OptLevel)
    ccall((:LLVMPassManagerBuilderSetOptLevel, libllvm), Cvoid, (LLVMPassManagerBuilderRef, Cuint), PMB, OptLevel)
end

function LLVMPassManagerBuilderSetSizeLevel(PMB, SizeLevel)
    ccall((:LLVMPassManagerBuilderSetSizeLevel, libllvm), Cvoid, (LLVMPassManagerBuilderRef, Cuint), PMB, SizeLevel)
end

function LLVMPassManagerBuilderSetDisableUnitAtATime(PMB, Value)
    ccall((:LLVMPassManagerBuilderSetDisableUnitAtATime, libllvm), Cvoid, (LLVMPassManagerBuilderRef, LLVMBool), PMB, Value)
end

function LLVMPassManagerBuilderSetDisableUnrollLoops(PMB, Value)
    ccall((:LLVMPassManagerBuilderSetDisableUnrollLoops, libllvm), Cvoid, (LLVMPassManagerBuilderRef, LLVMBool), PMB, Value)
end

function LLVMPassManagerBuilderSetDisableSimplifyLibCalls(PMB, Value)
    ccall((:LLVMPassManagerBuilderSetDisableSimplifyLibCalls, libllvm), Cvoid, (LLVMPassManagerBuilderRef, LLVMBool), PMB, Value)
end

function LLVMPassManagerBuilderUseInlinerWithThreshold(PMB, Threshold)
    ccall((:LLVMPassManagerBuilderUseInlinerWithThreshold, libllvm), Cvoid, (LLVMPassManagerBuilderRef, Cuint), PMB, Threshold)
end

function LLVMPassManagerBuilderPopulateFunctionPassManager(PMB, PM)
    ccall((:LLVMPassManagerBuilderPopulateFunctionPassManager, libllvm), Cvoid, (LLVMPassManagerBuilderRef, LLVMPassManagerRef), PMB, PM)
end

function LLVMPassManagerBuilderPopulateModulePassManager(PMB, PM)
    ccall((:LLVMPassManagerBuilderPopulateModulePassManager, libllvm), Cvoid, (LLVMPassManagerBuilderRef, LLVMPassManagerRef), PMB, PM)
end

function LLVMPassManagerBuilderPopulateLTOPassManager(PMB, PM, Internalize, RunInliner)
    ccall((:LLVMPassManagerBuilderPopulateLTOPassManager, libllvm), Cvoid, (LLVMPassManagerBuilderRef, LLVMPassManagerRef, LLVMBool, LLVMBool), PMB, PM, Internalize, RunInliner)
end

function LLVMAddAggressiveDCEPass(PM)
    ccall((:LLVMAddAggressiveDCEPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddDCEPass(PM)
    ccall((:LLVMAddDCEPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddBitTrackingDCEPass(PM)
    ccall((:LLVMAddBitTrackingDCEPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddAlignmentFromAssumptionsPass(PM)
    ccall((:LLVMAddAlignmentFromAssumptionsPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCFGSimplificationPass(PM)
    ccall((:LLVMAddCFGSimplificationPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddDeadStoreEliminationPass(PM)
    ccall((:LLVMAddDeadStoreEliminationPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScalarizerPass(PM)
    ccall((:LLVMAddScalarizerPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddMergedLoadStoreMotionPass(PM)
    ccall((:LLVMAddMergedLoadStoreMotionPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddGVNPass(PM)
    ccall((:LLVMAddGVNPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddNewGVNPass(PM)
    ccall((:LLVMAddNewGVNPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddIndVarSimplifyPass(PM)
    ccall((:LLVMAddIndVarSimplifyPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddInstructionSimplifyPass(PM)
    ccall((:LLVMAddInstructionSimplifyPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddJumpThreadingPass(PM)
    ccall((:LLVMAddJumpThreadingPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLICMPass(PM)
    ccall((:LLVMAddLICMPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopDeletionPass(PM)
    ccall((:LLVMAddLoopDeletionPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopIdiomPass(PM)
    ccall((:LLVMAddLoopIdiomPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopRotatePass(PM)
    ccall((:LLVMAddLoopRotatePass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopRerollPass(PM)
    ccall((:LLVMAddLoopRerollPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopUnrollPass(PM)
    ccall((:LLVMAddLoopUnrollPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopUnrollAndJamPass(PM)
    ccall((:LLVMAddLoopUnrollAndJamPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopUnswitchPass(PM)
    ccall((:LLVMAddLoopUnswitchPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLowerAtomicPass(PM)
    ccall((:LLVMAddLowerAtomicPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddMemCpyOptPass(PM)
    ccall((:LLVMAddMemCpyOptPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddPartiallyInlineLibCallsPass(PM)
    ccall((:LLVMAddPartiallyInlineLibCallsPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddReassociatePass(PM)
    ccall((:LLVMAddReassociatePass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddSCCPPass(PM)
    ccall((:LLVMAddSCCPPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScalarReplAggregatesPass(PM)
    ccall((:LLVMAddScalarReplAggregatesPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScalarReplAggregatesPassSSA(PM)
    ccall((:LLVMAddScalarReplAggregatesPassSSA, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScalarReplAggregatesPassWithThreshold(PM, Threshold)
    ccall((:LLVMAddScalarReplAggregatesPassWithThreshold, libllvm), Cvoid, (LLVMPassManagerRef, Cint), PM, Threshold)
end

function LLVMAddSimplifyLibCallsPass(PM)
    ccall((:LLVMAddSimplifyLibCallsPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddTailCallEliminationPass(PM)
    ccall((:LLVMAddTailCallEliminationPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddDemoteMemoryToRegisterPass(PM)
    ccall((:LLVMAddDemoteMemoryToRegisterPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddVerifierPass(PM)
    ccall((:LLVMAddVerifierPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCorrelatedValuePropagationPass(PM)
    ccall((:LLVMAddCorrelatedValuePropagationPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddEarlyCSEPass(PM)
    ccall((:LLVMAddEarlyCSEPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddEarlyCSEMemSSAPass(PM)
    ccall((:LLVMAddEarlyCSEMemSSAPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLowerExpectIntrinsicPass(PM)
    ccall((:LLVMAddLowerExpectIntrinsicPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLowerConstantIntrinsicsPass(PM)
    ccall((:LLVMAddLowerConstantIntrinsicsPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddTypeBasedAliasAnalysisPass(PM)
    ccall((:LLVMAddTypeBasedAliasAnalysisPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScopedNoAliasAAPass(PM)
    ccall((:LLVMAddScopedNoAliasAAPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddBasicAliasAnalysisPass(PM)
    ccall((:LLVMAddBasicAliasAnalysisPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddUnifyFunctionExitNodesPass(PM)
    ccall((:LLVMAddUnifyFunctionExitNodesPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLowerSwitchPass(PM)
    ccall((:LLVMAddLowerSwitchPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddPromoteMemoryToRegisterPass(PM)
    ccall((:LLVMAddPromoteMemoryToRegisterPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddAddDiscriminatorsPass(PM)
    ccall((:LLVMAddAddDiscriminatorsPass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopVectorizePass(PM)
    ccall((:LLVMAddLoopVectorizePass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddSLPVectorizePass(PM)
    ccall((:LLVMAddSLPVectorizePass, libllvm), Cvoid, (LLVMPassManagerRef,), PM)
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
    ccall((:lto_get_version, libllvm), Cstring, ())
end

function lto_get_error_message()
    ccall((:lto_get_error_message, libllvm), Cstring, ())
end

function lto_module_is_object_file(path)
    ccall((:lto_module_is_object_file, libllvm), lto_bool_t, (Cstring,), path)
end

function lto_module_is_object_file_for_target(path, target_triple_prefix)
    ccall((:lto_module_is_object_file_for_target, libllvm), lto_bool_t, (Cstring, Cstring), path, target_triple_prefix)
end

function lto_module_has_objc_category(mem, length)
    ccall((:lto_module_has_objc_category, libllvm), lto_bool_t, (Ptr{Cvoid}, Csize_t), mem, length)
end

function lto_module_is_object_file_in_memory(mem, length)
    ccall((:lto_module_is_object_file_in_memory, libllvm), lto_bool_t, (Ptr{Cvoid}, Csize_t), mem, length)
end

function lto_module_is_object_file_in_memory_for_target(mem, length, target_triple_prefix)
    ccall((:lto_module_is_object_file_in_memory_for_target, libllvm), lto_bool_t, (Ptr{Cvoid}, Csize_t, Cstring), mem, length, target_triple_prefix)
end

function lto_module_create(path)
    ccall((:lto_module_create, libllvm), lto_module_t, (Cstring,), path)
end

function lto_module_create_from_memory(mem, length)
    ccall((:lto_module_create_from_memory, libllvm), lto_module_t, (Ptr{Cvoid}, Csize_t), mem, length)
end

function lto_module_create_from_memory_with_path(mem, length, path)
    ccall((:lto_module_create_from_memory_with_path, libllvm), lto_module_t, (Ptr{Cvoid}, Csize_t, Cstring), mem, length, path)
end

function lto_module_create_in_local_context(mem, length, path)
    ccall((:lto_module_create_in_local_context, libllvm), lto_module_t, (Ptr{Cvoid}, Csize_t, Cstring), mem, length, path)
end

function lto_module_create_in_codegen_context(mem, length, path, cg)
    ccall((:lto_module_create_in_codegen_context, libllvm), lto_module_t, (Ptr{Cvoid}, Csize_t, Cstring, lto_code_gen_t), mem, length, path, cg)
end

function lto_module_create_from_fd(fd, path, file_size)
    ccall((:lto_module_create_from_fd, libllvm), lto_module_t, (Cint, Cstring, Csize_t), fd, path, file_size)
end

function lto_module_create_from_fd_at_offset(fd, path, file_size, map_size, offset)
    ccall((:lto_module_create_from_fd_at_offset, libllvm), lto_module_t, (Cint, Cstring, Csize_t, Csize_t, off_t), fd, path, file_size, map_size, offset)
end

function lto_module_dispose(mod)
    ccall((:lto_module_dispose, libllvm), Cvoid, (lto_module_t,), mod)
end

function lto_module_get_target_triple(mod)
    ccall((:lto_module_get_target_triple, libllvm), Cstring, (lto_module_t,), mod)
end

function lto_module_set_target_triple(mod, triple)
    ccall((:lto_module_set_target_triple, libllvm), Cvoid, (lto_module_t, Cstring), mod, triple)
end

function lto_module_get_num_symbols(mod)
    ccall((:lto_module_get_num_symbols, libllvm), Cuint, (lto_module_t,), mod)
end

function lto_module_get_symbol_name(mod, index)
    ccall((:lto_module_get_symbol_name, libllvm), Cstring, (lto_module_t, Cuint), mod, index)
end

function lto_module_get_symbol_attribute(mod, index)
    ccall((:lto_module_get_symbol_attribute, libllvm), lto_symbol_attributes, (lto_module_t, Cuint), mod, index)
end

function lto_module_get_linkeropts(mod)
    ccall((:lto_module_get_linkeropts, libllvm), Cstring, (lto_module_t,), mod)
end

function lto_module_get_macho_cputype(mod, out_cputype, out_cpusubtype)
    ccall((:lto_module_get_macho_cputype, libllvm), lto_bool_t, (lto_module_t, Ptr{Cuint}, Ptr{Cuint}), mod, out_cputype, out_cpusubtype)
end

function lto_module_has_ctor_dtor(mod)
    ccall((:lto_module_has_ctor_dtor, libllvm), lto_bool_t, (lto_module_t,), mod)
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
    ccall((:lto_codegen_set_diagnostic_handler, libllvm), Cvoid, (lto_code_gen_t, lto_diagnostic_handler_t, Ptr{Cvoid}), arg1, arg2, arg3)
end

function lto_codegen_create()
    ccall((:lto_codegen_create, libllvm), lto_code_gen_t, ())
end

function lto_codegen_create_in_local_context()
    ccall((:lto_codegen_create_in_local_context, libllvm), lto_code_gen_t, ())
end

function lto_codegen_dispose(arg1)
    ccall((:lto_codegen_dispose, libllvm), Cvoid, (lto_code_gen_t,), arg1)
end

function lto_codegen_add_module(cg, mod)
    ccall((:lto_codegen_add_module, libllvm), lto_bool_t, (lto_code_gen_t, lto_module_t), cg, mod)
end

function lto_codegen_set_module(cg, mod)
    ccall((:lto_codegen_set_module, libllvm), Cvoid, (lto_code_gen_t, lto_module_t), cg, mod)
end

function lto_codegen_set_debug_model(cg, arg2)
    ccall((:lto_codegen_set_debug_model, libllvm), lto_bool_t, (lto_code_gen_t, lto_debug_model), cg, arg2)
end

function lto_codegen_set_pic_model(cg, arg2)
    ccall((:lto_codegen_set_pic_model, libllvm), lto_bool_t, (lto_code_gen_t, lto_codegen_model), cg, arg2)
end

function lto_codegen_set_cpu(cg, cpu)
    ccall((:lto_codegen_set_cpu, libllvm), Cvoid, (lto_code_gen_t, Cstring), cg, cpu)
end

function lto_codegen_set_assembler_path(cg, path)
    ccall((:lto_codegen_set_assembler_path, libllvm), Cvoid, (lto_code_gen_t, Cstring), cg, path)
end

function lto_codegen_set_assembler_args(cg, args, nargs)
    ccall((:lto_codegen_set_assembler_args, libllvm), Cvoid, (lto_code_gen_t, Ptr{Cstring}, Cint), cg, args, nargs)
end

function lto_codegen_add_must_preserve_symbol(cg, symbol)
    ccall((:lto_codegen_add_must_preserve_symbol, libllvm), Cvoid, (lto_code_gen_t, Cstring), cg, symbol)
end

function lto_codegen_write_merged_modules(cg, path)
    ccall((:lto_codegen_write_merged_modules, libllvm), lto_bool_t, (lto_code_gen_t, Cstring), cg, path)
end

function lto_codegen_compile(cg, length)
    ccall((:lto_codegen_compile, libllvm), Ptr{Cvoid}, (lto_code_gen_t, Ptr{Csize_t}), cg, length)
end

function lto_codegen_compile_to_file(cg, name)
    ccall((:lto_codegen_compile_to_file, libllvm), lto_bool_t, (lto_code_gen_t, Ptr{Cstring}), cg, name)
end

function lto_codegen_optimize(cg)
    ccall((:lto_codegen_optimize, libllvm), lto_bool_t, (lto_code_gen_t,), cg)
end

function lto_codegen_compile_optimized(cg, length)
    ccall((:lto_codegen_compile_optimized, libllvm), Ptr{Cvoid}, (lto_code_gen_t, Ptr{Csize_t}), cg, length)
end

function lto_api_version()
    ccall((:lto_api_version, libllvm), Cuint, ())
end

function lto_set_debug_options(options, number)
    ccall((:lto_set_debug_options, libllvm), Cvoid, (Ptr{Cstring}, Cint), options, number)
end

function lto_codegen_debug_options(cg, arg2)
    ccall((:lto_codegen_debug_options, libllvm), Cvoid, (lto_code_gen_t, Cstring), cg, arg2)
end

function lto_codegen_debug_options_array(cg, arg2, number)
    ccall((:lto_codegen_debug_options_array, libllvm), Cvoid, (lto_code_gen_t, Ptr{Cstring}, Cint), cg, arg2, number)
end

function lto_initialize_disassembler()
    ccall((:lto_initialize_disassembler, libllvm), Cvoid, ())
end

function lto_codegen_set_should_internalize(cg, ShouldInternalize)
    ccall((:lto_codegen_set_should_internalize, libllvm), Cvoid, (lto_code_gen_t, lto_bool_t), cg, ShouldInternalize)
end

function lto_codegen_set_should_embed_uselists(cg, ShouldEmbedUselists)
    ccall((:lto_codegen_set_should_embed_uselists, libllvm), Cvoid, (lto_code_gen_t, lto_bool_t), cg, ShouldEmbedUselists)
end

mutable struct LLVMOpaqueLTOInput end

const lto_input_t = Ptr{LLVMOpaqueLTOInput}

function lto_input_create(buffer, buffer_size, path)
    ccall((:lto_input_create, libllvm), lto_input_t, (Ptr{Cvoid}, Csize_t, Cstring), buffer, buffer_size, path)
end

function lto_input_dispose(input)
    ccall((:lto_input_dispose, libllvm), Cvoid, (lto_input_t,), input)
end

function lto_input_get_num_dependent_libraries(input)
    ccall((:lto_input_get_num_dependent_libraries, libllvm), Cuint, (lto_input_t,), input)
end

function lto_input_get_dependent_library(input, index, size)
    ccall((:lto_input_get_dependent_library, libllvm), Cstring, (lto_input_t, Csize_t, Ptr{Csize_t}), input, index, size)
end

function lto_runtime_lib_symbols_list(size)
    ccall((:lto_runtime_lib_symbols_list, libllvm), Ptr{Cstring}, (Ptr{Csize_t},), size)
end

struct LTOObjectBuffer
    Buffer::Cstring
    Size::Csize_t
end

function thinlto_create_codegen()
    ccall((:thinlto_create_codegen, libllvm), thinlto_code_gen_t, ())
end

function thinlto_codegen_dispose(cg)
    ccall((:thinlto_codegen_dispose, libllvm), Cvoid, (thinlto_code_gen_t,), cg)
end

function thinlto_codegen_add_module(cg, identifier, data, length)
    ccall((:thinlto_codegen_add_module, libllvm), Cvoid, (thinlto_code_gen_t, Cstring, Cstring, Cint), cg, identifier, data, length)
end

function thinlto_codegen_process(cg)
    ccall((:thinlto_codegen_process, libllvm), Cvoid, (thinlto_code_gen_t,), cg)
end

function thinlto_module_get_num_objects(cg)
    ccall((:thinlto_module_get_num_objects, libllvm), Cuint, (thinlto_code_gen_t,), cg)
end

function thinlto_module_get_object(cg, index)
    ccall((:thinlto_module_get_object, libllvm), LTOObjectBuffer, (thinlto_code_gen_t, Cuint), cg, index)
end

function thinlto_module_get_num_object_files(cg)
    ccall((:thinlto_module_get_num_object_files, libllvm), Cuint, (thinlto_code_gen_t,), cg)
end

function thinlto_module_get_object_file(cg, index)
    ccall((:thinlto_module_get_object_file, libllvm), Cstring, (thinlto_code_gen_t, Cuint), cg, index)
end

function thinlto_codegen_set_pic_model(cg, arg2)
    ccall((:thinlto_codegen_set_pic_model, libllvm), lto_bool_t, (thinlto_code_gen_t, lto_codegen_model), cg, arg2)
end

function thinlto_codegen_set_savetemps_dir(cg, save_temps_dir)
    ccall((:thinlto_codegen_set_savetemps_dir, libllvm), Cvoid, (thinlto_code_gen_t, Cstring), cg, save_temps_dir)
end

function thinlto_set_generated_objects_dir(cg, save_temps_dir)
    ccall((:thinlto_set_generated_objects_dir, libllvm), Cvoid, (thinlto_code_gen_t, Cstring), cg, save_temps_dir)
end

function thinlto_codegen_set_cpu(cg, cpu)
    ccall((:thinlto_codegen_set_cpu, libllvm), Cvoid, (thinlto_code_gen_t, Cstring), cg, cpu)
end

function thinlto_codegen_disable_codegen(cg, disable)
    ccall((:thinlto_codegen_disable_codegen, libllvm), Cvoid, (thinlto_code_gen_t, lto_bool_t), cg, disable)
end

function thinlto_codegen_set_codegen_only(cg, codegen_only)
    ccall((:thinlto_codegen_set_codegen_only, libllvm), Cvoid, (thinlto_code_gen_t, lto_bool_t), cg, codegen_only)
end

function thinlto_debug_options(options, number)
    ccall((:thinlto_debug_options, libllvm), Cvoid, (Ptr{Cstring}, Cint), options, number)
end

function lto_module_is_thinlto(mod)
    ccall((:lto_module_is_thinlto, libllvm), lto_bool_t, (lto_module_t,), mod)
end

function thinlto_codegen_add_must_preserve_symbol(cg, name, length)
    ccall((:thinlto_codegen_add_must_preserve_symbol, libllvm), Cvoid, (thinlto_code_gen_t, Cstring, Cint), cg, name, length)
end

function thinlto_codegen_add_cross_referenced_symbol(cg, name, length)
    ccall((:thinlto_codegen_add_cross_referenced_symbol, libllvm), Cvoid, (thinlto_code_gen_t, Cstring, Cint), cg, name, length)
end

function thinlto_codegen_set_cache_dir(cg, cache_dir)
    ccall((:thinlto_codegen_set_cache_dir, libllvm), Cvoid, (thinlto_code_gen_t, Cstring), cg, cache_dir)
end

function thinlto_codegen_set_cache_pruning_interval(cg, interval)
    ccall((:thinlto_codegen_set_cache_pruning_interval, libllvm), Cvoid, (thinlto_code_gen_t, Cint), cg, interval)
end

function thinlto_codegen_set_final_cache_size_relative_to_available_space(cg, percentage)
    ccall((:thinlto_codegen_set_final_cache_size_relative_to_available_space, libllvm), Cvoid, (thinlto_code_gen_t, Cuint), cg, percentage)
end

function thinlto_codegen_set_cache_entry_expiration(cg, expiration)
    ccall((:thinlto_codegen_set_cache_entry_expiration, libllvm), Cvoid, (thinlto_code_gen_t, Cuint), cg, expiration)
end

function thinlto_codegen_set_cache_size_bytes(cg, max_size_bytes)
    ccall((:thinlto_codegen_set_cache_size_bytes, libllvm), Cvoid, (thinlto_code_gen_t, Cuint), cg, max_size_bytes)
end

function thinlto_codegen_set_cache_size_megabytes(cg, max_size_megabytes)
    ccall((:thinlto_codegen_set_cache_size_megabytes, libllvm), Cvoid, (thinlto_code_gen_t, Cuint), cg, max_size_megabytes)
end

function thinlto_codegen_set_cache_size_files(cg, max_size_files)
    ccall((:thinlto_codegen_set_cache_size_files, libllvm), Cvoid, (thinlto_code_gen_t, Cuint), cg, max_size_files)
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

const LTO_API_VERSION = 29

