#include <llvm-c/Types.h>

#include <llvm/IR/Value.h>
#include <llvm/IR/Module.h>

namespace llvm {

extern "C" LLVMContextRef LLVMGetValueContext(LLVMValueRef V) {
  return wrap(&unwrap(V)->getContext());
}

}