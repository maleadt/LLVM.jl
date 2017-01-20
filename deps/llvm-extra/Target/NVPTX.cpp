#ifdef TARGET_NVPTX

#include <llvm-c/Types.h>

#include <llvm/IR/LegacyPassManager.h>
#include <llvm/Pass.h>

namespace llvm {

extern ModulePass *createNVVMReflectPass();

extern "C" void LLVMExtraAddMVVMReflectPass(LLVMPassManagerRef PM) {
  createNVVMReflectPass();
}

}

#endif /* defined(TARGET_NVPTX) */
