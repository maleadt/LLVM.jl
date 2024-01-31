#ifndef LLVMEXTRA_NEWPM_H
#define LLVMEXTRA_NEWPM_H

#include "llvm/Config/llvm-config.h"
#include <llvm-c/Core.h>
#include <llvm-c/Error.h>
#include <llvm-c/TargetMachine.h>
#include <llvm-c/Types.h>

#if LLVM_VERSION_MAJOR >= 15

LLVM_C_EXTERN_C_BEGIN

typedef struct LLVMOpaquePreservedAnalyses *LLVMPreservedAnalysesRef;

LLVMPreservedAnalysesRef LLVMCreatePreservedAnalysesNone(void);
LLVMPreservedAnalysesRef LLVMCreatePreservedAnalysesAll(void);
LLVMPreservedAnalysesRef LLVMCreatePreservedAnalysesCFG(void);

void LLVMDisposePreservedAnalyses(LLVMPreservedAnalysesRef PA);

LLVMBool LLVMAreAllAnalysesPreserved(LLVMPreservedAnalysesRef PA);
LLVMBool LLVMAreCFGAnalysesPreserved(LLVMPreservedAnalysesRef PA);

typedef struct LLVMOpaqueModuleAnalysisManager *LLVMModuleAnalysisManagerRef;
typedef struct LLVMOpaqueCGSCCAnalysisManager *LLVMCGSCCAnalysisManagerRef;
typedef struct LLVMOpaqueFunctionAnalysisManager *LLVMFunctionAnalysisManagerRef;
typedef struct LLVMOpaqueLoopAnalysisManager *LLVMLoopAnalysisManagerRef;

LLVMModuleAnalysisManagerRef LLVMCreateNewPMModuleAnalysisManager(void);
LLVMCGSCCAnalysisManagerRef LLVMCreateNewPMCGSCCAnalysisManager(void);
LLVMFunctionAnalysisManagerRef LLVMCreateNewPMFunctionAnalysisManager(void);
LLVMLoopAnalysisManagerRef LLVMCreateNewPMLoopAnalysisManager(void);

void LLVMDisposeNewPMModuleAnalysisManager(LLVMModuleAnalysisManagerRef AM);
void LLVMDisposeNewPMCGSCCAnalysisManager(LLVMCGSCCAnalysisManagerRef AM);
void LLVMDisposeNewPMFunctionAnalysisManager(LLVMFunctionAnalysisManagerRef AM);
void LLVMDisposeNewPMLoopAnalysisManager(LLVMLoopAnalysisManagerRef AM);

typedef struct LLVMOpaqueModulePassManager *LLVMModulePassManagerRef;
typedef struct LLVMOpaqueCGSCCPassManager *LLVMCGSCCPassManagerRef;
typedef struct LLVMOpaqueFunctionPassManager *LLVMFunctionPassManagerRef;
typedef struct LLVMOpaqueLoopPassManager *LLVMLoopPassManagerRef;

LLVMModulePassManagerRef LLVMCreateNewPMModulePassManager(void);
LLVMCGSCCPassManagerRef LLVMCreateNewPMCGSCCPassManager(void);
LLVMFunctionPassManagerRef LLVMCreateNewPMFunctionPassManager(void);
LLVMLoopPassManagerRef LLVMCreateNewPMLoopPassManager(void);

void LLVMDisposeNewPMModulePassManager(LLVMModulePassManagerRef PM);
void LLVMDisposeNewPMCGSCCPassManager(LLVMCGSCCPassManagerRef PM);
void LLVMDisposeNewPMFunctionPassManager(LLVMFunctionPassManagerRef PM);
void LLVMDisposeNewPMLoopPassManager(LLVMLoopPassManagerRef PM);

LLVMPreservedAnalysesRef LLVMRunNewPMModulePassManager(LLVMModulePassManagerRef PM,
                                                       LLVMModuleRef M,
                                                       LLVMModuleAnalysisManagerRef AM);
LLVMPreservedAnalysesRef LLVMRunNewPMFunctionPassManager(LLVMFunctionPassManagerRef PM,
                                                         LLVMValueRef F,
                                                         LLVMFunctionAnalysisManagerRef AM);

typedef struct LLVMOpaqueStandardInstrumentations *LLVMStandardInstrumentationsRef;
typedef struct LLVMOpaquePassInstrumentationCallbacks *LLVMPassInstrumentationCallbacksRef;

LLVMStandardInstrumentationsRef LLVMCreateStandardInstrumentations(LLVMContextRef C,
                                                                   LLVMBool DebugLogging,
                                                                   LLVMBool VerifyEach);
LLVMPassInstrumentationCallbacksRef LLVMCreatePassInstrumentationCallbacks(void);

void LLVMDisposeStandardInstrumentations(LLVMStandardInstrumentationsRef SI);
void LLVMDisposePassInstrumentationCallbacks(LLVMPassInstrumentationCallbacksRef PIC);

void LLVMAddStandardInstrumentations(LLVMPassInstrumentationCallbacksRef PIC,
                                     LLVMStandardInstrumentationsRef SI);

typedef struct LLVMOpaquePassBuilder *LLVMPassBuilderRef;

LLVMPassBuilderRef LLVMCreatePassBuilder(LLVMTargetMachineRef TM,
                                         LLVMPassInstrumentationCallbacksRef PIC);

void LLVMDisposePassBuilder(LLVMPassBuilderRef PB);

LLVMErrorRef LLVMPassBuilderParseModulePassPipeline(LLVMPassBuilderRef PB,
                                                    LLVMModulePassManagerRef PM,
                                                    const char *PipelineText,
                                                    size_t PipelineTextLength);
LLVMErrorRef LLVMPassBuilderParseCGSCCPassPipeline(LLVMPassBuilderRef PB,
                                                   LLVMCGSCCPassManagerRef PM,
                                                   const char *PipelineText,
                                                   size_t PipelineTextLength);
LLVMErrorRef LLVMPassBuilderParseFunctionPassPipeline(LLVMPassBuilderRef PB,
                                                      LLVMFunctionPassManagerRef PM,
                                                      const char *PipelineText,
                                                      size_t PipelineTextLength);
LLVMErrorRef LLVMPassBuilderParseLoopPassPipeline(LLVMPassBuilderRef PB,
                                                  LLVMLoopPassManagerRef PM,
                                                  const char *PipelineText,
                                                  size_t PipelineTextLength);

void LLVMPassBuilderRegisterModuleAnalyses(LLVMPassBuilderRef PB,
                                           LLVMModuleAnalysisManagerRef AM);
void LLVMPassBuilderRegisterCGSCCAnalyses(LLVMPassBuilderRef PB,
                                          LLVMCGSCCAnalysisManagerRef AM);
void LLVMPassBuilderRegisterFunctionAnalyses(LLVMPassBuilderRef PB,
                                             LLVMFunctionAnalysisManagerRef AM);
void LLVMPassBuilderRegisterLoopAnalyses(LLVMPassBuilderRef PB,
                                         LLVMLoopAnalysisManagerRef AM);

void LLVMPassBuilderCrossRegisterProxies(LLVMPassBuilderRef PB,
                                         LLVMLoopAnalysisManagerRef LAM,
                                         LLVMFunctionAnalysisManagerRef FAM,
                                         LLVMCGSCCAnalysisManagerRef CGAM,
                                         LLVMModuleAnalysisManagerRef MAM);

void LLVMMPMAddMPM(LLVMModulePassManagerRef PM, LLVMModulePassManagerRef NestedPM);
void LLVMCGPMAddCGPM(LLVMCGSCCPassManagerRef PM, LLVMCGSCCPassManagerRef NestedPM);
void LLVMFPMAddFPM(LLVMFunctionPassManagerRef PM, LLVMFunctionPassManagerRef NestedPM);
void LLVMLPMAddLPM(LLVMLoopPassManagerRef PM, LLVMLoopPassManagerRef NestedPM);

void LLVMMPMAddCGPM(LLVMModulePassManagerRef PM, LLVMCGSCCPassManagerRef NestedPM);
void LLVMCGPMAddFPM(LLVMCGSCCPassManagerRef PM, LLVMFunctionPassManagerRef NestedPM);
void LLVMFPMAddLPM(LLVMFunctionPassManagerRef PM, LLVMLoopPassManagerRef NestedPM,
                   LLVMBool UseMemorySSA);
void LLVMMPMAddFPM(LLVMModulePassManagerRef PM, LLVMFunctionPassManagerRef NestedPM);

typedef LLVMPreservedAnalysesRef (*LLVMJuliaModulePassCallback)(
    LLVMModuleRef M, LLVMModuleAnalysisManagerRef AM, void *Thunk);
typedef LLVMPreservedAnalysesRef (*LLVMJuliaFunctionPassCallback)(
    LLVMValueRef F, LLVMFunctionAnalysisManagerRef AM, void *Thunk);

void LLVMMPMAddJuliaPass(LLVMModulePassManagerRef PM, LLVMJuliaModulePassCallback Callback,
                         void *Thunk);
void LLVMFPMAddJuliaPass(LLVMFunctionPassManagerRef PM,
                         LLVMJuliaFunctionPassCallback Callback, void *Thunk);


// Target Analyses
LLVMBool LLVMRegisterTargetIRAnalysis(LLVMFunctionAnalysisManagerRef FAM,
                                      LLVMTargetMachineRef TM);
LLVMBool LLVMRegisterTargetLibraryAnalysis(LLVMFunctionAnalysisManagerRef FAM,
                                           const char *Triple, size_t TripleLength);


// Analyses
LLVMErrorRef LLVMRegisterAliasAnalyses(LLVMFunctionAnalysisManagerRef FAM,
                                       LLVMPassBuilderRef PB, LLVMTargetMachineRef TM,
                                       const char *Analyses, size_t AnalysesLength);

LLVM_C_EXTERN_C_END

#endif

#endif
