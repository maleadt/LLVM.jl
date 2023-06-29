#include "NewPM.h"

#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/Passes/PassBuilder.h>
#include <llvm/Passes/StandardInstrumentations.h>

#include "llvm/Support/CBindingWrapping.h"

DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::TargetMachine, LLVMTargetMachineRef)

DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::PreservedAnalyses, LLVMPreservedAnalysesRef)

LLVMPreservedAnalysesRef LLVMCreatePreservedAnalysesNone(void) {
    return wrap(new llvm::PreservedAnalyses(llvm::PreservedAnalyses::none()));
}
LLVMPreservedAnalysesRef LLVMCreatePreservedAnalysesAll(void) {
    return wrap(new llvm::PreservedAnalyses(llvm::PreservedAnalyses::all()));
}
LLVMPreservedAnalysesRef LLVMCreatePreservedAnalysesCFG(void) {
    return wrap(new llvm::PreservedAnalyses(llvm::PreservedAnalyses::allInSet<llvm::CFGAnalyses>()));
}

DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::ModuleAnalysisManager, LLVMModuleAnalysisManagerRef)
DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::CGSCCAnalysisManager, LLVMCGSCCAnalysisManagerRef)
DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::FunctionAnalysisManager, LLVMFunctionAnalysisManagerRef)
DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::LoopAnalysisManager, LLVMLoopAnalysisManagerRef)
DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::AAManager, LLVMAAManagerRef)

LLVMModuleAnalysisManagerRef LLVMCreateNewPMModuleAnalysisManager(void) {
    return wrap(new llvm::ModuleAnalysisManager());
}
LLVMCGSCCAnalysisManagerRef LLVMCreateNewPMCGSCCAnalysisManager(void) {
    return wrap(new llvm::CGSCCAnalysisManager());
}
LLVMFunctionAnalysisManagerRef LLVMCreateNewPMFunctionAnalysisManager(void) {
    return wrap(new llvm::FunctionAnalysisManager());
}
LLVMLoopAnalysisManagerRef LLVMCreateNewPMLoopAnalysisManager(void) {
    return wrap(new llvm::LoopAnalysisManager());
}
LLVMAAManagerRef LLVMCreateNewPMAAManager(void) {
    return wrap(new llvm::AAManager());
}

void LLVMDisposeNewPMModuleAnalysisManager(LLVMModuleAnalysisManagerRef AM) {
    delete unwrap(AM);
}
void LLVMDisposeNewPMCGSCCAnalysisManager(LLVMCGSCCAnalysisManagerRef AM) {
    delete unwrap(AM);
}
void LLVMDisposeNewPMFunctionAnalysisManager(LLVMFunctionAnalysisManagerRef AM) {
    delete unwrap(AM);
}
void LLVMDisposeNewPMLoopAnalysisManager(LLVMLoopAnalysisManagerRef AM) {
    delete unwrap(AM);
}
void LLVMDisposeNewPMAAManager(LLVMAAManagerRef AM) {
    delete unwrap(AM);
}

DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::ModulePassManager, LLVMModulePassManagerRef)
DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::CGSCCPassManager, LLVMCGSCCPassManagerRef)
DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::FunctionPassManager, LLVMFunctionPassManagerRef)
DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::LoopPassManager, LLVMLoopPassManagerRef)

LLVMModulePassManagerRef LLVMCreateNewPMModulePassManager(void) {
    return wrap(new llvm::ModulePassManager());
}
LLVMCGSCCPassManagerRef LLVMCreateNewPMCGSCCPassManager(void) {
    return wrap(new llvm::CGSCCPassManager());
}
LLVMFunctionPassManagerRef LLVMCreateNewPMFunctionPassManager(void) {
    return wrap(new llvm::FunctionPassManager());
}
LLVMLoopPassManagerRef LLVMCreateNewPMLoopPassManager(void) {
    return wrap(new llvm::LoopPassManager());
}

void LLVMDisposeNewPMModulePassManager(LLVMModulePassManagerRef PM) {
    delete unwrap(PM);
}
void LLVMDisposeNewPMCGSCCPassManager(LLVMCGSCCPassManagerRef PM) {
    delete unwrap(PM);
}
void LLVMDisposeNewPMFunctionPassManager(LLVMFunctionPassManagerRef PM) {
    delete unwrap(PM);
}
void LLVMDisposeNewPMLoopPassManager(LLVMLoopPassManagerRef PM) {
    delete unwrap(PM);
}

DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::StandardInstrumentations, LLVMStandardInstrumentationsRef)
DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::PassInstrumentationCallbacks, LLVMPassInstrumentationCallbacksRef)

LLVMStandardInstrumentationsRef LLVMCreateStandardInstrumentations(void) {
    return wrap(new llvm::StandardInstrumentations(false));
}
LLVMPassInstrumentationCallbacksRef LLVMCreatePassInstrumentationCallbacks(void) {
    return wrap(new llvm::PassInstrumentationCallbacks());
}

void LLVMDisposeStandardInstrumentations(LLVMStandardInstrumentationsRef SI) {
    delete unwrap(SI);
}
void LLVMDisposePassInstrumentationCallbacks(LLVMPassInstrumentationCallbacksRef PIC) {
    delete unwrap(PIC);
}

void LLVMAddStandardInstrumentations(LLVMPassInstrumentationCallbacksRef PIC, LLVMStandardInstrumentationsRef SI) {
    unwrap(SI)->registerCallbacks(*unwrap(PIC));
}

DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::PassBuilder, LLVMPassBuilderRef)

LLVMPassBuilderRef LLVMCreatePassBuilder(LLVMTargetMachineRef TM, LLVMPassInstrumentationCallbacksRef PIC) {
    return wrap(new llvm::PassBuilder(unwrap(TM), llvm::PipelineTuningOptions(), llvm::None, unwrap(PIC)));
}

void LLVMDisposePassBuilder(LLVMPassBuilderRef PB) {
    delete unwrap(PB);
}

LLVMErrorRef LLVMPassBuilderParseModulePassPipeline(LLVMPassBuilderRef PB, LLVMModulePassManagerRef PM, const char *PipelineText, size_t PipelineTextLength);
LLVMErrorRef LLVMPassBuilderParseCGSCCPassPipeline(LLVMPassBuilderRef PB, LLVMCGSCCPassManagerRef PM, const char *PipelineText, size_t PipelineTextLength);
LLVMErrorRef LLVMPassBuilderParseFunctionPassPipeline(LLVMPassBuilderRef PB, LLVMFunctionPassManagerRef PM, const char *PipelineText, size_t PipelineTextLength);
LLVMErrorRef LLVMPassBuilderParseLoopPassPipeline(LLVMPassBuilderRef PB, LLVMLoopPassManagerRef PM, const char *PipelineText, size_t PipelineTextLength);
LLVMErrorRef LLVMPassBuilderParseAAPipeline(LLVMPassBuilderRef PB, LLVMAAManagerRef AM, const char *PipelineText, size_t PipelineTextLength);

void LLVMPassBuilderRegisterModuleAnalyses(LLVMPassBuilderRef PB, LLVMModuleAnalysisManagerRef AM) {
    unwrap(PB)->registerModuleAnalyses(*unwrap(AM));
}
void LLVMPassBuilderRegisterCGSCCAnalyses(LLVMPassBuilderRef PB, LLVMCGSCCAnalysisManagerRef AM) {
    unwrap(PB)->registerCGSCCAnalyses(*unwrap(AM));
}
void LLVMPassBuilderRegisterFunctionAnalyses(LLVMPassBuilderRef PB, LLVMFunctionAnalysisManagerRef AM) {
    unwrap(PB)->registerFunctionAnalyses(*unwrap(AM));
}
void LLVMPassBuilderRegisterLoopAnalyses(LLVMPassBuilderRef PB, LLVMLoopAnalysisManagerRef AM) {
    unwrap(PB)->registerLoopAnalyses(*unwrap(AM));
}

void LLVMPassBuilderCrossRegisterProxies(LLVMPassBuilderRef PB, LLVMLoopAnalysisManagerRef LAM, LLVMFunctionAnalysisManagerRef FAM, LLVMCGSCCAnalysisManagerRef CGAM, LLVMModuleAnalysisManagerRef MAM) {
    unwrap(PB)->crossRegisterProxies(*unwrap(LAM), *unwrap(FAM), *unwrap(CGAM), *unwrap(MAM));
}

void LLVMMPMAddMPM(LLVMModulePassManagerRef PM, LLVMModulePassManagerRef NestedPM) {
    unwrap(PM)->addPass(std::move(*unwrap(NestedPM)));
}
void LLVMCGPMAddCGPM(LLVMCGSCCPassManagerRef PM, LLVMCGSCCPassManagerRef NestedPM) {
    unwrap(PM)->addPass(std::move(*unwrap(NestedPM)));
}
void LLVMFPMAddFPM(LLVMFunctionPassManagerRef PM, LLVMFunctionPassManagerRef NestedPM) {
    unwrap(PM)->addPass(std::move(*unwrap(NestedPM)));
}
void LLVMLPMAddLPM(LLVMLoopPassManagerRef PM, LLVMLoopPassManagerRef NestedPM) {
    unwrap(PM)->addPass(std::move(*unwrap(NestedPM)));
}

void LLVMMPMAddCGPM(LLVMModulePassManagerRef PM, LLVMCGSCCPassManagerRef NestedPM) {
    unwrap(PM)->addPass(llvm::createModuleToPostOrderCGSCCPassAdaptor(std::move(*unwrap(NestedPM))));
}
void LLVMCGPMAddFPM(LLVMCGSCCPassManagerRef PM, LLVMFunctionPassManagerRef NestedPM) {
    unwrap(PM)->addPass(llvm::createCGSCCToFunctionPassAdaptor(std::move(*unwrap(NestedPM))));
}
void LLVMFPMAddLPM(LLVMFunctionPassManagerRef PM, LLVMLoopPassManagerRef NestedPM) {
    unwrap(PM)->addPass(llvm::createFunctionToLoopPassAdaptor(std::move(*unwrap(NestedPM))));
}
void LLVMMPMAddFPM(LLVMModulePassManagerRef PM, LLVMFunctionPassManagerRef NestedPM) {
    unwrap(PM)->addPass(llvm::createModuleToFunctionPassAdaptor(std::move(*unwrap(NestedPM))));
}

namespace {

    struct JuliaCustomModulePass : llvm::PassInfoMixin<JuliaCustomModulePass> {
        LLVMJuliaModulePassCallback Callback;
        void *Thunk;
        JuliaCustomModulePass(LLVMJuliaModulePassCallback Callback, void *Thunk) : Callback(Callback), Thunk(Thunk) {}
        llvm::PreservedAnalyses run(llvm::Module &M, llvm::ModuleAnalysisManager &AM) {
            auto raw = unwrap(Callback(wrap(&M), wrap(&AM), Thunk));
            llvm::PreservedAnalyses PA(std::move(*raw));
            delete raw;
            return PA;
        }
    };

    struct JuliaCustomFunctionPass : llvm::PassInfoMixin<JuliaCustomFunctionPass> {
        LLVMJuliaFunctionPassCallback Callback;
        void *Thunk;
        JuliaCustomFunctionPass(LLVMJuliaFunctionPassCallback Callback, void *Thunk) : Callback(Callback), Thunk(Thunk) {}
        llvm::PreservedAnalyses run(llvm::Function &F, llvm::FunctionAnalysisManager &AM) {
            auto raw = unwrap(Callback(wrap(&F), wrap(&AM), Thunk));
            llvm::PreservedAnalyses PA(std::move(*raw));
            delete raw;
            return PA;
        }
    };
}

void LLVMMPMAddJuliaPass(LLVMModulePassManagerRef PM, LLVMJuliaModulePassCallback Callback, void *Thunk) {
    unwrap(PM)->addPass(JuliaCustomModulePass(Callback, Thunk));
}
void LLVMFPMAddJuliaPass(LLVMFunctionPassManagerRef PM, LLVMJuliaFunctionPassCallback Callback, void *Thunk) {
    unwrap(PM)->addPass(JuliaCustomFunctionPass(Callback, Thunk));
}
