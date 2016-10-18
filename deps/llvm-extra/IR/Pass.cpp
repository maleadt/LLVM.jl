#include <llvm-c/Types.h>

#include <llvm/IR/Function.h>
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/IR/Module.h>

#include <julia.h>

using namespace llvm::legacy;

namespace llvm {

typedef struct LLVMOpaquePass *LLVMPassRef;
DEFINE_STDCXX_CONVERSION_FUNCTIONS(Pass, LLVMPassRef)

extern "C" void LLVMExtraAddPass(LLVMPassManagerRef PM, LLVMPassRef P) {
  unwrap(PM)->add(unwrap(P));
}

StringMap<char *> PassIDs;
char &CreatePassID(const char *Name) {
  std::string NameStr(Name);
  if (PassIDs.find(NameStr) != PassIDs.end())
    return *PassIDs[NameStr];
  else
    return *(PassIDs[NameStr] = new char);
}

//
// Module pass
//

class JuliaModulePass : public ModulePass {
public:
  JuliaModulePass(const char *Name, jl_value_t *Callback)
      : ModulePass(CreatePassID(Name)), Callback(Callback) {}

  bool runOnModule(Module &M) {
    jl_value_t **argv;
    JL_GC_PUSHARGS(argv, 2);
    argv[0] = Callback;
    argv[1] = jl_box_voidpointer(wrap(&M));

    jl_value_t *ret = jl_apply(argv, 2);
    bool changed = jl_unbox_bool(ret);

    JL_GC_POP();
    return changed;
  }

private:
  jl_value_t *Callback;
};

extern "C" LLVMPassRef LLVMExtraCreateModulePass(const char *Name,
                                                 jl_value_t *Callback) {
  return wrap(new JuliaModulePass(Name, Callback));
}

//
// Function pass
//

class JuliaFunctionPass : public FunctionPass {
public:
  JuliaFunctionPass(const char *Name, jl_value_t *Callback)
      : FunctionPass(CreatePassID(Name)), Callback(Callback) {}

  bool runOnFunction(Function &Fn) {
    jl_value_t **argv;
    JL_GC_PUSHARGS(argv, 2);
    argv[0] = Callback;
    argv[1] = jl_box_voidpointer(wrap(&Fn));

    jl_value_t *ret = jl_apply(argv, 2);
    bool changed = jl_unbox_bool(ret);

    JL_GC_POP();
    return changed;
  }

private:
  jl_value_t *Callback;
};

extern "C" LLVMPassRef LLVMExtraCreateFunctionPass(const char *Name,
                                                   jl_value_t *Callback) {
  return wrap(new JuliaFunctionPass(Name, Callback));
}

//
// BasicBlock pass
//

class JuliaBasicBlockPass : public BasicBlockPass {
public:
  JuliaBasicBlockPass(const char *Name, jl_value_t *Callback)
      : BasicBlockPass(CreatePassID(Name)), Callback(Callback) {}

  bool runOnBasicBlock(BasicBlock &BB) {
    jl_value_t **argv;
    JL_GC_PUSHARGS(argv, 2);
    argv[0] = Callback;
    argv[1] = jl_box_voidpointer(wrap(&BB));

    jl_value_t *ret = jl_apply(argv, 2);
    bool changed = jl_unbox_bool(ret);

    JL_GC_POP();
    return changed;
  }

private:
  jl_value_t *Callback;
};

extern "C" LLVMPassRef LLVMExtraCreateBasicBlockPass(const char *Name,
                                                     jl_value_t *Callback) {
  return wrap(new JuliaBasicBlockPass(Name, Callback));
}
}
