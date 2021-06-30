# Julia wrapper for source: LLVMExtra_jll

# initialization functions

function LLVMInitializeAllTargetInfos()
    ccall(:LLVMExtraInitializeAllTargetInfos,Cvoid,())
end

function LLVMInitializeAllTargets()
    ccall(:LLVMExtraInitializeAllTargets,Cvoid,())
end

function LLVMInitializeAllTargetMCs()
    ccall(:LLVMExtraInitializeAllTargetMCs,Cvoid,())
end

function LLVMInitializeAllAsmPrinters()
    ccall(:LLVMExtraInitializeAllAsmPrinters,Cvoid,())
end

function LLVMInitializeAllAsmParsers()
    ccall(:LLVMExtraInitializeAllAsmParsers,Cvoid,())
end

function LLVMInitializeAllDisassemblers()
    ccall(:LLVMExtraInitializeAllDisassemblers,Cvoid,())
end

function LLVMInitializeNativeTarget()
    ccall(:LLVMExtraInitializeNativeTarget,LLVMBool,())
end

function LLVMInitializeNativeAsmPrinter()
    ccall(:LLVMExtraInitializeNativeAsmPrinter,LLVMBool,())
end

function LLVMInitializeNativeAsmParser()
    ccall(:LLVMExtraInitializeNativeAsmParser,LLVMBool,())
end

function LLVMInitializeNativeDisassembler()
    ccall(:LLVMExtraInitializeNativeDisassembler,LLVMBool,())
end

# infrastructure for writing LLVM passes in Julia

mutable struct LLVMOpaquePass
end

const LLVMPassRef = Ptr{LLVMOpaquePass}

function LLVMAddPass(PM, P)
    ccall(:LLVMExtraAddPass,Cvoid,
        (LLVMPassManagerRef, LLVMPassRef),
        PM, P)
end

function LLVMCreateModulePass(Name, Callback)
    ccall(:LLVMExtraCreateModulePass,LLVMPassRef,
        (Cstring, Any),
        Name, Callback)
end

function LLVMCreateFunctionPass(Name, Callback)
    ccall(:LLVMExtraCreateFunctionPass,LLVMPassRef,
        (Cstring, Any),
        Name, Callback)
end

function LLVMCreateModulePass2(Name, Callback, Data)
    ccall(:LLVMExtraCreateModulePass2,LLVMPassRef,
        (Cstring, Ptr{Cvoid}, Ptr{Cvoid}),
        Name, Callback, Data)
end

function LLVMCreateFunctionPass2(Name, Callback, Data)
    ccall(:LLVMExtraCreateFunctionPass2,LLVMPassRef,
        (Cstring, Ptr{Cvoid}, Ptr{Cvoid}),
        Name, Callback, Data)
end


# various missing functions

function LLVMAddInternalizePassWithExportList(PM, ExportList, Length)
    ccall(:LLVMExtraAddInternalizePassWithExportList,Cvoid,(LLVMPassManagerRef,Ptr{Cstring},Csize_t), PM, ExportList, Length)
end

function LLVMAddTargetLibraryInfoByTriple(Triple, PM)
    ccall(:LLVMExtraAddTargetLibraryInfoByTiple,Cvoid,(Cstring, LLVMPassManagerRef), Triple, PM)
end

function LLVMAddNVVMReflectPass(PM, smversion)
    ccall(:LLVMExtraAddNVVMReflectFunctionPass,Cvoid,(LLVMPassManagerRef, Cuint), PM, smversion)
end

function LLVMAddBarrierNoopPass(PM)
    ccall(:LLVMExtraAddBarrierNoopPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddDivRemPairsPass(PM)
    ccall(:LLVMExtraAddDivRemPairsPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddLoopDistributePass(PM)
    ccall(:LLVMExtraAddLoopDistributePass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddLoopFusePass(PM)
    ccall(:LLVMExtraAddLoopFusePass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddLoopLoadEliminationPass(PM)
    ccall(:LLVMExtraLoopLoadEliminationPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddLoadStoreVectorizerPass(PM)
    ccall(:LLVMExtraAddLoadStoreVectorizerPass,Cvoid,(LLVMPassManagerRef,), PM)
end

if LLVM.version() < v"12"
function LLVMAddInstSimplifyPass(PM)
    ccall(:LLVMExtraAddInstructionSimplifyPass,Cvoid,(LLVMPassManagerRef,), PM)
end
end

function LLVMGetValueContext(V)
    ccall(:LLVMExtraGetValueContext,LLVMContextRef,(LLVMValueRef,),V)
end

function LLVMGetSourceLocation(V, index, Name, Filename, Line, Column)
    ccall(:LLVMExtraGetSourceLocation,Cint,(LLVMValueRef,Cint,Ptr{Cstring},Ptr{Cstring},Ptr{Cuint},Ptr{Cuint}), V, index, Name, Filename, Line, Column)
end

function LLVMExtraAppendToUsed(Mod, Values, Count)
    ccall(:LLVMExtraAppendToUsed,Cvoid,(LLVMModuleRef,Ptr{LLVMValueRef},Csize_t), Mod, Values, Count)
end

function LLVMExtraAppendToCompilerUsed(Mod, Values, Count)
    ccall(:LLVMExtraAppendToCompilerUsed,Cvoid,(LLVMModuleRef,Ptr{LLVMValueRef},Csize_t), Mod, Values, Count)
end

function LLVMExtraAddGenericAnalysisPasses(PM)
    ccall(:LLVMExtraAddGenericAnalysisPasses, Cvoid, (LLVMPassManagerRef,), PM)
end

@cenum(LLVMDebugEmissionKind,
    LLVMDebugEmissionKindNoDebug = 0,
    LLVMDebugEmissionKindFullDebug = 1,
    LLVMDebugEmissionKindLineTablesOnly = 2,
    LLVMDebugEmissionKindDebugDirectivesOnly = 3,
)
