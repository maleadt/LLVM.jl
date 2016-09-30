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


# Julia wrapper for header: llvm-extra/Transforms/IPO.h

function LLVMExtraAddInternalizePassWithExportList(PM::LLVMPassManagerRef, ExportList, Length)
    ccall((:LLVMExtraAddInternalizePassWithExportList,libllvm),Void,(LLVMPassManagerRef,Ptr{Cstring},Csize_t), PM, ExportList, Length)
end


# Julia wrapper for header: llvm-extra/Target/NVPTX.h

function LLVMExtraAddNVVMReflectPass(PM::LLVMPassManagerRef)
    ccall((:LLVMExtraAddMVVMReflectPass,libllvm),Void,(LLVMPassManagerRef,), PM)
end

function LLVMExtraAddNVVMReflectPassWithMapping(PM::LLVMPassManagerRef, Params, Values, Length)
    ccall((:LLVMExtraAddMVVMReflectPassWithMapping,libllvm),Void,(LLVMPassManagerRef,Ptr{Cstring},Ptr{Int},Csize_t), PM, Params, Values, Length)
end


# Julia wrapper for header: llvm-extra/IR/Pass.h

type LLVMOpaquePass
end

typealias LLVMPassRef Ptr{LLVMOpaquePass}

function LLVMExtraAddPass(PM::LLVMPassManagerRef, P::LLVMPassRef)
    ccall((:LLVMExtraAddPass,libllvm),Void,
        (LLVMPassManagerRef, LLVMPassRef),
        PM, P)
end

function LLVMExtraCreateModulePass(Name, Callback, Data)
    ccall((:LLVMExtraCreateModulePass,libllvm),LLVMPassRef,
        (Cstring, Ptr{Void}, Ptr{Void}),
        Name, Callback, Data)
end

function LLVMExtraCreateFunctionPass(Name, Callback, Data)
    ccall((:LLVMExtraCreateFunctionPass,libllvm),LLVMPassRef,
        (Cstring, Ptr{Void}, Ptr{Void}),
        Name, Callback, Data)
end

function LLVMExtraCreateBasicBlockPass(Name, Callback, Data)
    ccall((:LLVMExtraCreateBasicBlockPass,libllvm),LLVMPassRef,
        (Cstring, Ptr{Void}, Ptr{Void}),
        Name, Callback, Data)
end
