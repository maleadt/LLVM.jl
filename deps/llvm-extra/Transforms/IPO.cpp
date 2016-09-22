#include <llvm-c/Types.h>

#include <llvm/IR/GlobalValue.h>
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/Transforms/IPO.h>

namespace llvm {

extern "C"  void LLVMExtraAddInternalizePassWithExportList(LLVMPassManagerRef PM,
                                                           const char** ExportList,
                                                           size_t Length) {
    auto PreserveFobj = [=](const GlobalValue &GV) {
        for (size_t i = 0; i < Length; i++) {
            if (strcmp(ExportList[i], GV.getName().data()) == 0)
                return true;
        }
        return false;
    };
    unwrap(PM)->add(createInternalizePass(PreserveFobj));
}

}
