# Automatically generated using Clang.jl wrap_c, version 0.1.0


const LLVMFatalErrorHandler = Ptr{Cvoid}

const LLVMBool = Cint

mutable struct LLVMOpaqueMemoryBuffer
end

const LLVMMemoryBufferRef = Ptr{LLVMOpaqueMemoryBuffer}

mutable struct LLVMOpaqueContext
end

const LLVMContextRef = Ptr{LLVMOpaqueContext}

mutable struct LLVMOpaqueModule
end

const LLVMModuleRef = Ptr{LLVMOpaqueModule}

mutable struct LLVMOpaqueType
end

const LLVMTypeRef = Ptr{LLVMOpaqueType}

mutable struct LLVMOpaqueValue
end

const LLVMValueRef = Ptr{LLVMOpaqueValue}

mutable struct LLVMOpaqueBasicBlock
end

const LLVMBasicBlockRef = Ptr{LLVMOpaqueBasicBlock}

mutable struct LLVMOpaqueBuilder
end

const LLVMBuilderRef = Ptr{LLVMOpaqueBuilder}

mutable struct LLVMOpaqueModuleProvider
end

const LLVMModuleProviderRef = Ptr{LLVMOpaqueModuleProvider}

mutable struct LLVMOpaquePassManager
end

const LLVMPassManagerRef = Ptr{LLVMOpaquePassManager}

mutable struct LLVMOpaquePassRegistry
end

const LLVMPassRegistryRef = Ptr{LLVMOpaquePassRegistry}

mutable struct LLVMOpaqueUse
end

const LLVMUseRef = Ptr{LLVMOpaqueUse}

mutable struct LLVMOpaqueAttributeRef
end

const LLVMAttributeRef = Ptr{LLVMOpaqueAttributeRef}

mutable struct LLVMOpaqueDiagnosticInfo
end

const LLVMDiagnosticInfoRef = Ptr{LLVMOpaqueDiagnosticInfo}

mutable struct LLVMOpaqueObjectFile
end

const LLVMObjectFileRef = Ptr{LLVMOpaqueObjectFile}

mutable struct LLVMOpaqueSectionIterator
end

const LLVMSectionIteratorRef = Ptr{LLVMOpaqueSectionIterator}

mutable struct LLVMOpaqueSymbolIterator
end

const LLVMSymbolIteratorRef = Ptr{LLVMOpaqueSymbolIterator}

mutable struct LLVMOpaqueRelocationIterator
end

const LLVMRelocationIteratorRef = Ptr{LLVMOpaqueRelocationIterator}

# Skipping MacroDefinition: LLVM_TARGET ( TargetName ) void LLVMInitialize ## TargetName ## TargetInfo ( void ) ;
# Skipping MacroDefinition: LLVM_TARGET ( TargetName ) void LLVMInitialize ## TargetName ## Target ( void ) ;
# Skipping MacroDefinition: LLVM_TARGET ( TargetName ) void LLVMInitialize ## TargetName ## TargetMC ( void ) ;
# Skipping MacroDefinition: LLVM_ASM_PRINTER ( TargetName ) void LLVMInitialize ## TargetName ## AsmPrinter ( void ) ;
# Skipping MacroDefinition: LLVM_ASM_PARSER ( TargetName ) void LLVMInitialize ## TargetName ## AsmParser ( void ) ;
# Skipping MacroDefinition: LLVM_DISASSEMBLER ( TargetName ) void LLVMInitialize ## TargetName ## Disassembler ( void ) ;
# Skipping MacroDefinition: LLVM_TARGET ( TargetName ) LLVMInitialize ## TargetName ## TargetInfo ( ) ;
# Skipping MacroDefinition: LLVM_TARGET ( TargetName ) LLVMInitialize ## TargetName ## Target ( ) ;
# Skipping MacroDefinition: LLVM_TARGET ( TargetName ) LLVMInitialize ## TargetName ## TargetMC ( ) ;
# Skipping MacroDefinition: LLVM_ASM_PRINTER ( TargetName ) LLVMInitialize ## TargetName ## AsmPrinter ( ) ;
# Skipping MacroDefinition: LLVM_ASM_PARSER ( TargetName ) LLVMInitialize ## TargetName ## AsmParser ( ) ;
# Skipping MacroDefinition: LLVM_DISASSEMBLER ( TargetName ) LLVMInitialize ## TargetName ## Disassembler ( ) ;

# begin enum LLVMByteOrdering
const LLVMByteOrdering = UInt32
const LLVMBigEndian = (UInt32)(0)
const LLVMLittleEndian = (UInt32)(1)
# end enum LLVMByteOrdering

mutable struct LLVMOpaqueTargetData
end

const LLVMTargetDataRef = Ptr{LLVMOpaqueTargetData}

mutable struct LLVMOpaqueTargetLibraryInfotData
end

const LLVMTargetLibraryInfoRef = Ptr{LLVMOpaqueTargetLibraryInfotData}

mutable struct LLVMOpaqueTargetMachine
end

const LLVMTargetMachineRef = Ptr{LLVMOpaqueTargetMachine}

mutable struct LLVMTarget
end

const LLVMTargetRef = Ptr{LLVMTarget}

# begin enum LLVMCodeGenOptLevel
const LLVMCodeGenOptLevel = UInt32
const LLVMCodeGenLevelNone = (UInt32)(0)
const LLVMCodeGenLevelLess = (UInt32)(1)
const LLVMCodeGenLevelDefault = (UInt32)(2)
const LLVMCodeGenLevelAggressive = (UInt32)(3)
# end enum LLVMCodeGenOptLevel

# begin enum LLVMRelocMode
const LLVMRelocMode = UInt32
const LLVMRelocDefault = (UInt32)(0)
const LLVMRelocStatic = (UInt32)(1)
const LLVMRelocPIC = (UInt32)(2)
const LLVMRelocDynamicNoPic = (UInt32)(3)
# end enum LLVMRelocMode

# begin enum LLVMCodeModel
const LLVMCodeModel = UInt32
const LLVMCodeModelDefault = (UInt32)(0)
const LLVMCodeModelJITDefault = (UInt32)(1)
const LLVMCodeModelSmall = (UInt32)(2)
const LLVMCodeModelKernel = (UInt32)(3)
const LLVMCodeModelMedium = (UInt32)(4)
const LLVMCodeModelLarge = (UInt32)(5)
# end enum LLVMCodeModel

# begin enum LLVMCodeGenFileType
const LLVMCodeGenFileType = UInt32
const LLVMAssemblyFile = (UInt32)(0)
const LLVMObjectFile = (UInt32)(1)
# end enum LLVMCodeGenFileType

# begin enum LLVMVerifierFailureAction
const LLVMVerifierFailureAction = UInt32
const LLVMAbortProcessAction = (UInt32)(0)
const LLVMPrintMessageAction = (UInt32)(1)
const LLVMReturnStatusAction = (UInt32)(2)
# end enum LLVMVerifierFailureAction

# Skipping MacroDefinition: LLVM_FOR_EACH_VALUE_SUBCLASS ( macro ) macro ( Argument ) macro ( BasicBlock ) macro ( InlineAsm ) macro ( User ) macro ( Constant ) macro ( BlockAddress ) macro ( ConstantAggregateZero ) macro ( ConstantArray ) macro ( ConstantDataSequential ) macro ( ConstantDataArray ) macro ( ConstantDataVector ) macro ( ConstantExpr ) macro ( ConstantFP ) macro ( ConstantInt ) macro ( ConstantPointerNull ) macro ( ConstantStruct ) macro ( ConstantTokenNone ) macro ( ConstantVector ) macro ( GlobalValue ) macro ( GlobalAlias ) macro ( GlobalObject ) macro ( Function ) macro ( GlobalVariable ) macro ( UndefValue ) macro ( Instruction ) macro ( BinaryOperator ) macro ( CallInst ) macro ( IntrinsicInst ) macro ( DbgInfoIntrinsic ) macro ( DbgDeclareInst ) macro ( MemIntrinsic ) macro ( MemCpyInst ) macro ( MemMoveInst ) macro ( MemSetInst ) macro ( CmpInst ) macro ( FCmpInst ) macro ( ICmpInst ) macro ( ExtractElementInst ) macro ( GetElementPtrInst ) macro ( InsertElementInst ) macro ( InsertValueInst ) macro ( LandingPadInst ) macro ( PHINode ) macro ( SelectInst ) macro ( ShuffleVectorInst ) macro ( StoreInst ) macro ( TerminatorInst ) macro ( BranchInst ) macro ( IndirectBrInst ) macro ( InvokeInst ) macro ( ReturnInst ) macro ( SwitchInst ) macro ( UnreachableInst ) macro ( ResumeInst ) macro ( CleanupReturnInst ) macro ( CatchReturnInst ) macro ( FuncletPadInst ) macro ( CatchPadInst ) macro ( CleanupPadInst ) macro ( UnaryInstruction ) macro ( AllocaInst ) macro ( CastInst ) macro ( AddrSpaceCastInst ) macro ( BitCastInst ) macro ( FPExtInst ) macro ( FPToSIInst ) macro ( FPToUIInst ) macro ( FPTruncInst ) macro ( IntToPtrInst ) macro ( PtrToIntInst ) macro ( SExtInst ) macro ( SIToFPInst ) macro ( TruncInst ) macro ( UIToFPInst ) macro ( ZExtInst ) macro ( ExtractValueInst ) macro ( LoadInst ) macro ( VAArgInst )
# Skipping MacroDefinition: LLVM_DECLARE_VALUE_CAST ( name ) LLVMValueRef LLVMIsA ## name ( LLVMValueRef Val ) ;

# begin enum LLVMAttribute
const LLVMAttribute = Cint
const LLVMZExtAttribute = (Int32)(1)
const LLVMSExtAttribute = (Int32)(2)
const LLVMNoReturnAttribute = (Int32)(4)
const LLVMInRegAttribute = (Int32)(8)
const LLVMStructRetAttribute = (Int32)(16)
const LLVMNoUnwindAttribute = (Int32)(32)
const LLVMNoAliasAttribute = (Int32)(64)
const LLVMByValAttribute = (Int32)(128)
const LLVMNestAttribute = (Int32)(256)
const LLVMReadNoneAttribute = (Int32)(512)
const LLVMReadOnlyAttribute = (Int32)(1024)
const LLVMNoInlineAttribute = (Int32)(2048)
const LLVMAlwaysInlineAttribute = (Int32)(4096)
const LLVMOptimizeForSizeAttribute = (Int32)(8192)
const LLVMStackProtectAttribute = (Int32)(16384)
const LLVMStackProtectReqAttribute = (Int32)(32768)
const LLVMAlignment = (Int32)(2031616)
const LLVMNoCaptureAttribute = (Int32)(2097152)
const LLVMNoRedZoneAttribute = (Int32)(4194304)
const LLVMNoImplicitFloatAttribute = (Int32)(8388608)
const LLVMNakedAttribute = (Int32)(16777216)
const LLVMInlineHintAttribute = (Int32)(33554432)
const LLVMStackAlignment = (Int32)(469762048)
const LLVMReturnsTwice = (Int32)(536870912)
const LLVMUWTable = (Int32)(1073741824)
const LLVMNonLazyBind = (Int32)(-2147483648)
# end enum LLVMAttribute

# begin enum LLVMOpcode
const LLVMOpcode = UInt32
const LLVMRet = (UInt32)(1)
const LLVMBr = (UInt32)(2)
const LLVMSwitch = (UInt32)(3)
const LLVMIndirectBr = (UInt32)(4)
const LLVMInvoke = (UInt32)(5)
const LLVMUnreachable = (UInt32)(7)
const LLVMAdd = (UInt32)(8)
const LLVMFAdd = (UInt32)(9)
const LLVMSub = (UInt32)(10)
const LLVMFSub = (UInt32)(11)
const LLVMMul = (UInt32)(12)
const LLVMFMul = (UInt32)(13)
const LLVMUDiv = (UInt32)(14)
const LLVMSDiv = (UInt32)(15)
const LLVMFDiv = (UInt32)(16)
const LLVMURem = (UInt32)(17)
const LLVMSRem = (UInt32)(18)
const LLVMFRem = (UInt32)(19)
const LLVMShl = (UInt32)(20)
const LLVMLShr = (UInt32)(21)
const LLVMAShr = (UInt32)(22)
const LLVMAnd = (UInt32)(23)
const LLVMOr = (UInt32)(24)
const LLVMXor = (UInt32)(25)
const LLVMAlloca = (UInt32)(26)
const LLVMLoad = (UInt32)(27)
const LLVMStore = (UInt32)(28)
const LLVMGetElementPtr = (UInt32)(29)
const LLVMTrunc = (UInt32)(30)
const LLVMZExt = (UInt32)(31)
const LLVMSExt = (UInt32)(32)
const LLVMFPToUI = (UInt32)(33)
const LLVMFPToSI = (UInt32)(34)
const LLVMUIToFP = (UInt32)(35)
const LLVMSIToFP = (UInt32)(36)
const LLVMFPTrunc = (UInt32)(37)
const LLVMFPExt = (UInt32)(38)
const LLVMPtrToInt = (UInt32)(39)
const LLVMIntToPtr = (UInt32)(40)
const LLVMBitCast = (UInt32)(41)
const LLVMAddrSpaceCast = (UInt32)(60)
const LLVMICmp = (UInt32)(42)
const LLVMFCmp = (UInt32)(43)
const LLVMPHI = (UInt32)(44)
const LLVMCall = (UInt32)(45)
const LLVMSelect = (UInt32)(46)
const LLVMUserOp1 = (UInt32)(47)
const LLVMUserOp2 = (UInt32)(48)
const LLVMVAArg = (UInt32)(49)
const LLVMExtractElement = (UInt32)(50)
const LLVMInsertElement = (UInt32)(51)
const LLVMShuffleVector = (UInt32)(52)
const LLVMExtractValue = (UInt32)(53)
const LLVMInsertValue = (UInt32)(54)
const LLVMFence = (UInt32)(55)
const LLVMAtomicCmpXchg = (UInt32)(56)
const LLVMAtomicRMW = (UInt32)(57)
const LLVMResume = (UInt32)(58)
const LLVMLandingPad = (UInt32)(59)
const LLVMCleanupRet = (UInt32)(61)
const LLVMCatchRet = (UInt32)(62)
const LLVMCatchPad = (UInt32)(63)
const LLVMCleanupPad = (UInt32)(64)
const LLVMCatchSwitch = (UInt32)(65)
# end enum LLVMOpcode

# begin enum LLVMTypeKind
const LLVMTypeKind = UInt32
const LLVMVoidTypeKind = (UInt32)(0)
const LLVMHalfTypeKind = (UInt32)(1)
const LLVMFloatTypeKind = (UInt32)(2)
const LLVMDoubleTypeKind = (UInt32)(3)
const LLVMX86_FP80TypeKind = (UInt32)(4)
const LLVMFP128TypeKind = (UInt32)(5)
const LLVMPPC_FP128TypeKind = (UInt32)(6)
const LLVMLabelTypeKind = (UInt32)(7)
const LLVMIntegerTypeKind = (UInt32)(8)
const LLVMFunctionTypeKind = (UInt32)(9)
const LLVMStructTypeKind = (UInt32)(10)
const LLVMArrayTypeKind = (UInt32)(11)
const LLVMPointerTypeKind = (UInt32)(12)
const LLVMVectorTypeKind = (UInt32)(13)
const LLVMMetadataTypeKind = (UInt32)(14)
const LLVMX86_MMXTypeKind = (UInt32)(15)
const LLVMTokenTypeKind = (UInt32)(16)
# end enum LLVMTypeKind

# begin enum LLVMLinkage
const LLVMLinkage = UInt32
const LLVMExternalLinkage = (UInt32)(0)
const LLVMAvailableExternallyLinkage = (UInt32)(1)
const LLVMLinkOnceAnyLinkage = (UInt32)(2)
const LLVMLinkOnceODRLinkage = (UInt32)(3)
const LLVMLinkOnceODRAutoHideLinkage = (UInt32)(4)
const LLVMWeakAnyLinkage = (UInt32)(5)
const LLVMWeakODRLinkage = (UInt32)(6)
const LLVMAppendingLinkage = (UInt32)(7)
const LLVMInternalLinkage = (UInt32)(8)
const LLVMPrivateLinkage = (UInt32)(9)
const LLVMDLLImportLinkage = (UInt32)(10)
const LLVMDLLExportLinkage = (UInt32)(11)
const LLVMExternalWeakLinkage = (UInt32)(12)
const LLVMGhostLinkage = (UInt32)(13)
const LLVMCommonLinkage = (UInt32)(14)
const LLVMLinkerPrivateLinkage = (UInt32)(15)
const LLVMLinkerPrivateWeakLinkage = (UInt32)(16)
# end enum LLVMLinkage

# begin enum LLVMVisibility
const LLVMVisibility = UInt32
const LLVMDefaultVisibility = (UInt32)(0)
const LLVMHiddenVisibility = (UInt32)(1)
const LLVMProtectedVisibility = (UInt32)(2)
# end enum LLVMVisibility

# begin enum LLVMDLLStorageClass
const LLVMDLLStorageClass = UInt32
const LLVMDefaultStorageClass = (UInt32)(0)
const LLVMDLLImportStorageClass = (UInt32)(1)
const LLVMDLLExportStorageClass = (UInt32)(2)
# end enum LLVMDLLStorageClass

# begin enum LLVMCallConv
const LLVMCallConv = UInt32
const LLVMCCallConv = (UInt32)(0)
const LLVMFastCallConv = (UInt32)(8)
const LLVMColdCallConv = (UInt32)(9)
const LLVMWebKitJSCallConv = (UInt32)(12)
const LLVMAnyRegCallConv = (UInt32)(13)
const LLVMX86StdcallCallConv = (UInt32)(64)
const LLVMX86FastcallCallConv = (UInt32)(65)
# end enum LLVMCallConv

# begin enum LLVMValueKind
const LLVMValueKind = UInt32
const LLVMArgumentValueKind = (UInt32)(0)
const LLVMBasicBlockValueKind = (UInt32)(1)
const LLVMMemoryUseValueKind = (UInt32)(2)
const LLVMMemoryDefValueKind = (UInt32)(3)
const LLVMMemoryPhiValueKind = (UInt32)(4)
const LLVMFunctionValueKind = (UInt32)(5)
const LLVMGlobalAliasValueKind = (UInt32)(6)
const LLVMGlobalIFuncValueKind = (UInt32)(7)
const LLVMGlobalVariableValueKind = (UInt32)(8)
const LLVMBlockAddressValueKind = (UInt32)(9)
const LLVMConstantExprValueKind = (UInt32)(10)
const LLVMConstantArrayValueKind = (UInt32)(11)
const LLVMConstantStructValueKind = (UInt32)(12)
const LLVMConstantVectorValueKind = (UInt32)(13)
const LLVMUndefValueValueKind = (UInt32)(14)
const LLVMConstantAggregateZeroValueKind = (UInt32)(15)
const LLVMConstantDataArrayValueKind = (UInt32)(16)
const LLVMConstantDataVectorValueKind = (UInt32)(17)
const LLVMConstantIntValueKind = (UInt32)(18)
const LLVMConstantFPValueKind = (UInt32)(19)
const LLVMConstantPointerNullValueKind = (UInt32)(20)
const LLVMConstantTokenNoneValueKind = (UInt32)(21)
const LLVMMetadataAsValueValueKind = (UInt32)(22)
const LLVMInlineAsmValueKind = (UInt32)(23)
const LLVMInstructionValueKind = (UInt32)(24)
# end enum LLVMValueKind

# begin enum LLVMIntPredicate
const LLVMIntPredicate = UInt32
const LLVMIntEQ = (UInt32)(32)
const LLVMIntNE = (UInt32)(33)
const LLVMIntUGT = (UInt32)(34)
const LLVMIntUGE = (UInt32)(35)
const LLVMIntULT = (UInt32)(36)
const LLVMIntULE = (UInt32)(37)
const LLVMIntSGT = (UInt32)(38)
const LLVMIntSGE = (UInt32)(39)
const LLVMIntSLT = (UInt32)(40)
const LLVMIntSLE = (UInt32)(41)
# end enum LLVMIntPredicate

# begin enum LLVMRealPredicate
const LLVMRealPredicate = UInt32
const LLVMRealPredicateFalse = (UInt32)(0)
const LLVMRealOEQ = (UInt32)(1)
const LLVMRealOGT = (UInt32)(2)
const LLVMRealOGE = (UInt32)(3)
const LLVMRealOLT = (UInt32)(4)
const LLVMRealOLE = (UInt32)(5)
const LLVMRealONE = (UInt32)(6)
const LLVMRealORD = (UInt32)(7)
const LLVMRealUNO = (UInt32)(8)
const LLVMRealUEQ = (UInt32)(9)
const LLVMRealUGT = (UInt32)(10)
const LLVMRealUGE = (UInt32)(11)
const LLVMRealULT = (UInt32)(12)
const LLVMRealULE = (UInt32)(13)
const LLVMRealUNE = (UInt32)(14)
const LLVMRealPredicateTrue = (UInt32)(15)
# end enum LLVMRealPredicate

# begin enum LLVMLandingPadClauseTy
const LLVMLandingPadClauseTy = UInt32
const LLVMLandingPadCatch = (UInt32)(0)
const LLVMLandingPadFilter = (UInt32)(1)
# end enum LLVMLandingPadClauseTy

# begin enum LLVMThreadLocalMode
const LLVMThreadLocalMode = UInt32
const LLVMNotThreadLocal = (UInt32)(0)
const LLVMGeneralDynamicTLSModel = (UInt32)(1)
const LLVMLocalDynamicTLSModel = (UInt32)(2)
const LLVMInitialExecTLSModel = (UInt32)(3)
const LLVMLocalExecTLSModel = (UInt32)(4)
# end enum LLVMThreadLocalMode

# begin enum LLVMAtomicOrdering
const LLVMAtomicOrdering = UInt32
const LLVMAtomicOrderingNotAtomic = (UInt32)(0)
const LLVMAtomicOrderingUnordered = (UInt32)(1)
const LLVMAtomicOrderingMonotonic = (UInt32)(2)
const LLVMAtomicOrderingAcquire = (UInt32)(4)
const LLVMAtomicOrderingRelease = (UInt32)(5)
const LLVMAtomicOrderingAcquireRelease = (UInt32)(6)
const LLVMAtomicOrderingSequentiallyConsistent = (UInt32)(7)
# end enum LLVMAtomicOrdering

# begin enum LLVMAtomicRMWBinOp
const LLVMAtomicRMWBinOp = UInt32
const LLVMAtomicRMWBinOpXchg = (UInt32)(0)
const LLVMAtomicRMWBinOpAdd = (UInt32)(1)
const LLVMAtomicRMWBinOpSub = (UInt32)(2)
const LLVMAtomicRMWBinOpAnd = (UInt32)(3)
const LLVMAtomicRMWBinOpNand = (UInt32)(4)
const LLVMAtomicRMWBinOpOr = (UInt32)(5)
const LLVMAtomicRMWBinOpXor = (UInt32)(6)
const LLVMAtomicRMWBinOpMax = (UInt32)(7)
const LLVMAtomicRMWBinOpMin = (UInt32)(8)
const LLVMAtomicRMWBinOpUMax = (UInt32)(9)
const LLVMAtomicRMWBinOpUMin = (UInt32)(10)
# end enum LLVMAtomicRMWBinOp

# begin enum LLVMDiagnosticSeverity
const LLVMDiagnosticSeverity = UInt32
const LLVMDSError = (UInt32)(0)
const LLVMDSWarning = (UInt32)(1)
const LLVMDSRemark = (UInt32)(2)
const LLVMDSNote = (UInt32)(3)
# end enum LLVMDiagnosticSeverity

# begin enum LLVMAttributeIndex
const LLVMAttributeIndex = UInt32
const LLVMAttributeReturnIndex = (UInt32)(0)
const LLVMAttributeFunctionIndex = reinterpret(UInt32, Int32(-1))
# end enum LLVMAttributeIndex

const LLVMDiagnosticHandler = Ptr{Cvoid}
const LLVMYieldCallback = Ptr{Cvoid}

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

mutable struct LLVMOpInfoSymbol1
    Present::UInt64
    Name::Cstring
    Value::UInt64
end

mutable struct LLVMOpInfo1
    AddSymbol::LLVMOpInfoSymbol1
    SubtractSymbol::LLVMOpInfoSymbol1
    Value::UInt64
    VariantKind::UInt64
end

const LLVMSymbolLookupCallback = Ptr{Cvoid}

mutable struct LLVMOpaqueGenericValue
end

const LLVMGenericValueRef = Ptr{LLVMOpaqueGenericValue}

mutable struct LLVMOpaqueExecutionEngine
end

const LLVMExecutionEngineRef = Ptr{LLVMOpaqueExecutionEngine}

mutable struct LLVMOpaqueMCJITMemoryManager
end

const LLVMMCJITMemoryManagerRef = Ptr{LLVMOpaqueMCJITMemoryManager}

mutable struct LLVMMCJITCompilerOptions
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

# begin enum LLVMLinkerMode
const LLVMLinkerMode = UInt32
const LLVMLinkerDestroySource = (UInt32)(0)
const LLVMLinkerPreserveSource_Removed = (UInt32)(1)
# end enum LLVMLinkerMode

const off_t  = Csize_t
const llvm_lto_t = Ptr{Cvoid}

# begin enum llvm_lto_status_t
const llvm_lto_status_t = UInt32
const LLVM_LTO_UNKNOWN = (UInt32)(0)
const LLVM_LTO_OPT_SUCCESS = (UInt32)(1)
const LLVM_LTO_READ_SUCCESS = (UInt32)(2)
const LLVM_LTO_READ_FAILURE = (UInt32)(3)
const LLVM_LTO_WRITE_FAILURE = (UInt32)(4)
const LLVM_LTO_NO_TARGET = (UInt32)(5)
const LLVM_LTO_NO_WORK = (UInt32)(6)
const LLVM_LTO_MODULE_MERGE_FAILURE = (UInt32)(7)
const LLVM_LTO_ASM_FAILURE = (UInt32)(8)
const LLVM_LTO_NULL_OBJECT = (UInt32)(9)
# end enum llvm_lto_status_t

const LTO_API_VERSION = 20

const lto_bool_t = Bool

# begin enum lto_symbol_attributes
const lto_symbol_attributes = UInt32
const LTO_SYMBOL_ALIGNMENT_MASK = (UInt32)(31)
const LTO_SYMBOL_PERMISSIONS_MASK = (UInt32)(224)
const LTO_SYMBOL_PERMISSIONS_CODE = (UInt32)(160)
const LTO_SYMBOL_PERMISSIONS_DATA = (UInt32)(192)
const LTO_SYMBOL_PERMISSIONS_RODATA = (UInt32)(128)
const LTO_SYMBOL_DEFINITION_MASK = (UInt32)(1792)
const LTO_SYMBOL_DEFINITION_REGULAR = (UInt32)(256)
const LTO_SYMBOL_DEFINITION_TENTATIVE = (UInt32)(512)
const LTO_SYMBOL_DEFINITION_WEAK = (UInt32)(768)
const LTO_SYMBOL_DEFINITION_UNDEFINED = (UInt32)(1024)
const LTO_SYMBOL_DEFINITION_WEAKUNDEF = (UInt32)(1280)
const LTO_SYMBOL_SCOPE_MASK = (UInt32)(14336)
const LTO_SYMBOL_SCOPE_INTERNAL = (UInt32)(2048)
const LTO_SYMBOL_SCOPE_HIDDEN = (UInt32)(4096)
const LTO_SYMBOL_SCOPE_PROTECTED = (UInt32)(8192)
const LTO_SYMBOL_SCOPE_DEFAULT = (UInt32)(6144)
const LTO_SYMBOL_SCOPE_DEFAULT_CAN_BE_HIDDEN = (UInt32)(10240)
const LTO_SYMBOL_COMDAT = (UInt32)(16384)
const LTO_SYMBOL_ALIAS = (UInt32)(32768)
# end enum lto_symbol_attributes

# begin enum lto_debug_model
const lto_debug_model = UInt32
const LTO_DEBUG_MODEL_NONE = (UInt32)(0)
const LTO_DEBUG_MODEL_DWARF = (UInt32)(1)
# end enum lto_debug_model

# begin enum lto_codegen_model
const lto_codegen_model = UInt32
const LTO_CODEGEN_PIC_MODEL_STATIC = (UInt32)(0)
const LTO_CODEGEN_PIC_MODEL_DYNAMIC = (UInt32)(1)
const LTO_CODEGEN_PIC_MODEL_DYNAMIC_NO_PIC = (UInt32)(2)
const LTO_CODEGEN_PIC_MODEL_DEFAULT = (UInt32)(3)
# end enum lto_codegen_model

mutable struct LLVMOpaqueLTOModule
end

const lto_module_t = Ptr{LLVMOpaqueLTOModule}

mutable struct LLVMOpaqueLTOCodeGenerator
end

const lto_code_gen_t = Ptr{LLVMOpaqueLTOCodeGenerator}

mutable struct LLVMOpaqueThinLTOCodeGenerator
end

const thinlto_code_gen_t = Ptr{LLVMOpaqueThinLTOCodeGenerator}

# begin enum lto_codegen_diagnostic_severity_t
const lto_codegen_diagnostic_severity_t = UInt32
const LTO_DS_ERROR = (UInt32)(0)
const LTO_DS_WARNING = (UInt32)(1)
const LTO_DS_REMARK = (UInt32)(3)
const LTO_DS_NOTE = (UInt32)(2)
# end enum lto_codegen_diagnostic_severity_t

const lto_diagnostic_handler_t = Ptr{Cvoid}

mutable struct LTOObjectBuffer
    Buffer::Cstring
    Size::Csize_t
end

mutable struct LLVMOrcOpaqueJITStack
end

const LLVMOrcJITStackRef = Ptr{LLVMOrcOpaqueJITStack}
const LLVMOrcModuleHandle = UInt32
const LLVMOrcTargetAddress = UInt64
const LLVMOrcSymbolResolverFn = Ptr{Cvoid}
const LLVMOrcLazyCompileCallbackFn = Ptr{Cvoid}

# begin enum LLVMOrcErrorCode
const LLVMOrcErrorCode = UInt32
const LLVMOrcErrSuccess = (UInt32)(0)
const LLVMOrcErrGeneric = (UInt32)(1)
# end enum LLVMOrcErrorCode

mutable struct LLVMOpaquePassManagerBuilder
end

const LLVMPassManagerBuilderRef = Ptr{LLVMOpaquePassManagerBuilder}
