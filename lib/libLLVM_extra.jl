# Julia wrapper for source: LLVMExtra_jll

# initialization functions

function LLVMInitializeAllTargetInfos()
    @runtime_ccall (:LLVMExtraInitializeAllTargetInfos, libLLVMExtra) Cvoid ()
end

function LLVMInitializeAllTargets()
    @runtime_ccall (:LLVMExtraInitializeAllTargets, libLLVMExtra) Cvoid ()
end

function LLVMInitializeAllTargetMCs()
    @runtime_ccall (:LLVMExtraInitializeAllTargetMCs, libLLVMExtra) Cvoid ()
end

function LLVMInitializeAllAsmPrinters()
    @runtime_ccall (:LLVMExtraInitializeAllAsmPrinters, libLLVMExtra) Cvoid ()
end

function LLVMInitializeAllAsmParsers()
    @runtime_ccall (:LLVMExtraInitializeAllAsmParsers, libLLVMExtra) Cvoid ()
end

function LLVMInitializeAllDisassemblers()
    @runtime_ccall (:LLVMExtraInitializeAllDisassemblers, libLLVMExtra) Cvoid ()
end

function LLVMInitializeNativeTarget()
    @runtime_ccall (:LLVMExtraInitializeNativeTarget, libLLVMExtra) LLVMBool ()
end

function LLVMInitializeNativeAsmPrinter()
    @runtime_ccall (:LLVMExtraInitializeNativeAsmPrinter, libLLVMExtra) LLVMBool ()
end

function LLVMInitializeNativeAsmParser()
    @runtime_ccall (:LLVMExtraInitializeNativeAsmParser, libLLVMExtra) LLVMBool ()
end

function LLVMInitializeNativeDisassembler()
    @runtime_ccall (:LLVMExtraInitializeNativeDisassembler, libLLVMExtra) LLVMBool ()
end

# infrastructure for writing LLVM passes in Julia

mutable struct LLVMOpaquePass
end

const LLVMPassRef = Ptr{LLVMOpaquePass}

function LLVMAddPass(PM, P)
    @runtime_ccall (:LLVMExtraAddPass, libLLVMExtra) Cvoid (LLVMPassManagerRef, LLVMPassRef) PM P
end

function LLVMCreateModulePass(Name, Callback)
    @runtime_ccall (:LLVMExtraCreateModulePass, libLLVMExtra) LLVMPassRef (Cstring, Any) Name Callback
end

function LLVMCreateFunctionPass(Name, Callback)
    @runtime_ccall (:LLVMExtraCreateFunctionPass, libLLVMExtra) LLVMPassRef (Cstring, Any) Name Callback
end

function LLVMCreateBasicBlockPass(Name, Callback)
    @runtime_ccall (:LLVMExtraCreateBasicBlockPass, libLLVMExtra) LLVMPassRef (Cstring, Any) Name Callback
end

function LLVMCreateModulePass2(Name, Callback, Data)
    @runtime_ccall (:LLVMExtraCreateModulePass2, libLLVMExtra) LLVMPassRef (Cstring, Ptr{Cvoid}, Ptr{Cvoid}) Name Callback Data
end

function LLVMCreateFunctionPass2(Name, Callback, Data)
    @runtime_ccall (:LLVMExtraCreateFunctionPass2, libLLVMExtra) LLVMPassRef (Cstring, Ptr{Cvoid}, Ptr{Cvoid}) Name Callback Data
end


# various missing functions

function LLVMAddInternalizePassWithExportList(PM, ExportList, Length)
    @runtime_ccall (:LLVMExtraAddInternalizePassWithExportList, libLLVMExtra) Cvoid (LLVMPassManagerRef,Ptr{Cstring},Csize_t) PM ExportList Length
end

function LLVMAddTargetLibraryInfoByTriple(Triple, PM)
    @runtime_ccall (:LLVMExtraAddTargetLibraryInfoByTiple, libLLVMExtra) Cvoid (Cstring, LLVMPassManagerRef) Triple PM
end

function LLVMAddNVVMReflectPass(PM, smversion)
     @runtime_ccall (:LLVMExtraAddNVVMReflectFunctionPass, libLLVMExtra) Cvoid (LLVMPassManagerRef, Cuint) PM smversion
end

function LLVMAddBarrierNoopPass(PM)
    @runtime_ccall (:LLVMExtraAddBarrierNoopPass, libLLVMExtra) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddDivRemPairsPass(PM)
    @runtime_ccall (:LLVMExtraAddDivRemPairsPass, libLLVMExtra) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLoopDistributePass(PM)
    @runtime_ccall (:LLVMExtraAddLoopDistributePass, libLLVMExtra) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLoopFusePass(PM)
    @runtime_ccall (:LLVMExtraAddLoopFusePass, libLLVMExtra) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLoopLoadEliminationPass(PM)
    @runtime_ccall (:LLVMExtraLoopLoadEliminationPass, libLLVMExtra) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddLoadStoreVectorizerPass(PM)
    @runtime_ccall (:LLVMExtraAddLoadStoreVectorizerPass, libLLVMExtra) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMAddInstSimplifyPass(PM)
    @runtime_ccall (:LLVMExtraAddInstructionSimplifyPass, libLLVMExtra) Cvoid (LLVMPassManagerRef,) PM
end

function LLVMGetValueContext(V)
    @runtime_ccall (:LLVMExtraGetValueContext, libLLVMExtra) LLVMContextRef (LLVMValueRef,) V
end

function LLVMGetSourceLocation(V, index, Name, Filename, Line, Column)
    @runtime_ccall (:LLVMExtraGetSourceLocation, libLLVMExtra) Cint (LLVMValueRef,Cint,Ptr{Cstring},Ptr{Cstring},Ptr{Cuint},Ptr{Cuint}) V index Name Filename Line Column
end

if VERSION >= v"1.5" && !(v"1.6-" <= VERSION < v"1.6.0-DEV.90")
function LLVMExtraAppendToUsed(Mod, Values, Count)
    @runtime_ccall (:LLVMExtraAppendToUsed, libLLVMExtra) Cvoid (LLVMModuleRef,Ptr{LLVMValueRef},Csize_t) Mod Values Count
end

function LLVMExtraAppendToCompilerUsed(Mod, Values, Count)
    @runtime_ccall (:LLVMExtraAppendToCompilerUsed, libLLVMExtra) Cvoid (LLVMModuleRef,Ptr{LLVMValueRef},Csize_t) Mod Values Count
end

function LLVMExtraAddGenericAnalysisPasses(PM)
    ccall(:LLVMExtraAddGenericAnalysisPasses, Cvoid, (LLVMPassManagerRef,), PM)
end
end

@cenum(LLVMDebugEmissionKind,
    LLVMDebugEmissionKindNoDebug = 0,
    LLVMDebugEmissionKindFullDebug = 1,
    LLVMDebugEmissionKindLineTablesOnly = 2,
    LLVMDebugEmissionKindDebugDirectivesOnly = 3,
)
