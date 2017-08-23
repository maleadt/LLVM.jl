#include <llvm-c/Types.h>

#include <llvm/ADT/Triple.h>
#include <llvm/Analysis/TargetLibraryInfo.h>
#include <llvm/IR/LegacyPassManager.h>

namespace llvm {

extern "C" void LLVMExtraAddTargetLibraryInfoByTiple(const char *T,
                                                     LLVMPassManagerRef PM) {
  unwrap(PM)->add(new TargetLibraryInfoWrapperPass(Triple(T)));
}
}
