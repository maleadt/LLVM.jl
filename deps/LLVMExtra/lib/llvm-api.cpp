#include <LLVMExtra.h>

#include <llvm/ADT/Triple.h>
#include <llvm/Analysis/TargetLibraryInfo.h>
#include <llvm/Analysis/TargetTransformInfo.h>
#include <llvm/IR/Attributes.h>
#include <llvm/IR/DebugInfo.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/GlobalValue.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/IR/Module.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Transforms/IPO.h>
#include <llvm/Transforms/Scalar.h>
#include <llvm/Transforms/Scalar/SimpleLoopUnswitch.h>
#include <llvm/Transforms/Vectorize.h>
#if LLVM_VERSION_MAJOR < 12
#include <llvm/Transforms/Scalar/InstSimplifyPass.h>
#endif
#include <llvm/Transforms/Utils/Cloning.h>
#include <llvm/Transforms/Utils/ModuleUtils.h>

using namespace llvm;
using namespace llvm::legacy;

// Initialization functions
//
// The LLVMInitialize* functions and friends are defined `static inline`

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

void LLVMAddSpeculativeExecutionIfHasBranchDivergencePass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createSpeculativeExecutionIfHasBranchDivergencePass());
}

void LLVMAddSimpleLoopUnrollPass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createSimpleLoopUnrollPass());
}

void LLVMAddInductiveRangeCheckEliminationPass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createInductiveRangeCheckEliminationPass());
}

void LLVMAddSimpleLoopUnswitchLegacyPass(LLVMPassManagerRef PM)
{
    unwrap(PM)->add(createSimpleLoopUnswitchLegacyPass());
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

LLVMContextRef LLVMGetBuilderContext(LLVMBuilderRef B)
{
    return wrap(&unwrap(B)->getContext());
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

const char *LLVMExtraDIScopeGetName(LLVMMetadataRef File, unsigned *Len) {
    auto Name = unwrap<DIScope>(File)->getName();
    *Len = Name.size();
    return Name.data();
}

void LLVMExtraDumpMetadata(LLVMMetadataRef MD) {
  unwrap<Metadata>(MD)->print(errs(), /*M=*/nullptr, /*IsForDebug=*/true);
}

char* LLVMExtraPrintMetadataToString(LLVMMetadataRef MD) {
  std::string buf;
  raw_string_ostream os(buf);

  if (unwrap<Metadata>(MD))
    unwrap<Metadata>(MD)->print(os);
  else
    os << "Printing <null> Metadata";

  os.flush();

  return strdup(buf.c_str());
}

#if LLVM_VERSION_MAJOR >= 12
void LLVMAddCFGSimplificationPass2(LLVMPassManagerRef PM,
                                   int BonusInstThreshold,
                                   LLVMBool ForwardSwitchCondToPhi,
                                   LLVMBool ConvertSwitchToLookupTable,
                                   LLVMBool NeedCanonicalLoop,
                                   LLVMBool HoistCommonInsts,
                                   LLVMBool SinkCommonInsts,
                                   LLVMBool SimplifyCondBranch,
                                   LLVMBool FoldTwoEntryPHINode)
{
    auto simplifyCFGOptions = SimplifyCFGOptions().bonusInstThreshold(BonusInstThreshold)
                                                  .forwardSwitchCondToPhi(ForwardSwitchCondToPhi)
                                                  .convertSwitchToLookupTable(ConvertSwitchToLookupTable)
                                                  .needCanonicalLoops(NeedCanonicalLoop)
                                                  .hoistCommonInsts(HoistCommonInsts)
                                                  .sinkCommonInsts(SinkCommonInsts)
                                                  .setSimplifyCondBranch(SimplifyCondBranch)
                                                  .setFoldTwoEntryPHINode(FoldTwoEntryPHINode);
    unwrap(PM)->add(createCFGSimplificationPass(simplifyCFGOptions));
}
#endif

// versions of API without MetadataAsValue

const char *LLVMExtraGetMDString2(LLVMMetadataRef MD, unsigned *Length) {
    const MDString *S = unwrap<MDString>(MD);
    *Length = S->getString().size();
    return S->getString().data();
}

unsigned LLVMExtraGetMDNodeNumOperands2(LLVMMetadataRef MD) {
  return unwrap<MDNode>(MD)->getNumOperands();
}

void LLVMExtraGetMDNodeOperands2(LLVMMetadataRef MD, LLVMMetadataRef *Dest) {
  const auto *N = unwrap<MDNode>(MD);
  const unsigned numOperands = N->getNumOperands();
  for (unsigned i = 0; i < numOperands; i++)
    Dest[i] = wrap(N->getOperand(i));
}

unsigned LLVMExtraGetNamedMetadataNumOperands2(LLVMNamedMDNodeRef NMD) {
  return unwrap<NamedMDNode>(NMD)->getNumOperands();
}

void LLVMExtraGetNamedMetadataOperands2(LLVMNamedMDNodeRef NMD,
                                        LLVMMetadataRef *Dest) {
  NamedMDNode *N = unwrap<NamedMDNode>(NMD);
  for (unsigned i=0;i<N->getNumOperands();i++)
    Dest[i] = wrap(N->getOperand(i));
}

void LLVMExtraAddNamedMetadataOperand2(LLVMNamedMDNodeRef NMD, LLVMMetadataRef Val) {
  unwrap<NamedMDNode>(NMD)->addOperand(unwrap<MDNode>(Val));
}

// Bug fixes (TODO: upstream these)

void LLVMExtraSetInitializer(LLVMValueRef GlobalVar, LLVMValueRef ConstantVal) {
    unwrap<GlobalVariable>(GlobalVar)
        ->setInitializer(ConstantVal ? unwrap<Constant>(ConstantVal) : nullptr);
}

void LLVMExtraSetPersonalityFn(LLVMValueRef Fn, LLVMValueRef PersonalityFn) {
    unwrap<Function>(Fn)->setPersonalityFn(PersonalityFn ? unwrap<Constant>(PersonalityFn)
                                                         : nullptr);
}

#if LLVM_VERSION_MAJOR == 12
LLVMAttributeRef LLVMCreateTypeAttribute(LLVMContextRef C, unsigned KindID,
                                         LLVMTypeRef type_ref) {
  auto &Ctx = *unwrap(C);
  auto AttrKind = (Attribute::AttrKind)KindID;
  return wrap(Attribute::get(Ctx, AttrKind, unwrap(type_ref)));
}

LLVMTypeRef LLVMGetTypeAttributeValue(LLVMAttributeRef A) {
  auto Attr = unwrap(A);
  return wrap(Attr.getValueAsType());
}
LLVMBool LLVMIsTypeAttribute(LLVMAttributeRef A) {
  return unwrap(A).isTypeAttribute();
}
#endif

class ExternalTypeRemapper : public ValueMapTypeRemapper {
public:
  ExternalTypeRemapper(LLVMTypeRef (*fptr)(LLVMTypeRef, void *), void *data)
      : fptr(fptr), data(data) {}

private:
  Type *remapType(Type *SrcTy) override {
    return unwrap(fptr(wrap(SrcTy), data));
  }

  LLVMTypeRef (*fptr)(LLVMTypeRef, void *);
  void *data;
};

class ExternalValueMaterializer : public ValueMaterializer {
public:
  ExternalValueMaterializer(LLVMValueRef (*fptr)(LLVMValueRef, void *),
                            void *data)
      : fptr(fptr), data(data) {}
  virtual ~ExternalValueMaterializer() = default;
  Value *materialize(Value *V) override { return unwrap(fptr(wrap(V), data)); }

private:
  LLVMValueRef (*fptr)(LLVMValueRef, void *);
  void *data;
};

void LLVMCloneFunctionInto(LLVMValueRef NewFunc, LLVMValueRef OldFunc,
                           LLVMValueRef *ValueMap, unsigned ValueMapElements,
                           LLVMCloneFunctionChangeType Changes,
                           const char *NameSuffix,
                           LLVMTypeRef (*TypeMapper)(LLVMTypeRef, void *),
                           void *TypeMapperData,
                           LLVMValueRef (*Materializer)(LLVMValueRef, void *),
                           void *MaterializerData) {
  // NOTE: we ignore returns cloned, and don't return the code info
  SmallVector<ReturnInst *, 8> Returns;

#if LLVM_VERSION_MAJOR < 13
  LLVMCloneFunctionChangeType CFGT = Changes;
#else
  CloneFunctionChangeType CFGT;
  switch (Changes) {
  case LLVMCloneFunctionChangeTypeLocalChangesOnly:
    CFGT = CloneFunctionChangeType::LocalChangesOnly;
    break;
  case LLVMCloneFunctionChangeTypeGlobalChanges:
    CFGT = CloneFunctionChangeType::GlobalChanges;
    break;
  case LLVMCloneFunctionChangeTypeDifferentModule:
    CFGT = CloneFunctionChangeType::DifferentModule;
    break;
  case LLVMCloneFunctionChangeTypeClonedModule:
    CFGT = CloneFunctionChangeType::ClonedModule;
    break;
  }
#endif

  ValueToValueMapTy VMap;
  for (unsigned i = 0; i < ValueMapElements; ++i)
    VMap[unwrap(ValueMap[2 * i])] = unwrap(ValueMap[2 * i + 1]);
  ExternalTypeRemapper TheTypeRemapper(TypeMapper, TypeMapperData);
  ExternalValueMaterializer TheMaterializer(Materializer, MaterializerData);
  CloneFunctionInto(unwrap<Function>(NewFunc), unwrap<Function>(OldFunc), VMap,
                    CFGT, Returns, NameSuffix, nullptr,
                    TypeMapper ? &TheTypeRemapper : nullptr,
                    Materializer ? &TheMaterializer : nullptr);
}

void LLVMFunctionDeleteBody(LLVMValueRef Func) {
    unwrap<Function>(Func)->deleteBody();
}

void LLVMDestroyConstant(LLVMValueRef Const) {
    unwrap<Constant>(Const)->destroyConstant();
}

// operand bundles

DEFINE_STDCXX_CONVERSION_FUNCTIONS(OperandBundleUse, LLVMOperandBundleUseRef)

unsigned LLVMGetNumOperandBundles(LLVMValueRef Instr) {
    return unwrap<CallBase>(Instr)->getNumOperandBundles();
}

LLVMOperandBundleUseRef LLVMGetOperandBundle(LLVMValueRef Val, unsigned Index) {
    CallBase *CB = unwrap<CallBase>(Val);
    return wrap(new OperandBundleUse(CB->getOperandBundleAt(Index)));
}

void LLVMDisposeOperandBundleUse(LLVMOperandBundleUseRef Bundle) {
    delete unwrap<OperandBundleUse>(Bundle);
    return;
}

uint32_t LLVMGetOperandBundleUseTagID(LLVMOperandBundleUseRef Bundle) {
    const OperandBundleUse *S = unwrap<OperandBundleUse>(Bundle);
    return S->getTagID();
}

const char *LLVMGetOperandBundleUseTagName(LLVMOperandBundleUseRef Bundle, unsigned *Length) {
    const OperandBundleUse *S = unwrap<OperandBundleUse>(Bundle);
    *Length = S->getTagName().size();
    return S->getTagName().data();
}

unsigned LLVMGetOperandBundleUseNumInputs(LLVMOperandBundleUseRef Bundle) {
  return unwrap<OperandBundleUse>(Bundle)->Inputs.size();
}

void LLVMGetOperandBundleUseInputs(LLVMOperandBundleUseRef Bundle, LLVMValueRef *Dest) {
  size_t i = 0;
  for (auto &input: unwrap<OperandBundleUse>(Bundle)->Inputs)
      Dest[i++] = wrap(input);
}

DEFINE_STDCXX_CONVERSION_FUNCTIONS(OperandBundleDef, LLVMOperandBundleDefRef)

LLVMOperandBundleDefRef LLVMCreateOperandBundleDef(const char *Tag, LLVMValueRef *Inputs,
                                                   unsigned NumInputs) {
    SmallVector<Value*, 1> InputArray;
    for (auto *Input : makeArrayRef(Inputs, NumInputs))
        InputArray.push_back(unwrap(Input));
  return wrap(new OperandBundleDef(std::string(Tag), InputArray));
}

LLVMOperandBundleDefRef LLVMOperandBundleDefFromUse(LLVMOperandBundleUseRef Bundle) {
    return wrap(new OperandBundleDef(*unwrap<OperandBundleUse>(Bundle)));
}

void LLVMDisposeOperandBundleDef(LLVMOperandBundleDefRef Bundle) {
    delete unwrap<OperandBundleDef>(Bundle);
    return;
}

const char *LLVMGetOperandBundleDefTag(LLVMOperandBundleDefRef Bundle, unsigned *Length) {
    const OperandBundleDef *S = unwrap<OperandBundleDef>(Bundle);
    *Length = S->getTag().size();
    return S->getTag().data();
}

unsigned LLVMGetOperandBundleDefNumInputs(LLVMOperandBundleDefRef Bundle) {
  return unwrap<OperandBundleDef>(Bundle)->input_size();
}

void LLVMGetOperandBundleDefInputs(LLVMOperandBundleDefRef Bundle, LLVMValueRef *Dest) {
  size_t i = 0;
  for (auto input: unwrap<OperandBundleDef>(Bundle)->inputs())
      Dest[i++] = wrap(input);
}

LLVMValueRef LLVMBuildCallWithOpBundle(LLVMBuilderRef B, LLVMValueRef Fn,
                                       LLVMValueRef *Args, unsigned NumArgs,
                                       LLVMOperandBundleDefRef *Bundles, unsigned NumBundles,
                                       const char *Name) {
    SmallVector<OperandBundleDef, 1> BundleArray;
    for (auto *Bundle : makeArrayRef(Bundles, NumBundles))
        BundleArray.push_back(*unwrap<OperandBundleDef>(Bundle));

    llvm::IRBuilder<> *Builder = unwrap(B);
    llvm::ArrayRef<llvm::Value*> args = makeArrayRef(unwrap(Args), NumArgs);

    Value *V = unwrap(Fn);
    FunctionType *FnT = cast<FunctionType>(V->getType()->getPointerElementType());
    llvm::CallInst *CI = Builder->CreateCall(FnT, unwrap(Fn), args ,BundleArray, Name);
    return wrap(CI);
}

LLVMValueRef LLVMBuildCallWithOpBundle2(LLVMBuilderRef B, LLVMTypeRef Ty, LLVMValueRef Fn,
                                        LLVMValueRef *Args, unsigned NumArgs,
                                        LLVMOperandBundleDefRef *Bundles, unsigned NumBundles,
                                        const char *Name) {
    SmallVector<OperandBundleDef, 1> BundleArray;
    for (auto *Bundle : makeArrayRef(Bundles, NumBundles))
        BundleArray.push_back(*unwrap<OperandBundleDef>(Bundle));

    llvm::IRBuilder<> *Builder = unwrap(B);
    llvm::ArrayRef<llvm::Value*> args = makeArrayRef(unwrap(Args), NumArgs);

    FunctionType *FTy = unwrap<FunctionType>(Ty);
    llvm::CallInst *CI = Builder->CreateCall(FTy, unwrap(Fn), args ,BundleArray, Name);
    return wrap(CI);
}

LLVMValueRef LLVMMetadataAsValue2(LLVMContextRef C, LLVMMetadataRef Metadata) {
  auto *MD = unwrap(Metadata);
  if (auto *VAM = dyn_cast<ValueAsMetadata>(MD))
    return wrap(VAM->getValue());
  else
    return wrap(MetadataAsValue::get(*unwrap(C), MD));
}

void LLVMReplaceAllMetadataUsesWith(LLVMValueRef Old, LLVMValueRef New) {
  ValueAsMetadata::handleRAUW(unwrap<Value>(Old), unwrap<Value>(New));
}

void LLVMReplaceMDNodeOperandWith(LLVMMetadataRef MD, unsigned I, LLVMMetadataRef New) {
    unwrap<MDNode>(MD)->replaceOperandWith(I, unwrap(New));
}

#if LLVM_VERSION_MAJOR >= 13
LLVMBool LLVMContextSupportsTypedPointers(LLVMContextRef C) {
  return unwrap(C)->supportsTypedPointers();
}
#endif

LLVMValueRef LLVMConstDataArray(LLVMTypeRef ElementTy, const void *Data, unsigned NumElements) {
    StringRef S((const char *)Data, NumElements * unwrap(ElementTy)->getPrimitiveSizeInBits() / 8);
    return wrap(ConstantDataArray::getRaw(S, NumElements, unwrap(ElementTy)));
}

LLVMTypeRef LLVMGetFunctionType(LLVMValueRef Fn) {
    auto Ftype = unwrap<Function>(Fn)->getFunctionType();
    return wrap(Ftype);
}

LLVMTypeRef LLVMGetGlobalValueType(LLVMValueRef GV) {
    auto Ftype = unwrap<GlobalValue>(GV)->getValueType();
    return wrap(Ftype);
}

#if LLVM_VERSION_MAJOR >= 13 && LLVM_VERSION_MAJOR < 15
LLVMBool LLVMPointerTypeIsOpaque(LLVMTypeRef Ty) {
  return unwrap(Ty)->isOpaquePointerTy();
}
LLVMTypeRef LLVMPointerTypeInContext(LLVMContextRef C, unsigned AddressSpace) {
  return wrap(PointerType::get(*unwrap(C), AddressSpace));
}
#endif
