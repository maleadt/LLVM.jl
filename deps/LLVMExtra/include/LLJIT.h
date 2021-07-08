#ifndef LLVMEXTRA_LLJIT_H
#define LLVMEXTRA_LLJIT_H

#include "Orc.h"

#if LLVM_VERSION_MAJOR == 12
#include <llvm-c/LLJIT.h>

LLVM_C_EXTERN_C_BEGIN

// Upstreamed in LLVM13

LLVMOrcIRTransformLayerRef LLVMOrcLLJITGetIRTransformLayer(LLVMOrcLLJITRef J);

LLVMErrorRef LLVMOrcLLJITApplyDataLayout(LLVMOrcLLJITRef J, LLVMModuleRef Mod);

LLVM_C_EXTERN_C_END
#endif
#endif // LLVMEXTRA_LLJIT_H
