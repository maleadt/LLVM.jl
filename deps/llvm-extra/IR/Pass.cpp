#include <llvm-c/Types.h>

#include <llvm/IR/LegacyPassManager.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Function.h>

using namespace llvm::legacy;

namespace llvm {

typedef struct LLVMOpaquePass *LLVMPassRef;
DEFINE_STDCXX_CONVERSION_FUNCTIONS(Pass, LLVMPassRef)

extern "C" void
LLVMExtraAddPass(LLVMPassManagerRef PM, LLVMPassRef P) {
  unwrap(PM)->add(unwrap(P));
}

StringMap<char *> PassIDs;
char& CreatePassID(const char* Name) {
  std::string NameStr(Name);
  if (PassIDs.find(NameStr) != PassIDs.end())
    return *PassIDs[NameStr];
  else
    return *(PassIDs[NameStr] = new char);
}


//
// Module pass
//

typedef LLVMBool (*ModulePassCallback)(LLVMModuleRef M, void*);

class JuliaModulePass : public ModulePass {
public:
  JuliaModulePass(const char *Name, ModulePassCallback Callback, void* Data)
      : ModulePass(CreatePassID(Name)), Callback(Callback), Data(Data) {}

  bool runOnModule(Module &M) { return Callback(wrap(&M), Data); }

private:
  ModulePassCallback Callback;
  void* Data;
};

extern "C" LLVMPassRef
LLVMExtraCreateModulePass(const char *Name, ModulePassCallback Callback, void* Data) {
  return wrap(new JuliaModulePass(Name, Callback, Data));
}


//
// Function pass
//

typedef LLVMBool (*FunctionPassCallback)(LLVMValueRef Fn, void*);

class JuliaFunctionPass : public FunctionPass {
public:
  JuliaFunctionPass(const char *Name, FunctionPassCallback Callback, void* Data)
      : FunctionPass(CreatePassID(Name)), Callback(Callback), Data(Data) {}

  bool runOnFunction(Function &Fn) { return Callback(wrap(&Fn), Data); }

private:
  FunctionPassCallback Callback;
  void* Data;
};

extern "C" LLVMPassRef
LLVMExtraCreateFunctionPass(const char *Name, FunctionPassCallback Callback, void* Data) {
  return wrap(new JuliaFunctionPass(Name, Callback, Data));
}


//
// BasicBlock pass
//

typedef LLVMBool (*BasicBlockPassCallback)(LLVMBasicBlockRef BB, void*);

class JuliaBasicBlockPass : public BasicBlockPass {
public:
  JuliaBasicBlockPass(const char *Name, BasicBlockPassCallback Callback, void* Data)
      : BasicBlockPass(CreatePassID(Name)), Callback(Callback), Data(Data) {}

  bool runOnBasicBlock(BasicBlock &BB) { return Callback(wrap(&BB), Data); }

private:
  BasicBlockPassCallback Callback;
  void* Data;
};

extern "C" LLVMPassRef
LLVMExtraCreateBasicBlockPass(const char *Name, BasicBlockPassCallback Callback, void* Data) {
  return wrap(new JuliaBasicBlockPass(Name, Callback, Data));
}

}
