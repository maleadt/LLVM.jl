#ifndef LLVMEXTRA_H
#define LLVMEXTRA_H

#include "llvm/Config/llvm-config.h"
#include <llvm-c/Core.h>
#include <llvm-c/Orc.h>
#include <llvm-c/Target.h>
#include <llvm-c/Types.h>
#include <llvm/Support/CBindingWrapping.h>

LLVM_C_EXTERN_C_BEGIN

// XXX: without this, Clang.jl doesn't emit LLVMExtraInitializeNativeTarget.
//      maybe LLVM_C_EXTERN_C_BEGIN somehow eats the function definition?
void dummy();

LLVMBool LLVMExtraInitializeNativeTarget(void);
LLVMBool LLVMExtraInitializeNativeAsmParser(void);
LLVMBool LLVMExtraInitializeNativeAsmPrinter(void);
LLVMBool LLVMExtraInitializeNativeDisassembler(void);

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
void LLVMAddSimpleLoopUnswitchLegacyPass(LLVMPassManagerRef PM);


// Infrastructure for writing LLVM passes in Julia
typedef struct LLVMOpaquePass *LLVMPassRef;

void LLVMAddPass(LLVMPassManagerRef PM, LLVMPassRef P);
typedef LLVMBool (*LLVMPassCallback)(void *Ref, void *Data);

LLVMPassRef LLVMCreateModulePass2(const char *Name, LLVMPassCallback Callback, void *Data);

LLVMPassRef LLVMCreateFunctionPass2(const char *Name, LLVMPassCallback Callback,
                                    void *Data);


// Various missing functions
unsigned int LLVMGetDebugMDVersion(void);

LLVMContextRef LLVMGetBuilderContext(LLVMBuilderRef B);
LLVMContextRef LLVMGetValueContext(LLVMValueRef V);
void LLVMAddTargetLibraryInfoByTriple(const char *T, LLVMPassManagerRef PM);
void LLVMAddInternalizePassWithExportList(LLVMPassManagerRef PM, const char **ExportList,
                                          size_t Length);

void LLVMAppendToUsed(LLVMModuleRef Mod, LLVMValueRef *Values, size_t Count);
void LLVMAppendToCompilerUsed(LLVMModuleRef Mod, LLVMValueRef *Values, size_t Count);
void LLVMAddGenericAnalysisPasses(LLVMPassManagerRef PM);

void LLVMDumpMetadata(LLVMMetadataRef MD);

char *LLVMPrintMetadataToString(LLVMMetadataRef MD);

const char *LLVMDIScopeGetName(LLVMMetadataRef File, unsigned *Len);

const char *LLVMGetMDString2(LLVMMetadataRef MD, unsigned *Length);

unsigned LLVMGetMDNodeNumOperands2(LLVMMetadataRef MD);

void LLVMGetMDNodeOperands2(LLVMMetadataRef MD, LLVMMetadataRef *Dest);

unsigned LLVMGetNamedMetadataNumOperands2(LLVMNamedMDNodeRef NMD);

void LLVMGetNamedMetadataOperands2(LLVMNamedMDNodeRef NMD, LLVMMetadataRef *Dest);

void LLVMAddNamedMetadataOperand2(LLVMNamedMDNodeRef NMD, LLVMMetadataRef Val);

typedef struct LLVMOrcOpaqueIRCompileLayer *LLVMOrcIRCompileLayerRef;

void LLVMOrcIRCompileLayerEmit(LLVMOrcIRCompileLayerRef IRLayer,
                               LLVMOrcMaterializationResponsibilityRef MR,
                               LLVMOrcThreadSafeModuleRef TSM);

char *LLVMDumpJitDylibToString(LLVMOrcJITDylibRef JD);

LLVMTypeRef LLVMGetFunctionType(LLVMValueRef Fn);
LLVMTypeRef LLVMGetGlobalValueType(LLVMValueRef Fn);

void LLVMAddCFGSimplificationPass2(LLVMPassManagerRef PM, int BonusInstThreshold,
                                   LLVMBool ForwardSwitchCondToPhi,
                                   LLVMBool ConvertSwitchToLookupTable,
                                   LLVMBool NeedCanonicalLoop, LLVMBool HoistCommonInsts,
                                   LLVMBool SinkCommonInsts, LLVMBool SimplifyCondBranch,
                                   LLVMBool FoldTwoEntryPHINode);


// Bug fixes
void LLVMSetInitializer2(LLVMValueRef GlobalVar, LLVMValueRef ConstantVal);
void LLVMSetPersonalityFn2(LLVMValueRef Fn, LLVMValueRef PersonalityFn);

typedef enum {
  LLVMCloneFunctionChangeTypeLocalChangesOnly = 0,
  LLVMCloneFunctionChangeTypeGlobalChanges = 1,
  LLVMCloneFunctionChangeTypeDifferentModule = 2,
  LLVMCloneFunctionChangeTypeClonedModule = 3
} LLVMCloneFunctionChangeType;

void LLVMCloneFunctionInto(LLVMValueRef NewFunc, LLVMValueRef OldFunc,
                           LLVMValueRef *ValueMap, unsigned ValueMapElements,
                           LLVMCloneFunctionChangeType Changes, const char *NameSuffix,
                           LLVMTypeRef (*TypeMapper)(LLVMTypeRef, void *),
                           void *TypeMapperData,
                           LLVMValueRef (*Materializer)(LLVMValueRef, void *),
                           void *MaterializerData);

LLVMBasicBlockRef LLVMCloneBasicBlock(LLVMBasicBlockRef BB, const char *NameSuffix,
                                      LLVMValueRef *ValueMap, unsigned ValueMapElements,
                                      LLVMValueRef F);

void LLVMFunctionDeleteBody(LLVMValueRef Func);

void LLVMDestroyConstant(LLVMValueRef Const);


// operand bundles
typedef struct LLVMOpaqueOperandBundleUse *LLVMOperandBundleUseRef;
unsigned LLVMGetNumOperandBundles(LLVMValueRef Instr);
LLVMOperandBundleUseRef LLVMGetOperandBundle(LLVMValueRef Val, unsigned Index);
void LLVMDisposeOperandBundleUse(LLVMOperandBundleUseRef Bundle);
uint32_t LLVMGetOperandBundleUseTagID(LLVMOperandBundleUseRef Bundle);
const char *LLVMGetOperandBundleUseTagName(LLVMOperandBundleUseRef Bundle,
                                           unsigned *Length);
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
                                       LLVMOperandBundleDefRef *Bundles,
                                       unsigned NumBundles, const char *Name);
LLVMValueRef LLVMBuildCallWithOpBundle2(LLVMBuilderRef B, LLVMTypeRef Ty, LLVMValueRef Fn,
                                        LLVMValueRef *Args, unsigned NumArgs,
                                        LLVMOperandBundleDefRef *Bundles,
                                        unsigned NumBundles, const char *Name);


// metadata
LLVMValueRef LLVMMetadataAsValue2(LLVMContextRef C, LLVMMetadataRef Metadata);
void LLVMReplaceAllMetadataUsesWith(LLVMValueRef Old, LLVMValueRef New);
void LLVMReplaceMDNodeOperandWith(LLVMMetadataRef MD, unsigned I, LLVMMetadataRef New);


// constant data
LLVMValueRef LLVMConstDataArray(LLVMTypeRef ElementTy, const void *Data,
                                unsigned NumElements);


// missing opaque pointer APIs
LLVMBool LLVMContextSupportsTypedPointers(LLVMContextRef C);
#if LLVM_VERSION_MAJOR < 15
LLVMBool LLVMPointerTypeIsOpaque(LLVMTypeRef Ty);
LLVMTypeRef LLVMPointerTypeInContext(LLVMContextRef C, unsigned AddressSpace);
#endif


// (Post)DominatorTree
typedef struct LLVMOpaqueDominatorTree *LLVMDominatorTreeRef;
LLVMDominatorTreeRef LLVMCreateDominatorTree(LLVMValueRef Fn);
void LLVMDisposeDominatorTree(LLVMDominatorTreeRef Tree);
LLVMBool LLVMDominatorTreeInstructionDominates(LLVMDominatorTreeRef Tree,
                                               LLVMValueRef InstA, LLVMValueRef InstB);

typedef struct LLVMOpaquePostDominatorTree *LLVMPostDominatorTreeRef;
LLVMPostDominatorTreeRef LLVMCreatePostDominatorTree(LLVMValueRef Fn);
void LLVMDisposePostDominatorTree(LLVMPostDominatorTreeRef Tree);
LLVMBool LLVMPostDominatorTreeInstructionDominates(LLVMPostDominatorTreeRef Tree,
                                                   LLVMValueRef InstA, LLVMValueRef InstB);


LLVM_C_EXTERN_C_END
#endif
