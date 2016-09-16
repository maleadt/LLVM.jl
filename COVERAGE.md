LLVM API coverage
=================

<!--

Find functions in `lib` not mentioned in this document:
```
for f in $(grep -ohR "function \w*" lib | cut -d ' ' -f 2) 
do
    grep -q $f COVERAGE.md || echo $f
done
```

Check functions after modifications:
```
for f in $(egrep -ohR 'API\.\w*' src | cut -d . -f 2 | sort | uniq)
do
    sed -i "s/\[.\] ~*$f\b~*/[x] $f/" COVERAGE.md
done
```

Make sure all checked functions are actually implemented:
```
for f in $(egrep -oh '\[x\] \w*\b' COVERAGE.md | cut -d ' ' -f 2 | sort | uniq)
do
    egrep -Rq "API.$f\b" src || echo $f
done
```

-->

Analysis
--------

- [x] LLVMVerifyModule
- [x] LLVMVerifyFunction
- [ ] ~~LLVMViewFunctionCFG~~ (debug-specific)
- [ ] ~~LLVMViewFunctionCFGOnly~~ (debug-specific)



Bit Reader
----------

- [ ] ~~LLVMParseBitcode~~ (deprecated  )
- [x] LLVMParseBitcode2
- [ ] ~~LLVMParseBitcodeInContext~~ (deprecated )
- [x] LLVMParseBitcodeInContext2
- [ ] ~~LLVMGetBitcodeModuleInContext~~ (deprecated )
- [ ] LLVMGetBitcodeModuleInContext2
- [ ] ~~LLVMGetBitcodeModule~~ (deprecated  )
- [ ] LLVMGetBitcodeModule2



Bit Writer
----------

- [ ] ~~LLVMWriteBitcodeToFile~~ (unnecessary)
- [x] LLVMWriteBitcodeToFD
- [ ] ~~LLVMWriteBitcodeToFileHandle~~ (unnecessary)
- [x] LLVMWriteBitcodeToMemoryBuffer



Transforms
----------

### Interprocedural transformations

- [x] LLVMAddArgumentPromotionPass
- [x] LLVMAddConstantMergePass
- [x] LLVMAddDeadArgEliminationPass
- [x] LLVMAddFunctionAttrsPass
- [x] LLVMAddFunctionInliningPass
- [x] LLVMAddAlwaysInlinerPass
- [x] LLVMAddGlobalDCEPass
- [x] LLVMAddGlobalOptimizerPass
- [x] LLVMAddIPConstantPropagationPass
- [x] LLVMAddPruneEHPass
- [x] LLVMAddIPSCCPPass
- [x] LLVMAddInternalizePass
- [x] LLVMAddStripDeadPrototypesPass
- [x] LLVMAddStripSymbolsPass


### Pass manager builder

- [x] LLVMPassManagerBuilderCreate
- [x] LLVMPassManagerBuilderDispose
- [x] LLVMPassManagerBuilderSetOptLevel
- [x] LLVMPassManagerBuilderSetSizeLevel
- [x] LLVMPassManagerBuilderSetDisableUnitAtATime
- [x] LLVMPassManagerBuilderSetDisableUnrollLoops
- [x] LLVMPassManagerBuilderSetDisableSimplifyLibCalls
- [x] LLVMPassManagerBuilderUseInlinerWithThreshold
- [x] LLVMPassManagerBuilderPopulateFunctionPassManager
- [x] LLVMPassManagerBuilderPopulateModulePassManager
- [ ] LLVMPassManagerBuilderPopulateLTOPassManager


### Scalar transformations

- [x] LLVMAddAggressiveDCEPass
- [x] LLVMAddBitTrackingDCEPass
- [x] LLVMAddAlignmentFromAssumptionsPass
- [x] LLVMAddCFGSimplificationPass
- [x] LLVMAddDeadStoreEliminationPass
- [x] LLVMAddScalarizerPass
- [x] LLVMAddMergedLoadStoreMotionPass
- [x] LLVMAddGVNPass
- [x] LLVMAddIndVarSimplifyPass
- [x] LLVMAddInstructionCombiningPass
- [x] LLVMAddJumpThreadingPass
- [x] LLVMAddLICMPass
- [x] LLVMAddLoopDeletionPass
- [x] LLVMAddLoopIdiomPass
- [x] LLVMAddLoopRotatePass
- [x] LLVMAddLoopRerollPass
- [x] LLVMAddLoopUnrollPass
- [x] LLVMAddLoopUnswitchPass
- [x] LLVMAddMemCpyOptPass
- [x] LLVMAddPartiallyInlineLibCallsPass
- [x] LLVMAddLowerSwitchPass
- [x] LLVMAddPromoteMemoryToRegisterPass
- [x] LLVMAddReassociatePass
- [x] LLVMAddSCCPPass
- [x] LLVMAddScalarReplAggregatesPass
- [x] LLVMAddScalarReplAggregatesPassSSA
- [x] LLVMAddScalarReplAggregatesPassWithThreshold
- [x] LLVMAddSimplifyLibCallsPass
- [x] LLVMAddTailCallEliminationPass
- [x] LLVMAddConstantPropagationPass
- [x] LLVMAddDemoteMemoryToRegisterPass
- [x] LLVMAddVerifierPass
- [x] LLVMAddCorrelatedValuePropagationPass
- [x] LLVMAddEarlyCSEPass
- [x] LLVMAddLowerExpectIntrinsicPass
- [x] LLVMAddTypeBasedAliasAnalysisPass
- [x] LLVMAddScopedNoAliasAAPass
- [x] LLVMAddBasicAliasAnalysisPass


### Vectorization transformations

- [x] LLVMAddBBVectorizePass
- [x] LLVMAddLoopVectorizePass
- [x] LLVMAddSLPVectorizePass



Core
----

- [x] LLVMInitializeCore
- [x] LLVMShutdown
- [ ] LLVMCreateMessage
- [x] LLVMDisposeMessage


### Contexts

- [x] LLVMContextCreate
- [x] LLVMGetGlobalContext
- [x] LLVMContextSetDiagnosticHandler
- [ ] LLVMContextGetDiagnosticHandler
- [ ] LLVMContextGetDiagnosticContext
- [x] LLVMContextSetYieldCallback
- [x] LLVMContextDispose
- [x] LLVMGetDiagInfoDescription
- [x] LLVMGetDiagInfoSeverity
- [ ] LLVMGetMDKindIDInContext
- [ ] LLVMGetMDKindID


### Modules

- [x] LLVMModuleCreateWithName
- [x] LLVMModuleCreateWithNameInContext
- [x] LLVMCloneModule
- [x] LLVMDisposeModule
- [ ] LLVMGetModuleIdentifier
- [ ] LLVMSetModuleIdentifier
- [ ] LLVMGetDataLayoutStr
- [x] LLVMGetDataLayout
- [x] LLVMSetDataLayout
- [x] LLVMGetTarget
- [x] LLVMSetTarget
- [ ] ~~LLVMDumpModule~~ (unnecessary, we use `ToString` to power `show`)
- [ ] ~~LLVMPrintModuleToFile~~ (user can do this himself)
- [x] LLVMPrintModuleToString
- [x] LLVMSetModuleInlineAsm
- [x] LLVMGetModuleContext
- [x] LLVMGetTypeByName
- [x] LLVMGetNamedMetadataNumOperands
- [x] LLVMGetNamedMetadataOperands
- [x] LLVMAddNamedMetadataOperand
- [x] LLVMAddFunction
- [x] LLVMGetNamedFunction
- [x] LLVMGetFirstFunction
- [x] LLVMGetLastFunction
- [x] LLVMGetNextFunction
- [ ] LLVMGetPreviousFunction


### Types

- [x] LLVMGetTypeKind
- [x] LLVMTypeIsSized
- [x] LLVMGetTypeContext
- [ ] ~~LLVMDumpType~~ (unnecessary, we use `ToString` to power `show`)
- [x] LLVMPrintTypeToString

#### Integer Types

- [x] LLVMInt1TypeInContext
- [x] LLVMInt8TypeInContext
- [x] LLVMInt16TypeInContext
- [x] LLVMInt32TypeInContext
- [x] LLVMInt64TypeInContext
- [x] LLVMInt128TypeInContext
- [x] LLVMIntTypeInContext
- [x] LLVMInt1Type
- [x] LLVMInt8Type
- [x] LLVMInt16Type
- [x] LLVMInt32Type
- [x] LLVMInt64Type
- [x] LLVMInt128Type
- [x] LLVMIntType
- [x] LLVMGetIntTypeWidth

#### Floating Point Types

- [x] LLVMHalfTypeInContext
- [x] LLVMFloatTypeInContext
- [x] LLVMDoubleTypeInContext
- [ ] LLVMX86FP80TypeInContext
- [ ] LLVMFP128TypeInContext
- [ ] LLVMPPCFP128TypeInContext
- [x] LLVMHalfType
- [x] LLVMFloatType
- [x] LLVMDoubleType
- [ ] LLVMX86FP80Type
- [ ] LLVMFP128Type
- [ ] LLVMPPCFP128Type

#### Function Types

- [x] LLVMFunctionType
- [x] LLVMIsFunctionVarArg
- [x] LLVMGetReturnType
- [x] LLVMCountParamTypes
- [x] LLVMGetParamTypes

#### Structure Types

- [x] LLVMStructTypeInContext
- [x] LLVMStructType
- [x] LLVMStructCreateNamed
- [x] LLVMGetStructName
- [x] LLVMStructSetBody
- [x] LLVMCountStructElementTypes
- [x] LLVMGetStructElementTypes
- [x] LLVMStructGetTypeAtIndex
- [x] LLVMIsPackedStruct
- [x] LLVMIsOpaqueStruct

#### Sequential Types

- [x] LLVMGetElementType
- [x] LLVMArrayType
- [x] LLVMGetArrayLength
- [x] LLVMPointerType
- [x] LLVMGetPointerAddressSpace
- [x] LLVMVectorType
- [x] LLVMGetVectorSize

#### Other Types

- [x] LLVMVoidTypeInContext
- [x] LLVMLabelTypeInContext
- [ ] LLVMX86MMXTypeInContext
- [x] LLVMVoidType
- [x] LLVMLabelType
- [ ] LLVMX86MMXType


### Values

#### General APIs

- [x] LLVMTypeOf
- [x] LLVMGetValueKind
- [x] LLVMGetValueName
- [x] LLVMSetValueName
- [ ] ~~LLVMDumpValue~~ (unnecessary, we use `ToString` to power `show`)
- [x] LLVMPrintValueToString
- [x] LLVMReplaceAllUsesWith
- [x] LLVMIsConstant
- [x] LLVMIsUndef
- [ ] LLVMIsAArgument
- [ ] LLVMIsABasicBlock
- [ ] LLVMIsAInlineAsm
- [ ] LLVMIsAUser
- [ ] LLVMIsAConstant
- [ ] LLVMIsABlockAddress
- [ ] LLVMIsAConstantAggregateZero
- [ ] LLVMIsAConstantArray
- [ ] LLVMIsAConstantDataSequential
- [ ] LLVMIsAConstantDataArray
- [ ] LLVMIsAConstantDataVector
- [ ] LLVMIsAConstantExpr
- [ ] LLVMIsAConstantFP
- [ ] LLVMIsAConstantInt
- [ ] LLVMIsAConstantPointerNull
- [ ] LLVMIsAConstantStruct
- [ ] LLVMIsAConstantTokenNone
- [ ] LLVMIsAConstantVector
- [ ] LLVMIsAGlobalValue
- [ ] LLVMIsAGlobalAlias
- [ ] LLVMIsAGlobalObject
- [ ] LLVMIsAFunction
- [ ] LLVMIsAGlobalVariable
- [ ] LLVMIsAUndefValue
- [ ] LLVMIsAInstruction
- [ ] LLVMIsABinaryOperator
- [ ] LLVMIsACallInst
- [ ] LLVMIsAIntrinsicInst
- [ ] LLVMIsADbgInfoIntrinsic
- [ ] LLVMIsADbgDeclareInst
- [ ] LLVMIsAMemIntrinsic
- [ ] LLVMIsAMemCpyInst
- [ ] LLVMIsAMemMoveInst
- [ ] LLVMIsAMemSetInst
- [ ] LLVMIsACmpInst
- [ ] LLVMIsAFCmpInst
- [ ] LLVMIsAICmpInst
- [ ] LLVMIsAExtractElementInst
- [ ] LLVMIsAGetElementPtrInst
- [ ] LLVMIsAInsertElementInst
- [ ] LLVMIsAInsertValueInst
- [ ] LLVMIsALandingPadInst
- [ ] LLVMIsAPHINode
- [ ] LLVMIsASelectInst
- [ ] LLVMIsAShuffleVectorInst
- [ ] LLVMIsAStoreInst
- [ ] LLVMIsATerminatorInst
- [ ] LLVMIsABranchInst
- [ ] LLVMIsAIndirectBrInst
- [ ] LLVMIsAInvokeInst
- [ ] LLVMIsAReturnInst
- [ ] LLVMIsASwitchInst
- [ ] LLVMIsAUnreachableInst
- [ ] LLVMIsAResumeInst
- [ ] LLVMIsACleanupReturnInst
- [ ] LLVMIsACatchReturnInst
- [ ] LLVMIsAFuncletPadInst
- [ ] LLVMIsACatchPadInst
- [ ] LLVMIsACleanupPadInst
- [ ] LLVMIsAUnaryInstruction
- [ ] LLVMIsAAllocaInst
- [ ] LLVMIsACastInst
- [ ] LLVMIsAAddrSpaceCastInst
- [ ] LLVMIsABitCastInst
- [ ] LLVMIsAFPExtInst
- [ ] LLVMIsAFPToSIInst
- [ ] LLVMIsAFPToUIInst
- [ ] LLVMIsAFPTruncInst
- [ ] LLVMIsAIntToPtrInst
- [ ] LLVMIsAPtrToIntInst
- [ ] LLVMIsASExtInst
- [ ] LLVMIsASIToFPInst
- [ ] LLVMIsATruncInst
- [ ] LLVMIsAUIToFPInst
- [ ] LLVMIsAZExtInst
- [ ] LLVMIsAExtractValueInst
- [ ] LLVMIsALoadInst
- [ ] LLVMIsAVAArgInst
- [ ] LLVMIsAMDNode
- [ ] LLVMIsAMDString

#### Usage

- [x] LLVMGetFirstUse
- [x] LLVMGetNextUse
- [x] LLVMGetUser
- [x] LLVMGetUsedValue

#### User value

- [ ] LLVMGetOperand
- [ ] LLVMGetOperandUse
- [ ] LLVMSetOperand
- [ ] LLVMGetNumOperands

#### Constants

- [ ] LLVMConstNull
- [ ] LLVMConstAllOnes
- [ ] LLVMGetUndef
- [ ] LLVMIsNull
- [ ] LLVMConstPointerNull

**Scalar constants**

- [x] LLVMConstInt
- [ ] LLVMConstIntOfArbitraryPrecision
- [ ] LLVMConstIntOfString
- [ ] LLVMConstIntOfStringAndSize
- [x] LLVMConstReal
- [ ] LLVMConstRealOfString
- [ ] LLVMConstRealOfStringAndSize
- [x] LLVMConstIntGetZExtValue
- [x] LLVMConstIntGetSExtValue
- [x] LLVMConstRealGetDouble

**Composite Constants**

- [ ] LLVMConstStringInContext
- [ ] LLVMConstString
- [ ] LLVMIsConstantString
- [ ] LLVMGetAsString
- [ ] LLVMConstStructInContext
- [ ] LLVMConstStruct
- [ ] LLVMConstArray
- [ ] LLVMConstNamedStruct
- [ ] LLVMGetElementAsConstant
- [ ] LLVMConstVector

**Constant Expressions**

- [ ] LLVMGetConstOpcode
- [ ] LLVMAlignOf
- [ ] LLVMSizeOf
- [ ] LLVMConstNeg
- [ ] LLVMConstNSWNeg
- [ ] LLVMConstNUWNeg
- [ ] LLVMConstFNeg
- [ ] LLVMConstNot
- [ ] LLVMConstAdd
- [ ] LLVMConstNSWAdd
- [ ] LLVMConstNUWAdd
- [ ] LLVMConstFAdd
- [ ] LLVMConstSub
- [ ] LLVMConstNSWSub
- [ ] LLVMConstNUWSub
- [ ] LLVMConstFSub
- [ ] LLVMConstMul
- [ ] LLVMConstNSWMul
- [ ] LLVMConstNUWMul
- [ ] LLVMConstFMul
- [ ] LLVMConstUDiv
- [ ] LLVMConstSDiv
- [ ] LLVMConstExactSDiv
- [ ] LLVMConstFDiv
- [ ] LLVMConstURem
- [ ] LLVMConstSRem
- [ ] LLVMConstFRem
- [ ] LLVMConstAnd
- [ ] LLVMConstOr
- [ ] LLVMConstXor
- [ ] LLVMConstICmp
- [ ] LLVMConstFCmp
- [ ] LLVMConstShl
- [ ] LLVMConstLShr
- [ ] LLVMConstAShr
- [ ] LLVMConstGEP
- [ ] LLVMConstInBoundsGEP
- [ ] LLVMConstTrunc
- [ ] LLVMConstSExt
- [ ] LLVMConstZExt
- [ ] LLVMConstFPTrunc
- [ ] LLVMConstFPExt
- [ ] LLVMConstUIToFP
- [ ] LLVMConstSIToFP
- [ ] LLVMConstFPToUI
- [ ] LLVMConstFPToSI
- [ ] LLVMConstPtrToInt
- [ ] LLVMConstIntToPtr
- [ ] LLVMConstBitCast
- [ ] LLVMConstAddrSpaceCast
- [ ] LLVMConstZExtOrBitCast
- [ ] LLVMConstSExtOrBitCast
- [ ] LLVMConstTruncOrBitCast
- [ ] LLVMConstPointerCast
- [ ] LLVMConstIntCast
- [ ] LLVMConstFPCast
- [ ] LLVMConstSelect
- [ ] LLVMConstExtractElement
- [ ] LLVMConstInsertElement
- [ ] LLVMConstShuffleVector
- [ ] LLVMConstExtractValue
- [ ] LLVMConstInsertValue
- [ ] LLVMConstInlineAsm
- [ ] LLVMBlockAddress

**Global Values**

- [ ] LLVMGetGlobalParent
- [ ] LLVMIsDeclaration
- [ ] LLVMGetLinkage
- [ ] LLVMSetLinkage
- [ ] LLVMGetSection
- [ ] LLVMSetSection
- [ ] LLVMGetVisibility
- [ ] LLVMSetVisibility
- [ ] LLVMGetDLLStorageClass
- [ ] LLVMSetDLLStorageClass
- [ ] LLVMHasUnnamedAddr
- [ ] LLVMSetUnnamedAddr
- [ ] LLVMGetAlignment
- [ ] LLVMSetAlignment

**Global Variables**

- [x] LLVMAddGlobal
- [x] LLVMAddGlobalInAddressSpace
- [x] LLVMGetNamedGlobal
- [x] LLVMGetFirstGlobal
- [x] LLVMGetLastGlobal
- [x] LLVMGetNextGlobal
- [ ] LLVMGetPreviousGlobal
- [x] LLVMDeleteGlobal
- [x] LLVMGetInitializer
- [x] LLVMSetInitializer
- [x] LLVMIsThreadLocal
- [x] LLVMSetThreadLocal
- [x] LLVMIsGlobalConstant
- [x] LLVMSetGlobalConstant
- [x] LLVMGetThreadLocalMode
- [x] LLVMSetThreadLocalMode
- [x] LLVMIsExternallyInitialized
- [x] LLVMSetExternallyInitialized

**Global Aliases**

- [ ] LLVMAddAlias

**Function values**

- [x] LLVMDeleteFunction
- [ ] LLVMHasPersonalityFn
- [x] LLVMGetPersonalityFn
- [x] LLVMSetPersonalityFn
- [x] LLVMGetIntrinsicID
- [x] LLVMGetFunctionCallConv
- [x] LLVMSetFunctionCallConv
- [x] LLVMGetGC
- [x] LLVMSetGC
- [x] LLVMAddFunctionAttr
- [ ] LLVMAddAttributeAtIndex
- [ ] LLVMGetAttributeCountAtIndex
- [ ] LLVMGetAttributesAtIndex
- [ ] LLVMGetEnumAttributeAtIndex
- [ ] LLVMGetStringAttributeAtIndex
- [ ] LLVMRemoveEnumAttributeAtIndex
- [ ] LLVMRemoveStringAttributeAtIndex
- [ ] LLVMAddTargetDependentFunctionAttr
- [x] LLVMGetFunctionAttr
- [x] LLVMRemoveFunctionAttr

Function parameters:

- [x] LLVMCountParams
- [x] LLVMGetParams
- [x] LLVMGetParam
- [ ] LLVMGetParamParent
- [x] LLVMGetFirstParam
- [x] LLVMGetLastParam
- [x] LLVMGetNextParam
- [ ] LLVMGetPreviousParam
- [ ] LLVMAddAttribute
- [ ] LLVMRemoveAttribute
- [ ] LLVMGetAttribute
- [ ] LLVMSetParamAlignment
    

### Metadata

- [x] LLVMMDStringInContext
- [x] LLVMMDString
- [x] LLVMMDNodeInContext
- [x] LLVMMDNode
- [x] LLVMGetMDString
- [x] LLVMGetMDNodeNumOperands
- [x] LLVMGetMDNodeOperands


### Basic Block

- [x] LLVMBasicBlockAsValue
- [ ] LLVMValueIsBasicBlock
- [x] LLVMValueAsBasicBlock
- [ ] LLVMGetBasicBlockName
- [x] LLVMGetBasicBlockParent
- [x] LLVMGetBasicBlockTerminator
- [x] LLVMCountBasicBlocks
- [ ] LLVMGetBasicBlocks
- [x] LLVMGetFirstBasicBlock
- [x] LLVMGetLastBasicBlock
- [x] LLVMGetNextBasicBlock
- [ ] LLVMGetPreviousBasicBlock
- [x] LLVMGetEntryBasicBlock
- [x] LLVMAppendBasicBlockInContext
- [x] LLVMAppendBasicBlock
- [x] LLVMInsertBasicBlockInContext
- [x] LLVMInsertBasicBlock
- [x] LLVMDeleteBasicBlock
- [x] LLVMRemoveBasicBlockFromParent
- [x] LLVMMoveBasicBlockBefore
- [x] LLVMMoveBasicBlockAfter
- [x] LLVMGetFirstInstruction
- [x] LLVMGetLastInstruction


### Instructions

- [x] LLVMHasMetadata
- [x] LLVMGetMetadata
- [x] LLVMSetMetadata
- [x] LLVMGetInstructionParent
- [x] LLVMGetNextInstruction
- [ ] LLVMGetPreviousInstruction
- [ ] LLVMInstructionRemoveFromParent
- [x] LLVMInstructionEraseFromParent
- [ ] LLVMGetInstructionOpcode
- [x] LLVMGetICmpPredicate
- [x] LLVMGetFCmpPredicate
- [x] LLVMInstructionClone

#### Call Sites and Invocations

- [x] LLVMSetInstructionCallConv
- [x] LLVMGetInstructionCallConv
- [ ] LLVMAddInstrAttribute
- [ ] LLVMRemoveInstrAttribute
- [ ] LLVMSetInstrParamAlignment
- [ ] LLVMAddCallSiteAttribute
- [ ] LLVMGetCallSiteAttributeCount
- [ ] LLVMGetCallSiteAttributes
- [ ] LLVMGetCallSiteEnumAttribute
- [ ] LLVMGetCallSiteStringAttribute
- [ ] LLVMRemoveCallSiteEnumAttribute
- [ ] LLVMRemoveCallSiteStringAttribute
- [ ] LLVMGetCalledValue
- [x] LLVMIsTailCall
- [x] LLVMSetTailCall

#### Terminators

- [ ] LLVMGetNormalDest
- [ ] LLVMGetUnwindDest
- [ ] LLVMSetNormalDest
- [ ] LLVMSetUnwindDest
- [x] LLVMGetNumSuccessors
- [x] LLVMGetSuccessor
- [x] LLVMSetSuccessor
- [x] LLVMIsConditional
- [x] LLVMGetCondition
- [x] LLVMSetCondition
- [x] LLVMGetSwitchDefaultDest

#### PHI Nodes

- [ ] LLVMGetAllocatedType
- [ ] LLVMIsInBounds
- [ ] LLVMSetIsInBounds
- [x] LLVMAddIncoming
- [x] LLVMCountIncoming
- [x] LLVMGetIncomingValue
- [x] LLVMGetIncomingBlock



Instruction Builders
--------------------

- [x] LLVMCreateBuilderInContext
- [x] LLVMCreateBuilder
- [ ] LLVMPositionBuilder
- [x] LLVMPositionBuilderBefore
- [x] LLVMPositionBuilderAtEnd
- [x] LLVMGetInsertBlock
- [x] LLVMClearInsertionPosition
- [x] LLVMInsertIntoBuilder
- [x] LLVMInsertIntoBuilderWithName
- [x] LLVMDisposeBuilder
- [x] LLVMSetCurrentDebugLocation
- [x] LLVMGetCurrentDebugLocation
- [x] LLVMSetInstDebugLocation
- [x] LLVMBuildRetVoid
- [x] LLVMBuildRet
- [ ] LLVMBuildAggregateRet
- [x] LLVMBuildBr
- [x] LLVMBuildCondBr
- [ ] LLVMBuildSwitch
- [ ] LLVMBuildIndirectBr
- [ ] LLVMBuildInvoke
- [ ] LLVMBuildLandingPad
- [ ] LLVMBuildResume
- [x] LLVMBuildUnreachable
- [ ] LLVMAddCase
- [ ] LLVMAddDestination
- [ ] LLVMGetNumClauses
- [ ] LLVMGetClause
- [ ] LLVMAddClause
- [ ] LLVMIsCleanup
- [ ] LLVMSetCleanup
- [x] LLVMBuildAdd
- [ ] LLVMBuildNSWAdd
- [ ] LLVMBuildNUWAdd
- [x] LLVMBuildFAdd
- [ ] LLVMBuildSub
- [ ] LLVMBuildNSWSub
- [ ] LLVMBuildNUWSub
- [ ] LLVMBuildFSub
- [ ] LLVMBuildMul
- [ ] LLVMBuildNSWMul
- [ ] LLVMBuildNUWMul
- [ ] LLVMBuildFMul
- [ ] LLVMBuildUDiv
- [ ] LLVMBuildSDiv
- [ ] LLVMBuildExactSDiv
- [ ] LLVMBuildFDiv
- [ ] LLVMBuildURem
- [ ] LLVMBuildSRem
- [ ] LLVMBuildFRem
- [ ] LLVMBuildShl
- [ ] LLVMBuildLShr
- [ ] LLVMBuildAShr
- [ ] LLVMBuildAnd
- [ ] LLVMBuildOr
- [ ] LLVMBuildXor
- [ ] LLVMBuildBinOp
- [ ] LLVMBuildNeg
- [ ] LLVMBuildNSWNeg
- [ ] LLVMBuildNUWNeg
- [ ] LLVMBuildFNeg
- [ ] LLVMBuildNot
- [ ] LLVMBuildMalloc
- [ ] LLVMBuildArrayMalloc
- [x] LLVMBuildAlloca
- [ ] LLVMBuildArrayAlloca
- [ ] LLVMBuildFree
- [ ] LLVMBuildLoad
- [ ] LLVMBuildStore
- [ ] LLVMBuildGEP
- [ ] LLVMBuildInBoundsGEP
- [ ] LLVMBuildStructGEP
- [ ] LLVMBuildGlobalString
- [ ] LLVMBuildGlobalStringPtr
- [ ] LLVMGetVolatile
- [ ] LLVMSetVolatile
- [ ] LLVMGetOrdering
- [ ] LLVMSetOrdering
- [ ] LLVMBuildTrunc
- [ ] LLVMBuildZExt
- [ ] LLVMBuildSExt
- [ ] LLVMBuildFPToUI
- [ ] LLVMBuildFPToSI
- [ ] LLVMBuildUIToFP
- [ ] LLVMBuildSIToFP
- [ ] LLVMBuildFPTrunc
- [ ] LLVMBuildFPExt
- [ ] LLVMBuildPtrToInt
- [ ] LLVMBuildIntToPtr
- [ ] LLVMBuildBitCast
- [ ] LLVMBuildAddrSpaceCast
- [ ] LLVMBuildZExtOrBitCast
- [ ] LLVMBuildSExtOrBitCast
- [ ] LLVMBuildTruncOrBitCast
- [ ] LLVMBuildCast
- [ ] LLVMBuildPointerCast
- [ ] LLVMBuildIntCast
- [ ] LLVMBuildFPCast
- [ ] LLVMBuildICmp
- [ ] LLVMBuildFCmp
- [ ] LLVMBuildPhi
- [ ] LLVMBuildCall
- [ ] LLVMBuildSelect
- [ ] LLVMBuildVAArg
- [ ] LLVMBuildExtractElement
- [ ] LLVMBuildInsertElement
- [ ] LLVMBuildShuffleVector
- [ ] LLVMBuildExtractValue
- [ ] LLVMBuildInsertValue
- [ ] LLVMBuildIsNull
- [ ] LLVMBuildIsNotNull
- [ ] LLVMBuildPtrDiff
- [ ] LLVMBuildFence
- [ ] LLVMBuildAtomicRMW
- [ ] LLVMBuildAtomicCmpXchg



Module Providers
----------------

- [x] LLVMCreateModuleProviderForExistingModule
- [x] LLVMDisposeModuleProvider



Memory Buffers
--------------

- [x] LLVMCreateMemoryBufferWithContentsOfFile
- [ ] LLVMCreateMemoryBufferWithSTDIN
- [ ] LLVMCreateMemoryBufferWithMemoryRange
- [x] LLVMCreateMemoryBufferWithMemoryRangeCopy
- [x] LLVMGetBufferStart
- [x] LLVMGetBufferSize
- [x] LLVMDisposeMemoryBuffer



Pass Registry
-------------

- [x] LLVMGetGlobalPassRegistry



Pass Managers
-------------

- [x] LLVMCreatePassManager
- [x] LLVMCreateFunctionPassManagerForModule
- [ ] ~~LLVMCreateFunctionPassManager~~ (deprecated)
- [x] LLVMRunPassManager
- [x] LLVMInitializeFunctionPassManager
- [x] LLVMRunFunctionPassManager
- [x] LLVMFinalizeFunctionPassManager
- [x] LLVMDisposePassManager



Threading
---------

- [ ] LLVMStartMultithreaded
- [ ] LLVMStopMultithreaded
- [ ] LLVMIsMultithreaded



Disassembler
------------

- [ ] LLVMCreateDisasm
- [ ] LLVMCreateDisasmCPU
- [ ] LLVMCreateDisasmCPUFeatures
- [ ] LLVMSetDisasmOptions
- [ ] LLVMDisasmDispose
- [ ] LLVMDisasmInstruction



Execution Engine
----------------

- [x] LLVMLinkInMCJIT
- [x] LLVMLinkInInterpreter
- [x] LLVMCreateGenericValueOfInt
- [x] LLVMCreateGenericValueOfPointer
- [x] LLVMCreateGenericValueOfFloat
- [ ] LLVMGenericValueIntWidth
- [x] LLVMGenericValueToInt
- [x] LLVMGenericValueToPointer
- [x] LLVMGenericValueToFloat
- [x] LLVMDisposeGenericValue
- [x] LLVMCreateExecutionEngineForModule
- [x] LLVMCreateInterpreterForModule
- [x] LLVMCreateJITCompilerForModule
- [ ] LLVMInitializeMCJITCompilerOptions
- [ ] LLVMCreateMCJITCompilerForModule
- [x] LLVMDisposeExecutionEngine
- [ ] LLVMRunStaticConstructors
- [ ] LLVMRunStaticDestructors
- [ ] LLVMRunFunctionAsMain
- [x] LLVMRunFunction
- [ ] LLVMFreeMachineCodeForFunction
- [ ] LLVMAddModule
- [ ] LLVMRemoveModule
- [ ] LLVMFindFunction
- [ ] LLVMRecompileAndRelinkFunction
- [ ] LLVMGetExecutionEngineTargetData
- [ ] LLVMGetExecutionEngineTargetMachine
- [ ] LLVMAddGlobalMapping
- [ ] LLVMGetPointerToGlobal
- [ ] LLVMGetGlobalValueAddress
- [ ] LLVMGetFunctionAddress
- [ ] LLVMCreateSimpleMCJITMemoryManager
- [ ] LLVMDisposeMCJITMemoryManager



Initialization Routines
-----------------------

- [x] LLVMInitializeTransformUtils
- [x] LLVMInitializeScalarOpts
- [x] LLVMInitializeObjCARCOpts
- [x] LLVMInitializeVectorization
- [x] LLVMInitializeInstCombine
- [x] LLVMInitializeIPO
- [x] LLVMInitializeInstrumentation
- [x] LLVMInitializeAnalysis
- [x] LLVMInitializeIPA
- [x] LLVMInitializeCodeGen
- [x] LLVMInitializeTarget



Link Time Optimization
----------------------

- [ ] llvm_create_optimizer
- [ ] llvm_destroy_optimizer
- [ ] llvm_read_object_file
- [ ] llvm_optimize_modules



LTO
---

- [ ] lto_get_version
- [ ] lto_get_error_message
- [ ] lto_module_is_object_file
- [ ] lto_module_is_object_file_for_target
- [ ] lto_module_has_objc_category
- [ ] lto_module_is_object_file_in_memory
- [ ] lto_module_is_object_file_in_memory_for_target
- [ ] lto_module_create
- [ ] lto_module_create_from_memory
- [ ] lto_module_create_from_memory_with_path
- [ ] lto_module_create_in_local_context
- [ ] lto_module_create_in_codegen_context
- [ ] lto_module_create_from_fd
- [ ] lto_module_create_from_fd_at_offset
- [ ] lto_module_dispose
- [ ] lto_module_get_target_triple
- [ ] lto_module_set_target_triple
- [ ] lto_module_get_num_symbols
- [ ] lto_module_get_symbol_name
- [ ] lto_module_get_symbol_attribute
- [ ] lto_module_get_linkeropts
- [ ] lto_codegen_set_diagnostic_handler
- [ ] lto_codegen_create
- [ ] lto_codegen_create_in_local_context
- [ ] lto_codegen_dispose
- [ ] lto_codegen_add_module
- [ ] lto_codegen_set_module
- [ ] lto_codegen_set_debug_model
- [ ] lto_codegen_set_pic_model
- [ ] lto_codegen_set_cpu
- [ ] lto_codegen_set_assembler_path
- [ ] lto_codegen_set_assembler_args
- [ ] lto_codegen_add_must_preserve_symbol
- [ ] lto_codegen_write_merged_modules
- [ ] lto_codegen_compile
- [ ] lto_codegen_compile_to_file
- [ ] lto_codegen_optimize
- [ ] lto_codegen_compile_optimized
- [ ] lto_api_version
- [ ] lto_codegen_debug_options
- [ ] lto_initialize_disassembler
- [ ] lto_codegen_set_should_internalize
- [ ] lto_codegen_set_should_embed_uselists



Object file reading and writing
-------------------------------

- [ ] LLVMCreateObjectFile
- [ ] LLVMDisposeObjectFile
- [ ] LLVMGetSections
- [ ] LLVMDisposeSectionIterator
- [ ] LLVMIsSectionIteratorAtEnd
- [ ] LLVMMoveToNextSection
- [ ] LLVMMoveToContainingSection
- [ ] LLVMGetSymbols
- [ ] LLVMDisposeSymbolIterator
- [ ] LLVMIsSymbolIteratorAtEnd
- [ ] LLVMMoveToNextSymbol
- [ ] LLVMGetSectionName
- [ ] LLVMGetSectionSize
- [ ] LLVMGetSectionContents
- [ ] LLVMGetSectionAddress
- [ ] LLVMGetSectionContainsSymbol
- [ ] LLVMGetRelocations
- [ ] LLVMDisposeRelocationIterator
- [ ] LLVMIsRelocationIteratorAtEnd
- [ ] LLVMMoveToNextRelocation
- [ ] LLVMGetSymbolName
- [ ] LLVMGetSymbolAddress
- [ ] LLVMGetSymbolSize
- [ ] LLVMGetRelocationOffset
- [ ] LLVMGetRelocationSymbol
- [ ] LLVMGetRelocationType
- [ ] LLVMGetRelocationTypeName
- [ ] LLVMGetRelocationValueString



Target information
------------------

- [x] LLVMCreateTargetData
- [x] LLVMDisposeTargetData
- [ ] LLVMAddTargetLibraryInfo
- [x] LLVMCopyStringRepOfTargetData
- [x] LLVMByteOrder
- [x] LLVMPointerSize
- [x] LLVMPointerSizeForAS
- [x] LLVMIntPtrType
- [x] LLVMIntPtrTypeForAS
- [x] LLVMIntPtrTypeInContext
- [x] LLVMIntPtrTypeForASInContext
- [x] LLVMSizeOfTypeInBits
- [x] LLVMStoreSizeOfType
- [x] LLVMABISizeOfType
- [x] LLVMABIAlignmentOfType
- [x] LLVMCallFrameAlignmentOfType
- [x] LLVMPreferredAlignmentOfType
- [x] LLVMPreferredAlignmentOfGlobal
- [x] LLVMElementAtOffset
- [x] LLVMOffsetOfElement


Target machine
--------------

- [x] LLVMGetFirstTarget
- [x] LLVMGetNextTarget
- [x] LLVMGetTargetFromName
- [x] LLVMGetTargetFromTriple
- [x] LLVMGetTargetName
- [x] LLVMGetTargetDescription
- [x] LLVMTargetHasJIT
- [x] LLVMTargetHasTargetMachine
- [x] LLVMTargetHasAsmBackend
- [x] LLVMCreateTargetMachine
- [x] LLVMDisposeTargetMachine
- [x] LLVMGetTargetMachineTarget
- [x] LLVMGetTargetMachineTriple
- [x] LLVMGetTargetMachineCPU
- [x] LLVMGetTargetMachineFeatureString
- [x] LLVMCreateTargetDataLayout
- [x] LLVMSetTargetMachineAsmVerbosity
- [x] LLVMTargetMachineEmitToFile
- [x] LLVMTargetMachineEmitToMemoryBuffer
- [x] LLVMGetDefaultTargetTriple
- [x] LLVMAddAnalysisPasses


Unsorted
--------

- [ ] LLVMInstallFatalErrorHandler
- [ ] LLVMResetFatalErrorHandler
- [ ] LLVMEnablePrettyStackTrace

- [ ] LLVMGetModuleDataLayout
- [ ] LLVMSetModuleDataLayout

- [ ] LLVMGetEnumAttributeKindForName
- [ ] LLVMGetLastEnumAttributeKind
- [ ] LLVMCreateEnumAttribute
- [ ] LLVMGetEnumAttributeKind
- [ ] LLVMGetEnumAttributeValue
- [ ] LLVMCreateStringAttribute
- [ ] LLVMGetStringAttributeKind
- [ ] LLVMGetStringAttributeValue
- [ ] LLVMIsEnumAttribute
- [ ] LLVMIsStringAttribute

- [ ] LLVMGetNumArgOperands

- [ ] LLVMGetNumIndices
- [ ] LLVMGetIndices

- [ ] LLVMIsAtomicSingleThread
- [ ] LLVMSetAtomicSingleThread
- [ ] LLVMGetCmpXchgSuccessOrdering
- [ ] LLVMSetCmpXchgSuccessOrdering
- [ ] LLVMGetCmpXchgFailureOrdering
- [ ] LLVMSetCmpXchgFailureOrdering

- [ ] LLVMParseIRInContext
- [ ] LLVMLinkModules2

- [ ] thinlto_create_codegen
- [ ] thinlto_codegen_dispose
- [ ] thinlto_codegen_add_module
- [ ] thinlto_codegen_process
- [ ] thinlto_module_get_num_objects
- [ ] thinlto_module_get_object
- [ ] thinlto_codegen_set_pic_model
- [ ] thinlto_codegen_set_cache_dir
- [ ] thinlto_codegen_set_cache_pruning_interval
- [ ] thinlto_codegen_set_final_cache_size_relative_to_available_space
- [ ] thinlto_codegen_set_cache_entry_expiration
- [ ] thinlto_codegen_set_savetemps_dir
- [ ] thinlto_codegen_set_cpu
- [ ] thinlto_codegen_disable_codegen
- [ ] thinlto_codegen_set_codegen_only
- [ ] thinlto_debug_options
- [ ] lto_module_is_thinlto
- [ ] thinlto_codegen_add_must_preserve_symbol
- [ ] thinlto_codegen_add_cross_referenced_symbol

- [ ] LLVMOrcCreateInstance
- [ ] LLVMOrcGetErrorMsg
- [ ] LLVMOrcGetMangledSymbol
- [ ] LLVMOrcDisposeMangledSymbol
- [ ] LLVMOrcCreateLazyCompileCallback
- [ ] LLVMOrcCreateIndirectStub
- [ ] LLVMOrcSetIndirectStubPointer
- [ ] LLVMOrcAddEagerlyCompiledIR
- [ ] LLVMOrcAddLazilyCompiledIR
- [ ] LLVMOrcAddObjectFile
- [ ] LLVMOrcRemoveModule
- [ ] LLVMOrcGetSymbolAddress
- [ ] LLVMOrcDisposeInstance
- [ ] LLVMLoadLibraryPermanently
- [ ] LLVMParseCommandLineOptions
- [ ] LLVMSearchForAddressOfSymbol
- [ ] LLVMAddSymbol
