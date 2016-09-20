#include <llvm-c/Target.h>

/* The LLVMInitializeAll* functions and friends are defined `static inline`, so
 * we can't bind directly to them (the function body is generated via macro),
 * so here are some wrappers.
 */

void LLVMExtraInitializeAllTargetInfos(void) {
    LLVMInitializeAllTargetInfos();
}

void LLVMExtraInitializeAllTargets(void) {
    LLVMInitializeAllTargets();
}

void LLVMExtraInitializeAllTargetMCs(void) {
    LLVMInitializeAllTargetMCs();
}

void LLVMExtraInitializeAllAsmPrinters(void) {
    LLVMInitializeAllAsmPrinters();
}

void LLVMExtraInitializeAllAsmParsers(void) {
    LLVMInitializeAllAsmParsers();
}

void LLVMExtraInitializeAllDisassemblers(void) {
    LLVMInitializeAllDisassemblers();
}


/* These functions return true on failure. */

#ifndef LLVM_NATIVE_TARGET
#error LLVM_NATIVE_TARGET not defined
#endif

LLVMBool LLVMExtraInitializeNativeTarget(void) {
    return LLVMInitializeNativeTarget();
}

LLVMBool LLVMExtraInitializeNativeAsmParser(void) {
    return LLVMInitializeNativeAsmParser();
}

LLVMBool LLVMExtraInitializeNativeAsmPrinter(void) {
    return LLVMInitializeNativeAsmPrinter();
}

LLVMBool LLVMExtraInitializeNativeDisassembler(void) {
    return LLVMInitializeNativeDisassembler();
}
