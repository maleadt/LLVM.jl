# Julia wrapper for source: julia/src/llvm-api.cpp


# initialization functions

function LLVMInitializeAllTargetInfos()
    @apicall(:LLVMExtraInitializeAllTargetInfos,Cvoid,())
end

function LLVMInitializeAllTargets()
    @apicall(:LLVMExtraInitializeAllTargets,Cvoid,())
end

function LLVMInitializeAllTargetMCs()
    @apicall(:LLVMExtraInitializeAllTargetMCs,Cvoid,())
end

function LLVMInitializeAllAsmPrinters()
    @apicall(:LLVMExtraInitializeAllAsmPrinters,Cvoid,())
end

function LLVMInitializeAllAsmParsers()
    @apicall(:LLVMExtraInitializeAllAsmParsers,Cvoid,())
end

function LLVMInitializeAllDisassemblers()
    @apicall(:LLVMExtraInitializeAllDisassemblers,Cvoid,())
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
    @apicall(:LLVMExtraAddPass,Cvoid,
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


# various missing functions

function LLVMAddInternalizePassWithExportList(PM::LLVMPassManagerRef, ExportList, Length)
    @apicall(:LLVMExtraAddInternalizePassWithExportList,Cvoid,(LLVMPassManagerRef,Ptr{Cstring},Csize_t), PM, ExportList, Length)
end

function LLVMAddTargetLibraryInfoByTriple(Triple, PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddTargetLibraryInfoByTiple,Cvoid,(Cstring, LLVMPassManagerRef), Triple, PM)
end

function LLVMAddNVVMReflectPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMExtraAddMVVMReflectPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddNVVMReflectPassWithMapping(PM::LLVMPassManagerRef, Params, Values, Length)
    @apicall(:LLVMExtraAddMVVMReflectPassWithMapping,Cvoid,(LLVMPassManagerRef,Ptr{Cstring},Ptr{Int},Csize_t), PM, Params, Values, Length)
end

function LLVMGetDebugMDVersion()
    @apicall(:LLVMExtraGetDebugMDVersion,Cuint,())
end

function LLVMGetValueContext(V::LLVMValueRef)
    @apicall(:LLVMExtraGetValueContext,LLVMContextRef,(LLVMValueRef,),V)
end
