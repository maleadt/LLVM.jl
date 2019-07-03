# Julia wrapper for header: Analysis.h
# Automatically generated using Clang.jl


function LLVMVerifyModule(M, Action, OutMessage)
    @apicall(:LLVMVerifyModule, LLVMBool, (LLVMModuleRef, LLVMVerifierFailureAction, Ptr{Cstring}), M, Action, OutMessage)
end

function LLVMVerifyFunction(Fn, Action)
    @apicall(:LLVMVerifyFunction, LLVMBool, (LLVMValueRef, LLVMVerifierFailureAction), Fn, Action)
end

function LLVMViewFunctionCFG(Fn)
    @apicall(:LLVMViewFunctionCFG, Cvoid, (LLVMValueRef,), Fn)
end

function LLVMViewFunctionCFGOnly(Fn)
    @apicall(:LLVMViewFunctionCFGOnly, Cvoid, (LLVMValueRef,), Fn)
end
# Julia wrapper for header: BitReader.h
# Automatically generated using Clang.jl


function LLVMParseBitcode(MemBuf, OutModule, OutMessage)
    @apicall(:LLVMParseBitcode, LLVMBool, (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), MemBuf, OutModule, OutMessage)
end

function LLVMParseBitcode2(MemBuf, OutModule)
    @apicall(:LLVMParseBitcode2, LLVMBool, (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}), MemBuf, OutModule)
end

function LLVMParseBitcodeInContext(ContextRef, MemBuf, OutModule, OutMessage)
    @apicall(:LLVMParseBitcodeInContext, LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), ContextRef, MemBuf, OutModule, OutMessage)
end

function LLVMParseBitcodeInContext2(ContextRef, MemBuf, OutModule)
    @apicall(:LLVMParseBitcodeInContext2, LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}), ContextRef, MemBuf, OutModule)
end

function LLVMGetBitcodeModuleInContext(ContextRef, MemBuf, OutM, OutMessage)
    @apicall(:LLVMGetBitcodeModuleInContext, LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), ContextRef, MemBuf, OutM, OutMessage)
end

function LLVMGetBitcodeModuleInContext2(ContextRef, MemBuf, OutM)
    @apicall(:LLVMGetBitcodeModuleInContext2, LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}), ContextRef, MemBuf, OutM)
end

function LLVMGetBitcodeModule(MemBuf, OutM, OutMessage)
    @apicall(:LLVMGetBitcodeModule, LLVMBool, (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), MemBuf, OutM, OutMessage)
end

function LLVMGetBitcodeModule2(MemBuf, OutM)
    @apicall(:LLVMGetBitcodeModule2, LLVMBool, (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}), MemBuf, OutM)
end
# Julia wrapper for header: BitWriter.h
# Automatically generated using Clang.jl


function LLVMWriteBitcodeToFile(M, Path)
    @apicall(:LLVMWriteBitcodeToFile, Cint, (LLVMModuleRef, Cstring), M, Path)
end

function LLVMWriteBitcodeToFD(M, FD, ShouldClose, Unbuffered)
    @apicall(:LLVMWriteBitcodeToFD, Cint, (LLVMModuleRef, Cint, Cint, Cint), M, FD, ShouldClose, Unbuffered)
end

function LLVMWriteBitcodeToFileHandle(M, Handle)
    @apicall(:LLVMWriteBitcodeToFileHandle, Cint, (LLVMModuleRef, Cint), M, Handle)
end

function LLVMWriteBitcodeToMemoryBuffer(M)
    @apicall(:LLVMWriteBitcodeToMemoryBuffer, LLVMMemoryBufferRef, (LLVMModuleRef,), M)
end
# Julia wrapper for header: Comdat.h
# Automatically generated using Clang.jl


function LLVMGetOrInsertComdat(M, Name)
    @apicall(:LLVMGetOrInsertComdat, LLVMComdatRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetComdat(V)
    @apicall(:LLVMGetComdat, LLVMComdatRef, (LLVMValueRef,), V)
end

function LLVMSetComdat(V, C)
    @apicall(:LLVMSetComdat, Cvoid, (LLVMValueRef, LLVMComdatRef), V, C)
end

function LLVMGetComdatSelectionKind(C)
    @apicall(:LLVMGetComdatSelectionKind, LLVMComdatSelectionKind, (LLVMComdatRef,), C)
end

function LLVMSetComdatSelectionKind(C, Kind)
    @apicall(:LLVMSetComdatSelectionKind, Cvoid, (LLVMComdatRef, LLVMComdatSelectionKind), C, Kind)
end
# Julia wrapper for header: Core.h
# Automatically generated using Clang.jl


function LLVMInstallFatalErrorHandler(Handler)
    @apicall(:LLVMInstallFatalErrorHandler, Cvoid, (LLVMFatalErrorHandler,), Handler)
end

function LLVMResetFatalErrorHandler()
    @apicall(:LLVMResetFatalErrorHandler, Cvoid, ())
end

function LLVMEnablePrettyStackTrace()
    @apicall(:LLVMEnablePrettyStackTrace, Cvoid, ())
end

function LLVMInitializeCore(R)
    @apicall(:LLVMInitializeCore, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMShutdown()
    @apicall(:LLVMShutdown, Cvoid, ())
end

function LLVMCreateMessage(Message)
    @apicall(:LLVMCreateMessage, Cstring, (Cstring,), Message)
end

function LLVMDisposeMessage(Message)
    @apicall(:LLVMDisposeMessage, Cvoid, (Cstring,), Message)
end

function LLVMContextCreate()
    @apicall(:LLVMContextCreate, LLVMContextRef, ())
end

function LLVMGetGlobalContext()
    @apicall(:LLVMGetGlobalContext, LLVMContextRef, ())
end

function LLVMContextSetDiagnosticHandler(C, Handler, DiagnosticContext)
    @apicall(:LLVMContextSetDiagnosticHandler, Cvoid, (LLVMContextRef, LLVMDiagnosticHandler, Ptr{Cvoid}), C, Handler, DiagnosticContext)
end

function LLVMContextGetDiagnosticHandler(C)
    @apicall(:LLVMContextGetDiagnosticHandler, LLVMDiagnosticHandler, (LLVMContextRef,), C)
end

function LLVMContextGetDiagnosticContext(C)
    @apicall(:LLVMContextGetDiagnosticContext, Ptr{Cvoid}, (LLVMContextRef,), C)
end

function LLVMContextSetYieldCallback(C, Callback, OpaqueHandle)
    @apicall(:LLVMContextSetYieldCallback, Cvoid, (LLVMContextRef, LLVMYieldCallback, Ptr{Cvoid}), C, Callback, OpaqueHandle)
end

function LLVMContextShouldDiscardValueNames(C)
    @apicall(:LLVMContextShouldDiscardValueNames, LLVMBool, (LLVMContextRef,), C)
end

function LLVMContextSetDiscardValueNames(C, Discard)
    @apicall(:LLVMContextSetDiscardValueNames, Cvoid, (LLVMContextRef, LLVMBool), C, Discard)
end

function LLVMContextDispose(C)
    @apicall(:LLVMContextDispose, Cvoid, (LLVMContextRef,), C)
end

function LLVMGetDiagInfoDescription(DI)
    @apicall(:LLVMGetDiagInfoDescription, Cstring, (LLVMDiagnosticInfoRef,), DI)
end

function LLVMGetDiagInfoSeverity(DI)
    @apicall(:LLVMGetDiagInfoSeverity, LLVMDiagnosticSeverity, (LLVMDiagnosticInfoRef,), DI)
end

function LLVMGetMDKindIDInContext(C, Name, SLen)
    @apicall(:LLVMGetMDKindIDInContext, UInt32, (LLVMContextRef, Cstring, UInt32), C, Name, SLen)
end

function LLVMGetMDKindID(Name, SLen)
    @apicall(:LLVMGetMDKindID, UInt32, (Cstring, UInt32), Name, SLen)
end

function LLVMGetEnumAttributeKindForName(Name, SLen)
    @apicall(:LLVMGetEnumAttributeKindForName, UInt32, (Cstring, Csize_t), Name, SLen)
end

function LLVMGetLastEnumAttributeKind()
    @apicall(:LLVMGetLastEnumAttributeKind, UInt32, ())
end

function LLVMCreateEnumAttribute(C, KindID, Val)
    @apicall(:LLVMCreateEnumAttribute, LLVMAttributeRef, (LLVMContextRef, UInt32, UInt64), C, KindID, Val)
end

function LLVMGetEnumAttributeKind(A)
    @apicall(:LLVMGetEnumAttributeKind, UInt32, (LLVMAttributeRef,), A)
end

function LLVMGetEnumAttributeValue(A)
    @apicall(:LLVMGetEnumAttributeValue, UInt64, (LLVMAttributeRef,), A)
end

function LLVMCreateStringAttribute(C, K, KLength, V, VLength)
    @apicall(:LLVMCreateStringAttribute, LLVMAttributeRef, (LLVMContextRef, Cstring, UInt32, Cstring, UInt32), C, K, KLength, V, VLength)
end

function LLVMGetStringAttributeKind(A, Length)
    @apicall(:LLVMGetStringAttributeKind, Cstring, (LLVMAttributeRef, Ptr{UInt32}), A, Length)
end

function LLVMGetStringAttributeValue(A, Length)
    @apicall(:LLVMGetStringAttributeValue, Cstring, (LLVMAttributeRef, Ptr{UInt32}), A, Length)
end

function LLVMIsEnumAttribute(A)
    @apicall(:LLVMIsEnumAttribute, LLVMBool, (LLVMAttributeRef,), A)
end

function LLVMIsStringAttribute(A)
    @apicall(:LLVMIsStringAttribute, LLVMBool, (LLVMAttributeRef,), A)
end

function LLVMModuleCreateWithName(ModuleID)
    @apicall(:LLVMModuleCreateWithName, LLVMModuleRef, (Cstring,), ModuleID)
end

function LLVMModuleCreateWithNameInContext(ModuleID, C)
    @apicall(:LLVMModuleCreateWithNameInContext, LLVMModuleRef, (Cstring, LLVMContextRef), ModuleID, C)
end

function LLVMCloneModule(M)
    @apicall(:LLVMCloneModule, LLVMModuleRef, (LLVMModuleRef,), M)
end

function LLVMDisposeModule(M)
    @apicall(:LLVMDisposeModule, Cvoid, (LLVMModuleRef,), M)
end

function LLVMGetModuleIdentifier(M, Len)
    @apicall(:LLVMGetModuleIdentifier, Cstring, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMSetModuleIdentifier(M, Ident, Len)
    @apicall(:LLVMSetModuleIdentifier, Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Ident, Len)
end

function LLVMGetSourceFileName(M, Len)
    @apicall(:LLVMGetSourceFileName, Cstring, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMSetSourceFileName(M, Name, Len)
    @apicall(:LLVMSetSourceFileName, Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Name, Len)
end

function LLVMGetDataLayoutStr(M)
    @apicall(:LLVMGetDataLayoutStr, Cstring, (LLVMModuleRef,), M)
end

function LLVMGetDataLayout(M)
    @apicall(:LLVMGetDataLayout, Cstring, (LLVMModuleRef,), M)
end

function LLVMSetDataLayout(M, DataLayoutStr)
    @apicall(:LLVMSetDataLayout, Cvoid, (LLVMModuleRef, Cstring), M, DataLayoutStr)
end

function LLVMGetTarget(M)
    @apicall(:LLVMGetTarget, Cstring, (LLVMModuleRef,), M)
end

function LLVMSetTarget(M, Triple)
    @apicall(:LLVMSetTarget, Cvoid, (LLVMModuleRef, Cstring), M, Triple)
end

function LLVMCopyModuleFlagsMetadata(M, Len)
    @apicall(:LLVMCopyModuleFlagsMetadata, Ptr{LLVMModuleFlagEntry}, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMDisposeModuleFlagsMetadata(Entries)
    @apicall(:LLVMDisposeModuleFlagsMetadata, Cvoid, (Ptr{LLVMModuleFlagEntry},), Entries)
end

function LLVMModuleFlagEntriesGetFlagBehavior(Entries, Index)
    @apicall(:LLVMModuleFlagEntriesGetFlagBehavior, LLVMModuleFlagBehavior, (Ptr{LLVMModuleFlagEntry}, UInt32), Entries, Index)
end

function LLVMModuleFlagEntriesGetKey(Entries, Index, Len)
    @apicall(:LLVMModuleFlagEntriesGetKey, Cstring, (Ptr{LLVMModuleFlagEntry}, UInt32, Ptr{Csize_t}), Entries, Index, Len)
end

function LLVMModuleFlagEntriesGetMetadata(Entries, Index)
    @apicall(:LLVMModuleFlagEntriesGetMetadata, LLVMMetadataRef, (Ptr{LLVMModuleFlagEntry}, UInt32), Entries, Index)
end

function LLVMGetModuleFlag(M, Key, KeyLen)
    @apicall(:LLVMGetModuleFlag, LLVMMetadataRef, (LLVMModuleRef, Cstring, Csize_t), M, Key, KeyLen)
end

function LLVMAddModuleFlag(M, Behavior, Key, KeyLen, Val)
    @apicall(:LLVMAddModuleFlag, Cvoid, (LLVMModuleRef, LLVMModuleFlagBehavior, Cstring, Csize_t, LLVMMetadataRef), M, Behavior, Key, KeyLen, Val)
end

function LLVMDumpModule(M)
    @apicall(:LLVMDumpModule, Cvoid, (LLVMModuleRef,), M)
end

function LLVMPrintModuleToFile(M, Filename, ErrorMessage)
    @apicall(:LLVMPrintModuleToFile, LLVMBool, (LLVMModuleRef, Cstring, Ptr{Cstring}), M, Filename, ErrorMessage)
end

function LLVMPrintModuleToString(M)
    @apicall(:LLVMPrintModuleToString, Cstring, (LLVMModuleRef,), M)
end

function LLVMGetModuleInlineAsm(M, Len)
    @apicall(:LLVMGetModuleInlineAsm, Cstring, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMSetModuleInlineAsm2(M, Asm, Len)
    @apicall(:LLVMSetModuleInlineAsm2, Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Asm, Len)
end

function LLVMAppendModuleInlineAsm(M, Asm, Len)
    @apicall(:LLVMAppendModuleInlineAsm, Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Asm, Len)
end

function LLVMGetInlineAsm(Ty, AsmString, AsmStringSize, Constraints, ConstraintsSize, HasSideEffects, IsAlignStack, Dialect)
    @apicall(:LLVMGetInlineAsm, LLVMValueRef, (LLVMTypeRef, Cstring, Csize_t, Cstring, Csize_t, LLVMBool, LLVMBool, LLVMInlineAsmDialect), Ty, AsmString, AsmStringSize, Constraints, ConstraintsSize, HasSideEffects, IsAlignStack, Dialect)
end

function LLVMGetModuleContext(M)
    @apicall(:LLVMGetModuleContext, LLVMContextRef, (LLVMModuleRef,), M)
end

function LLVMGetTypeByName(M, Name)
    @apicall(:LLVMGetTypeByName, LLVMTypeRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetFirstNamedMetadata(M)
    @apicall(:LLVMGetFirstNamedMetadata, LLVMNamedMDNodeRef, (LLVMModuleRef,), M)
end

function LLVMGetLastNamedMetadata(M)
    @apicall(:LLVMGetLastNamedMetadata, LLVMNamedMDNodeRef, (LLVMModuleRef,), M)
end

function LLVMGetNextNamedMetadata(NamedMDNode)
    @apicall(:LLVMGetNextNamedMetadata, LLVMNamedMDNodeRef, (LLVMNamedMDNodeRef,), NamedMDNode)
end

function LLVMGetPreviousNamedMetadata(NamedMDNode)
    @apicall(:LLVMGetPreviousNamedMetadata, LLVMNamedMDNodeRef, (LLVMNamedMDNodeRef,), NamedMDNode)
end

function LLVMGetNamedMetadata(M, Name, NameLen)
    @apicall(:LLVMGetNamedMetadata, LLVMNamedMDNodeRef, (LLVMModuleRef, Cstring, Csize_t), M, Name, NameLen)
end

function LLVMGetOrInsertNamedMetadata(M, Name, NameLen)
    @apicall(:LLVMGetOrInsertNamedMetadata, LLVMNamedMDNodeRef, (LLVMModuleRef, Cstring, Csize_t), M, Name, NameLen)
end

function LLVMGetNamedMetadataName(NamedMD, NameLen)
    @apicall(:LLVMGetNamedMetadataName, Cstring, (LLVMNamedMDNodeRef, Ptr{Csize_t}), NamedMD, NameLen)
end

function LLVMGetNamedMetadataNumOperands(M, Name)
    @apicall(:LLVMGetNamedMetadataNumOperands, UInt32, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetNamedMetadataOperands(M, Name, Dest)
    @apicall(:LLVMGetNamedMetadataOperands, Cvoid, (LLVMModuleRef, Cstring, Ptr{LLVMValueRef}), M, Name, Dest)
end

function LLVMAddNamedMetadataOperand(M, Name, Val)
    @apicall(:LLVMAddNamedMetadataOperand, Cvoid, (LLVMModuleRef, Cstring, LLVMValueRef), M, Name, Val)
end

function LLVMGetDebugLocDirectory(Val, Length)
    @apicall(:LLVMGetDebugLocDirectory, Cstring, (LLVMValueRef, Ptr{UInt32}), Val, Length)
end

function LLVMGetDebugLocFilename(Val, Length)
    @apicall(:LLVMGetDebugLocFilename, Cstring, (LLVMValueRef, Ptr{UInt32}), Val, Length)
end

function LLVMGetDebugLocLine(Val)
    @apicall(:LLVMGetDebugLocLine, UInt32, (LLVMValueRef,), Val)
end

function LLVMGetDebugLocColumn(Val)
    @apicall(:LLVMGetDebugLocColumn, UInt32, (LLVMValueRef,), Val)
end

function LLVMAddFunction(M, Name, FunctionTy)
    @apicall(:LLVMAddFunction, LLVMValueRef, (LLVMModuleRef, Cstring, LLVMTypeRef), M, Name, FunctionTy)
end

function LLVMGetNamedFunction(M, Name)
    @apicall(:LLVMGetNamedFunction, LLVMValueRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetFirstFunction(M)
    @apicall(:LLVMGetFirstFunction, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastFunction(M)
    @apicall(:LLVMGetLastFunction, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextFunction(Fn)
    @apicall(:LLVMGetNextFunction, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetPreviousFunction(Fn)
    @apicall(:LLVMGetPreviousFunction, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMSetModuleInlineAsm(M, Asm)
    @apicall(:LLVMSetModuleInlineAsm, Cvoid, (LLVMModuleRef, Cstring), M, Asm)
end

function LLVMGetTypeKind(Ty)
    @apicall(:LLVMGetTypeKind, LLVMTypeKind, (LLVMTypeRef,), Ty)
end

function LLVMTypeIsSized(Ty)
    @apicall(:LLVMTypeIsSized, LLVMBool, (LLVMTypeRef,), Ty)
end

function LLVMGetTypeContext(Ty)
    @apicall(:LLVMGetTypeContext, LLVMContextRef, (LLVMTypeRef,), Ty)
end

function LLVMDumpType(Val)
    @apicall(:LLVMDumpType, Cvoid, (LLVMTypeRef,), Val)
end

function LLVMPrintTypeToString(Val)
    @apicall(:LLVMPrintTypeToString, Cstring, (LLVMTypeRef,), Val)
end

function LLVMInt1TypeInContext(C)
    @apicall(:LLVMInt1TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt8TypeInContext(C)
    @apicall(:LLVMInt8TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt16TypeInContext(C)
    @apicall(:LLVMInt16TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt32TypeInContext(C)
    @apicall(:LLVMInt32TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt64TypeInContext(C)
    @apicall(:LLVMInt64TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt128TypeInContext(C)
    @apicall(:LLVMInt128TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMIntTypeInContext(C, NumBits)
    @apicall(:LLVMIntTypeInContext, LLVMTypeRef, (LLVMContextRef, UInt32), C, NumBits)
end

function LLVMInt1Type()
    @apicall(:LLVMInt1Type, LLVMTypeRef, ())
end

function LLVMInt8Type()
    @apicall(:LLVMInt8Type, LLVMTypeRef, ())
end

function LLVMInt16Type()
    @apicall(:LLVMInt16Type, LLVMTypeRef, ())
end

function LLVMInt32Type()
    @apicall(:LLVMInt32Type, LLVMTypeRef, ())
end

function LLVMInt64Type()
    @apicall(:LLVMInt64Type, LLVMTypeRef, ())
end

function LLVMInt128Type()
    @apicall(:LLVMInt128Type, LLVMTypeRef, ())
end

function LLVMIntType(NumBits)
    @apicall(:LLVMIntType, LLVMTypeRef, (UInt32,), NumBits)
end

function LLVMGetIntTypeWidth(IntegerTy)
    @apicall(:LLVMGetIntTypeWidth, UInt32, (LLVMTypeRef,), IntegerTy)
end

function LLVMHalfTypeInContext(C)
    @apicall(:LLVMHalfTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMFloatTypeInContext(C)
    @apicall(:LLVMFloatTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMDoubleTypeInContext(C)
    @apicall(:LLVMDoubleTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMX86FP80TypeInContext(C)
    @apicall(:LLVMX86FP80TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMFP128TypeInContext(C)
    @apicall(:LLVMFP128TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMPPCFP128TypeInContext(C)
    @apicall(:LLVMPPCFP128TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMHalfType()
    @apicall(:LLVMHalfType, LLVMTypeRef, ())
end

function LLVMFloatType()
    @apicall(:LLVMFloatType, LLVMTypeRef, ())
end

function LLVMDoubleType()
    @apicall(:LLVMDoubleType, LLVMTypeRef, ())
end

function LLVMX86FP80Type()
    @apicall(:LLVMX86FP80Type, LLVMTypeRef, ())
end

function LLVMFP128Type()
    @apicall(:LLVMFP128Type, LLVMTypeRef, ())
end

function LLVMPPCFP128Type()
    @apicall(:LLVMPPCFP128Type, LLVMTypeRef, ())
end

function LLVMFunctionType(ReturnType, ParamTypes, ParamCount, IsVarArg)
    @apicall(:LLVMFunctionType, LLVMTypeRef, (LLVMTypeRef, Ptr{LLVMTypeRef}, UInt32, LLVMBool), ReturnType, ParamTypes, ParamCount, IsVarArg)
end

function LLVMIsFunctionVarArg(FunctionTy)
    @apicall(:LLVMIsFunctionVarArg, LLVMBool, (LLVMTypeRef,), FunctionTy)
end

function LLVMGetReturnType(FunctionTy)
    @apicall(:LLVMGetReturnType, LLVMTypeRef, (LLVMTypeRef,), FunctionTy)
end

function LLVMCountParamTypes(FunctionTy)
    @apicall(:LLVMCountParamTypes, UInt32, (LLVMTypeRef,), FunctionTy)
end

function LLVMGetParamTypes(FunctionTy, Dest)
    @apicall(:LLVMGetParamTypes, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), FunctionTy, Dest)
end

function LLVMStructTypeInContext(C, ElementTypes, ElementCount, Packed)
    @apicall(:LLVMStructTypeInContext, LLVMTypeRef, (LLVMContextRef, Ptr{LLVMTypeRef}, UInt32, LLVMBool), C, ElementTypes, ElementCount, Packed)
end

function LLVMStructType(ElementTypes, ElementCount, Packed)
    @apicall(:LLVMStructType, LLVMTypeRef, (Ptr{LLVMTypeRef}, UInt32, LLVMBool), ElementTypes, ElementCount, Packed)
end

function LLVMStructCreateNamed(C, Name)
    @apicall(:LLVMStructCreateNamed, LLVMTypeRef, (LLVMContextRef, Cstring), C, Name)
end

function LLVMGetStructName(Ty)
    @apicall(:LLVMGetStructName, Cstring, (LLVMTypeRef,), Ty)
end

function LLVMStructSetBody(StructTy, ElementTypes, ElementCount, Packed)
    @apicall(:LLVMStructSetBody, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}, UInt32, LLVMBool), StructTy, ElementTypes, ElementCount, Packed)
end

function LLVMCountStructElementTypes(StructTy)
    @apicall(:LLVMCountStructElementTypes, UInt32, (LLVMTypeRef,), StructTy)
end

function LLVMGetStructElementTypes(StructTy, Dest)
    @apicall(:LLVMGetStructElementTypes, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), StructTy, Dest)
end

function LLVMStructGetTypeAtIndex(StructTy, i)
    @apicall(:LLVMStructGetTypeAtIndex, LLVMTypeRef, (LLVMTypeRef, UInt32), StructTy, i)
end

function LLVMIsPackedStruct(StructTy)
    @apicall(:LLVMIsPackedStruct, LLVMBool, (LLVMTypeRef,), StructTy)
end

function LLVMIsOpaqueStruct(StructTy)
    @apicall(:LLVMIsOpaqueStruct, LLVMBool, (LLVMTypeRef,), StructTy)
end

function LLVMIsLiteralStruct(StructTy)
    @apicall(:LLVMIsLiteralStruct, LLVMBool, (LLVMTypeRef,), StructTy)
end

function LLVMGetElementType(Ty)
    @apicall(:LLVMGetElementType, LLVMTypeRef, (LLVMTypeRef,), Ty)
end

function LLVMGetSubtypes(Tp, Arr)
    @apicall(:LLVMGetSubtypes, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), Tp, Arr)
end

function LLVMGetNumContainedTypes(Tp)
    @apicall(:LLVMGetNumContainedTypes, UInt32, (LLVMTypeRef,), Tp)
end

function LLVMArrayType(ElementType, ElementCount)
    @apicall(:LLVMArrayType, LLVMTypeRef, (LLVMTypeRef, UInt32), ElementType, ElementCount)
end

function LLVMGetArrayLength(ArrayTy)
    @apicall(:LLVMGetArrayLength, UInt32, (LLVMTypeRef,), ArrayTy)
end

function LLVMPointerType(ElementType, AddressSpace)
    @apicall(:LLVMPointerType, LLVMTypeRef, (LLVMTypeRef, UInt32), ElementType, AddressSpace)
end

function LLVMGetPointerAddressSpace(PointerTy)
    @apicall(:LLVMGetPointerAddressSpace, UInt32, (LLVMTypeRef,), PointerTy)
end

function LLVMVectorType(ElementType, ElementCount)
    @apicall(:LLVMVectorType, LLVMTypeRef, (LLVMTypeRef, UInt32), ElementType, ElementCount)
end

function LLVMGetVectorSize(VectorTy)
    @apicall(:LLVMGetVectorSize, UInt32, (LLVMTypeRef,), VectorTy)
end

function LLVMVoidTypeInContext(C)
    @apicall(:LLVMVoidTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMLabelTypeInContext(C)
    @apicall(:LLVMLabelTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMX86MMXTypeInContext(C)
    @apicall(:LLVMX86MMXTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMTokenTypeInContext(C)
    @apicall(:LLVMTokenTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMMetadataTypeInContext(C)
    @apicall(:LLVMMetadataTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMVoidType()
    @apicall(:LLVMVoidType, LLVMTypeRef, ())
end

function LLVMLabelType()
    @apicall(:LLVMLabelType, LLVMTypeRef, ())
end

function LLVMX86MMXType()
    @apicall(:LLVMX86MMXType, LLVMTypeRef, ())
end

function LLVMTypeOf(Val)
    @apicall(:LLVMTypeOf, LLVMTypeRef, (LLVMValueRef,), Val)
end

function LLVMGetValueKind(Val)
    @apicall(:LLVMGetValueKind, LLVMValueKind, (LLVMValueRef,), Val)
end

function LLVMGetValueName2(Val, Length)
    @apicall(:LLVMGetValueName2, Cstring, (LLVMValueRef, Ptr{Csize_t}), Val, Length)
end

function LLVMSetValueName2(Val, Name, NameLen)
    @apicall(:LLVMSetValueName2, Cvoid, (LLVMValueRef, Cstring, Csize_t), Val, Name, NameLen)
end

function LLVMDumpValue(Val)
    @apicall(:LLVMDumpValue, Cvoid, (LLVMValueRef,), Val)
end

function LLVMPrintValueToString(Val)
    @apicall(:LLVMPrintValueToString, Cstring, (LLVMValueRef,), Val)
end

function LLVMReplaceAllUsesWith(OldVal, NewVal)
    @apicall(:LLVMReplaceAllUsesWith, Cvoid, (LLVMValueRef, LLVMValueRef), OldVal, NewVal)
end

function LLVMIsConstant(Val)
    @apicall(:LLVMIsConstant, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMIsUndef(Val)
    @apicall(:LLVMIsUndef, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMIsAArgument(Val)
    @apicall(:LLVMIsAArgument, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABasicBlock(Val)
    @apicall(:LLVMIsABasicBlock, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInlineAsm(Val)
    @apicall(:LLVMIsAInlineAsm, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUser(Val)
    @apicall(:LLVMIsAUser, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstant(Val)
    @apicall(:LLVMIsAConstant, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABlockAddress(Val)
    @apicall(:LLVMIsABlockAddress, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantAggregateZero(Val)
    @apicall(:LLVMIsAConstantAggregateZero, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantArray(Val)
    @apicall(:LLVMIsAConstantArray, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataSequential(Val)
    @apicall(:LLVMIsAConstantDataSequential, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataArray(Val)
    @apicall(:LLVMIsAConstantDataArray, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataVector(Val)
    @apicall(:LLVMIsAConstantDataVector, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantExpr(Val)
    @apicall(:LLVMIsAConstantExpr, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantFP(Val)
    @apicall(:LLVMIsAConstantFP, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantInt(Val)
    @apicall(:LLVMIsAConstantInt, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantPointerNull(Val)
    @apicall(:LLVMIsAConstantPointerNull, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantStruct(Val)
    @apicall(:LLVMIsAConstantStruct, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantTokenNone(Val)
    @apicall(:LLVMIsAConstantTokenNone, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantVector(Val)
    @apicall(:LLVMIsAConstantVector, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalValue(Val)
    @apicall(:LLVMIsAGlobalValue, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalAlias(Val)
    @apicall(:LLVMIsAGlobalAlias, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalIFunc(Val)
    @apicall(:LLVMIsAGlobalIFunc, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalObject(Val)
    @apicall(:LLVMIsAGlobalObject, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFunction(Val)
    @apicall(:LLVMIsAFunction, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalVariable(Val)
    @apicall(:LLVMIsAGlobalVariable, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUndefValue(Val)
    @apicall(:LLVMIsAUndefValue, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInstruction(Val)
    @apicall(:LLVMIsAInstruction, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABinaryOperator(Val)
    @apicall(:LLVMIsABinaryOperator, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACallInst(Val)
    @apicall(:LLVMIsACallInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIntrinsicInst(Val)
    @apicall(:LLVMIsAIntrinsicInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgInfoIntrinsic(Val)
    @apicall(:LLVMIsADbgInfoIntrinsic, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgVariableIntrinsic(Val)
    @apicall(:LLVMIsADbgVariableIntrinsic, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgDeclareInst(Val)
    @apicall(:LLVMIsADbgDeclareInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgLabelInst(Val)
    @apicall(:LLVMIsADbgLabelInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemIntrinsic(Val)
    @apicall(:LLVMIsAMemIntrinsic, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemCpyInst(Val)
    @apicall(:LLVMIsAMemCpyInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemMoveInst(Val)
    @apicall(:LLVMIsAMemMoveInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemSetInst(Val)
    @apicall(:LLVMIsAMemSetInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACmpInst(Val)
    @apicall(:LLVMIsACmpInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFCmpInst(Val)
    @apicall(:LLVMIsAFCmpInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAICmpInst(Val)
    @apicall(:LLVMIsAICmpInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAExtractElementInst(Val)
    @apicall(:LLVMIsAExtractElementInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGetElementPtrInst(Val)
    @apicall(:LLVMIsAGetElementPtrInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInsertElementInst(Val)
    @apicall(:LLVMIsAInsertElementInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInsertValueInst(Val)
    @apicall(:LLVMIsAInsertValueInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsALandingPadInst(Val)
    @apicall(:LLVMIsALandingPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAPHINode(Val)
    @apicall(:LLVMIsAPHINode, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASelectInst(Val)
    @apicall(:LLVMIsASelectInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAShuffleVectorInst(Val)
    @apicall(:LLVMIsAShuffleVectorInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAStoreInst(Val)
    @apicall(:LLVMIsAStoreInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABranchInst(Val)
    @apicall(:LLVMIsABranchInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIndirectBrInst(Val)
    @apicall(:LLVMIsAIndirectBrInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInvokeInst(Val)
    @apicall(:LLVMIsAInvokeInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAReturnInst(Val)
    @apicall(:LLVMIsAReturnInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASwitchInst(Val)
    @apicall(:LLVMIsASwitchInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUnreachableInst(Val)
    @apicall(:LLVMIsAUnreachableInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAResumeInst(Val)
    @apicall(:LLVMIsAResumeInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACleanupReturnInst(Val)
    @apicall(:LLVMIsACleanupReturnInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACatchReturnInst(Val)
    @apicall(:LLVMIsACatchReturnInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFuncletPadInst(Val)
    @apicall(:LLVMIsAFuncletPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACatchPadInst(Val)
    @apicall(:LLVMIsACatchPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACleanupPadInst(Val)
    @apicall(:LLVMIsACleanupPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUnaryInstruction(Val)
    @apicall(:LLVMIsAUnaryInstruction, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAAllocaInst(Val)
    @apicall(:LLVMIsAAllocaInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACastInst(Val)
    @apicall(:LLVMIsACastInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAAddrSpaceCastInst(Val)
    @apicall(:LLVMIsAAddrSpaceCastInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABitCastInst(Val)
    @apicall(:LLVMIsABitCastInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPExtInst(Val)
    @apicall(:LLVMIsAFPExtInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPToSIInst(Val)
    @apicall(:LLVMIsAFPToSIInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPToUIInst(Val)
    @apicall(:LLVMIsAFPToUIInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPTruncInst(Val)
    @apicall(:LLVMIsAFPTruncInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIntToPtrInst(Val)
    @apicall(:LLVMIsAIntToPtrInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAPtrToIntInst(Val)
    @apicall(:LLVMIsAPtrToIntInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASExtInst(Val)
    @apicall(:LLVMIsASExtInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASIToFPInst(Val)
    @apicall(:LLVMIsASIToFPInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsATruncInst(Val)
    @apicall(:LLVMIsATruncInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUIToFPInst(Val)
    @apicall(:LLVMIsAUIToFPInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAZExtInst(Val)
    @apicall(:LLVMIsAZExtInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAExtractValueInst(Val)
    @apicall(:LLVMIsAExtractValueInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsALoadInst(Val)
    @apicall(:LLVMIsALoadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAVAArgInst(Val)
    @apicall(:LLVMIsAVAArgInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMDNode(Val)
    @apicall(:LLVMIsAMDNode, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMDString(Val)
    @apicall(:LLVMIsAMDString, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMGetValueName(Val)
    @apicall(:LLVMGetValueName, Cstring, (LLVMValueRef,), Val)
end

function LLVMSetValueName(Val, Name)
    @apicall(:LLVMSetValueName, Cvoid, (LLVMValueRef, Cstring), Val, Name)
end

function LLVMGetFirstUse(Val)
    @apicall(:LLVMGetFirstUse, LLVMUseRef, (LLVMValueRef,), Val)
end

function LLVMGetNextUse(U)
    @apicall(:LLVMGetNextUse, LLVMUseRef, (LLVMUseRef,), U)
end

function LLVMGetUser(U)
    @apicall(:LLVMGetUser, LLVMValueRef, (LLVMUseRef,), U)
end

function LLVMGetUsedValue(U)
    @apicall(:LLVMGetUsedValue, LLVMValueRef, (LLVMUseRef,), U)
end

function LLVMGetOperand(Val, Index)
    @apicall(:LLVMGetOperand, LLVMValueRef, (LLVMValueRef, UInt32), Val, Index)
end

function LLVMGetOperandUse(Val, Index)
    @apicall(:LLVMGetOperandUse, LLVMUseRef, (LLVMValueRef, UInt32), Val, Index)
end

function LLVMSetOperand(User, Index, Val)
    @apicall(:LLVMSetOperand, Cvoid, (LLVMValueRef, UInt32, LLVMValueRef), User, Index, Val)
end

function LLVMGetNumOperands(Val)
    @apicall(:LLVMGetNumOperands, Cint, (LLVMValueRef,), Val)
end

function LLVMConstNull(Ty)
    @apicall(:LLVMConstNull, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstAllOnes(Ty)
    @apicall(:LLVMConstAllOnes, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMGetUndef(Ty)
    @apicall(:LLVMGetUndef, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMIsNull(Val)
    @apicall(:LLVMIsNull, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMConstPointerNull(Ty)
    @apicall(:LLVMConstPointerNull, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstInt(IntTy, N, SignExtend)
    @apicall(:LLVMConstInt, LLVMValueRef, (LLVMTypeRef, Culonglong, LLVMBool), IntTy, N, SignExtend)
end

function LLVMConstIntOfArbitraryPrecision(IntTy, NumWords, Words)
    @apicall(:LLVMConstIntOfArbitraryPrecision, LLVMValueRef, (LLVMTypeRef, UInt32, Ptr{UInt64}), IntTy, NumWords, Words)
end

function LLVMConstIntOfString(IntTy, Text, Radix)
    @apicall(:LLVMConstIntOfString, LLVMValueRef, (LLVMTypeRef, Cstring, UInt8), IntTy, Text, Radix)
end

function LLVMConstIntOfStringAndSize(IntTy, Text, SLen, Radix)
    @apicall(:LLVMConstIntOfStringAndSize, LLVMValueRef, (LLVMTypeRef, Cstring, UInt32, UInt8), IntTy, Text, SLen, Radix)
end

function LLVMConstReal(RealTy, N)
    @apicall(:LLVMConstReal, LLVMValueRef, (LLVMTypeRef, Cdouble), RealTy, N)
end

function LLVMConstRealOfString(RealTy, Text)
    @apicall(:LLVMConstRealOfString, LLVMValueRef, (LLVMTypeRef, Cstring), RealTy, Text)
end

function LLVMConstRealOfStringAndSize(RealTy, Text, SLen)
    @apicall(:LLVMConstRealOfStringAndSize, LLVMValueRef, (LLVMTypeRef, Cstring, UInt32), RealTy, Text, SLen)
end

function LLVMConstIntGetZExtValue(ConstantVal)
    @apicall(:LLVMConstIntGetZExtValue, Culonglong, (LLVMValueRef,), ConstantVal)
end

function LLVMConstIntGetSExtValue(ConstantVal)
    @apicall(:LLVMConstIntGetSExtValue, Clonglong, (LLVMValueRef,), ConstantVal)
end

function LLVMConstRealGetDouble(ConstantVal, losesInfo)
    @apicall(:LLVMConstRealGetDouble, Cdouble, (LLVMValueRef, Ptr{LLVMBool}), ConstantVal, losesInfo)
end

function LLVMConstStringInContext(C, Str, Length, DontNullTerminate)
    @apicall(:LLVMConstStringInContext, LLVMValueRef, (LLVMContextRef, Cstring, UInt32, LLVMBool), C, Str, Length, DontNullTerminate)
end

function LLVMConstString(Str, Length, DontNullTerminate)
    @apicall(:LLVMConstString, LLVMValueRef, (Cstring, UInt32, LLVMBool), Str, Length, DontNullTerminate)
end

function LLVMIsConstantString(c)
    @apicall(:LLVMIsConstantString, LLVMBool, (LLVMValueRef,), c)
end

function LLVMGetAsString(c, Length)
    @apicall(:LLVMGetAsString, Cstring, (LLVMValueRef, Ptr{Csize_t}), c, Length)
end

function LLVMConstStructInContext(C, ConstantVals, Count, Packed)
    @apicall(:LLVMConstStructInContext, LLVMValueRef, (LLVMContextRef, Ptr{LLVMValueRef}, UInt32, LLVMBool), C, ConstantVals, Count, Packed)
end

function LLVMConstStruct(ConstantVals, Count, Packed)
    @apicall(:LLVMConstStruct, LLVMValueRef, (Ptr{LLVMValueRef}, UInt32, LLVMBool), ConstantVals, Count, Packed)
end

function LLVMConstArray(ElementTy, ConstantVals, Length)
    @apicall(:LLVMConstArray, LLVMValueRef, (LLVMTypeRef, Ptr{LLVMValueRef}, UInt32), ElementTy, ConstantVals, Length)
end

function LLVMConstNamedStruct(StructTy, ConstantVals, Count)
    @apicall(:LLVMConstNamedStruct, LLVMValueRef, (LLVMTypeRef, Ptr{LLVMValueRef}, UInt32), StructTy, ConstantVals, Count)
end

function LLVMGetElementAsConstant(C, idx)
    @apicall(:LLVMGetElementAsConstant, LLVMValueRef, (LLVMValueRef, UInt32), C, idx)
end

function LLVMConstVector(ScalarConstantVals, Size)
    @apicall(:LLVMConstVector, LLVMValueRef, (Ptr{LLVMValueRef}, UInt32), ScalarConstantVals, Size)
end

function LLVMGetConstOpcode(ConstantVal)
    @apicall(:LLVMGetConstOpcode, LLVMOpcode, (LLVMValueRef,), ConstantVal)
end

function LLVMAlignOf(Ty)
    @apicall(:LLVMAlignOf, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMSizeOf(Ty)
    @apicall(:LLVMSizeOf, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstNeg(ConstantVal)
    @apicall(:LLVMConstNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNSWNeg(ConstantVal)
    @apicall(:LLVMConstNSWNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNUWNeg(ConstantVal)
    @apicall(:LLVMConstNUWNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstFNeg(ConstantVal)
    @apicall(:LLVMConstFNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNot(ConstantVal)
    @apicall(:LLVMConstNot, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstAdd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWAdd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNSWAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWAdd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNUWAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFAdd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSub(LHSConstant, RHSConstant)
    @apicall(:LLVMConstSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWSub(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNSWSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWSub(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNUWSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFSub(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstMul(LHSConstant, RHSConstant)
    @apicall(:LLVMConstMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWMul(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNSWMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWMul(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNUWMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFMul(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstUDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstUDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstExactUDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstExactUDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstSDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstExactSDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstExactSDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstURem(LHSConstant, RHSConstant)
    @apicall(:LLVMConstURem, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSRem(LHSConstant, RHSConstant)
    @apicall(:LLVMConstSRem, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFRem(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFRem, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstAnd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstAnd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstOr(LHSConstant, RHSConstant)
    @apicall(:LLVMConstOr, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstXor(LHSConstant, RHSConstant)
    @apicall(:LLVMConstXor, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstICmp(Predicate, LHSConstant, RHSConstant)
    @apicall(:LLVMConstICmp, LLVMValueRef, (LLVMIntPredicate, LLVMValueRef, LLVMValueRef), Predicate, LHSConstant, RHSConstant)
end

function LLVMConstFCmp(Predicate, LHSConstant, RHSConstant)
    @apicall(:LLVMConstFCmp, LLVMValueRef, (LLVMRealPredicate, LLVMValueRef, LLVMValueRef), Predicate, LHSConstant, RHSConstant)
end

function LLVMConstShl(LHSConstant, RHSConstant)
    @apicall(:LLVMConstShl, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstLShr(LHSConstant, RHSConstant)
    @apicall(:LLVMConstLShr, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstAShr(LHSConstant, RHSConstant)
    @apicall(:LLVMConstAShr, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstGEP(ConstantVal, ConstantIndices, NumIndices)
    @apicall(:LLVMConstGEP, LLVMValueRef, (LLVMValueRef, Ptr{LLVMValueRef}, UInt32), ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstGEP2(Ty, ConstantVal, ConstantIndices, NumIndices)
    @apicall(:LLVMConstGEP2, LLVMValueRef, (LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32), Ty, ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstInBoundsGEP(ConstantVal, ConstantIndices, NumIndices)
    @apicall(:LLVMConstInBoundsGEP, LLVMValueRef, (LLVMValueRef, Ptr{LLVMValueRef}, UInt32), ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstInBoundsGEP2(Ty, ConstantVal, ConstantIndices, NumIndices)
    @apicall(:LLVMConstInBoundsGEP2, LLVMValueRef, (LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32), Ty, ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstTrunc(ConstantVal, ToType)
    @apicall(:LLVMConstTrunc, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSExt(ConstantVal, ToType)
    @apicall(:LLVMConstSExt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstZExt(ConstantVal, ToType)
    @apicall(:LLVMConstZExt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPTrunc(ConstantVal, ToType)
    @apicall(:LLVMConstFPTrunc, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPExt(ConstantVal, ToType)
    @apicall(:LLVMConstFPExt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstUIToFP(ConstantVal, ToType)
    @apicall(:LLVMConstUIToFP, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSIToFP(ConstantVal, ToType)
    @apicall(:LLVMConstSIToFP, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPToUI(ConstantVal, ToType)
    @apicall(:LLVMConstFPToUI, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPToSI(ConstantVal, ToType)
    @apicall(:LLVMConstFPToSI, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstPtrToInt(ConstantVal, ToType)
    @apicall(:LLVMConstPtrToInt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstIntToPtr(ConstantVal, ToType)
    @apicall(:LLVMConstIntToPtr, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstBitCast(ConstantVal, ToType)
    @apicall(:LLVMConstBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstAddrSpaceCast(ConstantVal, ToType)
    @apicall(:LLVMConstAddrSpaceCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstZExtOrBitCast(ConstantVal, ToType)
    @apicall(:LLVMConstZExtOrBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSExtOrBitCast(ConstantVal, ToType)
    @apicall(:LLVMConstSExtOrBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstTruncOrBitCast(ConstantVal, ToType)
    @apicall(:LLVMConstTruncOrBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstPointerCast(ConstantVal, ToType)
    @apicall(:LLVMConstPointerCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstIntCast(ConstantVal, ToType, isSigned)
    @apicall(:LLVMConstIntCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef, LLVMBool), ConstantVal, ToType, isSigned)
end

function LLVMConstFPCast(ConstantVal, ToType)
    @apicall(:LLVMConstFPCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSelect(ConstantCondition, ConstantIfTrue, ConstantIfFalse)
    @apicall(:LLVMConstSelect, LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), ConstantCondition, ConstantIfTrue, ConstantIfFalse)
end

function LLVMConstExtractElement(VectorConstant, IndexConstant)
    @apicall(:LLVMConstExtractElement, LLVMValueRef, (LLVMValueRef, LLVMValueRef), VectorConstant, IndexConstant)
end

function LLVMConstInsertElement(VectorConstant, ElementValueConstant, IndexConstant)
    @apicall(:LLVMConstInsertElement, LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), VectorConstant, ElementValueConstant, IndexConstant)
end

function LLVMConstShuffleVector(VectorAConstant, VectorBConstant, MaskConstant)
    @apicall(:LLVMConstShuffleVector, LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), VectorAConstant, VectorBConstant, MaskConstant)
end

function LLVMConstExtractValue(AggConstant, IdxList, NumIdx)
    @apicall(:LLVMConstExtractValue, LLVMValueRef, (LLVMValueRef, Ptr{UInt32}, UInt32), AggConstant, IdxList, NumIdx)
end

function LLVMConstInsertValue(AggConstant, ElementValueConstant, IdxList, NumIdx)
    @apicall(:LLVMConstInsertValue, LLVMValueRef, (LLVMValueRef, LLVMValueRef, Ptr{UInt32}, UInt32), AggConstant, ElementValueConstant, IdxList, NumIdx)
end

function LLVMBlockAddress(F, BB)
    @apicall(:LLVMBlockAddress, LLVMValueRef, (LLVMValueRef, LLVMBasicBlockRef), F, BB)
end

function LLVMConstInlineAsm(Ty, AsmString, Constraints, HasSideEffects, IsAlignStack)
    @apicall(:LLVMConstInlineAsm, LLVMValueRef, (LLVMTypeRef, Cstring, Cstring, LLVMBool, LLVMBool), Ty, AsmString, Constraints, HasSideEffects, IsAlignStack)
end

function LLVMGetGlobalParent(Global)
    @apicall(:LLVMGetGlobalParent, LLVMModuleRef, (LLVMValueRef,), Global)
end

function LLVMIsDeclaration(Global)
    @apicall(:LLVMIsDeclaration, LLVMBool, (LLVMValueRef,), Global)
end

function LLVMGetLinkage(Global)
    @apicall(:LLVMGetLinkage, LLVMLinkage, (LLVMValueRef,), Global)
end

function LLVMSetLinkage(Global, Linkage)
    @apicall(:LLVMSetLinkage, Cvoid, (LLVMValueRef, LLVMLinkage), Global, Linkage)
end

function LLVMGetSection(Global)
    @apicall(:LLVMGetSection, Cstring, (LLVMValueRef,), Global)
end

function LLVMSetSection(Global, Section)
    @apicall(:LLVMSetSection, Cvoid, (LLVMValueRef, Cstring), Global, Section)
end

function LLVMGetVisibility(Global)
    @apicall(:LLVMGetVisibility, LLVMVisibility, (LLVMValueRef,), Global)
end

function LLVMSetVisibility(Global, Viz)
    @apicall(:LLVMSetVisibility, Cvoid, (LLVMValueRef, LLVMVisibility), Global, Viz)
end

function LLVMGetDLLStorageClass(Global)
    @apicall(:LLVMGetDLLStorageClass, LLVMDLLStorageClass, (LLVMValueRef,), Global)
end

function LLVMSetDLLStorageClass(Global, Class)
    @apicall(:LLVMSetDLLStorageClass, Cvoid, (LLVMValueRef, LLVMDLLStorageClass), Global, Class)
end

function LLVMGetUnnamedAddress(Global)
    @apicall(:LLVMGetUnnamedAddress, LLVMUnnamedAddr, (LLVMValueRef,), Global)
end

function LLVMSetUnnamedAddress(Global, UnnamedAddr)
    @apicall(:LLVMSetUnnamedAddress, Cvoid, (LLVMValueRef, LLVMUnnamedAddr), Global, UnnamedAddr)
end

function LLVMGlobalGetValueType(Global)
    @apicall(:LLVMGlobalGetValueType, LLVMTypeRef, (LLVMValueRef,), Global)
end

function LLVMHasUnnamedAddr(Global)
    @apicall(:LLVMHasUnnamedAddr, LLVMBool, (LLVMValueRef,), Global)
end

function LLVMSetUnnamedAddr(Global, HasUnnamedAddr)
    @apicall(:LLVMSetUnnamedAddr, Cvoid, (LLVMValueRef, LLVMBool), Global, HasUnnamedAddr)
end

function LLVMGetAlignment(V)
    @apicall(:LLVMGetAlignment, UInt32, (LLVMValueRef,), V)
end

function LLVMSetAlignment(V, Bytes)
    @apicall(:LLVMSetAlignment, Cvoid, (LLVMValueRef, UInt32), V, Bytes)
end

function LLVMGlobalSetMetadata(Global, Kind, MD)
    @apicall(:LLVMGlobalSetMetadata, Cvoid, (LLVMValueRef, UInt32, LLVMMetadataRef), Global, Kind, MD)
end

function LLVMGlobalEraseMetadata(Global, Kind)
    @apicall(:LLVMGlobalEraseMetadata, Cvoid, (LLVMValueRef, UInt32), Global, Kind)
end

function LLVMGlobalClearMetadata(Global)
    @apicall(:LLVMGlobalClearMetadata, Cvoid, (LLVMValueRef,), Global)
end

function LLVMGlobalCopyAllMetadata(Value, NumEntries)
    @apicall(:LLVMGlobalCopyAllMetadata, Ptr{LLVMValueMetadataEntry}, (LLVMValueRef, Ptr{Csize_t}), Value, NumEntries)
end

function LLVMDisposeValueMetadataEntries(Entries)
    @apicall(:LLVMDisposeValueMetadataEntries, Cvoid, (Ptr{LLVMValueMetadataEntry},), Entries)
end

function LLVMValueMetadataEntriesGetKind(Entries, Index)
    @apicall(:LLVMValueMetadataEntriesGetKind, UInt32, (Ptr{LLVMValueMetadataEntry}, UInt32), Entries, Index)
end

function LLVMValueMetadataEntriesGetMetadata(Entries, Index)
    @apicall(:LLVMValueMetadataEntriesGetMetadata, LLVMMetadataRef, (Ptr{LLVMValueMetadataEntry}, UInt32), Entries, Index)
end

function LLVMAddGlobal(M, Ty, Name)
    @apicall(:LLVMAddGlobal, LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, Cstring), M, Ty, Name)
end

function LLVMAddGlobalInAddressSpace(M, Ty, Name, AddressSpace)
    @apicall(:LLVMAddGlobalInAddressSpace, LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, Cstring, UInt32), M, Ty, Name, AddressSpace)
end

function LLVMGetNamedGlobal(M, Name)
    @apicall(:LLVMGetNamedGlobal, LLVMValueRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetFirstGlobal(M)
    @apicall(:LLVMGetFirstGlobal, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastGlobal(M)
    @apicall(:LLVMGetLastGlobal, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextGlobal(GlobalVar)
    @apicall(:LLVMGetNextGlobal, LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMGetPreviousGlobal(GlobalVar)
    @apicall(:LLVMGetPreviousGlobal, LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMDeleteGlobal(GlobalVar)
    @apicall(:LLVMDeleteGlobal, Cvoid, (LLVMValueRef,), GlobalVar)
end

function LLVMGetInitializer(GlobalVar)
    @apicall(:LLVMGetInitializer, LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMSetInitializer(GlobalVar, ConstantVal)
    @apicall(:LLVMSetInitializer, Cvoid, (LLVMValueRef, LLVMValueRef), GlobalVar, ConstantVal)
end

function LLVMIsThreadLocal(GlobalVar)
    @apicall(:LLVMIsThreadLocal, LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetThreadLocal(GlobalVar, IsThreadLocal)
    @apicall(:LLVMSetThreadLocal, Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsThreadLocal)
end

function LLVMIsGlobalConstant(GlobalVar)
    @apicall(:LLVMIsGlobalConstant, LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetGlobalConstant(GlobalVar, IsConstant)
    @apicall(:LLVMSetGlobalConstant, Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsConstant)
end

function LLVMGetThreadLocalMode(GlobalVar)
    @apicall(:LLVMGetThreadLocalMode, LLVMThreadLocalMode, (LLVMValueRef,), GlobalVar)
end

function LLVMSetThreadLocalMode(GlobalVar, Mode)
    @apicall(:LLVMSetThreadLocalMode, Cvoid, (LLVMValueRef, LLVMThreadLocalMode), GlobalVar, Mode)
end

function LLVMIsExternallyInitialized(GlobalVar)
    @apicall(:LLVMIsExternallyInitialized, LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetExternallyInitialized(GlobalVar, IsExtInit)
    @apicall(:LLVMSetExternallyInitialized, Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsExtInit)
end

function LLVMAddAlias(M, Ty, Aliasee, Name)
    @apicall(:LLVMAddAlias, LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, LLVMValueRef, Cstring), M, Ty, Aliasee, Name)
end

function LLVMGetNamedGlobalAlias(M, Name, NameLen)
    @apicall(:LLVMGetNamedGlobalAlias, LLVMValueRef, (LLVMModuleRef, Cstring, Csize_t), M, Name, NameLen)
end

function LLVMGetFirstGlobalAlias(M)
    @apicall(:LLVMGetFirstGlobalAlias, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastGlobalAlias(M)
    @apicall(:LLVMGetLastGlobalAlias, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextGlobalAlias(GA)
    @apicall(:LLVMGetNextGlobalAlias, LLVMValueRef, (LLVMValueRef,), GA)
end

function LLVMGetPreviousGlobalAlias(GA)
    @apicall(:LLVMGetPreviousGlobalAlias, LLVMValueRef, (LLVMValueRef,), GA)
end

function LLVMAliasGetAliasee(Alias)
    @apicall(:LLVMAliasGetAliasee, LLVMValueRef, (LLVMValueRef,), Alias)
end

function LLVMAliasSetAliasee(Alias, Aliasee)
    @apicall(:LLVMAliasSetAliasee, Cvoid, (LLVMValueRef, LLVMValueRef), Alias, Aliasee)
end

function LLVMDeleteFunction(Fn)
    @apicall(:LLVMDeleteFunction, Cvoid, (LLVMValueRef,), Fn)
end

function LLVMHasPersonalityFn(Fn)
    @apicall(:LLVMHasPersonalityFn, LLVMBool, (LLVMValueRef,), Fn)
end

function LLVMGetPersonalityFn(Fn)
    @apicall(:LLVMGetPersonalityFn, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMSetPersonalityFn(Fn, PersonalityFn)
    @apicall(:LLVMSetPersonalityFn, Cvoid, (LLVMValueRef, LLVMValueRef), Fn, PersonalityFn)
end

function LLVMGetIntrinsicID(Fn)
    @apicall(:LLVMGetIntrinsicID, UInt32, (LLVMValueRef,), Fn)
end

function LLVMGetIntrinsicDeclaration(Mod, ID, ParamTypes, ParamCount)
    @apicall(:LLVMGetIntrinsicDeclaration, LLVMValueRef, (LLVMModuleRef, UInt32, Ptr{LLVMTypeRef}, Csize_t), Mod, ID, ParamTypes, ParamCount)
end

function LLVMIntrinsicGetType(Ctx, ID, ParamTypes, ParamCount)
    @apicall(:LLVMIntrinsicGetType, LLVMTypeRef, (LLVMContextRef, UInt32, Ptr{LLVMTypeRef}, Csize_t), Ctx, ID, ParamTypes, ParamCount)
end

function LLVMIntrinsicGetName(ID, NameLength)
    @apicall(:LLVMIntrinsicGetName, Cstring, (UInt32, Ptr{Csize_t}), ID, NameLength)
end

function LLVMIntrinsicCopyOverloadedName(ID, ParamTypes, ParamCount, NameLength)
    @apicall(:LLVMIntrinsicCopyOverloadedName, Cstring, (UInt32, Ptr{LLVMTypeRef}, Csize_t, Ptr{Csize_t}), ID, ParamTypes, ParamCount, NameLength)
end

function LLVMIntrinsicIsOverloaded(ID)
    @apicall(:LLVMIntrinsicIsOverloaded, LLVMBool, (UInt32,), ID)
end

function LLVMGetFunctionCallConv(Fn)
    @apicall(:LLVMGetFunctionCallConv, UInt32, (LLVMValueRef,), Fn)
end

function LLVMSetFunctionCallConv(Fn, CC)
    @apicall(:LLVMSetFunctionCallConv, Cvoid, (LLVMValueRef, UInt32), Fn, CC)
end

function LLVMGetGC(Fn)
    @apicall(:LLVMGetGC, Cstring, (LLVMValueRef,), Fn)
end

function LLVMSetGC(Fn, Name)
    @apicall(:LLVMSetGC, Cvoid, (LLVMValueRef, Cstring), Fn, Name)
end

function LLVMAddAttributeAtIndex(F, Idx, A)
    @apicall(:LLVMAddAttributeAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, LLVMAttributeRef), F, Idx, A)
end

function LLVMGetAttributeCountAtIndex(F, Idx)
    @apicall(:LLVMGetAttributeCountAtIndex, UInt32, (LLVMValueRef, LLVMAttributeIndex), F, Idx)
end

function LLVMGetAttributesAtIndex(F, Idx, Attrs)
    @apicall(:LLVMGetAttributesAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Ptr{LLVMAttributeRef}), F, Idx, Attrs)
end

function LLVMGetEnumAttributeAtIndex(F, Idx, KindID)
    @apicall(:LLVMGetEnumAttributeAtIndex, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, UInt32), F, Idx, KindID)
end

function LLVMGetStringAttributeAtIndex(F, Idx, K, KLen)
    @apicall(:LLVMGetStringAttributeAtIndex, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), F, Idx, K, KLen)
end

function LLVMRemoveEnumAttributeAtIndex(F, Idx, KindID)
    @apicall(:LLVMRemoveEnumAttributeAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, UInt32), F, Idx, KindID)
end

function LLVMRemoveStringAttributeAtIndex(F, Idx, K, KLen)
    @apicall(:LLVMRemoveStringAttributeAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), F, Idx, K, KLen)
end

function LLVMAddTargetDependentFunctionAttr(Fn, A, V)
    @apicall(:LLVMAddTargetDependentFunctionAttr, Cvoid, (LLVMValueRef, Cstring, Cstring), Fn, A, V)
end

function LLVMCountParams(Fn)
    @apicall(:LLVMCountParams, UInt32, (LLVMValueRef,), Fn)
end

function LLVMGetParams(Fn, Params)
    @apicall(:LLVMGetParams, Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}), Fn, Params)
end

function LLVMGetParam(Fn, Index)
    @apicall(:LLVMGetParam, LLVMValueRef, (LLVMValueRef, UInt32), Fn, Index)
end

function LLVMGetParamParent(Inst)
    @apicall(:LLVMGetParamParent, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetFirstParam(Fn)
    @apicall(:LLVMGetFirstParam, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetLastParam(Fn)
    @apicall(:LLVMGetLastParam, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetNextParam(Arg)
    @apicall(:LLVMGetNextParam, LLVMValueRef, (LLVMValueRef,), Arg)
end

function LLVMGetPreviousParam(Arg)
    @apicall(:LLVMGetPreviousParam, LLVMValueRef, (LLVMValueRef,), Arg)
end

function LLVMSetParamAlignment(Arg, Align)
    @apicall(:LLVMSetParamAlignment, Cvoid, (LLVMValueRef, UInt32), Arg, Align)
end

function LLVMMDStringInContext(C, Str, SLen)
    @apicall(:LLVMMDStringInContext, LLVMValueRef, (LLVMContextRef, Cstring, UInt32), C, Str, SLen)
end

function LLVMMDString(Str, SLen)
    @apicall(:LLVMMDString, LLVMValueRef, (Cstring, UInt32), Str, SLen)
end

function LLVMMDNodeInContext(C, Vals, Count)
    @apicall(:LLVMMDNodeInContext, LLVMValueRef, (LLVMContextRef, Ptr{LLVMValueRef}, UInt32), C, Vals, Count)
end

function LLVMMDNode(Vals, Count)
    @apicall(:LLVMMDNode, LLVMValueRef, (Ptr{LLVMValueRef}, UInt32), Vals, Count)
end

function LLVMMetadataAsValue(C, MD)
    @apicall(:LLVMMetadataAsValue, LLVMValueRef, (LLVMContextRef, LLVMMetadataRef), C, MD)
end

function LLVMValueAsMetadata(Val)
    @apicall(:LLVMValueAsMetadata, LLVMMetadataRef, (LLVMValueRef,), Val)
end

function LLVMGetMDString(V, Length)
    @apicall(:LLVMGetMDString, Cstring, (LLVMValueRef, Ptr{UInt32}), V, Length)
end

function LLVMGetMDNodeNumOperands(V)
    @apicall(:LLVMGetMDNodeNumOperands, UInt32, (LLVMValueRef,), V)
end

function LLVMGetMDNodeOperands(V, Dest)
    @apicall(:LLVMGetMDNodeOperands, Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}), V, Dest)
end

function LLVMBasicBlockAsValue(BB)
    @apicall(:LLVMBasicBlockAsValue, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMValueIsBasicBlock(Val)
    @apicall(:LLVMValueIsBasicBlock, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMValueAsBasicBlock(Val)
    @apicall(:LLVMValueAsBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Val)
end

function LLVMGetBasicBlockName(BB)
    @apicall(:LLVMGetBasicBlockName, Cstring, (LLVMBasicBlockRef,), BB)
end

function LLVMGetBasicBlockParent(BB)
    @apicall(:LLVMGetBasicBlockParent, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetBasicBlockTerminator(BB)
    @apicall(:LLVMGetBasicBlockTerminator, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMCountBasicBlocks(Fn)
    @apicall(:LLVMCountBasicBlocks, UInt32, (LLVMValueRef,), Fn)
end

function LLVMGetBasicBlocks(Fn, BasicBlocks)
    @apicall(:LLVMGetBasicBlocks, Cvoid, (LLVMValueRef, Ptr{LLVMBasicBlockRef}), Fn, BasicBlocks)
end

function LLVMGetFirstBasicBlock(Fn)
    @apicall(:LLVMGetFirstBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

function LLVMGetLastBasicBlock(Fn)
    @apicall(:LLVMGetLastBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

function LLVMGetNextBasicBlock(BB)
    @apicall(:LLVMGetNextBasicBlock, LLVMBasicBlockRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetPreviousBasicBlock(BB)
    @apicall(:LLVMGetPreviousBasicBlock, LLVMBasicBlockRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetEntryBasicBlock(Fn)
    @apicall(:LLVMGetEntryBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

function LLVMCreateBasicBlockInContext(C, Name)
    @apicall(:LLVMCreateBasicBlockInContext, LLVMBasicBlockRef, (LLVMContextRef, Cstring), C, Name)
end

function LLVMAppendBasicBlockInContext(C, Fn, Name)
    @apicall(:LLVMAppendBasicBlockInContext, LLVMBasicBlockRef, (LLVMContextRef, LLVMValueRef, Cstring), C, Fn, Name)
end

function LLVMAppendBasicBlock(Fn, Name)
    @apicall(:LLVMAppendBasicBlock, LLVMBasicBlockRef, (LLVMValueRef, Cstring), Fn, Name)
end

function LLVMInsertBasicBlockInContext(C, BB, Name)
    @apicall(:LLVMInsertBasicBlockInContext, LLVMBasicBlockRef, (LLVMContextRef, LLVMBasicBlockRef, Cstring), C, BB, Name)
end

function LLVMInsertBasicBlock(InsertBeforeBB, Name)
    @apicall(:LLVMInsertBasicBlock, LLVMBasicBlockRef, (LLVMBasicBlockRef, Cstring), InsertBeforeBB, Name)
end

function LLVMDeleteBasicBlock(BB)
    @apicall(:LLVMDeleteBasicBlock, Cvoid, (LLVMBasicBlockRef,), BB)
end

function LLVMRemoveBasicBlockFromParent(BB)
    @apicall(:LLVMRemoveBasicBlockFromParent, Cvoid, (LLVMBasicBlockRef,), BB)
end

function LLVMMoveBasicBlockBefore(BB, MovePos)
    @apicall(:LLVMMoveBasicBlockBefore, Cvoid, (LLVMBasicBlockRef, LLVMBasicBlockRef), BB, MovePos)
end

function LLVMMoveBasicBlockAfter(BB, MovePos)
    @apicall(:LLVMMoveBasicBlockAfter, Cvoid, (LLVMBasicBlockRef, LLVMBasicBlockRef), BB, MovePos)
end

function LLVMGetFirstInstruction(BB)
    @apicall(:LLVMGetFirstInstruction, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetLastInstruction(BB)
    @apicall(:LLVMGetLastInstruction, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMHasMetadata(Val)
    @apicall(:LLVMHasMetadata, Cint, (LLVMValueRef,), Val)
end

function LLVMGetMetadata(Val, KindID)
    @apicall(:LLVMGetMetadata, LLVMValueRef, (LLVMValueRef, UInt32), Val, KindID)
end

function LLVMSetMetadata(Val, KindID, Node)
    @apicall(:LLVMSetMetadata, Cvoid, (LLVMValueRef, UInt32, LLVMValueRef), Val, KindID, Node)
end

function LLVMInstructionGetAllMetadataOtherThanDebugLoc(Instr, NumEntries)
    @apicall(:LLVMInstructionGetAllMetadataOtherThanDebugLoc, Ptr{LLVMValueMetadataEntry}, (LLVMValueRef, Ptr{Csize_t}), Instr, NumEntries)
end

function LLVMGetInstructionParent(Inst)
    @apicall(:LLVMGetInstructionParent, LLVMBasicBlockRef, (LLVMValueRef,), Inst)
end

function LLVMGetNextInstruction(Inst)
    @apicall(:LLVMGetNextInstruction, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetPreviousInstruction(Inst)
    @apicall(:LLVMGetPreviousInstruction, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMInstructionRemoveFromParent(Inst)
    @apicall(:LLVMInstructionRemoveFromParent, Cvoid, (LLVMValueRef,), Inst)
end

function LLVMInstructionEraseFromParent(Inst)
    @apicall(:LLVMInstructionEraseFromParent, Cvoid, (LLVMValueRef,), Inst)
end

function LLVMGetInstructionOpcode(Inst)
    @apicall(:LLVMGetInstructionOpcode, LLVMOpcode, (LLVMValueRef,), Inst)
end

function LLVMGetICmpPredicate(Inst)
    @apicall(:LLVMGetICmpPredicate, LLVMIntPredicate, (LLVMValueRef,), Inst)
end

function LLVMGetFCmpPredicate(Inst)
    @apicall(:LLVMGetFCmpPredicate, LLVMRealPredicate, (LLVMValueRef,), Inst)
end

function LLVMInstructionClone(Inst)
    @apicall(:LLVMInstructionClone, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMIsATerminatorInst(Inst)
    @apicall(:LLVMIsATerminatorInst, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetNumArgOperands(Instr)
    @apicall(:LLVMGetNumArgOperands, UInt32, (LLVMValueRef,), Instr)
end

function LLVMSetInstructionCallConv(Instr, CC)
    @apicall(:LLVMSetInstructionCallConv, Cvoid, (LLVMValueRef, UInt32), Instr, CC)
end

function LLVMGetInstructionCallConv(Instr)
    @apicall(:LLVMGetInstructionCallConv, UInt32, (LLVMValueRef,), Instr)
end

function LLVMSetInstrParamAlignment(Instr, index, Align)
    @apicall(:LLVMSetInstrParamAlignment, Cvoid, (LLVMValueRef, UInt32, UInt32), Instr, index, Align)
end

function LLVMAddCallSiteAttribute(C, Idx, A)
    @apicall(:LLVMAddCallSiteAttribute, Cvoid, (LLVMValueRef, LLVMAttributeIndex, LLVMAttributeRef), C, Idx, A)
end

function LLVMGetCallSiteAttributeCount(C, Idx)
    @apicall(:LLVMGetCallSiteAttributeCount, UInt32, (LLVMValueRef, LLVMAttributeIndex), C, Idx)
end

function LLVMGetCallSiteAttributes(C, Idx, Attrs)
    @apicall(:LLVMGetCallSiteAttributes, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Ptr{LLVMAttributeRef}), C, Idx, Attrs)
end

function LLVMGetCallSiteEnumAttribute(C, Idx, KindID)
    @apicall(:LLVMGetCallSiteEnumAttribute, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, UInt32), C, Idx, KindID)
end

function LLVMGetCallSiteStringAttribute(C, Idx, K, KLen)
    @apicall(:LLVMGetCallSiteStringAttribute, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), C, Idx, K, KLen)
end

function LLVMRemoveCallSiteEnumAttribute(C, Idx, KindID)
    @apicall(:LLVMRemoveCallSiteEnumAttribute, Cvoid, (LLVMValueRef, LLVMAttributeIndex, UInt32), C, Idx, KindID)
end

function LLVMRemoveCallSiteStringAttribute(C, Idx, K, KLen)
    @apicall(:LLVMRemoveCallSiteStringAttribute, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), C, Idx, K, KLen)
end

function LLVMGetCalledFunctionType(C)
    @apicall(:LLVMGetCalledFunctionType, LLVMTypeRef, (LLVMValueRef,), C)
end

function LLVMGetCalledValue(Instr)
    @apicall(:LLVMGetCalledValue, LLVMValueRef, (LLVMValueRef,), Instr)
end

function LLVMIsTailCall(CallInst)
    @apicall(:LLVMIsTailCall, LLVMBool, (LLVMValueRef,), CallInst)
end

function LLVMSetTailCall(CallInst, IsTailCall)
    @apicall(:LLVMSetTailCall, Cvoid, (LLVMValueRef, LLVMBool), CallInst, IsTailCall)
end

function LLVMGetNormalDest(InvokeInst)
    @apicall(:LLVMGetNormalDest, LLVMBasicBlockRef, (LLVMValueRef,), InvokeInst)
end

function LLVMGetUnwindDest(InvokeInst)
    @apicall(:LLVMGetUnwindDest, LLVMBasicBlockRef, (LLVMValueRef,), InvokeInst)
end

function LLVMSetNormalDest(InvokeInst, B)
    @apicall(:LLVMSetNormalDest, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), InvokeInst, B)
end

function LLVMSetUnwindDest(InvokeInst, B)
    @apicall(:LLVMSetUnwindDest, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), InvokeInst, B)
end

function LLVMGetNumSuccessors(Term)
    @apicall(:LLVMGetNumSuccessors, UInt32, (LLVMValueRef,), Term)
end

function LLVMGetSuccessor(Term, i)
    @apicall(:LLVMGetSuccessor, LLVMBasicBlockRef, (LLVMValueRef, UInt32), Term, i)
end

function LLVMSetSuccessor(Term, i, block)
    @apicall(:LLVMSetSuccessor, Cvoid, (LLVMValueRef, UInt32, LLVMBasicBlockRef), Term, i, block)
end

function LLVMIsConditional(Branch)
    @apicall(:LLVMIsConditional, LLVMBool, (LLVMValueRef,), Branch)
end

function LLVMGetCondition(Branch)
    @apicall(:LLVMGetCondition, LLVMValueRef, (LLVMValueRef,), Branch)
end

function LLVMSetCondition(Branch, Cond)
    @apicall(:LLVMSetCondition, Cvoid, (LLVMValueRef, LLVMValueRef), Branch, Cond)
end

function LLVMGetSwitchDefaultDest(SwitchInstr)
    @apicall(:LLVMGetSwitchDefaultDest, LLVMBasicBlockRef, (LLVMValueRef,), SwitchInstr)
end

function LLVMGetAllocatedType(Alloca)
    @apicall(:LLVMGetAllocatedType, LLVMTypeRef, (LLVMValueRef,), Alloca)
end

function LLVMIsInBounds(GEP)
    @apicall(:LLVMIsInBounds, LLVMBool, (LLVMValueRef,), GEP)
end

function LLVMSetIsInBounds(GEP, InBounds)
    @apicall(:LLVMSetIsInBounds, Cvoid, (LLVMValueRef, LLVMBool), GEP, InBounds)
end

function LLVMAddIncoming(PhiNode, IncomingValues, IncomingBlocks, Count)
    @apicall(:LLVMAddIncoming, Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}, Ptr{LLVMBasicBlockRef}, UInt32), PhiNode, IncomingValues, IncomingBlocks, Count)
end

function LLVMCountIncoming(PhiNode)
    @apicall(:LLVMCountIncoming, UInt32, (LLVMValueRef,), PhiNode)
end

function LLVMGetIncomingValue(PhiNode, Index)
    @apicall(:LLVMGetIncomingValue, LLVMValueRef, (LLVMValueRef, UInt32), PhiNode, Index)
end

function LLVMGetIncomingBlock(PhiNode, Index)
    @apicall(:LLVMGetIncomingBlock, LLVMBasicBlockRef, (LLVMValueRef, UInt32), PhiNode, Index)
end

function LLVMGetNumIndices(Inst)
    @apicall(:LLVMGetNumIndices, UInt32, (LLVMValueRef,), Inst)
end

function LLVMGetIndices(Inst)
    @apicall(:LLVMGetIndices, Ptr{UInt32}, (LLVMValueRef,), Inst)
end

function LLVMCreateBuilderInContext(C)
    @apicall(:LLVMCreateBuilderInContext, LLVMBuilderRef, (LLVMContextRef,), C)
end

function LLVMCreateBuilder()
    @apicall(:LLVMCreateBuilder, LLVMBuilderRef, ())
end

function LLVMPositionBuilder(Builder, Block, Instr)
    @apicall(:LLVMPositionBuilder, Cvoid, (LLVMBuilderRef, LLVMBasicBlockRef, LLVMValueRef), Builder, Block, Instr)
end

function LLVMPositionBuilderBefore(Builder, Instr)
    @apicall(:LLVMPositionBuilderBefore, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Instr)
end

function LLVMPositionBuilderAtEnd(Builder, Block)
    @apicall(:LLVMPositionBuilderAtEnd, Cvoid, (LLVMBuilderRef, LLVMBasicBlockRef), Builder, Block)
end

function LLVMGetInsertBlock(Builder)
    @apicall(:LLVMGetInsertBlock, LLVMBasicBlockRef, (LLVMBuilderRef,), Builder)
end

function LLVMClearInsertionPosition(Builder)
    @apicall(:LLVMClearInsertionPosition, Cvoid, (LLVMBuilderRef,), Builder)
end

function LLVMInsertIntoBuilder(Builder, Instr)
    @apicall(:LLVMInsertIntoBuilder, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Instr)
end

function LLVMInsertIntoBuilderWithName(Builder, Instr, Name)
    @apicall(:LLVMInsertIntoBuilderWithName, Cvoid, (LLVMBuilderRef, LLVMValueRef, Cstring), Builder, Instr, Name)
end

function LLVMDisposeBuilder(Builder)
    @apicall(:LLVMDisposeBuilder, Cvoid, (LLVMBuilderRef,), Builder)
end

function LLVMSetCurrentDebugLocation(Builder, L)
    @apicall(:LLVMSetCurrentDebugLocation, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, L)
end

function LLVMGetCurrentDebugLocation(Builder)
    @apicall(:LLVMGetCurrentDebugLocation, LLVMValueRef, (LLVMBuilderRef,), Builder)
end

function LLVMSetInstDebugLocation(Builder, Inst)
    @apicall(:LLVMSetInstDebugLocation, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Inst)
end

function LLVMBuildRetVoid(arg1)
    @apicall(:LLVMBuildRetVoid, LLVMValueRef, (LLVMBuilderRef,), arg1)
end

function LLVMBuildRet(arg1, V)
    @apicall(:LLVMBuildRet, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), arg1, V)
end

function LLVMBuildAggregateRet(arg1, RetVals, N)
    @apicall(:LLVMBuildAggregateRet, LLVMValueRef, (LLVMBuilderRef, Ptr{LLVMValueRef}, UInt32), arg1, RetVals, N)
end

function LLVMBuildBr(arg1, Dest)
    @apicall(:LLVMBuildBr, LLVMValueRef, (LLVMBuilderRef, LLVMBasicBlockRef), arg1, Dest)
end

function LLVMBuildCondBr(arg1, If, Then, Else)
    @apicall(:LLVMBuildCondBr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, LLVMBasicBlockRef), arg1, If, Then, Else)
end

function LLVMBuildSwitch(arg1, V, Else, NumCases)
    @apicall(:LLVMBuildSwitch, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, UInt32), arg1, V, Else, NumCases)
end

function LLVMBuildIndirectBr(B, Addr, NumDests)
    @apicall(:LLVMBuildIndirectBr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32), B, Addr, NumDests)
end

function LLVMBuildInvoke(arg1, Fn, Args, NumArgs, Then, Catch, Name)
    @apicall(:LLVMBuildInvoke, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, LLVMBasicBlockRef, LLVMBasicBlockRef, Cstring), arg1, Fn, Args, NumArgs, Then, Catch, Name)
end

function LLVMBuildInvoke2(arg1, Ty, Fn, Args, NumArgs, Then, Catch, Name)
    @apicall(:LLVMBuildInvoke2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, LLVMBasicBlockRef, LLVMBasicBlockRef, Cstring), arg1, Ty, Fn, Args, NumArgs, Then, Catch, Name)
end

function LLVMBuildUnreachable(arg1)
    @apicall(:LLVMBuildUnreachable, LLVMValueRef, (LLVMBuilderRef,), arg1)
end

function LLVMBuildResume(B, Exn)
    @apicall(:LLVMBuildResume, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), B, Exn)
end

function LLVMBuildLandingPad(B, Ty, PersFn, NumClauses, Name)
    @apicall(:LLVMBuildLandingPad, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, UInt32, Cstring), B, Ty, PersFn, NumClauses, Name)
end

function LLVMBuildCleanupRet(B, CatchPad, BB)
    @apicall(:LLVMBuildCleanupRet, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef), B, CatchPad, BB)
end

function LLVMBuildCatchRet(B, CatchPad, BB)
    @apicall(:LLVMBuildCatchRet, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef), B, CatchPad, BB)
end

function LLVMBuildCatchPad(B, ParentPad, Args, NumArgs, Name)
    @apicall(:LLVMBuildCatchPad, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, ParentPad, Args, NumArgs, Name)
end

function LLVMBuildCleanupPad(B, ParentPad, Args, NumArgs, Name)
    @apicall(:LLVMBuildCleanupPad, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, ParentPad, Args, NumArgs, Name)
end

function LLVMBuildCatchSwitch(B, ParentPad, UnwindBB, NumHandlers, Name)
    @apicall(:LLVMBuildCatchSwitch, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, UInt32, Cstring), B, ParentPad, UnwindBB, NumHandlers, Name)
end

function LLVMAddCase(Switch, OnVal, Dest)
    @apicall(:LLVMAddCase, Cvoid, (LLVMValueRef, LLVMValueRef, LLVMBasicBlockRef), Switch, OnVal, Dest)
end

function LLVMAddDestination(IndirectBr, Dest)
    @apicall(:LLVMAddDestination, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), IndirectBr, Dest)
end

function LLVMGetNumClauses(LandingPad)
    @apicall(:LLVMGetNumClauses, UInt32, (LLVMValueRef,), LandingPad)
end

function LLVMGetClause(LandingPad, Idx)
    @apicall(:LLVMGetClause, LLVMValueRef, (LLVMValueRef, UInt32), LandingPad, Idx)
end

function LLVMAddClause(LandingPad, ClauseVal)
    @apicall(:LLVMAddClause, Cvoid, (LLVMValueRef, LLVMValueRef), LandingPad, ClauseVal)
end

function LLVMIsCleanup(LandingPad)
    @apicall(:LLVMIsCleanup, LLVMBool, (LLVMValueRef,), LandingPad)
end

function LLVMSetCleanup(LandingPad, Val)
    @apicall(:LLVMSetCleanup, Cvoid, (LLVMValueRef, LLVMBool), LandingPad, Val)
end

function LLVMAddHandler(CatchSwitch, Dest)
    @apicall(:LLVMAddHandler, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), CatchSwitch, Dest)
end

function LLVMGetNumHandlers(CatchSwitch)
    @apicall(:LLVMGetNumHandlers, UInt32, (LLVMValueRef,), CatchSwitch)
end

function LLVMGetHandlers(CatchSwitch, Handlers)
    @apicall(:LLVMGetHandlers, Cvoid, (LLVMValueRef, Ptr{LLVMBasicBlockRef}), CatchSwitch, Handlers)
end

function LLVMGetArgOperand(Funclet, i)
    @apicall(:LLVMGetArgOperand, LLVMValueRef, (LLVMValueRef, UInt32), Funclet, i)
end

function LLVMSetArgOperand(Funclet, i, value)
    @apicall(:LLVMSetArgOperand, Cvoid, (LLVMValueRef, UInt32, LLVMValueRef), Funclet, i, value)
end

function LLVMGetParentCatchSwitch(CatchPad)
    @apicall(:LLVMGetParentCatchSwitch, LLVMValueRef, (LLVMValueRef,), CatchPad)
end

function LLVMSetParentCatchSwitch(CatchPad, CatchSwitch)
    @apicall(:LLVMSetParentCatchSwitch, Cvoid, (LLVMValueRef, LLVMValueRef), CatchPad, CatchSwitch)
end

function LLVMBuildAdd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWAdd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNSWAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWAdd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNUWAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFAdd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSub(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWSub(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNSWSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWSub(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNUWSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFSub(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildMul(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWMul(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNSWMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWMul(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNUWMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFMul(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildUDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildUDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildExactUDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildExactUDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildSDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildExactSDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildExactSDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildURem(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildURem, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSRem(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildSRem, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFRem(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFRem, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildShl(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildShl, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildLShr(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildLShr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildAShr(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildAShr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildAnd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildAnd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildOr(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildOr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildXor(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildXor, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildBinOp(B, Op, LHS, RHS, Name)
    @apicall(:LLVMBuildBinOp, LLVMValueRef, (LLVMBuilderRef, LLVMOpcode, LLVMValueRef, LLVMValueRef, Cstring), B, Op, LHS, RHS, Name)
end

function LLVMBuildNeg(arg1, V, Name)
    @apicall(:LLVMBuildNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildNSWNeg(B, V, Name)
    @apicall(:LLVMBuildNSWNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), B, V, Name)
end

function LLVMBuildNUWNeg(B, V, Name)
    @apicall(:LLVMBuildNUWNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), B, V, Name)
end

function LLVMBuildFNeg(arg1, V, Name)
    @apicall(:LLVMBuildFNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildNot(arg1, V, Name)
    @apicall(:LLVMBuildNot, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildMalloc(arg1, Ty, Name)
    @apicall(:LLVMBuildMalloc, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildArrayMalloc(arg1, Ty, Val, Name)
    @apicall(:LLVMBuildArrayMalloc, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring), arg1, Ty, Val, Name)
end

function LLVMBuildMemSet(B, Ptr, Val, Len, Align)
    @apicall(:LLVMBuildMemSet, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, UInt32), B, Ptr, Val, Len, Align)
end

function LLVMBuildMemCpy(B, Dst, DstAlign, Src, SrcAlign, Size)
    @apicall(:LLVMBuildMemCpy, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32, LLVMValueRef, UInt32, LLVMValueRef), B, Dst, DstAlign, Src, SrcAlign, Size)
end

function LLVMBuildMemMove(B, Dst, DstAlign, Src, SrcAlign, Size)
    @apicall(:LLVMBuildMemMove, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32, LLVMValueRef, UInt32, LLVMValueRef), B, Dst, DstAlign, Src, SrcAlign, Size)
end

function LLVMBuildAlloca(arg1, Ty, Name)
    @apicall(:LLVMBuildAlloca, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildArrayAlloca(arg1, Ty, Val, Name)
    @apicall(:LLVMBuildArrayAlloca, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring), arg1, Ty, Val, Name)
end

function LLVMBuildFree(arg1, PointerVal)
    @apicall(:LLVMBuildFree, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), arg1, PointerVal)
end

function LLVMBuildLoad(arg1, PointerVal, Name)
    @apicall(:LLVMBuildLoad, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, PointerVal, Name)
end

function LLVMBuildLoad2(arg1, Ty, PointerVal, Name)
    @apicall(:LLVMBuildLoad2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring), arg1, Ty, PointerVal, Name)
end

function LLVMBuildStore(arg1, Val, Ptr)
    @apicall(:LLVMBuildStore, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef), arg1, Val, Ptr)
end

function LLVMBuildGEP(B, Pointer, Indices, NumIndices, Name)
    @apicall(:LLVMBuildGEP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildInBoundsGEP(B, Pointer, Indices, NumIndices, Name)
    @apicall(:LLVMBuildInBoundsGEP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildStructGEP(B, Pointer, Idx, Name)
    @apicall(:LLVMBuildStructGEP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32, Cstring), B, Pointer, Idx, Name)
end

function LLVMBuildGEP2(B, Ty, Pointer, Indices, NumIndices, Name)
    @apicall(:LLVMBuildGEP2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, Ty, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildInBoundsGEP2(B, Ty, Pointer, Indices, NumIndices, Name)
    @apicall(:LLVMBuildInBoundsGEP2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, Ty, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildStructGEP2(B, Ty, Pointer, Idx, Name)
    @apicall(:LLVMBuildStructGEP2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, UInt32, Cstring), B, Ty, Pointer, Idx, Name)
end

function LLVMBuildGlobalString(B, Str, Name)
    @apicall(:LLVMBuildGlobalString, LLVMValueRef, (LLVMBuilderRef, Cstring, Cstring), B, Str, Name)
end

function LLVMBuildGlobalStringPtr(B, Str, Name)
    @apicall(:LLVMBuildGlobalStringPtr, LLVMValueRef, (LLVMBuilderRef, Cstring, Cstring), B, Str, Name)
end

function LLVMGetVolatile(MemoryAccessInst)
    @apicall(:LLVMGetVolatile, LLVMBool, (LLVMValueRef,), MemoryAccessInst)
end

function LLVMSetVolatile(MemoryAccessInst, IsVolatile)
    @apicall(:LLVMSetVolatile, Cvoid, (LLVMValueRef, LLVMBool), MemoryAccessInst, IsVolatile)
end

function LLVMGetOrdering(MemoryAccessInst)
    @apicall(:LLVMGetOrdering, LLVMAtomicOrdering, (LLVMValueRef,), MemoryAccessInst)
end

function LLVMSetOrdering(MemoryAccessInst, Ordering)
    @apicall(:LLVMSetOrdering, Cvoid, (LLVMValueRef, LLVMAtomicOrdering), MemoryAccessInst, Ordering)
end

function LLVMBuildTrunc(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildTrunc, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildZExt(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildZExt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSExt(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildSExt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPToUI(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPToUI, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPToSI(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPToSI, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildUIToFP(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildUIToFP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSIToFP(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildSIToFP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPTrunc(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPTrunc, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPExt(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPExt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildPtrToInt(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildPtrToInt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildIntToPtr(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildIntToPtr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildBitCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildAddrSpaceCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildAddrSpaceCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildZExtOrBitCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildZExtOrBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSExtOrBitCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildSExtOrBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildTruncOrBitCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildTruncOrBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildCast(B, Op, Val, DestTy, Name)
    @apicall(:LLVMBuildCast, LLVMValueRef, (LLVMBuilderRef, LLVMOpcode, LLVMValueRef, LLVMTypeRef, Cstring), B, Op, Val, DestTy, Name)
end

function LLVMBuildPointerCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildPointerCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildIntCast2(arg1, Val, DestTy, IsSigned, Name)
    @apicall(:LLVMBuildIntCast2, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, LLVMBool, Cstring), arg1, Val, DestTy, IsSigned, Name)
end

function LLVMBuildFPCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildIntCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildIntCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildICmp(arg1, Op, LHS, RHS, Name)
    @apicall(:LLVMBuildICmp, LLVMValueRef, (LLVMBuilderRef, LLVMIntPredicate, LLVMValueRef, LLVMValueRef, Cstring), arg1, Op, LHS, RHS, Name)
end

function LLVMBuildFCmp(arg1, Op, LHS, RHS, Name)
    @apicall(:LLVMBuildFCmp, LLVMValueRef, (LLVMBuilderRef, LLVMRealPredicate, LLVMValueRef, LLVMValueRef, Cstring), arg1, Op, LHS, RHS, Name)
end

function LLVMBuildPhi(arg1, Ty, Name)
    @apicall(:LLVMBuildPhi, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildCall(arg1, Fn, Args, NumArgs, Name)
    @apicall(:LLVMBuildCall, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), arg1, Fn, Args, NumArgs, Name)
end

function LLVMBuildCall2(arg1, arg2, Fn, Args, NumArgs, Name)
    @apicall(:LLVMBuildCall2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), arg1, arg2, Fn, Args, NumArgs, Name)
end

function LLVMBuildSelect(arg1, If, Then, Else, Name)
    @apicall(:LLVMBuildSelect, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, If, Then, Else, Name)
end

function LLVMBuildVAArg(arg1, List, Ty, Name)
    @apicall(:LLVMBuildVAArg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, List, Ty, Name)
end

function LLVMBuildExtractElement(arg1, VecVal, Index, Name)
    @apicall(:LLVMBuildExtractElement, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, VecVal, Index, Name)
end

function LLVMBuildInsertElement(arg1, VecVal, EltVal, Index, Name)
    @apicall(:LLVMBuildInsertElement, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, VecVal, EltVal, Index, Name)
end

function LLVMBuildShuffleVector(arg1, V1, V2, Mask, Name)
    @apicall(:LLVMBuildShuffleVector, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, V1, V2, Mask, Name)
end

function LLVMBuildExtractValue(arg1, AggVal, Index, Name)
    @apicall(:LLVMBuildExtractValue, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32, Cstring), arg1, AggVal, Index, Name)
end

function LLVMBuildInsertValue(arg1, AggVal, EltVal, Index, Name)
    @apicall(:LLVMBuildInsertValue, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, UInt32, Cstring), arg1, AggVal, EltVal, Index, Name)
end

function LLVMBuildIsNull(arg1, Val, Name)
    @apicall(:LLVMBuildIsNull, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, Val, Name)
end

function LLVMBuildIsNotNull(arg1, Val, Name)
    @apicall(:LLVMBuildIsNotNull, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, Val, Name)
end

function LLVMBuildPtrDiff(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildPtrDiff, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFence(B, ordering, singleThread, Name)
    @apicall(:LLVMBuildFence, LLVMValueRef, (LLVMBuilderRef, LLVMAtomicOrdering, LLVMBool, Cstring), B, ordering, singleThread, Name)
end

function LLVMBuildAtomicRMW(B, op, PTR, Val, ordering, singleThread)
    @apicall(:LLVMBuildAtomicRMW, LLVMValueRef, (LLVMBuilderRef, LLVMAtomicRMWBinOp, LLVMValueRef, LLVMValueRef, LLVMAtomicOrdering, LLVMBool), B, op, PTR, Val, ordering, singleThread)
end

function LLVMBuildAtomicCmpXchg(B, Ptr, Cmp, New, SuccessOrdering, FailureOrdering, SingleThread)
    @apicall(:LLVMBuildAtomicCmpXchg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, LLVMAtomicOrdering, LLVMAtomicOrdering, LLVMBool), B, Ptr, Cmp, New, SuccessOrdering, FailureOrdering, SingleThread)
end

function LLVMIsAtomicSingleThread(AtomicInst)
    @apicall(:LLVMIsAtomicSingleThread, LLVMBool, (LLVMValueRef,), AtomicInst)
end

function LLVMSetAtomicSingleThread(AtomicInst, SingleThread)
    @apicall(:LLVMSetAtomicSingleThread, Cvoid, (LLVMValueRef, LLVMBool), AtomicInst, SingleThread)
end

function LLVMGetCmpXchgSuccessOrdering(CmpXchgInst)
    @apicall(:LLVMGetCmpXchgSuccessOrdering, LLVMAtomicOrdering, (LLVMValueRef,), CmpXchgInst)
end

function LLVMSetCmpXchgSuccessOrdering(CmpXchgInst, Ordering)
    @apicall(:LLVMSetCmpXchgSuccessOrdering, Cvoid, (LLVMValueRef, LLVMAtomicOrdering), CmpXchgInst, Ordering)
end

function LLVMGetCmpXchgFailureOrdering(CmpXchgInst)
    @apicall(:LLVMGetCmpXchgFailureOrdering, LLVMAtomicOrdering, (LLVMValueRef,), CmpXchgInst)
end

function LLVMSetCmpXchgFailureOrdering(CmpXchgInst, Ordering)
    @apicall(:LLVMSetCmpXchgFailureOrdering, Cvoid, (LLVMValueRef, LLVMAtomicOrdering), CmpXchgInst, Ordering)
end

function LLVMCreateModuleProviderForExistingModule(M)
    @apicall(:LLVMCreateModuleProviderForExistingModule, LLVMModuleProviderRef, (LLVMModuleRef,), M)
end

function LLVMDisposeModuleProvider(M)
    @apicall(:LLVMDisposeModuleProvider, Cvoid, (LLVMModuleProviderRef,), M)
end

function LLVMCreateMemoryBufferWithContentsOfFile(Path, OutMemBuf, OutMessage)
    @apicall(:LLVMCreateMemoryBufferWithContentsOfFile, LLVMBool, (Cstring, Ptr{LLVMMemoryBufferRef}, Ptr{Cstring}), Path, OutMemBuf, OutMessage)
end

function LLVMCreateMemoryBufferWithSTDIN(OutMemBuf, OutMessage)
    @apicall(:LLVMCreateMemoryBufferWithSTDIN, LLVMBool, (Ptr{LLVMMemoryBufferRef}, Ptr{Cstring}), OutMemBuf, OutMessage)
end

function LLVMCreateMemoryBufferWithMemoryRange(InputData, InputDataLength, BufferName, RequiresNullTerminator)
    @apicall(:LLVMCreateMemoryBufferWithMemoryRange, LLVMMemoryBufferRef, (Cstring, Csize_t, Cstring, LLVMBool), InputData, InputDataLength, BufferName, RequiresNullTerminator)
end

function LLVMCreateMemoryBufferWithMemoryRangeCopy(InputData, InputDataLength, BufferName)
    @apicall(:LLVMCreateMemoryBufferWithMemoryRangeCopy, LLVMMemoryBufferRef, (Cstring, Csize_t, Cstring), InputData, InputDataLength, BufferName)
end

function LLVMGetBufferStart(MemBuf)
    @apicall(:LLVMGetBufferStart, Cstring, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMGetBufferSize(MemBuf)
    @apicall(:LLVMGetBufferSize, Csize_t, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMDisposeMemoryBuffer(MemBuf)
    @apicall(:LLVMDisposeMemoryBuffer, Cvoid, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMGetGlobalPassRegistry()
    @apicall(:LLVMGetGlobalPassRegistry, LLVMPassRegistryRef, ())
end

function LLVMCreatePassManager()
    @apicall(:LLVMCreatePassManager, LLVMPassManagerRef, ())
end

function LLVMCreateFunctionPassManagerForModule(M)
    @apicall(:LLVMCreateFunctionPassManagerForModule, LLVMPassManagerRef, (LLVMModuleRef,), M)
end

function LLVMCreateFunctionPassManager(MP)
    @apicall(:LLVMCreateFunctionPassManager, LLVMPassManagerRef, (LLVMModuleProviderRef,), MP)
end

function LLVMRunPassManager(PM, M)
    @apicall(:LLVMRunPassManager, LLVMBool, (LLVMPassManagerRef, LLVMModuleRef), PM, M)
end

function LLVMInitializeFunctionPassManager(FPM)
    @apicall(:LLVMInitializeFunctionPassManager, LLVMBool, (LLVMPassManagerRef,), FPM)
end

function LLVMRunFunctionPassManager(FPM, F)
    @apicall(:LLVMRunFunctionPassManager, LLVMBool, (LLVMPassManagerRef, LLVMValueRef), FPM, F)
end

function LLVMFinalizeFunctionPassManager(FPM)
    @apicall(:LLVMFinalizeFunctionPassManager, LLVMBool, (LLVMPassManagerRef,), FPM)
end

function LLVMDisposePassManager(PM)
    @apicall(:LLVMDisposePassManager, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMStartMultithreaded()
    @apicall(:LLVMStartMultithreaded, LLVMBool, ())
end

function LLVMStopMultithreaded()
    @apicall(:LLVMStopMultithreaded, Cvoid, ())
end

function LLVMIsMultithreaded()
    @apicall(:LLVMIsMultithreaded, LLVMBool, ())
end
# Julia wrapper for header: DataTypes.h
# Automatically generated using Clang.jl

# Julia wrapper for header: DebugInfo.h
# Automatically generated using Clang.jl


function LLVMInstallFatalErrorHandler(Handler)
    @apicall(:LLVMInstallFatalErrorHandler, Cvoid, (LLVMFatalErrorHandler,), Handler)
end

function LLVMResetFatalErrorHandler()
    @apicall(:LLVMResetFatalErrorHandler, Cvoid, ())
end

function LLVMEnablePrettyStackTrace()
    @apicall(:LLVMEnablePrettyStackTrace, Cvoid, ())
end

function LLVMInitializeCore(R)
    @apicall(:LLVMInitializeCore, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMShutdown()
    @apicall(:LLVMShutdown, Cvoid, ())
end

function LLVMCreateMessage(Message)
    @apicall(:LLVMCreateMessage, Cstring, (Cstring,), Message)
end

function LLVMDisposeMessage(Message)
    @apicall(:LLVMDisposeMessage, Cvoid, (Cstring,), Message)
end

function LLVMContextCreate()
    @apicall(:LLVMContextCreate, LLVMContextRef, ())
end

function LLVMGetGlobalContext()
    @apicall(:LLVMGetGlobalContext, LLVMContextRef, ())
end

function LLVMContextSetDiagnosticHandler(C, Handler, DiagnosticContext)
    @apicall(:LLVMContextSetDiagnosticHandler, Cvoid, (LLVMContextRef, LLVMDiagnosticHandler, Ptr{Cvoid}), C, Handler, DiagnosticContext)
end

function LLVMContextGetDiagnosticHandler(C)
    @apicall(:LLVMContextGetDiagnosticHandler, LLVMDiagnosticHandler, (LLVMContextRef,), C)
end

function LLVMContextGetDiagnosticContext(C)
    @apicall(:LLVMContextGetDiagnosticContext, Ptr{Cvoid}, (LLVMContextRef,), C)
end

function LLVMContextSetYieldCallback(C, Callback, OpaqueHandle)
    @apicall(:LLVMContextSetYieldCallback, Cvoid, (LLVMContextRef, LLVMYieldCallback, Ptr{Cvoid}), C, Callback, OpaqueHandle)
end

function LLVMContextShouldDiscardValueNames(C)
    @apicall(:LLVMContextShouldDiscardValueNames, LLVMBool, (LLVMContextRef,), C)
end

function LLVMContextSetDiscardValueNames(C, Discard)
    @apicall(:LLVMContextSetDiscardValueNames, Cvoid, (LLVMContextRef, LLVMBool), C, Discard)
end

function LLVMContextDispose(C)
    @apicall(:LLVMContextDispose, Cvoid, (LLVMContextRef,), C)
end

function LLVMGetDiagInfoDescription(DI)
    @apicall(:LLVMGetDiagInfoDescription, Cstring, (LLVMDiagnosticInfoRef,), DI)
end

function LLVMGetDiagInfoSeverity(DI)
    @apicall(:LLVMGetDiagInfoSeverity, LLVMDiagnosticSeverity, (LLVMDiagnosticInfoRef,), DI)
end

function LLVMGetMDKindIDInContext(C, Name, SLen)
    @apicall(:LLVMGetMDKindIDInContext, UInt32, (LLVMContextRef, Cstring, UInt32), C, Name, SLen)
end

function LLVMGetMDKindID(Name, SLen)
    @apicall(:LLVMGetMDKindID, UInt32, (Cstring, UInt32), Name, SLen)
end

function LLVMGetEnumAttributeKindForName(Name, SLen)
    @apicall(:LLVMGetEnumAttributeKindForName, UInt32, (Cstring, Csize_t), Name, SLen)
end

function LLVMGetLastEnumAttributeKind()
    @apicall(:LLVMGetLastEnumAttributeKind, UInt32, ())
end

function LLVMCreateEnumAttribute(C, KindID, Val)
    @apicall(:LLVMCreateEnumAttribute, LLVMAttributeRef, (LLVMContextRef, UInt32, UInt64), C, KindID, Val)
end

function LLVMGetEnumAttributeKind(A)
    @apicall(:LLVMGetEnumAttributeKind, UInt32, (LLVMAttributeRef,), A)
end

function LLVMGetEnumAttributeValue(A)
    @apicall(:LLVMGetEnumAttributeValue, UInt64, (LLVMAttributeRef,), A)
end

function LLVMCreateStringAttribute(C, K, KLength, V, VLength)
    @apicall(:LLVMCreateStringAttribute, LLVMAttributeRef, (LLVMContextRef, Cstring, UInt32, Cstring, UInt32), C, K, KLength, V, VLength)
end

function LLVMGetStringAttributeKind(A, Length)
    @apicall(:LLVMGetStringAttributeKind, Cstring, (LLVMAttributeRef, Ptr{UInt32}), A, Length)
end

function LLVMGetStringAttributeValue(A, Length)
    @apicall(:LLVMGetStringAttributeValue, Cstring, (LLVMAttributeRef, Ptr{UInt32}), A, Length)
end

function LLVMIsEnumAttribute(A)
    @apicall(:LLVMIsEnumAttribute, LLVMBool, (LLVMAttributeRef,), A)
end

function LLVMIsStringAttribute(A)
    @apicall(:LLVMIsStringAttribute, LLVMBool, (LLVMAttributeRef,), A)
end

function LLVMModuleCreateWithName(ModuleID)
    @apicall(:LLVMModuleCreateWithName, LLVMModuleRef, (Cstring,), ModuleID)
end

function LLVMModuleCreateWithNameInContext(ModuleID, C)
    @apicall(:LLVMModuleCreateWithNameInContext, LLVMModuleRef, (Cstring, LLVMContextRef), ModuleID, C)
end

function LLVMCloneModule(M)
    @apicall(:LLVMCloneModule, LLVMModuleRef, (LLVMModuleRef,), M)
end

function LLVMDisposeModule(M)
    @apicall(:LLVMDisposeModule, Cvoid, (LLVMModuleRef,), M)
end

function LLVMGetModuleIdentifier(M, Len)
    @apicall(:LLVMGetModuleIdentifier, Cstring, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMSetModuleIdentifier(M, Ident, Len)
    @apicall(:LLVMSetModuleIdentifier, Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Ident, Len)
end

function LLVMGetSourceFileName(M, Len)
    @apicall(:LLVMGetSourceFileName, Cstring, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMSetSourceFileName(M, Name, Len)
    @apicall(:LLVMSetSourceFileName, Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Name, Len)
end

function LLVMGetDataLayoutStr(M)
    @apicall(:LLVMGetDataLayoutStr, Cstring, (LLVMModuleRef,), M)
end

function LLVMGetDataLayout(M)
    @apicall(:LLVMGetDataLayout, Cstring, (LLVMModuleRef,), M)
end

function LLVMSetDataLayout(M, DataLayoutStr)
    @apicall(:LLVMSetDataLayout, Cvoid, (LLVMModuleRef, Cstring), M, DataLayoutStr)
end

function LLVMGetTarget(M)
    @apicall(:LLVMGetTarget, Cstring, (LLVMModuleRef,), M)
end

function LLVMSetTarget(M, Triple)
    @apicall(:LLVMSetTarget, Cvoid, (LLVMModuleRef, Cstring), M, Triple)
end

function LLVMCopyModuleFlagsMetadata(M, Len)
    @apicall(:LLVMCopyModuleFlagsMetadata, Ptr{LLVMModuleFlagEntry}, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMDisposeModuleFlagsMetadata(Entries)
    @apicall(:LLVMDisposeModuleFlagsMetadata, Cvoid, (Ptr{LLVMModuleFlagEntry},), Entries)
end

function LLVMModuleFlagEntriesGetFlagBehavior(Entries, Index)
    @apicall(:LLVMModuleFlagEntriesGetFlagBehavior, LLVMModuleFlagBehavior, (Ptr{LLVMModuleFlagEntry}, UInt32), Entries, Index)
end

function LLVMModuleFlagEntriesGetKey(Entries, Index, Len)
    @apicall(:LLVMModuleFlagEntriesGetKey, Cstring, (Ptr{LLVMModuleFlagEntry}, UInt32, Ptr{Csize_t}), Entries, Index, Len)
end

function LLVMModuleFlagEntriesGetMetadata(Entries, Index)
    @apicall(:LLVMModuleFlagEntriesGetMetadata, LLVMMetadataRef, (Ptr{LLVMModuleFlagEntry}, UInt32), Entries, Index)
end

function LLVMGetModuleFlag(M, Key, KeyLen)
    @apicall(:LLVMGetModuleFlag, LLVMMetadataRef, (LLVMModuleRef, Cstring, Csize_t), M, Key, KeyLen)
end

function LLVMAddModuleFlag(M, Behavior, Key, KeyLen, Val)
    @apicall(:LLVMAddModuleFlag, Cvoid, (LLVMModuleRef, LLVMModuleFlagBehavior, Cstring, Csize_t, LLVMMetadataRef), M, Behavior, Key, KeyLen, Val)
end

function LLVMDumpModule(M)
    @apicall(:LLVMDumpModule, Cvoid, (LLVMModuleRef,), M)
end

function LLVMPrintModuleToFile(M, Filename, ErrorMessage)
    @apicall(:LLVMPrintModuleToFile, LLVMBool, (LLVMModuleRef, Cstring, Ptr{Cstring}), M, Filename, ErrorMessage)
end

function LLVMPrintModuleToString(M)
    @apicall(:LLVMPrintModuleToString, Cstring, (LLVMModuleRef,), M)
end

function LLVMGetModuleInlineAsm(M, Len)
    @apicall(:LLVMGetModuleInlineAsm, Cstring, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMSetModuleInlineAsm2(M, Asm, Len)
    @apicall(:LLVMSetModuleInlineAsm2, Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Asm, Len)
end

function LLVMAppendModuleInlineAsm(M, Asm, Len)
    @apicall(:LLVMAppendModuleInlineAsm, Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Asm, Len)
end

function LLVMGetInlineAsm(Ty, AsmString, AsmStringSize, Constraints, ConstraintsSize, HasSideEffects, IsAlignStack, Dialect)
    @apicall(:LLVMGetInlineAsm, LLVMValueRef, (LLVMTypeRef, Cstring, Csize_t, Cstring, Csize_t, LLVMBool, LLVMBool, LLVMInlineAsmDialect), Ty, AsmString, AsmStringSize, Constraints, ConstraintsSize, HasSideEffects, IsAlignStack, Dialect)
end

function LLVMGetModuleContext(M)
    @apicall(:LLVMGetModuleContext, LLVMContextRef, (LLVMModuleRef,), M)
end

function LLVMGetTypeByName(M, Name)
    @apicall(:LLVMGetTypeByName, LLVMTypeRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetFirstNamedMetadata(M)
    @apicall(:LLVMGetFirstNamedMetadata, LLVMNamedMDNodeRef, (LLVMModuleRef,), M)
end

function LLVMGetLastNamedMetadata(M)
    @apicall(:LLVMGetLastNamedMetadata, LLVMNamedMDNodeRef, (LLVMModuleRef,), M)
end

function LLVMGetNextNamedMetadata(NamedMDNode)
    @apicall(:LLVMGetNextNamedMetadata, LLVMNamedMDNodeRef, (LLVMNamedMDNodeRef,), NamedMDNode)
end

function LLVMGetPreviousNamedMetadata(NamedMDNode)
    @apicall(:LLVMGetPreviousNamedMetadata, LLVMNamedMDNodeRef, (LLVMNamedMDNodeRef,), NamedMDNode)
end

function LLVMGetNamedMetadata(M, Name, NameLen)
    @apicall(:LLVMGetNamedMetadata, LLVMNamedMDNodeRef, (LLVMModuleRef, Cstring, Csize_t), M, Name, NameLen)
end

function LLVMGetOrInsertNamedMetadata(M, Name, NameLen)
    @apicall(:LLVMGetOrInsertNamedMetadata, LLVMNamedMDNodeRef, (LLVMModuleRef, Cstring, Csize_t), M, Name, NameLen)
end

function LLVMGetNamedMetadataName(NamedMD, NameLen)
    @apicall(:LLVMGetNamedMetadataName, Cstring, (LLVMNamedMDNodeRef, Ptr{Csize_t}), NamedMD, NameLen)
end

function LLVMGetNamedMetadataNumOperands(M, Name)
    @apicall(:LLVMGetNamedMetadataNumOperands, UInt32, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetNamedMetadataOperands(M, Name, Dest)
    @apicall(:LLVMGetNamedMetadataOperands, Cvoid, (LLVMModuleRef, Cstring, Ptr{LLVMValueRef}), M, Name, Dest)
end

function LLVMAddNamedMetadataOperand(M, Name, Val)
    @apicall(:LLVMAddNamedMetadataOperand, Cvoid, (LLVMModuleRef, Cstring, LLVMValueRef), M, Name, Val)
end

function LLVMGetDebugLocDirectory(Val, Length)
    @apicall(:LLVMGetDebugLocDirectory, Cstring, (LLVMValueRef, Ptr{UInt32}), Val, Length)
end

function LLVMGetDebugLocFilename(Val, Length)
    @apicall(:LLVMGetDebugLocFilename, Cstring, (LLVMValueRef, Ptr{UInt32}), Val, Length)
end

function LLVMGetDebugLocLine(Val)
    @apicall(:LLVMGetDebugLocLine, UInt32, (LLVMValueRef,), Val)
end

function LLVMGetDebugLocColumn(Val)
    @apicall(:LLVMGetDebugLocColumn, UInt32, (LLVMValueRef,), Val)
end

function LLVMAddFunction(M, Name, FunctionTy)
    @apicall(:LLVMAddFunction, LLVMValueRef, (LLVMModuleRef, Cstring, LLVMTypeRef), M, Name, FunctionTy)
end

function LLVMGetNamedFunction(M, Name)
    @apicall(:LLVMGetNamedFunction, LLVMValueRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetFirstFunction(M)
    @apicall(:LLVMGetFirstFunction, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastFunction(M)
    @apicall(:LLVMGetLastFunction, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextFunction(Fn)
    @apicall(:LLVMGetNextFunction, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetPreviousFunction(Fn)
    @apicall(:LLVMGetPreviousFunction, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMSetModuleInlineAsm(M, Asm)
    @apicall(:LLVMSetModuleInlineAsm, Cvoid, (LLVMModuleRef, Cstring), M, Asm)
end

function LLVMGetTypeKind(Ty)
    @apicall(:LLVMGetTypeKind, LLVMTypeKind, (LLVMTypeRef,), Ty)
end

function LLVMTypeIsSized(Ty)
    @apicall(:LLVMTypeIsSized, LLVMBool, (LLVMTypeRef,), Ty)
end

function LLVMGetTypeContext(Ty)
    @apicall(:LLVMGetTypeContext, LLVMContextRef, (LLVMTypeRef,), Ty)
end

function LLVMDumpType(Val)
    @apicall(:LLVMDumpType, Cvoid, (LLVMTypeRef,), Val)
end

function LLVMPrintTypeToString(Val)
    @apicall(:LLVMPrintTypeToString, Cstring, (LLVMTypeRef,), Val)
end

function LLVMInt1TypeInContext(C)
    @apicall(:LLVMInt1TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt8TypeInContext(C)
    @apicall(:LLVMInt8TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt16TypeInContext(C)
    @apicall(:LLVMInt16TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt32TypeInContext(C)
    @apicall(:LLVMInt32TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt64TypeInContext(C)
    @apicall(:LLVMInt64TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt128TypeInContext(C)
    @apicall(:LLVMInt128TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMIntTypeInContext(C, NumBits)
    @apicall(:LLVMIntTypeInContext, LLVMTypeRef, (LLVMContextRef, UInt32), C, NumBits)
end

function LLVMInt1Type()
    @apicall(:LLVMInt1Type, LLVMTypeRef, ())
end

function LLVMInt8Type()
    @apicall(:LLVMInt8Type, LLVMTypeRef, ())
end

function LLVMInt16Type()
    @apicall(:LLVMInt16Type, LLVMTypeRef, ())
end

function LLVMInt32Type()
    @apicall(:LLVMInt32Type, LLVMTypeRef, ())
end

function LLVMInt64Type()
    @apicall(:LLVMInt64Type, LLVMTypeRef, ())
end

function LLVMInt128Type()
    @apicall(:LLVMInt128Type, LLVMTypeRef, ())
end

function LLVMIntType(NumBits)
    @apicall(:LLVMIntType, LLVMTypeRef, (UInt32,), NumBits)
end

function LLVMGetIntTypeWidth(IntegerTy)
    @apicall(:LLVMGetIntTypeWidth, UInt32, (LLVMTypeRef,), IntegerTy)
end

function LLVMHalfTypeInContext(C)
    @apicall(:LLVMHalfTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMFloatTypeInContext(C)
    @apicall(:LLVMFloatTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMDoubleTypeInContext(C)
    @apicall(:LLVMDoubleTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMX86FP80TypeInContext(C)
    @apicall(:LLVMX86FP80TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMFP128TypeInContext(C)
    @apicall(:LLVMFP128TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMPPCFP128TypeInContext(C)
    @apicall(:LLVMPPCFP128TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMHalfType()
    @apicall(:LLVMHalfType, LLVMTypeRef, ())
end

function LLVMFloatType()
    @apicall(:LLVMFloatType, LLVMTypeRef, ())
end

function LLVMDoubleType()
    @apicall(:LLVMDoubleType, LLVMTypeRef, ())
end

function LLVMX86FP80Type()
    @apicall(:LLVMX86FP80Type, LLVMTypeRef, ())
end

function LLVMFP128Type()
    @apicall(:LLVMFP128Type, LLVMTypeRef, ())
end

function LLVMPPCFP128Type()
    @apicall(:LLVMPPCFP128Type, LLVMTypeRef, ())
end

function LLVMFunctionType(ReturnType, ParamTypes, ParamCount, IsVarArg)
    @apicall(:LLVMFunctionType, LLVMTypeRef, (LLVMTypeRef, Ptr{LLVMTypeRef}, UInt32, LLVMBool), ReturnType, ParamTypes, ParamCount, IsVarArg)
end

function LLVMIsFunctionVarArg(FunctionTy)
    @apicall(:LLVMIsFunctionVarArg, LLVMBool, (LLVMTypeRef,), FunctionTy)
end

function LLVMGetReturnType(FunctionTy)
    @apicall(:LLVMGetReturnType, LLVMTypeRef, (LLVMTypeRef,), FunctionTy)
end

function LLVMCountParamTypes(FunctionTy)
    @apicall(:LLVMCountParamTypes, UInt32, (LLVMTypeRef,), FunctionTy)
end

function LLVMGetParamTypes(FunctionTy, Dest)
    @apicall(:LLVMGetParamTypes, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), FunctionTy, Dest)
end

function LLVMStructTypeInContext(C, ElementTypes, ElementCount, Packed)
    @apicall(:LLVMStructTypeInContext, LLVMTypeRef, (LLVMContextRef, Ptr{LLVMTypeRef}, UInt32, LLVMBool), C, ElementTypes, ElementCount, Packed)
end

function LLVMStructType(ElementTypes, ElementCount, Packed)
    @apicall(:LLVMStructType, LLVMTypeRef, (Ptr{LLVMTypeRef}, UInt32, LLVMBool), ElementTypes, ElementCount, Packed)
end

function LLVMStructCreateNamed(C, Name)
    @apicall(:LLVMStructCreateNamed, LLVMTypeRef, (LLVMContextRef, Cstring), C, Name)
end

function LLVMGetStructName(Ty)
    @apicall(:LLVMGetStructName, Cstring, (LLVMTypeRef,), Ty)
end

function LLVMStructSetBody(StructTy, ElementTypes, ElementCount, Packed)
    @apicall(:LLVMStructSetBody, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}, UInt32, LLVMBool), StructTy, ElementTypes, ElementCount, Packed)
end

function LLVMCountStructElementTypes(StructTy)
    @apicall(:LLVMCountStructElementTypes, UInt32, (LLVMTypeRef,), StructTy)
end

function LLVMGetStructElementTypes(StructTy, Dest)
    @apicall(:LLVMGetStructElementTypes, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), StructTy, Dest)
end

function LLVMStructGetTypeAtIndex(StructTy, i)
    @apicall(:LLVMStructGetTypeAtIndex, LLVMTypeRef, (LLVMTypeRef, UInt32), StructTy, i)
end

function LLVMIsPackedStruct(StructTy)
    @apicall(:LLVMIsPackedStruct, LLVMBool, (LLVMTypeRef,), StructTy)
end

function LLVMIsOpaqueStruct(StructTy)
    @apicall(:LLVMIsOpaqueStruct, LLVMBool, (LLVMTypeRef,), StructTy)
end

function LLVMIsLiteralStruct(StructTy)
    @apicall(:LLVMIsLiteralStruct, LLVMBool, (LLVMTypeRef,), StructTy)
end

function LLVMGetElementType(Ty)
    @apicall(:LLVMGetElementType, LLVMTypeRef, (LLVMTypeRef,), Ty)
end

function LLVMGetSubtypes(Tp, Arr)
    @apicall(:LLVMGetSubtypes, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), Tp, Arr)
end

function LLVMGetNumContainedTypes(Tp)
    @apicall(:LLVMGetNumContainedTypes, UInt32, (LLVMTypeRef,), Tp)
end

function LLVMArrayType(ElementType, ElementCount)
    @apicall(:LLVMArrayType, LLVMTypeRef, (LLVMTypeRef, UInt32), ElementType, ElementCount)
end

function LLVMGetArrayLength(ArrayTy)
    @apicall(:LLVMGetArrayLength, UInt32, (LLVMTypeRef,), ArrayTy)
end

function LLVMPointerType(ElementType, AddressSpace)
    @apicall(:LLVMPointerType, LLVMTypeRef, (LLVMTypeRef, UInt32), ElementType, AddressSpace)
end

function LLVMGetPointerAddressSpace(PointerTy)
    @apicall(:LLVMGetPointerAddressSpace, UInt32, (LLVMTypeRef,), PointerTy)
end

function LLVMVectorType(ElementType, ElementCount)
    @apicall(:LLVMVectorType, LLVMTypeRef, (LLVMTypeRef, UInt32), ElementType, ElementCount)
end

function LLVMGetVectorSize(VectorTy)
    @apicall(:LLVMGetVectorSize, UInt32, (LLVMTypeRef,), VectorTy)
end

function LLVMVoidTypeInContext(C)
    @apicall(:LLVMVoidTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMLabelTypeInContext(C)
    @apicall(:LLVMLabelTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMX86MMXTypeInContext(C)
    @apicall(:LLVMX86MMXTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMTokenTypeInContext(C)
    @apicall(:LLVMTokenTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMMetadataTypeInContext(C)
    @apicall(:LLVMMetadataTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMVoidType()
    @apicall(:LLVMVoidType, LLVMTypeRef, ())
end

function LLVMLabelType()
    @apicall(:LLVMLabelType, LLVMTypeRef, ())
end

function LLVMX86MMXType()
    @apicall(:LLVMX86MMXType, LLVMTypeRef, ())
end

function LLVMTypeOf(Val)
    @apicall(:LLVMTypeOf, LLVMTypeRef, (LLVMValueRef,), Val)
end

function LLVMGetValueKind(Val)
    @apicall(:LLVMGetValueKind, LLVMValueKind, (LLVMValueRef,), Val)
end

function LLVMGetValueName2(Val, Length)
    @apicall(:LLVMGetValueName2, Cstring, (LLVMValueRef, Ptr{Csize_t}), Val, Length)
end

function LLVMSetValueName2(Val, Name, NameLen)
    @apicall(:LLVMSetValueName2, Cvoid, (LLVMValueRef, Cstring, Csize_t), Val, Name, NameLen)
end

function LLVMDumpValue(Val)
    @apicall(:LLVMDumpValue, Cvoid, (LLVMValueRef,), Val)
end

function LLVMPrintValueToString(Val)
    @apicall(:LLVMPrintValueToString, Cstring, (LLVMValueRef,), Val)
end

function LLVMReplaceAllUsesWith(OldVal, NewVal)
    @apicall(:LLVMReplaceAllUsesWith, Cvoid, (LLVMValueRef, LLVMValueRef), OldVal, NewVal)
end

function LLVMIsConstant(Val)
    @apicall(:LLVMIsConstant, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMIsUndef(Val)
    @apicall(:LLVMIsUndef, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMIsAArgument(Val)
    @apicall(:LLVMIsAArgument, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABasicBlock(Val)
    @apicall(:LLVMIsABasicBlock, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInlineAsm(Val)
    @apicall(:LLVMIsAInlineAsm, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUser(Val)
    @apicall(:LLVMIsAUser, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstant(Val)
    @apicall(:LLVMIsAConstant, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABlockAddress(Val)
    @apicall(:LLVMIsABlockAddress, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantAggregateZero(Val)
    @apicall(:LLVMIsAConstantAggregateZero, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantArray(Val)
    @apicall(:LLVMIsAConstantArray, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataSequential(Val)
    @apicall(:LLVMIsAConstantDataSequential, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataArray(Val)
    @apicall(:LLVMIsAConstantDataArray, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataVector(Val)
    @apicall(:LLVMIsAConstantDataVector, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantExpr(Val)
    @apicall(:LLVMIsAConstantExpr, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantFP(Val)
    @apicall(:LLVMIsAConstantFP, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantInt(Val)
    @apicall(:LLVMIsAConstantInt, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantPointerNull(Val)
    @apicall(:LLVMIsAConstantPointerNull, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantStruct(Val)
    @apicall(:LLVMIsAConstantStruct, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantTokenNone(Val)
    @apicall(:LLVMIsAConstantTokenNone, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantVector(Val)
    @apicall(:LLVMIsAConstantVector, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalValue(Val)
    @apicall(:LLVMIsAGlobalValue, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalAlias(Val)
    @apicall(:LLVMIsAGlobalAlias, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalIFunc(Val)
    @apicall(:LLVMIsAGlobalIFunc, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalObject(Val)
    @apicall(:LLVMIsAGlobalObject, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFunction(Val)
    @apicall(:LLVMIsAFunction, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalVariable(Val)
    @apicall(:LLVMIsAGlobalVariable, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUndefValue(Val)
    @apicall(:LLVMIsAUndefValue, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInstruction(Val)
    @apicall(:LLVMIsAInstruction, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABinaryOperator(Val)
    @apicall(:LLVMIsABinaryOperator, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACallInst(Val)
    @apicall(:LLVMIsACallInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIntrinsicInst(Val)
    @apicall(:LLVMIsAIntrinsicInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgInfoIntrinsic(Val)
    @apicall(:LLVMIsADbgInfoIntrinsic, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgVariableIntrinsic(Val)
    @apicall(:LLVMIsADbgVariableIntrinsic, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgDeclareInst(Val)
    @apicall(:LLVMIsADbgDeclareInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgLabelInst(Val)
    @apicall(:LLVMIsADbgLabelInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemIntrinsic(Val)
    @apicall(:LLVMIsAMemIntrinsic, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemCpyInst(Val)
    @apicall(:LLVMIsAMemCpyInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemMoveInst(Val)
    @apicall(:LLVMIsAMemMoveInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemSetInst(Val)
    @apicall(:LLVMIsAMemSetInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACmpInst(Val)
    @apicall(:LLVMIsACmpInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFCmpInst(Val)
    @apicall(:LLVMIsAFCmpInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAICmpInst(Val)
    @apicall(:LLVMIsAICmpInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAExtractElementInst(Val)
    @apicall(:LLVMIsAExtractElementInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGetElementPtrInst(Val)
    @apicall(:LLVMIsAGetElementPtrInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInsertElementInst(Val)
    @apicall(:LLVMIsAInsertElementInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInsertValueInst(Val)
    @apicall(:LLVMIsAInsertValueInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsALandingPadInst(Val)
    @apicall(:LLVMIsALandingPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAPHINode(Val)
    @apicall(:LLVMIsAPHINode, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASelectInst(Val)
    @apicall(:LLVMIsASelectInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAShuffleVectorInst(Val)
    @apicall(:LLVMIsAShuffleVectorInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAStoreInst(Val)
    @apicall(:LLVMIsAStoreInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABranchInst(Val)
    @apicall(:LLVMIsABranchInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIndirectBrInst(Val)
    @apicall(:LLVMIsAIndirectBrInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInvokeInst(Val)
    @apicall(:LLVMIsAInvokeInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAReturnInst(Val)
    @apicall(:LLVMIsAReturnInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASwitchInst(Val)
    @apicall(:LLVMIsASwitchInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUnreachableInst(Val)
    @apicall(:LLVMIsAUnreachableInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAResumeInst(Val)
    @apicall(:LLVMIsAResumeInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACleanupReturnInst(Val)
    @apicall(:LLVMIsACleanupReturnInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACatchReturnInst(Val)
    @apicall(:LLVMIsACatchReturnInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFuncletPadInst(Val)
    @apicall(:LLVMIsAFuncletPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACatchPadInst(Val)
    @apicall(:LLVMIsACatchPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACleanupPadInst(Val)
    @apicall(:LLVMIsACleanupPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUnaryInstruction(Val)
    @apicall(:LLVMIsAUnaryInstruction, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAAllocaInst(Val)
    @apicall(:LLVMIsAAllocaInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACastInst(Val)
    @apicall(:LLVMIsACastInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAAddrSpaceCastInst(Val)
    @apicall(:LLVMIsAAddrSpaceCastInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABitCastInst(Val)
    @apicall(:LLVMIsABitCastInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPExtInst(Val)
    @apicall(:LLVMIsAFPExtInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPToSIInst(Val)
    @apicall(:LLVMIsAFPToSIInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPToUIInst(Val)
    @apicall(:LLVMIsAFPToUIInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPTruncInst(Val)
    @apicall(:LLVMIsAFPTruncInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIntToPtrInst(Val)
    @apicall(:LLVMIsAIntToPtrInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAPtrToIntInst(Val)
    @apicall(:LLVMIsAPtrToIntInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASExtInst(Val)
    @apicall(:LLVMIsASExtInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASIToFPInst(Val)
    @apicall(:LLVMIsASIToFPInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsATruncInst(Val)
    @apicall(:LLVMIsATruncInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUIToFPInst(Val)
    @apicall(:LLVMIsAUIToFPInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAZExtInst(Val)
    @apicall(:LLVMIsAZExtInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAExtractValueInst(Val)
    @apicall(:LLVMIsAExtractValueInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsALoadInst(Val)
    @apicall(:LLVMIsALoadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAVAArgInst(Val)
    @apicall(:LLVMIsAVAArgInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMDNode(Val)
    @apicall(:LLVMIsAMDNode, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMDString(Val)
    @apicall(:LLVMIsAMDString, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMGetValueName(Val)
    @apicall(:LLVMGetValueName, Cstring, (LLVMValueRef,), Val)
end

function LLVMSetValueName(Val, Name)
    @apicall(:LLVMSetValueName, Cvoid, (LLVMValueRef, Cstring), Val, Name)
end

function LLVMGetFirstUse(Val)
    @apicall(:LLVMGetFirstUse, LLVMUseRef, (LLVMValueRef,), Val)
end

function LLVMGetNextUse(U)
    @apicall(:LLVMGetNextUse, LLVMUseRef, (LLVMUseRef,), U)
end

function LLVMGetUser(U)
    @apicall(:LLVMGetUser, LLVMValueRef, (LLVMUseRef,), U)
end

function LLVMGetUsedValue(U)
    @apicall(:LLVMGetUsedValue, LLVMValueRef, (LLVMUseRef,), U)
end

function LLVMGetOperand(Val, Index)
    @apicall(:LLVMGetOperand, LLVMValueRef, (LLVMValueRef, UInt32), Val, Index)
end

function LLVMGetOperandUse(Val, Index)
    @apicall(:LLVMGetOperandUse, LLVMUseRef, (LLVMValueRef, UInt32), Val, Index)
end

function LLVMSetOperand(User, Index, Val)
    @apicall(:LLVMSetOperand, Cvoid, (LLVMValueRef, UInt32, LLVMValueRef), User, Index, Val)
end

function LLVMGetNumOperands(Val)
    @apicall(:LLVMGetNumOperands, Cint, (LLVMValueRef,), Val)
end

function LLVMConstNull(Ty)
    @apicall(:LLVMConstNull, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstAllOnes(Ty)
    @apicall(:LLVMConstAllOnes, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMGetUndef(Ty)
    @apicall(:LLVMGetUndef, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMIsNull(Val)
    @apicall(:LLVMIsNull, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMConstPointerNull(Ty)
    @apicall(:LLVMConstPointerNull, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstInt(IntTy, N, SignExtend)
    @apicall(:LLVMConstInt, LLVMValueRef, (LLVMTypeRef, Culonglong, LLVMBool), IntTy, N, SignExtend)
end

function LLVMConstIntOfArbitraryPrecision(IntTy, NumWords, Words)
    @apicall(:LLVMConstIntOfArbitraryPrecision, LLVMValueRef, (LLVMTypeRef, UInt32, Ptr{UInt64}), IntTy, NumWords, Words)
end

function LLVMConstIntOfString(IntTy, Text, Radix)
    @apicall(:LLVMConstIntOfString, LLVMValueRef, (LLVMTypeRef, Cstring, UInt8), IntTy, Text, Radix)
end

function LLVMConstIntOfStringAndSize(IntTy, Text, SLen, Radix)
    @apicall(:LLVMConstIntOfStringAndSize, LLVMValueRef, (LLVMTypeRef, Cstring, UInt32, UInt8), IntTy, Text, SLen, Radix)
end

function LLVMConstReal(RealTy, N)
    @apicall(:LLVMConstReal, LLVMValueRef, (LLVMTypeRef, Cdouble), RealTy, N)
end

function LLVMConstRealOfString(RealTy, Text)
    @apicall(:LLVMConstRealOfString, LLVMValueRef, (LLVMTypeRef, Cstring), RealTy, Text)
end

function LLVMConstRealOfStringAndSize(RealTy, Text, SLen)
    @apicall(:LLVMConstRealOfStringAndSize, LLVMValueRef, (LLVMTypeRef, Cstring, UInt32), RealTy, Text, SLen)
end

function LLVMConstIntGetZExtValue(ConstantVal)
    @apicall(:LLVMConstIntGetZExtValue, Culonglong, (LLVMValueRef,), ConstantVal)
end

function LLVMConstIntGetSExtValue(ConstantVal)
    @apicall(:LLVMConstIntGetSExtValue, Clonglong, (LLVMValueRef,), ConstantVal)
end

function LLVMConstRealGetDouble(ConstantVal, losesInfo)
    @apicall(:LLVMConstRealGetDouble, Cdouble, (LLVMValueRef, Ptr{LLVMBool}), ConstantVal, losesInfo)
end

function LLVMConstStringInContext(C, Str, Length, DontNullTerminate)
    @apicall(:LLVMConstStringInContext, LLVMValueRef, (LLVMContextRef, Cstring, UInt32, LLVMBool), C, Str, Length, DontNullTerminate)
end

function LLVMConstString(Str, Length, DontNullTerminate)
    @apicall(:LLVMConstString, LLVMValueRef, (Cstring, UInt32, LLVMBool), Str, Length, DontNullTerminate)
end

function LLVMIsConstantString(c)
    @apicall(:LLVMIsConstantString, LLVMBool, (LLVMValueRef,), c)
end

function LLVMGetAsString(c, Length)
    @apicall(:LLVMGetAsString, Cstring, (LLVMValueRef, Ptr{Csize_t}), c, Length)
end

function LLVMConstStructInContext(C, ConstantVals, Count, Packed)
    @apicall(:LLVMConstStructInContext, LLVMValueRef, (LLVMContextRef, Ptr{LLVMValueRef}, UInt32, LLVMBool), C, ConstantVals, Count, Packed)
end

function LLVMConstStruct(ConstantVals, Count, Packed)
    @apicall(:LLVMConstStruct, LLVMValueRef, (Ptr{LLVMValueRef}, UInt32, LLVMBool), ConstantVals, Count, Packed)
end

function LLVMConstArray(ElementTy, ConstantVals, Length)
    @apicall(:LLVMConstArray, LLVMValueRef, (LLVMTypeRef, Ptr{LLVMValueRef}, UInt32), ElementTy, ConstantVals, Length)
end

function LLVMConstNamedStruct(StructTy, ConstantVals, Count)
    @apicall(:LLVMConstNamedStruct, LLVMValueRef, (LLVMTypeRef, Ptr{LLVMValueRef}, UInt32), StructTy, ConstantVals, Count)
end

function LLVMGetElementAsConstant(C, idx)
    @apicall(:LLVMGetElementAsConstant, LLVMValueRef, (LLVMValueRef, UInt32), C, idx)
end

function LLVMConstVector(ScalarConstantVals, Size)
    @apicall(:LLVMConstVector, LLVMValueRef, (Ptr{LLVMValueRef}, UInt32), ScalarConstantVals, Size)
end

function LLVMGetConstOpcode(ConstantVal)
    @apicall(:LLVMGetConstOpcode, LLVMOpcode, (LLVMValueRef,), ConstantVal)
end

function LLVMAlignOf(Ty)
    @apicall(:LLVMAlignOf, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMSizeOf(Ty)
    @apicall(:LLVMSizeOf, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstNeg(ConstantVal)
    @apicall(:LLVMConstNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNSWNeg(ConstantVal)
    @apicall(:LLVMConstNSWNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNUWNeg(ConstantVal)
    @apicall(:LLVMConstNUWNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstFNeg(ConstantVal)
    @apicall(:LLVMConstFNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNot(ConstantVal)
    @apicall(:LLVMConstNot, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstAdd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWAdd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNSWAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWAdd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNUWAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFAdd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSub(LHSConstant, RHSConstant)
    @apicall(:LLVMConstSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWSub(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNSWSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWSub(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNUWSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFSub(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstMul(LHSConstant, RHSConstant)
    @apicall(:LLVMConstMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWMul(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNSWMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWMul(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNUWMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFMul(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstUDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstUDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstExactUDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstExactUDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstSDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstExactSDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstExactSDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstURem(LHSConstant, RHSConstant)
    @apicall(:LLVMConstURem, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSRem(LHSConstant, RHSConstant)
    @apicall(:LLVMConstSRem, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFRem(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFRem, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstAnd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstAnd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstOr(LHSConstant, RHSConstant)
    @apicall(:LLVMConstOr, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstXor(LHSConstant, RHSConstant)
    @apicall(:LLVMConstXor, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstICmp(Predicate, LHSConstant, RHSConstant)
    @apicall(:LLVMConstICmp, LLVMValueRef, (LLVMIntPredicate, LLVMValueRef, LLVMValueRef), Predicate, LHSConstant, RHSConstant)
end

function LLVMConstFCmp(Predicate, LHSConstant, RHSConstant)
    @apicall(:LLVMConstFCmp, LLVMValueRef, (LLVMRealPredicate, LLVMValueRef, LLVMValueRef), Predicate, LHSConstant, RHSConstant)
end

function LLVMConstShl(LHSConstant, RHSConstant)
    @apicall(:LLVMConstShl, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstLShr(LHSConstant, RHSConstant)
    @apicall(:LLVMConstLShr, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstAShr(LHSConstant, RHSConstant)
    @apicall(:LLVMConstAShr, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstGEP(ConstantVal, ConstantIndices, NumIndices)
    @apicall(:LLVMConstGEP, LLVMValueRef, (LLVMValueRef, Ptr{LLVMValueRef}, UInt32), ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstGEP2(Ty, ConstantVal, ConstantIndices, NumIndices)
    @apicall(:LLVMConstGEP2, LLVMValueRef, (LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32), Ty, ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstInBoundsGEP(ConstantVal, ConstantIndices, NumIndices)
    @apicall(:LLVMConstInBoundsGEP, LLVMValueRef, (LLVMValueRef, Ptr{LLVMValueRef}, UInt32), ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstInBoundsGEP2(Ty, ConstantVal, ConstantIndices, NumIndices)
    @apicall(:LLVMConstInBoundsGEP2, LLVMValueRef, (LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32), Ty, ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstTrunc(ConstantVal, ToType)
    @apicall(:LLVMConstTrunc, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSExt(ConstantVal, ToType)
    @apicall(:LLVMConstSExt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstZExt(ConstantVal, ToType)
    @apicall(:LLVMConstZExt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPTrunc(ConstantVal, ToType)
    @apicall(:LLVMConstFPTrunc, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPExt(ConstantVal, ToType)
    @apicall(:LLVMConstFPExt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstUIToFP(ConstantVal, ToType)
    @apicall(:LLVMConstUIToFP, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSIToFP(ConstantVal, ToType)
    @apicall(:LLVMConstSIToFP, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPToUI(ConstantVal, ToType)
    @apicall(:LLVMConstFPToUI, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPToSI(ConstantVal, ToType)
    @apicall(:LLVMConstFPToSI, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstPtrToInt(ConstantVal, ToType)
    @apicall(:LLVMConstPtrToInt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstIntToPtr(ConstantVal, ToType)
    @apicall(:LLVMConstIntToPtr, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstBitCast(ConstantVal, ToType)
    @apicall(:LLVMConstBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstAddrSpaceCast(ConstantVal, ToType)
    @apicall(:LLVMConstAddrSpaceCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstZExtOrBitCast(ConstantVal, ToType)
    @apicall(:LLVMConstZExtOrBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSExtOrBitCast(ConstantVal, ToType)
    @apicall(:LLVMConstSExtOrBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstTruncOrBitCast(ConstantVal, ToType)
    @apicall(:LLVMConstTruncOrBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstPointerCast(ConstantVal, ToType)
    @apicall(:LLVMConstPointerCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstIntCast(ConstantVal, ToType, isSigned)
    @apicall(:LLVMConstIntCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef, LLVMBool), ConstantVal, ToType, isSigned)
end

function LLVMConstFPCast(ConstantVal, ToType)
    @apicall(:LLVMConstFPCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSelect(ConstantCondition, ConstantIfTrue, ConstantIfFalse)
    @apicall(:LLVMConstSelect, LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), ConstantCondition, ConstantIfTrue, ConstantIfFalse)
end

function LLVMConstExtractElement(VectorConstant, IndexConstant)
    @apicall(:LLVMConstExtractElement, LLVMValueRef, (LLVMValueRef, LLVMValueRef), VectorConstant, IndexConstant)
end

function LLVMConstInsertElement(VectorConstant, ElementValueConstant, IndexConstant)
    @apicall(:LLVMConstInsertElement, LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), VectorConstant, ElementValueConstant, IndexConstant)
end

function LLVMConstShuffleVector(VectorAConstant, VectorBConstant, MaskConstant)
    @apicall(:LLVMConstShuffleVector, LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), VectorAConstant, VectorBConstant, MaskConstant)
end

function LLVMConstExtractValue(AggConstant, IdxList, NumIdx)
    @apicall(:LLVMConstExtractValue, LLVMValueRef, (LLVMValueRef, Ptr{UInt32}, UInt32), AggConstant, IdxList, NumIdx)
end

function LLVMConstInsertValue(AggConstant, ElementValueConstant, IdxList, NumIdx)
    @apicall(:LLVMConstInsertValue, LLVMValueRef, (LLVMValueRef, LLVMValueRef, Ptr{UInt32}, UInt32), AggConstant, ElementValueConstant, IdxList, NumIdx)
end

function LLVMBlockAddress(F, BB)
    @apicall(:LLVMBlockAddress, LLVMValueRef, (LLVMValueRef, LLVMBasicBlockRef), F, BB)
end

function LLVMConstInlineAsm(Ty, AsmString, Constraints, HasSideEffects, IsAlignStack)
    @apicall(:LLVMConstInlineAsm, LLVMValueRef, (LLVMTypeRef, Cstring, Cstring, LLVMBool, LLVMBool), Ty, AsmString, Constraints, HasSideEffects, IsAlignStack)
end

function LLVMGetGlobalParent(Global)
    @apicall(:LLVMGetGlobalParent, LLVMModuleRef, (LLVMValueRef,), Global)
end

function LLVMIsDeclaration(Global)
    @apicall(:LLVMIsDeclaration, LLVMBool, (LLVMValueRef,), Global)
end

function LLVMGetLinkage(Global)
    @apicall(:LLVMGetLinkage, LLVMLinkage, (LLVMValueRef,), Global)
end

function LLVMSetLinkage(Global, Linkage)
    @apicall(:LLVMSetLinkage, Cvoid, (LLVMValueRef, LLVMLinkage), Global, Linkage)
end

function LLVMGetSection(Global)
    @apicall(:LLVMGetSection, Cstring, (LLVMValueRef,), Global)
end

function LLVMSetSection(Global, Section)
    @apicall(:LLVMSetSection, Cvoid, (LLVMValueRef, Cstring), Global, Section)
end

function LLVMGetVisibility(Global)
    @apicall(:LLVMGetVisibility, LLVMVisibility, (LLVMValueRef,), Global)
end

function LLVMSetVisibility(Global, Viz)
    @apicall(:LLVMSetVisibility, Cvoid, (LLVMValueRef, LLVMVisibility), Global, Viz)
end

function LLVMGetDLLStorageClass(Global)
    @apicall(:LLVMGetDLLStorageClass, LLVMDLLStorageClass, (LLVMValueRef,), Global)
end

function LLVMSetDLLStorageClass(Global, Class)
    @apicall(:LLVMSetDLLStorageClass, Cvoid, (LLVMValueRef, LLVMDLLStorageClass), Global, Class)
end

function LLVMGetUnnamedAddress(Global)
    @apicall(:LLVMGetUnnamedAddress, LLVMUnnamedAddr, (LLVMValueRef,), Global)
end

function LLVMSetUnnamedAddress(Global, UnnamedAddr)
    @apicall(:LLVMSetUnnamedAddress, Cvoid, (LLVMValueRef, LLVMUnnamedAddr), Global, UnnamedAddr)
end

function LLVMGlobalGetValueType(Global)
    @apicall(:LLVMGlobalGetValueType, LLVMTypeRef, (LLVMValueRef,), Global)
end

function LLVMHasUnnamedAddr(Global)
    @apicall(:LLVMHasUnnamedAddr, LLVMBool, (LLVMValueRef,), Global)
end

function LLVMSetUnnamedAddr(Global, HasUnnamedAddr)
    @apicall(:LLVMSetUnnamedAddr, Cvoid, (LLVMValueRef, LLVMBool), Global, HasUnnamedAddr)
end

function LLVMGetAlignment(V)
    @apicall(:LLVMGetAlignment, UInt32, (LLVMValueRef,), V)
end

function LLVMSetAlignment(V, Bytes)
    @apicall(:LLVMSetAlignment, Cvoid, (LLVMValueRef, UInt32), V, Bytes)
end

function LLVMGlobalSetMetadata(Global, Kind, MD)
    @apicall(:LLVMGlobalSetMetadata, Cvoid, (LLVMValueRef, UInt32, LLVMMetadataRef), Global, Kind, MD)
end

function LLVMGlobalEraseMetadata(Global, Kind)
    @apicall(:LLVMGlobalEraseMetadata, Cvoid, (LLVMValueRef, UInt32), Global, Kind)
end

function LLVMGlobalClearMetadata(Global)
    @apicall(:LLVMGlobalClearMetadata, Cvoid, (LLVMValueRef,), Global)
end

function LLVMGlobalCopyAllMetadata(Value, NumEntries)
    @apicall(:LLVMGlobalCopyAllMetadata, Ptr{LLVMValueMetadataEntry}, (LLVMValueRef, Ptr{Csize_t}), Value, NumEntries)
end

function LLVMDisposeValueMetadataEntries(Entries)
    @apicall(:LLVMDisposeValueMetadataEntries, Cvoid, (Ptr{LLVMValueMetadataEntry},), Entries)
end

function LLVMValueMetadataEntriesGetKind(Entries, Index)
    @apicall(:LLVMValueMetadataEntriesGetKind, UInt32, (Ptr{LLVMValueMetadataEntry}, UInt32), Entries, Index)
end

function LLVMValueMetadataEntriesGetMetadata(Entries, Index)
    @apicall(:LLVMValueMetadataEntriesGetMetadata, LLVMMetadataRef, (Ptr{LLVMValueMetadataEntry}, UInt32), Entries, Index)
end

function LLVMAddGlobal(M, Ty, Name)
    @apicall(:LLVMAddGlobal, LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, Cstring), M, Ty, Name)
end

function LLVMAddGlobalInAddressSpace(M, Ty, Name, AddressSpace)
    @apicall(:LLVMAddGlobalInAddressSpace, LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, Cstring, UInt32), M, Ty, Name, AddressSpace)
end

function LLVMGetNamedGlobal(M, Name)
    @apicall(:LLVMGetNamedGlobal, LLVMValueRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetFirstGlobal(M)
    @apicall(:LLVMGetFirstGlobal, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastGlobal(M)
    @apicall(:LLVMGetLastGlobal, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextGlobal(GlobalVar)
    @apicall(:LLVMGetNextGlobal, LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMGetPreviousGlobal(GlobalVar)
    @apicall(:LLVMGetPreviousGlobal, LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMDeleteGlobal(GlobalVar)
    @apicall(:LLVMDeleteGlobal, Cvoid, (LLVMValueRef,), GlobalVar)
end

function LLVMGetInitializer(GlobalVar)
    @apicall(:LLVMGetInitializer, LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMSetInitializer(GlobalVar, ConstantVal)
    @apicall(:LLVMSetInitializer, Cvoid, (LLVMValueRef, LLVMValueRef), GlobalVar, ConstantVal)
end

function LLVMIsThreadLocal(GlobalVar)
    @apicall(:LLVMIsThreadLocal, LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetThreadLocal(GlobalVar, IsThreadLocal)
    @apicall(:LLVMSetThreadLocal, Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsThreadLocal)
end

function LLVMIsGlobalConstant(GlobalVar)
    @apicall(:LLVMIsGlobalConstant, LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetGlobalConstant(GlobalVar, IsConstant)
    @apicall(:LLVMSetGlobalConstant, Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsConstant)
end

function LLVMGetThreadLocalMode(GlobalVar)
    @apicall(:LLVMGetThreadLocalMode, LLVMThreadLocalMode, (LLVMValueRef,), GlobalVar)
end

function LLVMSetThreadLocalMode(GlobalVar, Mode)
    @apicall(:LLVMSetThreadLocalMode, Cvoid, (LLVMValueRef, LLVMThreadLocalMode), GlobalVar, Mode)
end

function LLVMIsExternallyInitialized(GlobalVar)
    @apicall(:LLVMIsExternallyInitialized, LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetExternallyInitialized(GlobalVar, IsExtInit)
    @apicall(:LLVMSetExternallyInitialized, Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsExtInit)
end

function LLVMAddAlias(M, Ty, Aliasee, Name)
    @apicall(:LLVMAddAlias, LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, LLVMValueRef, Cstring), M, Ty, Aliasee, Name)
end

function LLVMGetNamedGlobalAlias(M, Name, NameLen)
    @apicall(:LLVMGetNamedGlobalAlias, LLVMValueRef, (LLVMModuleRef, Cstring, Csize_t), M, Name, NameLen)
end

function LLVMGetFirstGlobalAlias(M)
    @apicall(:LLVMGetFirstGlobalAlias, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastGlobalAlias(M)
    @apicall(:LLVMGetLastGlobalAlias, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextGlobalAlias(GA)
    @apicall(:LLVMGetNextGlobalAlias, LLVMValueRef, (LLVMValueRef,), GA)
end

function LLVMGetPreviousGlobalAlias(GA)
    @apicall(:LLVMGetPreviousGlobalAlias, LLVMValueRef, (LLVMValueRef,), GA)
end

function LLVMAliasGetAliasee(Alias)
    @apicall(:LLVMAliasGetAliasee, LLVMValueRef, (LLVMValueRef,), Alias)
end

function LLVMAliasSetAliasee(Alias, Aliasee)
    @apicall(:LLVMAliasSetAliasee, Cvoid, (LLVMValueRef, LLVMValueRef), Alias, Aliasee)
end

function LLVMDeleteFunction(Fn)
    @apicall(:LLVMDeleteFunction, Cvoid, (LLVMValueRef,), Fn)
end

function LLVMHasPersonalityFn(Fn)
    @apicall(:LLVMHasPersonalityFn, LLVMBool, (LLVMValueRef,), Fn)
end

function LLVMGetPersonalityFn(Fn)
    @apicall(:LLVMGetPersonalityFn, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMSetPersonalityFn(Fn, PersonalityFn)
    @apicall(:LLVMSetPersonalityFn, Cvoid, (LLVMValueRef, LLVMValueRef), Fn, PersonalityFn)
end

function LLVMGetIntrinsicID(Fn)
    @apicall(:LLVMGetIntrinsicID, UInt32, (LLVMValueRef,), Fn)
end

function LLVMGetIntrinsicDeclaration(Mod, ID, ParamTypes, ParamCount)
    @apicall(:LLVMGetIntrinsicDeclaration, LLVMValueRef, (LLVMModuleRef, UInt32, Ptr{LLVMTypeRef}, Csize_t), Mod, ID, ParamTypes, ParamCount)
end

function LLVMIntrinsicGetType(Ctx, ID, ParamTypes, ParamCount)
    @apicall(:LLVMIntrinsicGetType, LLVMTypeRef, (LLVMContextRef, UInt32, Ptr{LLVMTypeRef}, Csize_t), Ctx, ID, ParamTypes, ParamCount)
end

function LLVMIntrinsicGetName(ID, NameLength)
    @apicall(:LLVMIntrinsicGetName, Cstring, (UInt32, Ptr{Csize_t}), ID, NameLength)
end

function LLVMIntrinsicCopyOverloadedName(ID, ParamTypes, ParamCount, NameLength)
    @apicall(:LLVMIntrinsicCopyOverloadedName, Cstring, (UInt32, Ptr{LLVMTypeRef}, Csize_t, Ptr{Csize_t}), ID, ParamTypes, ParamCount, NameLength)
end

function LLVMIntrinsicIsOverloaded(ID)
    @apicall(:LLVMIntrinsicIsOverloaded, LLVMBool, (UInt32,), ID)
end

function LLVMGetFunctionCallConv(Fn)
    @apicall(:LLVMGetFunctionCallConv, UInt32, (LLVMValueRef,), Fn)
end

function LLVMSetFunctionCallConv(Fn, CC)
    @apicall(:LLVMSetFunctionCallConv, Cvoid, (LLVMValueRef, UInt32), Fn, CC)
end

function LLVMGetGC(Fn)
    @apicall(:LLVMGetGC, Cstring, (LLVMValueRef,), Fn)
end

function LLVMSetGC(Fn, Name)
    @apicall(:LLVMSetGC, Cvoid, (LLVMValueRef, Cstring), Fn, Name)
end

function LLVMAddAttributeAtIndex(F, Idx, A)
    @apicall(:LLVMAddAttributeAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, LLVMAttributeRef), F, Idx, A)
end

function LLVMGetAttributeCountAtIndex(F, Idx)
    @apicall(:LLVMGetAttributeCountAtIndex, UInt32, (LLVMValueRef, LLVMAttributeIndex), F, Idx)
end

function LLVMGetAttributesAtIndex(F, Idx, Attrs)
    @apicall(:LLVMGetAttributesAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Ptr{LLVMAttributeRef}), F, Idx, Attrs)
end

function LLVMGetEnumAttributeAtIndex(F, Idx, KindID)
    @apicall(:LLVMGetEnumAttributeAtIndex, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, UInt32), F, Idx, KindID)
end

function LLVMGetStringAttributeAtIndex(F, Idx, K, KLen)
    @apicall(:LLVMGetStringAttributeAtIndex, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), F, Idx, K, KLen)
end

function LLVMRemoveEnumAttributeAtIndex(F, Idx, KindID)
    @apicall(:LLVMRemoveEnumAttributeAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, UInt32), F, Idx, KindID)
end

function LLVMRemoveStringAttributeAtIndex(F, Idx, K, KLen)
    @apicall(:LLVMRemoveStringAttributeAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), F, Idx, K, KLen)
end

function LLVMAddTargetDependentFunctionAttr(Fn, A, V)
    @apicall(:LLVMAddTargetDependentFunctionAttr, Cvoid, (LLVMValueRef, Cstring, Cstring), Fn, A, V)
end

function LLVMCountParams(Fn)
    @apicall(:LLVMCountParams, UInt32, (LLVMValueRef,), Fn)
end

function LLVMGetParams(Fn, Params)
    @apicall(:LLVMGetParams, Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}), Fn, Params)
end

function LLVMGetParam(Fn, Index)
    @apicall(:LLVMGetParam, LLVMValueRef, (LLVMValueRef, UInt32), Fn, Index)
end

function LLVMGetParamParent(Inst)
    @apicall(:LLVMGetParamParent, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetFirstParam(Fn)
    @apicall(:LLVMGetFirstParam, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetLastParam(Fn)
    @apicall(:LLVMGetLastParam, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetNextParam(Arg)
    @apicall(:LLVMGetNextParam, LLVMValueRef, (LLVMValueRef,), Arg)
end

function LLVMGetPreviousParam(Arg)
    @apicall(:LLVMGetPreviousParam, LLVMValueRef, (LLVMValueRef,), Arg)
end

function LLVMSetParamAlignment(Arg, Align)
    @apicall(:LLVMSetParamAlignment, Cvoid, (LLVMValueRef, UInt32), Arg, Align)
end

function LLVMMDStringInContext(C, Str, SLen)
    @apicall(:LLVMMDStringInContext, LLVMValueRef, (LLVMContextRef, Cstring, UInt32), C, Str, SLen)
end

function LLVMMDString(Str, SLen)
    @apicall(:LLVMMDString, LLVMValueRef, (Cstring, UInt32), Str, SLen)
end

function LLVMMDNodeInContext(C, Vals, Count)
    @apicall(:LLVMMDNodeInContext, LLVMValueRef, (LLVMContextRef, Ptr{LLVMValueRef}, UInt32), C, Vals, Count)
end

function LLVMMDNode(Vals, Count)
    @apicall(:LLVMMDNode, LLVMValueRef, (Ptr{LLVMValueRef}, UInt32), Vals, Count)
end

function LLVMMetadataAsValue(C, MD)
    @apicall(:LLVMMetadataAsValue, LLVMValueRef, (LLVMContextRef, LLVMMetadataRef), C, MD)
end

function LLVMValueAsMetadata(Val)
    @apicall(:LLVMValueAsMetadata, LLVMMetadataRef, (LLVMValueRef,), Val)
end

function LLVMGetMDString(V, Length)
    @apicall(:LLVMGetMDString, Cstring, (LLVMValueRef, Ptr{UInt32}), V, Length)
end

function LLVMGetMDNodeNumOperands(V)
    @apicall(:LLVMGetMDNodeNumOperands, UInt32, (LLVMValueRef,), V)
end

function LLVMGetMDNodeOperands(V, Dest)
    @apicall(:LLVMGetMDNodeOperands, Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}), V, Dest)
end

function LLVMBasicBlockAsValue(BB)
    @apicall(:LLVMBasicBlockAsValue, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMValueIsBasicBlock(Val)
    @apicall(:LLVMValueIsBasicBlock, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMValueAsBasicBlock(Val)
    @apicall(:LLVMValueAsBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Val)
end

function LLVMGetBasicBlockName(BB)
    @apicall(:LLVMGetBasicBlockName, Cstring, (LLVMBasicBlockRef,), BB)
end

function LLVMGetBasicBlockParent(BB)
    @apicall(:LLVMGetBasicBlockParent, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetBasicBlockTerminator(BB)
    @apicall(:LLVMGetBasicBlockTerminator, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMCountBasicBlocks(Fn)
    @apicall(:LLVMCountBasicBlocks, UInt32, (LLVMValueRef,), Fn)
end

function LLVMGetBasicBlocks(Fn, BasicBlocks)
    @apicall(:LLVMGetBasicBlocks, Cvoid, (LLVMValueRef, Ptr{LLVMBasicBlockRef}), Fn, BasicBlocks)
end

function LLVMGetFirstBasicBlock(Fn)
    @apicall(:LLVMGetFirstBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

function LLVMGetLastBasicBlock(Fn)
    @apicall(:LLVMGetLastBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

function LLVMGetNextBasicBlock(BB)
    @apicall(:LLVMGetNextBasicBlock, LLVMBasicBlockRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetPreviousBasicBlock(BB)
    @apicall(:LLVMGetPreviousBasicBlock, LLVMBasicBlockRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetEntryBasicBlock(Fn)
    @apicall(:LLVMGetEntryBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

function LLVMCreateBasicBlockInContext(C, Name)
    @apicall(:LLVMCreateBasicBlockInContext, LLVMBasicBlockRef, (LLVMContextRef, Cstring), C, Name)
end

function LLVMAppendBasicBlockInContext(C, Fn, Name)
    @apicall(:LLVMAppendBasicBlockInContext, LLVMBasicBlockRef, (LLVMContextRef, LLVMValueRef, Cstring), C, Fn, Name)
end

function LLVMAppendBasicBlock(Fn, Name)
    @apicall(:LLVMAppendBasicBlock, LLVMBasicBlockRef, (LLVMValueRef, Cstring), Fn, Name)
end

function LLVMInsertBasicBlockInContext(C, BB, Name)
    @apicall(:LLVMInsertBasicBlockInContext, LLVMBasicBlockRef, (LLVMContextRef, LLVMBasicBlockRef, Cstring), C, BB, Name)
end

function LLVMInsertBasicBlock(InsertBeforeBB, Name)
    @apicall(:LLVMInsertBasicBlock, LLVMBasicBlockRef, (LLVMBasicBlockRef, Cstring), InsertBeforeBB, Name)
end

function LLVMDeleteBasicBlock(BB)
    @apicall(:LLVMDeleteBasicBlock, Cvoid, (LLVMBasicBlockRef,), BB)
end

function LLVMRemoveBasicBlockFromParent(BB)
    @apicall(:LLVMRemoveBasicBlockFromParent, Cvoid, (LLVMBasicBlockRef,), BB)
end

function LLVMMoveBasicBlockBefore(BB, MovePos)
    @apicall(:LLVMMoveBasicBlockBefore, Cvoid, (LLVMBasicBlockRef, LLVMBasicBlockRef), BB, MovePos)
end

function LLVMMoveBasicBlockAfter(BB, MovePos)
    @apicall(:LLVMMoveBasicBlockAfter, Cvoid, (LLVMBasicBlockRef, LLVMBasicBlockRef), BB, MovePos)
end

function LLVMGetFirstInstruction(BB)
    @apicall(:LLVMGetFirstInstruction, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetLastInstruction(BB)
    @apicall(:LLVMGetLastInstruction, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMHasMetadata(Val)
    @apicall(:LLVMHasMetadata, Cint, (LLVMValueRef,), Val)
end

function LLVMGetMetadata(Val, KindID)
    @apicall(:LLVMGetMetadata, LLVMValueRef, (LLVMValueRef, UInt32), Val, KindID)
end

function LLVMSetMetadata(Val, KindID, Node)
    @apicall(:LLVMSetMetadata, Cvoid, (LLVMValueRef, UInt32, LLVMValueRef), Val, KindID, Node)
end

function LLVMInstructionGetAllMetadataOtherThanDebugLoc(Instr, NumEntries)
    @apicall(:LLVMInstructionGetAllMetadataOtherThanDebugLoc, Ptr{LLVMValueMetadataEntry}, (LLVMValueRef, Ptr{Csize_t}), Instr, NumEntries)
end

function LLVMGetInstructionParent(Inst)
    @apicall(:LLVMGetInstructionParent, LLVMBasicBlockRef, (LLVMValueRef,), Inst)
end

function LLVMGetNextInstruction(Inst)
    @apicall(:LLVMGetNextInstruction, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetPreviousInstruction(Inst)
    @apicall(:LLVMGetPreviousInstruction, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMInstructionRemoveFromParent(Inst)
    @apicall(:LLVMInstructionRemoveFromParent, Cvoid, (LLVMValueRef,), Inst)
end

function LLVMInstructionEraseFromParent(Inst)
    @apicall(:LLVMInstructionEraseFromParent, Cvoid, (LLVMValueRef,), Inst)
end

function LLVMGetInstructionOpcode(Inst)
    @apicall(:LLVMGetInstructionOpcode, LLVMOpcode, (LLVMValueRef,), Inst)
end

function LLVMGetICmpPredicate(Inst)
    @apicall(:LLVMGetICmpPredicate, LLVMIntPredicate, (LLVMValueRef,), Inst)
end

function LLVMGetFCmpPredicate(Inst)
    @apicall(:LLVMGetFCmpPredicate, LLVMRealPredicate, (LLVMValueRef,), Inst)
end

function LLVMInstructionClone(Inst)
    @apicall(:LLVMInstructionClone, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMIsATerminatorInst(Inst)
    @apicall(:LLVMIsATerminatorInst, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetNumArgOperands(Instr)
    @apicall(:LLVMGetNumArgOperands, UInt32, (LLVMValueRef,), Instr)
end

function LLVMSetInstructionCallConv(Instr, CC)
    @apicall(:LLVMSetInstructionCallConv, Cvoid, (LLVMValueRef, UInt32), Instr, CC)
end

function LLVMGetInstructionCallConv(Instr)
    @apicall(:LLVMGetInstructionCallConv, UInt32, (LLVMValueRef,), Instr)
end

function LLVMSetInstrParamAlignment(Instr, index, Align)
    @apicall(:LLVMSetInstrParamAlignment, Cvoid, (LLVMValueRef, UInt32, UInt32), Instr, index, Align)
end

function LLVMAddCallSiteAttribute(C, Idx, A)
    @apicall(:LLVMAddCallSiteAttribute, Cvoid, (LLVMValueRef, LLVMAttributeIndex, LLVMAttributeRef), C, Idx, A)
end

function LLVMGetCallSiteAttributeCount(C, Idx)
    @apicall(:LLVMGetCallSiteAttributeCount, UInt32, (LLVMValueRef, LLVMAttributeIndex), C, Idx)
end

function LLVMGetCallSiteAttributes(C, Idx, Attrs)
    @apicall(:LLVMGetCallSiteAttributes, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Ptr{LLVMAttributeRef}), C, Idx, Attrs)
end

function LLVMGetCallSiteEnumAttribute(C, Idx, KindID)
    @apicall(:LLVMGetCallSiteEnumAttribute, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, UInt32), C, Idx, KindID)
end

function LLVMGetCallSiteStringAttribute(C, Idx, K, KLen)
    @apicall(:LLVMGetCallSiteStringAttribute, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), C, Idx, K, KLen)
end

function LLVMRemoveCallSiteEnumAttribute(C, Idx, KindID)
    @apicall(:LLVMRemoveCallSiteEnumAttribute, Cvoid, (LLVMValueRef, LLVMAttributeIndex, UInt32), C, Idx, KindID)
end

function LLVMRemoveCallSiteStringAttribute(C, Idx, K, KLen)
    @apicall(:LLVMRemoveCallSiteStringAttribute, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), C, Idx, K, KLen)
end

function LLVMGetCalledFunctionType(C)
    @apicall(:LLVMGetCalledFunctionType, LLVMTypeRef, (LLVMValueRef,), C)
end

function LLVMGetCalledValue(Instr)
    @apicall(:LLVMGetCalledValue, LLVMValueRef, (LLVMValueRef,), Instr)
end

function LLVMIsTailCall(CallInst)
    @apicall(:LLVMIsTailCall, LLVMBool, (LLVMValueRef,), CallInst)
end

function LLVMSetTailCall(CallInst, IsTailCall)
    @apicall(:LLVMSetTailCall, Cvoid, (LLVMValueRef, LLVMBool), CallInst, IsTailCall)
end

function LLVMGetNormalDest(InvokeInst)
    @apicall(:LLVMGetNormalDest, LLVMBasicBlockRef, (LLVMValueRef,), InvokeInst)
end

function LLVMGetUnwindDest(InvokeInst)
    @apicall(:LLVMGetUnwindDest, LLVMBasicBlockRef, (LLVMValueRef,), InvokeInst)
end

function LLVMSetNormalDest(InvokeInst, B)
    @apicall(:LLVMSetNormalDest, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), InvokeInst, B)
end

function LLVMSetUnwindDest(InvokeInst, B)
    @apicall(:LLVMSetUnwindDest, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), InvokeInst, B)
end

function LLVMGetNumSuccessors(Term)
    @apicall(:LLVMGetNumSuccessors, UInt32, (LLVMValueRef,), Term)
end

function LLVMGetSuccessor(Term, i)
    @apicall(:LLVMGetSuccessor, LLVMBasicBlockRef, (LLVMValueRef, UInt32), Term, i)
end

function LLVMSetSuccessor(Term, i, block)
    @apicall(:LLVMSetSuccessor, Cvoid, (LLVMValueRef, UInt32, LLVMBasicBlockRef), Term, i, block)
end

function LLVMIsConditional(Branch)
    @apicall(:LLVMIsConditional, LLVMBool, (LLVMValueRef,), Branch)
end

function LLVMGetCondition(Branch)
    @apicall(:LLVMGetCondition, LLVMValueRef, (LLVMValueRef,), Branch)
end

function LLVMSetCondition(Branch, Cond)
    @apicall(:LLVMSetCondition, Cvoid, (LLVMValueRef, LLVMValueRef), Branch, Cond)
end

function LLVMGetSwitchDefaultDest(SwitchInstr)
    @apicall(:LLVMGetSwitchDefaultDest, LLVMBasicBlockRef, (LLVMValueRef,), SwitchInstr)
end

function LLVMGetAllocatedType(Alloca)
    @apicall(:LLVMGetAllocatedType, LLVMTypeRef, (LLVMValueRef,), Alloca)
end

function LLVMIsInBounds(GEP)
    @apicall(:LLVMIsInBounds, LLVMBool, (LLVMValueRef,), GEP)
end

function LLVMSetIsInBounds(GEP, InBounds)
    @apicall(:LLVMSetIsInBounds, Cvoid, (LLVMValueRef, LLVMBool), GEP, InBounds)
end

function LLVMAddIncoming(PhiNode, IncomingValues, IncomingBlocks, Count)
    @apicall(:LLVMAddIncoming, Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}, Ptr{LLVMBasicBlockRef}, UInt32), PhiNode, IncomingValues, IncomingBlocks, Count)
end

function LLVMCountIncoming(PhiNode)
    @apicall(:LLVMCountIncoming, UInt32, (LLVMValueRef,), PhiNode)
end

function LLVMGetIncomingValue(PhiNode, Index)
    @apicall(:LLVMGetIncomingValue, LLVMValueRef, (LLVMValueRef, UInt32), PhiNode, Index)
end

function LLVMGetIncomingBlock(PhiNode, Index)
    @apicall(:LLVMGetIncomingBlock, LLVMBasicBlockRef, (LLVMValueRef, UInt32), PhiNode, Index)
end

function LLVMGetNumIndices(Inst)
    @apicall(:LLVMGetNumIndices, UInt32, (LLVMValueRef,), Inst)
end

function LLVMGetIndices(Inst)
    @apicall(:LLVMGetIndices, Ptr{UInt32}, (LLVMValueRef,), Inst)
end

function LLVMCreateBuilderInContext(C)
    @apicall(:LLVMCreateBuilderInContext, LLVMBuilderRef, (LLVMContextRef,), C)
end

function LLVMCreateBuilder()
    @apicall(:LLVMCreateBuilder, LLVMBuilderRef, ())
end

function LLVMPositionBuilder(Builder, Block, Instr)
    @apicall(:LLVMPositionBuilder, Cvoid, (LLVMBuilderRef, LLVMBasicBlockRef, LLVMValueRef), Builder, Block, Instr)
end

function LLVMPositionBuilderBefore(Builder, Instr)
    @apicall(:LLVMPositionBuilderBefore, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Instr)
end

function LLVMPositionBuilderAtEnd(Builder, Block)
    @apicall(:LLVMPositionBuilderAtEnd, Cvoid, (LLVMBuilderRef, LLVMBasicBlockRef), Builder, Block)
end

function LLVMGetInsertBlock(Builder)
    @apicall(:LLVMGetInsertBlock, LLVMBasicBlockRef, (LLVMBuilderRef,), Builder)
end

function LLVMClearInsertionPosition(Builder)
    @apicall(:LLVMClearInsertionPosition, Cvoid, (LLVMBuilderRef,), Builder)
end

function LLVMInsertIntoBuilder(Builder, Instr)
    @apicall(:LLVMInsertIntoBuilder, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Instr)
end

function LLVMInsertIntoBuilderWithName(Builder, Instr, Name)
    @apicall(:LLVMInsertIntoBuilderWithName, Cvoid, (LLVMBuilderRef, LLVMValueRef, Cstring), Builder, Instr, Name)
end

function LLVMDisposeBuilder(Builder)
    @apicall(:LLVMDisposeBuilder, Cvoid, (LLVMBuilderRef,), Builder)
end

function LLVMSetCurrentDebugLocation(Builder, L)
    @apicall(:LLVMSetCurrentDebugLocation, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, L)
end

function LLVMGetCurrentDebugLocation(Builder)
    @apicall(:LLVMGetCurrentDebugLocation, LLVMValueRef, (LLVMBuilderRef,), Builder)
end

function LLVMSetInstDebugLocation(Builder, Inst)
    @apicall(:LLVMSetInstDebugLocation, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Inst)
end

function LLVMBuildRetVoid(arg1)
    @apicall(:LLVMBuildRetVoid, LLVMValueRef, (LLVMBuilderRef,), arg1)
end

function LLVMBuildRet(arg1, V)
    @apicall(:LLVMBuildRet, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), arg1, V)
end

function LLVMBuildAggregateRet(arg1, RetVals, N)
    @apicall(:LLVMBuildAggregateRet, LLVMValueRef, (LLVMBuilderRef, Ptr{LLVMValueRef}, UInt32), arg1, RetVals, N)
end

function LLVMBuildBr(arg1, Dest)
    @apicall(:LLVMBuildBr, LLVMValueRef, (LLVMBuilderRef, LLVMBasicBlockRef), arg1, Dest)
end

function LLVMBuildCondBr(arg1, If, Then, Else)
    @apicall(:LLVMBuildCondBr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, LLVMBasicBlockRef), arg1, If, Then, Else)
end

function LLVMBuildSwitch(arg1, V, Else, NumCases)
    @apicall(:LLVMBuildSwitch, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, UInt32), arg1, V, Else, NumCases)
end

function LLVMBuildIndirectBr(B, Addr, NumDests)
    @apicall(:LLVMBuildIndirectBr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32), B, Addr, NumDests)
end

function LLVMBuildInvoke(arg1, Fn, Args, NumArgs, Then, Catch, Name)
    @apicall(:LLVMBuildInvoke, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, LLVMBasicBlockRef, LLVMBasicBlockRef, Cstring), arg1, Fn, Args, NumArgs, Then, Catch, Name)
end

function LLVMBuildInvoke2(arg1, Ty, Fn, Args, NumArgs, Then, Catch, Name)
    @apicall(:LLVMBuildInvoke2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, LLVMBasicBlockRef, LLVMBasicBlockRef, Cstring), arg1, Ty, Fn, Args, NumArgs, Then, Catch, Name)
end

function LLVMBuildUnreachable(arg1)
    @apicall(:LLVMBuildUnreachable, LLVMValueRef, (LLVMBuilderRef,), arg1)
end

function LLVMBuildResume(B, Exn)
    @apicall(:LLVMBuildResume, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), B, Exn)
end

function LLVMBuildLandingPad(B, Ty, PersFn, NumClauses, Name)
    @apicall(:LLVMBuildLandingPad, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, UInt32, Cstring), B, Ty, PersFn, NumClauses, Name)
end

function LLVMBuildCleanupRet(B, CatchPad, BB)
    @apicall(:LLVMBuildCleanupRet, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef), B, CatchPad, BB)
end

function LLVMBuildCatchRet(B, CatchPad, BB)
    @apicall(:LLVMBuildCatchRet, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef), B, CatchPad, BB)
end

function LLVMBuildCatchPad(B, ParentPad, Args, NumArgs, Name)
    @apicall(:LLVMBuildCatchPad, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, ParentPad, Args, NumArgs, Name)
end

function LLVMBuildCleanupPad(B, ParentPad, Args, NumArgs, Name)
    @apicall(:LLVMBuildCleanupPad, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, ParentPad, Args, NumArgs, Name)
end

function LLVMBuildCatchSwitch(B, ParentPad, UnwindBB, NumHandlers, Name)
    @apicall(:LLVMBuildCatchSwitch, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, UInt32, Cstring), B, ParentPad, UnwindBB, NumHandlers, Name)
end

function LLVMAddCase(Switch, OnVal, Dest)
    @apicall(:LLVMAddCase, Cvoid, (LLVMValueRef, LLVMValueRef, LLVMBasicBlockRef), Switch, OnVal, Dest)
end

function LLVMAddDestination(IndirectBr, Dest)
    @apicall(:LLVMAddDestination, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), IndirectBr, Dest)
end

function LLVMGetNumClauses(LandingPad)
    @apicall(:LLVMGetNumClauses, UInt32, (LLVMValueRef,), LandingPad)
end

function LLVMGetClause(LandingPad, Idx)
    @apicall(:LLVMGetClause, LLVMValueRef, (LLVMValueRef, UInt32), LandingPad, Idx)
end

function LLVMAddClause(LandingPad, ClauseVal)
    @apicall(:LLVMAddClause, Cvoid, (LLVMValueRef, LLVMValueRef), LandingPad, ClauseVal)
end

function LLVMIsCleanup(LandingPad)
    @apicall(:LLVMIsCleanup, LLVMBool, (LLVMValueRef,), LandingPad)
end

function LLVMSetCleanup(LandingPad, Val)
    @apicall(:LLVMSetCleanup, Cvoid, (LLVMValueRef, LLVMBool), LandingPad, Val)
end

function LLVMAddHandler(CatchSwitch, Dest)
    @apicall(:LLVMAddHandler, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), CatchSwitch, Dest)
end

function LLVMGetNumHandlers(CatchSwitch)
    @apicall(:LLVMGetNumHandlers, UInt32, (LLVMValueRef,), CatchSwitch)
end

function LLVMGetHandlers(CatchSwitch, Handlers)
    @apicall(:LLVMGetHandlers, Cvoid, (LLVMValueRef, Ptr{LLVMBasicBlockRef}), CatchSwitch, Handlers)
end

function LLVMGetArgOperand(Funclet, i)
    @apicall(:LLVMGetArgOperand, LLVMValueRef, (LLVMValueRef, UInt32), Funclet, i)
end

function LLVMSetArgOperand(Funclet, i, value)
    @apicall(:LLVMSetArgOperand, Cvoid, (LLVMValueRef, UInt32, LLVMValueRef), Funclet, i, value)
end

function LLVMGetParentCatchSwitch(CatchPad)
    @apicall(:LLVMGetParentCatchSwitch, LLVMValueRef, (LLVMValueRef,), CatchPad)
end

function LLVMSetParentCatchSwitch(CatchPad, CatchSwitch)
    @apicall(:LLVMSetParentCatchSwitch, Cvoid, (LLVMValueRef, LLVMValueRef), CatchPad, CatchSwitch)
end

function LLVMBuildAdd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWAdd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNSWAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWAdd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNUWAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFAdd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSub(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWSub(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNSWSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWSub(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNUWSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFSub(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildMul(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWMul(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNSWMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWMul(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNUWMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFMul(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildUDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildUDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildExactUDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildExactUDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildSDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildExactSDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildExactSDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildURem(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildURem, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSRem(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildSRem, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFRem(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFRem, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildShl(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildShl, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildLShr(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildLShr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildAShr(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildAShr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildAnd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildAnd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildOr(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildOr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildXor(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildXor, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildBinOp(B, Op, LHS, RHS, Name)
    @apicall(:LLVMBuildBinOp, LLVMValueRef, (LLVMBuilderRef, LLVMOpcode, LLVMValueRef, LLVMValueRef, Cstring), B, Op, LHS, RHS, Name)
end

function LLVMBuildNeg(arg1, V, Name)
    @apicall(:LLVMBuildNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildNSWNeg(B, V, Name)
    @apicall(:LLVMBuildNSWNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), B, V, Name)
end

function LLVMBuildNUWNeg(B, V, Name)
    @apicall(:LLVMBuildNUWNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), B, V, Name)
end

function LLVMBuildFNeg(arg1, V, Name)
    @apicall(:LLVMBuildFNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildNot(arg1, V, Name)
    @apicall(:LLVMBuildNot, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildMalloc(arg1, Ty, Name)
    @apicall(:LLVMBuildMalloc, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildArrayMalloc(arg1, Ty, Val, Name)
    @apicall(:LLVMBuildArrayMalloc, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring), arg1, Ty, Val, Name)
end

function LLVMBuildMemSet(B, Ptr, Val, Len, Align)
    @apicall(:LLVMBuildMemSet, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, UInt32), B, Ptr, Val, Len, Align)
end

function LLVMBuildMemCpy(B, Dst, DstAlign, Src, SrcAlign, Size)
    @apicall(:LLVMBuildMemCpy, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32, LLVMValueRef, UInt32, LLVMValueRef), B, Dst, DstAlign, Src, SrcAlign, Size)
end

function LLVMBuildMemMove(B, Dst, DstAlign, Src, SrcAlign, Size)
    @apicall(:LLVMBuildMemMove, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32, LLVMValueRef, UInt32, LLVMValueRef), B, Dst, DstAlign, Src, SrcAlign, Size)
end

function LLVMBuildAlloca(arg1, Ty, Name)
    @apicall(:LLVMBuildAlloca, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildArrayAlloca(arg1, Ty, Val, Name)
    @apicall(:LLVMBuildArrayAlloca, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring), arg1, Ty, Val, Name)
end

function LLVMBuildFree(arg1, PointerVal)
    @apicall(:LLVMBuildFree, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), arg1, PointerVal)
end

function LLVMBuildLoad(arg1, PointerVal, Name)
    @apicall(:LLVMBuildLoad, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, PointerVal, Name)
end

function LLVMBuildLoad2(arg1, Ty, PointerVal, Name)
    @apicall(:LLVMBuildLoad2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring), arg1, Ty, PointerVal, Name)
end

function LLVMBuildStore(arg1, Val, Ptr)
    @apicall(:LLVMBuildStore, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef), arg1, Val, Ptr)
end

function LLVMBuildGEP(B, Pointer, Indices, NumIndices, Name)
    @apicall(:LLVMBuildGEP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildInBoundsGEP(B, Pointer, Indices, NumIndices, Name)
    @apicall(:LLVMBuildInBoundsGEP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildStructGEP(B, Pointer, Idx, Name)
    @apicall(:LLVMBuildStructGEP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32, Cstring), B, Pointer, Idx, Name)
end

function LLVMBuildGEP2(B, Ty, Pointer, Indices, NumIndices, Name)
    @apicall(:LLVMBuildGEP2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, Ty, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildInBoundsGEP2(B, Ty, Pointer, Indices, NumIndices, Name)
    @apicall(:LLVMBuildInBoundsGEP2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, Ty, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildStructGEP2(B, Ty, Pointer, Idx, Name)
    @apicall(:LLVMBuildStructGEP2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, UInt32, Cstring), B, Ty, Pointer, Idx, Name)
end

function LLVMBuildGlobalString(B, Str, Name)
    @apicall(:LLVMBuildGlobalString, LLVMValueRef, (LLVMBuilderRef, Cstring, Cstring), B, Str, Name)
end

function LLVMBuildGlobalStringPtr(B, Str, Name)
    @apicall(:LLVMBuildGlobalStringPtr, LLVMValueRef, (LLVMBuilderRef, Cstring, Cstring), B, Str, Name)
end

function LLVMGetVolatile(MemoryAccessInst)
    @apicall(:LLVMGetVolatile, LLVMBool, (LLVMValueRef,), MemoryAccessInst)
end

function LLVMSetVolatile(MemoryAccessInst, IsVolatile)
    @apicall(:LLVMSetVolatile, Cvoid, (LLVMValueRef, LLVMBool), MemoryAccessInst, IsVolatile)
end

function LLVMGetOrdering(MemoryAccessInst)
    @apicall(:LLVMGetOrdering, LLVMAtomicOrdering, (LLVMValueRef,), MemoryAccessInst)
end

function LLVMSetOrdering(MemoryAccessInst, Ordering)
    @apicall(:LLVMSetOrdering, Cvoid, (LLVMValueRef, LLVMAtomicOrdering), MemoryAccessInst, Ordering)
end

function LLVMBuildTrunc(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildTrunc, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildZExt(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildZExt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSExt(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildSExt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPToUI(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPToUI, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPToSI(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPToSI, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildUIToFP(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildUIToFP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSIToFP(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildSIToFP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPTrunc(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPTrunc, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPExt(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPExt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildPtrToInt(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildPtrToInt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildIntToPtr(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildIntToPtr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildBitCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildAddrSpaceCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildAddrSpaceCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildZExtOrBitCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildZExtOrBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSExtOrBitCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildSExtOrBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildTruncOrBitCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildTruncOrBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildCast(B, Op, Val, DestTy, Name)
    @apicall(:LLVMBuildCast, LLVMValueRef, (LLVMBuilderRef, LLVMOpcode, LLVMValueRef, LLVMTypeRef, Cstring), B, Op, Val, DestTy, Name)
end

function LLVMBuildPointerCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildPointerCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildIntCast2(arg1, Val, DestTy, IsSigned, Name)
    @apicall(:LLVMBuildIntCast2, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, LLVMBool, Cstring), arg1, Val, DestTy, IsSigned, Name)
end

function LLVMBuildFPCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildIntCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildIntCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildICmp(arg1, Op, LHS, RHS, Name)
    @apicall(:LLVMBuildICmp, LLVMValueRef, (LLVMBuilderRef, LLVMIntPredicate, LLVMValueRef, LLVMValueRef, Cstring), arg1, Op, LHS, RHS, Name)
end

function LLVMBuildFCmp(arg1, Op, LHS, RHS, Name)
    @apicall(:LLVMBuildFCmp, LLVMValueRef, (LLVMBuilderRef, LLVMRealPredicate, LLVMValueRef, LLVMValueRef, Cstring), arg1, Op, LHS, RHS, Name)
end

function LLVMBuildPhi(arg1, Ty, Name)
    @apicall(:LLVMBuildPhi, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildCall(arg1, Fn, Args, NumArgs, Name)
    @apicall(:LLVMBuildCall, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), arg1, Fn, Args, NumArgs, Name)
end

function LLVMBuildCall2(arg1, arg2, Fn, Args, NumArgs, Name)
    @apicall(:LLVMBuildCall2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), arg1, arg2, Fn, Args, NumArgs, Name)
end

function LLVMBuildSelect(arg1, If, Then, Else, Name)
    @apicall(:LLVMBuildSelect, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, If, Then, Else, Name)
end

function LLVMBuildVAArg(arg1, List, Ty, Name)
    @apicall(:LLVMBuildVAArg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, List, Ty, Name)
end

function LLVMBuildExtractElement(arg1, VecVal, Index, Name)
    @apicall(:LLVMBuildExtractElement, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, VecVal, Index, Name)
end

function LLVMBuildInsertElement(arg1, VecVal, EltVal, Index, Name)
    @apicall(:LLVMBuildInsertElement, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, VecVal, EltVal, Index, Name)
end

function LLVMBuildShuffleVector(arg1, V1, V2, Mask, Name)
    @apicall(:LLVMBuildShuffleVector, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, V1, V2, Mask, Name)
end

function LLVMBuildExtractValue(arg1, AggVal, Index, Name)
    @apicall(:LLVMBuildExtractValue, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32, Cstring), arg1, AggVal, Index, Name)
end

function LLVMBuildInsertValue(arg1, AggVal, EltVal, Index, Name)
    @apicall(:LLVMBuildInsertValue, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, UInt32, Cstring), arg1, AggVal, EltVal, Index, Name)
end

function LLVMBuildIsNull(arg1, Val, Name)
    @apicall(:LLVMBuildIsNull, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, Val, Name)
end

function LLVMBuildIsNotNull(arg1, Val, Name)
    @apicall(:LLVMBuildIsNotNull, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, Val, Name)
end

function LLVMBuildPtrDiff(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildPtrDiff, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFence(B, ordering, singleThread, Name)
    @apicall(:LLVMBuildFence, LLVMValueRef, (LLVMBuilderRef, LLVMAtomicOrdering, LLVMBool, Cstring), B, ordering, singleThread, Name)
end

function LLVMBuildAtomicRMW(B, op, PTR, Val, ordering, singleThread)
    @apicall(:LLVMBuildAtomicRMW, LLVMValueRef, (LLVMBuilderRef, LLVMAtomicRMWBinOp, LLVMValueRef, LLVMValueRef, LLVMAtomicOrdering, LLVMBool), B, op, PTR, Val, ordering, singleThread)
end

function LLVMBuildAtomicCmpXchg(B, Ptr, Cmp, New, SuccessOrdering, FailureOrdering, SingleThread)
    @apicall(:LLVMBuildAtomicCmpXchg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, LLVMAtomicOrdering, LLVMAtomicOrdering, LLVMBool), B, Ptr, Cmp, New, SuccessOrdering, FailureOrdering, SingleThread)
end

function LLVMIsAtomicSingleThread(AtomicInst)
    @apicall(:LLVMIsAtomicSingleThread, LLVMBool, (LLVMValueRef,), AtomicInst)
end

function LLVMSetAtomicSingleThread(AtomicInst, SingleThread)
    @apicall(:LLVMSetAtomicSingleThread, Cvoid, (LLVMValueRef, LLVMBool), AtomicInst, SingleThread)
end

function LLVMGetCmpXchgSuccessOrdering(CmpXchgInst)
    @apicall(:LLVMGetCmpXchgSuccessOrdering, LLVMAtomicOrdering, (LLVMValueRef,), CmpXchgInst)
end

function LLVMSetCmpXchgSuccessOrdering(CmpXchgInst, Ordering)
    @apicall(:LLVMSetCmpXchgSuccessOrdering, Cvoid, (LLVMValueRef, LLVMAtomicOrdering), CmpXchgInst, Ordering)
end

function LLVMGetCmpXchgFailureOrdering(CmpXchgInst)
    @apicall(:LLVMGetCmpXchgFailureOrdering, LLVMAtomicOrdering, (LLVMValueRef,), CmpXchgInst)
end

function LLVMSetCmpXchgFailureOrdering(CmpXchgInst, Ordering)
    @apicall(:LLVMSetCmpXchgFailureOrdering, Cvoid, (LLVMValueRef, LLVMAtomicOrdering), CmpXchgInst, Ordering)
end

function LLVMCreateModuleProviderForExistingModule(M)
    @apicall(:LLVMCreateModuleProviderForExistingModule, LLVMModuleProviderRef, (LLVMModuleRef,), M)
end

function LLVMDisposeModuleProvider(M)
    @apicall(:LLVMDisposeModuleProvider, Cvoid, (LLVMModuleProviderRef,), M)
end

function LLVMCreateMemoryBufferWithContentsOfFile(Path, OutMemBuf, OutMessage)
    @apicall(:LLVMCreateMemoryBufferWithContentsOfFile, LLVMBool, (Cstring, Ptr{LLVMMemoryBufferRef}, Ptr{Cstring}), Path, OutMemBuf, OutMessage)
end

function LLVMCreateMemoryBufferWithSTDIN(OutMemBuf, OutMessage)
    @apicall(:LLVMCreateMemoryBufferWithSTDIN, LLVMBool, (Ptr{LLVMMemoryBufferRef}, Ptr{Cstring}), OutMemBuf, OutMessage)
end

function LLVMCreateMemoryBufferWithMemoryRange(InputData, InputDataLength, BufferName, RequiresNullTerminator)
    @apicall(:LLVMCreateMemoryBufferWithMemoryRange, LLVMMemoryBufferRef, (Cstring, Csize_t, Cstring, LLVMBool), InputData, InputDataLength, BufferName, RequiresNullTerminator)
end

function LLVMCreateMemoryBufferWithMemoryRangeCopy(InputData, InputDataLength, BufferName)
    @apicall(:LLVMCreateMemoryBufferWithMemoryRangeCopy, LLVMMemoryBufferRef, (Cstring, Csize_t, Cstring), InputData, InputDataLength, BufferName)
end

function LLVMGetBufferStart(MemBuf)
    @apicall(:LLVMGetBufferStart, Cstring, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMGetBufferSize(MemBuf)
    @apicall(:LLVMGetBufferSize, Csize_t, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMDisposeMemoryBuffer(MemBuf)
    @apicall(:LLVMDisposeMemoryBuffer, Cvoid, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMGetGlobalPassRegistry()
    @apicall(:LLVMGetGlobalPassRegistry, LLVMPassRegistryRef, ())
end

function LLVMCreatePassManager()
    @apicall(:LLVMCreatePassManager, LLVMPassManagerRef, ())
end

function LLVMCreateFunctionPassManagerForModule(M)
    @apicall(:LLVMCreateFunctionPassManagerForModule, LLVMPassManagerRef, (LLVMModuleRef,), M)
end

function LLVMCreateFunctionPassManager(MP)
    @apicall(:LLVMCreateFunctionPassManager, LLVMPassManagerRef, (LLVMModuleProviderRef,), MP)
end

function LLVMRunPassManager(PM, M)
    @apicall(:LLVMRunPassManager, LLVMBool, (LLVMPassManagerRef, LLVMModuleRef), PM, M)
end

function LLVMInitializeFunctionPassManager(FPM)
    @apicall(:LLVMInitializeFunctionPassManager, LLVMBool, (LLVMPassManagerRef,), FPM)
end

function LLVMRunFunctionPassManager(FPM, F)
    @apicall(:LLVMRunFunctionPassManager, LLVMBool, (LLVMPassManagerRef, LLVMValueRef), FPM, F)
end

function LLVMFinalizeFunctionPassManager(FPM)
    @apicall(:LLVMFinalizeFunctionPassManager, LLVMBool, (LLVMPassManagerRef,), FPM)
end

function LLVMDisposePassManager(PM)
    @apicall(:LLVMDisposePassManager, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMStartMultithreaded()
    @apicall(:LLVMStartMultithreaded, LLVMBool, ())
end

function LLVMStopMultithreaded()
    @apicall(:LLVMStopMultithreaded, Cvoid, ())
end

function LLVMIsMultithreaded()
    @apicall(:LLVMIsMultithreaded, LLVMBool, ())
end

function LLVMDebugMetadataVersion()
    @apicall(:LLVMDebugMetadataVersion, UInt32, ())
end

function LLVMGetModuleDebugMetadataVersion(Module)
    @apicall(:LLVMGetModuleDebugMetadataVersion, UInt32, (LLVMModuleRef,), Module)
end

function LLVMStripModuleDebugInfo(Module)
    @apicall(:LLVMStripModuleDebugInfo, LLVMBool, (LLVMModuleRef,), Module)
end

function LLVMCreateDIBuilderDisallowUnresolved(M)
    @apicall(:LLVMCreateDIBuilderDisallowUnresolved, LLVMDIBuilderRef, (LLVMModuleRef,), M)
end

function LLVMCreateDIBuilder(M)
    @apicall(:LLVMCreateDIBuilder, LLVMDIBuilderRef, (LLVMModuleRef,), M)
end

function LLVMDisposeDIBuilder(Builder)
    @apicall(:LLVMDisposeDIBuilder, Cvoid, (LLVMDIBuilderRef,), Builder)
end

function LLVMDIBuilderFinalize(Builder)
    @apicall(:LLVMDIBuilderFinalize, Cvoid, (LLVMDIBuilderRef,), Builder)
end

function LLVMDIBuilderCreateCompileUnit(Builder, Lang, FileRef, Producer, ProducerLen, isOptimized, Flags, FlagsLen, RuntimeVer, SplitName, SplitNameLen, Kind, DWOId, SplitDebugInlining, DebugInfoForProfiling)
    @apicall(:LLVMDIBuilderCreateCompileUnit, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMDWARFSourceLanguage, LLVMMetadataRef, Cstring, Csize_t, LLVMBool, Cstring, Csize_t, UInt32, Cstring, Csize_t, LLVMDWARFEmissionKind, UInt32, LLVMBool, LLVMBool), Builder, Lang, FileRef, Producer, ProducerLen, isOptimized, Flags, FlagsLen, RuntimeVer, SplitName, SplitNameLen, Kind, DWOId, SplitDebugInlining, DebugInfoForProfiling)
end

function LLVMDIBuilderCreateFile(Builder, Filename, FilenameLen, Directory, DirectoryLen)
    @apicall(:LLVMDIBuilderCreateFile, LLVMMetadataRef, (LLVMDIBuilderRef, Cstring, Csize_t, Cstring, Csize_t), Builder, Filename, FilenameLen, Directory, DirectoryLen)
end

function LLVMDIBuilderCreateModule(Builder, ParentScope, Name, NameLen, ConfigMacros, ConfigMacrosLen, IncludePath, IncludePathLen, ISysRoot, ISysRootLen)
    @apicall(:LLVMDIBuilderCreateModule, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, Cstring, Csize_t, Cstring, Csize_t, Cstring, Csize_t), Builder, ParentScope, Name, NameLen, ConfigMacros, ConfigMacrosLen, IncludePath, IncludePathLen, ISysRoot, ISysRootLen)
end

function LLVMDIBuilderCreateNameSpace(Builder, ParentScope, Name, NameLen, ExportSymbols)
    @apicall(:LLVMDIBuilderCreateNameSpace, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMBool), Builder, ParentScope, Name, NameLen, ExportSymbols)
end

function LLVMDIBuilderCreateFunction(Builder, Scope, Name, NameLen, LinkageName, LinkageNameLen, File, LineNo, Ty, IsLocalToUnit, IsDefinition, ScopeLine, Flags, IsOptimized)
    @apicall(:LLVMDIBuilderCreateFunction, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, Cstring, Csize_t, LLVMMetadataRef, UInt32, LLVMMetadataRef, LLVMBool, LLVMBool, UInt32, LLVMDIFlags, LLVMBool), Builder, Scope, Name, NameLen, LinkageName, LinkageNameLen, File, LineNo, Ty, IsLocalToUnit, IsDefinition, ScopeLine, Flags, IsOptimized)
end

function LLVMDIBuilderCreateLexicalBlock(Builder, Scope, File, Line, Column)
    @apicall(:LLVMDIBuilderCreateLexicalBlock, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, UInt32, UInt32), Builder, Scope, File, Line, Column)
end

function LLVMDIBuilderCreateLexicalBlockFile(Builder, Scope, File, Discriminator)
    @apicall(:LLVMDIBuilderCreateLexicalBlockFile, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, UInt32), Builder, Scope, File, Discriminator)
end

function LLVMDIBuilderCreateImportedModuleFromNamespace(Builder, Scope, NS, File, Line)
    @apicall(:LLVMDIBuilderCreateImportedModuleFromNamespace, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, UInt32), Builder, Scope, NS, File, Line)
end

function LLVMDIBuilderCreateImportedModuleFromAlias(Builder, Scope, ImportedEntity, File, Line)
    @apicall(:LLVMDIBuilderCreateImportedModuleFromAlias, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, UInt32), Builder, Scope, ImportedEntity, File, Line)
end

function LLVMDIBuilderCreateImportedModuleFromModule(Builder, Scope, M, File, Line)
    @apicall(:LLVMDIBuilderCreateImportedModuleFromModule, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, UInt32), Builder, Scope, M, File, Line)
end

function LLVMDIBuilderCreateImportedDeclaration(Builder, Scope, Decl, File, Line, Name, NameLen)
    @apicall(:LLVMDIBuilderCreateImportedDeclaration, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, UInt32, Cstring, Csize_t), Builder, Scope, Decl, File, Line, Name, NameLen)
end

function LLVMDIBuilderCreateDebugLocation(Ctx, Line, Column, Scope, InlinedAt)
    @apicall(:LLVMDIBuilderCreateDebugLocation, LLVMMetadataRef, (LLVMContextRef, UInt32, UInt32, LLVMMetadataRef, LLVMMetadataRef), Ctx, Line, Column, Scope, InlinedAt)
end

function LLVMDILocationGetLine(Location)
    @apicall(:LLVMDILocationGetLine, UInt32, (LLVMMetadataRef,), Location)
end

function LLVMDILocationGetColumn(Location)
    @apicall(:LLVMDILocationGetColumn, UInt32, (LLVMMetadataRef,), Location)
end

function LLVMDILocationGetScope(Location)
    @apicall(:LLVMDILocationGetScope, LLVMMetadataRef, (LLVMMetadataRef,), Location)
end

function LLVMDIBuilderGetOrCreateTypeArray(Builder, Data, NumElements)
    @apicall(:LLVMDIBuilderGetOrCreateTypeArray, LLVMMetadataRef, (LLVMDIBuilderRef, Ptr{LLVMMetadataRef}, Csize_t), Builder, Data, NumElements)
end

function LLVMDIBuilderCreateSubroutineType(Builder, File, ParameterTypes, NumParameterTypes, Flags)
    @apicall(:LLVMDIBuilderCreateSubroutineType, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Ptr{LLVMMetadataRef}, UInt32, LLVMDIFlags), Builder, File, ParameterTypes, NumParameterTypes, Flags)
end

function LLVMDIBuilderCreateEnumerationType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Elements, NumElements, ClassTy)
    @apicall(:LLVMDIBuilderCreateEnumerationType, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, UInt32, UInt64, UInt32, Ptr{LLVMMetadataRef}, UInt32, LLVMMetadataRef), Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Elements, NumElements, ClassTy)
end

function LLVMDIBuilderCreateUnionType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Flags, Elements, NumElements, RunTimeLang, UniqueId, UniqueIdLen)
    @apicall(:LLVMDIBuilderCreateUnionType, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, UInt32, UInt64, UInt32, LLVMDIFlags, Ptr{LLVMMetadataRef}, UInt32, UInt32, Cstring, Csize_t), Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Flags, Elements, NumElements, RunTimeLang, UniqueId, UniqueIdLen)
end

function LLVMDIBuilderCreateArrayType(Builder, Size, AlignInBits, Ty, Subscripts, NumSubscripts)
    @apicall(:LLVMDIBuilderCreateArrayType, LLVMMetadataRef, (LLVMDIBuilderRef, UInt64, UInt32, LLVMMetadataRef, Ptr{LLVMMetadataRef}, UInt32), Builder, Size, AlignInBits, Ty, Subscripts, NumSubscripts)
end

function LLVMDIBuilderCreateVectorType(Builder, Size, AlignInBits, Ty, Subscripts, NumSubscripts)
    @apicall(:LLVMDIBuilderCreateVectorType, LLVMMetadataRef, (LLVMDIBuilderRef, UInt64, UInt32, LLVMMetadataRef, Ptr{LLVMMetadataRef}, UInt32), Builder, Size, AlignInBits, Ty, Subscripts, NumSubscripts)
end

function LLVMDIBuilderCreateUnspecifiedType(Builder, Name, NameLen)
    @apicall(:LLVMDIBuilderCreateUnspecifiedType, LLVMMetadataRef, (LLVMDIBuilderRef, Cstring, Csize_t), Builder, Name, NameLen)
end

function LLVMDIBuilderCreateBasicType(Builder, Name, NameLen, SizeInBits, Encoding, Flags)
    @apicall(:LLVMDIBuilderCreateBasicType, LLVMMetadataRef, (LLVMDIBuilderRef, Cstring, Csize_t, UInt64, LLVMDWARFTypeEncoding, LLVMDIFlags), Builder, Name, NameLen, SizeInBits, Encoding, Flags)
end

function LLVMDIBuilderCreatePointerType(Builder, PointeeTy, SizeInBits, AlignInBits, AddressSpace, Name, NameLen)
    @apicall(:LLVMDIBuilderCreatePointerType, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, UInt64, UInt32, UInt32, Cstring, Csize_t), Builder, PointeeTy, SizeInBits, AlignInBits, AddressSpace, Name, NameLen)
end

function LLVMDIBuilderCreateStructType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Flags, DerivedFrom, Elements, NumElements, RunTimeLang, VTableHolder, UniqueId, UniqueIdLen)
    @apicall(:LLVMDIBuilderCreateStructType, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, UInt32, UInt64, UInt32, LLVMDIFlags, LLVMMetadataRef, Ptr{LLVMMetadataRef}, UInt32, UInt32, LLVMMetadataRef, Cstring, Csize_t), Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, Flags, DerivedFrom, Elements, NumElements, RunTimeLang, VTableHolder, UniqueId, UniqueIdLen)
end

function LLVMDIBuilderCreateMemberType(Builder, Scope, Name, NameLen, File, LineNo, SizeInBits, AlignInBits, OffsetInBits, Flags, Ty)
    @apicall(:LLVMDIBuilderCreateMemberType, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, UInt32, UInt64, UInt32, UInt64, LLVMDIFlags, LLVMMetadataRef), Builder, Scope, Name, NameLen, File, LineNo, SizeInBits, AlignInBits, OffsetInBits, Flags, Ty)
end

function LLVMDIBuilderCreateStaticMemberType(Builder, Scope, Name, NameLen, File, LineNumber, Type, Flags, ConstantVal, AlignInBits)
    @apicall(:LLVMDIBuilderCreateStaticMemberType, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, UInt32, LLVMMetadataRef, LLVMDIFlags, LLVMValueRef, UInt32), Builder, Scope, Name, NameLen, File, LineNumber, Type, Flags, ConstantVal, AlignInBits)
end

function LLVMDIBuilderCreateMemberPointerType(Builder, PointeeType, ClassType, SizeInBits, AlignInBits, Flags)
    @apicall(:LLVMDIBuilderCreateMemberPointerType, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, UInt64, UInt32, LLVMDIFlags), Builder, PointeeType, ClassType, SizeInBits, AlignInBits, Flags)
end

function LLVMDIBuilderCreateObjCIVar(Builder, Name, NameLen, File, LineNo, SizeInBits, AlignInBits, OffsetInBits, Flags, Ty, PropertyNode)
    @apicall(:LLVMDIBuilderCreateObjCIVar, LLVMMetadataRef, (LLVMDIBuilderRef, Cstring, Csize_t, LLVMMetadataRef, UInt32, UInt64, UInt32, UInt64, LLVMDIFlags, LLVMMetadataRef, LLVMMetadataRef), Builder, Name, NameLen, File, LineNo, SizeInBits, AlignInBits, OffsetInBits, Flags, Ty, PropertyNode)
end

function LLVMDIBuilderCreateObjCProperty(Builder, Name, NameLen, File, LineNo, GetterName, GetterNameLen, SetterName, SetterNameLen, PropertyAttributes, Ty)
    @apicall(:LLVMDIBuilderCreateObjCProperty, LLVMMetadataRef, (LLVMDIBuilderRef, Cstring, Csize_t, LLVMMetadataRef, UInt32, Cstring, Csize_t, Cstring, Csize_t, UInt32, LLVMMetadataRef), Builder, Name, NameLen, File, LineNo, GetterName, GetterNameLen, SetterName, SetterNameLen, PropertyAttributes, Ty)
end

function LLVMDIBuilderCreateObjectPointerType(Builder, Type)
    @apicall(:LLVMDIBuilderCreateObjectPointerType, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef), Builder, Type)
end

function LLVMDIBuilderCreateQualifiedType(Builder, Tag, Type)
    @apicall(:LLVMDIBuilderCreateQualifiedType, LLVMMetadataRef, (LLVMDIBuilderRef, UInt32, LLVMMetadataRef), Builder, Tag, Type)
end

function LLVMDIBuilderCreateReferenceType(Builder, Tag, Type)
    @apicall(:LLVMDIBuilderCreateReferenceType, LLVMMetadataRef, (LLVMDIBuilderRef, UInt32, LLVMMetadataRef), Builder, Tag, Type)
end

function LLVMDIBuilderCreateNullPtrType(Builder)
    @apicall(:LLVMDIBuilderCreateNullPtrType, LLVMMetadataRef, (LLVMDIBuilderRef,), Builder)
end

function LLVMDIBuilderCreateTypedef(Builder, Type, Name, NameLen, File, LineNo, Scope)
    @apicall(:LLVMDIBuilderCreateTypedef, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, UInt32, LLVMMetadataRef), Builder, Type, Name, NameLen, File, LineNo, Scope)
end

function LLVMDIBuilderCreateInheritance(Builder, Ty, BaseTy, BaseOffset, VBPtrOffset, Flags)
    @apicall(:LLVMDIBuilderCreateInheritance, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, LLVMMetadataRef, UInt64, UInt32, LLVMDIFlags), Builder, Ty, BaseTy, BaseOffset, VBPtrOffset, Flags)
end

function LLVMDIBuilderCreateForwardDecl(Builder, Tag, Name, NameLen, Scope, File, Line, RuntimeLang, SizeInBits, AlignInBits, UniqueIdentifier, UniqueIdentifierLen)
    @apicall(:LLVMDIBuilderCreateForwardDecl, LLVMMetadataRef, (LLVMDIBuilderRef, UInt32, Cstring, Csize_t, LLVMMetadataRef, LLVMMetadataRef, UInt32, UInt32, UInt64, UInt32, Cstring, Csize_t), Builder, Tag, Name, NameLen, Scope, File, Line, RuntimeLang, SizeInBits, AlignInBits, UniqueIdentifier, UniqueIdentifierLen)
end

function LLVMDIBuilderCreateReplaceableCompositeType(Builder, Tag, Name, NameLen, Scope, File, Line, RuntimeLang, SizeInBits, AlignInBits, Flags, UniqueIdentifier, UniqueIdentifierLen)
    @apicall(:LLVMDIBuilderCreateReplaceableCompositeType, LLVMMetadataRef, (LLVMDIBuilderRef, UInt32, Cstring, Csize_t, LLVMMetadataRef, LLVMMetadataRef, UInt32, UInt32, UInt64, UInt32, LLVMDIFlags, Cstring, Csize_t), Builder, Tag, Name, NameLen, Scope, File, Line, RuntimeLang, SizeInBits, AlignInBits, Flags, UniqueIdentifier, UniqueIdentifierLen)
end

function LLVMDIBuilderCreateBitFieldMemberType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, OffsetInBits, StorageOffsetInBits, Flags, Type)
    @apicall(:LLVMDIBuilderCreateBitFieldMemberType, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, UInt32, UInt64, UInt64, UInt64, LLVMDIFlags, LLVMMetadataRef), Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, OffsetInBits, StorageOffsetInBits, Flags, Type)
end

function LLVMDIBuilderCreateClassType(Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, OffsetInBits, Flags, DerivedFrom, Elements, NumElements, VTableHolder, TemplateParamsNode, UniqueIdentifier, UniqueIdentifierLen)
    @apicall(:LLVMDIBuilderCreateClassType, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, UInt32, UInt64, UInt32, UInt64, LLVMDIFlags, LLVMMetadataRef, Ptr{LLVMMetadataRef}, UInt32, LLVMMetadataRef, LLVMMetadataRef, Cstring, Csize_t), Builder, Scope, Name, NameLen, File, LineNumber, SizeInBits, AlignInBits, OffsetInBits, Flags, DerivedFrom, Elements, NumElements, VTableHolder, TemplateParamsNode, UniqueIdentifier, UniqueIdentifierLen)
end

function LLVMDIBuilderCreateArtificialType(Builder, Type)
    @apicall(:LLVMDIBuilderCreateArtificialType, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef), Builder, Type)
end

function LLVMDITypeGetName(DType, Length)
    @apicall(:LLVMDITypeGetName, Cstring, (LLVMMetadataRef, Ptr{Csize_t}), DType, Length)
end

function LLVMDITypeGetSizeInBits(DType)
    @apicall(:LLVMDITypeGetSizeInBits, UInt64, (LLVMMetadataRef,), DType)
end

function LLVMDITypeGetOffsetInBits(DType)
    @apicall(:LLVMDITypeGetOffsetInBits, UInt64, (LLVMMetadataRef,), DType)
end

function LLVMDITypeGetAlignInBits(DType)
    @apicall(:LLVMDITypeGetAlignInBits, UInt32, (LLVMMetadataRef,), DType)
end

function LLVMDITypeGetLine(DType)
    @apicall(:LLVMDITypeGetLine, UInt32, (LLVMMetadataRef,), DType)
end

function LLVMDITypeGetFlags(DType)
    @apicall(:LLVMDITypeGetFlags, LLVMDIFlags, (LLVMMetadataRef,), DType)
end

function LLVMDIBuilderGetOrCreateSubrange(Builder, LowerBound, Count)
    @apicall(:LLVMDIBuilderGetOrCreateSubrange, LLVMMetadataRef, (LLVMDIBuilderRef, Int64, Int64), Builder, LowerBound, Count)
end

function LLVMDIBuilderGetOrCreateArray(Builder, Data, NumElements)
    @apicall(:LLVMDIBuilderGetOrCreateArray, LLVMMetadataRef, (LLVMDIBuilderRef, Ptr{LLVMMetadataRef}, Csize_t), Builder, Data, NumElements)
end

function LLVMDIBuilderCreateExpression(Builder, Addr, Length)
    @apicall(:LLVMDIBuilderCreateExpression, LLVMMetadataRef, (LLVMDIBuilderRef, Ptr{Int64}, Csize_t), Builder, Addr, Length)
end

function LLVMDIBuilderCreateConstantValueExpression(Builder, Value)
    @apicall(:LLVMDIBuilderCreateConstantValueExpression, LLVMMetadataRef, (LLVMDIBuilderRef, Int64), Builder, Value)
end

function LLVMDIBuilderCreateGlobalVariableExpression(Builder, Scope, Name, NameLen, Linkage, LinkLen, File, LineNo, Ty, LocalToUnit, Expr, Decl, AlignInBits)
    @apicall(:LLVMDIBuilderCreateGlobalVariableExpression, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, Cstring, Csize_t, LLVMMetadataRef, UInt32, LLVMMetadataRef, LLVMBool, LLVMMetadataRef, LLVMMetadataRef, UInt32), Builder, Scope, Name, NameLen, Linkage, LinkLen, File, LineNo, Ty, LocalToUnit, Expr, Decl, AlignInBits)
end

function LLVMTemporaryMDNode(Ctx, Data, NumElements)
    @apicall(:LLVMTemporaryMDNode, LLVMMetadataRef, (LLVMContextRef, Ptr{LLVMMetadataRef}, Csize_t), Ctx, Data, NumElements)
end

function LLVMDisposeTemporaryMDNode(TempNode)
    @apicall(:LLVMDisposeTemporaryMDNode, Cvoid, (LLVMMetadataRef,), TempNode)
end

function LLVMMetadataReplaceAllUsesWith(TempTargetMetadata, Replacement)
    @apicall(:LLVMMetadataReplaceAllUsesWith, Cvoid, (LLVMMetadataRef, LLVMMetadataRef), TempTargetMetadata, Replacement)
end

function LLVMDIBuilderCreateTempGlobalVariableFwdDecl(Builder, Scope, Name, NameLen, Linkage, LnkLen, File, LineNo, Ty, LocalToUnit, Decl, AlignInBits)
    @apicall(:LLVMDIBuilderCreateTempGlobalVariableFwdDecl, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, Cstring, Csize_t, LLVMMetadataRef, UInt32, LLVMMetadataRef, LLVMBool, LLVMMetadataRef, UInt32), Builder, Scope, Name, NameLen, Linkage, LnkLen, File, LineNo, Ty, LocalToUnit, Decl, AlignInBits)
end

function LLVMDIBuilderInsertDeclareBefore(Builder, Storage, VarInfo, Expr, DebugLoc, Instr)
    @apicall(:LLVMDIBuilderInsertDeclareBefore, LLVMValueRef, (LLVMDIBuilderRef, LLVMValueRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, LLVMValueRef), Builder, Storage, VarInfo, Expr, DebugLoc, Instr)
end

function LLVMDIBuilderInsertDeclareAtEnd(Builder, Storage, VarInfo, Expr, DebugLoc, Block)
    @apicall(:LLVMDIBuilderInsertDeclareAtEnd, LLVMValueRef, (LLVMDIBuilderRef, LLVMValueRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, LLVMBasicBlockRef), Builder, Storage, VarInfo, Expr, DebugLoc, Block)
end

function LLVMDIBuilderInsertDbgValueBefore(Builder, Val, VarInfo, Expr, DebugLoc, Instr)
    @apicall(:LLVMDIBuilderInsertDbgValueBefore, LLVMValueRef, (LLVMDIBuilderRef, LLVMValueRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, LLVMValueRef), Builder, Val, VarInfo, Expr, DebugLoc, Instr)
end

function LLVMDIBuilderInsertDbgValueAtEnd(Builder, Val, VarInfo, Expr, DebugLoc, Block)
    @apicall(:LLVMDIBuilderInsertDbgValueAtEnd, LLVMValueRef, (LLVMDIBuilderRef, LLVMValueRef, LLVMMetadataRef, LLVMMetadataRef, LLVMMetadataRef, LLVMBasicBlockRef), Builder, Val, VarInfo, Expr, DebugLoc, Block)
end

function LLVMDIBuilderCreateAutoVariable(Builder, Scope, Name, NameLen, File, LineNo, Ty, AlwaysPreserve, Flags, AlignInBits)
    @apicall(:LLVMDIBuilderCreateAutoVariable, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, LLVMMetadataRef, UInt32, LLVMMetadataRef, LLVMBool, LLVMDIFlags, UInt32), Builder, Scope, Name, NameLen, File, LineNo, Ty, AlwaysPreserve, Flags, AlignInBits)
end

function LLVMDIBuilderCreateParameterVariable(Builder, Scope, Name, NameLen, ArgNo, File, LineNo, Ty, AlwaysPreserve, Flags)
    @apicall(:LLVMDIBuilderCreateParameterVariable, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMMetadataRef, Cstring, Csize_t, UInt32, LLVMMetadataRef, UInt32, LLVMMetadataRef, LLVMBool, LLVMDIFlags), Builder, Scope, Name, NameLen, ArgNo, File, LineNo, Ty, AlwaysPreserve, Flags)
end

function LLVMGetSubprogram(Func)
    @apicall(:LLVMGetSubprogram, LLVMMetadataRef, (LLVMValueRef,), Func)
end

function LLVMSetSubprogram(Func, SP)
    @apicall(:LLVMSetSubprogram, Cvoid, (LLVMValueRef, LLVMMetadataRef), Func, SP)
end

function LLVMGetMetadataKind(Metadata)
    @apicall(:LLVMGetMetadataKind, LLVMMetadataKind, (LLVMMetadataRef,), Metadata)
end
# Julia wrapper for header: Disassembler.h
# Automatically generated using Clang.jl


function LLVMCreateDisasm(TripleName, DisInfo, TagType, GetOpInfo, SymbolLookUp)
    @apicall(:LLVMCreateDisasm, LLVMDisasmContextRef, (Cstring, Ptr{Cvoid}, Cint, LLVMOpInfoCallback, LLVMSymbolLookupCallback), TripleName, DisInfo, TagType, GetOpInfo, SymbolLookUp)
end

function LLVMCreateDisasmCPU(Triple, CPU, DisInfo, TagType, GetOpInfo, SymbolLookUp)
    @apicall(:LLVMCreateDisasmCPU, LLVMDisasmContextRef, (Cstring, Cstring, Ptr{Cvoid}, Cint, LLVMOpInfoCallback, LLVMSymbolLookupCallback), Triple, CPU, DisInfo, TagType, GetOpInfo, SymbolLookUp)
end

function LLVMCreateDisasmCPUFeatures(Triple, CPU, Features, DisInfo, TagType, GetOpInfo, SymbolLookUp)
    @apicall(:LLVMCreateDisasmCPUFeatures, LLVMDisasmContextRef, (Cstring, Cstring, Cstring, Ptr{Cvoid}, Cint, LLVMOpInfoCallback, LLVMSymbolLookupCallback), Triple, CPU, Features, DisInfo, TagType, GetOpInfo, SymbolLookUp)
end

function LLVMSetDisasmOptions(DC, Options)
    @apicall(:LLVMSetDisasmOptions, Cint, (LLVMDisasmContextRef, UInt64), DC, Options)
end

function LLVMDisasmDispose(DC)
    @apicall(:LLVMDisasmDispose, Cvoid, (LLVMDisasmContextRef,), DC)
end

function LLVMDisasmInstruction(DC, Bytes, BytesSize, PC, OutString, OutStringSize)
    @apicall(:LLVMDisasmInstruction, Csize_t, (LLVMDisasmContextRef, Ptr{UInt8}, UInt64, UInt64, Cstring, Csize_t), DC, Bytes, BytesSize, PC, OutString, OutStringSize)
end
# Julia wrapper for header: DisassemblerTypes.h
# Automatically generated using Clang.jl

# Julia wrapper for header: Error.h
# Automatically generated using Clang.jl


function LLVMGetErrorTypeId(Err)
    @apicall(:LLVMGetErrorTypeId, LLVMErrorTypeId, (LLVMErrorRef,), Err)
end

function LLVMConsumeError(Err)
    @apicall(:LLVMConsumeError, Cvoid, (LLVMErrorRef,), Err)
end

function LLVMGetErrorMessage(Err)
    @apicall(:LLVMGetErrorMessage, Cstring, (LLVMErrorRef,), Err)
end

function LLVMDisposeErrorMessage(ErrMsg)
    @apicall(:LLVMDisposeErrorMessage, Cvoid, (Cstring,), ErrMsg)
end

function LLVMGetStringErrorTypeId()
    @apicall(:LLVMGetStringErrorTypeId, LLVMErrorTypeId, ())
end
# Julia wrapper for header: ErrorHandling.h
# Automatically generated using Clang.jl


function LLVMInstallFatalErrorHandler(Handler)
    @apicall(:LLVMInstallFatalErrorHandler, Cvoid, (LLVMFatalErrorHandler,), Handler)
end

function LLVMResetFatalErrorHandler()
    @apicall(:LLVMResetFatalErrorHandler, Cvoid, ())
end

function LLVMEnablePrettyStackTrace()
    @apicall(:LLVMEnablePrettyStackTrace, Cvoid, ())
end
# Julia wrapper for header: ExecutionEngine.h
# Automatically generated using Clang.jl


function LLVMInitializeNVPTXTargetInfo()
    @apicall(:LLVMInitializeNVPTXTargetInfo, Cvoid, ())
end

function LLVMInitializeAMDGPUTargetInfo()
    @apicall(:LLVMInitializeAMDGPUTargetInfo, Cvoid, ())
end

function LLVMInitializeWebAssemblyTargetInfo()
    @apicall(:LLVMInitializeWebAssemblyTargetInfo, Cvoid, ())
end

function LLVMInitializeX86TargetInfo()
    @apicall(:LLVMInitializeX86TargetInfo, Cvoid, ())
end

function LLVMInitializeNVPTXTarget()
    @apicall(:LLVMInitializeNVPTXTarget, Cvoid, ())
end

function LLVMInitializeAMDGPUTarget()
    @apicall(:LLVMInitializeAMDGPUTarget, Cvoid, ())
end

function LLVMInitializeWebAssemblyTarget()
    @apicall(:LLVMInitializeWebAssemblyTarget, Cvoid, ())
end

function LLVMInitializeX86Target()
    @apicall(:LLVMInitializeX86Target, Cvoid, ())
end

function LLVMInitializeNVPTXTargetMC()
    @apicall(:LLVMInitializeNVPTXTargetMC, Cvoid, ())
end

function LLVMInitializeAMDGPUTargetMC()
    @apicall(:LLVMInitializeAMDGPUTargetMC, Cvoid, ())
end

function LLVMInitializeWebAssemblyTargetMC()
    @apicall(:LLVMInitializeWebAssemblyTargetMC, Cvoid, ())
end

function LLVMInitializeX86TargetMC()
    @apicall(:LLVMInitializeX86TargetMC, Cvoid, ())
end

function LLVMInitializeNVPTXAsmPrinter()
    @apicall(:LLVMInitializeNVPTXAsmPrinter, Cvoid, ())
end

function LLVMInitializeAMDGPUAsmPrinter()
    @apicall(:LLVMInitializeAMDGPUAsmPrinter, Cvoid, ())
end

function LLVMInitializeWebAssemblyAsmPrinter()
    @apicall(:LLVMInitializeWebAssemblyAsmPrinter, Cvoid, ())
end

function LLVMInitializeX86AsmPrinter()
    @apicall(:LLVMInitializeX86AsmPrinter, Cvoid, ())
end

function LLVMInitializeAMDGPUAsmParser()
    @apicall(:LLVMInitializeAMDGPUAsmParser, Cvoid, ())
end

function LLVMInitializeWebAssemblyAsmParser()
    @apicall(:LLVMInitializeWebAssemblyAsmParser, Cvoid, ())
end

function LLVMInitializeX86AsmParser()
    @apicall(:LLVMInitializeX86AsmParser, Cvoid, ())
end

function LLVMInitializeAMDGPUDisassembler()
    @apicall(:LLVMInitializeAMDGPUDisassembler, Cvoid, ())
end

function LLVMInitializeWebAssemblyDisassembler()
    @apicall(:LLVMInitializeWebAssemblyDisassembler, Cvoid, ())
end

function LLVMInitializeX86Disassembler()
    @apicall(:LLVMInitializeX86Disassembler, Cvoid, ())
end

function LLVMInitializeAllTargetInfos()
    @apicall(:LLVMInitializeAllTargetInfos, Cvoid, ())
end

function LLVMInitializeAllTargets()
    @apicall(:LLVMInitializeAllTargets, Cvoid, ())
end

function LLVMInitializeAllTargetMCs()
    @apicall(:LLVMInitializeAllTargetMCs, Cvoid, ())
end

function LLVMInitializeAllAsmPrinters()
    @apicall(:LLVMInitializeAllAsmPrinters, Cvoid, ())
end

function LLVMInitializeAllAsmParsers()
    @apicall(:LLVMInitializeAllAsmParsers, Cvoid, ())
end

function LLVMInitializeAllDisassemblers()
    @apicall(:LLVMInitializeAllDisassemblers, Cvoid, ())
end

function LLVMInitializeNativeTarget()
    @apicall(:LLVMInitializeNativeTarget, LLVMBool, ())
end

function LLVMInitializeNativeAsmParser()
    @apicall(:LLVMInitializeNativeAsmParser, LLVMBool, ())
end

function LLVMInitializeNativeAsmPrinter()
    @apicall(:LLVMInitializeNativeAsmPrinter, LLVMBool, ())
end

function LLVMInitializeNativeDisassembler()
    @apicall(:LLVMInitializeNativeDisassembler, LLVMBool, ())
end

function LLVMGetModuleDataLayout(M)
    @apicall(:LLVMGetModuleDataLayout, LLVMTargetDataRef, (LLVMModuleRef,), M)
end

function LLVMSetModuleDataLayout(M, DL)
    @apicall(:LLVMSetModuleDataLayout, Cvoid, (LLVMModuleRef, LLVMTargetDataRef), M, DL)
end

function LLVMCreateTargetData(StringRep)
    @apicall(:LLVMCreateTargetData, LLVMTargetDataRef, (Cstring,), StringRep)
end

function LLVMDisposeTargetData(TD)
    @apicall(:LLVMDisposeTargetData, Cvoid, (LLVMTargetDataRef,), TD)
end

function LLVMAddTargetLibraryInfo(TLI, PM)
    @apicall(:LLVMAddTargetLibraryInfo, Cvoid, (LLVMTargetLibraryInfoRef, LLVMPassManagerRef), TLI, PM)
end

function LLVMCopyStringRepOfTargetData(TD)
    @apicall(:LLVMCopyStringRepOfTargetData, Cstring, (LLVMTargetDataRef,), TD)
end

function LLVMByteOrder(TD)
    @apicall(:LLVMByteOrder, LLVMByteOrdering, (LLVMTargetDataRef,), TD)
end

function LLVMPointerSize(TD)
    @apicall(:LLVMPointerSize, UInt32, (LLVMTargetDataRef,), TD)
end

function LLVMPointerSizeForAS(TD, AS)
    @apicall(:LLVMPointerSizeForAS, UInt32, (LLVMTargetDataRef, UInt32), TD, AS)
end

function LLVMIntPtrType(TD)
    @apicall(:LLVMIntPtrType, LLVMTypeRef, (LLVMTargetDataRef,), TD)
end

function LLVMIntPtrTypeForAS(TD, AS)
    @apicall(:LLVMIntPtrTypeForAS, LLVMTypeRef, (LLVMTargetDataRef, UInt32), TD, AS)
end

function LLVMIntPtrTypeInContext(C, TD)
    @apicall(:LLVMIntPtrTypeInContext, LLVMTypeRef, (LLVMContextRef, LLVMTargetDataRef), C, TD)
end

function LLVMIntPtrTypeForASInContext(C, TD, AS)
    @apicall(:LLVMIntPtrTypeForASInContext, LLVMTypeRef, (LLVMContextRef, LLVMTargetDataRef, UInt32), C, TD, AS)
end

function LLVMSizeOfTypeInBits(TD, Ty)
    @apicall(:LLVMSizeOfTypeInBits, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMStoreSizeOfType(TD, Ty)
    @apicall(:LLVMStoreSizeOfType, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMABISizeOfType(TD, Ty)
    @apicall(:LLVMABISizeOfType, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMABIAlignmentOfType(TD, Ty)
    @apicall(:LLVMABIAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMCallFrameAlignmentOfType(TD, Ty)
    @apicall(:LLVMCallFrameAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMPreferredAlignmentOfType(TD, Ty)
    @apicall(:LLVMPreferredAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMPreferredAlignmentOfGlobal(TD, GlobalVar)
    @apicall(:LLVMPreferredAlignmentOfGlobal, UInt32, (LLVMTargetDataRef, LLVMValueRef), TD, GlobalVar)
end

function LLVMElementAtOffset(TD, StructTy, Offset)
    @apicall(:LLVMElementAtOffset, UInt32, (LLVMTargetDataRef, LLVMTypeRef, Culonglong), TD, StructTy, Offset)
end

function LLVMOffsetOfElement(TD, StructTy, Element)
    @apicall(:LLVMOffsetOfElement, Culonglong, (LLVMTargetDataRef, LLVMTypeRef, UInt32), TD, StructTy, Element)
end

function LLVMGetFirstTarget()
    @apicall(:LLVMGetFirstTarget, LLVMTargetRef, ())
end

function LLVMGetNextTarget(T)
    @apicall(:LLVMGetNextTarget, LLVMTargetRef, (LLVMTargetRef,), T)
end

function LLVMGetTargetFromName(Name)
    @apicall(:LLVMGetTargetFromName, LLVMTargetRef, (Cstring,), Name)
end

function LLVMGetTargetFromTriple(Triple, T, ErrorMessage)
    @apicall(:LLVMGetTargetFromTriple, LLVMBool, (Cstring, Ptr{LLVMTargetRef}, Ptr{Cstring}), Triple, T, ErrorMessage)
end

function LLVMGetTargetName(T)
    @apicall(:LLVMGetTargetName, Cstring, (LLVMTargetRef,), T)
end

function LLVMGetTargetDescription(T)
    @apicall(:LLVMGetTargetDescription, Cstring, (LLVMTargetRef,), T)
end

function LLVMTargetHasJIT(T)
    @apicall(:LLVMTargetHasJIT, LLVMBool, (LLVMTargetRef,), T)
end

function LLVMTargetHasTargetMachine(T)
    @apicall(:LLVMTargetHasTargetMachine, LLVMBool, (LLVMTargetRef,), T)
end

function LLVMTargetHasAsmBackend(T)
    @apicall(:LLVMTargetHasAsmBackend, LLVMBool, (LLVMTargetRef,), T)
end

function LLVMCreateTargetMachine(T, Triple, CPU, Features, Level, Reloc, CodeModel)
    @apicall(:LLVMCreateTargetMachine, LLVMTargetMachineRef, (LLVMTargetRef, Cstring, Cstring, Cstring, LLVMCodeGenOptLevel, LLVMRelocMode, LLVMCodeModel), T, Triple, CPU, Features, Level, Reloc, CodeModel)
end

function LLVMDisposeTargetMachine(T)
    @apicall(:LLVMDisposeTargetMachine, Cvoid, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineTarget(T)
    @apicall(:LLVMGetTargetMachineTarget, LLVMTargetRef, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineTriple(T)
    @apicall(:LLVMGetTargetMachineTriple, Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineCPU(T)
    @apicall(:LLVMGetTargetMachineCPU, Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineFeatureString(T)
    @apicall(:LLVMGetTargetMachineFeatureString, Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMCreateTargetDataLayout(T)
    @apicall(:LLVMCreateTargetDataLayout, LLVMTargetDataRef, (LLVMTargetMachineRef,), T)
end

function LLVMSetTargetMachineAsmVerbosity(T, VerboseAsm)
    @apicall(:LLVMSetTargetMachineAsmVerbosity, Cvoid, (LLVMTargetMachineRef, LLVMBool), T, VerboseAsm)
end

function LLVMTargetMachineEmitToFile(T, M, Filename, codegen, ErrorMessage)
    @apicall(:LLVMTargetMachineEmitToFile, LLVMBool, (LLVMTargetMachineRef, LLVMModuleRef, Cstring, LLVMCodeGenFileType, Ptr{Cstring}), T, M, Filename, codegen, ErrorMessage)
end

function LLVMTargetMachineEmitToMemoryBuffer(T, M, codegen, ErrorMessage, OutMemBuf)
    @apicall(:LLVMTargetMachineEmitToMemoryBuffer, LLVMBool, (LLVMTargetMachineRef, LLVMModuleRef, LLVMCodeGenFileType, Ptr{Cstring}, Ptr{LLVMMemoryBufferRef}), T, M, codegen, ErrorMessage, OutMemBuf)
end

function LLVMGetDefaultTargetTriple()
    @apicall(:LLVMGetDefaultTargetTriple, Cstring, ())
end

function LLVMNormalizeTargetTriple(triple)
    @apicall(:LLVMNormalizeTargetTriple, Cstring, (Cstring,), triple)
end

function LLVMGetHostCPUName()
    @apicall(:LLVMGetHostCPUName, Cstring, ())
end

function LLVMGetHostCPUFeatures()
    @apicall(:LLVMGetHostCPUFeatures, Cstring, ())
end

function LLVMAddAnalysisPasses(T, PM)
    @apicall(:LLVMAddAnalysisPasses, Cvoid, (LLVMTargetMachineRef, LLVMPassManagerRef), T, PM)
end

function LLVMLinkInMCJIT()
    @apicall(:LLVMLinkInMCJIT, Cvoid, ())
end

function LLVMLinkInInterpreter()
    @apicall(:LLVMLinkInInterpreter, Cvoid, ())
end

function LLVMCreateGenericValueOfInt(Ty, N, IsSigned)
    @apicall(:LLVMCreateGenericValueOfInt, LLVMGenericValueRef, (LLVMTypeRef, Culonglong, LLVMBool), Ty, N, IsSigned)
end

function LLVMCreateGenericValueOfPointer(P)
    @apicall(:LLVMCreateGenericValueOfPointer, LLVMGenericValueRef, (Ptr{Cvoid},), P)
end

function LLVMCreateGenericValueOfFloat(Ty, N)
    @apicall(:LLVMCreateGenericValueOfFloat, LLVMGenericValueRef, (LLVMTypeRef, Cdouble), Ty, N)
end

function LLVMGenericValueIntWidth(GenValRef)
    @apicall(:LLVMGenericValueIntWidth, UInt32, (LLVMGenericValueRef,), GenValRef)
end

function LLVMGenericValueToInt(GenVal, IsSigned)
    @apicall(:LLVMGenericValueToInt, Culonglong, (LLVMGenericValueRef, LLVMBool), GenVal, IsSigned)
end

function LLVMGenericValueToPointer(GenVal)
    @apicall(:LLVMGenericValueToPointer, Ptr{Cvoid}, (LLVMGenericValueRef,), GenVal)
end

function LLVMGenericValueToFloat(TyRef, GenVal)
    @apicall(:LLVMGenericValueToFloat, Cdouble, (LLVMTypeRef, LLVMGenericValueRef), TyRef, GenVal)
end

function LLVMDisposeGenericValue(GenVal)
    @apicall(:LLVMDisposeGenericValue, Cvoid, (LLVMGenericValueRef,), GenVal)
end

function LLVMCreateExecutionEngineForModule(OutEE, M, OutError)
    @apicall(:LLVMCreateExecutionEngineForModule, LLVMBool, (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, Ptr{Cstring}), OutEE, M, OutError)
end

function LLVMCreateInterpreterForModule(OutInterp, M, OutError)
    @apicall(:LLVMCreateInterpreterForModule, LLVMBool, (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, Ptr{Cstring}), OutInterp, M, OutError)
end

function LLVMCreateJITCompilerForModule(OutJIT, M, OptLevel, OutError)
    @apicall(:LLVMCreateJITCompilerForModule, LLVMBool, (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, UInt32, Ptr{Cstring}), OutJIT, M, OptLevel, OutError)
end

function LLVMInitializeMCJITCompilerOptions(Options, SizeOfOptions)
    @apicall(:LLVMInitializeMCJITCompilerOptions, Cvoid, (Ptr{LLVMMCJITCompilerOptions}, Csize_t), Options, SizeOfOptions)
end

function LLVMCreateMCJITCompilerForModule(OutJIT, M, Options, SizeOfOptions, OutError)
    @apicall(:LLVMCreateMCJITCompilerForModule, LLVMBool, (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, Ptr{LLVMMCJITCompilerOptions}, Csize_t, Ptr{Cstring}), OutJIT, M, Options, SizeOfOptions, OutError)
end

function LLVMDisposeExecutionEngine(EE)
    @apicall(:LLVMDisposeExecutionEngine, Cvoid, (LLVMExecutionEngineRef,), EE)
end

function LLVMRunStaticConstructors(EE)
    @apicall(:LLVMRunStaticConstructors, Cvoid, (LLVMExecutionEngineRef,), EE)
end

function LLVMRunStaticDestructors(EE)
    @apicall(:LLVMRunStaticDestructors, Cvoid, (LLVMExecutionEngineRef,), EE)
end

function LLVMRunFunctionAsMain(EE, F, ArgC, ArgV, EnvP)
    @apicall(:LLVMRunFunctionAsMain, Cint, (LLVMExecutionEngineRef, LLVMValueRef, UInt32, Ptr{Cstring}, Ptr{Cstring}), EE, F, ArgC, ArgV, EnvP)
end

function LLVMRunFunction(EE, F, NumArgs, Args)
    @apicall(:LLVMRunFunction, LLVMGenericValueRef, (LLVMExecutionEngineRef, LLVMValueRef, UInt32, Ptr{LLVMGenericValueRef}), EE, F, NumArgs, Args)
end

function LLVMFreeMachineCodeForFunction(EE, F)
    @apicall(:LLVMFreeMachineCodeForFunction, Cvoid, (LLVMExecutionEngineRef, LLVMValueRef), EE, F)
end

function LLVMAddModule(EE, M)
    @apicall(:LLVMAddModule, Cvoid, (LLVMExecutionEngineRef, LLVMModuleRef), EE, M)
end

function LLVMRemoveModule(EE, M, OutMod, OutError)
    @apicall(:LLVMRemoveModule, LLVMBool, (LLVMExecutionEngineRef, LLVMModuleRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), EE, M, OutMod, OutError)
end

function LLVMFindFunction(EE, Name, OutFn)
    @apicall(:LLVMFindFunction, LLVMBool, (LLVMExecutionEngineRef, Cstring, Ptr{LLVMValueRef}), EE, Name, OutFn)
end

function LLVMRecompileAndRelinkFunction(EE, Fn)
    @apicall(:LLVMRecompileAndRelinkFunction, Ptr{Cvoid}, (LLVMExecutionEngineRef, LLVMValueRef), EE, Fn)
end

function LLVMGetExecutionEngineTargetData(EE)
    @apicall(:LLVMGetExecutionEngineTargetData, LLVMTargetDataRef, (LLVMExecutionEngineRef,), EE)
end

function LLVMGetExecutionEngineTargetMachine(EE)
    @apicall(:LLVMGetExecutionEngineTargetMachine, LLVMTargetMachineRef, (LLVMExecutionEngineRef,), EE)
end

function LLVMAddGlobalMapping(EE, Global, Addr)
    @apicall(:LLVMAddGlobalMapping, Cvoid, (LLVMExecutionEngineRef, LLVMValueRef, Ptr{Cvoid}), EE, Global, Addr)
end

function LLVMGetPointerToGlobal(EE, Global)
    @apicall(:LLVMGetPointerToGlobal, Ptr{Cvoid}, (LLVMExecutionEngineRef, LLVMValueRef), EE, Global)
end

function LLVMGetGlobalValueAddress(EE, Name)
    @apicall(:LLVMGetGlobalValueAddress, UInt64, (LLVMExecutionEngineRef, Cstring), EE, Name)
end

function LLVMGetFunctionAddress(EE, Name)
    @apicall(:LLVMGetFunctionAddress, UInt64, (LLVMExecutionEngineRef, Cstring), EE, Name)
end

function LLVMCreateSimpleMCJITMemoryManager(Opaque, AllocateCodeSection, AllocateDataSection, FinalizeMemory, Destroy)
    @apicall(:LLVMCreateSimpleMCJITMemoryManager, LLVMMCJITMemoryManagerRef, (Ptr{Cvoid}, LLVMMemoryManagerAllocateCodeSectionCallback, LLVMMemoryManagerAllocateDataSectionCallback, LLVMMemoryManagerFinalizeMemoryCallback, LLVMMemoryManagerDestroyCallback), Opaque, AllocateCodeSection, AllocateDataSection, FinalizeMemory, Destroy)
end

function LLVMDisposeMCJITMemoryManager(MM)
    @apicall(:LLVMDisposeMCJITMemoryManager, Cvoid, (LLVMMCJITMemoryManagerRef,), MM)
end

function LLVMCreateGDBRegistrationListener()
    @apicall(:LLVMCreateGDBRegistrationListener, LLVMJITEventListenerRef, ())
end

function LLVMCreateIntelJITEventListener()
    @apicall(:LLVMCreateIntelJITEventListener, LLVMJITEventListenerRef, ())
end

function LLVMCreateOProfileJITEventListener()
    @apicall(:LLVMCreateOProfileJITEventListener, LLVMJITEventListenerRef, ())
end

function LLVMCreatePerfJITEventListener()
    @apicall(:LLVMCreatePerfJITEventListener, LLVMJITEventListenerRef, ())
end
# Julia wrapper for header: IRReader.h
# Automatically generated using Clang.jl


function LLVMParseIRInContext(ContextRef, MemBuf, OutM, OutMessage)
    @apicall(:LLVMParseIRInContext, LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), ContextRef, MemBuf, OutM, OutMessage)
end
# Julia wrapper for header: Initialization.h
# Automatically generated using Clang.jl


function LLVMInitializeCore(R)
    @apicall(:LLVMInitializeCore, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeTransformUtils(R)
    @apicall(:LLVMInitializeTransformUtils, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeScalarOpts(R)
    @apicall(:LLVMInitializeScalarOpts, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeObjCARCOpts(R)
    @apicall(:LLVMInitializeObjCARCOpts, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeVectorization(R)
    @apicall(:LLVMInitializeVectorization, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeInstCombine(R)
    @apicall(:LLVMInitializeInstCombine, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeAggressiveInstCombiner(R)
    @apicall(:LLVMInitializeAggressiveInstCombiner, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeIPO(R)
    @apicall(:LLVMInitializeIPO, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeInstrumentation(R)
    @apicall(:LLVMInitializeInstrumentation, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeAnalysis(R)
    @apicall(:LLVMInitializeAnalysis, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeIPA(R)
    @apicall(:LLVMInitializeIPA, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeCodeGen(R)
    @apicall(:LLVMInitializeCodeGen, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeTarget(R)
    @apicall(:LLVMInitializeTarget, Cvoid, (LLVMPassRegistryRef,), R)
end
# Julia wrapper for header: LinkTimeOptimizer.h
# Automatically generated using Clang.jl


function llvm_create_optimizer()
    @apicall(:llvm_create_optimizer, llvm_lto_t, ())
end

function llvm_destroy_optimizer(lto)
    @apicall(:llvm_destroy_optimizer, Cvoid, (llvm_lto_t,), lto)
end

function llvm_read_object_file(lto, input_filename)
    @apicall(:llvm_read_object_file, llvm_lto_status_t, (llvm_lto_t, Cstring), lto, input_filename)
end

function llvm_optimize_modules(lto, output_filename)
    @apicall(:llvm_optimize_modules, llvm_lto_status_t, (llvm_lto_t, Cstring), lto, output_filename)
end
# Julia wrapper for header: Linker.h
# Automatically generated using Clang.jl


function LLVMLinkModules2(Dest, Src)
    @apicall(:LLVMLinkModules2, LLVMBool, (LLVMModuleRef, LLVMModuleRef), Dest, Src)
end
# Julia wrapper for header: Object.h
# Automatically generated using Clang.jl


function LLVMCreateObjectFile(MemBuf)
    @apicall(:LLVMCreateObjectFile, LLVMObjectFileRef, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMDisposeObjectFile(ObjectFile)
    @apicall(:LLVMDisposeObjectFile, Cvoid, (LLVMObjectFileRef,), ObjectFile)
end

function LLVMGetSections(ObjectFile)
    @apicall(:LLVMGetSections, LLVMSectionIteratorRef, (LLVMObjectFileRef,), ObjectFile)
end

function LLVMDisposeSectionIterator(SI)
    @apicall(:LLVMDisposeSectionIterator, Cvoid, (LLVMSectionIteratorRef,), SI)
end

function LLVMIsSectionIteratorAtEnd(ObjectFile, SI)
    @apicall(:LLVMIsSectionIteratorAtEnd, LLVMBool, (LLVMObjectFileRef, LLVMSectionIteratorRef), ObjectFile, SI)
end

function LLVMMoveToNextSection(SI)
    @apicall(:LLVMMoveToNextSection, Cvoid, (LLVMSectionIteratorRef,), SI)
end

function LLVMMoveToContainingSection(Sect, Sym)
    @apicall(:LLVMMoveToContainingSection, Cvoid, (LLVMSectionIteratorRef, LLVMSymbolIteratorRef), Sect, Sym)
end

function LLVMGetSymbols(ObjectFile)
    @apicall(:LLVMGetSymbols, LLVMSymbolIteratorRef, (LLVMObjectFileRef,), ObjectFile)
end

function LLVMDisposeSymbolIterator(SI)
    @apicall(:LLVMDisposeSymbolIterator, Cvoid, (LLVMSymbolIteratorRef,), SI)
end

function LLVMIsSymbolIteratorAtEnd(ObjectFile, SI)
    @apicall(:LLVMIsSymbolIteratorAtEnd, LLVMBool, (LLVMObjectFileRef, LLVMSymbolIteratorRef), ObjectFile, SI)
end

function LLVMMoveToNextSymbol(SI)
    @apicall(:LLVMMoveToNextSymbol, Cvoid, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetSectionName(SI)
    @apicall(:LLVMGetSectionName, Cstring, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionSize(SI)
    @apicall(:LLVMGetSectionSize, UInt64, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionContents(SI)
    @apicall(:LLVMGetSectionContents, Cstring, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionAddress(SI)
    @apicall(:LLVMGetSectionAddress, UInt64, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionContainsSymbol(SI, Sym)
    @apicall(:LLVMGetSectionContainsSymbol, LLVMBool, (LLVMSectionIteratorRef, LLVMSymbolIteratorRef), SI, Sym)
end

function LLVMGetRelocations(Section)
    @apicall(:LLVMGetRelocations, LLVMRelocationIteratorRef, (LLVMSectionIteratorRef,), Section)
end

function LLVMDisposeRelocationIterator(RI)
    @apicall(:LLVMDisposeRelocationIterator, Cvoid, (LLVMRelocationIteratorRef,), RI)
end

function LLVMIsRelocationIteratorAtEnd(Section, RI)
    @apicall(:LLVMIsRelocationIteratorAtEnd, LLVMBool, (LLVMSectionIteratorRef, LLVMRelocationIteratorRef), Section, RI)
end

function LLVMMoveToNextRelocation(RI)
    @apicall(:LLVMMoveToNextRelocation, Cvoid, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetSymbolName(SI)
    @apicall(:LLVMGetSymbolName, Cstring, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetSymbolAddress(SI)
    @apicall(:LLVMGetSymbolAddress, UInt64, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetSymbolSize(SI)
    @apicall(:LLVMGetSymbolSize, UInt64, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetRelocationOffset(RI)
    @apicall(:LLVMGetRelocationOffset, UInt64, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationSymbol(RI)
    @apicall(:LLVMGetRelocationSymbol, LLVMSymbolIteratorRef, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationType(RI)
    @apicall(:LLVMGetRelocationType, UInt64, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationTypeName(RI)
    @apicall(:LLVMGetRelocationTypeName, Cstring, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationValueString(RI)
    @apicall(:LLVMGetRelocationValueString, Cstring, (LLVMRelocationIteratorRef,), RI)
end
# Julia wrapper for header: OptRemarks.h
# Automatically generated using Clang.jl


function LLVMInstallFatalErrorHandler(Handler)
    @apicall(:LLVMInstallFatalErrorHandler, Cvoid, (LLVMFatalErrorHandler,), Handler)
end

function LLVMResetFatalErrorHandler()
    @apicall(:LLVMResetFatalErrorHandler, Cvoid, ())
end

function LLVMEnablePrettyStackTrace()
    @apicall(:LLVMEnablePrettyStackTrace, Cvoid, ())
end

function LLVMInitializeCore(R)
    @apicall(:LLVMInitializeCore, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMShutdown()
    @apicall(:LLVMShutdown, Cvoid, ())
end

function LLVMCreateMessage(Message)
    @apicall(:LLVMCreateMessage, Cstring, (Cstring,), Message)
end

function LLVMDisposeMessage(Message)
    @apicall(:LLVMDisposeMessage, Cvoid, (Cstring,), Message)
end

function LLVMContextCreate()
    @apicall(:LLVMContextCreate, LLVMContextRef, ())
end

function LLVMGetGlobalContext()
    @apicall(:LLVMGetGlobalContext, LLVMContextRef, ())
end

function LLVMContextSetDiagnosticHandler(C, Handler, DiagnosticContext)
    @apicall(:LLVMContextSetDiagnosticHandler, Cvoid, (LLVMContextRef, LLVMDiagnosticHandler, Ptr{Cvoid}), C, Handler, DiagnosticContext)
end

function LLVMContextGetDiagnosticHandler(C)
    @apicall(:LLVMContextGetDiagnosticHandler, LLVMDiagnosticHandler, (LLVMContextRef,), C)
end

function LLVMContextGetDiagnosticContext(C)
    @apicall(:LLVMContextGetDiagnosticContext, Ptr{Cvoid}, (LLVMContextRef,), C)
end

function LLVMContextSetYieldCallback(C, Callback, OpaqueHandle)
    @apicall(:LLVMContextSetYieldCallback, Cvoid, (LLVMContextRef, LLVMYieldCallback, Ptr{Cvoid}), C, Callback, OpaqueHandle)
end

function LLVMContextShouldDiscardValueNames(C)
    @apicall(:LLVMContextShouldDiscardValueNames, LLVMBool, (LLVMContextRef,), C)
end

function LLVMContextSetDiscardValueNames(C, Discard)
    @apicall(:LLVMContextSetDiscardValueNames, Cvoid, (LLVMContextRef, LLVMBool), C, Discard)
end

function LLVMContextDispose(C)
    @apicall(:LLVMContextDispose, Cvoid, (LLVMContextRef,), C)
end

function LLVMGetDiagInfoDescription(DI)
    @apicall(:LLVMGetDiagInfoDescription, Cstring, (LLVMDiagnosticInfoRef,), DI)
end

function LLVMGetDiagInfoSeverity(DI)
    @apicall(:LLVMGetDiagInfoSeverity, LLVMDiagnosticSeverity, (LLVMDiagnosticInfoRef,), DI)
end

function LLVMGetMDKindIDInContext(C, Name, SLen)
    @apicall(:LLVMGetMDKindIDInContext, UInt32, (LLVMContextRef, Cstring, UInt32), C, Name, SLen)
end

function LLVMGetMDKindID(Name, SLen)
    @apicall(:LLVMGetMDKindID, UInt32, (Cstring, UInt32), Name, SLen)
end

function LLVMGetEnumAttributeKindForName(Name, SLen)
    @apicall(:LLVMGetEnumAttributeKindForName, UInt32, (Cstring, Csize_t), Name, SLen)
end

function LLVMGetLastEnumAttributeKind()
    @apicall(:LLVMGetLastEnumAttributeKind, UInt32, ())
end

function LLVMCreateEnumAttribute(C, KindID, Val)
    @apicall(:LLVMCreateEnumAttribute, LLVMAttributeRef, (LLVMContextRef, UInt32, UInt64), C, KindID, Val)
end

function LLVMGetEnumAttributeKind(A)
    @apicall(:LLVMGetEnumAttributeKind, UInt32, (LLVMAttributeRef,), A)
end

function LLVMGetEnumAttributeValue(A)
    @apicall(:LLVMGetEnumAttributeValue, UInt64, (LLVMAttributeRef,), A)
end

function LLVMCreateStringAttribute(C, K, KLength, V, VLength)
    @apicall(:LLVMCreateStringAttribute, LLVMAttributeRef, (LLVMContextRef, Cstring, UInt32, Cstring, UInt32), C, K, KLength, V, VLength)
end

function LLVMGetStringAttributeKind(A, Length)
    @apicall(:LLVMGetStringAttributeKind, Cstring, (LLVMAttributeRef, Ptr{UInt32}), A, Length)
end

function LLVMGetStringAttributeValue(A, Length)
    @apicall(:LLVMGetStringAttributeValue, Cstring, (LLVMAttributeRef, Ptr{UInt32}), A, Length)
end

function LLVMIsEnumAttribute(A)
    @apicall(:LLVMIsEnumAttribute, LLVMBool, (LLVMAttributeRef,), A)
end

function LLVMIsStringAttribute(A)
    @apicall(:LLVMIsStringAttribute, LLVMBool, (LLVMAttributeRef,), A)
end

function LLVMModuleCreateWithName(ModuleID)
    @apicall(:LLVMModuleCreateWithName, LLVMModuleRef, (Cstring,), ModuleID)
end

function LLVMModuleCreateWithNameInContext(ModuleID, C)
    @apicall(:LLVMModuleCreateWithNameInContext, LLVMModuleRef, (Cstring, LLVMContextRef), ModuleID, C)
end

function LLVMCloneModule(M)
    @apicall(:LLVMCloneModule, LLVMModuleRef, (LLVMModuleRef,), M)
end

function LLVMDisposeModule(M)
    @apicall(:LLVMDisposeModule, Cvoid, (LLVMModuleRef,), M)
end

function LLVMGetModuleIdentifier(M, Len)
    @apicall(:LLVMGetModuleIdentifier, Cstring, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMSetModuleIdentifier(M, Ident, Len)
    @apicall(:LLVMSetModuleIdentifier, Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Ident, Len)
end

function LLVMGetSourceFileName(M, Len)
    @apicall(:LLVMGetSourceFileName, Cstring, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMSetSourceFileName(M, Name, Len)
    @apicall(:LLVMSetSourceFileName, Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Name, Len)
end

function LLVMGetDataLayoutStr(M)
    @apicall(:LLVMGetDataLayoutStr, Cstring, (LLVMModuleRef,), M)
end

function LLVMGetDataLayout(M)
    @apicall(:LLVMGetDataLayout, Cstring, (LLVMModuleRef,), M)
end

function LLVMSetDataLayout(M, DataLayoutStr)
    @apicall(:LLVMSetDataLayout, Cvoid, (LLVMModuleRef, Cstring), M, DataLayoutStr)
end

function LLVMGetTarget(M)
    @apicall(:LLVMGetTarget, Cstring, (LLVMModuleRef,), M)
end

function LLVMSetTarget(M, Triple)
    @apicall(:LLVMSetTarget, Cvoid, (LLVMModuleRef, Cstring), M, Triple)
end

function LLVMCopyModuleFlagsMetadata(M, Len)
    @apicall(:LLVMCopyModuleFlagsMetadata, Ptr{LLVMModuleFlagEntry}, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMDisposeModuleFlagsMetadata(Entries)
    @apicall(:LLVMDisposeModuleFlagsMetadata, Cvoid, (Ptr{LLVMModuleFlagEntry},), Entries)
end

function LLVMModuleFlagEntriesGetFlagBehavior(Entries, Index)
    @apicall(:LLVMModuleFlagEntriesGetFlagBehavior, LLVMModuleFlagBehavior, (Ptr{LLVMModuleFlagEntry}, UInt32), Entries, Index)
end

function LLVMModuleFlagEntriesGetKey(Entries, Index, Len)
    @apicall(:LLVMModuleFlagEntriesGetKey, Cstring, (Ptr{LLVMModuleFlagEntry}, UInt32, Ptr{Csize_t}), Entries, Index, Len)
end

function LLVMModuleFlagEntriesGetMetadata(Entries, Index)
    @apicall(:LLVMModuleFlagEntriesGetMetadata, LLVMMetadataRef, (Ptr{LLVMModuleFlagEntry}, UInt32), Entries, Index)
end

function LLVMGetModuleFlag(M, Key, KeyLen)
    @apicall(:LLVMGetModuleFlag, LLVMMetadataRef, (LLVMModuleRef, Cstring, Csize_t), M, Key, KeyLen)
end

function LLVMAddModuleFlag(M, Behavior, Key, KeyLen, Val)
    @apicall(:LLVMAddModuleFlag, Cvoid, (LLVMModuleRef, LLVMModuleFlagBehavior, Cstring, Csize_t, LLVMMetadataRef), M, Behavior, Key, KeyLen, Val)
end

function LLVMDumpModule(M)
    @apicall(:LLVMDumpModule, Cvoid, (LLVMModuleRef,), M)
end

function LLVMPrintModuleToFile(M, Filename, ErrorMessage)
    @apicall(:LLVMPrintModuleToFile, LLVMBool, (LLVMModuleRef, Cstring, Ptr{Cstring}), M, Filename, ErrorMessage)
end

function LLVMPrintModuleToString(M)
    @apicall(:LLVMPrintModuleToString, Cstring, (LLVMModuleRef,), M)
end

function LLVMGetModuleInlineAsm(M, Len)
    @apicall(:LLVMGetModuleInlineAsm, Cstring, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMSetModuleInlineAsm2(M, Asm, Len)
    @apicall(:LLVMSetModuleInlineAsm2, Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Asm, Len)
end

function LLVMAppendModuleInlineAsm(M, Asm, Len)
    @apicall(:LLVMAppendModuleInlineAsm, Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Asm, Len)
end

function LLVMGetInlineAsm(Ty, AsmString, AsmStringSize, Constraints, ConstraintsSize, HasSideEffects, IsAlignStack, Dialect)
    @apicall(:LLVMGetInlineAsm, LLVMValueRef, (LLVMTypeRef, Cstring, Csize_t, Cstring, Csize_t, LLVMBool, LLVMBool, LLVMInlineAsmDialect), Ty, AsmString, AsmStringSize, Constraints, ConstraintsSize, HasSideEffects, IsAlignStack, Dialect)
end

function LLVMGetModuleContext(M)
    @apicall(:LLVMGetModuleContext, LLVMContextRef, (LLVMModuleRef,), M)
end

function LLVMGetTypeByName(M, Name)
    @apicall(:LLVMGetTypeByName, LLVMTypeRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetFirstNamedMetadata(M)
    @apicall(:LLVMGetFirstNamedMetadata, LLVMNamedMDNodeRef, (LLVMModuleRef,), M)
end

function LLVMGetLastNamedMetadata(M)
    @apicall(:LLVMGetLastNamedMetadata, LLVMNamedMDNodeRef, (LLVMModuleRef,), M)
end

function LLVMGetNextNamedMetadata(NamedMDNode)
    @apicall(:LLVMGetNextNamedMetadata, LLVMNamedMDNodeRef, (LLVMNamedMDNodeRef,), NamedMDNode)
end

function LLVMGetPreviousNamedMetadata(NamedMDNode)
    @apicall(:LLVMGetPreviousNamedMetadata, LLVMNamedMDNodeRef, (LLVMNamedMDNodeRef,), NamedMDNode)
end

function LLVMGetNamedMetadata(M, Name, NameLen)
    @apicall(:LLVMGetNamedMetadata, LLVMNamedMDNodeRef, (LLVMModuleRef, Cstring, Csize_t), M, Name, NameLen)
end

function LLVMGetOrInsertNamedMetadata(M, Name, NameLen)
    @apicall(:LLVMGetOrInsertNamedMetadata, LLVMNamedMDNodeRef, (LLVMModuleRef, Cstring, Csize_t), M, Name, NameLen)
end

function LLVMGetNamedMetadataName(NamedMD, NameLen)
    @apicall(:LLVMGetNamedMetadataName, Cstring, (LLVMNamedMDNodeRef, Ptr{Csize_t}), NamedMD, NameLen)
end

function LLVMGetNamedMetadataNumOperands(M, Name)
    @apicall(:LLVMGetNamedMetadataNumOperands, UInt32, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetNamedMetadataOperands(M, Name, Dest)
    @apicall(:LLVMGetNamedMetadataOperands, Cvoid, (LLVMModuleRef, Cstring, Ptr{LLVMValueRef}), M, Name, Dest)
end

function LLVMAddNamedMetadataOperand(M, Name, Val)
    @apicall(:LLVMAddNamedMetadataOperand, Cvoid, (LLVMModuleRef, Cstring, LLVMValueRef), M, Name, Val)
end

function LLVMGetDebugLocDirectory(Val, Length)
    @apicall(:LLVMGetDebugLocDirectory, Cstring, (LLVMValueRef, Ptr{UInt32}), Val, Length)
end

function LLVMGetDebugLocFilename(Val, Length)
    @apicall(:LLVMGetDebugLocFilename, Cstring, (LLVMValueRef, Ptr{UInt32}), Val, Length)
end

function LLVMGetDebugLocLine(Val)
    @apicall(:LLVMGetDebugLocLine, UInt32, (LLVMValueRef,), Val)
end

function LLVMGetDebugLocColumn(Val)
    @apicall(:LLVMGetDebugLocColumn, UInt32, (LLVMValueRef,), Val)
end

function LLVMAddFunction(M, Name, FunctionTy)
    @apicall(:LLVMAddFunction, LLVMValueRef, (LLVMModuleRef, Cstring, LLVMTypeRef), M, Name, FunctionTy)
end

function LLVMGetNamedFunction(M, Name)
    @apicall(:LLVMGetNamedFunction, LLVMValueRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetFirstFunction(M)
    @apicall(:LLVMGetFirstFunction, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastFunction(M)
    @apicall(:LLVMGetLastFunction, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextFunction(Fn)
    @apicall(:LLVMGetNextFunction, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetPreviousFunction(Fn)
    @apicall(:LLVMGetPreviousFunction, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMSetModuleInlineAsm(M, Asm)
    @apicall(:LLVMSetModuleInlineAsm, Cvoid, (LLVMModuleRef, Cstring), M, Asm)
end

function LLVMGetTypeKind(Ty)
    @apicall(:LLVMGetTypeKind, LLVMTypeKind, (LLVMTypeRef,), Ty)
end

function LLVMTypeIsSized(Ty)
    @apicall(:LLVMTypeIsSized, LLVMBool, (LLVMTypeRef,), Ty)
end

function LLVMGetTypeContext(Ty)
    @apicall(:LLVMGetTypeContext, LLVMContextRef, (LLVMTypeRef,), Ty)
end

function LLVMDumpType(Val)
    @apicall(:LLVMDumpType, Cvoid, (LLVMTypeRef,), Val)
end

function LLVMPrintTypeToString(Val)
    @apicall(:LLVMPrintTypeToString, Cstring, (LLVMTypeRef,), Val)
end

function LLVMInt1TypeInContext(C)
    @apicall(:LLVMInt1TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt8TypeInContext(C)
    @apicall(:LLVMInt8TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt16TypeInContext(C)
    @apicall(:LLVMInt16TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt32TypeInContext(C)
    @apicall(:LLVMInt32TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt64TypeInContext(C)
    @apicall(:LLVMInt64TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt128TypeInContext(C)
    @apicall(:LLVMInt128TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMIntTypeInContext(C, NumBits)
    @apicall(:LLVMIntTypeInContext, LLVMTypeRef, (LLVMContextRef, UInt32), C, NumBits)
end

function LLVMInt1Type()
    @apicall(:LLVMInt1Type, LLVMTypeRef, ())
end

function LLVMInt8Type()
    @apicall(:LLVMInt8Type, LLVMTypeRef, ())
end

function LLVMInt16Type()
    @apicall(:LLVMInt16Type, LLVMTypeRef, ())
end

function LLVMInt32Type()
    @apicall(:LLVMInt32Type, LLVMTypeRef, ())
end

function LLVMInt64Type()
    @apicall(:LLVMInt64Type, LLVMTypeRef, ())
end

function LLVMInt128Type()
    @apicall(:LLVMInt128Type, LLVMTypeRef, ())
end

function LLVMIntType(NumBits)
    @apicall(:LLVMIntType, LLVMTypeRef, (UInt32,), NumBits)
end

function LLVMGetIntTypeWidth(IntegerTy)
    @apicall(:LLVMGetIntTypeWidth, UInt32, (LLVMTypeRef,), IntegerTy)
end

function LLVMHalfTypeInContext(C)
    @apicall(:LLVMHalfTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMFloatTypeInContext(C)
    @apicall(:LLVMFloatTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMDoubleTypeInContext(C)
    @apicall(:LLVMDoubleTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMX86FP80TypeInContext(C)
    @apicall(:LLVMX86FP80TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMFP128TypeInContext(C)
    @apicall(:LLVMFP128TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMPPCFP128TypeInContext(C)
    @apicall(:LLVMPPCFP128TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMHalfType()
    @apicall(:LLVMHalfType, LLVMTypeRef, ())
end

function LLVMFloatType()
    @apicall(:LLVMFloatType, LLVMTypeRef, ())
end

function LLVMDoubleType()
    @apicall(:LLVMDoubleType, LLVMTypeRef, ())
end

function LLVMX86FP80Type()
    @apicall(:LLVMX86FP80Type, LLVMTypeRef, ())
end

function LLVMFP128Type()
    @apicall(:LLVMFP128Type, LLVMTypeRef, ())
end

function LLVMPPCFP128Type()
    @apicall(:LLVMPPCFP128Type, LLVMTypeRef, ())
end

function LLVMFunctionType(ReturnType, ParamTypes, ParamCount, IsVarArg)
    @apicall(:LLVMFunctionType, LLVMTypeRef, (LLVMTypeRef, Ptr{LLVMTypeRef}, UInt32, LLVMBool), ReturnType, ParamTypes, ParamCount, IsVarArg)
end

function LLVMIsFunctionVarArg(FunctionTy)
    @apicall(:LLVMIsFunctionVarArg, LLVMBool, (LLVMTypeRef,), FunctionTy)
end

function LLVMGetReturnType(FunctionTy)
    @apicall(:LLVMGetReturnType, LLVMTypeRef, (LLVMTypeRef,), FunctionTy)
end

function LLVMCountParamTypes(FunctionTy)
    @apicall(:LLVMCountParamTypes, UInt32, (LLVMTypeRef,), FunctionTy)
end

function LLVMGetParamTypes(FunctionTy, Dest)
    @apicall(:LLVMGetParamTypes, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), FunctionTy, Dest)
end

function LLVMStructTypeInContext(C, ElementTypes, ElementCount, Packed)
    @apicall(:LLVMStructTypeInContext, LLVMTypeRef, (LLVMContextRef, Ptr{LLVMTypeRef}, UInt32, LLVMBool), C, ElementTypes, ElementCount, Packed)
end

function LLVMStructType(ElementTypes, ElementCount, Packed)
    @apicall(:LLVMStructType, LLVMTypeRef, (Ptr{LLVMTypeRef}, UInt32, LLVMBool), ElementTypes, ElementCount, Packed)
end

function LLVMStructCreateNamed(C, Name)
    @apicall(:LLVMStructCreateNamed, LLVMTypeRef, (LLVMContextRef, Cstring), C, Name)
end

function LLVMGetStructName(Ty)
    @apicall(:LLVMGetStructName, Cstring, (LLVMTypeRef,), Ty)
end

function LLVMStructSetBody(StructTy, ElementTypes, ElementCount, Packed)
    @apicall(:LLVMStructSetBody, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}, UInt32, LLVMBool), StructTy, ElementTypes, ElementCount, Packed)
end

function LLVMCountStructElementTypes(StructTy)
    @apicall(:LLVMCountStructElementTypes, UInt32, (LLVMTypeRef,), StructTy)
end

function LLVMGetStructElementTypes(StructTy, Dest)
    @apicall(:LLVMGetStructElementTypes, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), StructTy, Dest)
end

function LLVMStructGetTypeAtIndex(StructTy, i)
    @apicall(:LLVMStructGetTypeAtIndex, LLVMTypeRef, (LLVMTypeRef, UInt32), StructTy, i)
end

function LLVMIsPackedStruct(StructTy)
    @apicall(:LLVMIsPackedStruct, LLVMBool, (LLVMTypeRef,), StructTy)
end

function LLVMIsOpaqueStruct(StructTy)
    @apicall(:LLVMIsOpaqueStruct, LLVMBool, (LLVMTypeRef,), StructTy)
end

function LLVMIsLiteralStruct(StructTy)
    @apicall(:LLVMIsLiteralStruct, LLVMBool, (LLVMTypeRef,), StructTy)
end

function LLVMGetElementType(Ty)
    @apicall(:LLVMGetElementType, LLVMTypeRef, (LLVMTypeRef,), Ty)
end

function LLVMGetSubtypes(Tp, Arr)
    @apicall(:LLVMGetSubtypes, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), Tp, Arr)
end

function LLVMGetNumContainedTypes(Tp)
    @apicall(:LLVMGetNumContainedTypes, UInt32, (LLVMTypeRef,), Tp)
end

function LLVMArrayType(ElementType, ElementCount)
    @apicall(:LLVMArrayType, LLVMTypeRef, (LLVMTypeRef, UInt32), ElementType, ElementCount)
end

function LLVMGetArrayLength(ArrayTy)
    @apicall(:LLVMGetArrayLength, UInt32, (LLVMTypeRef,), ArrayTy)
end

function LLVMPointerType(ElementType, AddressSpace)
    @apicall(:LLVMPointerType, LLVMTypeRef, (LLVMTypeRef, UInt32), ElementType, AddressSpace)
end

function LLVMGetPointerAddressSpace(PointerTy)
    @apicall(:LLVMGetPointerAddressSpace, UInt32, (LLVMTypeRef,), PointerTy)
end

function LLVMVectorType(ElementType, ElementCount)
    @apicall(:LLVMVectorType, LLVMTypeRef, (LLVMTypeRef, UInt32), ElementType, ElementCount)
end

function LLVMGetVectorSize(VectorTy)
    @apicall(:LLVMGetVectorSize, UInt32, (LLVMTypeRef,), VectorTy)
end

function LLVMVoidTypeInContext(C)
    @apicall(:LLVMVoidTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMLabelTypeInContext(C)
    @apicall(:LLVMLabelTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMX86MMXTypeInContext(C)
    @apicall(:LLVMX86MMXTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMTokenTypeInContext(C)
    @apicall(:LLVMTokenTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMMetadataTypeInContext(C)
    @apicall(:LLVMMetadataTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMVoidType()
    @apicall(:LLVMVoidType, LLVMTypeRef, ())
end

function LLVMLabelType()
    @apicall(:LLVMLabelType, LLVMTypeRef, ())
end

function LLVMX86MMXType()
    @apicall(:LLVMX86MMXType, LLVMTypeRef, ())
end

function LLVMTypeOf(Val)
    @apicall(:LLVMTypeOf, LLVMTypeRef, (LLVMValueRef,), Val)
end

function LLVMGetValueKind(Val)
    @apicall(:LLVMGetValueKind, LLVMValueKind, (LLVMValueRef,), Val)
end

function LLVMGetValueName2(Val, Length)
    @apicall(:LLVMGetValueName2, Cstring, (LLVMValueRef, Ptr{Csize_t}), Val, Length)
end

function LLVMSetValueName2(Val, Name, NameLen)
    @apicall(:LLVMSetValueName2, Cvoid, (LLVMValueRef, Cstring, Csize_t), Val, Name, NameLen)
end

function LLVMDumpValue(Val)
    @apicall(:LLVMDumpValue, Cvoid, (LLVMValueRef,), Val)
end

function LLVMPrintValueToString(Val)
    @apicall(:LLVMPrintValueToString, Cstring, (LLVMValueRef,), Val)
end

function LLVMReplaceAllUsesWith(OldVal, NewVal)
    @apicall(:LLVMReplaceAllUsesWith, Cvoid, (LLVMValueRef, LLVMValueRef), OldVal, NewVal)
end

function LLVMIsConstant(Val)
    @apicall(:LLVMIsConstant, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMIsUndef(Val)
    @apicall(:LLVMIsUndef, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMIsAArgument(Val)
    @apicall(:LLVMIsAArgument, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABasicBlock(Val)
    @apicall(:LLVMIsABasicBlock, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInlineAsm(Val)
    @apicall(:LLVMIsAInlineAsm, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUser(Val)
    @apicall(:LLVMIsAUser, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstant(Val)
    @apicall(:LLVMIsAConstant, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABlockAddress(Val)
    @apicall(:LLVMIsABlockAddress, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantAggregateZero(Val)
    @apicall(:LLVMIsAConstantAggregateZero, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantArray(Val)
    @apicall(:LLVMIsAConstantArray, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataSequential(Val)
    @apicall(:LLVMIsAConstantDataSequential, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataArray(Val)
    @apicall(:LLVMIsAConstantDataArray, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataVector(Val)
    @apicall(:LLVMIsAConstantDataVector, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantExpr(Val)
    @apicall(:LLVMIsAConstantExpr, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantFP(Val)
    @apicall(:LLVMIsAConstantFP, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantInt(Val)
    @apicall(:LLVMIsAConstantInt, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantPointerNull(Val)
    @apicall(:LLVMIsAConstantPointerNull, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantStruct(Val)
    @apicall(:LLVMIsAConstantStruct, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantTokenNone(Val)
    @apicall(:LLVMIsAConstantTokenNone, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantVector(Val)
    @apicall(:LLVMIsAConstantVector, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalValue(Val)
    @apicall(:LLVMIsAGlobalValue, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalAlias(Val)
    @apicall(:LLVMIsAGlobalAlias, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalIFunc(Val)
    @apicall(:LLVMIsAGlobalIFunc, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalObject(Val)
    @apicall(:LLVMIsAGlobalObject, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFunction(Val)
    @apicall(:LLVMIsAFunction, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalVariable(Val)
    @apicall(:LLVMIsAGlobalVariable, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUndefValue(Val)
    @apicall(:LLVMIsAUndefValue, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInstruction(Val)
    @apicall(:LLVMIsAInstruction, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABinaryOperator(Val)
    @apicall(:LLVMIsABinaryOperator, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACallInst(Val)
    @apicall(:LLVMIsACallInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIntrinsicInst(Val)
    @apicall(:LLVMIsAIntrinsicInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgInfoIntrinsic(Val)
    @apicall(:LLVMIsADbgInfoIntrinsic, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgVariableIntrinsic(Val)
    @apicall(:LLVMIsADbgVariableIntrinsic, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgDeclareInst(Val)
    @apicall(:LLVMIsADbgDeclareInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgLabelInst(Val)
    @apicall(:LLVMIsADbgLabelInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemIntrinsic(Val)
    @apicall(:LLVMIsAMemIntrinsic, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemCpyInst(Val)
    @apicall(:LLVMIsAMemCpyInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemMoveInst(Val)
    @apicall(:LLVMIsAMemMoveInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemSetInst(Val)
    @apicall(:LLVMIsAMemSetInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACmpInst(Val)
    @apicall(:LLVMIsACmpInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFCmpInst(Val)
    @apicall(:LLVMIsAFCmpInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAICmpInst(Val)
    @apicall(:LLVMIsAICmpInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAExtractElementInst(Val)
    @apicall(:LLVMIsAExtractElementInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGetElementPtrInst(Val)
    @apicall(:LLVMIsAGetElementPtrInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInsertElementInst(Val)
    @apicall(:LLVMIsAInsertElementInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInsertValueInst(Val)
    @apicall(:LLVMIsAInsertValueInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsALandingPadInst(Val)
    @apicall(:LLVMIsALandingPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAPHINode(Val)
    @apicall(:LLVMIsAPHINode, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASelectInst(Val)
    @apicall(:LLVMIsASelectInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAShuffleVectorInst(Val)
    @apicall(:LLVMIsAShuffleVectorInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAStoreInst(Val)
    @apicall(:LLVMIsAStoreInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABranchInst(Val)
    @apicall(:LLVMIsABranchInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIndirectBrInst(Val)
    @apicall(:LLVMIsAIndirectBrInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInvokeInst(Val)
    @apicall(:LLVMIsAInvokeInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAReturnInst(Val)
    @apicall(:LLVMIsAReturnInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASwitchInst(Val)
    @apicall(:LLVMIsASwitchInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUnreachableInst(Val)
    @apicall(:LLVMIsAUnreachableInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAResumeInst(Val)
    @apicall(:LLVMIsAResumeInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACleanupReturnInst(Val)
    @apicall(:LLVMIsACleanupReturnInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACatchReturnInst(Val)
    @apicall(:LLVMIsACatchReturnInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFuncletPadInst(Val)
    @apicall(:LLVMIsAFuncletPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACatchPadInst(Val)
    @apicall(:LLVMIsACatchPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACleanupPadInst(Val)
    @apicall(:LLVMIsACleanupPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUnaryInstruction(Val)
    @apicall(:LLVMIsAUnaryInstruction, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAAllocaInst(Val)
    @apicall(:LLVMIsAAllocaInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACastInst(Val)
    @apicall(:LLVMIsACastInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAAddrSpaceCastInst(Val)
    @apicall(:LLVMIsAAddrSpaceCastInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABitCastInst(Val)
    @apicall(:LLVMIsABitCastInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPExtInst(Val)
    @apicall(:LLVMIsAFPExtInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPToSIInst(Val)
    @apicall(:LLVMIsAFPToSIInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPToUIInst(Val)
    @apicall(:LLVMIsAFPToUIInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPTruncInst(Val)
    @apicall(:LLVMIsAFPTruncInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIntToPtrInst(Val)
    @apicall(:LLVMIsAIntToPtrInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAPtrToIntInst(Val)
    @apicall(:LLVMIsAPtrToIntInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASExtInst(Val)
    @apicall(:LLVMIsASExtInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASIToFPInst(Val)
    @apicall(:LLVMIsASIToFPInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsATruncInst(Val)
    @apicall(:LLVMIsATruncInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUIToFPInst(Val)
    @apicall(:LLVMIsAUIToFPInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAZExtInst(Val)
    @apicall(:LLVMIsAZExtInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAExtractValueInst(Val)
    @apicall(:LLVMIsAExtractValueInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsALoadInst(Val)
    @apicall(:LLVMIsALoadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAVAArgInst(Val)
    @apicall(:LLVMIsAVAArgInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMDNode(Val)
    @apicall(:LLVMIsAMDNode, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMDString(Val)
    @apicall(:LLVMIsAMDString, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMGetValueName(Val)
    @apicall(:LLVMGetValueName, Cstring, (LLVMValueRef,), Val)
end

function LLVMSetValueName(Val, Name)
    @apicall(:LLVMSetValueName, Cvoid, (LLVMValueRef, Cstring), Val, Name)
end

function LLVMGetFirstUse(Val)
    @apicall(:LLVMGetFirstUse, LLVMUseRef, (LLVMValueRef,), Val)
end

function LLVMGetNextUse(U)
    @apicall(:LLVMGetNextUse, LLVMUseRef, (LLVMUseRef,), U)
end

function LLVMGetUser(U)
    @apicall(:LLVMGetUser, LLVMValueRef, (LLVMUseRef,), U)
end

function LLVMGetUsedValue(U)
    @apicall(:LLVMGetUsedValue, LLVMValueRef, (LLVMUseRef,), U)
end

function LLVMGetOperand(Val, Index)
    @apicall(:LLVMGetOperand, LLVMValueRef, (LLVMValueRef, UInt32), Val, Index)
end

function LLVMGetOperandUse(Val, Index)
    @apicall(:LLVMGetOperandUse, LLVMUseRef, (LLVMValueRef, UInt32), Val, Index)
end

function LLVMSetOperand(User, Index, Val)
    @apicall(:LLVMSetOperand, Cvoid, (LLVMValueRef, UInt32, LLVMValueRef), User, Index, Val)
end

function LLVMGetNumOperands(Val)
    @apicall(:LLVMGetNumOperands, Cint, (LLVMValueRef,), Val)
end

function LLVMConstNull(Ty)
    @apicall(:LLVMConstNull, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstAllOnes(Ty)
    @apicall(:LLVMConstAllOnes, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMGetUndef(Ty)
    @apicall(:LLVMGetUndef, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMIsNull(Val)
    @apicall(:LLVMIsNull, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMConstPointerNull(Ty)
    @apicall(:LLVMConstPointerNull, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstInt(IntTy, N, SignExtend)
    @apicall(:LLVMConstInt, LLVMValueRef, (LLVMTypeRef, Culonglong, LLVMBool), IntTy, N, SignExtend)
end

function LLVMConstIntOfArbitraryPrecision(IntTy, NumWords, Words)
    @apicall(:LLVMConstIntOfArbitraryPrecision, LLVMValueRef, (LLVMTypeRef, UInt32, Ptr{UInt64}), IntTy, NumWords, Words)
end

function LLVMConstIntOfString(IntTy, Text, Radix)
    @apicall(:LLVMConstIntOfString, LLVMValueRef, (LLVMTypeRef, Cstring, UInt8), IntTy, Text, Radix)
end

function LLVMConstIntOfStringAndSize(IntTy, Text, SLen, Radix)
    @apicall(:LLVMConstIntOfStringAndSize, LLVMValueRef, (LLVMTypeRef, Cstring, UInt32, UInt8), IntTy, Text, SLen, Radix)
end

function LLVMConstReal(RealTy, N)
    @apicall(:LLVMConstReal, LLVMValueRef, (LLVMTypeRef, Cdouble), RealTy, N)
end

function LLVMConstRealOfString(RealTy, Text)
    @apicall(:LLVMConstRealOfString, LLVMValueRef, (LLVMTypeRef, Cstring), RealTy, Text)
end

function LLVMConstRealOfStringAndSize(RealTy, Text, SLen)
    @apicall(:LLVMConstRealOfStringAndSize, LLVMValueRef, (LLVMTypeRef, Cstring, UInt32), RealTy, Text, SLen)
end

function LLVMConstIntGetZExtValue(ConstantVal)
    @apicall(:LLVMConstIntGetZExtValue, Culonglong, (LLVMValueRef,), ConstantVal)
end

function LLVMConstIntGetSExtValue(ConstantVal)
    @apicall(:LLVMConstIntGetSExtValue, Clonglong, (LLVMValueRef,), ConstantVal)
end

function LLVMConstRealGetDouble(ConstantVal, losesInfo)
    @apicall(:LLVMConstRealGetDouble, Cdouble, (LLVMValueRef, Ptr{LLVMBool}), ConstantVal, losesInfo)
end

function LLVMConstStringInContext(C, Str, Length, DontNullTerminate)
    @apicall(:LLVMConstStringInContext, LLVMValueRef, (LLVMContextRef, Cstring, UInt32, LLVMBool), C, Str, Length, DontNullTerminate)
end

function LLVMConstString(Str, Length, DontNullTerminate)
    @apicall(:LLVMConstString, LLVMValueRef, (Cstring, UInt32, LLVMBool), Str, Length, DontNullTerminate)
end

function LLVMIsConstantString(c)
    @apicall(:LLVMIsConstantString, LLVMBool, (LLVMValueRef,), c)
end

function LLVMGetAsString(c, Length)
    @apicall(:LLVMGetAsString, Cstring, (LLVMValueRef, Ptr{Csize_t}), c, Length)
end

function LLVMConstStructInContext(C, ConstantVals, Count, Packed)
    @apicall(:LLVMConstStructInContext, LLVMValueRef, (LLVMContextRef, Ptr{LLVMValueRef}, UInt32, LLVMBool), C, ConstantVals, Count, Packed)
end

function LLVMConstStruct(ConstantVals, Count, Packed)
    @apicall(:LLVMConstStruct, LLVMValueRef, (Ptr{LLVMValueRef}, UInt32, LLVMBool), ConstantVals, Count, Packed)
end

function LLVMConstArray(ElementTy, ConstantVals, Length)
    @apicall(:LLVMConstArray, LLVMValueRef, (LLVMTypeRef, Ptr{LLVMValueRef}, UInt32), ElementTy, ConstantVals, Length)
end

function LLVMConstNamedStruct(StructTy, ConstantVals, Count)
    @apicall(:LLVMConstNamedStruct, LLVMValueRef, (LLVMTypeRef, Ptr{LLVMValueRef}, UInt32), StructTy, ConstantVals, Count)
end

function LLVMGetElementAsConstant(C, idx)
    @apicall(:LLVMGetElementAsConstant, LLVMValueRef, (LLVMValueRef, UInt32), C, idx)
end

function LLVMConstVector(ScalarConstantVals, Size)
    @apicall(:LLVMConstVector, LLVMValueRef, (Ptr{LLVMValueRef}, UInt32), ScalarConstantVals, Size)
end

function LLVMGetConstOpcode(ConstantVal)
    @apicall(:LLVMGetConstOpcode, LLVMOpcode, (LLVMValueRef,), ConstantVal)
end

function LLVMAlignOf(Ty)
    @apicall(:LLVMAlignOf, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMSizeOf(Ty)
    @apicall(:LLVMSizeOf, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstNeg(ConstantVal)
    @apicall(:LLVMConstNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNSWNeg(ConstantVal)
    @apicall(:LLVMConstNSWNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNUWNeg(ConstantVal)
    @apicall(:LLVMConstNUWNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstFNeg(ConstantVal)
    @apicall(:LLVMConstFNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNot(ConstantVal)
    @apicall(:LLVMConstNot, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstAdd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWAdd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNSWAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWAdd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNUWAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFAdd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSub(LHSConstant, RHSConstant)
    @apicall(:LLVMConstSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWSub(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNSWSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWSub(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNUWSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFSub(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstMul(LHSConstant, RHSConstant)
    @apicall(:LLVMConstMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWMul(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNSWMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWMul(LHSConstant, RHSConstant)
    @apicall(:LLVMConstNUWMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFMul(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstUDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstUDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstExactUDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstExactUDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstSDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstExactSDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstExactSDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFDiv(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstURem(LHSConstant, RHSConstant)
    @apicall(:LLVMConstURem, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSRem(LHSConstant, RHSConstant)
    @apicall(:LLVMConstSRem, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFRem(LHSConstant, RHSConstant)
    @apicall(:LLVMConstFRem, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstAnd(LHSConstant, RHSConstant)
    @apicall(:LLVMConstAnd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstOr(LHSConstant, RHSConstant)
    @apicall(:LLVMConstOr, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstXor(LHSConstant, RHSConstant)
    @apicall(:LLVMConstXor, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstICmp(Predicate, LHSConstant, RHSConstant)
    @apicall(:LLVMConstICmp, LLVMValueRef, (LLVMIntPredicate, LLVMValueRef, LLVMValueRef), Predicate, LHSConstant, RHSConstant)
end

function LLVMConstFCmp(Predicate, LHSConstant, RHSConstant)
    @apicall(:LLVMConstFCmp, LLVMValueRef, (LLVMRealPredicate, LLVMValueRef, LLVMValueRef), Predicate, LHSConstant, RHSConstant)
end

function LLVMConstShl(LHSConstant, RHSConstant)
    @apicall(:LLVMConstShl, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstLShr(LHSConstant, RHSConstant)
    @apicall(:LLVMConstLShr, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstAShr(LHSConstant, RHSConstant)
    @apicall(:LLVMConstAShr, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstGEP(ConstantVal, ConstantIndices, NumIndices)
    @apicall(:LLVMConstGEP, LLVMValueRef, (LLVMValueRef, Ptr{LLVMValueRef}, UInt32), ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstGEP2(Ty, ConstantVal, ConstantIndices, NumIndices)
    @apicall(:LLVMConstGEP2, LLVMValueRef, (LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32), Ty, ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstInBoundsGEP(ConstantVal, ConstantIndices, NumIndices)
    @apicall(:LLVMConstInBoundsGEP, LLVMValueRef, (LLVMValueRef, Ptr{LLVMValueRef}, UInt32), ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstInBoundsGEP2(Ty, ConstantVal, ConstantIndices, NumIndices)
    @apicall(:LLVMConstInBoundsGEP2, LLVMValueRef, (LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32), Ty, ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstTrunc(ConstantVal, ToType)
    @apicall(:LLVMConstTrunc, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSExt(ConstantVal, ToType)
    @apicall(:LLVMConstSExt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstZExt(ConstantVal, ToType)
    @apicall(:LLVMConstZExt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPTrunc(ConstantVal, ToType)
    @apicall(:LLVMConstFPTrunc, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPExt(ConstantVal, ToType)
    @apicall(:LLVMConstFPExt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstUIToFP(ConstantVal, ToType)
    @apicall(:LLVMConstUIToFP, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSIToFP(ConstantVal, ToType)
    @apicall(:LLVMConstSIToFP, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPToUI(ConstantVal, ToType)
    @apicall(:LLVMConstFPToUI, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPToSI(ConstantVal, ToType)
    @apicall(:LLVMConstFPToSI, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstPtrToInt(ConstantVal, ToType)
    @apicall(:LLVMConstPtrToInt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstIntToPtr(ConstantVal, ToType)
    @apicall(:LLVMConstIntToPtr, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstBitCast(ConstantVal, ToType)
    @apicall(:LLVMConstBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstAddrSpaceCast(ConstantVal, ToType)
    @apicall(:LLVMConstAddrSpaceCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstZExtOrBitCast(ConstantVal, ToType)
    @apicall(:LLVMConstZExtOrBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSExtOrBitCast(ConstantVal, ToType)
    @apicall(:LLVMConstSExtOrBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstTruncOrBitCast(ConstantVal, ToType)
    @apicall(:LLVMConstTruncOrBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstPointerCast(ConstantVal, ToType)
    @apicall(:LLVMConstPointerCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstIntCast(ConstantVal, ToType, isSigned)
    @apicall(:LLVMConstIntCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef, LLVMBool), ConstantVal, ToType, isSigned)
end

function LLVMConstFPCast(ConstantVal, ToType)
    @apicall(:LLVMConstFPCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSelect(ConstantCondition, ConstantIfTrue, ConstantIfFalse)
    @apicall(:LLVMConstSelect, LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), ConstantCondition, ConstantIfTrue, ConstantIfFalse)
end

function LLVMConstExtractElement(VectorConstant, IndexConstant)
    @apicall(:LLVMConstExtractElement, LLVMValueRef, (LLVMValueRef, LLVMValueRef), VectorConstant, IndexConstant)
end

function LLVMConstInsertElement(VectorConstant, ElementValueConstant, IndexConstant)
    @apicall(:LLVMConstInsertElement, LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), VectorConstant, ElementValueConstant, IndexConstant)
end

function LLVMConstShuffleVector(VectorAConstant, VectorBConstant, MaskConstant)
    @apicall(:LLVMConstShuffleVector, LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), VectorAConstant, VectorBConstant, MaskConstant)
end

function LLVMConstExtractValue(AggConstant, IdxList, NumIdx)
    @apicall(:LLVMConstExtractValue, LLVMValueRef, (LLVMValueRef, Ptr{UInt32}, UInt32), AggConstant, IdxList, NumIdx)
end

function LLVMConstInsertValue(AggConstant, ElementValueConstant, IdxList, NumIdx)
    @apicall(:LLVMConstInsertValue, LLVMValueRef, (LLVMValueRef, LLVMValueRef, Ptr{UInt32}, UInt32), AggConstant, ElementValueConstant, IdxList, NumIdx)
end

function LLVMBlockAddress(F, BB)
    @apicall(:LLVMBlockAddress, LLVMValueRef, (LLVMValueRef, LLVMBasicBlockRef), F, BB)
end

function LLVMConstInlineAsm(Ty, AsmString, Constraints, HasSideEffects, IsAlignStack)
    @apicall(:LLVMConstInlineAsm, LLVMValueRef, (LLVMTypeRef, Cstring, Cstring, LLVMBool, LLVMBool), Ty, AsmString, Constraints, HasSideEffects, IsAlignStack)
end

function LLVMGetGlobalParent(Global)
    @apicall(:LLVMGetGlobalParent, LLVMModuleRef, (LLVMValueRef,), Global)
end

function LLVMIsDeclaration(Global)
    @apicall(:LLVMIsDeclaration, LLVMBool, (LLVMValueRef,), Global)
end

function LLVMGetLinkage(Global)
    @apicall(:LLVMGetLinkage, LLVMLinkage, (LLVMValueRef,), Global)
end

function LLVMSetLinkage(Global, Linkage)
    @apicall(:LLVMSetLinkage, Cvoid, (LLVMValueRef, LLVMLinkage), Global, Linkage)
end

function LLVMGetSection(Global)
    @apicall(:LLVMGetSection, Cstring, (LLVMValueRef,), Global)
end

function LLVMSetSection(Global, Section)
    @apicall(:LLVMSetSection, Cvoid, (LLVMValueRef, Cstring), Global, Section)
end

function LLVMGetVisibility(Global)
    @apicall(:LLVMGetVisibility, LLVMVisibility, (LLVMValueRef,), Global)
end

function LLVMSetVisibility(Global, Viz)
    @apicall(:LLVMSetVisibility, Cvoid, (LLVMValueRef, LLVMVisibility), Global, Viz)
end

function LLVMGetDLLStorageClass(Global)
    @apicall(:LLVMGetDLLStorageClass, LLVMDLLStorageClass, (LLVMValueRef,), Global)
end

function LLVMSetDLLStorageClass(Global, Class)
    @apicall(:LLVMSetDLLStorageClass, Cvoid, (LLVMValueRef, LLVMDLLStorageClass), Global, Class)
end

function LLVMGetUnnamedAddress(Global)
    @apicall(:LLVMGetUnnamedAddress, LLVMUnnamedAddr, (LLVMValueRef,), Global)
end

function LLVMSetUnnamedAddress(Global, UnnamedAddr)
    @apicall(:LLVMSetUnnamedAddress, Cvoid, (LLVMValueRef, LLVMUnnamedAddr), Global, UnnamedAddr)
end

function LLVMGlobalGetValueType(Global)
    @apicall(:LLVMGlobalGetValueType, LLVMTypeRef, (LLVMValueRef,), Global)
end

function LLVMHasUnnamedAddr(Global)
    @apicall(:LLVMHasUnnamedAddr, LLVMBool, (LLVMValueRef,), Global)
end

function LLVMSetUnnamedAddr(Global, HasUnnamedAddr)
    @apicall(:LLVMSetUnnamedAddr, Cvoid, (LLVMValueRef, LLVMBool), Global, HasUnnamedAddr)
end

function LLVMGetAlignment(V)
    @apicall(:LLVMGetAlignment, UInt32, (LLVMValueRef,), V)
end

function LLVMSetAlignment(V, Bytes)
    @apicall(:LLVMSetAlignment, Cvoid, (LLVMValueRef, UInt32), V, Bytes)
end

function LLVMGlobalSetMetadata(Global, Kind, MD)
    @apicall(:LLVMGlobalSetMetadata, Cvoid, (LLVMValueRef, UInt32, LLVMMetadataRef), Global, Kind, MD)
end

function LLVMGlobalEraseMetadata(Global, Kind)
    @apicall(:LLVMGlobalEraseMetadata, Cvoid, (LLVMValueRef, UInt32), Global, Kind)
end

function LLVMGlobalClearMetadata(Global)
    @apicall(:LLVMGlobalClearMetadata, Cvoid, (LLVMValueRef,), Global)
end

function LLVMGlobalCopyAllMetadata(Value, NumEntries)
    @apicall(:LLVMGlobalCopyAllMetadata, Ptr{LLVMValueMetadataEntry}, (LLVMValueRef, Ptr{Csize_t}), Value, NumEntries)
end

function LLVMDisposeValueMetadataEntries(Entries)
    @apicall(:LLVMDisposeValueMetadataEntries, Cvoid, (Ptr{LLVMValueMetadataEntry},), Entries)
end

function LLVMValueMetadataEntriesGetKind(Entries, Index)
    @apicall(:LLVMValueMetadataEntriesGetKind, UInt32, (Ptr{LLVMValueMetadataEntry}, UInt32), Entries, Index)
end

function LLVMValueMetadataEntriesGetMetadata(Entries, Index)
    @apicall(:LLVMValueMetadataEntriesGetMetadata, LLVMMetadataRef, (Ptr{LLVMValueMetadataEntry}, UInt32), Entries, Index)
end

function LLVMAddGlobal(M, Ty, Name)
    @apicall(:LLVMAddGlobal, LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, Cstring), M, Ty, Name)
end

function LLVMAddGlobalInAddressSpace(M, Ty, Name, AddressSpace)
    @apicall(:LLVMAddGlobalInAddressSpace, LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, Cstring, UInt32), M, Ty, Name, AddressSpace)
end

function LLVMGetNamedGlobal(M, Name)
    @apicall(:LLVMGetNamedGlobal, LLVMValueRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetFirstGlobal(M)
    @apicall(:LLVMGetFirstGlobal, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastGlobal(M)
    @apicall(:LLVMGetLastGlobal, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextGlobal(GlobalVar)
    @apicall(:LLVMGetNextGlobal, LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMGetPreviousGlobal(GlobalVar)
    @apicall(:LLVMGetPreviousGlobal, LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMDeleteGlobal(GlobalVar)
    @apicall(:LLVMDeleteGlobal, Cvoid, (LLVMValueRef,), GlobalVar)
end

function LLVMGetInitializer(GlobalVar)
    @apicall(:LLVMGetInitializer, LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMSetInitializer(GlobalVar, ConstantVal)
    @apicall(:LLVMSetInitializer, Cvoid, (LLVMValueRef, LLVMValueRef), GlobalVar, ConstantVal)
end

function LLVMIsThreadLocal(GlobalVar)
    @apicall(:LLVMIsThreadLocal, LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetThreadLocal(GlobalVar, IsThreadLocal)
    @apicall(:LLVMSetThreadLocal, Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsThreadLocal)
end

function LLVMIsGlobalConstant(GlobalVar)
    @apicall(:LLVMIsGlobalConstant, LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetGlobalConstant(GlobalVar, IsConstant)
    @apicall(:LLVMSetGlobalConstant, Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsConstant)
end

function LLVMGetThreadLocalMode(GlobalVar)
    @apicall(:LLVMGetThreadLocalMode, LLVMThreadLocalMode, (LLVMValueRef,), GlobalVar)
end

function LLVMSetThreadLocalMode(GlobalVar, Mode)
    @apicall(:LLVMSetThreadLocalMode, Cvoid, (LLVMValueRef, LLVMThreadLocalMode), GlobalVar, Mode)
end

function LLVMIsExternallyInitialized(GlobalVar)
    @apicall(:LLVMIsExternallyInitialized, LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetExternallyInitialized(GlobalVar, IsExtInit)
    @apicall(:LLVMSetExternallyInitialized, Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsExtInit)
end

function LLVMAddAlias(M, Ty, Aliasee, Name)
    @apicall(:LLVMAddAlias, LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, LLVMValueRef, Cstring), M, Ty, Aliasee, Name)
end

function LLVMGetNamedGlobalAlias(M, Name, NameLen)
    @apicall(:LLVMGetNamedGlobalAlias, LLVMValueRef, (LLVMModuleRef, Cstring, Csize_t), M, Name, NameLen)
end

function LLVMGetFirstGlobalAlias(M)
    @apicall(:LLVMGetFirstGlobalAlias, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastGlobalAlias(M)
    @apicall(:LLVMGetLastGlobalAlias, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextGlobalAlias(GA)
    @apicall(:LLVMGetNextGlobalAlias, LLVMValueRef, (LLVMValueRef,), GA)
end

function LLVMGetPreviousGlobalAlias(GA)
    @apicall(:LLVMGetPreviousGlobalAlias, LLVMValueRef, (LLVMValueRef,), GA)
end

function LLVMAliasGetAliasee(Alias)
    @apicall(:LLVMAliasGetAliasee, LLVMValueRef, (LLVMValueRef,), Alias)
end

function LLVMAliasSetAliasee(Alias, Aliasee)
    @apicall(:LLVMAliasSetAliasee, Cvoid, (LLVMValueRef, LLVMValueRef), Alias, Aliasee)
end

function LLVMDeleteFunction(Fn)
    @apicall(:LLVMDeleteFunction, Cvoid, (LLVMValueRef,), Fn)
end

function LLVMHasPersonalityFn(Fn)
    @apicall(:LLVMHasPersonalityFn, LLVMBool, (LLVMValueRef,), Fn)
end

function LLVMGetPersonalityFn(Fn)
    @apicall(:LLVMGetPersonalityFn, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMSetPersonalityFn(Fn, PersonalityFn)
    @apicall(:LLVMSetPersonalityFn, Cvoid, (LLVMValueRef, LLVMValueRef), Fn, PersonalityFn)
end

function LLVMGetIntrinsicID(Fn)
    @apicall(:LLVMGetIntrinsicID, UInt32, (LLVMValueRef,), Fn)
end

function LLVMGetIntrinsicDeclaration(Mod, ID, ParamTypes, ParamCount)
    @apicall(:LLVMGetIntrinsicDeclaration, LLVMValueRef, (LLVMModuleRef, UInt32, Ptr{LLVMTypeRef}, Csize_t), Mod, ID, ParamTypes, ParamCount)
end

function LLVMIntrinsicGetType(Ctx, ID, ParamTypes, ParamCount)
    @apicall(:LLVMIntrinsicGetType, LLVMTypeRef, (LLVMContextRef, UInt32, Ptr{LLVMTypeRef}, Csize_t), Ctx, ID, ParamTypes, ParamCount)
end

function LLVMIntrinsicGetName(ID, NameLength)
    @apicall(:LLVMIntrinsicGetName, Cstring, (UInt32, Ptr{Csize_t}), ID, NameLength)
end

function LLVMIntrinsicCopyOverloadedName(ID, ParamTypes, ParamCount, NameLength)
    @apicall(:LLVMIntrinsicCopyOverloadedName, Cstring, (UInt32, Ptr{LLVMTypeRef}, Csize_t, Ptr{Csize_t}), ID, ParamTypes, ParamCount, NameLength)
end

function LLVMIntrinsicIsOverloaded(ID)
    @apicall(:LLVMIntrinsicIsOverloaded, LLVMBool, (UInt32,), ID)
end

function LLVMGetFunctionCallConv(Fn)
    @apicall(:LLVMGetFunctionCallConv, UInt32, (LLVMValueRef,), Fn)
end

function LLVMSetFunctionCallConv(Fn, CC)
    @apicall(:LLVMSetFunctionCallConv, Cvoid, (LLVMValueRef, UInt32), Fn, CC)
end

function LLVMGetGC(Fn)
    @apicall(:LLVMGetGC, Cstring, (LLVMValueRef,), Fn)
end

function LLVMSetGC(Fn, Name)
    @apicall(:LLVMSetGC, Cvoid, (LLVMValueRef, Cstring), Fn, Name)
end

function LLVMAddAttributeAtIndex(F, Idx, A)
    @apicall(:LLVMAddAttributeAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, LLVMAttributeRef), F, Idx, A)
end

function LLVMGetAttributeCountAtIndex(F, Idx)
    @apicall(:LLVMGetAttributeCountAtIndex, UInt32, (LLVMValueRef, LLVMAttributeIndex), F, Idx)
end

function LLVMGetAttributesAtIndex(F, Idx, Attrs)
    @apicall(:LLVMGetAttributesAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Ptr{LLVMAttributeRef}), F, Idx, Attrs)
end

function LLVMGetEnumAttributeAtIndex(F, Idx, KindID)
    @apicall(:LLVMGetEnumAttributeAtIndex, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, UInt32), F, Idx, KindID)
end

function LLVMGetStringAttributeAtIndex(F, Idx, K, KLen)
    @apicall(:LLVMGetStringAttributeAtIndex, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), F, Idx, K, KLen)
end

function LLVMRemoveEnumAttributeAtIndex(F, Idx, KindID)
    @apicall(:LLVMRemoveEnumAttributeAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, UInt32), F, Idx, KindID)
end

function LLVMRemoveStringAttributeAtIndex(F, Idx, K, KLen)
    @apicall(:LLVMRemoveStringAttributeAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), F, Idx, K, KLen)
end

function LLVMAddTargetDependentFunctionAttr(Fn, A, V)
    @apicall(:LLVMAddTargetDependentFunctionAttr, Cvoid, (LLVMValueRef, Cstring, Cstring), Fn, A, V)
end

function LLVMCountParams(Fn)
    @apicall(:LLVMCountParams, UInt32, (LLVMValueRef,), Fn)
end

function LLVMGetParams(Fn, Params)
    @apicall(:LLVMGetParams, Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}), Fn, Params)
end

function LLVMGetParam(Fn, Index)
    @apicall(:LLVMGetParam, LLVMValueRef, (LLVMValueRef, UInt32), Fn, Index)
end

function LLVMGetParamParent(Inst)
    @apicall(:LLVMGetParamParent, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetFirstParam(Fn)
    @apicall(:LLVMGetFirstParam, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetLastParam(Fn)
    @apicall(:LLVMGetLastParam, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetNextParam(Arg)
    @apicall(:LLVMGetNextParam, LLVMValueRef, (LLVMValueRef,), Arg)
end

function LLVMGetPreviousParam(Arg)
    @apicall(:LLVMGetPreviousParam, LLVMValueRef, (LLVMValueRef,), Arg)
end

function LLVMSetParamAlignment(Arg, Align)
    @apicall(:LLVMSetParamAlignment, Cvoid, (LLVMValueRef, UInt32), Arg, Align)
end

function LLVMMDStringInContext(C, Str, SLen)
    @apicall(:LLVMMDStringInContext, LLVMValueRef, (LLVMContextRef, Cstring, UInt32), C, Str, SLen)
end

function LLVMMDString(Str, SLen)
    @apicall(:LLVMMDString, LLVMValueRef, (Cstring, UInt32), Str, SLen)
end

function LLVMMDNodeInContext(C, Vals, Count)
    @apicall(:LLVMMDNodeInContext, LLVMValueRef, (LLVMContextRef, Ptr{LLVMValueRef}, UInt32), C, Vals, Count)
end

function LLVMMDNode(Vals, Count)
    @apicall(:LLVMMDNode, LLVMValueRef, (Ptr{LLVMValueRef}, UInt32), Vals, Count)
end

function LLVMMetadataAsValue(C, MD)
    @apicall(:LLVMMetadataAsValue, LLVMValueRef, (LLVMContextRef, LLVMMetadataRef), C, MD)
end

function LLVMValueAsMetadata(Val)
    @apicall(:LLVMValueAsMetadata, LLVMMetadataRef, (LLVMValueRef,), Val)
end

function LLVMGetMDString(V, Length)
    @apicall(:LLVMGetMDString, Cstring, (LLVMValueRef, Ptr{UInt32}), V, Length)
end

function LLVMGetMDNodeNumOperands(V)
    @apicall(:LLVMGetMDNodeNumOperands, UInt32, (LLVMValueRef,), V)
end

function LLVMGetMDNodeOperands(V, Dest)
    @apicall(:LLVMGetMDNodeOperands, Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}), V, Dest)
end

function LLVMBasicBlockAsValue(BB)
    @apicall(:LLVMBasicBlockAsValue, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMValueIsBasicBlock(Val)
    @apicall(:LLVMValueIsBasicBlock, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMValueAsBasicBlock(Val)
    @apicall(:LLVMValueAsBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Val)
end

function LLVMGetBasicBlockName(BB)
    @apicall(:LLVMGetBasicBlockName, Cstring, (LLVMBasicBlockRef,), BB)
end

function LLVMGetBasicBlockParent(BB)
    @apicall(:LLVMGetBasicBlockParent, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetBasicBlockTerminator(BB)
    @apicall(:LLVMGetBasicBlockTerminator, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMCountBasicBlocks(Fn)
    @apicall(:LLVMCountBasicBlocks, UInt32, (LLVMValueRef,), Fn)
end

function LLVMGetBasicBlocks(Fn, BasicBlocks)
    @apicall(:LLVMGetBasicBlocks, Cvoid, (LLVMValueRef, Ptr{LLVMBasicBlockRef}), Fn, BasicBlocks)
end

function LLVMGetFirstBasicBlock(Fn)
    @apicall(:LLVMGetFirstBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

function LLVMGetLastBasicBlock(Fn)
    @apicall(:LLVMGetLastBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

function LLVMGetNextBasicBlock(BB)
    @apicall(:LLVMGetNextBasicBlock, LLVMBasicBlockRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetPreviousBasicBlock(BB)
    @apicall(:LLVMGetPreviousBasicBlock, LLVMBasicBlockRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetEntryBasicBlock(Fn)
    @apicall(:LLVMGetEntryBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

function LLVMCreateBasicBlockInContext(C, Name)
    @apicall(:LLVMCreateBasicBlockInContext, LLVMBasicBlockRef, (LLVMContextRef, Cstring), C, Name)
end

function LLVMAppendBasicBlockInContext(C, Fn, Name)
    @apicall(:LLVMAppendBasicBlockInContext, LLVMBasicBlockRef, (LLVMContextRef, LLVMValueRef, Cstring), C, Fn, Name)
end

function LLVMAppendBasicBlock(Fn, Name)
    @apicall(:LLVMAppendBasicBlock, LLVMBasicBlockRef, (LLVMValueRef, Cstring), Fn, Name)
end

function LLVMInsertBasicBlockInContext(C, BB, Name)
    @apicall(:LLVMInsertBasicBlockInContext, LLVMBasicBlockRef, (LLVMContextRef, LLVMBasicBlockRef, Cstring), C, BB, Name)
end

function LLVMInsertBasicBlock(InsertBeforeBB, Name)
    @apicall(:LLVMInsertBasicBlock, LLVMBasicBlockRef, (LLVMBasicBlockRef, Cstring), InsertBeforeBB, Name)
end

function LLVMDeleteBasicBlock(BB)
    @apicall(:LLVMDeleteBasicBlock, Cvoid, (LLVMBasicBlockRef,), BB)
end

function LLVMRemoveBasicBlockFromParent(BB)
    @apicall(:LLVMRemoveBasicBlockFromParent, Cvoid, (LLVMBasicBlockRef,), BB)
end

function LLVMMoveBasicBlockBefore(BB, MovePos)
    @apicall(:LLVMMoveBasicBlockBefore, Cvoid, (LLVMBasicBlockRef, LLVMBasicBlockRef), BB, MovePos)
end

function LLVMMoveBasicBlockAfter(BB, MovePos)
    @apicall(:LLVMMoveBasicBlockAfter, Cvoid, (LLVMBasicBlockRef, LLVMBasicBlockRef), BB, MovePos)
end

function LLVMGetFirstInstruction(BB)
    @apicall(:LLVMGetFirstInstruction, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetLastInstruction(BB)
    @apicall(:LLVMGetLastInstruction, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMHasMetadata(Val)
    @apicall(:LLVMHasMetadata, Cint, (LLVMValueRef,), Val)
end

function LLVMGetMetadata(Val, KindID)
    @apicall(:LLVMGetMetadata, LLVMValueRef, (LLVMValueRef, UInt32), Val, KindID)
end

function LLVMSetMetadata(Val, KindID, Node)
    @apicall(:LLVMSetMetadata, Cvoid, (LLVMValueRef, UInt32, LLVMValueRef), Val, KindID, Node)
end

function LLVMInstructionGetAllMetadataOtherThanDebugLoc(Instr, NumEntries)
    @apicall(:LLVMInstructionGetAllMetadataOtherThanDebugLoc, Ptr{LLVMValueMetadataEntry}, (LLVMValueRef, Ptr{Csize_t}), Instr, NumEntries)
end

function LLVMGetInstructionParent(Inst)
    @apicall(:LLVMGetInstructionParent, LLVMBasicBlockRef, (LLVMValueRef,), Inst)
end

function LLVMGetNextInstruction(Inst)
    @apicall(:LLVMGetNextInstruction, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetPreviousInstruction(Inst)
    @apicall(:LLVMGetPreviousInstruction, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMInstructionRemoveFromParent(Inst)
    @apicall(:LLVMInstructionRemoveFromParent, Cvoid, (LLVMValueRef,), Inst)
end

function LLVMInstructionEraseFromParent(Inst)
    @apicall(:LLVMInstructionEraseFromParent, Cvoid, (LLVMValueRef,), Inst)
end

function LLVMGetInstructionOpcode(Inst)
    @apicall(:LLVMGetInstructionOpcode, LLVMOpcode, (LLVMValueRef,), Inst)
end

function LLVMGetICmpPredicate(Inst)
    @apicall(:LLVMGetICmpPredicate, LLVMIntPredicate, (LLVMValueRef,), Inst)
end

function LLVMGetFCmpPredicate(Inst)
    @apicall(:LLVMGetFCmpPredicate, LLVMRealPredicate, (LLVMValueRef,), Inst)
end

function LLVMInstructionClone(Inst)
    @apicall(:LLVMInstructionClone, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMIsATerminatorInst(Inst)
    @apicall(:LLVMIsATerminatorInst, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetNumArgOperands(Instr)
    @apicall(:LLVMGetNumArgOperands, UInt32, (LLVMValueRef,), Instr)
end

function LLVMSetInstructionCallConv(Instr, CC)
    @apicall(:LLVMSetInstructionCallConv, Cvoid, (LLVMValueRef, UInt32), Instr, CC)
end

function LLVMGetInstructionCallConv(Instr)
    @apicall(:LLVMGetInstructionCallConv, UInt32, (LLVMValueRef,), Instr)
end

function LLVMSetInstrParamAlignment(Instr, index, Align)
    @apicall(:LLVMSetInstrParamAlignment, Cvoid, (LLVMValueRef, UInt32, UInt32), Instr, index, Align)
end

function LLVMAddCallSiteAttribute(C, Idx, A)
    @apicall(:LLVMAddCallSiteAttribute, Cvoid, (LLVMValueRef, LLVMAttributeIndex, LLVMAttributeRef), C, Idx, A)
end

function LLVMGetCallSiteAttributeCount(C, Idx)
    @apicall(:LLVMGetCallSiteAttributeCount, UInt32, (LLVMValueRef, LLVMAttributeIndex), C, Idx)
end

function LLVMGetCallSiteAttributes(C, Idx, Attrs)
    @apicall(:LLVMGetCallSiteAttributes, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Ptr{LLVMAttributeRef}), C, Idx, Attrs)
end

function LLVMGetCallSiteEnumAttribute(C, Idx, KindID)
    @apicall(:LLVMGetCallSiteEnumAttribute, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, UInt32), C, Idx, KindID)
end

function LLVMGetCallSiteStringAttribute(C, Idx, K, KLen)
    @apicall(:LLVMGetCallSiteStringAttribute, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), C, Idx, K, KLen)
end

function LLVMRemoveCallSiteEnumAttribute(C, Idx, KindID)
    @apicall(:LLVMRemoveCallSiteEnumAttribute, Cvoid, (LLVMValueRef, LLVMAttributeIndex, UInt32), C, Idx, KindID)
end

function LLVMRemoveCallSiteStringAttribute(C, Idx, K, KLen)
    @apicall(:LLVMRemoveCallSiteStringAttribute, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), C, Idx, K, KLen)
end

function LLVMGetCalledFunctionType(C)
    @apicall(:LLVMGetCalledFunctionType, LLVMTypeRef, (LLVMValueRef,), C)
end

function LLVMGetCalledValue(Instr)
    @apicall(:LLVMGetCalledValue, LLVMValueRef, (LLVMValueRef,), Instr)
end

function LLVMIsTailCall(CallInst)
    @apicall(:LLVMIsTailCall, LLVMBool, (LLVMValueRef,), CallInst)
end

function LLVMSetTailCall(CallInst, IsTailCall)
    @apicall(:LLVMSetTailCall, Cvoid, (LLVMValueRef, LLVMBool), CallInst, IsTailCall)
end

function LLVMGetNormalDest(InvokeInst)
    @apicall(:LLVMGetNormalDest, LLVMBasicBlockRef, (LLVMValueRef,), InvokeInst)
end

function LLVMGetUnwindDest(InvokeInst)
    @apicall(:LLVMGetUnwindDest, LLVMBasicBlockRef, (LLVMValueRef,), InvokeInst)
end

function LLVMSetNormalDest(InvokeInst, B)
    @apicall(:LLVMSetNormalDest, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), InvokeInst, B)
end

function LLVMSetUnwindDest(InvokeInst, B)
    @apicall(:LLVMSetUnwindDest, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), InvokeInst, B)
end

function LLVMGetNumSuccessors(Term)
    @apicall(:LLVMGetNumSuccessors, UInt32, (LLVMValueRef,), Term)
end

function LLVMGetSuccessor(Term, i)
    @apicall(:LLVMGetSuccessor, LLVMBasicBlockRef, (LLVMValueRef, UInt32), Term, i)
end

function LLVMSetSuccessor(Term, i, block)
    @apicall(:LLVMSetSuccessor, Cvoid, (LLVMValueRef, UInt32, LLVMBasicBlockRef), Term, i, block)
end

function LLVMIsConditional(Branch)
    @apicall(:LLVMIsConditional, LLVMBool, (LLVMValueRef,), Branch)
end

function LLVMGetCondition(Branch)
    @apicall(:LLVMGetCondition, LLVMValueRef, (LLVMValueRef,), Branch)
end

function LLVMSetCondition(Branch, Cond)
    @apicall(:LLVMSetCondition, Cvoid, (LLVMValueRef, LLVMValueRef), Branch, Cond)
end

function LLVMGetSwitchDefaultDest(SwitchInstr)
    @apicall(:LLVMGetSwitchDefaultDest, LLVMBasicBlockRef, (LLVMValueRef,), SwitchInstr)
end

function LLVMGetAllocatedType(Alloca)
    @apicall(:LLVMGetAllocatedType, LLVMTypeRef, (LLVMValueRef,), Alloca)
end

function LLVMIsInBounds(GEP)
    @apicall(:LLVMIsInBounds, LLVMBool, (LLVMValueRef,), GEP)
end

function LLVMSetIsInBounds(GEP, InBounds)
    @apicall(:LLVMSetIsInBounds, Cvoid, (LLVMValueRef, LLVMBool), GEP, InBounds)
end

function LLVMAddIncoming(PhiNode, IncomingValues, IncomingBlocks, Count)
    @apicall(:LLVMAddIncoming, Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}, Ptr{LLVMBasicBlockRef}, UInt32), PhiNode, IncomingValues, IncomingBlocks, Count)
end

function LLVMCountIncoming(PhiNode)
    @apicall(:LLVMCountIncoming, UInt32, (LLVMValueRef,), PhiNode)
end

function LLVMGetIncomingValue(PhiNode, Index)
    @apicall(:LLVMGetIncomingValue, LLVMValueRef, (LLVMValueRef, UInt32), PhiNode, Index)
end

function LLVMGetIncomingBlock(PhiNode, Index)
    @apicall(:LLVMGetIncomingBlock, LLVMBasicBlockRef, (LLVMValueRef, UInt32), PhiNode, Index)
end

function LLVMGetNumIndices(Inst)
    @apicall(:LLVMGetNumIndices, UInt32, (LLVMValueRef,), Inst)
end

function LLVMGetIndices(Inst)
    @apicall(:LLVMGetIndices, Ptr{UInt32}, (LLVMValueRef,), Inst)
end

function LLVMCreateBuilderInContext(C)
    @apicall(:LLVMCreateBuilderInContext, LLVMBuilderRef, (LLVMContextRef,), C)
end

function LLVMCreateBuilder()
    @apicall(:LLVMCreateBuilder, LLVMBuilderRef, ())
end

function LLVMPositionBuilder(Builder, Block, Instr)
    @apicall(:LLVMPositionBuilder, Cvoid, (LLVMBuilderRef, LLVMBasicBlockRef, LLVMValueRef), Builder, Block, Instr)
end

function LLVMPositionBuilderBefore(Builder, Instr)
    @apicall(:LLVMPositionBuilderBefore, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Instr)
end

function LLVMPositionBuilderAtEnd(Builder, Block)
    @apicall(:LLVMPositionBuilderAtEnd, Cvoid, (LLVMBuilderRef, LLVMBasicBlockRef), Builder, Block)
end

function LLVMGetInsertBlock(Builder)
    @apicall(:LLVMGetInsertBlock, LLVMBasicBlockRef, (LLVMBuilderRef,), Builder)
end

function LLVMClearInsertionPosition(Builder)
    @apicall(:LLVMClearInsertionPosition, Cvoid, (LLVMBuilderRef,), Builder)
end

function LLVMInsertIntoBuilder(Builder, Instr)
    @apicall(:LLVMInsertIntoBuilder, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Instr)
end

function LLVMInsertIntoBuilderWithName(Builder, Instr, Name)
    @apicall(:LLVMInsertIntoBuilderWithName, Cvoid, (LLVMBuilderRef, LLVMValueRef, Cstring), Builder, Instr, Name)
end

function LLVMDisposeBuilder(Builder)
    @apicall(:LLVMDisposeBuilder, Cvoid, (LLVMBuilderRef,), Builder)
end

function LLVMSetCurrentDebugLocation(Builder, L)
    @apicall(:LLVMSetCurrentDebugLocation, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, L)
end

function LLVMGetCurrentDebugLocation(Builder)
    @apicall(:LLVMGetCurrentDebugLocation, LLVMValueRef, (LLVMBuilderRef,), Builder)
end

function LLVMSetInstDebugLocation(Builder, Inst)
    @apicall(:LLVMSetInstDebugLocation, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Inst)
end

function LLVMBuildRetVoid(arg1)
    @apicall(:LLVMBuildRetVoid, LLVMValueRef, (LLVMBuilderRef,), arg1)
end

function LLVMBuildRet(arg1, V)
    @apicall(:LLVMBuildRet, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), arg1, V)
end

function LLVMBuildAggregateRet(arg1, RetVals, N)
    @apicall(:LLVMBuildAggregateRet, LLVMValueRef, (LLVMBuilderRef, Ptr{LLVMValueRef}, UInt32), arg1, RetVals, N)
end

function LLVMBuildBr(arg1, Dest)
    @apicall(:LLVMBuildBr, LLVMValueRef, (LLVMBuilderRef, LLVMBasicBlockRef), arg1, Dest)
end

function LLVMBuildCondBr(arg1, If, Then, Else)
    @apicall(:LLVMBuildCondBr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, LLVMBasicBlockRef), arg1, If, Then, Else)
end

function LLVMBuildSwitch(arg1, V, Else, NumCases)
    @apicall(:LLVMBuildSwitch, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, UInt32), arg1, V, Else, NumCases)
end

function LLVMBuildIndirectBr(B, Addr, NumDests)
    @apicall(:LLVMBuildIndirectBr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32), B, Addr, NumDests)
end

function LLVMBuildInvoke(arg1, Fn, Args, NumArgs, Then, Catch, Name)
    @apicall(:LLVMBuildInvoke, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, LLVMBasicBlockRef, LLVMBasicBlockRef, Cstring), arg1, Fn, Args, NumArgs, Then, Catch, Name)
end

function LLVMBuildInvoke2(arg1, Ty, Fn, Args, NumArgs, Then, Catch, Name)
    @apicall(:LLVMBuildInvoke2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, LLVMBasicBlockRef, LLVMBasicBlockRef, Cstring), arg1, Ty, Fn, Args, NumArgs, Then, Catch, Name)
end

function LLVMBuildUnreachable(arg1)
    @apicall(:LLVMBuildUnreachable, LLVMValueRef, (LLVMBuilderRef,), arg1)
end

function LLVMBuildResume(B, Exn)
    @apicall(:LLVMBuildResume, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), B, Exn)
end

function LLVMBuildLandingPad(B, Ty, PersFn, NumClauses, Name)
    @apicall(:LLVMBuildLandingPad, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, UInt32, Cstring), B, Ty, PersFn, NumClauses, Name)
end

function LLVMBuildCleanupRet(B, CatchPad, BB)
    @apicall(:LLVMBuildCleanupRet, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef), B, CatchPad, BB)
end

function LLVMBuildCatchRet(B, CatchPad, BB)
    @apicall(:LLVMBuildCatchRet, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef), B, CatchPad, BB)
end

function LLVMBuildCatchPad(B, ParentPad, Args, NumArgs, Name)
    @apicall(:LLVMBuildCatchPad, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, ParentPad, Args, NumArgs, Name)
end

function LLVMBuildCleanupPad(B, ParentPad, Args, NumArgs, Name)
    @apicall(:LLVMBuildCleanupPad, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, ParentPad, Args, NumArgs, Name)
end

function LLVMBuildCatchSwitch(B, ParentPad, UnwindBB, NumHandlers, Name)
    @apicall(:LLVMBuildCatchSwitch, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, UInt32, Cstring), B, ParentPad, UnwindBB, NumHandlers, Name)
end

function LLVMAddCase(Switch, OnVal, Dest)
    @apicall(:LLVMAddCase, Cvoid, (LLVMValueRef, LLVMValueRef, LLVMBasicBlockRef), Switch, OnVal, Dest)
end

function LLVMAddDestination(IndirectBr, Dest)
    @apicall(:LLVMAddDestination, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), IndirectBr, Dest)
end

function LLVMGetNumClauses(LandingPad)
    @apicall(:LLVMGetNumClauses, UInt32, (LLVMValueRef,), LandingPad)
end

function LLVMGetClause(LandingPad, Idx)
    @apicall(:LLVMGetClause, LLVMValueRef, (LLVMValueRef, UInt32), LandingPad, Idx)
end

function LLVMAddClause(LandingPad, ClauseVal)
    @apicall(:LLVMAddClause, Cvoid, (LLVMValueRef, LLVMValueRef), LandingPad, ClauseVal)
end

function LLVMIsCleanup(LandingPad)
    @apicall(:LLVMIsCleanup, LLVMBool, (LLVMValueRef,), LandingPad)
end

function LLVMSetCleanup(LandingPad, Val)
    @apicall(:LLVMSetCleanup, Cvoid, (LLVMValueRef, LLVMBool), LandingPad, Val)
end

function LLVMAddHandler(CatchSwitch, Dest)
    @apicall(:LLVMAddHandler, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), CatchSwitch, Dest)
end

function LLVMGetNumHandlers(CatchSwitch)
    @apicall(:LLVMGetNumHandlers, UInt32, (LLVMValueRef,), CatchSwitch)
end

function LLVMGetHandlers(CatchSwitch, Handlers)
    @apicall(:LLVMGetHandlers, Cvoid, (LLVMValueRef, Ptr{LLVMBasicBlockRef}), CatchSwitch, Handlers)
end

function LLVMGetArgOperand(Funclet, i)
    @apicall(:LLVMGetArgOperand, LLVMValueRef, (LLVMValueRef, UInt32), Funclet, i)
end

function LLVMSetArgOperand(Funclet, i, value)
    @apicall(:LLVMSetArgOperand, Cvoid, (LLVMValueRef, UInt32, LLVMValueRef), Funclet, i, value)
end

function LLVMGetParentCatchSwitch(CatchPad)
    @apicall(:LLVMGetParentCatchSwitch, LLVMValueRef, (LLVMValueRef,), CatchPad)
end

function LLVMSetParentCatchSwitch(CatchPad, CatchSwitch)
    @apicall(:LLVMSetParentCatchSwitch, Cvoid, (LLVMValueRef, LLVMValueRef), CatchPad, CatchSwitch)
end

function LLVMBuildAdd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWAdd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNSWAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWAdd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNUWAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFAdd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSub(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWSub(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNSWSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWSub(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNUWSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFSub(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildMul(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWMul(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNSWMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWMul(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildNUWMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFMul(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildUDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildUDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildExactUDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildExactUDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildSDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildExactSDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildExactSDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFDiv(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildURem(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildURem, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSRem(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildSRem, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFRem(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildFRem, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildShl(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildShl, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildLShr(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildLShr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildAShr(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildAShr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildAnd(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildAnd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildOr(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildOr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildXor(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildXor, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildBinOp(B, Op, LHS, RHS, Name)
    @apicall(:LLVMBuildBinOp, LLVMValueRef, (LLVMBuilderRef, LLVMOpcode, LLVMValueRef, LLVMValueRef, Cstring), B, Op, LHS, RHS, Name)
end

function LLVMBuildNeg(arg1, V, Name)
    @apicall(:LLVMBuildNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildNSWNeg(B, V, Name)
    @apicall(:LLVMBuildNSWNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), B, V, Name)
end

function LLVMBuildNUWNeg(B, V, Name)
    @apicall(:LLVMBuildNUWNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), B, V, Name)
end

function LLVMBuildFNeg(arg1, V, Name)
    @apicall(:LLVMBuildFNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildNot(arg1, V, Name)
    @apicall(:LLVMBuildNot, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildMalloc(arg1, Ty, Name)
    @apicall(:LLVMBuildMalloc, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildArrayMalloc(arg1, Ty, Val, Name)
    @apicall(:LLVMBuildArrayMalloc, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring), arg1, Ty, Val, Name)
end

function LLVMBuildMemSet(B, Ptr, Val, Len, Align)
    @apicall(:LLVMBuildMemSet, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, UInt32), B, Ptr, Val, Len, Align)
end

function LLVMBuildMemCpy(B, Dst, DstAlign, Src, SrcAlign, Size)
    @apicall(:LLVMBuildMemCpy, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32, LLVMValueRef, UInt32, LLVMValueRef), B, Dst, DstAlign, Src, SrcAlign, Size)
end

function LLVMBuildMemMove(B, Dst, DstAlign, Src, SrcAlign, Size)
    @apicall(:LLVMBuildMemMove, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32, LLVMValueRef, UInt32, LLVMValueRef), B, Dst, DstAlign, Src, SrcAlign, Size)
end

function LLVMBuildAlloca(arg1, Ty, Name)
    @apicall(:LLVMBuildAlloca, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildArrayAlloca(arg1, Ty, Val, Name)
    @apicall(:LLVMBuildArrayAlloca, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring), arg1, Ty, Val, Name)
end

function LLVMBuildFree(arg1, PointerVal)
    @apicall(:LLVMBuildFree, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), arg1, PointerVal)
end

function LLVMBuildLoad(arg1, PointerVal, Name)
    @apicall(:LLVMBuildLoad, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, PointerVal, Name)
end

function LLVMBuildLoad2(arg1, Ty, PointerVal, Name)
    @apicall(:LLVMBuildLoad2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring), arg1, Ty, PointerVal, Name)
end

function LLVMBuildStore(arg1, Val, Ptr)
    @apicall(:LLVMBuildStore, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef), arg1, Val, Ptr)
end

function LLVMBuildGEP(B, Pointer, Indices, NumIndices, Name)
    @apicall(:LLVMBuildGEP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildInBoundsGEP(B, Pointer, Indices, NumIndices, Name)
    @apicall(:LLVMBuildInBoundsGEP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildStructGEP(B, Pointer, Idx, Name)
    @apicall(:LLVMBuildStructGEP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32, Cstring), B, Pointer, Idx, Name)
end

function LLVMBuildGEP2(B, Ty, Pointer, Indices, NumIndices, Name)
    @apicall(:LLVMBuildGEP2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, Ty, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildInBoundsGEP2(B, Ty, Pointer, Indices, NumIndices, Name)
    @apicall(:LLVMBuildInBoundsGEP2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, Ty, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildStructGEP2(B, Ty, Pointer, Idx, Name)
    @apicall(:LLVMBuildStructGEP2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, UInt32, Cstring), B, Ty, Pointer, Idx, Name)
end

function LLVMBuildGlobalString(B, Str, Name)
    @apicall(:LLVMBuildGlobalString, LLVMValueRef, (LLVMBuilderRef, Cstring, Cstring), B, Str, Name)
end

function LLVMBuildGlobalStringPtr(B, Str, Name)
    @apicall(:LLVMBuildGlobalStringPtr, LLVMValueRef, (LLVMBuilderRef, Cstring, Cstring), B, Str, Name)
end

function LLVMGetVolatile(MemoryAccessInst)
    @apicall(:LLVMGetVolatile, LLVMBool, (LLVMValueRef,), MemoryAccessInst)
end

function LLVMSetVolatile(MemoryAccessInst, IsVolatile)
    @apicall(:LLVMSetVolatile, Cvoid, (LLVMValueRef, LLVMBool), MemoryAccessInst, IsVolatile)
end

function LLVMGetOrdering(MemoryAccessInst)
    @apicall(:LLVMGetOrdering, LLVMAtomicOrdering, (LLVMValueRef,), MemoryAccessInst)
end

function LLVMSetOrdering(MemoryAccessInst, Ordering)
    @apicall(:LLVMSetOrdering, Cvoid, (LLVMValueRef, LLVMAtomicOrdering), MemoryAccessInst, Ordering)
end

function LLVMBuildTrunc(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildTrunc, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildZExt(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildZExt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSExt(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildSExt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPToUI(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPToUI, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPToSI(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPToSI, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildUIToFP(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildUIToFP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSIToFP(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildSIToFP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPTrunc(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPTrunc, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPExt(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPExt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildPtrToInt(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildPtrToInt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildIntToPtr(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildIntToPtr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildBitCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildAddrSpaceCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildAddrSpaceCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildZExtOrBitCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildZExtOrBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSExtOrBitCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildSExtOrBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildTruncOrBitCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildTruncOrBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildCast(B, Op, Val, DestTy, Name)
    @apicall(:LLVMBuildCast, LLVMValueRef, (LLVMBuilderRef, LLVMOpcode, LLVMValueRef, LLVMTypeRef, Cstring), B, Op, Val, DestTy, Name)
end

function LLVMBuildPointerCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildPointerCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildIntCast2(arg1, Val, DestTy, IsSigned, Name)
    @apicall(:LLVMBuildIntCast2, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, LLVMBool, Cstring), arg1, Val, DestTy, IsSigned, Name)
end

function LLVMBuildFPCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildFPCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildIntCast(arg1, Val, DestTy, Name)
    @apicall(:LLVMBuildIntCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildICmp(arg1, Op, LHS, RHS, Name)
    @apicall(:LLVMBuildICmp, LLVMValueRef, (LLVMBuilderRef, LLVMIntPredicate, LLVMValueRef, LLVMValueRef, Cstring), arg1, Op, LHS, RHS, Name)
end

function LLVMBuildFCmp(arg1, Op, LHS, RHS, Name)
    @apicall(:LLVMBuildFCmp, LLVMValueRef, (LLVMBuilderRef, LLVMRealPredicate, LLVMValueRef, LLVMValueRef, Cstring), arg1, Op, LHS, RHS, Name)
end

function LLVMBuildPhi(arg1, Ty, Name)
    @apicall(:LLVMBuildPhi, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildCall(arg1, Fn, Args, NumArgs, Name)
    @apicall(:LLVMBuildCall, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), arg1, Fn, Args, NumArgs, Name)
end

function LLVMBuildCall2(arg1, arg2, Fn, Args, NumArgs, Name)
    @apicall(:LLVMBuildCall2, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), arg1, arg2, Fn, Args, NumArgs, Name)
end

function LLVMBuildSelect(arg1, If, Then, Else, Name)
    @apicall(:LLVMBuildSelect, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, If, Then, Else, Name)
end

function LLVMBuildVAArg(arg1, List, Ty, Name)
    @apicall(:LLVMBuildVAArg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, List, Ty, Name)
end

function LLVMBuildExtractElement(arg1, VecVal, Index, Name)
    @apicall(:LLVMBuildExtractElement, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, VecVal, Index, Name)
end

function LLVMBuildInsertElement(arg1, VecVal, EltVal, Index, Name)
    @apicall(:LLVMBuildInsertElement, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, VecVal, EltVal, Index, Name)
end

function LLVMBuildShuffleVector(arg1, V1, V2, Mask, Name)
    @apicall(:LLVMBuildShuffleVector, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, V1, V2, Mask, Name)
end

function LLVMBuildExtractValue(arg1, AggVal, Index, Name)
    @apicall(:LLVMBuildExtractValue, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32, Cstring), arg1, AggVal, Index, Name)
end

function LLVMBuildInsertValue(arg1, AggVal, EltVal, Index, Name)
    @apicall(:LLVMBuildInsertValue, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, UInt32, Cstring), arg1, AggVal, EltVal, Index, Name)
end

function LLVMBuildIsNull(arg1, Val, Name)
    @apicall(:LLVMBuildIsNull, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, Val, Name)
end

function LLVMBuildIsNotNull(arg1, Val, Name)
    @apicall(:LLVMBuildIsNotNull, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, Val, Name)
end

function LLVMBuildPtrDiff(arg1, LHS, RHS, Name)
    @apicall(:LLVMBuildPtrDiff, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFence(B, ordering, singleThread, Name)
    @apicall(:LLVMBuildFence, LLVMValueRef, (LLVMBuilderRef, LLVMAtomicOrdering, LLVMBool, Cstring), B, ordering, singleThread, Name)
end

function LLVMBuildAtomicRMW(B, op, PTR, Val, ordering, singleThread)
    @apicall(:LLVMBuildAtomicRMW, LLVMValueRef, (LLVMBuilderRef, LLVMAtomicRMWBinOp, LLVMValueRef, LLVMValueRef, LLVMAtomicOrdering, LLVMBool), B, op, PTR, Val, ordering, singleThread)
end

function LLVMBuildAtomicCmpXchg(B, Ptr, Cmp, New, SuccessOrdering, FailureOrdering, SingleThread)
    @apicall(:LLVMBuildAtomicCmpXchg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, LLVMAtomicOrdering, LLVMAtomicOrdering, LLVMBool), B, Ptr, Cmp, New, SuccessOrdering, FailureOrdering, SingleThread)
end

function LLVMIsAtomicSingleThread(AtomicInst)
    @apicall(:LLVMIsAtomicSingleThread, LLVMBool, (LLVMValueRef,), AtomicInst)
end

function LLVMSetAtomicSingleThread(AtomicInst, SingleThread)
    @apicall(:LLVMSetAtomicSingleThread, Cvoid, (LLVMValueRef, LLVMBool), AtomicInst, SingleThread)
end

function LLVMGetCmpXchgSuccessOrdering(CmpXchgInst)
    @apicall(:LLVMGetCmpXchgSuccessOrdering, LLVMAtomicOrdering, (LLVMValueRef,), CmpXchgInst)
end

function LLVMSetCmpXchgSuccessOrdering(CmpXchgInst, Ordering)
    @apicall(:LLVMSetCmpXchgSuccessOrdering, Cvoid, (LLVMValueRef, LLVMAtomicOrdering), CmpXchgInst, Ordering)
end

function LLVMGetCmpXchgFailureOrdering(CmpXchgInst)
    @apicall(:LLVMGetCmpXchgFailureOrdering, LLVMAtomicOrdering, (LLVMValueRef,), CmpXchgInst)
end

function LLVMSetCmpXchgFailureOrdering(CmpXchgInst, Ordering)
    @apicall(:LLVMSetCmpXchgFailureOrdering, Cvoid, (LLVMValueRef, LLVMAtomicOrdering), CmpXchgInst, Ordering)
end

function LLVMCreateModuleProviderForExistingModule(M)
    @apicall(:LLVMCreateModuleProviderForExistingModule, LLVMModuleProviderRef, (LLVMModuleRef,), M)
end

function LLVMDisposeModuleProvider(M)
    @apicall(:LLVMDisposeModuleProvider, Cvoid, (LLVMModuleProviderRef,), M)
end

function LLVMCreateMemoryBufferWithContentsOfFile(Path, OutMemBuf, OutMessage)
    @apicall(:LLVMCreateMemoryBufferWithContentsOfFile, LLVMBool, (Cstring, Ptr{LLVMMemoryBufferRef}, Ptr{Cstring}), Path, OutMemBuf, OutMessage)
end

function LLVMCreateMemoryBufferWithSTDIN(OutMemBuf, OutMessage)
    @apicall(:LLVMCreateMemoryBufferWithSTDIN, LLVMBool, (Ptr{LLVMMemoryBufferRef}, Ptr{Cstring}), OutMemBuf, OutMessage)
end

function LLVMCreateMemoryBufferWithMemoryRange(InputData, InputDataLength, BufferName, RequiresNullTerminator)
    @apicall(:LLVMCreateMemoryBufferWithMemoryRange, LLVMMemoryBufferRef, (Cstring, Csize_t, Cstring, LLVMBool), InputData, InputDataLength, BufferName, RequiresNullTerminator)
end

function LLVMCreateMemoryBufferWithMemoryRangeCopy(InputData, InputDataLength, BufferName)
    @apicall(:LLVMCreateMemoryBufferWithMemoryRangeCopy, LLVMMemoryBufferRef, (Cstring, Csize_t, Cstring), InputData, InputDataLength, BufferName)
end

function LLVMGetBufferStart(MemBuf)
    @apicall(:LLVMGetBufferStart, Cstring, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMGetBufferSize(MemBuf)
    @apicall(:LLVMGetBufferSize, Csize_t, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMDisposeMemoryBuffer(MemBuf)
    @apicall(:LLVMDisposeMemoryBuffer, Cvoid, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMGetGlobalPassRegistry()
    @apicall(:LLVMGetGlobalPassRegistry, LLVMPassRegistryRef, ())
end

function LLVMCreatePassManager()
    @apicall(:LLVMCreatePassManager, LLVMPassManagerRef, ())
end

function LLVMCreateFunctionPassManagerForModule(M)
    @apicall(:LLVMCreateFunctionPassManagerForModule, LLVMPassManagerRef, (LLVMModuleRef,), M)
end

function LLVMCreateFunctionPassManager(MP)
    @apicall(:LLVMCreateFunctionPassManager, LLVMPassManagerRef, (LLVMModuleProviderRef,), MP)
end

function LLVMRunPassManager(PM, M)
    @apicall(:LLVMRunPassManager, LLVMBool, (LLVMPassManagerRef, LLVMModuleRef), PM, M)
end

function LLVMInitializeFunctionPassManager(FPM)
    @apicall(:LLVMInitializeFunctionPassManager, LLVMBool, (LLVMPassManagerRef,), FPM)
end

function LLVMRunFunctionPassManager(FPM, F)
    @apicall(:LLVMRunFunctionPassManager, LLVMBool, (LLVMPassManagerRef, LLVMValueRef), FPM, F)
end

function LLVMFinalizeFunctionPassManager(FPM)
    @apicall(:LLVMFinalizeFunctionPassManager, LLVMBool, (LLVMPassManagerRef,), FPM)
end

function LLVMDisposePassManager(PM)
    @apicall(:LLVMDisposePassManager, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMStartMultithreaded()
    @apicall(:LLVMStartMultithreaded, LLVMBool, ())
end

function LLVMStopMultithreaded()
    @apicall(:LLVMStopMultithreaded, Cvoid, ())
end

function LLVMIsMultithreaded()
    @apicall(:LLVMIsMultithreaded, LLVMBool, ())
end

function LLVMOptRemarkParserCreate(Buf, Size)
    @apicall(:LLVMOptRemarkParserCreate, LLVMOptRemarkParserRef, (Ptr{Cvoid}, UInt64), Buf, Size)
end

function LLVMOptRemarkParserGetNext(Parser)
    @apicall(:LLVMOptRemarkParserGetNext, Ptr{LLVMOptRemarkEntry}, (LLVMOptRemarkParserRef,), Parser)
end

function LLVMOptRemarkParserHasError(Parser)
    @apicall(:LLVMOptRemarkParserHasError, LLVMBool, (LLVMOptRemarkParserRef,), Parser)
end

function LLVMOptRemarkParserGetErrorMessage(Parser)
    @apicall(:LLVMOptRemarkParserGetErrorMessage, Cstring, (LLVMOptRemarkParserRef,), Parser)
end

function LLVMOptRemarkParserDispose(Parser)
    @apicall(:LLVMOptRemarkParserDispose, Cvoid, (LLVMOptRemarkParserRef,), Parser)
end

function LLVMOptRemarkVersion()
    @apicall(:LLVMOptRemarkVersion, UInt32, ())
end
# Julia wrapper for header: OrcBindings.h
# Automatically generated using Clang.jl


function LLVMGetErrorTypeId(Err)
    @apicall(:LLVMGetErrorTypeId, LLVMErrorTypeId, (LLVMErrorRef,), Err)
end

function LLVMConsumeError(Err)
    @apicall(:LLVMConsumeError, Cvoid, (LLVMErrorRef,), Err)
end

function LLVMGetErrorMessage(Err)
    @apicall(:LLVMGetErrorMessage, Cstring, (LLVMErrorRef,), Err)
end

function LLVMDisposeErrorMessage(ErrMsg)
    @apicall(:LLVMDisposeErrorMessage, Cvoid, (Cstring,), ErrMsg)
end

function LLVMGetStringErrorTypeId()
    @apicall(:LLVMGetStringErrorTypeId, LLVMErrorTypeId, ())
end

function LLVMCreateObjectFile(MemBuf)
    @apicall(:LLVMCreateObjectFile, LLVMObjectFileRef, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMDisposeObjectFile(ObjectFile)
    @apicall(:LLVMDisposeObjectFile, Cvoid, (LLVMObjectFileRef,), ObjectFile)
end

function LLVMGetSections(ObjectFile)
    @apicall(:LLVMGetSections, LLVMSectionIteratorRef, (LLVMObjectFileRef,), ObjectFile)
end

function LLVMDisposeSectionIterator(SI)
    @apicall(:LLVMDisposeSectionIterator, Cvoid, (LLVMSectionIteratorRef,), SI)
end

function LLVMIsSectionIteratorAtEnd(ObjectFile, SI)
    @apicall(:LLVMIsSectionIteratorAtEnd, LLVMBool, (LLVMObjectFileRef, LLVMSectionIteratorRef), ObjectFile, SI)
end

function LLVMMoveToNextSection(SI)
    @apicall(:LLVMMoveToNextSection, Cvoid, (LLVMSectionIteratorRef,), SI)
end

function LLVMMoveToContainingSection(Sect, Sym)
    @apicall(:LLVMMoveToContainingSection, Cvoid, (LLVMSectionIteratorRef, LLVMSymbolIteratorRef), Sect, Sym)
end

function LLVMGetSymbols(ObjectFile)
    @apicall(:LLVMGetSymbols, LLVMSymbolIteratorRef, (LLVMObjectFileRef,), ObjectFile)
end

function LLVMDisposeSymbolIterator(SI)
    @apicall(:LLVMDisposeSymbolIterator, Cvoid, (LLVMSymbolIteratorRef,), SI)
end

function LLVMIsSymbolIteratorAtEnd(ObjectFile, SI)
    @apicall(:LLVMIsSymbolIteratorAtEnd, LLVMBool, (LLVMObjectFileRef, LLVMSymbolIteratorRef), ObjectFile, SI)
end

function LLVMMoveToNextSymbol(SI)
    @apicall(:LLVMMoveToNextSymbol, Cvoid, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetSectionName(SI)
    @apicall(:LLVMGetSectionName, Cstring, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionSize(SI)
    @apicall(:LLVMGetSectionSize, UInt64, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionContents(SI)
    @apicall(:LLVMGetSectionContents, Cstring, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionAddress(SI)
    @apicall(:LLVMGetSectionAddress, UInt64, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionContainsSymbol(SI, Sym)
    @apicall(:LLVMGetSectionContainsSymbol, LLVMBool, (LLVMSectionIteratorRef, LLVMSymbolIteratorRef), SI, Sym)
end

function LLVMGetRelocations(Section)
    @apicall(:LLVMGetRelocations, LLVMRelocationIteratorRef, (LLVMSectionIteratorRef,), Section)
end

function LLVMDisposeRelocationIterator(RI)
    @apicall(:LLVMDisposeRelocationIterator, Cvoid, (LLVMRelocationIteratorRef,), RI)
end

function LLVMIsRelocationIteratorAtEnd(Section, RI)
    @apicall(:LLVMIsRelocationIteratorAtEnd, LLVMBool, (LLVMSectionIteratorRef, LLVMRelocationIteratorRef), Section, RI)
end

function LLVMMoveToNextRelocation(RI)
    @apicall(:LLVMMoveToNextRelocation, Cvoid, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetSymbolName(SI)
    @apicall(:LLVMGetSymbolName, Cstring, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetSymbolAddress(SI)
    @apicall(:LLVMGetSymbolAddress, UInt64, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetSymbolSize(SI)
    @apicall(:LLVMGetSymbolSize, UInt64, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetRelocationOffset(RI)
    @apicall(:LLVMGetRelocationOffset, UInt64, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationSymbol(RI)
    @apicall(:LLVMGetRelocationSymbol, LLVMSymbolIteratorRef, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationType(RI)
    @apicall(:LLVMGetRelocationType, UInt64, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationTypeName(RI)
    @apicall(:LLVMGetRelocationTypeName, Cstring, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationValueString(RI)
    @apicall(:LLVMGetRelocationValueString, Cstring, (LLVMRelocationIteratorRef,), RI)
end

function LLVMInitializeNVPTXTargetInfo()
    @apicall(:LLVMInitializeNVPTXTargetInfo, Cvoid, ())
end

function LLVMInitializeAMDGPUTargetInfo()
    @apicall(:LLVMInitializeAMDGPUTargetInfo, Cvoid, ())
end

function LLVMInitializeWebAssemblyTargetInfo()
    @apicall(:LLVMInitializeWebAssemblyTargetInfo, Cvoid, ())
end

function LLVMInitializeX86TargetInfo()
    @apicall(:LLVMInitializeX86TargetInfo, Cvoid, ())
end

function LLVMInitializeNVPTXTarget()
    @apicall(:LLVMInitializeNVPTXTarget, Cvoid, ())
end

function LLVMInitializeAMDGPUTarget()
    @apicall(:LLVMInitializeAMDGPUTarget, Cvoid, ())
end

function LLVMInitializeWebAssemblyTarget()
    @apicall(:LLVMInitializeWebAssemblyTarget, Cvoid, ())
end

function LLVMInitializeX86Target()
    @apicall(:LLVMInitializeX86Target, Cvoid, ())
end

function LLVMInitializeNVPTXTargetMC()
    @apicall(:LLVMInitializeNVPTXTargetMC, Cvoid, ())
end

function LLVMInitializeAMDGPUTargetMC()
    @apicall(:LLVMInitializeAMDGPUTargetMC, Cvoid, ())
end

function LLVMInitializeWebAssemblyTargetMC()
    @apicall(:LLVMInitializeWebAssemblyTargetMC, Cvoid, ())
end

function LLVMInitializeX86TargetMC()
    @apicall(:LLVMInitializeX86TargetMC, Cvoid, ())
end

function LLVMInitializeNVPTXAsmPrinter()
    @apicall(:LLVMInitializeNVPTXAsmPrinter, Cvoid, ())
end

function LLVMInitializeAMDGPUAsmPrinter()
    @apicall(:LLVMInitializeAMDGPUAsmPrinter, Cvoid, ())
end

function LLVMInitializeWebAssemblyAsmPrinter()
    @apicall(:LLVMInitializeWebAssemblyAsmPrinter, Cvoid, ())
end

function LLVMInitializeX86AsmPrinter()
    @apicall(:LLVMInitializeX86AsmPrinter, Cvoid, ())
end

function LLVMInitializeAMDGPUAsmParser()
    @apicall(:LLVMInitializeAMDGPUAsmParser, Cvoid, ())
end

function LLVMInitializeWebAssemblyAsmParser()
    @apicall(:LLVMInitializeWebAssemblyAsmParser, Cvoid, ())
end

function LLVMInitializeX86AsmParser()
    @apicall(:LLVMInitializeX86AsmParser, Cvoid, ())
end

function LLVMInitializeAMDGPUDisassembler()
    @apicall(:LLVMInitializeAMDGPUDisassembler, Cvoid, ())
end

function LLVMInitializeWebAssemblyDisassembler()
    @apicall(:LLVMInitializeWebAssemblyDisassembler, Cvoid, ())
end

function LLVMInitializeX86Disassembler()
    @apicall(:LLVMInitializeX86Disassembler, Cvoid, ())
end

function LLVMInitializeAllTargetInfos()
    @apicall(:LLVMInitializeAllTargetInfos, Cvoid, ())
end

function LLVMInitializeAllTargets()
    @apicall(:LLVMInitializeAllTargets, Cvoid, ())
end

function LLVMInitializeAllTargetMCs()
    @apicall(:LLVMInitializeAllTargetMCs, Cvoid, ())
end

function LLVMInitializeAllAsmPrinters()
    @apicall(:LLVMInitializeAllAsmPrinters, Cvoid, ())
end

function LLVMInitializeAllAsmParsers()
    @apicall(:LLVMInitializeAllAsmParsers, Cvoid, ())
end

function LLVMInitializeAllDisassemblers()
    @apicall(:LLVMInitializeAllDisassemblers, Cvoid, ())
end

function LLVMInitializeNativeTarget()
    @apicall(:LLVMInitializeNativeTarget, LLVMBool, ())
end

function LLVMInitializeNativeAsmParser()
    @apicall(:LLVMInitializeNativeAsmParser, LLVMBool, ())
end

function LLVMInitializeNativeAsmPrinter()
    @apicall(:LLVMInitializeNativeAsmPrinter, LLVMBool, ())
end

function LLVMInitializeNativeDisassembler()
    @apicall(:LLVMInitializeNativeDisassembler, LLVMBool, ())
end

function LLVMGetModuleDataLayout(M)
    @apicall(:LLVMGetModuleDataLayout, LLVMTargetDataRef, (LLVMModuleRef,), M)
end

function LLVMSetModuleDataLayout(M, DL)
    @apicall(:LLVMSetModuleDataLayout, Cvoid, (LLVMModuleRef, LLVMTargetDataRef), M, DL)
end

function LLVMCreateTargetData(StringRep)
    @apicall(:LLVMCreateTargetData, LLVMTargetDataRef, (Cstring,), StringRep)
end

function LLVMDisposeTargetData(TD)
    @apicall(:LLVMDisposeTargetData, Cvoid, (LLVMTargetDataRef,), TD)
end

function LLVMAddTargetLibraryInfo(TLI, PM)
    @apicall(:LLVMAddTargetLibraryInfo, Cvoid, (LLVMTargetLibraryInfoRef, LLVMPassManagerRef), TLI, PM)
end

function LLVMCopyStringRepOfTargetData(TD)
    @apicall(:LLVMCopyStringRepOfTargetData, Cstring, (LLVMTargetDataRef,), TD)
end

function LLVMByteOrder(TD)
    @apicall(:LLVMByteOrder, LLVMByteOrdering, (LLVMTargetDataRef,), TD)
end

function LLVMPointerSize(TD)
    @apicall(:LLVMPointerSize, UInt32, (LLVMTargetDataRef,), TD)
end

function LLVMPointerSizeForAS(TD, AS)
    @apicall(:LLVMPointerSizeForAS, UInt32, (LLVMTargetDataRef, UInt32), TD, AS)
end

function LLVMIntPtrType(TD)
    @apicall(:LLVMIntPtrType, LLVMTypeRef, (LLVMTargetDataRef,), TD)
end

function LLVMIntPtrTypeForAS(TD, AS)
    @apicall(:LLVMIntPtrTypeForAS, LLVMTypeRef, (LLVMTargetDataRef, UInt32), TD, AS)
end

function LLVMIntPtrTypeInContext(C, TD)
    @apicall(:LLVMIntPtrTypeInContext, LLVMTypeRef, (LLVMContextRef, LLVMTargetDataRef), C, TD)
end

function LLVMIntPtrTypeForASInContext(C, TD, AS)
    @apicall(:LLVMIntPtrTypeForASInContext, LLVMTypeRef, (LLVMContextRef, LLVMTargetDataRef, UInt32), C, TD, AS)
end

function LLVMSizeOfTypeInBits(TD, Ty)
    @apicall(:LLVMSizeOfTypeInBits, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMStoreSizeOfType(TD, Ty)
    @apicall(:LLVMStoreSizeOfType, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMABISizeOfType(TD, Ty)
    @apicall(:LLVMABISizeOfType, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMABIAlignmentOfType(TD, Ty)
    @apicall(:LLVMABIAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMCallFrameAlignmentOfType(TD, Ty)
    @apicall(:LLVMCallFrameAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMPreferredAlignmentOfType(TD, Ty)
    @apicall(:LLVMPreferredAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMPreferredAlignmentOfGlobal(TD, GlobalVar)
    @apicall(:LLVMPreferredAlignmentOfGlobal, UInt32, (LLVMTargetDataRef, LLVMValueRef), TD, GlobalVar)
end

function LLVMElementAtOffset(TD, StructTy, Offset)
    @apicall(:LLVMElementAtOffset, UInt32, (LLVMTargetDataRef, LLVMTypeRef, Culonglong), TD, StructTy, Offset)
end

function LLVMOffsetOfElement(TD, StructTy, Element)
    @apicall(:LLVMOffsetOfElement, Culonglong, (LLVMTargetDataRef, LLVMTypeRef, UInt32), TD, StructTy, Element)
end

function LLVMGetFirstTarget()
    @apicall(:LLVMGetFirstTarget, LLVMTargetRef, ())
end

function LLVMGetNextTarget(T)
    @apicall(:LLVMGetNextTarget, LLVMTargetRef, (LLVMTargetRef,), T)
end

function LLVMGetTargetFromName(Name)
    @apicall(:LLVMGetTargetFromName, LLVMTargetRef, (Cstring,), Name)
end

function LLVMGetTargetFromTriple(Triple, T, ErrorMessage)
    @apicall(:LLVMGetTargetFromTriple, LLVMBool, (Cstring, Ptr{LLVMTargetRef}, Ptr{Cstring}), Triple, T, ErrorMessage)
end

function LLVMGetTargetName(T)
    @apicall(:LLVMGetTargetName, Cstring, (LLVMTargetRef,), T)
end

function LLVMGetTargetDescription(T)
    @apicall(:LLVMGetTargetDescription, Cstring, (LLVMTargetRef,), T)
end

function LLVMTargetHasJIT(T)
    @apicall(:LLVMTargetHasJIT, LLVMBool, (LLVMTargetRef,), T)
end

function LLVMTargetHasTargetMachine(T)
    @apicall(:LLVMTargetHasTargetMachine, LLVMBool, (LLVMTargetRef,), T)
end

function LLVMTargetHasAsmBackend(T)
    @apicall(:LLVMTargetHasAsmBackend, LLVMBool, (LLVMTargetRef,), T)
end

function LLVMCreateTargetMachine(T, Triple, CPU, Features, Level, Reloc, CodeModel)
    @apicall(:LLVMCreateTargetMachine, LLVMTargetMachineRef, (LLVMTargetRef, Cstring, Cstring, Cstring, LLVMCodeGenOptLevel, LLVMRelocMode, LLVMCodeModel), T, Triple, CPU, Features, Level, Reloc, CodeModel)
end

function LLVMDisposeTargetMachine(T)
    @apicall(:LLVMDisposeTargetMachine, Cvoid, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineTarget(T)
    @apicall(:LLVMGetTargetMachineTarget, LLVMTargetRef, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineTriple(T)
    @apicall(:LLVMGetTargetMachineTriple, Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineCPU(T)
    @apicall(:LLVMGetTargetMachineCPU, Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineFeatureString(T)
    @apicall(:LLVMGetTargetMachineFeatureString, Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMCreateTargetDataLayout(T)
    @apicall(:LLVMCreateTargetDataLayout, LLVMTargetDataRef, (LLVMTargetMachineRef,), T)
end

function LLVMSetTargetMachineAsmVerbosity(T, VerboseAsm)
    @apicall(:LLVMSetTargetMachineAsmVerbosity, Cvoid, (LLVMTargetMachineRef, LLVMBool), T, VerboseAsm)
end

function LLVMTargetMachineEmitToFile(T, M, Filename, codegen, ErrorMessage)
    @apicall(:LLVMTargetMachineEmitToFile, LLVMBool, (LLVMTargetMachineRef, LLVMModuleRef, Cstring, LLVMCodeGenFileType, Ptr{Cstring}), T, M, Filename, codegen, ErrorMessage)
end

function LLVMTargetMachineEmitToMemoryBuffer(T, M, codegen, ErrorMessage, OutMemBuf)
    @apicall(:LLVMTargetMachineEmitToMemoryBuffer, LLVMBool, (LLVMTargetMachineRef, LLVMModuleRef, LLVMCodeGenFileType, Ptr{Cstring}, Ptr{LLVMMemoryBufferRef}), T, M, codegen, ErrorMessage, OutMemBuf)
end

function LLVMGetDefaultTargetTriple()
    @apicall(:LLVMGetDefaultTargetTriple, Cstring, ())
end

function LLVMNormalizeTargetTriple(triple)
    @apicall(:LLVMNormalizeTargetTriple, Cstring, (Cstring,), triple)
end

function LLVMGetHostCPUName()
    @apicall(:LLVMGetHostCPUName, Cstring, ())
end

function LLVMGetHostCPUFeatures()
    @apicall(:LLVMGetHostCPUFeatures, Cstring, ())
end

function LLVMAddAnalysisPasses(T, PM)
    @apicall(:LLVMAddAnalysisPasses, Cvoid, (LLVMTargetMachineRef, LLVMPassManagerRef), T, PM)
end

function LLVMOrcCreateInstance(TM)
    @apicall(:LLVMOrcCreateInstance, LLVMOrcJITStackRef, (LLVMTargetMachineRef,), TM)
end

function LLVMOrcGetErrorMsg(JITStack)
    @apicall(:LLVMOrcGetErrorMsg, Cstring, (LLVMOrcJITStackRef,), JITStack)
end

function LLVMOrcGetMangledSymbol(JITStack, MangledSymbol, Symbol)
    @apicall(:LLVMOrcGetMangledSymbol, Cvoid, (LLVMOrcJITStackRef, Ptr{Cstring}, Cstring), JITStack, MangledSymbol, Symbol)
end

function LLVMOrcDisposeMangledSymbol(MangledSymbol)
    @apicall(:LLVMOrcDisposeMangledSymbol, Cvoid, (Cstring,), MangledSymbol)
end

function LLVMOrcCreateLazyCompileCallback(JITStack, RetAddr, Callback, CallbackCtx)
    @apicall(:LLVMOrcCreateLazyCompileCallback, LLVMErrorRef, (LLVMOrcJITStackRef, Ptr{LLVMOrcTargetAddress}, LLVMOrcLazyCompileCallbackFn, Ptr{Cvoid}), JITStack, RetAddr, Callback, CallbackCtx)
end

function LLVMOrcCreateIndirectStub(JITStack, StubName, InitAddr)
    @apicall(:LLVMOrcCreateIndirectStub, LLVMErrorRef, (LLVMOrcJITStackRef, Cstring, LLVMOrcTargetAddress), JITStack, StubName, InitAddr)
end

function LLVMOrcSetIndirectStubPointer(JITStack, StubName, NewAddr)
    @apicall(:LLVMOrcSetIndirectStubPointer, LLVMErrorRef, (LLVMOrcJITStackRef, Cstring, LLVMOrcTargetAddress), JITStack, StubName, NewAddr)
end

function LLVMOrcAddEagerlyCompiledIR(JITStack, RetHandle, Mod, SymbolResolver, SymbolResolverCtx)
    @apicall(:LLVMOrcAddEagerlyCompiledIR, LLVMErrorRef, (LLVMOrcJITStackRef, Ptr{LLVMOrcModuleHandle}, LLVMModuleRef, LLVMOrcSymbolResolverFn, Ptr{Cvoid}), JITStack, RetHandle, Mod, SymbolResolver, SymbolResolverCtx)
end

function LLVMOrcAddLazilyCompiledIR(JITStack, RetHandle, Mod, SymbolResolver, SymbolResolverCtx)
    @apicall(:LLVMOrcAddLazilyCompiledIR, LLVMErrorRef, (LLVMOrcJITStackRef, Ptr{LLVMOrcModuleHandle}, LLVMModuleRef, LLVMOrcSymbolResolverFn, Ptr{Cvoid}), JITStack, RetHandle, Mod, SymbolResolver, SymbolResolverCtx)
end

function LLVMOrcAddObjectFile(JITStack, RetHandle, Obj, SymbolResolver, SymbolResolverCtx)
    @apicall(:LLVMOrcAddObjectFile, LLVMErrorRef, (LLVMOrcJITStackRef, Ptr{LLVMOrcModuleHandle}, LLVMMemoryBufferRef, LLVMOrcSymbolResolverFn, Ptr{Cvoid}), JITStack, RetHandle, Obj, SymbolResolver, SymbolResolverCtx)
end

function LLVMOrcRemoveModule(JITStack, H)
    @apicall(:LLVMOrcRemoveModule, LLVMErrorRef, (LLVMOrcJITStackRef, LLVMOrcModuleHandle), JITStack, H)
end

function LLVMOrcGetSymbolAddress(JITStack, RetAddr, SymbolName)
    @apicall(:LLVMOrcGetSymbolAddress, LLVMErrorRef, (LLVMOrcJITStackRef, Ptr{LLVMOrcTargetAddress}, Cstring), JITStack, RetAddr, SymbolName)
end

function LLVMOrcGetSymbolAddressIn(JITStack, RetAddr, H, SymbolName)
    @apicall(:LLVMOrcGetSymbolAddressIn, LLVMErrorRef, (LLVMOrcJITStackRef, Ptr{LLVMOrcTargetAddress}, LLVMOrcModuleHandle, Cstring), JITStack, RetAddr, H, SymbolName)
end

function LLVMOrcDisposeInstance(JITStack)
    @apicall(:LLVMOrcDisposeInstance, LLVMErrorRef, (LLVMOrcJITStackRef,), JITStack)
end

function LLVMOrcRegisterJITEventListener(JITStack, L)
    @apicall(:LLVMOrcRegisterJITEventListener, Cvoid, (LLVMOrcJITStackRef, LLVMJITEventListenerRef), JITStack, L)
end

function LLVMOrcUnregisterJITEventListener(JITStack, L)
    @apicall(:LLVMOrcUnregisterJITEventListener, Cvoid, (LLVMOrcJITStackRef, LLVMJITEventListenerRef), JITStack, L)
end
# Julia wrapper for header: Support.h
# Automatically generated using Clang.jl


function LLVMLoadLibraryPermanently(Filename)
    @apicall(:LLVMLoadLibraryPermanently, LLVMBool, (Cstring,), Filename)
end

function LLVMParseCommandLineOptions(argc, argv, Overview)
    @apicall(:LLVMParseCommandLineOptions, Cvoid, (Cint, Ptr{Cstring}, Cstring), argc, argv, Overview)
end

function LLVMSearchForAddressOfSymbol(symbolName)
    @apicall(:LLVMSearchForAddressOfSymbol, Ptr{Cvoid}, (Cstring,), symbolName)
end

function LLVMAddSymbol(symbolName, symbolValue)
    @apicall(:LLVMAddSymbol, Cvoid, (Cstring, Ptr{Cvoid}), symbolName, symbolValue)
end
# Julia wrapper for header: Target.h
# Automatically generated using Clang.jl


function LLVMInitializeNVPTXTargetInfo()
    @apicall(:LLVMInitializeNVPTXTargetInfo, Cvoid, ())
end

function LLVMInitializeAMDGPUTargetInfo()
    @apicall(:LLVMInitializeAMDGPUTargetInfo, Cvoid, ())
end

function LLVMInitializeWebAssemblyTargetInfo()
    @apicall(:LLVMInitializeWebAssemblyTargetInfo, Cvoid, ())
end

function LLVMInitializeX86TargetInfo()
    @apicall(:LLVMInitializeX86TargetInfo, Cvoid, ())
end

function LLVMInitializeNVPTXTarget()
    @apicall(:LLVMInitializeNVPTXTarget, Cvoid, ())
end

function LLVMInitializeAMDGPUTarget()
    @apicall(:LLVMInitializeAMDGPUTarget, Cvoid, ())
end

function LLVMInitializeWebAssemblyTarget()
    @apicall(:LLVMInitializeWebAssemblyTarget, Cvoid, ())
end

function LLVMInitializeX86Target()
    @apicall(:LLVMInitializeX86Target, Cvoid, ())
end

function LLVMInitializeNVPTXTargetMC()
    @apicall(:LLVMInitializeNVPTXTargetMC, Cvoid, ())
end

function LLVMInitializeAMDGPUTargetMC()
    @apicall(:LLVMInitializeAMDGPUTargetMC, Cvoid, ())
end

function LLVMInitializeWebAssemblyTargetMC()
    @apicall(:LLVMInitializeWebAssemblyTargetMC, Cvoid, ())
end

function LLVMInitializeX86TargetMC()
    @apicall(:LLVMInitializeX86TargetMC, Cvoid, ())
end

function LLVMInitializeNVPTXAsmPrinter()
    @apicall(:LLVMInitializeNVPTXAsmPrinter, Cvoid, ())
end

function LLVMInitializeAMDGPUAsmPrinter()
    @apicall(:LLVMInitializeAMDGPUAsmPrinter, Cvoid, ())
end

function LLVMInitializeWebAssemblyAsmPrinter()
    @apicall(:LLVMInitializeWebAssemblyAsmPrinter, Cvoid, ())
end

function LLVMInitializeX86AsmPrinter()
    @apicall(:LLVMInitializeX86AsmPrinter, Cvoid, ())
end

function LLVMInitializeAMDGPUAsmParser()
    @apicall(:LLVMInitializeAMDGPUAsmParser, Cvoid, ())
end

function LLVMInitializeWebAssemblyAsmParser()
    @apicall(:LLVMInitializeWebAssemblyAsmParser, Cvoid, ())
end

function LLVMInitializeX86AsmParser()
    @apicall(:LLVMInitializeX86AsmParser, Cvoid, ())
end

function LLVMInitializeAMDGPUDisassembler()
    @apicall(:LLVMInitializeAMDGPUDisassembler, Cvoid, ())
end

function LLVMInitializeWebAssemblyDisassembler()
    @apicall(:LLVMInitializeWebAssemblyDisassembler, Cvoid, ())
end

function LLVMInitializeX86Disassembler()
    @apicall(:LLVMInitializeX86Disassembler, Cvoid, ())
end

function LLVMInitializeAllTargetInfos()
    @apicall(:LLVMInitializeAllTargetInfos, Cvoid, ())
end

function LLVMInitializeAllTargets()
    @apicall(:LLVMInitializeAllTargets, Cvoid, ())
end

function LLVMInitializeAllTargetMCs()
    @apicall(:LLVMInitializeAllTargetMCs, Cvoid, ())
end

function LLVMInitializeAllAsmPrinters()
    @apicall(:LLVMInitializeAllAsmPrinters, Cvoid, ())
end

function LLVMInitializeAllAsmParsers()
    @apicall(:LLVMInitializeAllAsmParsers, Cvoid, ())
end

function LLVMInitializeAllDisassemblers()
    @apicall(:LLVMInitializeAllDisassemblers, Cvoid, ())
end

function LLVMInitializeNativeTarget()
    @apicall(:LLVMInitializeNativeTarget, LLVMBool, ())
end

function LLVMInitializeNativeAsmParser()
    @apicall(:LLVMInitializeNativeAsmParser, LLVMBool, ())
end

function LLVMInitializeNativeAsmPrinter()
    @apicall(:LLVMInitializeNativeAsmPrinter, LLVMBool, ())
end

function LLVMInitializeNativeDisassembler()
    @apicall(:LLVMInitializeNativeDisassembler, LLVMBool, ())
end

function LLVMGetModuleDataLayout(M)
    @apicall(:LLVMGetModuleDataLayout, LLVMTargetDataRef, (LLVMModuleRef,), M)
end

function LLVMSetModuleDataLayout(M, DL)
    @apicall(:LLVMSetModuleDataLayout, Cvoid, (LLVMModuleRef, LLVMTargetDataRef), M, DL)
end

function LLVMCreateTargetData(StringRep)
    @apicall(:LLVMCreateTargetData, LLVMTargetDataRef, (Cstring,), StringRep)
end

function LLVMDisposeTargetData(TD)
    @apicall(:LLVMDisposeTargetData, Cvoid, (LLVMTargetDataRef,), TD)
end

function LLVMAddTargetLibraryInfo(TLI, PM)
    @apicall(:LLVMAddTargetLibraryInfo, Cvoid, (LLVMTargetLibraryInfoRef, LLVMPassManagerRef), TLI, PM)
end

function LLVMCopyStringRepOfTargetData(TD)
    @apicall(:LLVMCopyStringRepOfTargetData, Cstring, (LLVMTargetDataRef,), TD)
end

function LLVMByteOrder(TD)
    @apicall(:LLVMByteOrder, LLVMByteOrdering, (LLVMTargetDataRef,), TD)
end

function LLVMPointerSize(TD)
    @apicall(:LLVMPointerSize, UInt32, (LLVMTargetDataRef,), TD)
end

function LLVMPointerSizeForAS(TD, AS)
    @apicall(:LLVMPointerSizeForAS, UInt32, (LLVMTargetDataRef, UInt32), TD, AS)
end

function LLVMIntPtrType(TD)
    @apicall(:LLVMIntPtrType, LLVMTypeRef, (LLVMTargetDataRef,), TD)
end

function LLVMIntPtrTypeForAS(TD, AS)
    @apicall(:LLVMIntPtrTypeForAS, LLVMTypeRef, (LLVMTargetDataRef, UInt32), TD, AS)
end

function LLVMIntPtrTypeInContext(C, TD)
    @apicall(:LLVMIntPtrTypeInContext, LLVMTypeRef, (LLVMContextRef, LLVMTargetDataRef), C, TD)
end

function LLVMIntPtrTypeForASInContext(C, TD, AS)
    @apicall(:LLVMIntPtrTypeForASInContext, LLVMTypeRef, (LLVMContextRef, LLVMTargetDataRef, UInt32), C, TD, AS)
end

function LLVMSizeOfTypeInBits(TD, Ty)
    @apicall(:LLVMSizeOfTypeInBits, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMStoreSizeOfType(TD, Ty)
    @apicall(:LLVMStoreSizeOfType, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMABISizeOfType(TD, Ty)
    @apicall(:LLVMABISizeOfType, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMABIAlignmentOfType(TD, Ty)
    @apicall(:LLVMABIAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMCallFrameAlignmentOfType(TD, Ty)
    @apicall(:LLVMCallFrameAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMPreferredAlignmentOfType(TD, Ty)
    @apicall(:LLVMPreferredAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMPreferredAlignmentOfGlobal(TD, GlobalVar)
    @apicall(:LLVMPreferredAlignmentOfGlobal, UInt32, (LLVMTargetDataRef, LLVMValueRef), TD, GlobalVar)
end

function LLVMElementAtOffset(TD, StructTy, Offset)
    @apicall(:LLVMElementAtOffset, UInt32, (LLVMTargetDataRef, LLVMTypeRef, Culonglong), TD, StructTy, Offset)
end

function LLVMOffsetOfElement(TD, StructTy, Element)
    @apicall(:LLVMOffsetOfElement, Culonglong, (LLVMTargetDataRef, LLVMTypeRef, UInt32), TD, StructTy, Element)
end
# Julia wrapper for header: TargetMachine.h
# Automatically generated using Clang.jl


function LLVMInitializeNVPTXTargetInfo()
    @apicall(:LLVMInitializeNVPTXTargetInfo, Cvoid, ())
end

function LLVMInitializeAMDGPUTargetInfo()
    @apicall(:LLVMInitializeAMDGPUTargetInfo, Cvoid, ())
end

function LLVMInitializeWebAssemblyTargetInfo()
    @apicall(:LLVMInitializeWebAssemblyTargetInfo, Cvoid, ())
end

function LLVMInitializeX86TargetInfo()
    @apicall(:LLVMInitializeX86TargetInfo, Cvoid, ())
end

function LLVMInitializeNVPTXTarget()
    @apicall(:LLVMInitializeNVPTXTarget, Cvoid, ())
end

function LLVMInitializeAMDGPUTarget()
    @apicall(:LLVMInitializeAMDGPUTarget, Cvoid, ())
end

function LLVMInitializeWebAssemblyTarget()
    @apicall(:LLVMInitializeWebAssemblyTarget, Cvoid, ())
end

function LLVMInitializeX86Target()
    @apicall(:LLVMInitializeX86Target, Cvoid, ())
end

function LLVMInitializeNVPTXTargetMC()
    @apicall(:LLVMInitializeNVPTXTargetMC, Cvoid, ())
end

function LLVMInitializeAMDGPUTargetMC()
    @apicall(:LLVMInitializeAMDGPUTargetMC, Cvoid, ())
end

function LLVMInitializeWebAssemblyTargetMC()
    @apicall(:LLVMInitializeWebAssemblyTargetMC, Cvoid, ())
end

function LLVMInitializeX86TargetMC()
    @apicall(:LLVMInitializeX86TargetMC, Cvoid, ())
end

function LLVMInitializeNVPTXAsmPrinter()
    @apicall(:LLVMInitializeNVPTXAsmPrinter, Cvoid, ())
end

function LLVMInitializeAMDGPUAsmPrinter()
    @apicall(:LLVMInitializeAMDGPUAsmPrinter, Cvoid, ())
end

function LLVMInitializeWebAssemblyAsmPrinter()
    @apicall(:LLVMInitializeWebAssemblyAsmPrinter, Cvoid, ())
end

function LLVMInitializeX86AsmPrinter()
    @apicall(:LLVMInitializeX86AsmPrinter, Cvoid, ())
end

function LLVMInitializeAMDGPUAsmParser()
    @apicall(:LLVMInitializeAMDGPUAsmParser, Cvoid, ())
end

function LLVMInitializeWebAssemblyAsmParser()
    @apicall(:LLVMInitializeWebAssemblyAsmParser, Cvoid, ())
end

function LLVMInitializeX86AsmParser()
    @apicall(:LLVMInitializeX86AsmParser, Cvoid, ())
end

function LLVMInitializeAMDGPUDisassembler()
    @apicall(:LLVMInitializeAMDGPUDisassembler, Cvoid, ())
end

function LLVMInitializeWebAssemblyDisassembler()
    @apicall(:LLVMInitializeWebAssemblyDisassembler, Cvoid, ())
end

function LLVMInitializeX86Disassembler()
    @apicall(:LLVMInitializeX86Disassembler, Cvoid, ())
end

function LLVMInitializeAllTargetInfos()
    @apicall(:LLVMInitializeAllTargetInfos, Cvoid, ())
end

function LLVMInitializeAllTargets()
    @apicall(:LLVMInitializeAllTargets, Cvoid, ())
end

function LLVMInitializeAllTargetMCs()
    @apicall(:LLVMInitializeAllTargetMCs, Cvoid, ())
end

function LLVMInitializeAllAsmPrinters()
    @apicall(:LLVMInitializeAllAsmPrinters, Cvoid, ())
end

function LLVMInitializeAllAsmParsers()
    @apicall(:LLVMInitializeAllAsmParsers, Cvoid, ())
end

function LLVMInitializeAllDisassemblers()
    @apicall(:LLVMInitializeAllDisassemblers, Cvoid, ())
end

function LLVMInitializeNativeTarget()
    @apicall(:LLVMInitializeNativeTarget, LLVMBool, ())
end

function LLVMInitializeNativeAsmParser()
    @apicall(:LLVMInitializeNativeAsmParser, LLVMBool, ())
end

function LLVMInitializeNativeAsmPrinter()
    @apicall(:LLVMInitializeNativeAsmPrinter, LLVMBool, ())
end

function LLVMInitializeNativeDisassembler()
    @apicall(:LLVMInitializeNativeDisassembler, LLVMBool, ())
end

function LLVMGetModuleDataLayout(M)
    @apicall(:LLVMGetModuleDataLayout, LLVMTargetDataRef, (LLVMModuleRef,), M)
end

function LLVMSetModuleDataLayout(M, DL)
    @apicall(:LLVMSetModuleDataLayout, Cvoid, (LLVMModuleRef, LLVMTargetDataRef), M, DL)
end

function LLVMCreateTargetData(StringRep)
    @apicall(:LLVMCreateTargetData, LLVMTargetDataRef, (Cstring,), StringRep)
end

function LLVMDisposeTargetData(TD)
    @apicall(:LLVMDisposeTargetData, Cvoid, (LLVMTargetDataRef,), TD)
end

function LLVMAddTargetLibraryInfo(TLI, PM)
    @apicall(:LLVMAddTargetLibraryInfo, Cvoid, (LLVMTargetLibraryInfoRef, LLVMPassManagerRef), TLI, PM)
end

function LLVMCopyStringRepOfTargetData(TD)
    @apicall(:LLVMCopyStringRepOfTargetData, Cstring, (LLVMTargetDataRef,), TD)
end

function LLVMByteOrder(TD)
    @apicall(:LLVMByteOrder, LLVMByteOrdering, (LLVMTargetDataRef,), TD)
end

function LLVMPointerSize(TD)
    @apicall(:LLVMPointerSize, UInt32, (LLVMTargetDataRef,), TD)
end

function LLVMPointerSizeForAS(TD, AS)
    @apicall(:LLVMPointerSizeForAS, UInt32, (LLVMTargetDataRef, UInt32), TD, AS)
end

function LLVMIntPtrType(TD)
    @apicall(:LLVMIntPtrType, LLVMTypeRef, (LLVMTargetDataRef,), TD)
end

function LLVMIntPtrTypeForAS(TD, AS)
    @apicall(:LLVMIntPtrTypeForAS, LLVMTypeRef, (LLVMTargetDataRef, UInt32), TD, AS)
end

function LLVMIntPtrTypeInContext(C, TD)
    @apicall(:LLVMIntPtrTypeInContext, LLVMTypeRef, (LLVMContextRef, LLVMTargetDataRef), C, TD)
end

function LLVMIntPtrTypeForASInContext(C, TD, AS)
    @apicall(:LLVMIntPtrTypeForASInContext, LLVMTypeRef, (LLVMContextRef, LLVMTargetDataRef, UInt32), C, TD, AS)
end

function LLVMSizeOfTypeInBits(TD, Ty)
    @apicall(:LLVMSizeOfTypeInBits, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMStoreSizeOfType(TD, Ty)
    @apicall(:LLVMStoreSizeOfType, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMABISizeOfType(TD, Ty)
    @apicall(:LLVMABISizeOfType, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMABIAlignmentOfType(TD, Ty)
    @apicall(:LLVMABIAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMCallFrameAlignmentOfType(TD, Ty)
    @apicall(:LLVMCallFrameAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMPreferredAlignmentOfType(TD, Ty)
    @apicall(:LLVMPreferredAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMPreferredAlignmentOfGlobal(TD, GlobalVar)
    @apicall(:LLVMPreferredAlignmentOfGlobal, UInt32, (LLVMTargetDataRef, LLVMValueRef), TD, GlobalVar)
end

function LLVMElementAtOffset(TD, StructTy, Offset)
    @apicall(:LLVMElementAtOffset, UInt32, (LLVMTargetDataRef, LLVMTypeRef, Culonglong), TD, StructTy, Offset)
end

function LLVMOffsetOfElement(TD, StructTy, Element)
    @apicall(:LLVMOffsetOfElement, Culonglong, (LLVMTargetDataRef, LLVMTypeRef, UInt32), TD, StructTy, Element)
end

function LLVMGetFirstTarget()
    @apicall(:LLVMGetFirstTarget, LLVMTargetRef, ())
end

function LLVMGetNextTarget(T)
    @apicall(:LLVMGetNextTarget, LLVMTargetRef, (LLVMTargetRef,), T)
end

function LLVMGetTargetFromName(Name)
    @apicall(:LLVMGetTargetFromName, LLVMTargetRef, (Cstring,), Name)
end

function LLVMGetTargetFromTriple(Triple, T, ErrorMessage)
    @apicall(:LLVMGetTargetFromTriple, LLVMBool, (Cstring, Ptr{LLVMTargetRef}, Ptr{Cstring}), Triple, T, ErrorMessage)
end

function LLVMGetTargetName(T)
    @apicall(:LLVMGetTargetName, Cstring, (LLVMTargetRef,), T)
end

function LLVMGetTargetDescription(T)
    @apicall(:LLVMGetTargetDescription, Cstring, (LLVMTargetRef,), T)
end

function LLVMTargetHasJIT(T)
    @apicall(:LLVMTargetHasJIT, LLVMBool, (LLVMTargetRef,), T)
end

function LLVMTargetHasTargetMachine(T)
    @apicall(:LLVMTargetHasTargetMachine, LLVMBool, (LLVMTargetRef,), T)
end

function LLVMTargetHasAsmBackend(T)
    @apicall(:LLVMTargetHasAsmBackend, LLVMBool, (LLVMTargetRef,), T)
end

function LLVMCreateTargetMachine(T, Triple, CPU, Features, Level, Reloc, CodeModel)
    @apicall(:LLVMCreateTargetMachine, LLVMTargetMachineRef, (LLVMTargetRef, Cstring, Cstring, Cstring, LLVMCodeGenOptLevel, LLVMRelocMode, LLVMCodeModel), T, Triple, CPU, Features, Level, Reloc, CodeModel)
end

function LLVMDisposeTargetMachine(T)
    @apicall(:LLVMDisposeTargetMachine, Cvoid, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineTarget(T)
    @apicall(:LLVMGetTargetMachineTarget, LLVMTargetRef, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineTriple(T)
    @apicall(:LLVMGetTargetMachineTriple, Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineCPU(T)
    @apicall(:LLVMGetTargetMachineCPU, Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineFeatureString(T)
    @apicall(:LLVMGetTargetMachineFeatureString, Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMCreateTargetDataLayout(T)
    @apicall(:LLVMCreateTargetDataLayout, LLVMTargetDataRef, (LLVMTargetMachineRef,), T)
end

function LLVMSetTargetMachineAsmVerbosity(T, VerboseAsm)
    @apicall(:LLVMSetTargetMachineAsmVerbosity, Cvoid, (LLVMTargetMachineRef, LLVMBool), T, VerboseAsm)
end

function LLVMTargetMachineEmitToFile(T, M, Filename, codegen, ErrorMessage)
    @apicall(:LLVMTargetMachineEmitToFile, LLVMBool, (LLVMTargetMachineRef, LLVMModuleRef, Cstring, LLVMCodeGenFileType, Ptr{Cstring}), T, M, Filename, codegen, ErrorMessage)
end

function LLVMTargetMachineEmitToMemoryBuffer(T, M, codegen, ErrorMessage, OutMemBuf)
    @apicall(:LLVMTargetMachineEmitToMemoryBuffer, LLVMBool, (LLVMTargetMachineRef, LLVMModuleRef, LLVMCodeGenFileType, Ptr{Cstring}, Ptr{LLVMMemoryBufferRef}), T, M, codegen, ErrorMessage, OutMemBuf)
end

function LLVMGetDefaultTargetTriple()
    @apicall(:LLVMGetDefaultTargetTriple, Cstring, ())
end

function LLVMNormalizeTargetTriple(triple)
    @apicall(:LLVMNormalizeTargetTriple, Cstring, (Cstring,), triple)
end

function LLVMGetHostCPUName()
    @apicall(:LLVMGetHostCPUName, Cstring, ())
end

function LLVMGetHostCPUFeatures()
    @apicall(:LLVMGetHostCPUFeatures, Cstring, ())
end

function LLVMAddAnalysisPasses(T, PM)
    @apicall(:LLVMAddAnalysisPasses, Cvoid, (LLVMTargetMachineRef, LLVMPassManagerRef), T, PM)
end
# Julia wrapper for header: Types.h
# Automatically generated using Clang.jl

# Julia wrapper for header: lto.h
# Automatically generated using Clang.jl


function lto_get_version()
    @apicall(:lto_get_version, Cstring, ())
end

function lto_get_error_message()
    @apicall(:lto_get_error_message, Cstring, ())
end

function lto_module_is_object_file(path)
    @apicall(:lto_module_is_object_file, lto_bool_t, (Cstring,), path)
end

function lto_module_is_object_file_for_target(path, target_triple_prefix)
    @apicall(:lto_module_is_object_file_for_target, lto_bool_t, (Cstring, Cstring), path, target_triple_prefix)
end

function lto_module_has_objc_category(mem, length)
    @apicall(:lto_module_has_objc_category, lto_bool_t, (Ptr{Cvoid}, Csize_t), mem, length)
end

function lto_module_is_object_file_in_memory(mem, length)
    @apicall(:lto_module_is_object_file_in_memory, lto_bool_t, (Ptr{Cvoid}, Csize_t), mem, length)
end

function lto_module_is_object_file_in_memory_for_target(mem, length, target_triple_prefix)
    @apicall(:lto_module_is_object_file_in_memory_for_target, lto_bool_t, (Ptr{Cvoid}, Csize_t, Cstring), mem, length, target_triple_prefix)
end

function lto_module_create(path)
    @apicall(:lto_module_create, lto_module_t, (Cstring,), path)
end

function lto_module_create_from_memory(mem, length)
    @apicall(:lto_module_create_from_memory, lto_module_t, (Ptr{Cvoid}, Csize_t), mem, length)
end

function lto_module_create_from_memory_with_path(mem, length, path)
    @apicall(:lto_module_create_from_memory_with_path, lto_module_t, (Ptr{Cvoid}, Csize_t, Cstring), mem, length, path)
end

function lto_module_create_in_local_context(mem, length, path)
    @apicall(:lto_module_create_in_local_context, lto_module_t, (Ptr{Cvoid}, Csize_t, Cstring), mem, length, path)
end

function lto_module_create_in_codegen_context(mem, length, path, cg)
    @apicall(:lto_module_create_in_codegen_context, lto_module_t, (Ptr{Cvoid}, Csize_t, Cstring, lto_code_gen_t), mem, length, path, cg)
end

function lto_module_create_from_fd(fd, path, file_size)
    @apicall(:lto_module_create_from_fd, lto_module_t, (Cint, Cstring, Csize_t), fd, path, file_size)
end

function lto_module_create_from_fd_at_offset(fd, path, file_size, map_size, offset)
    @apicall(:lto_module_create_from_fd_at_offset, lto_module_t, (Cint, Cstring, Csize_t, Csize_t, off_t), fd, path, file_size, map_size, offset)
end

function lto_module_dispose(mod)
    @apicall(:lto_module_dispose, Cvoid, (lto_module_t,), mod)
end

function lto_module_get_target_triple(mod)
    @apicall(:lto_module_get_target_triple, Cstring, (lto_module_t,), mod)
end

function lto_module_set_target_triple(mod, triple)
    @apicall(:lto_module_set_target_triple, Cvoid, (lto_module_t, Cstring), mod, triple)
end

function lto_module_get_num_symbols(mod)
    @apicall(:lto_module_get_num_symbols, UInt32, (lto_module_t,), mod)
end

function lto_module_get_symbol_name(mod, index)
    @apicall(:lto_module_get_symbol_name, Cstring, (lto_module_t, UInt32), mod, index)
end

function lto_module_get_symbol_attribute(mod, index)
    @apicall(:lto_module_get_symbol_attribute, lto_symbol_attributes, (lto_module_t, UInt32), mod, index)
end

function lto_module_get_linkeropts(mod)
    @apicall(:lto_module_get_linkeropts, Cstring, (lto_module_t,), mod)
end

function lto_codegen_set_diagnostic_handler(arg1, arg2, arg3)
    @apicall(:lto_codegen_set_diagnostic_handler, Cvoid, (lto_code_gen_t, lto_diagnostic_handler_t, Ptr{Cvoid}), arg1, arg2, arg3)
end

function lto_codegen_create()
    @apicall(:lto_codegen_create, lto_code_gen_t, ())
end

function lto_codegen_create_in_local_context()
    @apicall(:lto_codegen_create_in_local_context, lto_code_gen_t, ())
end

function lto_codegen_dispose(arg1)
    @apicall(:lto_codegen_dispose, Cvoid, (lto_code_gen_t,), arg1)
end

function lto_codegen_add_module(cg, mod)
    @apicall(:lto_codegen_add_module, lto_bool_t, (lto_code_gen_t, lto_module_t), cg, mod)
end

function lto_codegen_set_module(cg, mod)
    @apicall(:lto_codegen_set_module, Cvoid, (lto_code_gen_t, lto_module_t), cg, mod)
end

function lto_codegen_set_debug_model(cg, arg1)
    @apicall(:lto_codegen_set_debug_model, lto_bool_t, (lto_code_gen_t, lto_debug_model), cg, arg1)
end

function lto_codegen_set_pic_model(cg, arg1)
    @apicall(:lto_codegen_set_pic_model, lto_bool_t, (lto_code_gen_t, lto_codegen_model), cg, arg1)
end

function lto_codegen_set_cpu(cg, cpu)
    @apicall(:lto_codegen_set_cpu, Cvoid, (lto_code_gen_t, Cstring), cg, cpu)
end

function lto_codegen_set_assembler_path(cg, path)
    @apicall(:lto_codegen_set_assembler_path, Cvoid, (lto_code_gen_t, Cstring), cg, path)
end

function lto_codegen_set_assembler_args(cg, args, nargs)
    @apicall(:lto_codegen_set_assembler_args, Cvoid, (lto_code_gen_t, Ptr{Cstring}, Cint), cg, args, nargs)
end

function lto_codegen_add_must_preserve_symbol(cg, symbol)
    @apicall(:lto_codegen_add_must_preserve_symbol, Cvoid, (lto_code_gen_t, Cstring), cg, symbol)
end

function lto_codegen_write_merged_modules(cg, path)
    @apicall(:lto_codegen_write_merged_modules, lto_bool_t, (lto_code_gen_t, Cstring), cg, path)
end

function lto_codegen_compile(cg, length)
    @apicall(:lto_codegen_compile, Ptr{Cvoid}, (lto_code_gen_t, Ptr{Csize_t}), cg, length)
end

function lto_codegen_compile_to_file(cg, name)
    @apicall(:lto_codegen_compile_to_file, lto_bool_t, (lto_code_gen_t, Ptr{Cstring}), cg, name)
end

function lto_codegen_optimize(cg)
    @apicall(:lto_codegen_optimize, lto_bool_t, (lto_code_gen_t,), cg)
end

function lto_codegen_compile_optimized(cg, length)
    @apicall(:lto_codegen_compile_optimized, Ptr{Cvoid}, (lto_code_gen_t, Ptr{Csize_t}), cg, length)
end

function lto_api_version()
    @apicall(:lto_api_version, UInt32, ())
end

function lto_codegen_debug_options(cg, arg1)
    @apicall(:lto_codegen_debug_options, Cvoid, (lto_code_gen_t, Cstring), cg, arg1)
end

function lto_initialize_disassembler()
    @apicall(:lto_initialize_disassembler, Cvoid, ())
end

function lto_codegen_set_should_internalize(cg, ShouldInternalize)
    @apicall(:lto_codegen_set_should_internalize, Cvoid, (lto_code_gen_t, lto_bool_t), cg, ShouldInternalize)
end

function lto_codegen_set_should_embed_uselists(cg, ShouldEmbedUselists)
    @apicall(:lto_codegen_set_should_embed_uselists, Cvoid, (lto_code_gen_t, lto_bool_t), cg, ShouldEmbedUselists)
end

function thinlto_create_codegen()
    @apicall(:thinlto_create_codegen, thinlto_code_gen_t, ())
end

function thinlto_codegen_dispose(cg)
    @apicall(:thinlto_codegen_dispose, Cvoid, (thinlto_code_gen_t,), cg)
end

function thinlto_codegen_add_module(cg, identifier, data, length)
    @apicall(:thinlto_codegen_add_module, Cvoid, (thinlto_code_gen_t, Cstring, Cstring, Cint), cg, identifier, data, length)
end

function thinlto_codegen_process(cg)
    @apicall(:thinlto_codegen_process, Cvoid, (thinlto_code_gen_t,), cg)
end

function thinlto_module_get_num_objects(cg)
    @apicall(:thinlto_module_get_num_objects, UInt32, (thinlto_code_gen_t,), cg)
end

function thinlto_module_get_object(cg, index)
    @apicall(:thinlto_module_get_object, LTOObjectBuffer, (thinlto_code_gen_t, UInt32), cg, index)
end

function thinlto_module_get_num_object_files(cg)
    @apicall(:thinlto_module_get_num_object_files, UInt32, (thinlto_code_gen_t,), cg)
end

function thinlto_module_get_object_file(cg, index)
    @apicall(:thinlto_module_get_object_file, Cstring, (thinlto_code_gen_t, UInt32), cg, index)
end

function thinlto_codegen_set_pic_model(cg, arg1)
    @apicall(:thinlto_codegen_set_pic_model, lto_bool_t, (thinlto_code_gen_t, lto_codegen_model), cg, arg1)
end

function thinlto_codegen_set_savetemps_dir(cg, save_temps_dir)
    @apicall(:thinlto_codegen_set_savetemps_dir, Cvoid, (thinlto_code_gen_t, Cstring), cg, save_temps_dir)
end

function thinlto_set_generated_objects_dir(cg, save_temps_dir)
    @apicall(:thinlto_set_generated_objects_dir, Cvoid, (thinlto_code_gen_t, Cstring), cg, save_temps_dir)
end

function thinlto_codegen_set_cpu(cg, cpu)
    @apicall(:thinlto_codegen_set_cpu, Cvoid, (thinlto_code_gen_t, Cstring), cg, cpu)
end

function thinlto_codegen_disable_codegen(cg, disable)
    @apicall(:thinlto_codegen_disable_codegen, Cvoid, (thinlto_code_gen_t, lto_bool_t), cg, disable)
end

function thinlto_codegen_set_codegen_only(cg, codegen_only)
    @apicall(:thinlto_codegen_set_codegen_only, Cvoid, (thinlto_code_gen_t, lto_bool_t), cg, codegen_only)
end

function thinlto_debug_options(options, number)
    @apicall(:thinlto_debug_options, Cvoid, (Ptr{Cstring}, Cint), options, number)
end

function lto_module_is_thinlto(mod)
    @apicall(:lto_module_is_thinlto, lto_bool_t, (lto_module_t,), mod)
end

function thinlto_codegen_add_must_preserve_symbol(cg, name, length)
    @apicall(:thinlto_codegen_add_must_preserve_symbol, Cvoid, (thinlto_code_gen_t, Cstring, Cint), cg, name, length)
end

function thinlto_codegen_add_cross_referenced_symbol(cg, name, length)
    @apicall(:thinlto_codegen_add_cross_referenced_symbol, Cvoid, (thinlto_code_gen_t, Cstring, Cint), cg, name, length)
end

function thinlto_codegen_set_cache_dir(cg, cache_dir)
    @apicall(:thinlto_codegen_set_cache_dir, Cvoid, (thinlto_code_gen_t, Cstring), cg, cache_dir)
end

function thinlto_codegen_set_cache_pruning_interval(cg, interval)
    @apicall(:thinlto_codegen_set_cache_pruning_interval, Cvoid, (thinlto_code_gen_t, Cint), cg, interval)
end

function thinlto_codegen_set_final_cache_size_relative_to_available_space(cg, percentage)
    @apicall(:thinlto_codegen_set_final_cache_size_relative_to_available_space, Cvoid, (thinlto_code_gen_t, UInt32), cg, percentage)
end

function thinlto_codegen_set_cache_entry_expiration(cg, expiration)
    @apicall(:thinlto_codegen_set_cache_entry_expiration, Cvoid, (thinlto_code_gen_t, UInt32), cg, expiration)
end

function thinlto_codegen_set_cache_size_bytes(cg, max_size_bytes)
    @apicall(:thinlto_codegen_set_cache_size_bytes, Cvoid, (thinlto_code_gen_t, UInt32), cg, max_size_bytes)
end

function thinlto_codegen_set_cache_size_megabytes(cg, max_size_megabytes)
    @apicall(:thinlto_codegen_set_cache_size_megabytes, Cvoid, (thinlto_code_gen_t, UInt32), cg, max_size_megabytes)
end

function thinlto_codegen_set_cache_size_files(cg, max_size_files)
    @apicall(:thinlto_codegen_set_cache_size_files, Cvoid, (thinlto_code_gen_t, UInt32), cg, max_size_files)
end
# Julia wrapper for header: AggressiveInstCombine.h
# Automatically generated using Clang.jl


function LLVMAddAggressiveInstCombinerPass(PM)
    @apicall(:LLVMAddAggressiveInstCombinerPass, Cvoid, (LLVMPassManagerRef,), PM)
end
# Julia wrapper for header: Coroutines.h
# Automatically generated using Clang.jl


function LLVMAddCoroEarlyPass(PM)
    @apicall(:LLVMAddCoroEarlyPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCoroSplitPass(PM)
    @apicall(:LLVMAddCoroSplitPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCoroElidePass(PM)
    @apicall(:LLVMAddCoroElidePass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCoroCleanupPass(PM)
    @apicall(:LLVMAddCoroCleanupPass, Cvoid, (LLVMPassManagerRef,), PM)
end
# Julia wrapper for header: IPO.h
# Automatically generated using Clang.jl


function LLVMAddArgumentPromotionPass(PM)
    @apicall(:LLVMAddArgumentPromotionPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddConstantMergePass(PM)
    @apicall(:LLVMAddConstantMergePass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCalledValuePropagationPass(PM)
    @apicall(:LLVMAddCalledValuePropagationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddDeadArgEliminationPass(PM)
    @apicall(:LLVMAddDeadArgEliminationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddFunctionAttrsPass(PM)
    @apicall(:LLVMAddFunctionAttrsPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddFunctionInliningPass(PM)
    @apicall(:LLVMAddFunctionInliningPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddAlwaysInlinerPass(PM)
    @apicall(:LLVMAddAlwaysInlinerPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddGlobalDCEPass(PM)
    @apicall(:LLVMAddGlobalDCEPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddGlobalOptimizerPass(PM)
    @apicall(:LLVMAddGlobalOptimizerPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddIPConstantPropagationPass(PM)
    @apicall(:LLVMAddIPConstantPropagationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddPruneEHPass(PM)
    @apicall(:LLVMAddPruneEHPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddIPSCCPPass(PM)
    @apicall(:LLVMAddIPSCCPPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddInternalizePass(arg1, AllButMain)
    @apicall(:LLVMAddInternalizePass, Cvoid, (LLVMPassManagerRef, UInt32), arg1, AllButMain)
end

function LLVMAddStripDeadPrototypesPass(PM)
    @apicall(:LLVMAddStripDeadPrototypesPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddStripSymbolsPass(PM)
    @apicall(:LLVMAddStripSymbolsPass, Cvoid, (LLVMPassManagerRef,), PM)
end
# Julia wrapper for header: InstCombine.h
# Automatically generated using Clang.jl


function LLVMAddInstructionCombiningPass(PM)
    @apicall(:LLVMAddInstructionCombiningPass, Cvoid, (LLVMPassManagerRef,), PM)
end
# Julia wrapper for header: PassManagerBuilder.h
# Automatically generated using Clang.jl


function LLVMPassManagerBuilderCreate()
    @apicall(:LLVMPassManagerBuilderCreate, LLVMPassManagerBuilderRef, ())
end

function LLVMPassManagerBuilderDispose(PMB)
    @apicall(:LLVMPassManagerBuilderDispose, Cvoid, (LLVMPassManagerBuilderRef,), PMB)
end

function LLVMPassManagerBuilderSetOptLevel(PMB, OptLevel)
    @apicall(:LLVMPassManagerBuilderSetOptLevel, Cvoid, (LLVMPassManagerBuilderRef, UInt32), PMB, OptLevel)
end

function LLVMPassManagerBuilderSetSizeLevel(PMB, SizeLevel)
    @apicall(:LLVMPassManagerBuilderSetSizeLevel, Cvoid, (LLVMPassManagerBuilderRef, UInt32), PMB, SizeLevel)
end

function LLVMPassManagerBuilderSetDisableUnitAtATime(PMB, Value)
    @apicall(:LLVMPassManagerBuilderSetDisableUnitAtATime, Cvoid, (LLVMPassManagerBuilderRef, LLVMBool), PMB, Value)
end

function LLVMPassManagerBuilderSetDisableUnrollLoops(PMB, Value)
    @apicall(:LLVMPassManagerBuilderSetDisableUnrollLoops, Cvoid, (LLVMPassManagerBuilderRef, LLVMBool), PMB, Value)
end

function LLVMPassManagerBuilderSetDisableSimplifyLibCalls(PMB, Value)
    @apicall(:LLVMPassManagerBuilderSetDisableSimplifyLibCalls, Cvoid, (LLVMPassManagerBuilderRef, LLVMBool), PMB, Value)
end

function LLVMPassManagerBuilderUseInlinerWithThreshold(PMB, Threshold)
    @apicall(:LLVMPassManagerBuilderUseInlinerWithThreshold, Cvoid, (LLVMPassManagerBuilderRef, UInt32), PMB, Threshold)
end

function LLVMPassManagerBuilderPopulateFunctionPassManager(PMB, PM)
    @apicall(:LLVMPassManagerBuilderPopulateFunctionPassManager, Cvoid, (LLVMPassManagerBuilderRef, LLVMPassManagerRef), PMB, PM)
end

function LLVMPassManagerBuilderPopulateModulePassManager(PMB, PM)
    @apicall(:LLVMPassManagerBuilderPopulateModulePassManager, Cvoid, (LLVMPassManagerBuilderRef, LLVMPassManagerRef), PMB, PM)
end

function LLVMPassManagerBuilderPopulateLTOPassManager(PMB, PM, Internalize, RunInliner)
    @apicall(:LLVMPassManagerBuilderPopulateLTOPassManager, Cvoid, (LLVMPassManagerBuilderRef, LLVMPassManagerRef, LLVMBool, LLVMBool), PMB, PM, Internalize, RunInliner)
end
# Julia wrapper for header: Scalar.h
# Automatically generated using Clang.jl


function LLVMAddAggressiveDCEPass(PM)
    @apicall(:LLVMAddAggressiveDCEPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddBitTrackingDCEPass(PM)
    @apicall(:LLVMAddBitTrackingDCEPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddAlignmentFromAssumptionsPass(PM)
    @apicall(:LLVMAddAlignmentFromAssumptionsPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCFGSimplificationPass(PM)
    @apicall(:LLVMAddCFGSimplificationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddDeadStoreEliminationPass(PM)
    @apicall(:LLVMAddDeadStoreEliminationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScalarizerPass(PM)
    @apicall(:LLVMAddScalarizerPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddMergedLoadStoreMotionPass(PM)
    @apicall(:LLVMAddMergedLoadStoreMotionPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddGVNPass(PM)
    @apicall(:LLVMAddGVNPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddNewGVNPass(PM)
    @apicall(:LLVMAddNewGVNPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddIndVarSimplifyPass(PM)
    @apicall(:LLVMAddIndVarSimplifyPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddInstructionCombiningPass(PM)
    @apicall(:LLVMAddInstructionCombiningPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddJumpThreadingPass(PM)
    @apicall(:LLVMAddJumpThreadingPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLICMPass(PM)
    @apicall(:LLVMAddLICMPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopDeletionPass(PM)
    @apicall(:LLVMAddLoopDeletionPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopIdiomPass(PM)
    @apicall(:LLVMAddLoopIdiomPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopRotatePass(PM)
    @apicall(:LLVMAddLoopRotatePass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopRerollPass(PM)
    @apicall(:LLVMAddLoopRerollPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopUnrollPass(PM)
    @apicall(:LLVMAddLoopUnrollPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopUnrollAndJamPass(PM)
    @apicall(:LLVMAddLoopUnrollAndJamPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopUnswitchPass(PM)
    @apicall(:LLVMAddLoopUnswitchPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLowerAtomicPass(PM)
    @apicall(:LLVMAddLowerAtomicPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddMemCpyOptPass(PM)
    @apicall(:LLVMAddMemCpyOptPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddPartiallyInlineLibCallsPass(PM)
    @apicall(:LLVMAddPartiallyInlineLibCallsPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddReassociatePass(PM)
    @apicall(:LLVMAddReassociatePass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddSCCPPass(PM)
    @apicall(:LLVMAddSCCPPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScalarReplAggregatesPass(PM)
    @apicall(:LLVMAddScalarReplAggregatesPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScalarReplAggregatesPassSSA(PM)
    @apicall(:LLVMAddScalarReplAggregatesPassSSA, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScalarReplAggregatesPassWithThreshold(PM, Threshold)
    @apicall(:LLVMAddScalarReplAggregatesPassWithThreshold, Cvoid, (LLVMPassManagerRef, Cint), PM, Threshold)
end

function LLVMAddSimplifyLibCallsPass(PM)
    @apicall(:LLVMAddSimplifyLibCallsPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddTailCallEliminationPass(PM)
    @apicall(:LLVMAddTailCallEliminationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddConstantPropagationPass(PM)
    @apicall(:LLVMAddConstantPropagationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddDemoteMemoryToRegisterPass(PM)
    @apicall(:LLVMAddDemoteMemoryToRegisterPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddVerifierPass(PM)
    @apicall(:LLVMAddVerifierPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCorrelatedValuePropagationPass(PM)
    @apicall(:LLVMAddCorrelatedValuePropagationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddEarlyCSEPass(PM)
    @apicall(:LLVMAddEarlyCSEPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddEarlyCSEMemSSAPass(PM)
    @apicall(:LLVMAddEarlyCSEMemSSAPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLowerExpectIntrinsicPass(PM)
    @apicall(:LLVMAddLowerExpectIntrinsicPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddTypeBasedAliasAnalysisPass(PM)
    @apicall(:LLVMAddTypeBasedAliasAnalysisPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScopedNoAliasAAPass(PM)
    @apicall(:LLVMAddScopedNoAliasAAPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddBasicAliasAnalysisPass(PM)
    @apicall(:LLVMAddBasicAliasAnalysisPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddUnifyFunctionExitNodesPass(PM)
    @apicall(:LLVMAddUnifyFunctionExitNodesPass, Cvoid, (LLVMPassManagerRef,), PM)
end
# Julia wrapper for header: Utils.h
# Automatically generated using Clang.jl


function LLVMAddLowerSwitchPass(PM)
    @apicall(:LLVMAddLowerSwitchPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddPromoteMemoryToRegisterPass(PM)
    @apicall(:LLVMAddPromoteMemoryToRegisterPass, Cvoid, (LLVMPassManagerRef,), PM)
end
# Julia wrapper for header: Vectorize.h
# Automatically generated using Clang.jl


function LLVMAddLoopVectorizePass(PM)
    @apicall(:LLVMAddLoopVectorizePass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddSLPVectorizePass(PM)
    @apicall(:LLVMAddSLPVectorizePass, Cvoid, (LLVMPassManagerRef,), PM)
end
