#include <LLVMExtra.h>

#include <llvm/ADT/Triple.h>
#include <llvm/Analysis/TargetLibraryInfo.h>
#include <llvm/Analysis/TargetTransformInfo.h>
#include <llvm/IR/Attributes.h>
#include <llvm/IR/DebugInfo.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/GlobalValue.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/IR/Module.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Transforms/IPO.h>
#include <llvm/Transforms/Scalar.h>
#include <llvm/Transforms/Vectorize.h>
#if LLVM_VERSION_MAJOR < 12
#include <llvm/Transforms/Scalar/InstSimplifyPass.h>
#endif
#include <llvm/Transforms/Utils/ModuleUtils.h>

using namespace llvm;
using namespace llvm::legacy;

// Initialization functions
//
// The LLVMInitialize* functions and friends are defined `static inline`

void LLVMExtraInitializeAllTargetInfos()
{
    InitializeAllTargetInfos();
}

void LLVMExtraInitializeAllTargets()
{
    InitializeAllTargets();
}

void LLVMExtraInitializeAllTargetMCs()
{
    InitializeAllTargetMCs();
}

void LLVMExtraInitializeAllAsmPrinters()
{
    InitializeAllAsmPrinters();
}

void LLVMExtraInitializeAllAsmParsers()
{
    InitializeAllAsmParsers();
}

void LLVMExtraInitializeAllDisassemblers()
{
    InitializeAllDisassemblers();
}

LLVMBool LLVMExtraInitializeNativeTarget()
{
    return InitializeNativeTarget();
}

LLVMBool LLVMExtraInitializeNativeAsmParser()
{
    return InitializeNativeTargetAsmParser();
}

LLVMBool LLVMExtraInitializeNativeAsmPrinter()
{
    return InitializeNativeTargetAsmPrinter();
}

LLVMBool LLVMExtraInitializeNativeDisassembler()
{
    return InitializeNativeTargetDisassembler();
}

// Various missing passes (being upstreamed)

void LLVMExtraAddBarrierNoopPass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createBarrierNoopPass());
}

void LLVMExtraAddDivRemPairsPass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createDivRemPairsPass());
}

void LLVMExtraAddLoopDistributePass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createLoopDistributePass());
}

void LLVMExtraAddLoopFusePass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createLoopFusePass());
}

void LLVMExtraLoopLoadEliminationPass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createLoopLoadEliminationPass());
}

void LLVMExtraAddLoadStoreVectorizerPass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createLoadStoreVectorizerPass());
}

void LLVMExtraAddVectorCombinePass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createVectorCombinePass());
}

#if LLVM_VERSION_MAJOR < 12
void LLVMExtraAddInstructionSimplifyPass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createInstSimplifyLegacyPass());
}
#endif

// Infrastructure for writing LLVM passes in Julia

typedef struct LLVMOpaquePass *LLVMPassRef;
DEFINE_STDCXX_CONVERSION_FUNCTIONS(Pass, LLVMPassRef)

void LLVMExtraAddPass(LLVMPassManagerRef PM, LLVMPassRef P)
{
    unwrap(PM)->add(unwrap(P));
}

typedef LLVMBool (*LLVMPassCallback)(void *Ref, void *Data);

namespace {
StringMap<char *> PassIDs;
char &CreatePassID(const char *Name)
{
    std::string NameStr(Name);
    if (PassIDs.find(NameStr) != PassIDs.end())
        return *PassIDs[NameStr];
    else
        return *(PassIDs[NameStr] = new char);
}

class JuliaModulePass : public ModulePass
{
public:
    JuliaModulePass(const char *Name, LLVMPassCallback Callback, void *Data)
        : ModulePass(CreatePassID(Name)), Callback(Callback), Data(Data)
    {
    }

    bool runOnModule(Module &M) override
    {
        void *Ref = (void *)wrap(&M);
        bool Changed = Callback(Ref, Data);
        return Changed;
    }

private:
    LLVMPassCallback Callback;
    void *Data;
};

class JuliaFunctionPass : public FunctionPass
{
public:
    JuliaFunctionPass(const char *Name, LLVMPassCallback Callback, void *Data)
        : FunctionPass(CreatePassID(Name)), Callback(Callback), Data(Data)
    {
    }

    bool runOnFunction(Function &Fn) override
    {
        void *Ref = (void *)wrap(&Fn);
        bool Changed = Callback(Ref, Data);
        return Changed;
    }

private:
    LLVMPassCallback Callback;
    void *Data;
};

}; // namespace

LLVMPassRef
LLVMExtraCreateModulePass2(const char *Name, LLVMPassCallback Callback, void *Data)
{
    return wrap(new JuliaModulePass(Name, Callback, Data));
}

LLVMPassRef
LLVMExtraCreateFunctionPass2(const char *Name, LLVMPassCallback Callback, void *Data)
{
    return wrap(new JuliaFunctionPass(Name, Callback, Data));
}

// Various missing functions

unsigned int LLVMExtraGetDebugMDVersion()
{
    return DEBUG_METADATA_VERSION;
}

LLVMContextRef LLVMExtraGetValueContext(LLVMValueRef V)
{
    return wrap(&unwrap(V)->getContext());
}

void LLVMExtraAddTargetLibraryInfoByTiple(const char *T, LLVMPassManagerRef PM)
{
    unwrap(PM)->add(new TargetLibraryInfoWrapperPass(Triple(T)));
}

void LLVMExtraAddInternalizePassWithExportList(
    LLVMPassManagerRef PM, const char **ExportList, size_t Length)
{
    auto PreserveFobj = [=](const GlobalValue &GV)
    {
        for (size_t i = 0; i < Length; i++)
        {
            if (strcmp(ExportList[i], GV.getName().data()) == 0)
                return true;
        }
        return false;
    };
    unwrap(PM)->add(createInternalizePass(PreserveFobj));
}

void LLVMExtraAppendToUsed(LLVMModuleRef Mod,
                           LLVMValueRef *Values,
                           size_t Count)
{
    SmallVector<GlobalValue *, 1> GlobalValues;
    for (auto *Value : makeArrayRef(Values, Count))
        GlobalValues.push_back(cast<GlobalValue>(unwrap(Value)));
    appendToUsed(*unwrap(Mod), GlobalValues);
}

void LLVMExtraAppendToCompilerUsed(LLVMModuleRef Mod,
                                   LLVMValueRef *Values,
                                   size_t Count)
{
    SmallVector<GlobalValue *, 1> GlobalValues;
    for (auto *Value : makeArrayRef(Values, Count))
        GlobalValues.push_back(cast<GlobalValue>(unwrap(Value)));
    appendToCompilerUsed(*unwrap(Mod), GlobalValues);
}

void LLVMExtraAddGenericAnalysisPasses(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createTargetTransformInfoWrapperPass(TargetIRAnalysis()));
}
