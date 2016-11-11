#include <llvm-c/Types.h>

#include <llvm/IR/LegacyPassManager.h>
#include <llvm/Pass.h>

namespace llvm {

extern ModulePass *createNVVMReflectPass();
extern ModulePass *createNVVMReflectPass(const StringMap<int> &Mapping);

extern "C" void LLVMExtraAddMVVMReflectPass(LLVMPassManagerRef PM) {
  createNVVMReflectPass();
}

extern "C" void LLVMExtraAddMVVMReflectPassWithMapping(LLVMPassManagerRef PM,
                                                       const char **Params,
                                                       int *Values,
                                                       size_t Length) {
  StringMap<int> Mapping;
  for (size_t i = 0; i < Length; i++)
    Mapping[Params[i]] = Values[i];
  createNVVMReflectPass(Mapping);
}
}
