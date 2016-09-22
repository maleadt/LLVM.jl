#include <llvm-c/Types.h>

#include <llvm/Support/TargetSelect.h>

using namespace llvm;

#ifdef __cplusplus
extern "C" {
#endif

/* The LLVMInitializeAll* functions and friends are defined `static inline`, so
 * we can't bind directly to them (the function body is generated via macro),
 * so here are some wrappers.
 */

void LLVMExtraInitializeAllTargetInfos(void) {
    InitializeAllTargetInfos();
}

void LLVMExtraInitializeAllTargets(void) {
    InitializeAllTargets();
}

void LLVMExtraInitializeAllTargetMCs(void) {
    InitializeAllTargetMCs();
}

void LLVMExtraInitializeAllAsmPrinters(void) {
    InitializeAllAsmPrinters();
}

void LLVMExtraInitializeAllAsmParsers(void) {
    InitializeAllAsmParsers();
}

void LLVMExtraInitializeAllDisassemblers(void) {
    InitializeAllDisassemblers();
}


/* These functions return true on failure. */

#ifndef LLVM_NATIVE_TARGET
#error LLVM_NATIVE_TARGET not defined
#endif

LLVMBool LLVMExtraInitializeNativeTarget(void) {
    return InitializeNativeTarget();
}

LLVMBool LLVMExtraInitializeNativeAsmParser(void) {
    return InitializeNativeTargetAsmParser();
}

LLVMBool LLVMExtraInitializeNativeAsmPrinter(void) {
    return InitializeNativeTargetAsmPrinter();
}

LLVMBool LLVMExtraInitializeNativeDisassembler(void) {
    return InitializeNativeTargetDisassembler();
}

#ifdef __cplusplus
}
#endif /* defined(__cplusplus) */
