# Julia wrapper for header: llvm-extra/Target.c

function LLVMInitializeAllTargetInfos()
    ccall((:LLVMExtraInitializeAllTargetInfos,libllvm_extra),Void,())
end

function LLVMInitializeAllTargets()
    ccall((:LLVMExtraInitializeAllTargets,libllvm_extra),Void,())
end

function LLVMInitializeAllTargetMCs()
    ccall((:LLVMExtraInitializeAllTargetMCs,libllvm_extra),Void,())
end

function LLVMInitializeAllAsmPrinters()
    ccall((:LLVMExtraInitializeAllAsmPrinters,libllvm_extra),Void,())
end

function LLVMInitializeAllAsmParsers()
    ccall((:LLVMExtraInitializeAllAsmParsers,libllvm_extra),Void,())
end

function LLVMInitializeAllDisassemblers()
    ccall((:LLVMExtraInitializeAllDisassemblers,libllvm_extra),Void,())
end

function LLVMInitializeNativeTarget()
    ccall((:LLVMExtraInitializeNativeTarget,libllvm_extra),LLVMBool,())
end

function LLVMInitializeNativeAsmPrinter()
    ccall((:LLVMExtraInitializeNativeAsmPrinter,libllvm_extra),LLVMBool,())
end

function LLVMInitializeNativeAsmParser()
    ccall((:LLVMExtraInitializeNativeAsmParser,libllvm_extra),LLVMBool,())
end

function LLVMInitializeNativeDisassembler()
    ccall((:LLVMExtraInitializeNativeDisassembler,libllvm_extra),LLVMBool,())
end
