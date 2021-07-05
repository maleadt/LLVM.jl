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

void LLVMInitializeAllTargetInfos()
{
    InitializeAllTargetInfos();
}

void LLVMInitializeAllTargets()
{
    InitializeAllTargets();
}

void LLVMInitializeAllTargetMCs()
{
    InitializeAllTargetMCs();
}

void LLVMInitializeAllAsmPrinters()
{
    InitializeAllAsmPrinters();
}

void LLVMInitializeAllAsmParsers()
{
    InitializeAllAsmParsers();
}

void LLVMInitializeAllDisassemblers()
{
    InitializeAllDisassemblers();
}

LLVMBool LLVMInitializeNativeTarget()
{
    return InitializeNativeTarget();
}

LLVMBool LLVMInitializeNativeAsmParser()
{
    return InitializeNativeTargetAsmParser();
}

LLVMBool LLVMInitializeNativeAsmPrinter()
{
    return InitializeNativeTargetAsmPrinter();
}

LLVMBool LLVMInitializeNativeDisassembler()
{
    return InitializeNativeTargetDisassembler();
}

// Various missing passes (being upstreamed)

void LLVMAddBarrierNoopPass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createBarrierNoopPass());
}

void LLVMAddDivRemPairsPass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createDivRemPairsPass());
}

void LLVMAddLoopDistributePass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createLoopDistributePass());
}

void LLVMAddLoopFusePass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createLoopFusePass());
}

void LLVMAddLoopLoadEliminationPass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createLoopLoadEliminationPass());
}

void LLVMAddLoadStoreVectorizerPass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createLoadStoreVectorizerPass());
}

void LLVMAddVectorCombinePass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createVectorCombinePass());
}

#if LLVM_VERSION_MAJOR < 12
void LLVMAddInstructionSimplifyPass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createInstSimplifyLegacyPass());
}
#endif

// Infrastructure for writing LLVM passes in Julia

typedef struct LLVMOpaquePass *LLVMPassRef;
DEFINE_STDCXX_CONVERSION_FUNCTIONS(Pass, LLVMPassRef)

void LLVMAddPass(LLVMPassManagerRef PM, LLVMPassRef P)
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
LLVMCreateModulePass2(const char *Name, LLVMPassCallback Callback, void *Data)
{
    return wrap(new JuliaModulePass(Name, Callback, Data));
}

LLVMPassRef
LLVMCreateFunctionPass2(const char *Name, LLVMPassCallback Callback, void *Data)
{
    return wrap(new JuliaFunctionPass(Name, Callback, Data));
}

// Various missing functions

unsigned int LLVMGetDebugMDVersion()
{
    return DEBUG_METADATA_VERSION;
}

LLVMContextRef LLVMGetValueContext(LLVMValueRef V)
{
    return wrap(&unwrap(V)->getContext());
}

void LLVMAddTargetLibraryInfoByTriple(const char *T, LLVMPassManagerRef PM)
{
    unwrap(PM)->add(new TargetLibraryInfoWrapperPass(Triple(T)));
}

void LLVMAddInternalizePassWithExportList(
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

template <typename DIT> DIT *unwrapDI(LLVMMetadataRef Ref) {
  return (DIT *)(Ref ? unwrap<MDNode>(Ref) : nullptr);
}

const char *LLVMExtraDIScopeGetName(LLVMMetadataRef File, unsigned *Len) {
  auto Name = unwrapDI<DIScope>(File)->getName();
  *Len = Name.size();
  return Name.data();
}

// Bug fixes (TODO: upstream these)

void LLVMExtraSetInitializer(LLVMValueRef GlobalVar, LLVMValueRef ConstantVal) {
  unwrap<GlobalVariable>(GlobalVar)
    ->setInitializer(ConstantVal ? unwrap<Constant>(ConstantVal) : nullptr);
}

void LLVMExtraSetPersonalityFn(LLVMValueRef Fn, LLVMValueRef PersonalityFn) {
  unwrap<Function>(Fn)->setPersonalityFn(PersonalityFn ? unwrap<Constant>(PersonalityFn) : nullptr);
}
