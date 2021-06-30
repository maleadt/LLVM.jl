#ifndef LLVMEXTRA_H
#define LLVMEXTRA_H

#include <llvm-c/Core.h>
#include <llvm-c/Types.h>

LLVM_C_EXTERN_C_BEGIN

void LLVMExtraInitializeAllTargetInfos();
void LLVMExtraInitializeAllTargets();
void LLVMExtraInitializeAllTargetMCs();
void LLVMExtraInitializeAllAsmPrinters();
void LLVMExtraInitializeAllAsmParsers();
void LLVMExtraInitializeAllDisassemblers();
LLVMBool LLVMExtraInitializeNativeTarget();
LLVMBool LLVMExtraInitializeNativeAsmParser();
LLVMBool LLVMExtraInitializeNativeAsmPrinter();
LLVMBool LLVMExtraInitializeNativeDisassembler();

// Various missing passes (being upstreamed)
void LLVMExtraAddBarrierNoopPass(LLVMPassManagerRef PM);
void LLVMExtraAddDivRemPairsPass(LLVMPassManagerRef PM);
void LLVMExtraAddLoopDistributePass(LLVMPassManagerRef PM);
void LLVMExtraAddLoopFusePass(LLVMPassManagerRef PM);
void LLVMExtraLoopLoadEliminationPass(LLVMPassManagerRef PM);
void LLVMExtraAddLoadStoreVectorizerPass(LLVMPassManagerRef PM);
void LLVMExtraAddVectorCombinePass(LLVMPassManagerRef PM);

#if LLVM_VERSION_MAJOR < 12
void LLVMExtraAddInstructionSimplifyPass(LLVMPassManagerRef PM);
#endif

// Infrastructure for writing LLVM passes in Julia
typedef struct LLVMOpaquePass *LLVMPassRef;

void LLVMExtraAddPass(LLVMPassManagerRef PM, LLVMPassRef P);
typedef LLVMBool (*LLVMPassCallback)(void *Ref, void *Data);

LLVMPassRef
LLVMExtraCreateModulePass2(const char *Name, LLVMPassCallback Callback, void *Data);

LLVMPassRef
LLVMExtraCreateFunctionPass2(const char *Name, LLVMPassCallback Callback, void *Data);

// Various missing functions
unsigned int LLVMExtraGetDebugMDVersion();

LLVMContextRef LLVMExtraGetValueContext(LLVMValueRef V);
void LLVMExtraAddTargetLibraryInfoByTiple(const char *T, LLVMPassManagerRef PM);
void LLVMExtraAddInternalizePassWithExportList(
    LLVMPassManagerRef PM, const char **ExportList, size_t Length);

void LLVMExtraAppendToUsed(LLVMModuleRef Mod,
                           LLVMValueRef *Values,
                           size_t Count);
void LLVMExtraAppendToCompilerUsed(LLVMModuleRef Mod,
                                   LLVMValueRef *Values,
                                   size_t Count);
void LLVMExtraAddGenericAnalysisPasses(LLVMPassManagerRef PM);

LLVM_C_EXTERN_C_END
#endif
