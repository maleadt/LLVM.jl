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

function LLVMExtraCreateModulePass(Name, Callback)
    ccall((:LLVMExtraCreateModulePass,libllvm),LLVMPassRef,
        (Cstring, Any),
        Name, Callback)
end

function LLVMExtraCreateFunctionPass(Name, Callback)
    ccall((:LLVMExtraCreateFunctionPass,libllvm),LLVMPassRef,
        (Cstring, Any),
        Name, Callback)
end

function LLVMExtraCreateBasicBlockPass(Name, Callback)
    ccall((:LLVMExtraCreateBasicBlockPass,libllvm),LLVMPassRef,
        (Cstring, Any),
        Name, Callback)
end


# Julia wrapper for header: llvm-extra/IR/Metadata.h

function LLVMGetDebugMDVersion()
    ccall((:LLVMGetDebugMDVersion,libllvm),Cuint,())
end


# Julia wrapper for header: llvm-extra/IR/Core.h

function LLVMGetAttributeCountAtIndex_D26392(F::LLVMValueRef,Idx::LLVMAttributeIndex)
    ccall((:LLVMGetAttributeCountAtIndex_D26392,libllvm),UInt32,(LLVMValueRef,LLVMAttributeIndex),F,Idx)
end

function LLVMGetCallSiteAttributeCount_D26392(C::LLVMValueRef,Idx::LLVMAttributeIndex)
    ccall((:LLVMGetCallSiteAttributeCount_D26392,libllvm),UInt32,(LLVMValueRef,LLVMAttributeIndex),C,Idx)
end
