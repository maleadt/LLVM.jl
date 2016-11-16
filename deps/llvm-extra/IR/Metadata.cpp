#include <llvm-c/Types.h>

#include <llvm/IR/Metadata.h>

namespace llvm {

extern "C" unsigned int LLVMExtraGetDebugMDVersion() {
  return DEBUG_METADATA_VERSION;
}
}
