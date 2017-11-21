# Julia wrapper for source: julia/src/llvm-api.cpp


# initialization functions

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


# infrastructure for writing LLVM passes in Julia

mutable struct LLVMOpaquePass
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


# bugfixes

if libllvm_version < v"4.0"

# D26392
function LLVMGetAttributeCountAtIndex(F::LLVMValueRef,Idx::LLVMAttributeIndex)
    @apicall(:LLVMExtraGetAttributeCountAtIndex,UInt32,(LLVMValueRef,LLVMAttributeIndex),F,Idx)
end

# D26392
function LLVMGetCallSiteAttributeCount(C::LLVMValueRef,Idx::LLVMAttributeIndex)
    @apicall(:LLVMExtraGetCallSiteAttributeCount,UInt32,(LLVMValueRef,LLVMAttributeIndex),C,Idx)
end

end


# various missing functions

function LLVMAddInternalizePassWithExportList(PM::LLVMPassManagerRef, ExportList, Length)
    @apicall(:LLVMExtraAddInternalizePassWithExportList,Void,(LLVMPassManagerRef,Ptr{Cstring},Csize_t), PM, ExportList, Length)
end

function LLVMAddTargetLibraryInfoByTriple(Triple, PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddTargetLibraryInfoByTiple,Void,(Cstring, LLVMPassManagerRef), Triple, PM)
end

function LLVMAddNVVMReflectPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddMVVMReflectPass,Void,(LLVMPassManagerRef,), PM)
end

function LLVMAddNVVMReflectPassWithMapping(PM::LLVMPassManagerRef, Params, Values, Length)
    @apicall(:LLVMExtraAddMVVMReflectPassWithMapping,Void,(LLVMPassManagerRef,Ptr{Cstring},Ptr{Int},Csize_t), PM, Params, Values, Length)
end

function LLVMGetDebugMDVersion()
    @apicall(:LLVMExtraGetDebugMDVersion,Cuint,())
end

function LLVMGetValueContext(V::LLVMValueRef)
    @apicall(:LLVMExtraGetValueContext,LLVMContextRef,(LLVMValueRef,),V)
end
