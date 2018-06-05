# Julia wrapper for header: llvm-c/ErrorHandling.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMInstallFatalErrorHandler(Handler::LLVMFatalErrorHandler)
    @apicall(:LLVMInstallFatalErrorHandler, Cvoid, (LLVMFatalErrorHandler,), Handler)
end

function LLVMResetFatalErrorHandler()
    @apicall(:LLVMResetFatalErrorHandler, Cvoid, ())
end

function LLVMEnablePrettyStackTrace()
    @apicall(:LLVMEnablePrettyStackTrace, Cvoid, ())
end


# Julia wrapper for header: llvm-c/Object.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMCreateObjectFile(MemBuf::LLVMMemoryBufferRef)
    @apicall(:LLVMCreateObjectFile, LLVMObjectFileRef, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMDisposeObjectFile(ObjectFile::LLVMObjectFileRef)
    @apicall(:LLVMDisposeObjectFile, Cvoid, (LLVMObjectFileRef,), ObjectFile)
end

function LLVMGetSections(ObjectFile::LLVMObjectFileRef)
    @apicall(:LLVMGetSections, LLVMSectionIteratorRef, (LLVMObjectFileRef,), ObjectFile)
end

function LLVMDisposeSectionIterator(SI::LLVMSectionIteratorRef)
    @apicall(:LLVMDisposeSectionIterator, Cvoid, (LLVMSectionIteratorRef,), SI)
end

function LLVMIsSectionIteratorAtEnd(ObjectFile::LLVMObjectFileRef, SI::LLVMSectionIteratorRef)
    @apicall(:LLVMIsSectionIteratorAtEnd, LLVMBool, (LLVMObjectFileRef, LLVMSectionIteratorRef), ObjectFile, SI)
end

function LLVMMoveToNextSection(SI::LLVMSectionIteratorRef)
    @apicall(:LLVMMoveToNextSection, Cvoid, (LLVMSectionIteratorRef,), SI)
end

function LLVMMoveToContainingSection(Sect::LLVMSectionIteratorRef, Sym::LLVMSymbolIteratorRef)
    @apicall(:LLVMMoveToContainingSection, Cvoid, (LLVMSectionIteratorRef, LLVMSymbolIteratorRef), Sect, Sym)
end

function LLVMGetSymbols(ObjectFile::LLVMObjectFileRef)
    @apicall(:LLVMGetSymbols, LLVMSymbolIteratorRef, (LLVMObjectFileRef,), ObjectFile)
end

function LLVMDisposeSymbolIterator(SI::LLVMSymbolIteratorRef)
    @apicall(:LLVMDisposeSymbolIterator, Cvoid, (LLVMSymbolIteratorRef,), SI)
end

function LLVMIsSymbolIteratorAtEnd(ObjectFile::LLVMObjectFileRef, SI::LLVMSymbolIteratorRef)
    @apicall(:LLVMIsSymbolIteratorAtEnd, LLVMBool, (LLVMObjectFileRef, LLVMSymbolIteratorRef), ObjectFile, SI)
end

function LLVMMoveToNextSymbol(SI::LLVMSymbolIteratorRef)
    @apicall(:LLVMMoveToNextSymbol, Cvoid, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetSectionName(SI::LLVMSectionIteratorRef)
    @apicall(:LLVMGetSectionName, Cstring, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionSize(SI::LLVMSectionIteratorRef)
    @apicall(:LLVMGetSectionSize, UInt64, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionContents(SI::LLVMSectionIteratorRef)
    @apicall(:LLVMGetSectionContents, Cstring, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionAddress(SI::LLVMSectionIteratorRef)
    @apicall(:LLVMGetSectionAddress, UInt64, (LLVMSectionIteratorRef,), SI)
end

function LLVMGetSectionContainsSymbol(SI::LLVMSectionIteratorRef, Sym::LLVMSymbolIteratorRef)
    @apicall(:LLVMGetSectionContainsSymbol, LLVMBool, (LLVMSectionIteratorRef, LLVMSymbolIteratorRef), SI, Sym)
end

function LLVMGetRelocations(Section::LLVMSectionIteratorRef)
    @apicall(:LLVMGetRelocations, LLVMRelocationIteratorRef, (LLVMSectionIteratorRef,), Section)
end

function LLVMDisposeRelocationIterator(RI::LLVMRelocationIteratorRef)
    @apicall(:LLVMDisposeRelocationIterator, Cvoid, (LLVMRelocationIteratorRef,), RI)
end

function LLVMIsRelocationIteratorAtEnd(Section::LLVMSectionIteratorRef, RI::LLVMRelocationIteratorRef)
    @apicall(:LLVMIsRelocationIteratorAtEnd, LLVMBool, (LLVMSectionIteratorRef, LLVMRelocationIteratorRef), Section, RI)
end

function LLVMMoveToNextRelocation(RI::LLVMRelocationIteratorRef)
    @apicall(:LLVMMoveToNextRelocation, Cvoid, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetSymbolName(SI::LLVMSymbolIteratorRef)
    @apicall(:LLVMGetSymbolName, Cstring, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetSymbolAddress(SI::LLVMSymbolIteratorRef)
    @apicall(:LLVMGetSymbolAddress, UInt64, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetSymbolSize(SI::LLVMSymbolIteratorRef)
    @apicall(:LLVMGetSymbolSize, UInt64, (LLVMSymbolIteratorRef,), SI)
end

function LLVMGetRelocationOffset(RI::LLVMRelocationIteratorRef)
    @apicall(:LLVMGetRelocationOffset, UInt64, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationSymbol(RI::LLVMRelocationIteratorRef)
    @apicall(:LLVMGetRelocationSymbol, LLVMSymbolIteratorRef, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationType(RI::LLVMRelocationIteratorRef)
    @apicall(:LLVMGetRelocationType, UInt64, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationTypeName(RI::LLVMRelocationIteratorRef)
    @apicall(:LLVMGetRelocationTypeName, Cstring, (LLVMRelocationIteratorRef,), RI)
end

function LLVMGetRelocationValueString(RI::LLVMRelocationIteratorRef)
    @apicall(:LLVMGetRelocationValueString, Cstring, (LLVMRelocationIteratorRef,), RI)
end


# Julia wrapper for header: llvm-c/Target.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMGetModuleDataLayout(M::LLVMModuleRef)
    @apicall(:LLVMGetModuleDataLayout, LLVMTargetDataRef, (LLVMModuleRef,), M)
end

function LLVMSetModuleDataLayout(M::LLVMModuleRef, DL::LLVMTargetDataRef)
    @apicall(:LLVMSetModuleDataLayout, Cvoid, (LLVMModuleRef, LLVMTargetDataRef), M, DL)
end

function LLVMCreateTargetData(StringRep)
    @apicall(:LLVMCreateTargetData, LLVMTargetDataRef, (Cstring,), StringRep)
end

function LLVMDisposeTargetData(TD::LLVMTargetDataRef)
    @apicall(:LLVMDisposeTargetData, Cvoid, (LLVMTargetDataRef,), TD)
end

function LLVMAddTargetLibraryInfo(TLI::LLVMTargetLibraryInfoRef, PM::LLVMPassManagerRef)
    @apicall(:LLVMAddTargetLibraryInfo, Cvoid, (LLVMTargetLibraryInfoRef, LLVMPassManagerRef), TLI, PM)
end

function LLVMCopyStringRepOfTargetData(TD::LLVMTargetDataRef)
    @apicall(:LLVMCopyStringRepOfTargetData, Cstring, (LLVMTargetDataRef,), TD)
end

function LLVMByteOrder(TD::LLVMTargetDataRef)
    @apicall(:LLVMByteOrder, Cint, (LLVMTargetDataRef,), TD)
end

function LLVMPointerSize(TD::LLVMTargetDataRef)
    @apicall(:LLVMPointerSize, UInt32, (LLVMTargetDataRef,), TD)
end

function LLVMPointerSizeForAS(TD::LLVMTargetDataRef, AS::UInt32)
    @apicall(:LLVMPointerSizeForAS, UInt32, (LLVMTargetDataRef, UInt32), TD, AS)
end

function LLVMIntPtrType(TD::LLVMTargetDataRef)
    @apicall(:LLVMIntPtrType, LLVMTypeRef, (LLVMTargetDataRef,), TD)
end

function LLVMIntPtrTypeForAS(TD::LLVMTargetDataRef, AS::UInt32)
    @apicall(:LLVMIntPtrTypeForAS, LLVMTypeRef, (LLVMTargetDataRef, UInt32), TD, AS)
end

function LLVMIntPtrTypeInContext(C::LLVMContextRef, TD::LLVMTargetDataRef)
    @apicall(:LLVMIntPtrTypeInContext, LLVMTypeRef, (LLVMContextRef, LLVMTargetDataRef), C, TD)
end

function LLVMIntPtrTypeForASInContext(C::LLVMContextRef, TD::LLVMTargetDataRef, AS::UInt32)
    @apicall(:LLVMIntPtrTypeForASInContext, LLVMTypeRef, (LLVMContextRef, LLVMTargetDataRef, UInt32), C, TD, AS)
end

function LLVMSizeOfTypeInBits(TD::LLVMTargetDataRef, Ty::LLVMTypeRef)
    @apicall(:LLVMSizeOfTypeInBits, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMStoreSizeOfType(TD::LLVMTargetDataRef, Ty::LLVMTypeRef)
    @apicall(:LLVMStoreSizeOfType, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMABISizeOfType(TD::LLVMTargetDataRef, Ty::LLVMTypeRef)
    @apicall(:LLVMABISizeOfType, Culonglong, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMABIAlignmentOfType(TD::LLVMTargetDataRef, Ty::LLVMTypeRef)
    @apicall(:LLVMABIAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMCallFrameAlignmentOfType(TD::LLVMTargetDataRef, Ty::LLVMTypeRef)
    @apicall(:LLVMCallFrameAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMPreferredAlignmentOfType(TD::LLVMTargetDataRef, Ty::LLVMTypeRef)
    @apicall(:LLVMPreferredAlignmentOfType, UInt32, (LLVMTargetDataRef, LLVMTypeRef), TD, Ty)
end

function LLVMPreferredAlignmentOfGlobal(TD::LLVMTargetDataRef, GlobalVar::LLVMValueRef)
    @apicall(:LLVMPreferredAlignmentOfGlobal, UInt32, (LLVMTargetDataRef, LLVMValueRef), TD, GlobalVar)
end

function LLVMElementAtOffset(TD::LLVMTargetDataRef, StructTy::LLVMTypeRef, Offset::Culonglong)
    @apicall(:LLVMElementAtOffset, UInt32, (LLVMTargetDataRef, LLVMTypeRef, Culonglong), TD, StructTy, Offset)
end

function LLVMOffsetOfElement(TD::LLVMTargetDataRef, StructTy::LLVMTypeRef, Element::UInt32)
    @apicall(:LLVMOffsetOfElement, Culonglong, (LLVMTargetDataRef, LLVMTypeRef, UInt32), TD, StructTy, Element)
end


# Julia wrapper for header: llvm-c/TargetMachine.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMGetFirstTarget()
    @apicall(:LLVMGetFirstTarget, LLVMTargetRef, ())
end

function LLVMGetNextTarget(T::LLVMTargetRef)
    @apicall(:LLVMGetNextTarget, LLVMTargetRef, (LLVMTargetRef,), T)
end

function LLVMGetTargetFromName(Name)
    @apicall(:LLVMGetTargetFromName, LLVMTargetRef, (Cstring,), Name)
end

function LLVMGetTargetFromTriple(Triple, T, ErrorMessage)
    @apicall(:LLVMGetTargetFromTriple, LLVMBool, (Cstring, Ptr{LLVMTargetRef}, Ptr{Cstring}), Triple, T, ErrorMessage)
end

function LLVMGetTargetName(T::LLVMTargetRef)
    @apicall(:LLVMGetTargetName, Cstring, (LLVMTargetRef,), T)
end

function LLVMGetTargetDescription(T::LLVMTargetRef)
    @apicall(:LLVMGetTargetDescription, Cstring, (LLVMTargetRef,), T)
end

function LLVMTargetHasJIT(T::LLVMTargetRef)
    @apicall(:LLVMTargetHasJIT, LLVMBool, (LLVMTargetRef,), T)
end

function LLVMTargetHasTargetMachine(T::LLVMTargetRef)
    @apicall(:LLVMTargetHasTargetMachine, LLVMBool, (LLVMTargetRef,), T)
end

function LLVMTargetHasAsmBackend(T::LLVMTargetRef)
    @apicall(:LLVMTargetHasAsmBackend, LLVMBool, (LLVMTargetRef,), T)
end

function LLVMCreateTargetMachine(T::LLVMTargetRef, Triple, CPU, Features, Level::LLVMCodeGenOptLevel, Reloc::LLVMRelocMode, CodeModel::LLVMCodeModel)
    @apicall(:LLVMCreateTargetMachine, LLVMTargetMachineRef, (LLVMTargetRef, Cstring, Cstring, Cstring, LLVMCodeGenOptLevel, LLVMRelocMode, LLVMCodeModel), T, Triple, CPU, Features, Level, Reloc, CodeModel)
end

function LLVMDisposeTargetMachine(T::LLVMTargetMachineRef)
    @apicall(:LLVMDisposeTargetMachine, Cvoid, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineTarget(T::LLVMTargetMachineRef)
    @apicall(:LLVMGetTargetMachineTarget, LLVMTargetRef, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineTriple(T::LLVMTargetMachineRef)
    @apicall(:LLVMGetTargetMachineTriple, Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineCPU(T::LLVMTargetMachineRef)
    @apicall(:LLVMGetTargetMachineCPU, Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMGetTargetMachineFeatureString(T::LLVMTargetMachineRef)
    @apicall(:LLVMGetTargetMachineFeatureString, Cstring, (LLVMTargetMachineRef,), T)
end

function LLVMCreateTargetDataLayout(T::LLVMTargetMachineRef)
    @apicall(:LLVMCreateTargetDataLayout, LLVMTargetDataRef, (LLVMTargetMachineRef,), T)
end

function LLVMSetTargetMachineAsmVerbosity(T::LLVMTargetMachineRef, VerboseAsm::LLVMBool)
    @apicall(:LLVMSetTargetMachineAsmVerbosity, Cvoid, (LLVMTargetMachineRef, LLVMBool), T, VerboseAsm)
end

function LLVMTargetMachineEmitToFile(T::LLVMTargetMachineRef, M::LLVMModuleRef, Filename, codegen::LLVMCodeGenFileType, ErrorMessage)
    @apicall(:LLVMTargetMachineEmitToFile, LLVMBool, (LLVMTargetMachineRef, LLVMModuleRef, Cstring, LLVMCodeGenFileType, Ptr{Cstring}), T, M, Filename, codegen, ErrorMessage)
end

function LLVMTargetMachineEmitToMemoryBuffer(T::LLVMTargetMachineRef, M::LLVMModuleRef, codegen::LLVMCodeGenFileType, ErrorMessage, OutMemBuf)
    @apicall(:LLVMTargetMachineEmitToMemoryBuffer, LLVMBool, (LLVMTargetMachineRef, LLVMModuleRef, LLVMCodeGenFileType, Ptr{Cstring}, Ptr{LLVMMemoryBufferRef}), T, M, codegen, ErrorMessage, OutMemBuf)
end

function LLVMGetDefaultTargetTriple()
    @apicall(:LLVMGetDefaultTargetTriple, Cstring, ())
end

function LLVMAddAnalysisPasses(T::LLVMTargetMachineRef, PM::LLVMPassManagerRef)
    @apicall(:LLVMAddAnalysisPasses, Cvoid, (LLVMTargetMachineRef, LLVMPassManagerRef), T, PM)
end


# Julia wrapper for header: llvm-c/Types.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0


# Julia wrapper for header: llvm-c/Analysis.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMVerifyModule(M::LLVMModuleRef, Action::LLVMVerifierFailureAction, OutMessage)
    @apicall(:LLVMVerifyModule, LLVMBool, (LLVMModuleRef, LLVMVerifierFailureAction, Ptr{Cstring}), M, Action, OutMessage)
end

function LLVMVerifyFunction(Fn::LLVMValueRef, Action::LLVMVerifierFailureAction)
    @apicall(:LLVMVerifyFunction, LLVMBool, (LLVMValueRef, LLVMVerifierFailureAction), Fn, Action)
end

function LLVMViewFunctionCFG(Fn::LLVMValueRef)
    @apicall(:LLVMViewFunctionCFG, Cvoid, (LLVMValueRef,), Fn)
end

function LLVMViewFunctionCFGOnly(Fn::LLVMValueRef)
    @apicall(:LLVMViewFunctionCFGOnly, Cvoid, (LLVMValueRef,), Fn)
end


# Julia wrapper for header: llvm-c/BitReader.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMParseBitcode(MemBuf::LLVMMemoryBufferRef, OutModule, OutMessage)
    @apicall(:LLVMParseBitcode, LLVMBool, (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), MemBuf, OutModule, OutMessage)
end

function LLVMParseBitcode2(MemBuf::LLVMMemoryBufferRef, OutModule)
    @apicall(:LLVMParseBitcode2, LLVMBool, (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}), MemBuf, OutModule)
end

function LLVMParseBitcodeInContext(ContextRef::LLVMContextRef, MemBuf::LLVMMemoryBufferRef, OutModule, OutMessage)
    @apicall(:LLVMParseBitcodeInContext, LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), ContextRef, MemBuf, OutModule, OutMessage)
end

function LLVMParseBitcodeInContext2(ContextRef::LLVMContextRef, MemBuf::LLVMMemoryBufferRef, OutModule)
    @apicall(:LLVMParseBitcodeInContext2, LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}), ContextRef, MemBuf, OutModule)
end

function LLVMGetBitcodeModuleInContext(ContextRef::LLVMContextRef, MemBuf::LLVMMemoryBufferRef, OutM, OutMessage)
    @apicall(:LLVMGetBitcodeModuleInContext, LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), ContextRef, MemBuf, OutM, OutMessage)
end

function LLVMGetBitcodeModuleInContext2(ContextRef::LLVMContextRef, MemBuf::LLVMMemoryBufferRef, OutM)
    @apicall(:LLVMGetBitcodeModuleInContext2, LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}), ContextRef, MemBuf, OutM)
end

function LLVMGetBitcodeModule(MemBuf::LLVMMemoryBufferRef, OutM, OutMessage)
    @apicall(:LLVMGetBitcodeModule, LLVMBool, (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), MemBuf, OutM, OutMessage)
end

function LLVMGetBitcodeModule2(MemBuf::LLVMMemoryBufferRef, OutM)
    @apicall(:LLVMGetBitcodeModule2, LLVMBool, (LLVMMemoryBufferRef, Ptr{LLVMModuleRef}), MemBuf, OutM)
end


# Julia wrapper for header: llvm-c/BitWriter.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMWriteBitcodeToFile(M::LLVMModuleRef, Path)
    @apicall(:LLVMWriteBitcodeToFile, Cint, (LLVMModuleRef, Cstring), M, Path)
end

function LLVMWriteBitcodeToFD(M::LLVMModuleRef, FD::Cint, ShouldClose::Cint, Unbuffered::Cint)
    @apicall(:LLVMWriteBitcodeToFD, Cint, (LLVMModuleRef, Cint, Cint, Cint), M, FD, ShouldClose, Unbuffered)
end

function LLVMWriteBitcodeToFileHandle(M::LLVMModuleRef, Handle::Cint)
    @apicall(:LLVMWriteBitcodeToFileHandle, Cint, (LLVMModuleRef, Cint), M, Handle)
end

function LLVMWriteBitcodeToMemoryBuffer(M::LLVMModuleRef)
    @apicall(:LLVMWriteBitcodeToMemoryBuffer, LLVMMemoryBufferRef, (LLVMModuleRef,), M)
end


# Julia wrapper for header: llvm-c/Core.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

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

function LLVMContextSetDiagnosticHandler(C::LLVMContextRef, Handler::LLVMDiagnosticHandler, DiagnosticContext)
    @apicall(:LLVMContextSetDiagnosticHandler, Cvoid, (LLVMContextRef, LLVMDiagnosticHandler, Ptr{Cvoid}), C, Handler, DiagnosticContext)
end

function LLVMContextGetDiagnosticHandler(C::LLVMContextRef)
    @apicall(:LLVMContextGetDiagnosticHandler, LLVMDiagnosticHandler, (LLVMContextRef,), C)
end

function LLVMContextGetDiagnosticContext(C::LLVMContextRef)
    @apicall(:LLVMContextGetDiagnosticContext, Ptr{Cvoid}, (LLVMContextRef,), C)
end

function LLVMContextSetYieldCallback(C::LLVMContextRef, Callback::LLVMYieldCallback, OpaqueHandle)
    @apicall(:LLVMContextSetYieldCallback, Cvoid, (LLVMContextRef, LLVMYieldCallback, Ptr{Cvoid}), C, Callback, OpaqueHandle)
end

function LLVMContextDispose(C::LLVMContextRef)
    @apicall(:LLVMContextDispose, Cvoid, (LLVMContextRef,), C)
end

function LLVMGetDiagInfoDescription(DI::LLVMDiagnosticInfoRef)
    @apicall(:LLVMGetDiagInfoDescription, Cstring, (LLVMDiagnosticInfoRef,), DI)
end

function LLVMGetDiagInfoSeverity(DI::LLVMDiagnosticInfoRef)
    @apicall(:LLVMGetDiagInfoSeverity, LLVMDiagnosticSeverity, (LLVMDiagnosticInfoRef,), DI)
end

function LLVMGetMDKindIDInContext(C::LLVMContextRef, Name, SLen::UInt32)
    @apicall(:LLVMGetMDKindIDInContext, UInt32, (LLVMContextRef, Cstring, UInt32), C, Name, SLen)
end

function LLVMGetMDKindID(Name, SLen::UInt32)
    @apicall(:LLVMGetMDKindID, UInt32, (Cstring, UInt32), Name, SLen)
end

function LLVMGetEnumAttributeKindForName(Name, SLen::Csize_t)
    @apicall(:LLVMGetEnumAttributeKindForName, UInt32, (Cstring, Csize_t), Name, SLen)
end

function LLVMGetLastEnumAttributeKind()
    @apicall(:LLVMGetLastEnumAttributeKind, UInt32, ())
end

function LLVMCreateEnumAttribute(C::LLVMContextRef, KindID::UInt32, Val::UInt64)
    @apicall(:LLVMCreateEnumAttribute, LLVMAttributeRef, (LLVMContextRef, UInt32, UInt64), C, KindID, Val)
end

function LLVMGetEnumAttributeKind(A::LLVMAttributeRef)
    @apicall(:LLVMGetEnumAttributeKind, UInt32, (LLVMAttributeRef,), A)
end

function LLVMGetEnumAttributeValue(A::LLVMAttributeRef)
    @apicall(:LLVMGetEnumAttributeValue, UInt64, (LLVMAttributeRef,), A)
end

function LLVMCreateStringAttribute(C::LLVMContextRef, K, KLength::UInt32, V, VLength::UInt32)
    @apicall(:LLVMCreateStringAttribute, LLVMAttributeRef, (LLVMContextRef, Cstring, UInt32, Cstring, UInt32), C, K, KLength, V, VLength)
end

function LLVMGetStringAttributeKind(A::LLVMAttributeRef, Length)
    @apicall(:LLVMGetStringAttributeKind, Cstring, (LLVMAttributeRef, Ptr{UInt32}), A, Length)
end

function LLVMGetStringAttributeValue(A::LLVMAttributeRef, Length)
    @apicall(:LLVMGetStringAttributeValue, Cstring, (LLVMAttributeRef, Ptr{UInt32}), A, Length)
end

function LLVMIsEnumAttribute(A::LLVMAttributeRef)
    @apicall(:LLVMIsEnumAttribute, LLVMBool, (LLVMAttributeRef,), A)
end

function LLVMIsStringAttribute(A::LLVMAttributeRef)
    @apicall(:LLVMIsStringAttribute, LLVMBool, (LLVMAttributeRef,), A)
end

function LLVMModuleCreateWithName(ModuleID)
    @apicall(:LLVMModuleCreateWithName, LLVMModuleRef, (Cstring,), ModuleID)
end

function LLVMModuleCreateWithNameInContext(ModuleID, C::LLVMContextRef)
    @apicall(:LLVMModuleCreateWithNameInContext, LLVMModuleRef, (Cstring, LLVMContextRef), ModuleID, C)
end

function LLVMCloneModule(M::LLVMModuleRef)
    @apicall(:LLVMCloneModule, LLVMModuleRef, (LLVMModuleRef,), M)
end

function LLVMDisposeModule(M::LLVMModuleRef)
    @apicall(:LLVMDisposeModule, Cvoid, (LLVMModuleRef,), M)
end

function LLVMGetModuleIdentifier(M::LLVMModuleRef, Len)
    @apicall(:LLVMGetModuleIdentifier, Cstring, (LLVMModuleRef, Ptr{Csize_t}), M, Len)
end

function LLVMSetModuleIdentifier(M::LLVMModuleRef, Ident, Len::Csize_t)
    @apicall(:LLVMSetModuleIdentifier, Cvoid, (LLVMModuleRef, Cstring, Csize_t), M, Ident, Len)
end

function LLVMGetDataLayoutStr(M::LLVMModuleRef)
    @apicall(:LLVMGetDataLayoutStr, Cstring, (LLVMModuleRef,), M)
end

function LLVMGetDataLayout(M::LLVMModuleRef)
    @apicall(:LLVMGetDataLayout, Cstring, (LLVMModuleRef,), M)
end

function LLVMSetDataLayout(M::LLVMModuleRef, DataLayoutStr)
    @apicall(:LLVMSetDataLayout, Cvoid, (LLVMModuleRef, Cstring), M, DataLayoutStr)
end

function LLVMGetTarget(M::LLVMModuleRef)
    @apicall(:LLVMGetTarget, Cstring, (LLVMModuleRef,), M)
end

function LLVMSetTarget(M::LLVMModuleRef, Triple)
    @apicall(:LLVMSetTarget, Cvoid, (LLVMModuleRef, Cstring), M, Triple)
end

function LLVMDumpModule(M::LLVMModuleRef)
    @apicall(:LLVMDumpModule, Cvoid, (LLVMModuleRef,), M)
end

function LLVMPrintModuleToFile(M::LLVMModuleRef, Filename, ErrorMessage)
    @apicall(:LLVMPrintModuleToFile, LLVMBool, (LLVMModuleRef, Cstring, Ptr{Cstring}), M, Filename, ErrorMessage)
end

function LLVMPrintModuleToString(M::LLVMModuleRef)
    @apicall(:LLVMPrintModuleToString, Cstring, (LLVMModuleRef,), M)
end

function LLVMSetModuleInlineAsm(M::LLVMModuleRef, Asm)
    @apicall(:LLVMSetModuleInlineAsm, Cvoid, (LLVMModuleRef, Cstring), M, Asm)
end

function LLVMGetModuleContext(M::LLVMModuleRef)
    @apicall(:LLVMGetModuleContext, LLVMContextRef, (LLVMModuleRef,), M)
end

function LLVMGetTypeByName(M::LLVMModuleRef, Name)
    @apicall(:LLVMGetTypeByName, LLVMTypeRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetNamedMetadataNumOperands(M::LLVMModuleRef, Name)
    @apicall(:LLVMGetNamedMetadataNumOperands, UInt32, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetNamedMetadataOperands(M::LLVMModuleRef, Name, Dest)
    @apicall(:LLVMGetNamedMetadataOperands, Cvoid, (LLVMModuleRef, Cstring, Ptr{LLVMValueRef}), M, Name, Dest)
end

function LLVMAddNamedMetadataOperand(M::LLVMModuleRef, Name, Val::LLVMValueRef)
    @apicall(:LLVMAddNamedMetadataOperand, Cvoid, (LLVMModuleRef, Cstring, LLVMValueRef), M, Name, Val)
end

function LLVMAddFunction(M::LLVMModuleRef, Name, FunctionTy::LLVMTypeRef)
    @apicall(:LLVMAddFunction, LLVMValueRef, (LLVMModuleRef, Cstring, LLVMTypeRef), M, Name, FunctionTy)
end

function LLVMGetNamedFunction(M::LLVMModuleRef, Name)
    @apicall(:LLVMGetNamedFunction, LLVMValueRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetFirstFunction(M::LLVMModuleRef)
    @apicall(:LLVMGetFirstFunction, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastFunction(M::LLVMModuleRef)
    @apicall(:LLVMGetLastFunction, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextFunction(Fn::LLVMValueRef)
    @apicall(:LLVMGetNextFunction, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetPreviousFunction(Fn::LLVMValueRef)
    @apicall(:LLVMGetPreviousFunction, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetTypeKind(Ty::LLVMTypeRef)
    @apicall(:LLVMGetTypeKind, LLVMTypeKind, (LLVMTypeRef,), Ty)
end

function LLVMTypeIsSized(Ty::LLVMTypeRef)
    @apicall(:LLVMTypeIsSized, LLVMBool, (LLVMTypeRef,), Ty)
end

function LLVMGetTypeContext(Ty::LLVMTypeRef)
    @apicall(:LLVMGetTypeContext, LLVMContextRef, (LLVMTypeRef,), Ty)
end

function LLVMDumpType(Val::LLVMTypeRef)
    @apicall(:LLVMDumpType, Cvoid, (LLVMTypeRef,), Val)
end

function LLVMPrintTypeToString(Val::LLVMTypeRef)
    @apicall(:LLVMPrintTypeToString, Cstring, (LLVMTypeRef,), Val)
end

function LLVMInt1TypeInContext(C::LLVMContextRef)
    @apicall(:LLVMInt1TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt8TypeInContext(C::LLVMContextRef)
    @apicall(:LLVMInt8TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt16TypeInContext(C::LLVMContextRef)
    @apicall(:LLVMInt16TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt32TypeInContext(C::LLVMContextRef)
    @apicall(:LLVMInt32TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt64TypeInContext(C::LLVMContextRef)
    @apicall(:LLVMInt64TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMInt128TypeInContext(C::LLVMContextRef)
    @apicall(:LLVMInt128TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMIntTypeInContext(C::LLVMContextRef, NumBits::UInt32)
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

function LLVMIntType(NumBits::UInt32)
    @apicall(:LLVMIntType, LLVMTypeRef, (UInt32,), NumBits)
end

function LLVMGetIntTypeWidth(IntegerTy::LLVMTypeRef)
    @apicall(:LLVMGetIntTypeWidth, UInt32, (LLVMTypeRef,), IntegerTy)
end

function LLVMHalfTypeInContext(C::LLVMContextRef)
    @apicall(:LLVMHalfTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMFloatTypeInContext(C::LLVMContextRef)
    @apicall(:LLVMFloatTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMDoubleTypeInContext(C::LLVMContextRef)
    @apicall(:LLVMDoubleTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMX86FP80TypeInContext(C::LLVMContextRef)
    @apicall(:LLVMX86FP80TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMFP128TypeInContext(C::LLVMContextRef)
    @apicall(:LLVMFP128TypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMPPCFP128TypeInContext(C::LLVMContextRef)
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

function LLVMFunctionType(ReturnType::LLVMTypeRef, ParamTypes, ParamCount::UInt32, IsVarArg::LLVMBool)
    @apicall(:LLVMFunctionType, LLVMTypeRef, (LLVMTypeRef, Ptr{LLVMTypeRef}, UInt32, LLVMBool), ReturnType, ParamTypes, ParamCount, IsVarArg)
end

function LLVMIsFunctionVarArg(FunctionTy::LLVMTypeRef)
    @apicall(:LLVMIsFunctionVarArg, LLVMBool, (LLVMTypeRef,), FunctionTy)
end

function LLVMGetReturnType(FunctionTy::LLVMTypeRef)
    @apicall(:LLVMGetReturnType, LLVMTypeRef, (LLVMTypeRef,), FunctionTy)
end

function LLVMCountParamTypes(FunctionTy::LLVMTypeRef)
    @apicall(:LLVMCountParamTypes, UInt32, (LLVMTypeRef,), FunctionTy)
end

function LLVMGetParamTypes(FunctionTy::LLVMTypeRef, Dest)
    @apicall(:LLVMGetParamTypes, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), FunctionTy, Dest)
end

function LLVMStructTypeInContext(C::LLVMContextRef, ElementTypes, ElementCount::UInt32, Packed::LLVMBool)
    @apicall(:LLVMStructTypeInContext, LLVMTypeRef, (LLVMContextRef, Ptr{LLVMTypeRef}, UInt32, LLVMBool), C, ElementTypes, ElementCount, Packed)
end

function LLVMStructType(ElementTypes, ElementCount::UInt32, Packed::LLVMBool)
    @apicall(:LLVMStructType, LLVMTypeRef, (Ptr{LLVMTypeRef}, UInt32, LLVMBool), ElementTypes, ElementCount, Packed)
end

function LLVMStructCreateNamed(C::LLVMContextRef, Name)
    @apicall(:LLVMStructCreateNamed, LLVMTypeRef, (LLVMContextRef, Cstring), C, Name)
end

function LLVMGetStructName(Ty::LLVMTypeRef)
    @apicall(:LLVMGetStructName, Cstring, (LLVMTypeRef,), Ty)
end

function LLVMStructSetBody(StructTy::LLVMTypeRef, ElementTypes, ElementCount::UInt32, Packed::LLVMBool)
    @apicall(:LLVMStructSetBody, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}, UInt32, LLVMBool), StructTy, ElementTypes, ElementCount, Packed)
end

function LLVMCountStructElementTypes(StructTy::LLVMTypeRef)
    @apicall(:LLVMCountStructElementTypes, UInt32, (LLVMTypeRef,), StructTy)
end

function LLVMGetStructElementTypes(StructTy::LLVMTypeRef, Dest)
    @apicall(:LLVMGetStructElementTypes, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), StructTy, Dest)
end

function LLVMStructGetTypeAtIndex(StructTy::LLVMTypeRef, i::UInt32)
    @apicall(:LLVMStructGetTypeAtIndex, LLVMTypeRef, (LLVMTypeRef, UInt32), StructTy, i)
end

function LLVMIsPackedStruct(StructTy::LLVMTypeRef)
    @apicall(:LLVMIsPackedStruct, LLVMBool, (LLVMTypeRef,), StructTy)
end

function LLVMIsOpaqueStruct(StructTy::LLVMTypeRef)
    @apicall(:LLVMIsOpaqueStruct, LLVMBool, (LLVMTypeRef,), StructTy)
end

function LLVMGetElementType(Ty::LLVMTypeRef)
    @apicall(:LLVMGetElementType, LLVMTypeRef, (LLVMTypeRef,), Ty)
end

function LLVMGetSubtypes(Tp::LLVMTypeRef, Arr)
    @apicall(:LLVMGetSubtypes, Cvoid, (LLVMTypeRef, Ptr{LLVMTypeRef}), Tp, Arr)
end

function LLVMGetNumContainedTypes(Tp::LLVMTypeRef)
    @apicall(:LLVMGetNumContainedTypes, UInt32, (LLVMTypeRef,), Tp)
end

function LLVMArrayType(ElementType::LLVMTypeRef, ElementCount::UInt32)
    @apicall(:LLVMArrayType, LLVMTypeRef, (LLVMTypeRef, UInt32), ElementType, ElementCount)
end

function LLVMGetArrayLength(ArrayTy::LLVMTypeRef)
    @apicall(:LLVMGetArrayLength, UInt32, (LLVMTypeRef,), ArrayTy)
end

function LLVMPointerType(ElementType::LLVMTypeRef, AddressSpace::UInt32)
    @apicall(:LLVMPointerType, LLVMTypeRef, (LLVMTypeRef, UInt32), ElementType, AddressSpace)
end

function LLVMGetPointerAddressSpace(PointerTy::LLVMTypeRef)
    @apicall(:LLVMGetPointerAddressSpace, UInt32, (LLVMTypeRef,), PointerTy)
end

function LLVMVectorType(ElementType::LLVMTypeRef, ElementCount::UInt32)
    @apicall(:LLVMVectorType, LLVMTypeRef, (LLVMTypeRef, UInt32), ElementType, ElementCount)
end

function LLVMGetVectorSize(VectorTy::LLVMTypeRef)
    @apicall(:LLVMGetVectorSize, UInt32, (LLVMTypeRef,), VectorTy)
end

function LLVMVoidTypeInContext(C::LLVMContextRef)
    @apicall(:LLVMVoidTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMLabelTypeInContext(C::LLVMContextRef)
    @apicall(:LLVMLabelTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMX86MMXTypeInContext(C::LLVMContextRef)
    @apicall(:LLVMX86MMXTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMTokenTypeInContext(C::LLVMContextRef)
    @apicall(:LLVMTokenTypeInContext, LLVMTypeRef, (LLVMContextRef,), C)
end

function LLVMMetadataTypeInContext(C::LLVMContextRef)
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

function LLVMTypeOf(Val::LLVMValueRef)
    @apicall(:LLVMTypeOf, LLVMTypeRef, (LLVMValueRef,), Val)
end

function LLVMGetValueKind(Val::LLVMValueRef)
    @apicall(:LLVMGetValueKind, LLVMValueKind, (LLVMValueRef,), Val)
end

function LLVMGetValueName(Val::LLVMValueRef)
    @apicall(:LLVMGetValueName, Cstring, (LLVMValueRef,), Val)
end

function LLVMSetValueName(Val::LLVMValueRef, Name)
    @apicall(:LLVMSetValueName, Cvoid, (LLVMValueRef, Cstring), Val, Name)
end

function LLVMDumpValue(Val::LLVMValueRef)
    @apicall(:LLVMDumpValue, Cvoid, (LLVMValueRef,), Val)
end

function LLVMPrintValueToString(Val::LLVMValueRef)
    @apicall(:LLVMPrintValueToString, Cstring, (LLVMValueRef,), Val)
end

function LLVMReplaceAllUsesWith(OldVal::LLVMValueRef, NewVal::LLVMValueRef)
    @apicall(:LLVMReplaceAllUsesWith, Cvoid, (LLVMValueRef, LLVMValueRef), OldVal, NewVal)
end

function LLVMIsConstant(Val::LLVMValueRef)
    @apicall(:LLVMIsConstant, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMIsUndef(Val::LLVMValueRef)
    @apicall(:LLVMIsUndef, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMIsAArgument(Val::LLVMValueRef)
    @apicall(:LLVMIsAArgument, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABasicBlock(Val::LLVMValueRef)
    @apicall(:LLVMIsABasicBlock, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInlineAsm(Val::LLVMValueRef)
    @apicall(:LLVMIsAInlineAsm, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUser(Val::LLVMValueRef)
    @apicall(:LLVMIsAUser, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstant(Val::LLVMValueRef)
    @apicall(:LLVMIsAConstant, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABlockAddress(Val::LLVMValueRef)
    @apicall(:LLVMIsABlockAddress, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantAggregateZero(Val::LLVMValueRef)
    @apicall(:LLVMIsAConstantAggregateZero, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantArray(Val::LLVMValueRef)
    @apicall(:LLVMIsAConstantArray, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataSequential(Val::LLVMValueRef)
    @apicall(:LLVMIsAConstantDataSequential, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataArray(Val::LLVMValueRef)
    @apicall(:LLVMIsAConstantDataArray, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantDataVector(Val::LLVMValueRef)
    @apicall(:LLVMIsAConstantDataVector, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantExpr(Val::LLVMValueRef)
    @apicall(:LLVMIsAConstantExpr, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantFP(Val::LLVMValueRef)
    @apicall(:LLVMIsAConstantFP, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantInt(Val::LLVMValueRef)
    @apicall(:LLVMIsAConstantInt, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantPointerNull(Val::LLVMValueRef)
    @apicall(:LLVMIsAConstantPointerNull, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantStruct(Val::LLVMValueRef)
    @apicall(:LLVMIsAConstantStruct, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantTokenNone(Val::LLVMValueRef)
    @apicall(:LLVMIsAConstantTokenNone, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAConstantVector(Val::LLVMValueRef)
    @apicall(:LLVMIsAConstantVector, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalValue(Val::LLVMValueRef)
    @apicall(:LLVMIsAGlobalValue, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalAlias(Val::LLVMValueRef)
    @apicall(:LLVMIsAGlobalAlias, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalObject(Val::LLVMValueRef)
    @apicall(:LLVMIsAGlobalObject, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFunction(Val::LLVMValueRef)
    @apicall(:LLVMIsAFunction, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGlobalVariable(Val::LLVMValueRef)
    @apicall(:LLVMIsAGlobalVariable, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUndefValue(Val::LLVMValueRef)
    @apicall(:LLVMIsAUndefValue, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInstruction(Val::LLVMValueRef)
    @apicall(:LLVMIsAInstruction, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABinaryOperator(Val::LLVMValueRef)
    @apicall(:LLVMIsABinaryOperator, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACallInst(Val::LLVMValueRef)
    @apicall(:LLVMIsACallInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIntrinsicInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAIntrinsicInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgInfoIntrinsic(Val::LLVMValueRef)
    @apicall(:LLVMIsADbgInfoIntrinsic, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsADbgDeclareInst(Val::LLVMValueRef)
    @apicall(:LLVMIsADbgDeclareInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemIntrinsic(Val::LLVMValueRef)
    @apicall(:LLVMIsAMemIntrinsic, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemCpyInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAMemCpyInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemMoveInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAMemMoveInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMemSetInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAMemSetInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACmpInst(Val::LLVMValueRef)
    @apicall(:LLVMIsACmpInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFCmpInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAFCmpInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAICmpInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAICmpInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAExtractElementInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAExtractElementInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAGetElementPtrInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAGetElementPtrInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInsertElementInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAInsertElementInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInsertValueInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAInsertValueInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsALandingPadInst(Val::LLVMValueRef)
    @apicall(:LLVMIsALandingPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAPHINode(Val::LLVMValueRef)
    @apicall(:LLVMIsAPHINode, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASelectInst(Val::LLVMValueRef)
    @apicall(:LLVMIsASelectInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAShuffleVectorInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAShuffleVectorInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAStoreInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAStoreInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsATerminatorInst(Val::LLVMValueRef)
    @apicall(:LLVMIsATerminatorInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABranchInst(Val::LLVMValueRef)
    @apicall(:LLVMIsABranchInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIndirectBrInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAIndirectBrInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAInvokeInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAInvokeInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAReturnInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAReturnInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASwitchInst(Val::LLVMValueRef)
    @apicall(:LLVMIsASwitchInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUnreachableInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAUnreachableInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAResumeInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAResumeInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACleanupReturnInst(Val::LLVMValueRef)
    @apicall(:LLVMIsACleanupReturnInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACatchReturnInst(Val::LLVMValueRef)
    @apicall(:LLVMIsACatchReturnInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFuncletPadInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAFuncletPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACatchPadInst(Val::LLVMValueRef)
    @apicall(:LLVMIsACatchPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACleanupPadInst(Val::LLVMValueRef)
    @apicall(:LLVMIsACleanupPadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUnaryInstruction(Val::LLVMValueRef)
    @apicall(:LLVMIsAUnaryInstruction, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAAllocaInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAAllocaInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsACastInst(Val::LLVMValueRef)
    @apicall(:LLVMIsACastInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAAddrSpaceCastInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAAddrSpaceCastInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsABitCastInst(Val::LLVMValueRef)
    @apicall(:LLVMIsABitCastInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPExtInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAFPExtInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPToSIInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAFPToSIInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPToUIInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAFPToUIInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAFPTruncInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAFPTruncInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAIntToPtrInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAIntToPtrInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAPtrToIntInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAPtrToIntInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASExtInst(Val::LLVMValueRef)
    @apicall(:LLVMIsASExtInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsASIToFPInst(Val::LLVMValueRef)
    @apicall(:LLVMIsASIToFPInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsATruncInst(Val::LLVMValueRef)
    @apicall(:LLVMIsATruncInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAUIToFPInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAUIToFPInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAZExtInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAZExtInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAExtractValueInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAExtractValueInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsALoadInst(Val::LLVMValueRef)
    @apicall(:LLVMIsALoadInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAVAArgInst(Val::LLVMValueRef)
    @apicall(:LLVMIsAVAArgInst, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMDNode(Val::LLVMValueRef)
    @apicall(:LLVMIsAMDNode, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMIsAMDString(Val::LLVMValueRef)
    @apicall(:LLVMIsAMDString, LLVMValueRef, (LLVMValueRef,), Val)
end

function LLVMGetFirstUse(Val::LLVMValueRef)
    @apicall(:LLVMGetFirstUse, LLVMUseRef, (LLVMValueRef,), Val)
end

function LLVMGetNextUse(U::LLVMUseRef)
    @apicall(:LLVMGetNextUse, LLVMUseRef, (LLVMUseRef,), U)
end

function LLVMGetUser(U::LLVMUseRef)
    @apicall(:LLVMGetUser, LLVMValueRef, (LLVMUseRef,), U)
end

function LLVMGetUsedValue(U::LLVMUseRef)
    @apicall(:LLVMGetUsedValue, LLVMValueRef, (LLVMUseRef,), U)
end

function LLVMGetOperand(Val::LLVMValueRef, Index::UInt32)
    @apicall(:LLVMGetOperand, LLVMValueRef, (LLVMValueRef, UInt32), Val, Index)
end

function LLVMGetOperandUse(Val::LLVMValueRef, Index::UInt32)
    @apicall(:LLVMGetOperandUse, LLVMUseRef, (LLVMValueRef, UInt32), Val, Index)
end

function LLVMSetOperand(User::LLVMValueRef, Index::UInt32, Val::LLVMValueRef)
    @apicall(:LLVMSetOperand, Cvoid, (LLVMValueRef, UInt32, LLVMValueRef), User, Index, Val)
end

function LLVMGetNumOperands(Val::LLVMValueRef)
    @apicall(:LLVMGetNumOperands, Cint, (LLVMValueRef,), Val)
end

function LLVMConstNull(Ty::LLVMTypeRef)
    @apicall(:LLVMConstNull, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstAllOnes(Ty::LLVMTypeRef)
    @apicall(:LLVMConstAllOnes, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMGetUndef(Ty::LLVMTypeRef)
    @apicall(:LLVMGetUndef, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMIsNull(Val::LLVMValueRef)
    @apicall(:LLVMIsNull, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMConstPointerNull(Ty::LLVMTypeRef)
    @apicall(:LLVMConstPointerNull, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstInt(IntTy::LLVMTypeRef, N::Culonglong, SignExtend::LLVMBool)
    @apicall(:LLVMConstInt, LLVMValueRef, (LLVMTypeRef, Culonglong, LLVMBool), IntTy, N, SignExtend)
end

function LLVMConstIntOfArbitraryPrecision(IntTy::LLVMTypeRef, NumWords::UInt32, Words)
    @apicall(:LLVMConstIntOfArbitraryPrecision, LLVMValueRef, (LLVMTypeRef, UInt32, Ptr{UInt64}), IntTy, NumWords, Words)
end

function LLVMConstIntOfString(IntTy::LLVMTypeRef, Text, Radix::UInt8)
    @apicall(:LLVMConstIntOfString, LLVMValueRef, (LLVMTypeRef, Cstring, UInt8), IntTy, Text, Radix)
end

function LLVMConstIntOfStringAndSize(IntTy::LLVMTypeRef, Text, SLen::UInt32, Radix::UInt8)
    @apicall(:LLVMConstIntOfStringAndSize, LLVMValueRef, (LLVMTypeRef, Cstring, UInt32, UInt8), IntTy, Text, SLen, Radix)
end

function LLVMConstReal(RealTy::LLVMTypeRef, N::Cdouble)
    @apicall(:LLVMConstReal, LLVMValueRef, (LLVMTypeRef, Cdouble), RealTy, N)
end

function LLVMConstRealOfString(RealTy::LLVMTypeRef, Text)
    @apicall(:LLVMConstRealOfString, LLVMValueRef, (LLVMTypeRef, Cstring), RealTy, Text)
end

function LLVMConstRealOfStringAndSize(RealTy::LLVMTypeRef, Text, SLen::UInt32)
    @apicall(:LLVMConstRealOfStringAndSize, LLVMValueRef, (LLVMTypeRef, Cstring, UInt32), RealTy, Text, SLen)
end

function LLVMConstIntGetZExtValue(ConstantVal::LLVMValueRef)
    @apicall(:LLVMConstIntGetZExtValue, Culonglong, (LLVMValueRef,), ConstantVal)
end

function LLVMConstIntGetSExtValue(ConstantVal::LLVMValueRef)
    @apicall(:LLVMConstIntGetSExtValue, Clonglong, (LLVMValueRef,), ConstantVal)
end

function LLVMConstRealGetDouble(ConstantVal::LLVMValueRef, losesInfo)
    @apicall(:LLVMConstRealGetDouble, Cdouble, (LLVMValueRef, Ptr{LLVMBool}), ConstantVal, losesInfo)
end

function LLVMConstStringInContext(C::LLVMContextRef, Str, Length::UInt32, DontNullTerminate::LLVMBool)
    @apicall(:LLVMConstStringInContext, LLVMValueRef, (LLVMContextRef, Cstring, UInt32, LLVMBool), C, Str, Length, DontNullTerminate)
end

function LLVMConstString(Str, Length::UInt32, DontNullTerminate::LLVMBool)
    @apicall(:LLVMConstString, LLVMValueRef, (Cstring, UInt32, LLVMBool), Str, Length, DontNullTerminate)
end

function LLVMIsConstantString(c::LLVMValueRef)
    @apicall(:LLVMIsConstantString, LLVMBool, (LLVMValueRef,), c)
end

function LLVMGetAsString(c::LLVMValueRef, Length)
    @apicall(:LLVMGetAsString, Cstring, (LLVMValueRef, Ptr{Csize_t}), c, Length)
end

function LLVMConstStructInContext(C::LLVMContextRef, ConstantVals, Count::UInt32, Packed::LLVMBool)
    @apicall(:LLVMConstStructInContext, LLVMValueRef, (LLVMContextRef, Ptr{LLVMValueRef}, UInt32, LLVMBool), C, ConstantVals, Count, Packed)
end

function LLVMConstStruct(ConstantVals, Count::UInt32, Packed::LLVMBool)
    @apicall(:LLVMConstStruct, LLVMValueRef, (Ptr{LLVMValueRef}, UInt32, LLVMBool), ConstantVals, Count, Packed)
end

function LLVMConstArray(ElementTy::LLVMTypeRef, ConstantVals, Length::UInt32)
    @apicall(:LLVMConstArray, LLVMValueRef, (LLVMTypeRef, Ptr{LLVMValueRef}, UInt32), ElementTy, ConstantVals, Length)
end

function LLVMConstNamedStruct(StructTy::LLVMTypeRef, ConstantVals, Count::UInt32)
    @apicall(:LLVMConstNamedStruct, LLVMValueRef, (LLVMTypeRef, Ptr{LLVMValueRef}, UInt32), StructTy, ConstantVals, Count)
end

function LLVMGetElementAsConstant(C::LLVMValueRef, idx::UInt32)
    @apicall(:LLVMGetElementAsConstant, LLVMValueRef, (LLVMValueRef, UInt32), C, idx)
end

function LLVMConstVector(ScalarConstantVals, Size::UInt32)
    @apicall(:LLVMConstVector, LLVMValueRef, (Ptr{LLVMValueRef}, UInt32), ScalarConstantVals, Size)
end

function LLVMGetConstOpcode(ConstantVal::LLVMValueRef)
    @apicall(:LLVMGetConstOpcode, LLVMOpcode, (LLVMValueRef,), ConstantVal)
end

function LLVMAlignOf(Ty::LLVMTypeRef)
    @apicall(:LLVMAlignOf, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMSizeOf(Ty::LLVMTypeRef)
    @apicall(:LLVMSizeOf, LLVMValueRef, (LLVMTypeRef,), Ty)
end

function LLVMConstNeg(ConstantVal::LLVMValueRef)
    @apicall(:LLVMConstNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNSWNeg(ConstantVal::LLVMValueRef)
    @apicall(:LLVMConstNSWNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNUWNeg(ConstantVal::LLVMValueRef)
    @apicall(:LLVMConstNUWNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstFNeg(ConstantVal::LLVMValueRef)
    @apicall(:LLVMConstFNeg, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstNot(ConstantVal::LLVMValueRef)
    @apicall(:LLVMConstNot, LLVMValueRef, (LLVMValueRef,), ConstantVal)
end

function LLVMConstAdd(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWAdd(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstNSWAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWAdd(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstNUWAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFAdd(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstFAdd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSub(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWSub(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstNSWSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWSub(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstNUWSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFSub(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstFSub, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstMul(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNSWMul(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstNSWMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstNUWMul(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstNUWMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFMul(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstFMul, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstUDiv(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstUDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstExactUDiv(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstExactUDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSDiv(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstSDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstExactSDiv(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstExactSDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFDiv(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstFDiv, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstURem(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstURem, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstSRem(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstSRem, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstFRem(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstFRem, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstAnd(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstAnd, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstOr(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstOr, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstXor(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstXor, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstICmp(Predicate::LLVMIntPredicate, LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstICmp, LLVMValueRef, (LLVMIntPredicate, LLVMValueRef, LLVMValueRef), Predicate, LHSConstant, RHSConstant)
end

function LLVMConstFCmp(Predicate::LLVMRealPredicate, LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstFCmp, LLVMValueRef, (LLVMRealPredicate, LLVMValueRef, LLVMValueRef), Predicate, LHSConstant, RHSConstant)
end

function LLVMConstShl(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstShl, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstLShr(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstLShr, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstAShr(LHSConstant::LLVMValueRef, RHSConstant::LLVMValueRef)
    @apicall(:LLVMConstAShr, LLVMValueRef, (LLVMValueRef, LLVMValueRef), LHSConstant, RHSConstant)
end

function LLVMConstGEP(ConstantVal::LLVMValueRef, ConstantIndices, NumIndices::UInt32)
    @apicall(:LLVMConstGEP, LLVMValueRef, (LLVMValueRef, Ptr{LLVMValueRef}, UInt32), ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstInBoundsGEP(ConstantVal::LLVMValueRef, ConstantIndices, NumIndices::UInt32)
    @apicall(:LLVMConstInBoundsGEP, LLVMValueRef, (LLVMValueRef, Ptr{LLVMValueRef}, UInt32), ConstantVal, ConstantIndices, NumIndices)
end

function LLVMConstTrunc(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstTrunc, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSExt(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstSExt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstZExt(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstZExt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPTrunc(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstFPTrunc, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPExt(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstFPExt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstUIToFP(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstUIToFP, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSIToFP(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstSIToFP, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPToUI(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstFPToUI, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstFPToSI(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstFPToSI, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstPtrToInt(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstPtrToInt, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstIntToPtr(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstIntToPtr, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstBitCast(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstAddrSpaceCast(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstAddrSpaceCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstZExtOrBitCast(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstZExtOrBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSExtOrBitCast(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstSExtOrBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstTruncOrBitCast(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstTruncOrBitCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstPointerCast(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstPointerCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstIntCast(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef, isSigned::LLVMBool)
    @apicall(:LLVMConstIntCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef, LLVMBool), ConstantVal, ToType, isSigned)
end

function LLVMConstFPCast(ConstantVal::LLVMValueRef, ToType::LLVMTypeRef)
    @apicall(:LLVMConstFPCast, LLVMValueRef, (LLVMValueRef, LLVMTypeRef), ConstantVal, ToType)
end

function LLVMConstSelect(ConstantCondition::LLVMValueRef, ConstantIfTrue::LLVMValueRef, ConstantIfFalse::LLVMValueRef)
    @apicall(:LLVMConstSelect, LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), ConstantCondition, ConstantIfTrue, ConstantIfFalse)
end

function LLVMConstExtractElement(VectorConstant::LLVMValueRef, IndexConstant::LLVMValueRef)
    @apicall(:LLVMConstExtractElement, LLVMValueRef, (LLVMValueRef, LLVMValueRef), VectorConstant, IndexConstant)
end

function LLVMConstInsertElement(VectorConstant::LLVMValueRef, ElementValueConstant::LLVMValueRef, IndexConstant::LLVMValueRef)
    @apicall(:LLVMConstInsertElement, LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), VectorConstant, ElementValueConstant, IndexConstant)
end

function LLVMConstShuffleVector(VectorAConstant::LLVMValueRef, VectorBConstant::LLVMValueRef, MaskConstant::LLVMValueRef)
    @apicall(:LLVMConstShuffleVector, LLVMValueRef, (LLVMValueRef, LLVMValueRef, LLVMValueRef), VectorAConstant, VectorBConstant, MaskConstant)
end

function LLVMConstExtractValue(AggConstant::LLVMValueRef, IdxList, NumIdx::UInt32)
    @apicall(:LLVMConstExtractValue, LLVMValueRef, (LLVMValueRef, Ptr{UInt32}, UInt32), AggConstant, IdxList, NumIdx)
end

function LLVMConstInsertValue(AggConstant::LLVMValueRef, ElementValueConstant::LLVMValueRef, IdxList, NumIdx::UInt32)
    @apicall(:LLVMConstInsertValue, LLVMValueRef, (LLVMValueRef, LLVMValueRef, Ptr{UInt32}, UInt32), AggConstant, ElementValueConstant, IdxList, NumIdx)
end

function LLVMConstInlineAsm(Ty::LLVMTypeRef, AsmString, Constraints, HasSideEffects::LLVMBool, IsAlignStack::LLVMBool)
    @apicall(:LLVMConstInlineAsm, LLVMValueRef, (LLVMTypeRef, Cstring, Cstring, LLVMBool, LLVMBool), Ty, AsmString, Constraints, HasSideEffects, IsAlignStack)
end

function LLVMBlockAddress(F::LLVMValueRef, BB::LLVMBasicBlockRef)
    @apicall(:LLVMBlockAddress, LLVMValueRef, (LLVMValueRef, LLVMBasicBlockRef), F, BB)
end

function LLVMGetGlobalParent(Global::LLVMValueRef)
    @apicall(:LLVMGetGlobalParent, LLVMModuleRef, (LLVMValueRef,), Global)
end

function LLVMIsDeclaration(Global::LLVMValueRef)
    @apicall(:LLVMIsDeclaration, LLVMBool, (LLVMValueRef,), Global)
end

function LLVMGetLinkage(Global::LLVMValueRef)
    @apicall(:LLVMGetLinkage, LLVMLinkage, (LLVMValueRef,), Global)
end

function LLVMSetLinkage(Global::LLVMValueRef, Linkage::LLVMLinkage)
    @apicall(:LLVMSetLinkage, Cvoid, (LLVMValueRef, LLVMLinkage), Global, Linkage)
end

function LLVMGetSection(Global::LLVMValueRef)
    @apicall(:LLVMGetSection, Cstring, (LLVMValueRef,), Global)
end

function LLVMSetSection(Global::LLVMValueRef, Section)
    @apicall(:LLVMSetSection, Cvoid, (LLVMValueRef, Cstring), Global, Section)
end

function LLVMGetVisibility(Global::LLVMValueRef)
    @apicall(:LLVMGetVisibility, LLVMVisibility, (LLVMValueRef,), Global)
end

function LLVMSetVisibility(Global::LLVMValueRef, Viz::LLVMVisibility)
    @apicall(:LLVMSetVisibility, Cvoid, (LLVMValueRef, LLVMVisibility), Global, Viz)
end

function LLVMGetDLLStorageClass(Global::LLVMValueRef)
    @apicall(:LLVMGetDLLStorageClass, LLVMDLLStorageClass, (LLVMValueRef,), Global)
end

function LLVMSetDLLStorageClass(Global::LLVMValueRef, Class::LLVMDLLStorageClass)
    @apicall(:LLVMSetDLLStorageClass, Cvoid, (LLVMValueRef, LLVMDLLStorageClass), Global, Class)
end

function LLVMHasUnnamedAddr(Global::LLVMValueRef)
    @apicall(:LLVMHasUnnamedAddr, LLVMBool, (LLVMValueRef,), Global)
end

function LLVMSetUnnamedAddr(Global::LLVMValueRef, HasUnnamedAddr::LLVMBool)
    @apicall(:LLVMSetUnnamedAddr, Cvoid, (LLVMValueRef, LLVMBool), Global, HasUnnamedAddr)
end

function LLVMGetAlignment(V::LLVMValueRef)
    @apicall(:LLVMGetAlignment, UInt32, (LLVMValueRef,), V)
end

function LLVMSetAlignment(V::LLVMValueRef, Bytes::UInt32)
    @apicall(:LLVMSetAlignment, Cvoid, (LLVMValueRef, UInt32), V, Bytes)
end

function LLVMAddGlobal(M::LLVMModuleRef, Ty::LLVMTypeRef, Name)
    @apicall(:LLVMAddGlobal, LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, Cstring), M, Ty, Name)
end

function LLVMAddGlobalInAddressSpace(M::LLVMModuleRef, Ty::LLVMTypeRef, Name, AddressSpace::UInt32)
    @apicall(:LLVMAddGlobalInAddressSpace, LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, Cstring, UInt32), M, Ty, Name, AddressSpace)
end

function LLVMGetNamedGlobal(M::LLVMModuleRef, Name)
    @apicall(:LLVMGetNamedGlobal, LLVMValueRef, (LLVMModuleRef, Cstring), M, Name)
end

function LLVMGetFirstGlobal(M::LLVMModuleRef)
    @apicall(:LLVMGetFirstGlobal, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetLastGlobal(M::LLVMModuleRef)
    @apicall(:LLVMGetLastGlobal, LLVMValueRef, (LLVMModuleRef,), M)
end

function LLVMGetNextGlobal(GlobalVar::LLVMValueRef)
    @apicall(:LLVMGetNextGlobal, LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMGetPreviousGlobal(GlobalVar::LLVMValueRef)
    @apicall(:LLVMGetPreviousGlobal, LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMDeleteGlobal(GlobalVar::LLVMValueRef)
    @apicall(:LLVMDeleteGlobal, Cvoid, (LLVMValueRef,), GlobalVar)
end

function LLVMGetInitializer(GlobalVar::LLVMValueRef)
    @apicall(:LLVMGetInitializer, LLVMValueRef, (LLVMValueRef,), GlobalVar)
end

function LLVMSetInitializer(GlobalVar::LLVMValueRef, ConstantVal::LLVMValueRef)
    @apicall(:LLVMSetInitializer, Cvoid, (LLVMValueRef, LLVMValueRef), GlobalVar, ConstantVal)
end

function LLVMIsThreadLocal(GlobalVar::LLVMValueRef)
    @apicall(:LLVMIsThreadLocal, LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetThreadLocal(GlobalVar::LLVMValueRef, IsThreadLocal::LLVMBool)
    @apicall(:LLVMSetThreadLocal, Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsThreadLocal)
end

function LLVMIsGlobalConstant(GlobalVar::LLVMValueRef)
    @apicall(:LLVMIsGlobalConstant, LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetGlobalConstant(GlobalVar::LLVMValueRef, IsConstant::LLVMBool)
    @apicall(:LLVMSetGlobalConstant, Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsConstant)
end

function LLVMGetThreadLocalMode(GlobalVar::LLVMValueRef)
    @apicall(:LLVMGetThreadLocalMode, LLVMThreadLocalMode, (LLVMValueRef,), GlobalVar)
end

function LLVMSetThreadLocalMode(GlobalVar::LLVMValueRef, Mode::LLVMThreadLocalMode)
    @apicall(:LLVMSetThreadLocalMode, Cvoid, (LLVMValueRef, LLVMThreadLocalMode), GlobalVar, Mode)
end

function LLVMIsExternallyInitialized(GlobalVar::LLVMValueRef)
    @apicall(:LLVMIsExternallyInitialized, LLVMBool, (LLVMValueRef,), GlobalVar)
end

function LLVMSetExternallyInitialized(GlobalVar::LLVMValueRef, IsExtInit::LLVMBool)
    @apicall(:LLVMSetExternallyInitialized, Cvoid, (LLVMValueRef, LLVMBool), GlobalVar, IsExtInit)
end

function LLVMAddAlias(M::LLVMModuleRef, Ty::LLVMTypeRef, Aliasee::LLVMValueRef, Name)
    @apicall(:LLVMAddAlias, LLVMValueRef, (LLVMModuleRef, LLVMTypeRef, LLVMValueRef, Cstring), M, Ty, Aliasee, Name)
end

function LLVMDeleteFunction(Fn::LLVMValueRef)
    @apicall(:LLVMDeleteFunction, Cvoid, (LLVMValueRef,), Fn)
end

function LLVMHasPersonalityFn(Fn::LLVMValueRef)
    @apicall(:LLVMHasPersonalityFn, LLVMBool, (LLVMValueRef,), Fn)
end

function LLVMGetPersonalityFn(Fn::LLVMValueRef)
    @apicall(:LLVMGetPersonalityFn, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMSetPersonalityFn(Fn::LLVMValueRef, PersonalityFn::LLVMValueRef)
    @apicall(:LLVMSetPersonalityFn, Cvoid, (LLVMValueRef, LLVMValueRef), Fn, PersonalityFn)
end

function LLVMGetIntrinsicID(Fn::LLVMValueRef)
    @apicall(:LLVMGetIntrinsicID, UInt32, (LLVMValueRef,), Fn)
end

function LLVMGetFunctionCallConv(Fn::LLVMValueRef)
    @apicall(:LLVMGetFunctionCallConv, UInt32, (LLVMValueRef,), Fn)
end

function LLVMSetFunctionCallConv(Fn::LLVMValueRef, CC::UInt32)
    @apicall(:LLVMSetFunctionCallConv, Cvoid, (LLVMValueRef, UInt32), Fn, CC)
end

function LLVMGetGC(Fn::LLVMValueRef)
    @apicall(:LLVMGetGC, Cstring, (LLVMValueRef,), Fn)
end

function LLVMSetGC(Fn::LLVMValueRef, Name)
    @apicall(:LLVMSetGC, Cvoid, (LLVMValueRef, Cstring), Fn, Name)
end

function LLVMAddAttributeAtIndex(F::LLVMValueRef, Idx::LLVMAttributeIndex, A::LLVMAttributeRef)
    @apicall(:LLVMAddAttributeAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, LLVMAttributeRef), F, Idx, A)
end

function LLVMGetAttributeCountAtIndex(F::LLVMValueRef, Idx::LLVMAttributeIndex)
    @apicall(:LLVMGetAttributeCountAtIndex, UInt32, (LLVMValueRef, LLVMAttributeIndex), F, Idx)
end

function LLVMGetAttributesAtIndex(F::LLVMValueRef, Idx::LLVMAttributeIndex, Attrs)
    @apicall(:LLVMGetAttributesAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Ptr{LLVMAttributeRef}), F, Idx, Attrs)
end

function LLVMGetEnumAttributeAtIndex(F::LLVMValueRef, Idx::LLVMAttributeIndex, KindID::UInt32)
    @apicall(:LLVMGetEnumAttributeAtIndex, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, UInt32), F, Idx, KindID)
end

function LLVMGetStringAttributeAtIndex(F::LLVMValueRef, Idx::LLVMAttributeIndex, K, KLen::UInt32)
    @apicall(:LLVMGetStringAttributeAtIndex, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), F, Idx, K, KLen)
end

function LLVMRemoveEnumAttributeAtIndex(F::LLVMValueRef, Idx::LLVMAttributeIndex, KindID::UInt32)
    @apicall(:LLVMRemoveEnumAttributeAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, UInt32), F, Idx, KindID)
end

function LLVMRemoveStringAttributeAtIndex(F::LLVMValueRef, Idx::LLVMAttributeIndex, K, KLen::UInt32)
    @apicall(:LLVMRemoveStringAttributeAtIndex, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), F, Idx, K, KLen)
end

function LLVMAddTargetDependentFunctionAttr(Fn::LLVMValueRef, A, V)
    @apicall(:LLVMAddTargetDependentFunctionAttr, Cvoid, (LLVMValueRef, Cstring, Cstring), Fn, A, V)
end

function LLVMCountParams(Fn::LLVMValueRef)
    @apicall(:LLVMCountParams, UInt32, (LLVMValueRef,), Fn)
end

function LLVMGetParams(Fn::LLVMValueRef, Params)
    @apicall(:LLVMGetParams, Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}), Fn, Params)
end

function LLVMGetParam(Fn::LLVMValueRef, Index::UInt32)
    @apicall(:LLVMGetParam, LLVMValueRef, (LLVMValueRef, UInt32), Fn, Index)
end

function LLVMGetParamParent(Inst::LLVMValueRef)
    @apicall(:LLVMGetParamParent, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetFirstParam(Fn::LLVMValueRef)
    @apicall(:LLVMGetFirstParam, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetLastParam(Fn::LLVMValueRef)
    @apicall(:LLVMGetLastParam, LLVMValueRef, (LLVMValueRef,), Fn)
end

function LLVMGetNextParam(Arg::LLVMValueRef)
    @apicall(:LLVMGetNextParam, LLVMValueRef, (LLVMValueRef,), Arg)
end

function LLVMGetPreviousParam(Arg::LLVMValueRef)
    @apicall(:LLVMGetPreviousParam, LLVMValueRef, (LLVMValueRef,), Arg)
end

function LLVMSetParamAlignment(Arg::LLVMValueRef, Align::UInt32)
    @apicall(:LLVMSetParamAlignment, Cvoid, (LLVMValueRef, UInt32), Arg, Align)
end

function LLVMMDStringInContext(C::LLVMContextRef, Str, SLen::UInt32)
    @apicall(:LLVMMDStringInContext, LLVMValueRef, (LLVMContextRef, Cstring, UInt32), C, Str, SLen)
end

function LLVMMDString(Str, SLen::UInt32)
    @apicall(:LLVMMDString, LLVMValueRef, (Cstring, UInt32), Str, SLen)
end

function LLVMMDNodeInContext(C::LLVMContextRef, Vals, Count::UInt32)
    @apicall(:LLVMMDNodeInContext, LLVMValueRef, (LLVMContextRef, Ptr{LLVMValueRef}, UInt32), C, Vals, Count)
end

function LLVMMDNode(Vals, Count::UInt32)
    @apicall(:LLVMMDNode, LLVMValueRef, (Ptr{LLVMValueRef}, UInt32), Vals, Count)
end

function LLVMMetadataAsValue(C::LLVMContextRef, MD::LLVMMetadataRef)
    @apicall(:LLVMMetadataAsValue, LLVMValueRef, (LLVMContextRef, LLVMMetadataRef), C, MD)
end

function LLVMValueAsMetadata(Val::LLVMValueRef)
    @apicall(:LLVMValueAsMetadata, LLVMMetadataRef, (LLVMValueRef,), Val)
end

function LLVMGetMDString(V::LLVMValueRef, Length)
    @apicall(:LLVMGetMDString, Cstring, (LLVMValueRef, Ptr{UInt32}), V, Length)
end

function LLVMGetMDNodeNumOperands(V::LLVMValueRef)
    @apicall(:LLVMGetMDNodeNumOperands, UInt32, (LLVMValueRef,), V)
end

function LLVMGetMDNodeOperands(V::LLVMValueRef, Dest)
    @apicall(:LLVMGetMDNodeOperands, Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}), V, Dest)
end

function LLVMBasicBlockAsValue(BB::LLVMBasicBlockRef)
    @apicall(:LLVMBasicBlockAsValue, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMValueIsBasicBlock(Val::LLVMValueRef)
    @apicall(:LLVMValueIsBasicBlock, LLVMBool, (LLVMValueRef,), Val)
end

function LLVMValueAsBasicBlock(Val::LLVMValueRef)
    @apicall(:LLVMValueAsBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Val)
end

function LLVMGetBasicBlockName(BB::LLVMBasicBlockRef)
    @apicall(:LLVMGetBasicBlockName, Cstring, (LLVMBasicBlockRef,), BB)
end

function LLVMGetBasicBlockParent(BB::LLVMBasicBlockRef)
    @apicall(:LLVMGetBasicBlockParent, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetBasicBlockTerminator(BB::LLVMBasicBlockRef)
    @apicall(:LLVMGetBasicBlockTerminator, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMCountBasicBlocks(Fn::LLVMValueRef)
    @apicall(:LLVMCountBasicBlocks, UInt32, (LLVMValueRef,), Fn)
end

function LLVMGetBasicBlocks(Fn::LLVMValueRef, BasicBlocks)
    @apicall(:LLVMGetBasicBlocks, Cvoid, (LLVMValueRef, Ptr{LLVMBasicBlockRef}), Fn, BasicBlocks)
end

function LLVMGetFirstBasicBlock(Fn::LLVMValueRef)
    @apicall(:LLVMGetFirstBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

function LLVMGetLastBasicBlock(Fn::LLVMValueRef)
    @apicall(:LLVMGetLastBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

function LLVMGetNextBasicBlock(BB::LLVMBasicBlockRef)
    @apicall(:LLVMGetNextBasicBlock, LLVMBasicBlockRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetPreviousBasicBlock(BB::LLVMBasicBlockRef)
    @apicall(:LLVMGetPreviousBasicBlock, LLVMBasicBlockRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetEntryBasicBlock(Fn::LLVMValueRef)
    @apicall(:LLVMGetEntryBasicBlock, LLVMBasicBlockRef, (LLVMValueRef,), Fn)
end

function LLVMAppendBasicBlockInContext(C::LLVMContextRef, Fn::LLVMValueRef, Name)
    @apicall(:LLVMAppendBasicBlockInContext, LLVMBasicBlockRef, (LLVMContextRef, LLVMValueRef, Cstring), C, Fn, Name)
end

function LLVMAppendBasicBlock(Fn::LLVMValueRef, Name)
    @apicall(:LLVMAppendBasicBlock, LLVMBasicBlockRef, (LLVMValueRef, Cstring), Fn, Name)
end

function LLVMInsertBasicBlockInContext(C::LLVMContextRef, BB::LLVMBasicBlockRef, Name)
    @apicall(:LLVMInsertBasicBlockInContext, LLVMBasicBlockRef, (LLVMContextRef, LLVMBasicBlockRef, Cstring), C, BB, Name)
end

function LLVMInsertBasicBlock(InsertBeforeBB::LLVMBasicBlockRef, Name)
    @apicall(:LLVMInsertBasicBlock, LLVMBasicBlockRef, (LLVMBasicBlockRef, Cstring), InsertBeforeBB, Name)
end

function LLVMDeleteBasicBlock(BB::LLVMBasicBlockRef)
    @apicall(:LLVMDeleteBasicBlock, Cvoid, (LLVMBasicBlockRef,), BB)
end

function LLVMRemoveBasicBlockFromParent(BB::LLVMBasicBlockRef)
    @apicall(:LLVMRemoveBasicBlockFromParent, Cvoid, (LLVMBasicBlockRef,), BB)
end

function LLVMMoveBasicBlockBefore(BB::LLVMBasicBlockRef, MovePos::LLVMBasicBlockRef)
    @apicall(:LLVMMoveBasicBlockBefore, Cvoid, (LLVMBasicBlockRef, LLVMBasicBlockRef), BB, MovePos)
end

function LLVMMoveBasicBlockAfter(BB::LLVMBasicBlockRef, MovePos::LLVMBasicBlockRef)
    @apicall(:LLVMMoveBasicBlockAfter, Cvoid, (LLVMBasicBlockRef, LLVMBasicBlockRef), BB, MovePos)
end

function LLVMGetFirstInstruction(BB::LLVMBasicBlockRef)
    @apicall(:LLVMGetFirstInstruction, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMGetLastInstruction(BB::LLVMBasicBlockRef)
    @apicall(:LLVMGetLastInstruction, LLVMValueRef, (LLVMBasicBlockRef,), BB)
end

function LLVMHasMetadata(Val::LLVMValueRef)
    @apicall(:LLVMHasMetadata, Cint, (LLVMValueRef,), Val)
end

function LLVMGetMetadata(Val::LLVMValueRef, KindID::UInt32)
    @apicall(:LLVMGetMetadata, LLVMValueRef, (LLVMValueRef, UInt32), Val, KindID)
end

function LLVMSetMetadata(Val::LLVMValueRef, KindID::UInt32, Node::LLVMValueRef)
    @apicall(:LLVMSetMetadata, Cvoid, (LLVMValueRef, UInt32, LLVMValueRef), Val, KindID, Node)
end

function LLVMGetInstructionParent(Inst::LLVMValueRef)
    @apicall(:LLVMGetInstructionParent, LLVMBasicBlockRef, (LLVMValueRef,), Inst)
end

function LLVMGetNextInstruction(Inst::LLVMValueRef)
    @apicall(:LLVMGetNextInstruction, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetPreviousInstruction(Inst::LLVMValueRef)
    @apicall(:LLVMGetPreviousInstruction, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMInstructionRemoveFromParent(Inst::LLVMValueRef)
    @apicall(:LLVMInstructionRemoveFromParent, Cvoid, (LLVMValueRef,), Inst)
end

function LLVMInstructionEraseFromParent(Inst::LLVMValueRef)
    @apicall(:LLVMInstructionEraseFromParent, Cvoid, (LLVMValueRef,), Inst)
end

function LLVMGetInstructionOpcode(Inst::LLVMValueRef)
    @apicall(:LLVMGetInstructionOpcode, LLVMOpcode, (LLVMValueRef,), Inst)
end

function LLVMGetICmpPredicate(Inst::LLVMValueRef)
    @apicall(:LLVMGetICmpPredicate, LLVMIntPredicate, (LLVMValueRef,), Inst)
end

function LLVMGetFCmpPredicate(Inst::LLVMValueRef)
    @apicall(:LLVMGetFCmpPredicate, LLVMRealPredicate, (LLVMValueRef,), Inst)
end

function LLVMInstructionClone(Inst::LLVMValueRef)
    @apicall(:LLVMInstructionClone, LLVMValueRef, (LLVMValueRef,), Inst)
end

function LLVMGetNumArgOperands(Instr::LLVMValueRef)
    @apicall(:LLVMGetNumArgOperands, UInt32, (LLVMValueRef,), Instr)
end

function LLVMSetInstructionCallConv(Instr::LLVMValueRef, CC::UInt32)
    @apicall(:LLVMSetInstructionCallConv, Cvoid, (LLVMValueRef, UInt32), Instr, CC)
end

function LLVMGetInstructionCallConv(Instr::LLVMValueRef)
    @apicall(:LLVMGetInstructionCallConv, UInt32, (LLVMValueRef,), Instr)
end

function LLVMSetInstrParamAlignment(Instr::LLVMValueRef, index::UInt32, Align::UInt32)
    @apicall(:LLVMSetInstrParamAlignment, Cvoid, (LLVMValueRef, UInt32, UInt32), Instr, index, Align)
end

function LLVMAddCallSiteAttribute(C::LLVMValueRef, Idx::LLVMAttributeIndex, A::LLVMAttributeRef)
    @apicall(:LLVMAddCallSiteAttribute, Cvoid, (LLVMValueRef, LLVMAttributeIndex, LLVMAttributeRef), C, Idx, A)
end

function LLVMGetCallSiteAttributeCount(C::LLVMValueRef, Idx::LLVMAttributeIndex)
    @apicall(:LLVMGetCallSiteAttributeCount, UInt32, (LLVMValueRef, LLVMAttributeIndex), C, Idx)
end

function LLVMGetCallSiteAttributes(C::LLVMValueRef, Idx::LLVMAttributeIndex, Attrs)
    @apicall(:LLVMGetCallSiteAttributes, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Ptr{LLVMAttributeRef}), C, Idx, Attrs)
end

function LLVMGetCallSiteEnumAttribute(C::LLVMValueRef, Idx::LLVMAttributeIndex, KindID::UInt32)
    @apicall(:LLVMGetCallSiteEnumAttribute, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, UInt32), C, Idx, KindID)
end

function LLVMGetCallSiteStringAttribute(C::LLVMValueRef, Idx::LLVMAttributeIndex, K, KLen::UInt32)
    @apicall(:LLVMGetCallSiteStringAttribute, LLVMAttributeRef, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), C, Idx, K, KLen)
end

function LLVMRemoveCallSiteEnumAttribute(C::LLVMValueRef, Idx::LLVMAttributeIndex, KindID::UInt32)
    @apicall(:LLVMRemoveCallSiteEnumAttribute, Cvoid, (LLVMValueRef, LLVMAttributeIndex, UInt32), C, Idx, KindID)
end

function LLVMRemoveCallSiteStringAttribute(C::LLVMValueRef, Idx::LLVMAttributeIndex, K, KLen::UInt32)
    @apicall(:LLVMRemoveCallSiteStringAttribute, Cvoid, (LLVMValueRef, LLVMAttributeIndex, Cstring, UInt32), C, Idx, K, KLen)
end

function LLVMGetCalledValue(Instr::LLVMValueRef)
    @apicall(:LLVMGetCalledValue, LLVMValueRef, (LLVMValueRef,), Instr)
end

function LLVMIsTailCall(CallInst::LLVMValueRef)
    @apicall(:LLVMIsTailCall, LLVMBool, (LLVMValueRef,), CallInst)
end

function LLVMSetTailCall(CallInst::LLVMValueRef, IsTailCall::LLVMBool)
    @apicall(:LLVMSetTailCall, Cvoid, (LLVMValueRef, LLVMBool), CallInst, IsTailCall)
end

function LLVMGetNormalDest(InvokeInst::LLVMValueRef)
    @apicall(:LLVMGetNormalDest, LLVMBasicBlockRef, (LLVMValueRef,), InvokeInst)
end

function LLVMGetUnwindDest(InvokeInst::LLVMValueRef)
    @apicall(:LLVMGetUnwindDest, LLVMBasicBlockRef, (LLVMValueRef,), InvokeInst)
end

function LLVMSetNormalDest(InvokeInst::LLVMValueRef, B::LLVMBasicBlockRef)
    @apicall(:LLVMSetNormalDest, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), InvokeInst, B)
end

function LLVMSetUnwindDest(InvokeInst::LLVMValueRef, B::LLVMBasicBlockRef)
    @apicall(:LLVMSetUnwindDest, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), InvokeInst, B)
end

function LLVMGetNumSuccessors(Term::LLVMValueRef)
    @apicall(:LLVMGetNumSuccessors, UInt32, (LLVMValueRef,), Term)
end

function LLVMGetSuccessor(Term::LLVMValueRef, i::UInt32)
    @apicall(:LLVMGetSuccessor, LLVMBasicBlockRef, (LLVMValueRef, UInt32), Term, i)
end

function LLVMSetSuccessor(Term::LLVMValueRef, i::UInt32, block::LLVMBasicBlockRef)
    @apicall(:LLVMSetSuccessor, Cvoid, (LLVMValueRef, UInt32, LLVMBasicBlockRef), Term, i, block)
end

function LLVMIsConditional(Branch::LLVMValueRef)
    @apicall(:LLVMIsConditional, LLVMBool, (LLVMValueRef,), Branch)
end

function LLVMGetCondition(Branch::LLVMValueRef)
    @apicall(:LLVMGetCondition, LLVMValueRef, (LLVMValueRef,), Branch)
end

function LLVMSetCondition(Branch::LLVMValueRef, Cond::LLVMValueRef)
    @apicall(:LLVMSetCondition, Cvoid, (LLVMValueRef, LLVMValueRef), Branch, Cond)
end

function LLVMGetSwitchDefaultDest(SwitchInstr::LLVMValueRef)
    @apicall(:LLVMGetSwitchDefaultDest, LLVMBasicBlockRef, (LLVMValueRef,), SwitchInstr)
end

function LLVMGetAllocatedType(Alloca::LLVMValueRef)
    @apicall(:LLVMGetAllocatedType, LLVMTypeRef, (LLVMValueRef,), Alloca)
end

function LLVMIsInBounds(GEP::LLVMValueRef)
    @apicall(:LLVMIsInBounds, LLVMBool, (LLVMValueRef,), GEP)
end

function LLVMSetIsInBounds(GEP::LLVMValueRef, InBounds::LLVMBool)
    @apicall(:LLVMSetIsInBounds, Cvoid, (LLVMValueRef, LLVMBool), GEP, InBounds)
end

function LLVMAddIncoming(PhiNode::LLVMValueRef, IncomingValues, IncomingBlocks, Count::UInt32)
    @apicall(:LLVMAddIncoming, Cvoid, (LLVMValueRef, Ptr{LLVMValueRef}, Ptr{LLVMBasicBlockRef}, UInt32), PhiNode, IncomingValues, IncomingBlocks, Count)
end

function LLVMCountIncoming(PhiNode::LLVMValueRef)
    @apicall(:LLVMCountIncoming, UInt32, (LLVMValueRef,), PhiNode)
end

function LLVMGetIncomingValue(PhiNode::LLVMValueRef, Index::UInt32)
    @apicall(:LLVMGetIncomingValue, LLVMValueRef, (LLVMValueRef, UInt32), PhiNode, Index)
end

function LLVMGetIncomingBlock(PhiNode::LLVMValueRef, Index::UInt32)
    @apicall(:LLVMGetIncomingBlock, LLVMBasicBlockRef, (LLVMValueRef, UInt32), PhiNode, Index)
end

function LLVMGetNumIndices(Inst::LLVMValueRef)
    @apicall(:LLVMGetNumIndices, UInt32, (LLVMValueRef,), Inst)
end

function LLVMGetIndices(Inst::LLVMValueRef)
    @apicall(:LLVMGetIndices, Ptr{UInt32}, (LLVMValueRef,), Inst)
end

function LLVMCreateBuilderInContext(C::LLVMContextRef)
    @apicall(:LLVMCreateBuilderInContext, LLVMBuilderRef, (LLVMContextRef,), C)
end

function LLVMCreateBuilder()
    @apicall(:LLVMCreateBuilder, LLVMBuilderRef, ())
end

function LLVMPositionBuilder(Builder::LLVMBuilderRef, Block::LLVMBasicBlockRef, Instr::LLVMValueRef)
    @apicall(:LLVMPositionBuilder, Cvoid, (LLVMBuilderRef, LLVMBasicBlockRef, LLVMValueRef), Builder, Block, Instr)
end

function LLVMPositionBuilderBefore(Builder::LLVMBuilderRef, Instr::LLVMValueRef)
    @apicall(:LLVMPositionBuilderBefore, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Instr)
end

function LLVMPositionBuilderAtEnd(Builder::LLVMBuilderRef, Block::LLVMBasicBlockRef)
    @apicall(:LLVMPositionBuilderAtEnd, Cvoid, (LLVMBuilderRef, LLVMBasicBlockRef), Builder, Block)
end

function LLVMGetInsertBlock(Builder::LLVMBuilderRef)
    @apicall(:LLVMGetInsertBlock, LLVMBasicBlockRef, (LLVMBuilderRef,), Builder)
end

function LLVMClearInsertionPosition(Builder::LLVMBuilderRef)
    @apicall(:LLVMClearInsertionPosition, Cvoid, (LLVMBuilderRef,), Builder)
end

function LLVMInsertIntoBuilder(Builder::LLVMBuilderRef, Instr::LLVMValueRef)
    @apicall(:LLVMInsertIntoBuilder, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Instr)
end

function LLVMInsertIntoBuilderWithName(Builder::LLVMBuilderRef, Instr::LLVMValueRef, Name)
    @apicall(:LLVMInsertIntoBuilderWithName, Cvoid, (LLVMBuilderRef, LLVMValueRef, Cstring), Builder, Instr, Name)
end

function LLVMDisposeBuilder(Builder::LLVMBuilderRef)
    @apicall(:LLVMDisposeBuilder, Cvoid, (LLVMBuilderRef,), Builder)
end

function LLVMSetCurrentDebugLocation(Builder::LLVMBuilderRef, L::LLVMValueRef)
    @apicall(:LLVMSetCurrentDebugLocation, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, L)
end

function LLVMGetCurrentDebugLocation(Builder::LLVMBuilderRef)
    @apicall(:LLVMGetCurrentDebugLocation, LLVMValueRef, (LLVMBuilderRef,), Builder)
end

function LLVMSetInstDebugLocation(Builder::LLVMBuilderRef, Inst::LLVMValueRef)
    @apicall(:LLVMSetInstDebugLocation, Cvoid, (LLVMBuilderRef, LLVMValueRef), Builder, Inst)
end

function LLVMBuildRetVoid(arg1::LLVMBuilderRef)
    @apicall(:LLVMBuildRetVoid, LLVMValueRef, (LLVMBuilderRef,), arg1)
end

function LLVMBuildRet(arg1::LLVMBuilderRef, V::LLVMValueRef)
    @apicall(:LLVMBuildRet, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), arg1, V)
end

function LLVMBuildAggregateRet(arg1::LLVMBuilderRef, RetVals, N::UInt32)
    @apicall(:LLVMBuildAggregateRet, LLVMValueRef, (LLVMBuilderRef, Ptr{LLVMValueRef}, UInt32), arg1, RetVals, N)
end

function LLVMBuildBr(arg1::LLVMBuilderRef, Dest::LLVMBasicBlockRef)
    @apicall(:LLVMBuildBr, LLVMValueRef, (LLVMBuilderRef, LLVMBasicBlockRef), arg1, Dest)
end

function LLVMBuildCondBr(arg1::LLVMBuilderRef, If::LLVMValueRef, Then::LLVMBasicBlockRef, Else::LLVMBasicBlockRef)
    @apicall(:LLVMBuildCondBr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, LLVMBasicBlockRef), arg1, If, Then, Else)
end

function LLVMBuildSwitch(arg1::LLVMBuilderRef, V::LLVMValueRef, Else::LLVMBasicBlockRef, NumCases::UInt32)
    @apicall(:LLVMBuildSwitch, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMBasicBlockRef, UInt32), arg1, V, Else, NumCases)
end

function LLVMBuildIndirectBr(B::LLVMBuilderRef, Addr::LLVMValueRef, NumDests::UInt32)
    @apicall(:LLVMBuildIndirectBr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32), B, Addr, NumDests)
end

function LLVMBuildInvoke(arg1::LLVMBuilderRef, Fn::LLVMValueRef, Args, NumArgs::UInt32, Then::LLVMBasicBlockRef, Catch::LLVMBasicBlockRef, Name)
    @apicall(:LLVMBuildInvoke, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, LLVMBasicBlockRef, LLVMBasicBlockRef, Cstring), arg1, Fn, Args, NumArgs, Then, Catch, Name)
end

function LLVMBuildLandingPad(B::LLVMBuilderRef, Ty::LLVMTypeRef, PersFn::LLVMValueRef, NumClauses::UInt32, Name)
    @apicall(:LLVMBuildLandingPad, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, UInt32, Cstring), B, Ty, PersFn, NumClauses, Name)
end

function LLVMBuildResume(B::LLVMBuilderRef, Exn::LLVMValueRef)
    @apicall(:LLVMBuildResume, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), B, Exn)
end

function LLVMBuildUnreachable(arg1::LLVMBuilderRef)
    @apicall(:LLVMBuildUnreachable, LLVMValueRef, (LLVMBuilderRef,), arg1)
end

function LLVMAddCase(Switch::LLVMValueRef, OnVal::LLVMValueRef, Dest::LLVMBasicBlockRef)
    @apicall(:LLVMAddCase, Cvoid, (LLVMValueRef, LLVMValueRef, LLVMBasicBlockRef), Switch, OnVal, Dest)
end

function LLVMAddDestination(IndirectBr::LLVMValueRef, Dest::LLVMBasicBlockRef)
    @apicall(:LLVMAddDestination, Cvoid, (LLVMValueRef, LLVMBasicBlockRef), IndirectBr, Dest)
end

function LLVMGetNumClauses(LandingPad::LLVMValueRef)
    @apicall(:LLVMGetNumClauses, UInt32, (LLVMValueRef,), LandingPad)
end

function LLVMGetClause(LandingPad::LLVMValueRef, Idx::UInt32)
    @apicall(:LLVMGetClause, LLVMValueRef, (LLVMValueRef, UInt32), LandingPad, Idx)
end

function LLVMAddClause(LandingPad::LLVMValueRef, ClauseVal::LLVMValueRef)
    @apicall(:LLVMAddClause, Cvoid, (LLVMValueRef, LLVMValueRef), LandingPad, ClauseVal)
end

function LLVMIsCleanup(LandingPad::LLVMValueRef)
    @apicall(:LLVMIsCleanup, LLVMBool, (LLVMValueRef,), LandingPad)
end

function LLVMSetCleanup(LandingPad::LLVMValueRef, Val::LLVMBool)
    @apicall(:LLVMSetCleanup, Cvoid, (LLVMValueRef, LLVMBool), LandingPad, Val)
end

function LLVMBuildAdd(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWAdd(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildNSWAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWAdd(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildNUWAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFAdd(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildFAdd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSub(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWSub(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildNSWSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWSub(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildNUWSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFSub(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildFSub, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildMul(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNSWMul(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildNSWMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildNUWMul(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildNUWMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFMul(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildFMul, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildUDiv(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildUDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildExactUDiv(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildExactUDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSDiv(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildSDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildExactSDiv(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildExactSDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFDiv(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildFDiv, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildURem(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildURem, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildSRem(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildSRem, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFRem(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildFRem, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildShl(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildShl, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildLShr(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildLShr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildAShr(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildAShr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildAnd(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildAnd, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildOr(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildOr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildXor(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildXor, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildBinOp(B::LLVMBuilderRef, Op::LLVMOpcode, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildBinOp, LLVMValueRef, (LLVMBuilderRef, LLVMOpcode, LLVMValueRef, LLVMValueRef, Cstring), B, Op, LHS, RHS, Name)
end

function LLVMBuildNeg(arg1::LLVMBuilderRef, V::LLVMValueRef, Name)
    @apicall(:LLVMBuildNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildNSWNeg(B::LLVMBuilderRef, V::LLVMValueRef, Name)
    @apicall(:LLVMBuildNSWNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), B, V, Name)
end

function LLVMBuildNUWNeg(B::LLVMBuilderRef, V::LLVMValueRef, Name)
    @apicall(:LLVMBuildNUWNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), B, V, Name)
end

function LLVMBuildFNeg(arg1::LLVMBuilderRef, V::LLVMValueRef, Name)
    @apicall(:LLVMBuildFNeg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildNot(arg1::LLVMBuilderRef, V::LLVMValueRef, Name)
    @apicall(:LLVMBuildNot, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, V, Name)
end

function LLVMBuildMalloc(arg1::LLVMBuilderRef, Ty::LLVMTypeRef, Name)
    @apicall(:LLVMBuildMalloc, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildArrayMalloc(arg1::LLVMBuilderRef, Ty::LLVMTypeRef, Val::LLVMValueRef, Name)
    @apicall(:LLVMBuildArrayMalloc, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring), arg1, Ty, Val, Name)
end

function LLVMBuildAlloca(arg1::LLVMBuilderRef, Ty::LLVMTypeRef, Name)
    @apicall(:LLVMBuildAlloca, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildArrayAlloca(arg1::LLVMBuilderRef, Ty::LLVMTypeRef, Val::LLVMValueRef, Name)
    @apicall(:LLVMBuildArrayAlloca, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, LLVMValueRef, Cstring), arg1, Ty, Val, Name)
end

function LLVMBuildFree(arg1::LLVMBuilderRef, PointerVal::LLVMValueRef)
    @apicall(:LLVMBuildFree, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef), arg1, PointerVal)
end

function LLVMBuildLoad(arg1::LLVMBuilderRef, PointerVal::LLVMValueRef, Name)
    @apicall(:LLVMBuildLoad, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, PointerVal, Name)
end

function LLVMBuildStore(arg1::LLVMBuilderRef, Val::LLVMValueRef, Ptr::LLVMValueRef)
    @apicall(:LLVMBuildStore, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef), arg1, Val, Ptr)
end

function LLVMBuildGEP(B::LLVMBuilderRef, Pointer::LLVMValueRef, Indices, NumIndices::UInt32, Name)
    @apicall(:LLVMBuildGEP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildInBoundsGEP(B::LLVMBuilderRef, Pointer::LLVMValueRef, Indices, NumIndices::UInt32, Name)
    @apicall(:LLVMBuildInBoundsGEP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), B, Pointer, Indices, NumIndices, Name)
end

function LLVMBuildStructGEP(B::LLVMBuilderRef, Pointer::LLVMValueRef, Idx::UInt32, Name)
    @apicall(:LLVMBuildStructGEP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32, Cstring), B, Pointer, Idx, Name)
end

function LLVMBuildGlobalString(B::LLVMBuilderRef, Str, Name)
    @apicall(:LLVMBuildGlobalString, LLVMValueRef, (LLVMBuilderRef, Cstring, Cstring), B, Str, Name)
end

function LLVMBuildGlobalStringPtr(B::LLVMBuilderRef, Str, Name)
    @apicall(:LLVMBuildGlobalStringPtr, LLVMValueRef, (LLVMBuilderRef, Cstring, Cstring), B, Str, Name)
end

function LLVMGetVolatile(MemoryAccessInst::LLVMValueRef)
    @apicall(:LLVMGetVolatile, LLVMBool, (LLVMValueRef,), MemoryAccessInst)
end

function LLVMSetVolatile(MemoryAccessInst::LLVMValueRef, IsVolatile::LLVMBool)
    @apicall(:LLVMSetVolatile, Cvoid, (LLVMValueRef, LLVMBool), MemoryAccessInst, IsVolatile)
end

function LLVMGetOrdering(MemoryAccessInst::LLVMValueRef)
    @apicall(:LLVMGetOrdering, LLVMAtomicOrdering, (LLVMValueRef,), MemoryAccessInst)
end

function LLVMSetOrdering(MemoryAccessInst::LLVMValueRef, Ordering::LLVMAtomicOrdering)
    @apicall(:LLVMSetOrdering, Cvoid, (LLVMValueRef, LLVMAtomicOrdering), MemoryAccessInst, Ordering)
end

function LLVMBuildTrunc(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildTrunc, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildZExt(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildZExt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSExt(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildSExt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPToUI(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildFPToUI, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPToSI(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildFPToSI, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildUIToFP(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildUIToFP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSIToFP(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildSIToFP, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPTrunc(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildFPTrunc, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPExt(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildFPExt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildPtrToInt(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildPtrToInt, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildIntToPtr(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildIntToPtr, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildBitCast(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildAddrSpaceCast(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildAddrSpaceCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildZExtOrBitCast(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildZExtOrBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildSExtOrBitCast(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildSExtOrBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildTruncOrBitCast(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildTruncOrBitCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildCast(B::LLVMBuilderRef, Op::LLVMOpcode, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildCast, LLVMValueRef, (LLVMBuilderRef, LLVMOpcode, LLVMValueRef, LLVMTypeRef, Cstring), B, Op, Val, DestTy, Name)
end

function LLVMBuildPointerCast(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildPointerCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildIntCast(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildIntCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildFPCast(arg1::LLVMBuilderRef, Val::LLVMValueRef, DestTy::LLVMTypeRef, Name)
    @apicall(:LLVMBuildFPCast, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, Val, DestTy, Name)
end

function LLVMBuildICmp(arg1::LLVMBuilderRef, Op::LLVMIntPredicate, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildICmp, LLVMValueRef, (LLVMBuilderRef, LLVMIntPredicate, LLVMValueRef, LLVMValueRef, Cstring), arg1, Op, LHS, RHS, Name)
end

function LLVMBuildFCmp(arg1::LLVMBuilderRef, Op::LLVMRealPredicate, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildFCmp, LLVMValueRef, (LLVMBuilderRef, LLVMRealPredicate, LLVMValueRef, LLVMValueRef, Cstring), arg1, Op, LHS, RHS, Name)
end

function LLVMBuildPhi(arg1::LLVMBuilderRef, Ty::LLVMTypeRef, Name)
    @apicall(:LLVMBuildPhi, LLVMValueRef, (LLVMBuilderRef, LLVMTypeRef, Cstring), arg1, Ty, Name)
end

function LLVMBuildCall(arg1::LLVMBuilderRef, Fn::LLVMValueRef, Args, NumArgs::UInt32, Name)
    @apicall(:LLVMBuildCall, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Ptr{LLVMValueRef}, UInt32, Cstring), arg1, Fn, Args, NumArgs, Name)
end

function LLVMBuildSelect(arg1::LLVMBuilderRef, If::LLVMValueRef, Then::LLVMValueRef, Else::LLVMValueRef, Name)
    @apicall(:LLVMBuildSelect, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, If, Then, Else, Name)
end

function LLVMBuildVAArg(arg1::LLVMBuilderRef, List::LLVMValueRef, Ty::LLVMTypeRef, Name)
    @apicall(:LLVMBuildVAArg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMTypeRef, Cstring), arg1, List, Ty, Name)
end

function LLVMBuildExtractElement(arg1::LLVMBuilderRef, VecVal::LLVMValueRef, Index::LLVMValueRef, Name)
    @apicall(:LLVMBuildExtractElement, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, VecVal, Index, Name)
end

function LLVMBuildInsertElement(arg1::LLVMBuilderRef, VecVal::LLVMValueRef, EltVal::LLVMValueRef, Index::LLVMValueRef, Name)
    @apicall(:LLVMBuildInsertElement, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, VecVal, EltVal, Index, Name)
end

function LLVMBuildShuffleVector(arg1::LLVMBuilderRef, V1::LLVMValueRef, V2::LLVMValueRef, Mask::LLVMValueRef, Name)
    @apicall(:LLVMBuildShuffleVector, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, V1, V2, Mask, Name)
end

function LLVMBuildExtractValue(arg1::LLVMBuilderRef, AggVal::LLVMValueRef, Index::UInt32, Name)
    @apicall(:LLVMBuildExtractValue, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, UInt32, Cstring), arg1, AggVal, Index, Name)
end

function LLVMBuildInsertValue(arg1::LLVMBuilderRef, AggVal::LLVMValueRef, EltVal::LLVMValueRef, Index::UInt32, Name)
    @apicall(:LLVMBuildInsertValue, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, UInt32, Cstring), arg1, AggVal, EltVal, Index, Name)
end

function LLVMBuildIsNull(arg1::LLVMBuilderRef, Val::LLVMValueRef, Name)
    @apicall(:LLVMBuildIsNull, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, Val, Name)
end

function LLVMBuildIsNotNull(arg1::LLVMBuilderRef, Val::LLVMValueRef, Name)
    @apicall(:LLVMBuildIsNotNull, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, Cstring), arg1, Val, Name)
end

function LLVMBuildPtrDiff(arg1::LLVMBuilderRef, LHS::LLVMValueRef, RHS::LLVMValueRef, Name)
    @apicall(:LLVMBuildPtrDiff, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, Cstring), arg1, LHS, RHS, Name)
end

function LLVMBuildFence(B::LLVMBuilderRef, ordering::LLVMAtomicOrdering, singleThread::LLVMBool, Name)
    @apicall(:LLVMBuildFence, LLVMValueRef, (LLVMBuilderRef, LLVMAtomicOrdering, LLVMBool, Cstring), B, ordering, singleThread, Name)
end

function LLVMBuildAtomicRMW(B::LLVMBuilderRef, op::LLVMAtomicRMWBinOp, PTR::LLVMValueRef, Val::LLVMValueRef, ordering::LLVMAtomicOrdering, singleThread::LLVMBool)
    @apicall(:LLVMBuildAtomicRMW, LLVMValueRef, (LLVMBuilderRef, LLVMAtomicRMWBinOp, LLVMValueRef, LLVMValueRef, LLVMAtomicOrdering, LLVMBool), B, op, PTR, Val, ordering, singleThread)
end

function LLVMBuildAtomicCmpXchg(B::LLVMBuilderRef, Ptr::LLVMValueRef, Cmp::LLVMValueRef, New::LLVMValueRef, SuccessOrdering::LLVMAtomicOrdering, FailureOrdering::LLVMAtomicOrdering, SingleThread::LLVMBool)
    @apicall(:LLVMBuildAtomicCmpXchg, LLVMValueRef, (LLVMBuilderRef, LLVMValueRef, LLVMValueRef, LLVMValueRef, LLVMAtomicOrdering, LLVMAtomicOrdering, LLVMBool), B, Ptr, Cmp, New, SuccessOrdering, FailureOrdering, SingleThread)
end

function LLVMIsAtomicSingleThread(AtomicInst::LLVMValueRef)
    @apicall(:LLVMIsAtomicSingleThread, LLVMBool, (LLVMValueRef,), AtomicInst)
end

function LLVMSetAtomicSingleThread(AtomicInst::LLVMValueRef, SingleThread::LLVMBool)
    @apicall(:LLVMSetAtomicSingleThread, Cvoid, (LLVMValueRef, LLVMBool), AtomicInst, SingleThread)
end

function LLVMGetCmpXchgSuccessOrdering(CmpXchgInst::LLVMValueRef)
    @apicall(:LLVMGetCmpXchgSuccessOrdering, LLVMAtomicOrdering, (LLVMValueRef,), CmpXchgInst)
end

function LLVMSetCmpXchgSuccessOrdering(CmpXchgInst::LLVMValueRef, Ordering::LLVMAtomicOrdering)
    @apicall(:LLVMSetCmpXchgSuccessOrdering, Cvoid, (LLVMValueRef, LLVMAtomicOrdering), CmpXchgInst, Ordering)
end

function LLVMGetCmpXchgFailureOrdering(CmpXchgInst::LLVMValueRef)
    @apicall(:LLVMGetCmpXchgFailureOrdering, LLVMAtomicOrdering, (LLVMValueRef,), CmpXchgInst)
end

function LLVMSetCmpXchgFailureOrdering(CmpXchgInst::LLVMValueRef, Ordering::LLVMAtomicOrdering)
    @apicall(:LLVMSetCmpXchgFailureOrdering, Cvoid, (LLVMValueRef, LLVMAtomicOrdering), CmpXchgInst, Ordering)
end

function LLVMCreateModuleProviderForExistingModule(M::LLVMModuleRef)
    @apicall(:LLVMCreateModuleProviderForExistingModule, LLVMModuleProviderRef, (LLVMModuleRef,), M)
end

function LLVMDisposeModuleProvider(M::LLVMModuleProviderRef)
    @apicall(:LLVMDisposeModuleProvider, Cvoid, (LLVMModuleProviderRef,), M)
end

function LLVMCreateMemoryBufferWithContentsOfFile(Path, OutMemBuf, OutMessage)
    @apicall(:LLVMCreateMemoryBufferWithContentsOfFile, LLVMBool, (Cstring, Ptr{LLVMMemoryBufferRef}, Ptr{Cstring}), Path, OutMemBuf, OutMessage)
end

function LLVMCreateMemoryBufferWithSTDIN(OutMemBuf, OutMessage)
    @apicall(:LLVMCreateMemoryBufferWithSTDIN, LLVMBool, (Ptr{LLVMMemoryBufferRef}, Ptr{Cstring}), OutMemBuf, OutMessage)
end

function LLVMCreateMemoryBufferWithMemoryRange(InputData, InputDataLength::Csize_t, BufferName, RequiresNullTerminator::LLVMBool)
    @apicall(:LLVMCreateMemoryBufferWithMemoryRange, LLVMMemoryBufferRef, (Cstring, Csize_t, Cstring, LLVMBool), InputData, InputDataLength, BufferName, RequiresNullTerminator)
end

function LLVMCreateMemoryBufferWithMemoryRangeCopy(InputData, InputDataLength::Csize_t, BufferName)
    @apicall(:LLVMCreateMemoryBufferWithMemoryRangeCopy, LLVMMemoryBufferRef, (Cstring, Csize_t, Cstring), InputData, InputDataLength, BufferName)
end

function LLVMGetBufferStart(MemBuf::LLVMMemoryBufferRef)
    @apicall(:LLVMGetBufferStart, Cstring, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMGetBufferSize(MemBuf::LLVMMemoryBufferRef)
    @apicall(:LLVMGetBufferSize, Csize_t, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMDisposeMemoryBuffer(MemBuf::LLVMMemoryBufferRef)
    @apicall(:LLVMDisposeMemoryBuffer, Cvoid, (LLVMMemoryBufferRef,), MemBuf)
end

function LLVMGetGlobalPassRegistry()
    @apicall(:LLVMGetGlobalPassRegistry, LLVMPassRegistryRef, ())
end

function LLVMCreatePassManager()
    @apicall(:LLVMCreatePassManager, LLVMPassManagerRef, ())
end

function LLVMCreateFunctionPassManagerForModule(M::LLVMModuleRef)
    @apicall(:LLVMCreateFunctionPassManagerForModule, LLVMPassManagerRef, (LLVMModuleRef,), M)
end

function LLVMCreateFunctionPassManager(MP::LLVMModuleProviderRef)
    @apicall(:LLVMCreateFunctionPassManager, LLVMPassManagerRef, (LLVMModuleProviderRef,), MP)
end

function LLVMRunPassManager(PM::LLVMPassManagerRef, M::LLVMModuleRef)
    @apicall(:LLVMRunPassManager, LLVMBool, (LLVMPassManagerRef, LLVMModuleRef), PM, M)
end

function LLVMInitializeFunctionPassManager(FPM::LLVMPassManagerRef)
    @apicall(:LLVMInitializeFunctionPassManager, LLVMBool, (LLVMPassManagerRef,), FPM)
end

function LLVMRunFunctionPassManager(FPM::LLVMPassManagerRef, F::LLVMValueRef)
    @apicall(:LLVMRunFunctionPassManager, LLVMBool, (LLVMPassManagerRef, LLVMValueRef), FPM, F)
end

function LLVMFinalizeFunctionPassManager(FPM::LLVMPassManagerRef)
    @apicall(:LLVMFinalizeFunctionPassManager, LLVMBool, (LLVMPassManagerRef,), FPM)
end

function LLVMDisposePassManager(PM::LLVMPassManagerRef)
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


# Julia wrapper for header: llvm-c/Disassembler.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMCreateDisasm(TripleName, DisInfo, TagType::Cint, GetOpInfo::LLVMOpInfoCallback, SymbolLookUp::LLVMSymbolLookupCallback)
    @apicall(:LLVMCreateDisasm, LLVMDisasmContextRef, (Cstring, Ptr{Cvoid}, Cint, LLVMOpInfoCallback, LLVMSymbolLookupCallback), TripleName, DisInfo, TagType, GetOpInfo, SymbolLookUp)
end

function LLVMCreateDisasmCPU(Triple, CPU, DisInfo, TagType::Cint, GetOpInfo::LLVMOpInfoCallback, SymbolLookUp::LLVMSymbolLookupCallback)
    @apicall(:LLVMCreateDisasmCPU, LLVMDisasmContextRef, (Cstring, Cstring, Ptr{Cvoid}, Cint, LLVMOpInfoCallback, LLVMSymbolLookupCallback), Triple, CPU, DisInfo, TagType, GetOpInfo, SymbolLookUp)
end

function LLVMCreateDisasmCPUFeatures(Triple, CPU, Features, DisInfo, TagType::Cint, GetOpInfo::LLVMOpInfoCallback, SymbolLookUp::LLVMSymbolLookupCallback)
    @apicall(:LLVMCreateDisasmCPUFeatures, LLVMDisasmContextRef, (Cstring, Cstring, Cstring, Ptr{Cvoid}, Cint, LLVMOpInfoCallback, LLVMSymbolLookupCallback), Triple, CPU, Features, DisInfo, TagType, GetOpInfo, SymbolLookUp)
end

function LLVMSetDisasmOptions(DC::LLVMDisasmContextRef, Options::UInt64)
    @apicall(:LLVMSetDisasmOptions, Cint, (LLVMDisasmContextRef, UInt64), DC, Options)
end

function LLVMDisasmDispose(DC::LLVMDisasmContextRef)
    @apicall(:LLVMDisasmDispose, Cvoid, (LLVMDisasmContextRef,), DC)
end

function LLVMDisasmInstruction(DC::LLVMDisasmContextRef, Bytes, BytesSize::UInt64, PC::UInt64, OutString, OutStringSize::Csize_t)
    @apicall(:LLVMDisasmInstruction, Csize_t, (LLVMDisasmContextRef, Ptr{UInt8}, UInt64, UInt64, Cstring, Csize_t), DC, Bytes, BytesSize, PC, OutString, OutStringSize)
end


# Julia wrapper for header: llvm-c/ExecutionEngine.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMLinkInMCJIT()
    @apicall(:LLVMLinkInMCJIT, Cvoid, ())
end

function LLVMLinkInInterpreter()
    @apicall(:LLVMLinkInInterpreter, Cvoid, ())
end

function LLVMCreateGenericValueOfInt(Ty::LLVMTypeRef, N::Culonglong, IsSigned::LLVMBool)
    @apicall(:LLVMCreateGenericValueOfInt, LLVMGenericValueRef, (LLVMTypeRef, Culonglong, LLVMBool), Ty, N, IsSigned)
end

function LLVMCreateGenericValueOfPointer(P)
    @apicall(:LLVMCreateGenericValueOfPointer, LLVMGenericValueRef, (Ptr{Cvoid},), P)
end

function LLVMCreateGenericValueOfFloat(Ty::LLVMTypeRef, N::Cdouble)
    @apicall(:LLVMCreateGenericValueOfFloat, LLVMGenericValueRef, (LLVMTypeRef, Cdouble), Ty, N)
end

function LLVMGenericValueIntWidth(GenValRef::LLVMGenericValueRef)
    @apicall(:LLVMGenericValueIntWidth, UInt32, (LLVMGenericValueRef,), GenValRef)
end

function LLVMGenericValueToInt(GenVal::LLVMGenericValueRef, IsSigned::LLVMBool)
    @apicall(:LLVMGenericValueToInt, Culonglong, (LLVMGenericValueRef, LLVMBool), GenVal, IsSigned)
end

function LLVMGenericValueToPointer(GenVal::LLVMGenericValueRef)
    @apicall(:LLVMGenericValueToPointer, Ptr{Cvoid}, (LLVMGenericValueRef,), GenVal)
end

function LLVMGenericValueToFloat(TyRef::LLVMTypeRef, GenVal::LLVMGenericValueRef)
    @apicall(:LLVMGenericValueToFloat, Cdouble, (LLVMTypeRef, LLVMGenericValueRef), TyRef, GenVal)
end

function LLVMDisposeGenericValue(GenVal::LLVMGenericValueRef)
    @apicall(:LLVMDisposeGenericValue, Cvoid, (LLVMGenericValueRef,), GenVal)
end

function LLVMCreateExecutionEngineForModule(OutEE, M::LLVMModuleRef, OutError)
    @apicall(:LLVMCreateExecutionEngineForModule, LLVMBool, (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, Ptr{Cstring}), OutEE, M, OutError)
end

function LLVMCreateInterpreterForModule(OutInterp, M::LLVMModuleRef, OutError)
    @apicall(:LLVMCreateInterpreterForModule, LLVMBool, (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, Ptr{Cstring}), OutInterp, M, OutError)
end

function LLVMCreateJITCompilerForModule(OutJIT, M::LLVMModuleRef, OptLevel::UInt32, OutError)
    @apicall(:LLVMCreateJITCompilerForModule, LLVMBool, (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, UInt32, Ptr{Cstring}), OutJIT, M, OptLevel, OutError)
end

function LLVMInitializeMCJITCompilerOptions(Options, SizeOfOptions::Csize_t)
    @apicall(:LLVMInitializeMCJITCompilerOptions, Cvoid, (Ptr{LLVMMCJITCompilerOptions}, Csize_t), Options, SizeOfOptions)
end

function LLVMCreateMCJITCompilerForModule(OutJIT, M::LLVMModuleRef, Options, SizeOfOptions::Csize_t, OutError)
    @apicall(:LLVMCreateMCJITCompilerForModule, LLVMBool, (Ptr{LLVMExecutionEngineRef}, LLVMModuleRef, Ptr{LLVMMCJITCompilerOptions}, Csize_t, Ptr{Cstring}), OutJIT, M, Options, SizeOfOptions, OutError)
end

function LLVMDisposeExecutionEngine(EE::LLVMExecutionEngineRef)
    @apicall(:LLVMDisposeExecutionEngine, Cvoid, (LLVMExecutionEngineRef,), EE)
end

function LLVMRunStaticConstructors(EE::LLVMExecutionEngineRef)
    @apicall(:LLVMRunStaticConstructors, Cvoid, (LLVMExecutionEngineRef,), EE)
end

function LLVMRunStaticDestructors(EE::LLVMExecutionEngineRef)
    @apicall(:LLVMRunStaticDestructors, Cvoid, (LLVMExecutionEngineRef,), EE)
end

function LLVMRunFunctionAsMain(EE::LLVMExecutionEngineRef, F::LLVMValueRef, ArgC::UInt32, ArgV, EnvP)
    @apicall(:LLVMRunFunctionAsMain, Cint, (LLVMExecutionEngineRef, LLVMValueRef, UInt32, Ptr{Cstring}, Ptr{Cstring}), EE, F, ArgC, ArgV, EnvP)
end

function LLVMRunFunction(EE::LLVMExecutionEngineRef, F::LLVMValueRef, NumArgs::UInt32, Args)
    @apicall(:LLVMRunFunction, LLVMGenericValueRef, (LLVMExecutionEngineRef, LLVMValueRef, UInt32, Ptr{LLVMGenericValueRef}), EE, F, NumArgs, Args)
end

function LLVMFreeMachineCodeForFunction(EE::LLVMExecutionEngineRef, F::LLVMValueRef)
    @apicall(:LLVMFreeMachineCodeForFunction, Cvoid, (LLVMExecutionEngineRef, LLVMValueRef), EE, F)
end

function LLVMAddModule(EE::LLVMExecutionEngineRef, M::LLVMModuleRef)
    @apicall(:LLVMAddModule, Cvoid, (LLVMExecutionEngineRef, LLVMModuleRef), EE, M)
end

function LLVMRemoveModule(EE::LLVMExecutionEngineRef, M::LLVMModuleRef, OutMod, OutError)
    @apicall(:LLVMRemoveModule, LLVMBool, (LLVMExecutionEngineRef, LLVMModuleRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), EE, M, OutMod, OutError)
end

function LLVMFindFunction(EE::LLVMExecutionEngineRef, Name, OutFn)
    @apicall(:LLVMFindFunction, LLVMBool, (LLVMExecutionEngineRef, Cstring, Ptr{LLVMValueRef}), EE, Name, OutFn)
end

function LLVMRecompileAndRelinkFunction(EE::LLVMExecutionEngineRef, Fn::LLVMValueRef)
    @apicall(:LLVMRecompileAndRelinkFunction, Ptr{Cvoid}, (LLVMExecutionEngineRef, LLVMValueRef), EE, Fn)
end

function LLVMGetExecutionEngineTargetData(EE::LLVMExecutionEngineRef)
    @apicall(:LLVMGetExecutionEngineTargetData, LLVMTargetDataRef, (LLVMExecutionEngineRef,), EE)
end

function LLVMGetExecutionEngineTargetMachine(EE::LLVMExecutionEngineRef)
    @apicall(:LLVMGetExecutionEngineTargetMachine, LLVMTargetMachineRef, (LLVMExecutionEngineRef,), EE)
end

function LLVMAddGlobalMapping(EE::LLVMExecutionEngineRef, Global::LLVMValueRef, Addr)
    @apicall(:LLVMAddGlobalMapping, Cvoid, (LLVMExecutionEngineRef, LLVMValueRef, Ptr{Cvoid}), EE, Global, Addr)
end

function LLVMGetPointerToGlobal(EE::LLVMExecutionEngineRef, Global::LLVMValueRef)
    @apicall(:LLVMGetPointerToGlobal, Ptr{Cvoid}, (LLVMExecutionEngineRef, LLVMValueRef), EE, Global)
end

function LLVMGetGlobalValueAddress(EE::LLVMExecutionEngineRef, Name)
    @apicall(:LLVMGetGlobalValueAddress, UInt64, (LLVMExecutionEngineRef, Cstring), EE, Name)
end

function LLVMGetFunctionAddress(EE::LLVMExecutionEngineRef, Name)
    @apicall(:LLVMGetFunctionAddress, UInt64, (LLVMExecutionEngineRef, Cstring), EE, Name)
end

function LLVMCreateSimpleMCJITMemoryManager(Opaque, AllocateCodeSection::LLVMMemoryManagerAllocateCodeSectionCallback, AllocateDataSection::LLVMMemoryManagerAllocateDataSectionCallback, FinalizeMemory::LLVMMemoryManagerFinalizeMemoryCallback, Destroy::LLVMMemoryManagerDestroyCallback)
    @apicall(:LLVMCreateSimpleMCJITMemoryManager, LLVMMCJITMemoryManagerRef, (Ptr{Cvoid}, LLVMMemoryManagerAllocateCodeSectionCallback, LLVMMemoryManagerAllocateDataSectionCallback, LLVMMemoryManagerFinalizeMemoryCallback, LLVMMemoryManagerDestroyCallback), Opaque, AllocateCodeSection, AllocateDataSection, FinalizeMemory, Destroy)
end

function LLVMDisposeMCJITMemoryManager(MM::LLVMMCJITMemoryManagerRef)
    @apicall(:LLVMDisposeMCJITMemoryManager, Cvoid, (LLVMMCJITMemoryManagerRef,), MM)
end


# Julia wrapper for header: llvm-c/Initialization.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMInitializeCore(R::LLVMPassRegistryRef)
    @apicall(:LLVMInitializeCore, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeTransformUtils(R::LLVMPassRegistryRef)
    @apicall(:LLVMInitializeTransformUtils, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeScalarOpts(R::LLVMPassRegistryRef)
    @apicall(:LLVMInitializeScalarOpts, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeObjCARCOpts(R::LLVMPassRegistryRef)
    @apicall(:LLVMInitializeObjCARCOpts, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeVectorization(R::LLVMPassRegistryRef)
    @apicall(:LLVMInitializeVectorization, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeInstCombine(R::LLVMPassRegistryRef)
    @apicall(:LLVMInitializeInstCombine, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeIPO(R::LLVMPassRegistryRef)
    @apicall(:LLVMInitializeIPO, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeInstrumentation(R::LLVMPassRegistryRef)
    @apicall(:LLVMInitializeInstrumentation, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeAnalysis(R::LLVMPassRegistryRef)
    @apicall(:LLVMInitializeAnalysis, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeIPA(R::LLVMPassRegistryRef)
    @apicall(:LLVMInitializeIPA, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeCodeGen(R::LLVMPassRegistryRef)
    @apicall(:LLVMInitializeCodeGen, Cvoid, (LLVMPassRegistryRef,), R)
end

function LLVMInitializeTarget(R::LLVMPassRegistryRef)
    @apicall(:LLVMInitializeTarget, Cvoid, (LLVMPassRegistryRef,), R)
end


# Julia wrapper for header: llvm-c/IRReader.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMParseIRInContext(ContextRef::LLVMContextRef, MemBuf::LLVMMemoryBufferRef, OutM, OutMessage)
    @apicall(:LLVMParseIRInContext, LLVMBool, (LLVMContextRef, LLVMMemoryBufferRef, Ptr{LLVMModuleRef}, Ptr{Cstring}), ContextRef, MemBuf, OutM, OutMessage)
end


# Julia wrapper for header: llvm-c/Linker.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMLinkModules2(Dest::LLVMModuleRef, Src::LLVMModuleRef)
    @apicall(:LLVMLinkModules2, LLVMBool, (LLVMModuleRef, LLVMModuleRef), Dest, Src)
end


# Julia wrapper for header: llvm-c/LinkTimeOptimizer.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function llvm_create_optimizer()
    @apicall(:llvm_create_optimizer, llvm_lto_t, ())
end

function llvm_destroy_optimizer(lto::llvm_lto_t)
    @apicall(:llvm_destroy_optimizer, Cvoid, (llvm_lto_t,), lto)
end

function llvm_read_object_file(lto::llvm_lto_t, input_filename)
    @apicall(:llvm_read_object_file, llvm_lto_status_t, (llvm_lto_t, Cstring), lto, input_filename)
end

function llvm_optimize_modules(lto::llvm_lto_t, output_filename)
    @apicall(:llvm_optimize_modules, llvm_lto_status_t, (llvm_lto_t, Cstring), lto, output_filename)
end


# Julia wrapper for header: llvm-c/lto.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

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

function lto_module_has_objc_category(mem, length::Csize_t)
    @apicall(:lto_module_has_objc_category, lto_bool_t, (Ptr{Cvoid}, Csize_t), mem, length)
end

function lto_module_is_object_file_in_memory(mem, length::Csize_t)
    @apicall(:lto_module_is_object_file_in_memory, lto_bool_t, (Ptr{Cvoid}, Csize_t), mem, length)
end

function lto_module_is_object_file_in_memory_for_target(mem, length::Csize_t, target_triple_prefix)
    @apicall(:lto_module_is_object_file_in_memory_for_target, lto_bool_t, (Ptr{Cvoid}, Csize_t, Cstring), mem, length, target_triple_prefix)
end

function lto_module_create(path)
    @apicall(:lto_module_create, lto_module_t, (Cstring,), path)
end

function lto_module_create_from_memory(mem, length::Csize_t)
    @apicall(:lto_module_create_from_memory, lto_module_t, (Ptr{Cvoid}, Csize_t), mem, length)
end

function lto_module_create_from_memory_with_path(mem, length::Csize_t, path)
    @apicall(:lto_module_create_from_memory_with_path, lto_module_t, (Ptr{Cvoid}, Csize_t, Cstring), mem, length, path)
end

function lto_module_create_in_local_context(mem, length::Csize_t, path)
    @apicall(:lto_module_create_in_local_context, lto_module_t, (Ptr{Cvoid}, Csize_t, Cstring), mem, length, path)
end

function lto_module_create_in_codegen_context(mem, length::Csize_t, path, cg::lto_code_gen_t)
    @apicall(:lto_module_create_in_codegen_context, lto_module_t, (Ptr{Cvoid}, Csize_t, Cstring, lto_code_gen_t), mem, length, path, cg)
end

function lto_module_create_from_fd(fd::Cint, path, file_size::Csize_t)
    @apicall(:lto_module_create_from_fd, lto_module_t, (Cint, Cstring, Csize_t), fd, path, file_size)
end

function lto_module_create_from_fd_at_offset(fd::Cint, path, file_size::Csize_t, map_size::Csize_t, offset::off_t)
    @apicall(:lto_module_create_from_fd_at_offset, lto_module_t, (Cint, Cstring, Csize_t, Csize_t, off_t), fd, path, file_size, map_size, offset)
end

function lto_module_dispose(mod::lto_module_t)
    @apicall(:lto_module_dispose, Cvoid, (lto_module_t,), mod)
end

function lto_module_get_target_triple(mod::lto_module_t)
    @apicall(:lto_module_get_target_triple, Cstring, (lto_module_t,), mod)
end

function lto_module_set_target_triple(mod::lto_module_t, triple)
    @apicall(:lto_module_set_target_triple, Cvoid, (lto_module_t, Cstring), mod, triple)
end

function lto_module_get_num_symbols(mod::lto_module_t)
    @apicall(:lto_module_get_num_symbols, UInt32, (lto_module_t,), mod)
end

function lto_module_get_symbol_name(mod::lto_module_t, index::UInt32)
    @apicall(:lto_module_get_symbol_name, Cstring, (lto_module_t, UInt32), mod, index)
end

function lto_module_get_symbol_attribute(mod::lto_module_t, index::UInt32)
    @apicall(:lto_module_get_symbol_attribute, lto_symbol_attributes, (lto_module_t, UInt32), mod, index)
end

function lto_module_get_linkeropts(mod::lto_module_t)
    @apicall(:lto_module_get_linkeropts, Cstring, (lto_module_t,), mod)
end

function lto_codegen_set_diagnostic_handler(arg1::lto_code_gen_t, arg2::lto_diagnostic_handler_t, arg3)
    @apicall(:lto_codegen_set_diagnostic_handler, Cvoid, (lto_code_gen_t, lto_diagnostic_handler_t, Ptr{Cvoid}), arg1, arg2, arg3)
end

function lto_codegen_create()
    @apicall(:lto_codegen_create, lto_code_gen_t, ())
end

function lto_codegen_create_in_local_context()
    @apicall(:lto_codegen_create_in_local_context, lto_code_gen_t, ())
end

function lto_codegen_dispose(arg1::lto_code_gen_t)
    @apicall(:lto_codegen_dispose, Cvoid, (lto_code_gen_t,), arg1)
end

function lto_codegen_add_module(cg::lto_code_gen_t, mod::lto_module_t)
    @apicall(:lto_codegen_add_module, lto_bool_t, (lto_code_gen_t, lto_module_t), cg, mod)
end

function lto_codegen_set_module(cg::lto_code_gen_t, mod::lto_module_t)
    @apicall(:lto_codegen_set_module, Cvoid, (lto_code_gen_t, lto_module_t), cg, mod)
end

function lto_codegen_set_debug_model(cg::lto_code_gen_t, arg1::lto_debug_model)
    @apicall(:lto_codegen_set_debug_model, lto_bool_t, (lto_code_gen_t, lto_debug_model), cg, arg1)
end

function lto_codegen_set_pic_model(cg::lto_code_gen_t, arg1::lto_codegen_model)
    @apicall(:lto_codegen_set_pic_model, lto_bool_t, (lto_code_gen_t, lto_codegen_model), cg, arg1)
end

function lto_codegen_set_cpu(cg::lto_code_gen_t, cpu)
    @apicall(:lto_codegen_set_cpu, Cvoid, (lto_code_gen_t, Cstring), cg, cpu)
end

function lto_codegen_set_assembler_path(cg::lto_code_gen_t, path)
    @apicall(:lto_codegen_set_assembler_path, Cvoid, (lto_code_gen_t, Cstring), cg, path)
end

function lto_codegen_set_assembler_args(cg::lto_code_gen_t, args, nargs::Cint)
    @apicall(:lto_codegen_set_assembler_args, Cvoid, (lto_code_gen_t, Ptr{Cstring}, Cint), cg, args, nargs)
end

function lto_codegen_add_must_preserve_symbol(cg::lto_code_gen_t, symbol)
    @apicall(:lto_codegen_add_must_preserve_symbol, Cvoid, (lto_code_gen_t, Cstring), cg, symbol)
end

function lto_codegen_write_merged_modules(cg::lto_code_gen_t, path)
    @apicall(:lto_codegen_write_merged_modules, lto_bool_t, (lto_code_gen_t, Cstring), cg, path)
end

function lto_codegen_compile(cg::lto_code_gen_t, length)
    @apicall(:lto_codegen_compile, Ptr{Cvoid}, (lto_code_gen_t, Ptr{Csize_t}), cg, length)
end

function lto_codegen_compile_to_file(cg::lto_code_gen_t, name)
    @apicall(:lto_codegen_compile_to_file, lto_bool_t, (lto_code_gen_t, Ptr{Cstring}), cg, name)
end

function lto_codegen_optimize(cg::lto_code_gen_t)
    @apicall(:lto_codegen_optimize, lto_bool_t, (lto_code_gen_t,), cg)
end

function lto_codegen_compile_optimized(cg::lto_code_gen_t, length)
    @apicall(:lto_codegen_compile_optimized, Ptr{Cvoid}, (lto_code_gen_t, Ptr{Csize_t}), cg, length)
end

function lto_api_version()
    @apicall(:lto_api_version, UInt32, ())
end

function lto_codegen_debug_options(cg::lto_code_gen_t, arg1)
    @apicall(:lto_codegen_debug_options, Cvoid, (lto_code_gen_t, Cstring), cg, arg1)
end

function lto_initialize_disassembler()
    @apicall(:lto_initialize_disassembler, Cvoid, ())
end

function lto_codegen_set_should_internalize(cg::lto_code_gen_t, ShouldInternalize::lto_bool_t)
    @apicall(:lto_codegen_set_should_internalize, Cvoid, (lto_code_gen_t, lto_bool_t), cg, ShouldInternalize)
end

function lto_codegen_set_should_embed_uselists(cg::lto_code_gen_t, ShouldEmbedUselists::lto_bool_t)
    @apicall(:lto_codegen_set_should_embed_uselists, Cvoid, (lto_code_gen_t, lto_bool_t), cg, ShouldEmbedUselists)
end

function thinlto_create_codegen()
    @apicall(:thinlto_create_codegen, thinlto_code_gen_t, ())
end

function thinlto_codegen_dispose(cg::thinlto_code_gen_t)
    @apicall(:thinlto_codegen_dispose, Cvoid, (thinlto_code_gen_t,), cg)
end

function thinlto_codegen_add_module(cg::thinlto_code_gen_t, identifier, data, length::Cint)
    @apicall(:thinlto_codegen_add_module, Cvoid, (thinlto_code_gen_t, Cstring, Cstring, Cint), cg, identifier, data, length)
end

function thinlto_codegen_process(cg::thinlto_code_gen_t)
    @apicall(:thinlto_codegen_process, Cvoid, (thinlto_code_gen_t,), cg)
end

function thinlto_module_get_num_objects(cg::thinlto_code_gen_t)
    @apicall(:thinlto_module_get_num_objects, UInt32, (thinlto_code_gen_t,), cg)
end

function thinlto_module_get_object(cg::thinlto_code_gen_t, index::UInt32)
    @apicall(:thinlto_module_get_object, LTOObjectBuffer, (thinlto_code_gen_t, UInt32), cg, index)
end

function thinlto_module_get_num_object_files(cg::thinlto_code_gen_t)
    @apicall(:thinlto_module_get_num_object_files, UInt32, (thinlto_code_gen_t,), cg)
end

function thinlto_module_get_object_file(cg::thinlto_code_gen_t, index::UInt32)
    @apicall(:thinlto_module_get_object_file, Cstring, (thinlto_code_gen_t, UInt32), cg, index)
end

function thinlto_codegen_set_pic_model(cg::thinlto_code_gen_t, arg1::lto_codegen_model)
    @apicall(:thinlto_codegen_set_pic_model, lto_bool_t, (thinlto_code_gen_t, lto_codegen_model), cg, arg1)
end

function thinlto_codegen_set_cache_dir(cg::thinlto_code_gen_t, cache_dir)
    @apicall(:thinlto_codegen_set_cache_dir, Cvoid, (thinlto_code_gen_t, Cstring), cg, cache_dir)
end

function thinlto_codegen_set_cache_pruning_interval(cg::thinlto_code_gen_t, interval::Cint)
    @apicall(:thinlto_codegen_set_cache_pruning_interval, Cvoid, (thinlto_code_gen_t, Cint), cg, interval)
end

function thinlto_codegen_set_final_cache_size_relative_to_available_space(cg::thinlto_code_gen_t, percentage::UInt32)
    @apicall(:thinlto_codegen_set_final_cache_size_relative_to_available_space, Cvoid, (thinlto_code_gen_t, UInt32), cg, percentage)
end

function thinlto_codegen_set_cache_entry_expiration(cg::thinlto_code_gen_t, expiration::UInt32)
    @apicall(:thinlto_codegen_set_cache_entry_expiration, Cvoid, (thinlto_code_gen_t, UInt32), cg, expiration)
end

function thinlto_codegen_set_savetemps_dir(cg::thinlto_code_gen_t, save_temps_dir)
    @apicall(:thinlto_codegen_set_savetemps_dir, Cvoid, (thinlto_code_gen_t, Cstring), cg, save_temps_dir)
end

function thinlto_set_generated_objects_dir(cg::thinlto_code_gen_t, save_temps_dir)
    @apicall(:thinlto_set_generated_objects_dir, Cvoid, (thinlto_code_gen_t, Cstring), cg, save_temps_dir)
end

function thinlto_codegen_set_cpu(cg::thinlto_code_gen_t, cpu)
    @apicall(:thinlto_codegen_set_cpu, Cvoid, (thinlto_code_gen_t, Cstring), cg, cpu)
end

function thinlto_codegen_disable_codegen(cg::thinlto_code_gen_t, disable::lto_bool_t)
    @apicall(:thinlto_codegen_disable_codegen, Cvoid, (thinlto_code_gen_t, lto_bool_t), cg, disable)
end

function thinlto_codegen_set_codegen_only(cg::thinlto_code_gen_t, codegen_only::lto_bool_t)
    @apicall(:thinlto_codegen_set_codegen_only, Cvoid, (thinlto_code_gen_t, lto_bool_t), cg, codegen_only)
end

function thinlto_debug_options(options, number::Cint)
    @apicall(:thinlto_debug_options, Cvoid, (Ptr{Cstring}, Cint), options, number)
end

function lto_module_is_thinlto(mod::lto_module_t)
    @apicall(:lto_module_is_thinlto, lto_bool_t, (lto_module_t,), mod)
end

function thinlto_codegen_add_must_preserve_symbol(cg::thinlto_code_gen_t, name, length::Cint)
    @apicall(:thinlto_codegen_add_must_preserve_symbol, Cvoid, (thinlto_code_gen_t, Cstring, Cint), cg, name, length)
end

function thinlto_codegen_add_cross_referenced_symbol(cg::thinlto_code_gen_t, name, length::Cint)
    @apicall(:thinlto_codegen_add_cross_referenced_symbol, Cvoid, (thinlto_code_gen_t, Cstring, Cint), cg, name, length)
end


# Julia wrapper for header: llvm-c/OrcBindings.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMOrcMakeSharedModule(Mod::LLVMModuleRef)
    @apicall(:LLVMOrcMakeSharedModule, LLVMSharedModuleRef, (LLVMModuleRef,), Mod)
end

function LLVMOrcDisposeSharedModuleRef(SharedMod::LLVMSharedModuleRef)
    @apicall(:LLVMOrcDisposeSharedModuleRef, Cvoid, (LLVMSharedModuleRef,), SharedMod)
end

function LLVMOrcCreateInstance(TM::LLVMTargetMachineRef)
    @apicall(:LLVMOrcCreateInstance, LLVMOrcJITStackRef, (LLVMTargetMachineRef,), TM)
end

function LLVMOrcGetErrorMsg(JITStack::LLVMOrcJITStackRef)
    @apicall(:LLVMOrcGetErrorMsg, Cstring, (LLVMOrcJITStackRef,), JITStack)
end

function LLVMOrcGetMangledSymbol(JITStack::LLVMOrcJITStackRef, MangledSymbol, Symbol)
    @apicall(:LLVMOrcGetMangledSymbol, Cvoid, (LLVMOrcJITStackRef, Ptr{Cstring}, Cstring), JITStack, MangledSymbol, Symbol)
end

function LLVMOrcDisposeMangledSymbol(MangledSymbol)
    @apicall(:LLVMOrcDisposeMangledSymbol, Cvoid, (Cstring,), MangledSymbol)
end

function LLVMOrcCreateLazyCompileCallback(JITStack::LLVMOrcJITStackRef, RetAddr, Callback::LLVMOrcLazyCompileCallbackFn, CallbackCtx)
    @apicall(:LLVMOrcCreateLazyCompileCallback, LLVMOrcErrorCode, (LLVMOrcJITStackRef, Ptr{LLVMOrcTargetAddress}, LLVMOrcLazyCompileCallbackFn, Ptr{Cvoid}), JITStack, RetAddr, Callback, CallbackCtx)
end

function LLVMOrcCreateIndirectStub(JITStack::LLVMOrcJITStackRef, StubName, InitAddr::LLVMOrcTargetAddress)
    @apicall(:LLVMOrcCreateIndirectStub, LLVMOrcErrorCode, (LLVMOrcJITStackRef, Cstring, LLVMOrcTargetAddress), JITStack, StubName, InitAddr)
end

function LLVMOrcSetIndirectStubPointer(JITStack::LLVMOrcJITStackRef, StubName, NewAddr::LLVMOrcTargetAddress)
    @apicall(:LLVMOrcSetIndirectStubPointer, LLVMOrcErrorCode, (LLVMOrcJITStackRef, Cstring, LLVMOrcTargetAddress), JITStack, StubName, NewAddr)
end

function LLVMOrcAddEagerlyCompiledIR(JITStack::LLVMOrcJITStackRef, RetHandle, Mod::LLVMSharedModuleRef, SymbolResolver::LLVMOrcSymbolResolverFn, SymbolResolverCtx)
    @apicall(:LLVMOrcAddEagerlyCompiledIR, LLVMOrcErrorCode, (LLVMOrcJITStackRef, Ptr{LLVMOrcModuleHandle}, LLVMSharedModuleRef, LLVMOrcSymbolResolverFn, Ptr{Cvoid}), JITStack, RetHandle, Mod, SymbolResolver, SymbolResolverCtx)
end

function LLVMOrcAddLazilyCompiledIR(JITStack::LLVMOrcJITStackRef, RetHandle, Mod::LLVMSharedModuleRef, SymbolResolver::LLVMOrcSymbolResolverFn, SymbolResolverCtx)
    @apicall(:LLVMOrcAddLazilyCompiledIR, LLVMOrcErrorCode, (LLVMOrcJITStackRef, Ptr{LLVMOrcModuleHandle}, LLVMSharedModuleRef, LLVMOrcSymbolResolverFn, Ptr{Cvoid}), JITStack, RetHandle, Mod, SymbolResolver, SymbolResolverCtx)
end

function LLVMOrcAddObjectFile(JITStack::LLVMOrcJITStackRef, RetHandle, Obj::LLVMMemoryBufferRef, SymbolResolver::LLVMOrcSymbolResolverFn, SymbolResolverCtx)
    @apicall(:LLVMOrcAddObjectFile, LLVMOrcErrorCode, (LLVMOrcJITStackRef, Ptr{LLVMOrcModuleHandle}, LLVMMemoryBufferRef, LLVMOrcSymbolResolverFn, Ptr{Cvoid}), JITStack, RetHandle, Obj, SymbolResolver, SymbolResolverCtx)
end

function LLVMOrcRemoveModule(JITStack::LLVMOrcJITStackRef, H::LLVMOrcModuleHandle)
    @apicall(:LLVMOrcRemoveModule, LLVMOrcErrorCode, (LLVMOrcJITStackRef, LLVMOrcModuleHandle), JITStack, H)
end

function LLVMOrcGetSymbolAddress(JITStack::LLVMOrcJITStackRef, RetAddr, SymbolName)
    @apicall(:LLVMOrcGetSymbolAddress, LLVMOrcErrorCode, (LLVMOrcJITStackRef, Ptr{LLVMOrcTargetAddress}, Cstring), JITStack, RetAddr, SymbolName)
end

function LLVMOrcDisposeInstance(JITStack::LLVMOrcJITStackRef)
    @apicall(:LLVMOrcDisposeInstance, LLVMOrcErrorCode, (LLVMOrcJITStackRef,), JITStack)
end


# Julia wrapper for header: llvm-c/Support.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMLoadLibraryPermanently(Filename)
    @apicall(:LLVMLoadLibraryPermanently, LLVMBool, (Cstring,), Filename)
end

function LLVMParseCommandLineOptions(argc::Cint, argv, Overview)
    @apicall(:LLVMParseCommandLineOptions, Cvoid, (Cint, Ptr{Cstring}, Cstring), argc, argv, Overview)
end

function LLVMSearchForAddressOfSymbol(symbolName)
    @apicall(:LLVMSearchForAddressOfSymbol, Ptr{Cvoid}, (Cstring,), symbolName)
end

function LLVMAddSymbol(symbolName, symbolValue)
    @apicall(:LLVMAddSymbol, Cvoid, (Cstring, Ptr{Cvoid}), symbolName, symbolValue)
end


# Julia wrapper for header: llvm-c/Transforms/IPO.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMAddArgumentPromotionPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddArgumentPromotionPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddConstantMergePass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddConstantMergePass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCalledValuePropagationPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddCalledValuePropagationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddDeadArgEliminationPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddDeadArgEliminationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddFunctionAttrsPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddFunctionAttrsPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddFunctionInliningPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddFunctionInliningPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddAlwaysInlinerPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddAlwaysInlinerPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddGlobalDCEPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddGlobalDCEPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddGlobalOptimizerPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddGlobalOptimizerPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddIPConstantPropagationPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddIPConstantPropagationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddPruneEHPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddPruneEHPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddIPSCCPPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddIPSCCPPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddInternalizePass(arg1::LLVMPassManagerRef, AllButMain::UInt32)
    @apicall(:LLVMAddInternalizePass, Cvoid, (LLVMPassManagerRef, UInt32), arg1, AllButMain)
end

function LLVMAddStripDeadPrototypesPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddStripDeadPrototypesPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddStripSymbolsPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddStripSymbolsPass, Cvoid, (LLVMPassManagerRef,), PM)
end


# Julia wrapper for header: llvm-c/Transforms/PassManagerBuilder.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMPassManagerBuilderCreate()
    @apicall(:LLVMPassManagerBuilderCreate, LLVMPassManagerBuilderRef, ())
end

function LLVMPassManagerBuilderDispose(PMB::LLVMPassManagerBuilderRef)
    @apicall(:LLVMPassManagerBuilderDispose, Cvoid, (LLVMPassManagerBuilderRef,), PMB)
end

function LLVMPassManagerBuilderSetOptLevel(PMB::LLVMPassManagerBuilderRef, OptLevel::UInt32)
    @apicall(:LLVMPassManagerBuilderSetOptLevel, Cvoid, (LLVMPassManagerBuilderRef, UInt32), PMB, OptLevel)
end

function LLVMPassManagerBuilderSetSizeLevel(PMB::LLVMPassManagerBuilderRef, SizeLevel::UInt32)
    @apicall(:LLVMPassManagerBuilderSetSizeLevel, Cvoid, (LLVMPassManagerBuilderRef, UInt32), PMB, SizeLevel)
end

function LLVMPassManagerBuilderSetDisableUnitAtATime(PMB::LLVMPassManagerBuilderRef, Value::LLVMBool)
    @apicall(:LLVMPassManagerBuilderSetDisableUnitAtATime, Cvoid, (LLVMPassManagerBuilderRef, LLVMBool), PMB, Value)
end

function LLVMPassManagerBuilderSetDisableUnrollLoops(PMB::LLVMPassManagerBuilderRef, Value::LLVMBool)
    @apicall(:LLVMPassManagerBuilderSetDisableUnrollLoops, Cvoid, (LLVMPassManagerBuilderRef, LLVMBool), PMB, Value)
end

function LLVMPassManagerBuilderSetDisableSimplifyLibCalls(PMB::LLVMPassManagerBuilderRef, Value::LLVMBool)
    @apicall(:LLVMPassManagerBuilderSetDisableSimplifyLibCalls, Cvoid, (LLVMPassManagerBuilderRef, LLVMBool), PMB, Value)
end

function LLVMPassManagerBuilderUseInlinerWithThreshold(PMB::LLVMPassManagerBuilderRef, Threshold::UInt32)
    @apicall(:LLVMPassManagerBuilderUseInlinerWithThreshold, Cvoid, (LLVMPassManagerBuilderRef, UInt32), PMB, Threshold)
end

function LLVMPassManagerBuilderPopulateFunctionPassManager(PMB::LLVMPassManagerBuilderRef, PM::LLVMPassManagerRef)
    @apicall(:LLVMPassManagerBuilderPopulateFunctionPassManager, Cvoid, (LLVMPassManagerBuilderRef, LLVMPassManagerRef), PMB, PM)
end

function LLVMPassManagerBuilderPopulateModulePassManager(PMB::LLVMPassManagerBuilderRef, PM::LLVMPassManagerRef)
    @apicall(:LLVMPassManagerBuilderPopulateModulePassManager, Cvoid, (LLVMPassManagerBuilderRef, LLVMPassManagerRef), PMB, PM)
end

function LLVMPassManagerBuilderPopulateLTOPassManager(PMB::LLVMPassManagerBuilderRef, PM::LLVMPassManagerRef, Internalize::LLVMBool, RunInliner::LLVMBool)
    @apicall(:LLVMPassManagerBuilderPopulateLTOPassManager, Cvoid, (LLVMPassManagerBuilderRef, LLVMPassManagerRef, LLVMBool, LLVMBool), PMB, PM, Internalize, RunInliner)
end


# Julia wrapper for header: llvm-c/Transforms/Scalar.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMAddAggressiveDCEPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddAggressiveDCEPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddBitTrackingDCEPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddBitTrackingDCEPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddAlignmentFromAssumptionsPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddAlignmentFromAssumptionsPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCFGSimplificationPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddCFGSimplificationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddDeadStoreEliminationPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddDeadStoreEliminationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScalarizerPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddScalarizerPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddMergedLoadStoreMotionPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddMergedLoadStoreMotionPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddGVNPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddGVNPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddNewGVNPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddNewGVNPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddIndVarSimplifyPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddIndVarSimplifyPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddInstructionCombiningPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddInstructionCombiningPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddJumpThreadingPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddJumpThreadingPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLICMPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddLICMPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopDeletionPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddLoopDeletionPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopIdiomPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddLoopIdiomPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopRotatePass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddLoopRotatePass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopRerollPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddLoopRerollPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopUnrollPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddLoopUnrollPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopUnswitchPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddLoopUnswitchPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddMemCpyOptPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddMemCpyOptPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddPartiallyInlineLibCallsPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddPartiallyInlineLibCallsPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLowerSwitchPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddLowerSwitchPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddPromoteMemoryToRegisterPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddPromoteMemoryToRegisterPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddReassociatePass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddReassociatePass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddSCCPPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddSCCPPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScalarReplAggregatesPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddScalarReplAggregatesPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScalarReplAggregatesPassSSA(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddScalarReplAggregatesPassSSA, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScalarReplAggregatesPassWithThreshold(PM::LLVMPassManagerRef, Threshold::Cint)
    @apicall(:LLVMAddScalarReplAggregatesPassWithThreshold, Cvoid, (LLVMPassManagerRef, Cint), PM, Threshold)
end

function LLVMAddSimplifyLibCallsPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddSimplifyLibCallsPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddTailCallEliminationPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddTailCallEliminationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddConstantPropagationPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddConstantPropagationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddDemoteMemoryToRegisterPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddDemoteMemoryToRegisterPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddVerifierPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddVerifierPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddCorrelatedValuePropagationPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddCorrelatedValuePropagationPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddEarlyCSEPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddEarlyCSEPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddEarlyCSEMemSSAPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddEarlyCSEMemSSAPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLowerExpectIntrinsicPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddLowerExpectIntrinsicPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddTypeBasedAliasAnalysisPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddTypeBasedAliasAnalysisPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddScopedNoAliasAAPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddScopedNoAliasAAPass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddBasicAliasAnalysisPass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddBasicAliasAnalysisPass, Cvoid, (LLVMPassManagerRef,), PM)
end


# Julia wrapper for header: llvm-c/Transforms/Vectorize.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMAddBBVectorizePass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddBBVectorizePass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddLoopVectorizePass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddLoopVectorizePass, Cvoid, (LLVMPassManagerRef,), PM)
end

function LLVMAddSLPVectorizePass(PM::LLVMPassManagerRef)
    @apicall(:LLVMAddSLPVectorizePass, Cvoid, (LLVMPassManagerRef,), PM)
end


# Julia wrapper for header: llvm-c/DebugInfo.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMDebugMetadataVersion()
    @apicall(:LLVMDebugMetadataVersion, UInt32, ())
end

function LLVMGetModuleDebugMetadataVersion(Module::LLVMModuleRef)
    @apicall(:LLVMGetModuleDebugMetadataVersion, UInt32, (LLVMModuleRef,), Module)
end

function LLVMStripModuleDebugInfo(Module::LLVMModuleRef)
    @apicall(:LLVMStripModuleDebugInfo, LLVMBool, (LLVMModuleRef,), Module)
end

function LLVMCreateDIBuilderDisallowUnresolved(M::LLVMModuleRef)
    @apicall(:LLVMCreateDIBuilderDisallowUnresolved, LLVMDIBuilderRef, (LLVMModuleRef,), M)
end

function LLVMCreateDIBuilder(M::LLVMModuleRef)
    @apicall(:LLVMCreateDIBuilder, LLVMDIBuilderRef, (LLVMModuleRef,), M)
end

function LLVMDisposeDIBuilder(Builder::LLVMDIBuilderRef)
    @apicall(:LLVMDisposeDIBuilder, Cvoid, (LLVMDIBuilderRef,), Builder)
end

function LLVMDIBuilderFinalize(Builder::LLVMDIBuilderRef)
    @apicall(:LLVMDIBuilderFinalize, Cvoid, (LLVMDIBuilderRef,), Builder)
end

function LLVMDIBuilderCreateCompileUnit(Builder::LLVMDIBuilderRef, Lang::LLVMDWARFSourceLanguage, FileRef::LLVMMetadataRef, Producer, ProducerLen::Csize_t, isOptimized::LLVMBool, Flags, FlagsLen::Csize_t, RuntimeVer::UInt32, SplitName, SplitNameLen::Csize_t, Kind::LLVMDWARFEmissionKind, DWOId::UInt32, SplitDebugInlining::LLVMBool, DebugInfoForProfiling::LLVMBool)
    @apicall(:LLVMDIBuilderCreateCompileUnit, LLVMMetadataRef, (LLVMDIBuilderRef, LLVMDWARFSourceLanguage, LLVMMetadataRef, Cstring, Csize_t, LLVMBool, Cstring, Csize_t, UInt32, Cstring, Csize_t, LLVMDWARFEmissionKind, UInt32, LLVMBool, LLVMBool), Builder, Lang, FileRef, Producer, ProducerLen, isOptimized, Flags, FlagsLen, RuntimeVer, SplitName, SplitNameLen, Kind, DWOId, SplitDebugInlining, DebugInfoForProfiling)
end

function LLVMDIBuilderCreateFile(Builder::LLVMDIBuilderRef, Filename, FilenameLen::Csize_t, Directory, DirectoryLen::Csize_t)
    @apicall(:LLVMDIBuilderCreateFile, LLVMMetadataRef, (LLVMDIBuilderRef, Cstring, Csize_t, Cstring, Csize_t), Builder, Filename, FilenameLen, Directory, DirectoryLen)
end

function LLVMDIBuilderCreateDebugLocation(Ctx::LLVMContextRef, Line::UInt32, Column::UInt32, Scope::LLVMMetadataRef, InlinedAt::LLVMMetadataRef)
    @apicall(:LLVMDIBuilderCreateDebugLocation, LLVMMetadataRef, (LLVMContextRef, UInt32, UInt32, LLVMMetadataRef, LLVMMetadataRef), Ctx, Line, Column, Scope, InlinedAt)
end
