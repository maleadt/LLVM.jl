# Automatically generated using Clang.jl

const LLVMBool = Cint
struct LLVMOpaqueMemoryBuffer end
const LLVMMemoryBufferRef = Ptr{LLVMOpaqueMemoryBuffer}
struct LLVMOpaqueContext end
const LLVMContextRef = Ptr{LLVMOpaqueContext}
struct LLVMOpaqueModule end
const LLVMModuleRef = Ptr{LLVMOpaqueModule}
struct LLVMOpaqueType end
const LLVMTypeRef = Ptr{LLVMOpaqueType}
struct LLVMOpaqueValue end
const LLVMValueRef = Ptr{LLVMOpaqueValue}
struct LLVMOpaqueBasicBlock end
const LLVMBasicBlockRef = Ptr{LLVMOpaqueBasicBlock}
struct LLVMOpaqueMetadata end
const LLVMMetadataRef = Ptr{LLVMOpaqueMetadata}
struct LLVMOpaqueNamedMDNode end
const LLVMNamedMDNodeRef = Ptr{LLVMOpaqueNamedMDNode}
struct LLVMOpaqueValueMetadataEntry end
const LLVMValueMetadataEntry = LLVMOpaqueValueMetadataEntry
struct LLVMOpaqueBuilder end
const LLVMBuilderRef = Ptr{LLVMOpaqueBuilder}
struct LLVMOpaqueDIBuilder end
const LLVMDIBuilderRef = Ptr{LLVMOpaqueDIBuilder}
struct LLVMOpaqueModuleProvider end
const LLVMModuleProviderRef = Ptr{LLVMOpaqueModuleProvider}
struct LLVMOpaquePassManager end
const LLVMPassManagerRef = Ptr{LLVMOpaquePassManager}
struct LLVMOpaquePassRegistry end
const LLVMPassRegistryRef = Ptr{LLVMOpaquePassRegistry}
struct LLVMOpaqueUse end
const LLVMUseRef = Ptr{LLVMOpaqueUse}
struct LLVMOpaqueAttributeRef end
const LLVMAttributeRef = Ptr{LLVMOpaqueAttributeRef}
struct LLVMOpaqueDiagnosticInfo end
const LLVMDiagnosticInfoRef = Ptr{LLVMOpaqueDiagnosticInfo}
const LLVMComdat = Cvoid
const LLVMComdatRef = Ptr{LLVMComdat}
struct LLVMOpaqueModuleFlagEntry end
const LLVMModuleFlagEntry = LLVMOpaqueModuleFlagEntry
struct LLVMOpaqueJITEventListener end
const LLVMJITEventListenerRef = Ptr{LLVMOpaqueJITEventListener}
struct LLVMOpaqueBinary end
const LLVMBinaryRef = Ptr{LLVMOpaqueBinary}

@cenum LLVMVerifierFailureAction::UInt32 begin
    LLVMAbortProcessAction = 0
    LLVMPrintMessageAction = 1
    LLVMReturnStatusAction = 2
end

@cenum LLVMComdatSelectionKind::UInt32 begin
    LLVMAnyComdatSelectionKind = 0
    LLVMExactMatchComdatSelectionKind = 1
    LLVMLargestComdatSelectionKind = 2
    LLVMNoDuplicatesComdatSelectionKind = 3
    LLVMSameSizeComdatSelectionKind = 4
end

const LLVMFatalErrorHandler = Ptr{Cvoid}

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

# the following isn't defined as a regular enum in llvm-c, so Clang.jl fails to pick it up
@cenum LLVMAttributeIndex::UInt32 begin
    LLVMAttributeReturnIndex = 0
    LLVMAttributeFunctionIndex = reinterpret(UInt32, Int32(-1))
end

const LLVMDiagnosticHandler = Ptr{Cvoid}
const LLVMYieldCallback = Ptr{Cvoid}

@cenum LLVMDIFlags::UInt32 begin
    LLVMDIFlagZero = 0
    LLVMDIFlagPrivate = 1
    LLVMDIFlagProtected = 2
    LLVMDIFlagPublic = 3
    LLVMDIFlagFwdDecl = 4
    LLVMDIFlagAppleBlock = 8
    LLVMDIFlagBlockByrefStruct = 16
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

const LLVMMetadataKind = UInt32
const LLVMDWARFTypeEncoding = UInt32
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
const LLVMDisassembler_Option_UseMarkup = 1
const LLVMDisassembler_Option_PrintImmHex = 2
const LLVMDisassembler_Option_AsmPrinterVariant = 4
const LLVMDisassembler_Option_SetInstrComments = 8
const LLVMDisassembler_Option_PrintLatency = 16
const LLVMDisasmContextRef = Ptr{Cvoid}
const LLVMOpInfoCallback = Ptr{Cvoid}

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

const LLVMSymbolLookupCallback = Ptr{Cvoid}
const LLVMErrorSuccess = 0
struct LLVMOpaqueError end
const LLVMErrorRef = Ptr{LLVMOpaqueError}
const LLVMErrorTypeId = Ptr{Cvoid}

@cenum LLVMByteOrdering::UInt32 begin
    LLVMBigEndian = 0
    LLVMLittleEndian = 1
end

struct LLVMOpaqueTargetData end
const LLVMTargetDataRef = Ptr{LLVMOpaqueTargetData}
struct LLVMOpaqueTargetLibraryInfotData end
const LLVMTargetLibraryInfoRef = Ptr{LLVMOpaqueTargetLibraryInfotData}
struct LLVMOpaqueTargetMachine end
const LLVMTargetMachineRef = Ptr{LLVMOpaqueTargetMachine}
const LLVMTarget = Cvoid
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

@cenum LLVMCodeModel::UInt32 begin
    LLVMCodeModelDefault = 0
    LLVMCodeModelJITDefault = 1
    LLVMCodeModelTiny = 2
    LLVMCodeModelSmall = 3
    LLVMCodeModelKernel = 4
    LLVMCodeModelMedium = 5
    LLVMCodeModelLarge = 6
end

@cenum LLVMCodeGenFileType::UInt32 begin
    LLVMAssemblyFile = 0
    LLVMObjectFile = 1
end

struct LLVMOpaqueGenericValue end
const LLVMGenericValueRef = Ptr{LLVMOpaqueGenericValue}
struct LLVMOpaqueExecutionEngine end
const LLVMExecutionEngineRef = Ptr{LLVMOpaqueExecutionEngine}
struct LLVMOpaqueMCJITMemoryManager end
const LLVMMCJITMemoryManagerRef = Ptr{LLVMOpaqueMCJITMemoryManager}

struct LLVMMCJITCompilerOptions
    OptLevel::UInt32
    CodeModel::LLVMCodeModel
    NoFramePointerElim::LLVMBool
    EnableFastISel::LLVMBool
    MCJMM::LLVMMCJITMemoryManagerRef
end

const LLVMMemoryManagerAllocateCodeSectionCallback = Ptr{Cvoid}
const LLVMMemoryManagerAllocateDataSectionCallback = Ptr{Cvoid}
const LLVMMemoryManagerFinalizeMemoryCallback = Ptr{Cvoid}
const LLVMMemoryManagerDestroyCallback = Ptr{Cvoid}
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

@cenum LLVMLinkerMode::UInt32 begin
    LLVMLinkerDestroySource = 0
    LLVMLinkerPreserveSource_Removed = 1
end

struct LLVMOpaqueSectionIterator end
const LLVMSectionIteratorRef = Ptr{LLVMOpaqueSectionIterator}
struct LLVMOpaqueSymbolIterator end
const LLVMSymbolIteratorRef = Ptr{LLVMOpaqueSymbolIterator}
struct LLVMOpaqueRelocationIterator end
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

struct LLVMOpaqueObjectFile end
const LLVMObjectFileRef = Ptr{LLVMOpaqueObjectFile}
const OPT_REMARKS_API_VERSION = 0

struct LLVMOptRemarkStringRef
    Str::Cstring
    Len::UInt32
end

struct LLVMOptRemarkDebugLoc
    SourceFile::LLVMOptRemarkStringRef
    SourceLineNumber::UInt32
    SourceColumnNumber::UInt32
end

struct LLVMOptRemarkArg
    Key::LLVMOptRemarkStringRef
    Value::LLVMOptRemarkStringRef
    DebugLoc::LLVMOptRemarkDebugLoc
end

struct LLVMOptRemarkEntry
    RemarkType::LLVMOptRemarkStringRef
    PassName::LLVMOptRemarkStringRef
    RemarkName::LLVMOptRemarkStringRef
    FunctionName::LLVMOptRemarkStringRef
    DebugLoc::LLVMOptRemarkDebugLoc
    Hotness::UInt32
    NumArgs::UInt32
    Args::Ptr{LLVMOptRemarkArg}
end

const LLVMOptRemarkOpaqueParser = Cvoid
const LLVMOptRemarkParserRef = Ptr{LLVMOptRemarkOpaqueParser}
const LLVMOrcOpaqueJITStack = Cvoid
const LLVMOrcJITStackRef = Ptr{LLVMOrcOpaqueJITStack}
const LLVMOrcModuleHandle = UInt64
const LLVMOrcTargetAddress = UInt64
const LLVMOrcSymbolResolverFn = Ptr{Cvoid}
const LLVMOrcLazyCompileCallbackFn = Ptr{Cvoid}
const REMARKS_API_VERSION = 0

@cenum LLVMRemarkType::UInt32 begin
    LLVMRemarkTypeUnknown = 0
    LLVMRemarkTypePassed = 1
    LLVMRemarkTypeMissed = 2
    LLVMRemarkTypeAnalysis = 3
    LLVMRemarkTypeAnalysisFPCommute = 4
    LLVMRemarkTypeAnalysisAliasing = 5
    LLVMRemarkTypeFailure = 6
end

const LLVMRemarkOpaqueString = Cvoid
const LLVMRemarkStringRef = Ptr{LLVMRemarkOpaqueString}
const LLVMRemarkOpaqueDebugLoc = Cvoid
const LLVMRemarkDebugLocRef = Ptr{LLVMRemarkOpaqueDebugLoc}
const LLVMRemarkOpaqueArg = Cvoid
const LLVMRemarkArgRef = Ptr{LLVMRemarkOpaqueArg}
const LLVMRemarkOpaqueEntry = Cvoid
const LLVMRemarkEntryRef = Ptr{LLVMRemarkOpaqueEntry}
const LLVMRemarkOpaqueParser = Cvoid
const LLVMRemarkParserRef = Ptr{LLVMRemarkOpaqueParser}
const LTO_API_VERSION = 24
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

struct LLVMOpaqueLTOModule end
const lto_module_t = Ptr{LLVMOpaqueLTOModule}
struct LLVMOpaqueLTOCodeGenerator end
const lto_code_gen_t = Ptr{LLVMOpaqueLTOCodeGenerator}
struct LLVMOpaqueThinLTOCodeGenerator end
const thinlto_code_gen_t = Ptr{LLVMOpaqueThinLTOCodeGenerator}

@cenum lto_codegen_diagnostic_severity_t::UInt32 begin
    LTO_DS_ERROR = 0
    LTO_DS_WARNING = 1
    LTO_DS_REMARK = 3
    LTO_DS_NOTE = 2
end

const lto_diagnostic_handler_t = Ptr{Cvoid}

struct LTOObjectBuffer
    Buffer::Cstring
    Size::Csize_t
end

struct LLVMOpaqueLTOInput end
const lto_input_t = Ptr{LLVMOpaqueLTOInput}
struct LLVMOpaquePassManagerBuilder end
const LLVMPassManagerBuilderRef = Ptr{LLVMOpaquePassManagerBuilder}
