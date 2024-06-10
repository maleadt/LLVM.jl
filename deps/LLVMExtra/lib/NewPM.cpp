#include "LLVMExtra.h"

#include <llvm/IR/Verifier.h>
#include <llvm/Passes/PassBuilder.h>
#include <llvm/Passes/StandardInstrumentations.h>
#include <llvm/Support/CBindingWrapping.h>

using namespace llvm;

static TargetMachine *unwrap(LLVMTargetMachineRef P) {
  return reinterpret_cast<TargetMachine *>(P);
}

// Extension object

namespace llvm {

// Keep this in sync with PassBuilderBindings.cpp!
class LLVMPassBuilderOptions {
public:
  explicit LLVMPassBuilderOptions(bool DebugLogging = false, bool VerifyEach = false,
                                  PipelineTuningOptions PTO = PipelineTuningOptions())
      : DebugLogging(DebugLogging), VerifyEach(VerifyEach), PTO(PTO) {}

  bool DebugLogging;
  bool VerifyEach;
  PipelineTuningOptions PTO;
};
DEFINE_SIMPLE_CONVERSION_FUNCTIONS(LLVMPassBuilderOptions, LLVMPassBuilderOptionsRef)

class LLVMPassBuilderExtensions {
public:
  void (*RegistrationCallback)(void *);
  SmallVector<std::function<bool(StringRef, ModulePassManager &,
                                 ArrayRef<PassBuilder::PipelineElement>)>,
              2>
      ModulePipelineParsingCallbacks;
  SmallVector<std::function<bool(StringRef, FunctionPassManager &,
                                 ArrayRef<PassBuilder::PipelineElement>)>,
              2>
      FunctionPipelineParsingCallbacks;
};
DEFINE_SIMPLE_CONVERSION_FUNCTIONS(LLVMPassBuilderExtensions, LLVMPassBuilderExtensionsRef)
} // namespace llvm

LLVMPassBuilderExtensionsRef LLVMCreatePassBuilderExtensions() {
  return wrap(new LLVMPassBuilderExtensions());
}

void LLVMDisposePassBuilderExtensions(LLVMPassBuilderExtensionsRef Extensions) {
  delete unwrap(Extensions);
}


// Pass registration

void LLVMPassBuilderExtensionsSetRegistrationCallback(
    LLVMPassBuilderExtensionsRef Extensions, void (*RegistrationCallback)(void *)) {
  LLVMPassBuilderExtensions *PassExts = unwrap(Extensions);
  PassExts->RegistrationCallback = RegistrationCallback;
  return;
}


// Custom passes

struct JuliaCustomModulePass : llvm::PassInfoMixin<JuliaCustomModulePass> {
  LLVMJuliaModulePassCallback Callback;
  void *Thunk;
  JuliaCustomModulePass(LLVMJuliaModulePassCallback Callback, void *Thunk)
      : Callback(Callback), Thunk(Thunk) {}
  llvm::PreservedAnalyses run(llvm::Module &M, llvm::ModuleAnalysisManager &) {
    auto changed = Callback(wrap(&M), Thunk);
    return changed ? llvm::PreservedAnalyses::none() : llvm::PreservedAnalyses::all();
  }
};

struct JuliaCustomFunctionPass : llvm::PassInfoMixin<JuliaCustomFunctionPass> {
  LLVMJuliaFunctionPassCallback Callback;
  void *Thunk;
  JuliaCustomFunctionPass(LLVMJuliaFunctionPassCallback Callback, void *Thunk)
      : Callback(Callback), Thunk(Thunk) {}
  llvm::PreservedAnalyses run(llvm::Function &F, llvm::FunctionAnalysisManager &) {
    auto changed = Callback(wrap(&F), Thunk);
    return changed ? llvm::PreservedAnalyses::none() : llvm::PreservedAnalyses::all();
  }
};

void LLVMPassBuilderExtensionsRegisterModulePass(LLVMPassBuilderExtensionsRef Extensions,
                                                 const char *PassName,
                                                 LLVMJuliaModulePassCallback Callback,
                                                 void *Thunk) {
  LLVMPassBuilderExtensions *PassExts = unwrap(Extensions);
  PassExts->ModulePipelineParsingCallbacks.push_back(
      [PassName, Callback, Thunk](StringRef Name, ModulePassManager &PM,
                                  ArrayRef<PassBuilder::PipelineElement> Pipeline) {
        if (Name.consume_front(PassName)) {
          PM.addPass(JuliaCustomModulePass(Callback, Thunk));
          return true;
        }
        return false;
      });
  return;
}

void LLVMPassBuilderExtensionsRegisterFunctionPass(LLVMPassBuilderExtensionsRef Extensions,
                                                   const char *PassName,
                                                   LLVMJuliaFunctionPassCallback Callback,
                                                   void *Thunk) {
  LLVMPassBuilderExtensions *PassExts = unwrap(Extensions);
  PassExts->FunctionPipelineParsingCallbacks.push_back(
      [PassName, Callback, Thunk](StringRef Name, FunctionPassManager &PM,
                                  ArrayRef<PassBuilder::PipelineElement> Pipeline) {
        if (Name.consume_front(PassName)) {
          PM.addPass(JuliaCustomFunctionPass(Callback, Thunk));
          return true;
        }
        return false;
      });
  return;
}


// Vendored API entrypoint

LLVMErrorRef LLVMRunJuliaPasses(LLVMModuleRef M, const char *Passes,
                                LLVMTargetMachineRef TM, LLVMPassBuilderOptionsRef Options,
                                LLVMPassBuilderExtensionsRef Extensions) {
  TargetMachine *Machine = unwrap(TM);
  LLVMPassBuilderOptions *PassOpts = unwrap(Options);
  LLVMPassBuilderExtensions *PassExts = unwrap(Extensions);
  bool Debug = PassOpts->DebugLogging;
  bool VerifyEach = PassOpts->VerifyEach;

  Module *Mod = unwrap(M);
  PassInstrumentationCallbacks PIC;
#if LLVM_VERSION_MAJOR >= 16
  PassBuilder PB(Machine, PassOpts->PTO, std::nullopt, &PIC);
#else
  PassBuilder PB(Machine, PassOpts->PTO, None, &PIC);
#endif
  if (PassExts->RegistrationCallback) {
    PassExts->RegistrationCallback(&PB);
  }
  for (auto &Callback : PassExts->ModulePipelineParsingCallbacks) {
    PB.registerPipelineParsingCallback(Callback);
  }
  for (auto &Callback : PassExts->FunctionPipelineParsingCallbacks) {
    PB.registerPipelineParsingCallback(Callback);
  }

  LoopAnalysisManager LAM;
  FunctionAnalysisManager FAM;
  CGSCCAnalysisManager CGAM;
  ModuleAnalysisManager MAM;
  PB.registerLoopAnalyses(LAM);
  PB.registerFunctionAnalyses(FAM);
  PB.registerCGSCCAnalyses(CGAM);
  PB.registerModuleAnalyses(MAM);
  PB.crossRegisterProxies(LAM, FAM, CGAM, MAM);

#if LLVM_VERSION_MAJOR >= 16
  StandardInstrumentations SI(Mod->getContext(), Debug, VerifyEach);
#else
  StandardInstrumentations SI(Debug, VerifyEach);
#endif
#if LLVM_VERSION_MAJOR >= 17
  SI.registerCallbacks(PIC, &MAM);
#else
  SI.registerCallbacks(PIC, &FAM);
#endif
  ModulePassManager MPM;
  if (VerifyEach) {
    MPM.addPass(VerifierPass());
  }
  if (auto Err = PB.parsePassPipeline(MPM, Passes)) {
    return wrap(std::move(Err));
  }

  MPM.run(*Mod, MAM);
  return LLVMErrorSuccess;
}
