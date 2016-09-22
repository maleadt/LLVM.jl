#ifdef TARGET_NVPTX

#include <llvm-c/Types.h>

#include <llvm/Pass.h>
#include <llvm/IR/LegacyPassManager.h>

namespace llvm {

extern ModulePass *createNVVMReflectPass();
extern ModulePass *createNVVMReflectPass(const StringMap<int> &Mapping);

#ifdef __cplusplus
extern "C" {
#endif

void LLVMExtraAddMVVMReflectPass(LLVMPassManagerRef PM) {
    createNVVMReflectPass();
}

void LLVMExtraAddMVVMReflectPassWithMapping(LLVMPassManagerRef PM,
                                            const char** Params, int* Values, size_t Length) {
    StringMap<int> Mapping;
    for (size_t i = 0; i < Length; i++)
        Mapping[Params[i]] = Values[i];
    createNVVMReflectPass(Mapping);
}

#ifdef __cplusplus
}
#endif /* defined(__cplusplus) */

}

#endif /* defined(TARGET_NVPTX) */
