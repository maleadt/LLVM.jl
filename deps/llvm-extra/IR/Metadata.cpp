#include <llvm-c/Types.h>

#include <llvm/IR/Metadata.h>

namespace llvm {

extern "C" unsigned int LLVMGetDebugMDVersion() {
  return DEBUG_METADATA_VERSION;
}
}
