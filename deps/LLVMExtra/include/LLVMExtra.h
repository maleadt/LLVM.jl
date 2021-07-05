#ifndef LLVMEXTRA_H
#define LLVMEXTRA_H

#include <llvm-c/Core.h>
#include <llvm-c/Types.h>

LLVM_C_EXTERN_C_BEGIN

void LLVMInitializeAllTargetInfos(void);
void LLVMInitializeAllTargets(void);
void LLVMInitializeAllTargetMCs(void);
void LLVMInitializeAllAsmPrinters(void);
void LLVMInitializeAllAsmParsers(void);
void LLVMInitializeAllDisassemblers(void);
LLVMBool LLVMInitializeNativeTarget(void);
LLVMBool LLVMInitializeNativeAsmParser(void);
LLVMBool LLVMInitializeNativeAsmPrinter(void);
LLVMBool LLVMInitializeNativeDisassembler(void);

// Various missing passes (being upstreamed)
void LLVMAddBarrierNoopPass(LLVMPassManagerRef PM);
void LLVMAddDivRemPairsPass(LLVMPassManagerRef PM);
void LLVMAddLoopDistributePass(LLVMPassManagerRef PM);
void LLVMAddLoopFusePass(LLVMPassManagerRef PM);
void LLVMAddLoopLoadEliminationPass(LLVMPassManagerRef PM);
void LLVMAddLoadStoreVectorizerPass(LLVMPassManagerRef PM);
void LLVMAddVectorCombinePass(LLVMPassManagerRef PM);

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

const char *LLVMExtraDIScopeGetName(LLVMMetadataRef File, unsigned *Len);

// Bug fixes
void LLVMExtraSetInitializer(LLVMValueRef GlobalVar, LLVMValueRef ConstantVal);
void LLVMExtraSetPersonalityFn(LLVMValueRef Fn, LLVMValueRef PersonalityFn);

LLVM_C_EXTERN_C_END
#endif
