#include <llvm-c/Types.h>

#include <llvm/Support/TargetSelect.h>

namespace llvm {

// The LLVMInitializeAll* functions and friends are defined `static inline`, so
// we can't bind directly to them (the function body is generated via macro), so
// here are some wrappers.

extern "C" void LLVMExtraInitializeAllTargetInfos() {
  InitializeAllTargetInfos();
}

extern "C" void LLVMExtraInitializeAllTargets() { InitializeAllTargets(); }

extern "C" void LLVMExtraInitializeAllTargetMCs() { InitializeAllTargetMCs(); }

extern "C" void LLVMExtraInitializeAllAsmPrinters() {
  InitializeAllAsmPrinters();
}

extern "C" void LLVMExtraInitializeAllAsmParsers() {
  InitializeAllAsmParsers();
}

extern "C" void LLVMExtraInitializeAllDisassemblers() {
  InitializeAllDisassemblers();
}

// These functions return true on failure.

#ifndef LLVM_NATIVE_TARGET
#error LLVM_NATIVE_TARGET not defined
#endif

extern "C" LLVMBool LLVMExtraInitializeNativeTarget() {
  return InitializeNativeTarget();
}

extern "C" LLVMBool LLVMExtraInitializeNativeAsmParser() {
  return InitializeNativeTargetAsmParser();
}

extern "C" LLVMBool LLVMExtraInitializeNativeAsmPrinter() {
  return InitializeNativeTargetAsmPrinter();
}

extern "C" LLVMBool LLVMExtraInitializeNativeDisassembler() {
  return InitializeNativeTargetDisassembler();
}
}
