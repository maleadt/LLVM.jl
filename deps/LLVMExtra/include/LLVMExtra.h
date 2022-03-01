#ifndef LLVMEXTRA_H
#define LLVMEXTRA_H

#include "llvm/Config/llvm-config.h"
#include <llvm-c/Core.h>
#include <llvm-c/Types.h>
typedef struct LLVMOpaqueTargetMachine *LLVMTargetMachineRef;
// Can't include TargetMachine since that would inclue LLVMInitializeNativeTarget
// #include <llvm-c/TargetMachine.h>
#include <llvm-c/Transforms/PassManagerBuilder.h>

LLVM_C_EXTERN_C_BEGIN

LLVMBool LLVMInitializeNativeTarget(void);
LLVMBool LLVMInitializeNativeAsmParser(void);
LLVMBool LLVMInitializeNativeAsmPrinter(void);
LLVMBool LLVMInitializeNativeDisassembler(void);

typedef enum {
  LLVMDebugEmissionKindNoDebug = 0,
  LLVMDebugEmissionKindFullDebug = 1,
  LLVMDebugEmissionKindLineTablesOnly = 2,
  LLVMDebugEmissionKindDebugDirectivesOnly = 3
} LLVMDebugEmissionKind;

// Various missing passes (being upstreamed)
void LLVMAddBarrierNoopPass(LLVMPassManagerRef PM);
void LLVMAddDivRemPairsPass(LLVMPassManagerRef PM);
void LLVMAddLoopDistributePass(LLVMPassManagerRef PM);
void LLVMAddLoopFusePass(LLVMPassManagerRef PM);
void LLVMAddLoopLoadEliminationPass(LLVMPassManagerRef PM);
void LLVMAddLoadStoreVectorizerPass(LLVMPassManagerRef PM);
void LLVMAddVectorCombinePass(LLVMPassManagerRef PM);
void LLVMAddSpeculativeExecutionIfHasBranchDivergencePass(LLVMPassManagerRef PM);
void LLVMAddSimpleLoopUnrollPass(LLVMPassManagerRef PM);
void LLVMAddInductiveRangeCheckEliminationPass(LLVMPassManagerRef PM);

#if LLVM_VERSION_MAJOR < 12
void LLVMAddInstructionSimplifyPass(LLVMPassManagerRef PM);
#endif

// Infrastructure for writing LLVM passes in Julia
typedef struct LLVMOpaquePass *LLVMPassRef;

void LLVMAddPass(LLVMPassManagerRef PM, LLVMPassRef P);
typedef LLVMBool (*LLVMPassCallback)(void *Ref, void *Data);

LLVMPassRef
LLVMCreateModulePass2(const char *Name, LLVMPassCallback Callback, void *Data);

LLVMPassRef
LLVMCreateFunctionPass2(const char *Name, LLVMPassCallback Callback, void *Data);

// Various missing functions
unsigned int LLVMGetDebugMDVersion(void);

LLVMContextRef LLVMGetValueContext(LLVMValueRef V);
void LLVMAddTargetLibraryInfoByTriple(const char *T, LLVMPassManagerRef PM);
void LLVMAddInternalizePassWithExportList(
    LLVMPassManagerRef PM, const char **ExportList, size_t Length);

void LLVMExtraAppendToUsed(LLVMModuleRef Mod,
                           LLVMValueRef *Values,
                           size_t Count);
void LLVMExtraAppendToCompilerUsed(LLVMModuleRef Mod,
                                   LLVMValueRef *Values,
                                   size_t Count);
void LLVMExtraAddGenericAnalysisPasses(LLVMPassManagerRef PM);

void LLVMExtraDumpMetadata(LLVMMetadataRef MD);

char* LLVMExtraPrintMetadataToString(LLVMMetadataRef MD);

const char *LLVMExtraDIScopeGetName(LLVMMetadataRef File, unsigned *Len);

const char *LLVMExtraGetMDString2(LLVMMetadataRef MD, unsigned *Length);

unsigned LLVMExtraGetMDNodeNumOperands2(LLVMMetadataRef MD);

void LLVMExtraGetMDNodeOperands2(LLVMMetadataRef MD, LLVMMetadataRef *Dest);

unsigned LLVMExtraGetNamedMetadataNumOperands2(LLVMNamedMDNodeRef NMD);

void LLVMExtraGetNamedMetadataOperands2(LLVMNamedMDNodeRef NMD, LLVMMetadataRef *Dest);

void LLVMExtraAddNamedMetadataOperand2(LLVMNamedMDNodeRef NMD, LLVMMetadataRef Val);

#if LLVM_VERSION_MAJOR >= 12
void LLVMAddCFGSimplificationPass2(LLVMPassManagerRef PM,
                                   int BonusInstThreshold,
                                   LLVMBool ForwardSwitchCondToPhi,
                                   LLVMBool ConvertSwitchToLookupTable,
                                   LLVMBool NeedCanonicalLoop,
                                   LLVMBool HoistCommonInsts,
                                   LLVMBool SinkCommonInsts,
                                   LLVMBool SimplifyCondBranch,
                                   LLVMBool FoldTwoEntryPHINode);
#endif

// Bug fixes
void LLVMExtraSetInitializer(LLVMValueRef GlobalVar, LLVMValueRef ConstantVal);
void LLVMExtraSetPersonalityFn(LLVMValueRef Fn, LLVMValueRef PersonalityFn);

// https://reviews.llvm.org/D97763
#if LLVM_VERSION_MAJOR == 12
/**
 * Create a type attribute
 */
LLVMAttributeRef LLVMCreateTypeAttribute(LLVMContextRef C, unsigned KindID,
                                         LLVMTypeRef type_ref);

/**
 * Get the type attribute's value.
 */
LLVMTypeRef LLVMGetTypeAttributeValue(LLVMAttributeRef A);
LLVMBool LLVMIsTypeAttribute(LLVMAttributeRef A);
#endif

typedef enum {
  LLVMCloneFunctionChangeTypeLocalChangesOnly = 0,
  LLVMCloneFunctionChangeTypeGlobalChanges = 1,
  LLVMCloneFunctionChangeTypeDifferentModule = 2,
  LLVMCloneFunctionChangeTypeClonedModule = 3
} LLVMCloneFunctionChangeType;

void LLVMCloneFunctionInto(LLVMValueRef NewFunc, LLVMValueRef OldFunc,
                           LLVMValueRef *ValueMap, unsigned ValueMapElements,
                           LLVMCloneFunctionChangeType Changes,
                           const char *NameSuffix,
                           LLVMTypeRef (*TypeMapper)(LLVMTypeRef, void *),
                           void *TypeMapperData,
                           LLVMValueRef (*Materializer)(LLVMValueRef, void *),
                           void *MaterializerData);

void LLVMFunctionDeleteBody(LLVMValueRef Func);

void LLVMDestroyConstant(LLVMValueRef Const);

// operand bundles
typedef struct LLVMOpaqueOperandBundleUse *LLVMOperandBundleUseRef;
unsigned LLVMGetNumOperandBundles(LLVMValueRef Instr);
LLVMOperandBundleUseRef LLVMGetOperandBundle(LLVMValueRef Val, unsigned Index);
void LLVMDisposeOperandBundleUse(LLVMOperandBundleUseRef Bundle);
uint32_t LLVMGetOperandBundleUseTagID(LLVMOperandBundleUseRef Bundle);
const char *LLVMGetOperandBundleUseTagName(LLVMOperandBundleUseRef Bundle, unsigned *Length);
unsigned LLVMGetOperandBundleUseNumInputs(LLVMOperandBundleUseRef Bundle);
void LLVMGetOperandBundleUseInputs(LLVMOperandBundleUseRef Bundle, LLVMValueRef *Dest);
typedef struct LLVMOpaqueOperandBundleDef *LLVMOperandBundleDefRef;
LLVMOperandBundleDefRef LLVMOperandBundleDefFromUse(LLVMOperandBundleUseRef Bundle);
LLVMOperandBundleDefRef LLVMCreateOperandBundleDef(const char *Tag, LLVMValueRef *Inputs,
                                                   unsigned NumInputs);
void LLVMDisposeOperandBundleDef(LLVMOperandBundleDefRef Bundle);
const char *LLVMGetOperandBundleDefTag(LLVMOperandBundleDefRef Bundle, unsigned *Length);
unsigned LLVMGetOperandBundleDefNumInputs(LLVMOperandBundleDefRef Bundle);
void LLVMGetOperandBundleDefInputs(LLVMOperandBundleDefRef Bundle, LLVMValueRef *Dest);
LLVMValueRef LLVMBuildCallWithOpBundle(LLVMBuilderRef B, LLVMValueRef Fn,
                                       LLVMValueRef *Args, unsigned NumArgs,
                                       LLVMOperandBundleDefRef *Bundles, unsigned NumBundles,
                                       const char *Name);
void LLVMAdjustPassManager(LLVMTargetMachineRef TM, LLVMPassManagerBuilderRef PMB);

typedef void (*LLVMPassManagerBuilderExtensionFunction)(
    void *Ctx, LLVMPassManagerBuilderRef PMB, LLVMPassManagerRef PM);

typedef enum {
    EP_EarlyAsPossible,
    EP_ModuleOptimizerEarly,
    EP_LoopOptimizerEnd,
    EP_ScalarOptimizerLate,
    EP_OptimizerLast,
    EP_VectorizerStart,
    EP_EnabledOnOptLevel0,
    EP_Peephole,
    EP_LateLoopOptimizations,
    EP_CGSCCOptimizerLate,
    EP_FullLinkTimeOptimizationEarly,
    EP_FullLinkTimeOptimizationLast,
} LLVMPassManagerBuilderExtensionPointTy;

void LLVMPassManagerBuilderAddExtension(LLVMPassManagerBuilderRef PMB,
                                        LLVMPassManagerBuilderExtensionPointTy Ty,
                                        LLVMPassManagerBuilderExtensionFunction Fn, void *Ctx);

LLVM_C_EXTERN_C_END
#endif
