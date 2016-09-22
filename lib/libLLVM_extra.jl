# Julia wrapper for header: llvm-extra/Target.h

function LLVMInitializeAllTargetInfos()
    ccall((:LLVMExtraInitializeAllTargetInfos,libllvm),Void,())
end

function LLVMInitializeAllTargets()
    ccall((:LLVMExtraInitializeAllTargets,libllvm),Void,())
end

function LLVMInitializeAllTargetMCs()
    ccall((:LLVMExtraInitializeAllTargetMCs,libllvm),Void,())
end

function LLVMInitializeAllAsmPrinters()
    ccall((:LLVMExtraInitializeAllAsmPrinters,libllvm),Void,())
end

function LLVMInitializeAllAsmParsers()
    ccall((:LLVMExtraInitializeAllAsmParsers,libllvm),Void,())
end

function LLVMInitializeAllDisassemblers()
    ccall((:LLVMExtraInitializeAllDisassemblers,libllvm),Void,())
end

function LLVMInitializeNativeTarget()
    ccall((:LLVMExtraInitializeNativeTarget,libllvm),LLVMBool,())
end

function LLVMInitializeNativeAsmPrinter()
    ccall((:LLVMExtraInitializeNativeAsmPrinter,libllvm),LLVMBool,())
end

function LLVMInitializeNativeAsmParser()
    ccall((:LLVMExtraInitializeNativeAsmParser,libllvm),LLVMBool,())
end

function LLVMInitializeNativeDisassembler()
    ccall((:LLVMExtraInitializeNativeDisassembler,libllvm),LLVMBool,())
end
