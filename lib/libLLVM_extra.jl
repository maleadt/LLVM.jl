# Julia wrapper for header: llvm-extra/Target.h

function LLVMInitializeAllTargetInfos()
    @apicall(:LLVMExtraInitializeAllTargetInfos,Void,())
end

function LLVMInitializeAllTargets()
    @apicall(:LLVMExtraInitializeAllTargets,Void,())
end

function LLVMInitializeAllTargetMCs()
    @apicall(:LLVMExtraInitializeAllTargetMCs,Void,())
end

function LLVMInitializeAllAsmPrinters()
    @apicall(:LLVMExtraInitializeAllAsmPrinters,Void,())
end

function LLVMInitializeAllAsmParsers()
    @apicall(:LLVMExtraInitializeAllAsmParsers,Void,())
end

function LLVMInitializeAllDisassemblers()
    @apicall(:LLVMExtraInitializeAllDisassemblers,Void,())
end

function LLVMInitializeNativeTarget()
    @apicall(:LLVMExtraInitializeNativeTarget,LLVMBool,())
end

function LLVMInitializeNativeAsmPrinter()
    @apicall(:LLVMExtraInitializeNativeAsmPrinter,LLVMBool,())
end

function LLVMInitializeNativeAsmParser()
    @apicall(:LLVMExtraInitializeNativeAsmParser,LLVMBool,())
end

function LLVMInitializeNativeDisassembler()
    @apicall(:LLVMExtraInitializeNativeDisassembler,LLVMBool,())
end


# Julia wrapper for header: llvm-extra/Transforms/IPO.h

function LLVMAddInternalizePassWithExportList(PM::LLVMPassManagerRef, ExportList, Length)
    @apicall(:LLVMExtraAddInternalizePassWithExportList,Void,(LLVMPassManagerRef,Ptr{Cstring},Csize_t), PM, ExportList, Length)
end


# Julia wrapper for header: llvm-extra/Target/NVPTX.h

function LLVMAddNVVMReflectPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddMVVMReflectPass,Void,(LLVMPassManagerRef,), PM)
end

function LLVMAddNVVMReflectPassWithMapping(PM::LLVMPassManagerRef, Params, Values, Length)
    @apicall(:LLVMExtraAddMVVMReflectPassWithMapping,Void,(LLVMPassManagerRef,Ptr{Cstring},Ptr{Int},Csize_t), PM, Params, Values, Length)
end


# Julia wrapper for header: llvm-extra/IR/Pass.h

type LLVMOpaquePass
end

const LLVMPassRef = Ptr{LLVMOpaquePass}

function LLVMAddPass(PM::LLVMPassManagerRef, P::LLVMPassRef)
    @apicall(:LLVMExtraAddPass,Void,
        (LLVMPassManagerRef, LLVMPassRef),
        PM, P)
end

function LLVMCreateModulePass(Name, Callback)
    @apicall(:LLVMExtraCreateModulePass,LLVMPassRef,
        (Cstring, Any),
        Name, Callback)
end

function LLVMCreateFunctionPass(Name, Callback)
    @apicall(:LLVMExtraCreateFunctionPass,LLVMPassRef,
        (Cstring, Any),
        Name, Callback)
end

function LLVMCreateBasicBlockPass(Name, Callback)
    @apicall(:LLVMExtraCreateBasicBlockPass,LLVMPassRef,
        (Cstring, Any),
        Name, Callback)
end


# Julia wrapper for header: llvm-extra/IR/Metadata.h

function LLVMGetDebugMDVersion()
    @apicall(:LLVMExtraGetDebugMDVersion,Cuint,())
end


# Julia wrapper for header: llvm-extra/IR/Core.h

function LLVMGetAttributeCountAtIndex_D26392(F::LLVMValueRef,Idx::LLVMAttributeIndex)
    @apicall(:LLVMGetAttributeCountAtIndex_D26392,UInt32,(LLVMValueRef,LLVMAttributeIndex),F,Idx)
end

function LLVMGetCallSiteAttributeCount_D26392(C::LLVMValueRef,Idx::LLVMAttributeIndex)
    @apicall(:LLVMGetCallSiteAttributeCount_D26392,UInt32,(LLVMValueRef,LLVMAttributeIndex),C,Idx)
end
