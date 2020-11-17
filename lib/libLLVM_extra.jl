# Julia wrapper for source: julia/src/llvm-api.cpp


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

function LLVMCreateBasicBlockPass(Name, Callback)
    ccall(:LLVMExtraCreateBasicBlockPass,LLVMPassRef,
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

if VERSION < v"1.2.0-DEV.531"
function LLVMAddNVVMReflectPass(PM, smversion)
    ccall(:LLVMExtraAddMVVMReflectPass,Cvoid,(LLVMPassManagerRef,), PM)
end
else

if version() < v"8.0"
    function LLVMAddNVVMReflectPass(PM, smversion)
        ccall(:LLVMExtraAddNVVMReflectPass,Cvoid,(LLVMPassManagerRef,), PM)
    end
else
    function LLVMAddNVVMReflectPass(PM, smversion)
        ccall(:LLVMExtraAddNVVMReflectFunctionPass,Cvoid,(LLVMPassManagerRef, Cuint), PM, smversion)
    end
end

function LLVMAddAllocOptPass(PM)
    ccall(:LLVMExtraAddAllocOptPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddBarrierNoopPass(PM)
    ccall(:LLVMExtraAddBarrierNoopPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddGCInvariantVerifierPass(PM, Strong)
    ccall(:LLVMExtraAddGCInvariantVerifierPass,Cvoid,(LLVMPassManagerRef,LLVMBool), PM, Strong)
end

function LLVMAddLowerExcHandlersPass(PM)
    ccall(:LLVMExtraAddLowerExcHandlersPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddCombineMulAddPass(PM)
    ccall(:LLVMExtraAddCombineMulAddPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddMultiVersioningPass(PM)
    ccall(:LLVMExtraAddMultiVersioningPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddPropagateJuliaAddrspaces(PM)
    ccall(:LLVMExtraAddPropagateJuliaAddrspaces,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddLowerPTLSPass(PM, imaging_mode)
    ccall(:LLVMExtraAddLowerPTLSPass,Cvoid,(LLVMPassManagerRef,LLVMBool), PM, imaging_mode)
end

function LLVMAddLowerSimdLoopPass(PM)
    ccall(:LLVMExtraAddLowerSimdLoopPass,Cvoid,(LLVMPassManagerRef,), PM)
end

function LLVMAddLateLowerGCFramePass(PM)
    ccall(:LLVMExtraAddLateLowerGCFramePass,Cvoid,(LLVMPassManagerRef,), PM)
end

end

if VERSION >= v"1.3.0-DEV.95"
function LLVMAddFinalLowerGCPass(PM)
    ccall(:LLVMExtraAddFinalLowerGCPass,Cvoid,(LLVMPassManagerRef,), PM)
end
end

if VERSION >= v"1.5.0-DEV.802"
function LLVMAddRemoveJuliaAddrspacesPass(PM)
    ccall(:LLVMExtraAddRemoveJuliaAddrspacesPass,Cvoid,(LLVMPassManagerRef,), PM)
end
end

if VERSION >= v"1.6.0-DEV.1215"
function LLVMAddDemoteFloat16Pass(PM)
    ccall(:LLVMExtraAddDemoteFloat16Pass,Cvoid,(LLVMPassManagerRef,), PM)
end
end

if VERSION >= v"1.6.0-DEV.1476"
function LLVMAddRemoveNIPass(PM)
    ccall(:LLVMExtraAddRemoveNIPass,Cvoid,(LLVMPassManagerRef,), PM)
end
end

if VERSION >= v"1.6.0-DEV.1477"
function LLVMAddJuliaLICMPass(PM)
    ccall(:LLVMExtraJuliaLICMPass,Cvoid,(LLVMPassManagerRef,), PM)
end
end

if VERSION >= v"1.6.0-DEV.1503"
function LLVMAddDivRemPairsPass(PM)
    ccall(:LLVMExtraAddDivRemPairsPass,Cvoid,(LLVMPassManagerRef,), PM)
end
end

if VERSION >= v"1.6.0-DEV.1503"
function LLVMAddLoopDistributePass(PM)
    ccall(:LLVMExtraAddLoopDistributePass,Cvoid,(LLVMPassManagerRef,), PM)
end
end

if VERSION >= v"1.6.0-DEV.1503"
function LLVMAddLoopFusePass(PM)
    ccall(:LLVMExtraAddLoopFusePass,Cvoid,(LLVMPassManagerRef,), PM)
end
end

if VERSION >= v"1.6.0-DEV.1503"
function LLVMAddLoopLoadEliminationPass(PM)
    ccall(:LLVMExtraLoopLoadEliminationPass,Cvoid,(LLVMPassManagerRef,), PM)
end
end

if VERSION >= v"1.6.0-DEV.1503"
function LLVMAddLoadStoreVectorizerPass(PM)
    ccall(:LLVMExtraAddLoadStoreVectorizerPass,Cvoid,(LLVMPassManagerRef,), PM)
end
end

if VERSION >= v"1.6.0-DEV.1503"
function LLVMAddInstSimplifyPass(PM)
    ccall(:LLVMExtraAddInstructionSimplifyPass,Cvoid,(LLVMPassManagerRef,), PM)
end
end

function LLVMGetValueContext(V)
    ccall(:LLVMExtraGetValueContext,LLVMContextRef,(LLVMValueRef,),V)
end

if VERSION >= v"0.7.0-alpha.37"
function LLVMGetSourceLocation(V, index, Name, Filename, Line, Column)
    ccall(:LLVMExtraGetSourceLocation,Cint,(LLVMValueRef,Cint,Ptr{Cstring},Ptr{Cstring},Ptr{Cuint},Ptr{Cuint}), V, index, Name, Filename, Line, Column)
end
end

if VERSION >= v"1.5" && !(v"1.6-" <= VERSION < v"1.6.0-DEV.90")
function LLVMExtraAppendToUsed(Mod, Values, Count)
    ccall(:LLVMExtraAppendToUsed,Cvoid,(LLVMModuleRef,Ptr{LLVMValueRef},Csize_t), Mod, Values, Count)
end

function LLVMExtraAppendToCompilerUsed(Mod, Values, Count)
    ccall(:LLVMExtraAppendToCompilerUsed,Cvoid,(LLVMModuleRef,Ptr{LLVMValueRef},Csize_t), Mod, Values, Count)
end

function LLVMExtraAddGenericAnalysisPasses(PM)
    ccall(:LLVMExtraAddGenericAnalysisPasses, Cvoid, (LLVMPassManagerRef,), PM)
end
end

if version() >= v"8.0"
    @cenum(LLVMDebugEmissionKind,
        LLVMDebugEmissionKindNoDebug = 0,
        LLVMDebugEmissionKindFullDebug = 1,
        LLVMDebugEmissionKindLineTablesOnly = 2,
        LLVMDebugEmissionKindDebugDirectivesOnly = 3,
    )
end
