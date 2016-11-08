#include <llvm-c/Core.h>
#include <llvm-c/Types.h>

#include <llvm/IR/Attributes.h>
#include <llvm/IR/CallSite.h>
#include <llvm/IR/Function.h>

namespace llvm {

extern "C" unsigned
LLVMGetAttributeCountAtIndex_D26392(LLVMValueRef F, LLVMAttributeIndex Idx) {
  auto Fn = unwrap<Function>(F);
  if (Fn->getAttributes().isEmpty())
    return 0;
  else
    return LLVMGetAttributeCountAtIndex(F, Idx);
}

extern "C" unsigned
LLVMGetCallSiteAttributeCount_D26392(LLVMValueRef C, LLVMAttributeIndex Idx) {
  CallSite CS(unwrap<Instruction>(C));
  if (CS.getAttributes().isEmpty())
    return 0;
  else
    return LLVMGetCallSiteAttributeCount(C, Idx);
}

}
