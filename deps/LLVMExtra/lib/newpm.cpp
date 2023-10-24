#include "NewPM.h"

#if LLVM_VERSION_MAJOR >= 15

#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/Analysis/TargetTransformInfo.h>
#include <llvm/Passes/PassBuilder.h>
#include <llvm/Passes/StandardInstrumentations.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Function.h>
#include <llvm/Target/TargetMachine.h>

#include <llvm/Support/CBindingWrapping.h>

using llvm::wrap;
using llvm::unwrap;

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

void LLVMDisposePreservedAnalyses(LLVMPreservedAnalysesRef PA) {
    delete unwrap(PA);
}

LLVMBool LLVMAreAllAnalysesPreserved(LLVMPreservedAnalysesRef PA) {
    return unwrap(PA)->areAllPreserved();
}

LLVMBool LLVMAreCFGAnalysesPreserved(LLVMPreservedAnalysesRef PA) {
    return unwrap(PA)->allAnalysesInSetPreserved<llvm::CFGAnalyses>();
}

DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::ModuleAnalysisManager, LLVMModuleAnalysisManagerRef)
DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::CGSCCAnalysisManager, LLVMCGSCCAnalysisManagerRef)
DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::FunctionAnalysisManager, LLVMFunctionAnalysisManagerRef)
DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::LoopAnalysisManager, LLVMLoopAnalysisManagerRef)

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

LLVMPreservedAnalysesRef LLVMRunNewPMModulePassManager(LLVMModulePassManagerRef PM, LLVMModuleRef M, LLVMModuleAnalysisManagerRef AM) {
    return wrap(new llvm::PreservedAnalyses(unwrap(PM)->run(*unwrap(M), *unwrap(AM))));
}
LLVMPreservedAnalysesRef LLVMRunNewPMFunctionPassManager(LLVMFunctionPassManagerRef PM, LLVMValueRef F, LLVMFunctionAnalysisManagerRef AM) {
    return wrap(new llvm::PreservedAnalyses(unwrap(PM)->run(*llvm::cast<llvm::Function>(unwrap(F)), *unwrap(AM))));
}

DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::StandardInstrumentations, LLVMStandardInstrumentationsRef)
DEFINE_SIMPLE_CONVERSION_FUNCTIONS(llvm::PassInstrumentationCallbacks, LLVMPassInstrumentationCallbacksRef)

LLVMStandardInstrumentationsRef LLVMCreateStandardInstrumentations(LLVMContextRef C, LLVMBool DebugLogging, LLVMBool VerifyEach) {
#if LLVM_VERSION_MAJOR >= 16
    return wrap(new llvm::StandardInstrumentations(*unwrap(C), DebugLogging, VerifyEach));
#else
    return wrap(new llvm::StandardInstrumentations(DebugLogging, VerifyEach));
#endif
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
#if LLVM_VERSION_MAJOR >= 16
    return wrap(new llvm::PassBuilder(unwrap(TM), llvm::PipelineTuningOptions(), std::nullopt, unwrap(PIC)));
#else
    return wrap(new llvm::PassBuilder(unwrap(TM), llvm::PipelineTuningOptions(), llvm::None, unwrap(PIC)));
#endif
}

void LLVMDisposePassBuilder(LLVMPassBuilderRef PB) {
    delete unwrap(PB);
}

LLVMErrorRef LLVMPassBuilderParseModulePassPipeline(LLVMPassBuilderRef PB, LLVMModulePassManagerRef PM, const char *PipelineText, size_t PipelineTextLength) {
    return wrap(unwrap(PB)->parsePassPipeline(*unwrap(PM), llvm::StringRef(PipelineText, PipelineTextLength)));
}
LLVMErrorRef LLVMPassBuilderParseCGSCCPassPipeline(LLVMPassBuilderRef PB, LLVMCGSCCPassManagerRef PM, const char *PipelineText, size_t PipelineTextLength) {
    return wrap(unwrap(PB)->parsePassPipeline(*unwrap(PM), llvm::StringRef(PipelineText, PipelineTextLength)));
}
LLVMErrorRef LLVMPassBuilderParseFunctionPassPipeline(LLVMPassBuilderRef PB, LLVMFunctionPassManagerRef PM, const char *PipelineText, size_t PipelineTextLength) {
    return wrap(unwrap(PB)->parsePassPipeline(*unwrap(PM), llvm::StringRef(PipelineText, PipelineTextLength)));
}
LLVMErrorRef LLVMPassBuilderParseLoopPassPipeline(LLVMPassBuilderRef PB, LLVMLoopPassManagerRef PM, const char *PipelineText, size_t PipelineTextLength) {
    return wrap(unwrap(PB)->parsePassPipeline(*unwrap(PM), llvm::StringRef(PipelineText, PipelineTextLength)));
}

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
void LLVMFPMAddLPM(LLVMFunctionPassManagerRef PM, LLVMLoopPassManagerRef NestedPM, LLVMBool UseMemorySSA) {
    unwrap(PM)->addPass(llvm::createFunctionToLoopPassAdaptor(std::move(*unwrap(NestedPM)), UseMemorySSA));
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

// Target Analyses

LLVMBool LLVMRegisterTargetIRAnalysis(LLVMFunctionAnalysisManagerRef FAM, LLVMTargetMachineRef TM) {
    return unwrap(FAM)->registerPass([&] { return llvm::TargetIRAnalysis(unwrap(TM)->getTargetIRAnalysis()); });
}
LLVMBool LLVMRegisterTargetLibraryAnalysis(LLVMFunctionAnalysisManagerRef FAM, const char *Triple, size_t TripleLength) {
    return unwrap(FAM)->registerPass([&] { return llvm::TargetLibraryAnalysis(llvm::TargetLibraryInfoImpl(llvm::Triple(llvm::StringRef(Triple, TripleLength)))); });
}

// Alias Analyses
LLVMErrorRef LLVMRegisterAliasAnalyses(LLVMFunctionAnalysisManagerRef FAM, LLVMPassBuilderRef PB, LLVMTargetMachineRef TM, const char *Analyses, size_t AnalysesLength) {
    llvm::AAManager AA;
    auto err = unwrap(PB)->parseAAPipeline(AA, llvm::StringRef(Analyses, AnalysesLength));
    if (err)
        return wrap(std::move(err));
    if (TM)
        unwrap(TM)->registerDefaultAliasAnalyses(AA);
    unwrap(FAM)->registerPass([&] { return std::move(AA); });
    return LLVMErrorSuccess;
}

#endif
