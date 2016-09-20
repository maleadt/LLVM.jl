# Julia wrapper for header: llvm-c/ErrorHandling.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMInstallFatalErrorHandler(Handler::LLVMFatalErrorHandler)
    ccall((:LLVMInstallFatalErrorHandler,libllvm),Void,(LLVMFatalErrorHandler,),Handler)
end

function LLVMResetFatalErrorHandler()
    ccall((:LLVMResetFatalErrorHandler,libllvm),Void,())
end

function LLVMEnablePrettyStackTrace()
    ccall((:LLVMEnablePrettyStackTrace,libllvm),Void,())
end


# Julia wrapper for header: llvm-c/Object.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMCreateObjectFile(MemBuf::LLVMMemoryBufferRef)
    ccall((:LLVMCreateObjectFile,libllvm),LLVMObjectFileRef,(LLVMMemoryBufferRef,),MemBuf)
end

function LLVMDisposeObjectFile(ObjectFile::LLVMObjectFileRef)
    ccall((:LLVMDisposeObjectFile,libllvm),Void,(LLVMObjectFileRef,),ObjectFile)
end

function LLVMGetSections(ObjectFile::LLVMObjectFileRef)
    ccall((:LLVMGetSections,libllvm),LLVMSectionIteratorRef,(LLVMObjectFileRef,),ObjectFile)
end

function LLVMDisposeSectionIterator(SI::LLVMSectionIteratorRef)
    ccall((:LLVMDisposeSectionIterator,libllvm),Void,(LLVMSectionIteratorRef,),SI)
end

function LLVMIsSectionIteratorAtEnd(ObjectFile::LLVMObjectFileRef,SI::LLVMSectionIteratorRef)
    ccall((:LLVMIsSectionIteratorAtEnd,libllvm),LLVMBool,(LLVMObjectFileRef,LLVMSectionIteratorRef),ObjectFile,SI)
end

function LLVMMoveToNextSection(SI::LLVMSectionIteratorRef)
    ccall((:LLVMMoveToNextSection,libllvm),Void,(LLVMSectionIteratorRef,),SI)
end

function LLVMMoveToContainingSection(Sect::LLVMSectionIteratorRef,Sym::LLVMSymbolIteratorRef)
    ccall((:LLVMMoveToContainingSection,libllvm),Void,(LLVMSectionIteratorRef,LLVMSymbolIteratorRef),Sect,Sym)
end

function LLVMGetSymbols(ObjectFile::LLVMObjectFileRef)
    ccall((:LLVMGetSymbols,libllvm),LLVMSymbolIteratorRef,(LLVMObjectFileRef,),ObjectFile)
end

function LLVMDisposeSymbolIterator(SI::LLVMSymbolIteratorRef)
    ccall((:LLVMDisposeSymbolIterator,libllvm),Void,(LLVMSymbolIteratorRef,),SI)
end

function LLVMIsSymbolIteratorAtEnd(ObjectFile::LLVMObjectFileRef,SI::LLVMSymbolIteratorRef)
    ccall((:LLVMIsSymbolIteratorAtEnd,libllvm),LLVMBool,(LLVMObjectFileRef,LLVMSymbolIteratorRef),ObjectFile,SI)
end

function LLVMMoveToNextSymbol(SI::LLVMSymbolIteratorRef)
    ccall((:LLVMMoveToNextSymbol,libllvm),Void,(LLVMSymbolIteratorRef,),SI)
end

function LLVMGetSectionName(SI::LLVMSectionIteratorRef)
    ccall((:LLVMGetSectionName,libllvm),Cstring,(LLVMSectionIteratorRef,),SI)
end

function LLVMGetSectionSize(SI::LLVMSectionIteratorRef)
    ccall((:LLVMGetSectionSize,libllvm),UInt64,(LLVMSectionIteratorRef,),SI)
end

function LLVMGetSectionContents(SI::LLVMSectionIteratorRef)
    ccall((:LLVMGetSectionContents,libllvm),Cstring,(LLVMSectionIteratorRef,),SI)
end

function LLVMGetSectionAddress(SI::LLVMSectionIteratorRef)
    ccall((:LLVMGetSectionAddress,libllvm),UInt64,(LLVMSectionIteratorRef,),SI)
end

function LLVMGetSectionContainsSymbol(SI::LLVMSectionIteratorRef,Sym::LLVMSymbolIteratorRef)
    ccall((:LLVMGetSectionContainsSymbol,libllvm),LLVMBool,(LLVMSectionIteratorRef,LLVMSymbolIteratorRef),SI,Sym)
end

function LLVMGetRelocations(Section::LLVMSectionIteratorRef)
    ccall((:LLVMGetRelocations,libllvm),LLVMRelocationIteratorRef,(LLVMSectionIteratorRef,),Section)
end

function LLVMDisposeRelocationIterator(RI::LLVMRelocationIteratorRef)
    ccall((:LLVMDisposeRelocationIterator,libllvm),Void,(LLVMRelocationIteratorRef,),RI)
end

function LLVMIsRelocationIteratorAtEnd(Section::LLVMSectionIteratorRef,RI::LLVMRelocationIteratorRef)
    ccall((:LLVMIsRelocationIteratorAtEnd,libllvm),LLVMBool,(LLVMSectionIteratorRef,LLVMRelocationIteratorRef),Section,RI)
end

function LLVMMoveToNextRelocation(RI::LLVMRelocationIteratorRef)
    ccall((:LLVMMoveToNextRelocation,libllvm),Void,(LLVMRelocationIteratorRef,),RI)
end

function LLVMGetSymbolName(SI::LLVMSymbolIteratorRef)
    ccall((:LLVMGetSymbolName,libllvm),Cstring,(LLVMSymbolIteratorRef,),SI)
end

function LLVMGetSymbolAddress(SI::LLVMSymbolIteratorRef)
    ccall((:LLVMGetSymbolAddress,libllvm),UInt64,(LLVMSymbolIteratorRef,),SI)
end

function LLVMGetSymbolSize(SI::LLVMSymbolIteratorRef)
    ccall((:LLVMGetSymbolSize,libllvm),UInt64,(LLVMSymbolIteratorRef,),SI)
end

function LLVMGetRelocationOffset(RI::LLVMRelocationIteratorRef)
    ccall((:LLVMGetRelocationOffset,libllvm),UInt64,(LLVMRelocationIteratorRef,),RI)
end

function LLVMGetRelocationSymbol(RI::LLVMRelocationIteratorRef)
    ccall((:LLVMGetRelocationSymbol,libllvm),LLVMSymbolIteratorRef,(LLVMRelocationIteratorRef,),RI)
end

function LLVMGetRelocationType(RI::LLVMRelocationIteratorRef)
    ccall((:LLVMGetRelocationType,libllvm),UInt64,(LLVMRelocationIteratorRef,),RI)
end

function LLVMGetRelocationTypeName(RI::LLVMRelocationIteratorRef)
    ccall((:LLVMGetRelocationTypeName,libllvm),Cstring,(LLVMRelocationIteratorRef,),RI)
end

function LLVMGetRelocationValueString(RI::LLVMRelocationIteratorRef)
    ccall((:LLVMGetRelocationValueString,libllvm),Cstring,(LLVMRelocationIteratorRef,),RI)
end


# Julia wrapper for header: llvm-c/Target.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMGetModuleDataLayout(M::LLVMModuleRef)
    ccall((:LLVMGetModuleDataLayout,libllvm),LLVMTargetDataRef,(LLVMModuleRef,),M)
end

function LLVMSetModuleDataLayout(M::LLVMModuleRef,DL::LLVMTargetDataRef)
    ccall((:LLVMSetModuleDataLayout,libllvm),Void,(LLVMModuleRef,LLVMTargetDataRef),M,DL)
end

function LLVMCreateTargetData(StringRep)
    ccall((:LLVMCreateTargetData,libllvm),LLVMTargetDataRef,(Cstring,),StringRep)
end

function LLVMDisposeTargetData(TD::LLVMTargetDataRef)
    ccall((:LLVMDisposeTargetData,libllvm),Void,(LLVMTargetDataRef,),TD)
end

function LLVMAddTargetLibraryInfo(TLI::LLVMTargetLibraryInfoRef,PM::LLVMPassManagerRef)
    ccall((:LLVMAddTargetLibraryInfo,libllvm),Void,(LLVMTargetLibraryInfoRef,LLVMPassManagerRef),TLI,PM)
end

function LLVMCopyStringRepOfTargetData(TD::LLVMTargetDataRef)
    ccall((:LLVMCopyStringRepOfTargetData,libllvm),Cstring,(LLVMTargetDataRef,),TD)
end

function LLVMByteOrder(TD::LLVMTargetDataRef)
    ccall((:LLVMByteOrder,libllvm),Cint,(LLVMTargetDataRef,),TD)
end

function LLVMPointerSize(TD::LLVMTargetDataRef)
    ccall((:LLVMPointerSize,libllvm),UInt32,(LLVMTargetDataRef,),TD)
end

function LLVMPointerSizeForAS(TD::LLVMTargetDataRef,AS::UInt32)
    ccall((:LLVMPointerSizeForAS,libllvm),UInt32,(LLVMTargetDataRef,UInt32),TD,AS)
end

function LLVMIntPtrType(TD::LLVMTargetDataRef)
    ccall((:LLVMIntPtrType,libllvm),LLVMTypeRef,(LLVMTargetDataRef,),TD)
end

function LLVMIntPtrTypeForAS(TD::LLVMTargetDataRef,AS::UInt32)
    ccall((:LLVMIntPtrTypeForAS,libllvm),LLVMTypeRef,(LLVMTargetDataRef,UInt32),TD,AS)
end

function LLVMIntPtrTypeInContext(C::LLVMContextRef,TD::LLVMTargetDataRef)
    ccall((:LLVMIntPtrTypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,LLVMTargetDataRef),C,TD)
end

function LLVMIntPtrTypeForASInContext(C::LLVMContextRef,TD::LLVMTargetDataRef,AS::UInt32)
    ccall((:LLVMIntPtrTypeForASInContext,libllvm),LLVMTypeRef,(LLVMContextRef,LLVMTargetDataRef,UInt32),C,TD,AS)
end

function LLVMSizeOfTypeInBits(TD::LLVMTargetDataRef,Ty::LLVMTypeRef)
    ccall((:LLVMSizeOfTypeInBits,libllvm),Culonglong,(LLVMTargetDataRef,LLVMTypeRef),TD,Ty)
end

function LLVMStoreSizeOfType(TD::LLVMTargetDataRef,Ty::LLVMTypeRef)
    ccall((:LLVMStoreSizeOfType,libllvm),Culonglong,(LLVMTargetDataRef,LLVMTypeRef),TD,Ty)
end

function LLVMABISizeOfType(TD::LLVMTargetDataRef,Ty::LLVMTypeRef)
    ccall((:LLVMABISizeOfType,libllvm),Culonglong,(LLVMTargetDataRef,LLVMTypeRef),TD,Ty)
end

function LLVMABIAlignmentOfType(TD::LLVMTargetDataRef,Ty::LLVMTypeRef)
    ccall((:LLVMABIAlignmentOfType,libllvm),UInt32,(LLVMTargetDataRef,LLVMTypeRef),TD,Ty)
end

function LLVMCallFrameAlignmentOfType(TD::LLVMTargetDataRef,Ty::LLVMTypeRef)
    ccall((:LLVMCallFrameAlignmentOfType,libllvm),UInt32,(LLVMTargetDataRef,LLVMTypeRef),TD,Ty)
end

function LLVMPreferredAlignmentOfType(TD::LLVMTargetDataRef,Ty::LLVMTypeRef)
    ccall((:LLVMPreferredAlignmentOfType,libllvm),UInt32,(LLVMTargetDataRef,LLVMTypeRef),TD,Ty)
end

function LLVMPreferredAlignmentOfGlobal(TD::LLVMTargetDataRef,GlobalVar::LLVMValueRef)
    ccall((:LLVMPreferredAlignmentOfGlobal,libllvm),UInt32,(LLVMTargetDataRef,LLVMValueRef),TD,GlobalVar)
end

function LLVMElementAtOffset(TD::LLVMTargetDataRef,StructTy::LLVMTypeRef,Offset::Culonglong)
    ccall((:LLVMElementAtOffset,libllvm),UInt32,(LLVMTargetDataRef,LLVMTypeRef,Culonglong),TD,StructTy,Offset)
end

function LLVMOffsetOfElement(TD::LLVMTargetDataRef,StructTy::LLVMTypeRef,Element::UInt32)
    ccall((:LLVMOffsetOfElement,libllvm),Culonglong,(LLVMTargetDataRef,LLVMTypeRef,UInt32),TD,StructTy,Element)
end


# Julia wrapper for header: llvm-c/TargetMachine.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMGetFirstTarget()
    ccall((:LLVMGetFirstTarget,libllvm),LLVMTargetRef,())
end

function LLVMGetNextTarget(T::LLVMTargetRef)
    ccall((:LLVMGetNextTarget,libllvm),LLVMTargetRef,(LLVMTargetRef,),T)
end

function LLVMGetTargetFromName(Name)
    ccall((:LLVMGetTargetFromName,libllvm),LLVMTargetRef,(Cstring,),Name)
end

function LLVMGetTargetFromTriple(Triple,T,ErrorMessage)
    ccall((:LLVMGetTargetFromTriple,libllvm),LLVMBool,(Cstring,Ptr{LLVMTargetRef},Ptr{Cstring}),Triple,T,ErrorMessage)
end

function LLVMGetTargetName(T::LLVMTargetRef)
    ccall((:LLVMGetTargetName,libllvm),Cstring,(LLVMTargetRef,),T)
end

function LLVMGetTargetDescription(T::LLVMTargetRef)
    ccall((:LLVMGetTargetDescription,libllvm),Cstring,(LLVMTargetRef,),T)
end

function LLVMTargetHasJIT(T::LLVMTargetRef)
    ccall((:LLVMTargetHasJIT,libllvm),LLVMBool,(LLVMTargetRef,),T)
end

function LLVMTargetHasTargetMachine(T::LLVMTargetRef)
    ccall((:LLVMTargetHasTargetMachine,libllvm),LLVMBool,(LLVMTargetRef,),T)
end

function LLVMTargetHasAsmBackend(T::LLVMTargetRef)
    ccall((:LLVMTargetHasAsmBackend,libllvm),LLVMBool,(LLVMTargetRef,),T)
end

function LLVMCreateTargetMachine(T::LLVMTargetRef,Triple,CPU,Features,Level::LLVMCodeGenOptLevel,Reloc::LLVMRelocMode,CodeModel::LLVMCodeModel)
    ccall((:LLVMCreateTargetMachine,libllvm),LLVMTargetMachineRef,(LLVMTargetRef,Cstring,Cstring,Cstring,LLVMCodeGenOptLevel,LLVMRelocMode,LLVMCodeModel),T,Triple,CPU,Features,Level,Reloc,CodeModel)
end

function LLVMDisposeTargetMachine(T::LLVMTargetMachineRef)
    ccall((:LLVMDisposeTargetMachine,libllvm),Void,(LLVMTargetMachineRef,),T)
end

function LLVMGetTargetMachineTarget(T::LLVMTargetMachineRef)
    ccall((:LLVMGetTargetMachineTarget,libllvm),LLVMTargetRef,(LLVMTargetMachineRef,),T)
end

function LLVMGetTargetMachineTriple(T::LLVMTargetMachineRef)
    ccall((:LLVMGetTargetMachineTriple,libllvm),Cstring,(LLVMTargetMachineRef,),T)
end

function LLVMGetTargetMachineCPU(T::LLVMTargetMachineRef)
    ccall((:LLVMGetTargetMachineCPU,libllvm),Cstring,(LLVMTargetMachineRef,),T)
end

function LLVMGetTargetMachineFeatureString(T::LLVMTargetMachineRef)
    ccall((:LLVMGetTargetMachineFeatureString,libllvm),Cstring,(LLVMTargetMachineRef,),T)
end

function LLVMCreateTargetDataLayout(T::LLVMTargetMachineRef)
    ccall((:LLVMCreateTargetDataLayout,libllvm),LLVMTargetDataRef,(LLVMTargetMachineRef,),T)
end

function LLVMSetTargetMachineAsmVerbosity(T::LLVMTargetMachineRef,VerboseAsm::LLVMBool)
    ccall((:LLVMSetTargetMachineAsmVerbosity,libllvm),Void,(LLVMTargetMachineRef,LLVMBool),T,VerboseAsm)
end

function LLVMTargetMachineEmitToFile(T::LLVMTargetMachineRef,M::LLVMModuleRef,Filename,codegen::LLVMCodeGenFileType,ErrorMessage)
    ccall((:LLVMTargetMachineEmitToFile,libllvm),LLVMBool,(LLVMTargetMachineRef,LLVMModuleRef,Cstring,LLVMCodeGenFileType,Ptr{Cstring}),T,M,Filename,codegen,ErrorMessage)
end

function LLVMTargetMachineEmitToMemoryBuffer(T::LLVMTargetMachineRef,M::LLVMModuleRef,codegen::LLVMCodeGenFileType,ErrorMessage,OutMemBuf)
    ccall((:LLVMTargetMachineEmitToMemoryBuffer,libllvm),LLVMBool,(LLVMTargetMachineRef,LLVMModuleRef,LLVMCodeGenFileType,Ptr{Cstring},Ptr{LLVMMemoryBufferRef}),T,M,codegen,ErrorMessage,OutMemBuf)
end

function LLVMGetDefaultTargetTriple()
    ccall((:LLVMGetDefaultTargetTriple,libllvm),Cstring,())
end

function LLVMAddAnalysisPasses(T::LLVMTargetMachineRef,PM::LLVMPassManagerRef)
    ccall((:LLVMAddAnalysisPasses,libllvm),Void,(LLVMTargetMachineRef,LLVMPassManagerRef),T,PM)
end


# Julia wrapper for header: llvm-c/Types.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0


# Julia wrapper for header: llvm-c/Analysis.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMVerifyModule(M::LLVMModuleRef,Action::LLVMVerifierFailureAction,OutMessage)
    ccall((:LLVMVerifyModule,libllvm),LLVMBool,(LLVMModuleRef,LLVMVerifierFailureAction,Ptr{Cstring}),M,Action,OutMessage)
end

function LLVMVerifyFunction(Fn::LLVMValueRef,Action::LLVMVerifierFailureAction)
    ccall((:LLVMVerifyFunction,libllvm),LLVMBool,(LLVMValueRef,LLVMVerifierFailureAction),Fn,Action)
end

function LLVMViewFunctionCFG(Fn::LLVMValueRef)
    ccall((:LLVMViewFunctionCFG,libllvm),Void,(LLVMValueRef,),Fn)
end

function LLVMViewFunctionCFGOnly(Fn::LLVMValueRef)
    ccall((:LLVMViewFunctionCFGOnly,libllvm),Void,(LLVMValueRef,),Fn)
end


# Julia wrapper for header: llvm-c/BitReader.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMParseBitcode(MemBuf::LLVMMemoryBufferRef,OutModule,OutMessage)
    ccall((:LLVMParseBitcode,libllvm),LLVMBool,(LLVMMemoryBufferRef,Ptr{LLVMModuleRef},Ptr{Cstring}),MemBuf,OutModule,OutMessage)
end

function LLVMParseBitcode2(MemBuf::LLVMMemoryBufferRef,OutModule)
    ccall((:LLVMParseBitcode2,libllvm),LLVMBool,(LLVMMemoryBufferRef,Ptr{LLVMModuleRef}),MemBuf,OutModule)
end

function LLVMParseBitcodeInContext(ContextRef::LLVMContextRef,MemBuf::LLVMMemoryBufferRef,OutModule,OutMessage)
    ccall((:LLVMParseBitcodeInContext,libllvm),LLVMBool,(LLVMContextRef,LLVMMemoryBufferRef,Ptr{LLVMModuleRef},Ptr{Cstring}),ContextRef,MemBuf,OutModule,OutMessage)
end

function LLVMParseBitcodeInContext2(ContextRef::LLVMContextRef,MemBuf::LLVMMemoryBufferRef,OutModule)
    ccall((:LLVMParseBitcodeInContext2,libllvm),LLVMBool,(LLVMContextRef,LLVMMemoryBufferRef,Ptr{LLVMModuleRef}),ContextRef,MemBuf,OutModule)
end

function LLVMGetBitcodeModuleInContext(ContextRef::LLVMContextRef,MemBuf::LLVMMemoryBufferRef,OutM,OutMessage)
    ccall((:LLVMGetBitcodeModuleInContext,libllvm),LLVMBool,(LLVMContextRef,LLVMMemoryBufferRef,Ptr{LLVMModuleRef},Ptr{Cstring}),ContextRef,MemBuf,OutM,OutMessage)
end

function LLVMGetBitcodeModuleInContext2(ContextRef::LLVMContextRef,MemBuf::LLVMMemoryBufferRef,OutM)
    ccall((:LLVMGetBitcodeModuleInContext2,libllvm),LLVMBool,(LLVMContextRef,LLVMMemoryBufferRef,Ptr{LLVMModuleRef}),ContextRef,MemBuf,OutM)
end

function LLVMGetBitcodeModule(MemBuf::LLVMMemoryBufferRef,OutM,OutMessage)
    ccall((:LLVMGetBitcodeModule,libllvm),LLVMBool,(LLVMMemoryBufferRef,Ptr{LLVMModuleRef},Ptr{Cstring}),MemBuf,OutM,OutMessage)
end

function LLVMGetBitcodeModule2(MemBuf::LLVMMemoryBufferRef,OutM)
    ccall((:LLVMGetBitcodeModule2,libllvm),LLVMBool,(LLVMMemoryBufferRef,Ptr{LLVMModuleRef}),MemBuf,OutM)
end


# Julia wrapper for header: llvm-c/BitWriter.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMWriteBitcodeToFile(M::LLVMModuleRef,Path)
    ccall((:LLVMWriteBitcodeToFile,libllvm),Cint,(LLVMModuleRef,Cstring),M,Path)
end

function LLVMWriteBitcodeToFD(M::LLVMModuleRef,FD::Cint,ShouldClose::Cint,Unbuffered::Cint)
    ccall((:LLVMWriteBitcodeToFD,libllvm),Cint,(LLVMModuleRef,Cint,Cint,Cint),M,FD,ShouldClose,Unbuffered)
end

function LLVMWriteBitcodeToFileHandle(M::LLVMModuleRef,Handle::Cint)
    ccall((:LLVMWriteBitcodeToFileHandle,libllvm),Cint,(LLVMModuleRef,Cint),M,Handle)
end

function LLVMWriteBitcodeToMemoryBuffer(M::LLVMModuleRef)
    ccall((:LLVMWriteBitcodeToMemoryBuffer,libllvm),LLVMMemoryBufferRef,(LLVMModuleRef,),M)
end


# Julia wrapper for header: llvm-c/Core.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMInitializeCore(R::LLVMPassRegistryRef)
    ccall((:LLVMInitializeCore,libllvm),Void,(LLVMPassRegistryRef,),R)
end

function LLVMShutdown()
    ccall((:LLVMShutdown,libllvm),Void,())
end

function LLVMCreateMessage(Message)
    ccall((:LLVMCreateMessage,libllvm),Cstring,(Cstring,),Message)
end

function LLVMDisposeMessage(Message)
    ccall((:LLVMDisposeMessage,libllvm),Void,(Cstring,),Message)
end

function LLVMContextCreate()
    ccall((:LLVMContextCreate,libllvm),LLVMContextRef,())
end

function LLVMGetGlobalContext()
    ccall((:LLVMGetGlobalContext,libllvm),LLVMContextRef,())
end

function LLVMContextSetDiagnosticHandler(C::LLVMContextRef,Handler::LLVMDiagnosticHandler,DiagnosticContext)
    ccall((:LLVMContextSetDiagnosticHandler,libllvm),Void,(LLVMContextRef,LLVMDiagnosticHandler,Ptr{Void}),C,Handler,DiagnosticContext)
end

function LLVMContextGetDiagnosticHandler(C::LLVMContextRef)
    ccall((:LLVMContextGetDiagnosticHandler,libllvm),LLVMDiagnosticHandler,(LLVMContextRef,),C)
end

function LLVMContextGetDiagnosticContext(C::LLVMContextRef)
    ccall((:LLVMContextGetDiagnosticContext,libllvm),Ptr{Void},(LLVMContextRef,),C)
end

function LLVMContextSetYieldCallback(C::LLVMContextRef,Callback::LLVMYieldCallback,OpaqueHandle)
    ccall((:LLVMContextSetYieldCallback,libllvm),Void,(LLVMContextRef,LLVMYieldCallback,Ptr{Void}),C,Callback,OpaqueHandle)
end

function LLVMContextDispose(C::LLVMContextRef)
    ccall((:LLVMContextDispose,libllvm),Void,(LLVMContextRef,),C)
end

function LLVMGetDiagInfoDescription(DI::LLVMDiagnosticInfoRef)
    ccall((:LLVMGetDiagInfoDescription,libllvm),Cstring,(LLVMDiagnosticInfoRef,),DI)
end

function LLVMGetDiagInfoSeverity(DI::LLVMDiagnosticInfoRef)
    ccall((:LLVMGetDiagInfoSeverity,libllvm),LLVMDiagnosticSeverity,(LLVMDiagnosticInfoRef,),DI)
end

function LLVMGetMDKindIDInContext(C::LLVMContextRef,Name,SLen::UInt32)
    ccall((:LLVMGetMDKindIDInContext,libllvm),UInt32,(LLVMContextRef,Cstring,UInt32),C,Name,SLen)
end

function LLVMGetMDKindID(Name,SLen::UInt32)
    ccall((:LLVMGetMDKindID,libllvm),UInt32,(Cstring,UInt32),Name,SLen)
end

function LLVMGetEnumAttributeKindForName(Name,SLen::Csize_t)
    ccall((:LLVMGetEnumAttributeKindForName,libllvm),UInt32,(Cstring,Csize_t),Name,SLen)
end

function LLVMGetLastEnumAttributeKind()
    ccall((:LLVMGetLastEnumAttributeKind,libllvm),UInt32,())
end

function LLVMCreateEnumAttribute(C::LLVMContextRef,KindID::UInt32,Val::UInt64)
    ccall((:LLVMCreateEnumAttribute,libllvm),LLVMAttributeRef,(LLVMContextRef,UInt32,UInt64),C,KindID,Val)
end

function LLVMGetEnumAttributeKind(A::LLVMAttributeRef)
    ccall((:LLVMGetEnumAttributeKind,libllvm),UInt32,(LLVMAttributeRef,),A)
end

function LLVMGetEnumAttributeValue(A::LLVMAttributeRef)
    ccall((:LLVMGetEnumAttributeValue,libllvm),UInt64,(LLVMAttributeRef,),A)
end

function LLVMCreateStringAttribute(C::LLVMContextRef,K,KLength::UInt32,V,VLength::UInt32)
    ccall((:LLVMCreateStringAttribute,libllvm),LLVMAttributeRef,(LLVMContextRef,Cstring,UInt32,Cstring,UInt32),C,K,KLength,V,VLength)
end

function LLVMGetStringAttributeKind(A::LLVMAttributeRef,Length)
    ccall((:LLVMGetStringAttributeKind,libllvm),Cstring,(LLVMAttributeRef,Ptr{UInt32}),A,Length)
end

function LLVMGetStringAttributeValue(A::LLVMAttributeRef,Length)
    ccall((:LLVMGetStringAttributeValue,libllvm),Cstring,(LLVMAttributeRef,Ptr{UInt32}),A,Length)
end

function LLVMIsEnumAttribute(A::LLVMAttributeRef)
    ccall((:LLVMIsEnumAttribute,libllvm),LLVMBool,(LLVMAttributeRef,),A)
end

function LLVMIsStringAttribute(A::LLVMAttributeRef)
    ccall((:LLVMIsStringAttribute,libllvm),LLVMBool,(LLVMAttributeRef,),A)
end

function LLVMModuleCreateWithName(ModuleID)
    ccall((:LLVMModuleCreateWithName,libllvm),LLVMModuleRef,(Cstring,),ModuleID)
end

function LLVMModuleCreateWithNameInContext(ModuleID,C::LLVMContextRef)
    ccall((:LLVMModuleCreateWithNameInContext,libllvm),LLVMModuleRef,(Cstring,LLVMContextRef),ModuleID,C)
end

function LLVMCloneModule(M::LLVMModuleRef)
    ccall((:LLVMCloneModule,libllvm),LLVMModuleRef,(LLVMModuleRef,),M)
end

function LLVMDisposeModule(M::LLVMModuleRef)
    ccall((:LLVMDisposeModule,libllvm),Void,(LLVMModuleRef,),M)
end

function LLVMGetModuleIdentifier(M::LLVMModuleRef,Len)
    ccall((:LLVMGetModuleIdentifier,libllvm),Cstring,(LLVMModuleRef,Ptr{Csize_t}),M,Len)
end

function LLVMSetModuleIdentifier(M::LLVMModuleRef,Ident,Len::Csize_t)
    ccall((:LLVMSetModuleIdentifier,libllvm),Void,(LLVMModuleRef,Cstring,Csize_t),M,Ident,Len)
end

function LLVMGetDataLayoutStr(M::LLVMModuleRef)
    ccall((:LLVMGetDataLayoutStr,libllvm),Cstring,(LLVMModuleRef,),M)
end

function LLVMGetDataLayout(M::LLVMModuleRef)
    ccall((:LLVMGetDataLayout,libllvm),Cstring,(LLVMModuleRef,),M)
end

function LLVMSetDataLayout(M::LLVMModuleRef,DataLayoutStr)
    ccall((:LLVMSetDataLayout,libllvm),Void,(LLVMModuleRef,Cstring),M,DataLayoutStr)
end

function LLVMGetTarget(M::LLVMModuleRef)
    ccall((:LLVMGetTarget,libllvm),Cstring,(LLVMModuleRef,),M)
end

function LLVMSetTarget(M::LLVMModuleRef,Triple)
    ccall((:LLVMSetTarget,libllvm),Void,(LLVMModuleRef,Cstring),M,Triple)
end

function LLVMDumpModule(M::LLVMModuleRef)
    ccall((:LLVMDumpModule,libllvm),Void,(LLVMModuleRef,),M)
end

function LLVMPrintModuleToFile(M::LLVMModuleRef,Filename,ErrorMessage)
    ccall((:LLVMPrintModuleToFile,libllvm),LLVMBool,(LLVMModuleRef,Cstring,Ptr{Cstring}),M,Filename,ErrorMessage)
end

function LLVMPrintModuleToString(M::LLVMModuleRef)
    ccall((:LLVMPrintModuleToString,libllvm),Cstring,(LLVMModuleRef,),M)
end

function LLVMSetModuleInlineAsm(M::LLVMModuleRef,Asm)
    ccall((:LLVMSetModuleInlineAsm,libllvm),Void,(LLVMModuleRef,Cstring),M,Asm)
end

function LLVMGetModuleContext(M::LLVMModuleRef)
    ccall((:LLVMGetModuleContext,libllvm),LLVMContextRef,(LLVMModuleRef,),M)
end

function LLVMGetTypeByName(M::LLVMModuleRef,Name)
    ccall((:LLVMGetTypeByName,libllvm),LLVMTypeRef,(LLVMModuleRef,Cstring),M,Name)
end

function LLVMGetNamedMetadataNumOperands(M::LLVMModuleRef,Name)
    ccall((:LLVMGetNamedMetadataNumOperands,libllvm),UInt32,(LLVMModuleRef,Cstring),M,Name)
end

function LLVMGetNamedMetadataOperands(M::LLVMModuleRef,Name,Dest)
    ccall((:LLVMGetNamedMetadataOperands,libllvm),Void,(LLVMModuleRef,Cstring,Ptr{LLVMValueRef}),M,Name,Dest)
end

function LLVMAddNamedMetadataOperand(M::LLVMModuleRef,Name,Val::LLVMValueRef)
    ccall((:LLVMAddNamedMetadataOperand,libllvm),Void,(LLVMModuleRef,Cstring,LLVMValueRef),M,Name,Val)
end

function LLVMAddFunction(M::LLVMModuleRef,Name,FunctionTy::LLVMTypeRef)
    ccall((:LLVMAddFunction,libllvm),LLVMValueRef,(LLVMModuleRef,Cstring,LLVMTypeRef),M,Name,FunctionTy)
end

function LLVMGetNamedFunction(M::LLVMModuleRef,Name)
    ccall((:LLVMGetNamedFunction,libllvm),LLVMValueRef,(LLVMModuleRef,Cstring),M,Name)
end

function LLVMGetFirstFunction(M::LLVMModuleRef)
    ccall((:LLVMGetFirstFunction,libllvm),LLVMValueRef,(LLVMModuleRef,),M)
end

function LLVMGetLastFunction(M::LLVMModuleRef)
    ccall((:LLVMGetLastFunction,libllvm),LLVMValueRef,(LLVMModuleRef,),M)
end

function LLVMGetNextFunction(Fn::LLVMValueRef)
    ccall((:LLVMGetNextFunction,libllvm),LLVMValueRef,(LLVMValueRef,),Fn)
end

function LLVMGetPreviousFunction(Fn::LLVMValueRef)
    ccall((:LLVMGetPreviousFunction,libllvm),LLVMValueRef,(LLVMValueRef,),Fn)
end

function LLVMGetTypeKind(Ty::LLVMTypeRef)
    ccall((:LLVMGetTypeKind,libllvm),LLVMTypeKind,(LLVMTypeRef,),Ty)
end

function LLVMTypeIsSized(Ty::LLVMTypeRef)
    ccall((:LLVMTypeIsSized,libllvm),LLVMBool,(LLVMTypeRef,),Ty)
end

function LLVMGetTypeContext(Ty::LLVMTypeRef)
    ccall((:LLVMGetTypeContext,libllvm),LLVMContextRef,(LLVMTypeRef,),Ty)
end

function LLVMDumpType(Val::LLVMTypeRef)
    ccall((:LLVMDumpType,libllvm),Void,(LLVMTypeRef,),Val)
end

function LLVMPrintTypeToString(Val::LLVMTypeRef)
    ccall((:LLVMPrintTypeToString,libllvm),Cstring,(LLVMTypeRef,),Val)
end

function LLVMInt1TypeInContext(C::LLVMContextRef)
    ccall((:LLVMInt1TypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMInt8TypeInContext(C::LLVMContextRef)
    ccall((:LLVMInt8TypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMInt16TypeInContext(C::LLVMContextRef)
    ccall((:LLVMInt16TypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMInt32TypeInContext(C::LLVMContextRef)
    ccall((:LLVMInt32TypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMInt64TypeInContext(C::LLVMContextRef)
    ccall((:LLVMInt64TypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMInt128TypeInContext(C::LLVMContextRef)
    ccall((:LLVMInt128TypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMIntTypeInContext(C::LLVMContextRef,NumBits::UInt32)
    ccall((:LLVMIntTypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,UInt32),C,NumBits)
end

function LLVMInt1Type()
    ccall((:LLVMInt1Type,libllvm),LLVMTypeRef,())
end

function LLVMInt8Type()
    ccall((:LLVMInt8Type,libllvm),LLVMTypeRef,())
end

function LLVMInt16Type()
    ccall((:LLVMInt16Type,libllvm),LLVMTypeRef,())
end

function LLVMInt32Type()
    ccall((:LLVMInt32Type,libllvm),LLVMTypeRef,())
end

function LLVMInt64Type()
    ccall((:LLVMInt64Type,libllvm),LLVMTypeRef,())
end

function LLVMInt128Type()
    ccall((:LLVMInt128Type,libllvm),LLVMTypeRef,())
end

function LLVMIntType(NumBits::UInt32)
    ccall((:LLVMIntType,libllvm),LLVMTypeRef,(UInt32,),NumBits)
end

function LLVMGetIntTypeWidth(IntegerTy::LLVMTypeRef)
    ccall((:LLVMGetIntTypeWidth,libllvm),UInt32,(LLVMTypeRef,),IntegerTy)
end

function LLVMHalfTypeInContext(C::LLVMContextRef)
    ccall((:LLVMHalfTypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMFloatTypeInContext(C::LLVMContextRef)
    ccall((:LLVMFloatTypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMDoubleTypeInContext(C::LLVMContextRef)
    ccall((:LLVMDoubleTypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMX86FP80TypeInContext(C::LLVMContextRef)
    ccall((:LLVMX86FP80TypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMFP128TypeInContext(C::LLVMContextRef)
    ccall((:LLVMFP128TypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMPPCFP128TypeInContext(C::LLVMContextRef)
    ccall((:LLVMPPCFP128TypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMHalfType()
    ccall((:LLVMHalfType,libllvm),LLVMTypeRef,())
end

function LLVMFloatType()
    ccall((:LLVMFloatType,libllvm),LLVMTypeRef,())
end

function LLVMDoubleType()
    ccall((:LLVMDoubleType,libllvm),LLVMTypeRef,())
end

function LLVMX86FP80Type()
    ccall((:LLVMX86FP80Type,libllvm),LLVMTypeRef,())
end

function LLVMFP128Type()
    ccall((:LLVMFP128Type,libllvm),LLVMTypeRef,())
end

function LLVMPPCFP128Type()
    ccall((:LLVMPPCFP128Type,libllvm),LLVMTypeRef,())
end

function LLVMFunctionType(ReturnType::LLVMTypeRef,ParamTypes,ParamCount::UInt32,IsVarArg::LLVMBool)
    ccall((:LLVMFunctionType,libllvm),LLVMTypeRef,(LLVMTypeRef,Ptr{LLVMTypeRef},UInt32,LLVMBool),ReturnType,ParamTypes,ParamCount,IsVarArg)
end

function LLVMIsFunctionVarArg(FunctionTy::LLVMTypeRef)
    ccall((:LLVMIsFunctionVarArg,libllvm),LLVMBool,(LLVMTypeRef,),FunctionTy)
end

function LLVMGetReturnType(FunctionTy::LLVMTypeRef)
    ccall((:LLVMGetReturnType,libllvm),LLVMTypeRef,(LLVMTypeRef,),FunctionTy)
end

function LLVMCountParamTypes(FunctionTy::LLVMTypeRef)
    ccall((:LLVMCountParamTypes,libllvm),UInt32,(LLVMTypeRef,),FunctionTy)
end

function LLVMGetParamTypes(FunctionTy::LLVMTypeRef,Dest)
    ccall((:LLVMGetParamTypes,libllvm),Void,(LLVMTypeRef,Ptr{LLVMTypeRef}),FunctionTy,Dest)
end

function LLVMStructTypeInContext(C::LLVMContextRef,ElementTypes,ElementCount::UInt32,Packed::LLVMBool)
    ccall((:LLVMStructTypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,Ptr{LLVMTypeRef},UInt32,LLVMBool),C,ElementTypes,ElementCount,Packed)
end

function LLVMStructType(ElementTypes,ElementCount::UInt32,Packed::LLVMBool)
    ccall((:LLVMStructType,libllvm),LLVMTypeRef,(Ptr{LLVMTypeRef},UInt32,LLVMBool),ElementTypes,ElementCount,Packed)
end

function LLVMStructCreateNamed(C::LLVMContextRef,Name)
    ccall((:LLVMStructCreateNamed,libllvm),LLVMTypeRef,(LLVMContextRef,Cstring),C,Name)
end

function LLVMGetStructName(Ty::LLVMTypeRef)
    ccall((:LLVMGetStructName,libllvm),Cstring,(LLVMTypeRef,),Ty)
end

function LLVMStructSetBody(StructTy::LLVMTypeRef,ElementTypes,ElementCount::UInt32,Packed::LLVMBool)
    ccall((:LLVMStructSetBody,libllvm),Void,(LLVMTypeRef,Ptr{LLVMTypeRef},UInt32,LLVMBool),StructTy,ElementTypes,ElementCount,Packed)
end

function LLVMCountStructElementTypes(StructTy::LLVMTypeRef)
    ccall((:LLVMCountStructElementTypes,libllvm),UInt32,(LLVMTypeRef,),StructTy)
end

function LLVMGetStructElementTypes(StructTy::LLVMTypeRef,Dest)
    ccall((:LLVMGetStructElementTypes,libllvm),Void,(LLVMTypeRef,Ptr{LLVMTypeRef}),StructTy,Dest)
end

function LLVMStructGetTypeAtIndex(StructTy::LLVMTypeRef,i::UInt32)
    ccall((:LLVMStructGetTypeAtIndex,libllvm),LLVMTypeRef,(LLVMTypeRef,UInt32),StructTy,i)
end

function LLVMIsPackedStruct(StructTy::LLVMTypeRef)
    ccall((:LLVMIsPackedStruct,libllvm),LLVMBool,(LLVMTypeRef,),StructTy)
end

function LLVMIsOpaqueStruct(StructTy::LLVMTypeRef)
    ccall((:LLVMIsOpaqueStruct,libllvm),LLVMBool,(LLVMTypeRef,),StructTy)
end

function LLVMGetElementType(Ty::LLVMTypeRef)
    ccall((:LLVMGetElementType,libllvm),LLVMTypeRef,(LLVMTypeRef,),Ty)
end

function LLVMArrayType(ElementType::LLVMTypeRef,ElementCount::UInt32)
    ccall((:LLVMArrayType,libllvm),LLVMTypeRef,(LLVMTypeRef,UInt32),ElementType,ElementCount)
end

function LLVMGetArrayLength(ArrayTy::LLVMTypeRef)
    ccall((:LLVMGetArrayLength,libllvm),UInt32,(LLVMTypeRef,),ArrayTy)
end

function LLVMPointerType(ElementType::LLVMTypeRef,AddressSpace::UInt32)
    ccall((:LLVMPointerType,libllvm),LLVMTypeRef,(LLVMTypeRef,UInt32),ElementType,AddressSpace)
end

function LLVMGetPointerAddressSpace(PointerTy::LLVMTypeRef)
    ccall((:LLVMGetPointerAddressSpace,libllvm),UInt32,(LLVMTypeRef,),PointerTy)
end

function LLVMVectorType(ElementType::LLVMTypeRef,ElementCount::UInt32)
    ccall((:LLVMVectorType,libllvm),LLVMTypeRef,(LLVMTypeRef,UInt32),ElementType,ElementCount)
end

function LLVMGetVectorSize(VectorTy::LLVMTypeRef)
    ccall((:LLVMGetVectorSize,libllvm),UInt32,(LLVMTypeRef,),VectorTy)
end

function LLVMVoidTypeInContext(C::LLVMContextRef)
    ccall((:LLVMVoidTypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMLabelTypeInContext(C::LLVMContextRef)
    ccall((:LLVMLabelTypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMX86MMXTypeInContext(C::LLVMContextRef)
    ccall((:LLVMX86MMXTypeInContext,libllvm),LLVMTypeRef,(LLVMContextRef,),C)
end

function LLVMVoidType()
    ccall((:LLVMVoidType,libllvm),LLVMTypeRef,())
end

function LLVMLabelType()
    ccall((:LLVMLabelType,libllvm),LLVMTypeRef,())
end

function LLVMX86MMXType()
    ccall((:LLVMX86MMXType,libllvm),LLVMTypeRef,())
end

function LLVMTypeOf(Val::LLVMValueRef)
    ccall((:LLVMTypeOf,libllvm),LLVMTypeRef,(LLVMValueRef,),Val)
end

function LLVMGetValueKind(Val::LLVMValueRef)
    ccall((:LLVMGetValueKind,libllvm),LLVMValueKind,(LLVMValueRef,),Val)
end

function LLVMGetValueName(Val::LLVMValueRef)
    ccall((:LLVMGetValueName,libllvm),Cstring,(LLVMValueRef,),Val)
end

function LLVMSetValueName(Val::LLVMValueRef,Name)
    ccall((:LLVMSetValueName,libllvm),Void,(LLVMValueRef,Cstring),Val,Name)
end

function LLVMDumpValue(Val::LLVMValueRef)
    ccall((:LLVMDumpValue,libllvm),Void,(LLVMValueRef,),Val)
end

function LLVMPrintValueToString(Val::LLVMValueRef)
    ccall((:LLVMPrintValueToString,libllvm),Cstring,(LLVMValueRef,),Val)
end

function LLVMReplaceAllUsesWith(OldVal::LLVMValueRef,NewVal::LLVMValueRef)
    ccall((:LLVMReplaceAllUsesWith,libllvm),Void,(LLVMValueRef,LLVMValueRef),OldVal,NewVal)
end

function LLVMIsConstant(Val::LLVMValueRef)
    ccall((:LLVMIsConstant,libllvm),LLVMBool,(LLVMValueRef,),Val)
end

function LLVMIsUndef(Val::LLVMValueRef)
    ccall((:LLVMIsUndef,libllvm),LLVMBool,(LLVMValueRef,),Val)
end

function LLVMIsAArgument(Val::LLVMValueRef)
    ccall((:LLVMIsAArgument,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsABasicBlock(Val::LLVMValueRef)
    ccall((:LLVMIsABasicBlock,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAInlineAsm(Val::LLVMValueRef)
    ccall((:LLVMIsAInlineAsm,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAUser(Val::LLVMValueRef)
    ccall((:LLVMIsAUser,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAConstant(Val::LLVMValueRef)
    ccall((:LLVMIsAConstant,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsABlockAddress(Val::LLVMValueRef)
    ccall((:LLVMIsABlockAddress,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAConstantAggregateZero(Val::LLVMValueRef)
    ccall((:LLVMIsAConstantAggregateZero,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAConstantArray(Val::LLVMValueRef)
    ccall((:LLVMIsAConstantArray,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAConstantDataSequential(Val::LLVMValueRef)
    ccall((:LLVMIsAConstantDataSequential,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAConstantDataArray(Val::LLVMValueRef)
    ccall((:LLVMIsAConstantDataArray,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAConstantDataVector(Val::LLVMValueRef)
    ccall((:LLVMIsAConstantDataVector,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAConstantExpr(Val::LLVMValueRef)
    ccall((:LLVMIsAConstantExpr,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAConstantFP(Val::LLVMValueRef)
    ccall((:LLVMIsAConstantFP,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAConstantInt(Val::LLVMValueRef)
    ccall((:LLVMIsAConstantInt,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAConstantPointerNull(Val::LLVMValueRef)
    ccall((:LLVMIsAConstantPointerNull,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAConstantStruct(Val::LLVMValueRef)
    ccall((:LLVMIsAConstantStruct,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAConstantTokenNone(Val::LLVMValueRef)
    ccall((:LLVMIsAConstantTokenNone,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAConstantVector(Val::LLVMValueRef)
    ccall((:LLVMIsAConstantVector,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAGlobalValue(Val::LLVMValueRef)
    ccall((:LLVMIsAGlobalValue,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAGlobalAlias(Val::LLVMValueRef)
    ccall((:LLVMIsAGlobalAlias,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAGlobalObject(Val::LLVMValueRef)
    ccall((:LLVMIsAGlobalObject,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAFunction(Val::LLVMValueRef)
    ccall((:LLVMIsAFunction,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAGlobalVariable(Val::LLVMValueRef)
    ccall((:LLVMIsAGlobalVariable,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAUndefValue(Val::LLVMValueRef)
    ccall((:LLVMIsAUndefValue,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAInstruction(Val::LLVMValueRef)
    ccall((:LLVMIsAInstruction,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsABinaryOperator(Val::LLVMValueRef)
    ccall((:LLVMIsABinaryOperator,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsACallInst(Val::LLVMValueRef)
    ccall((:LLVMIsACallInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAIntrinsicInst(Val::LLVMValueRef)
    ccall((:LLVMIsAIntrinsicInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsADbgInfoIntrinsic(Val::LLVMValueRef)
    ccall((:LLVMIsADbgInfoIntrinsic,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsADbgDeclareInst(Val::LLVMValueRef)
    ccall((:LLVMIsADbgDeclareInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAMemIntrinsic(Val::LLVMValueRef)
    ccall((:LLVMIsAMemIntrinsic,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAMemCpyInst(Val::LLVMValueRef)
    ccall((:LLVMIsAMemCpyInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAMemMoveInst(Val::LLVMValueRef)
    ccall((:LLVMIsAMemMoveInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAMemSetInst(Val::LLVMValueRef)
    ccall((:LLVMIsAMemSetInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsACmpInst(Val::LLVMValueRef)
    ccall((:LLVMIsACmpInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAFCmpInst(Val::LLVMValueRef)
    ccall((:LLVMIsAFCmpInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAICmpInst(Val::LLVMValueRef)
    ccall((:LLVMIsAICmpInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAExtractElementInst(Val::LLVMValueRef)
    ccall((:LLVMIsAExtractElementInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAGetElementPtrInst(Val::LLVMValueRef)
    ccall((:LLVMIsAGetElementPtrInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAInsertElementInst(Val::LLVMValueRef)
    ccall((:LLVMIsAInsertElementInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAInsertValueInst(Val::LLVMValueRef)
    ccall((:LLVMIsAInsertValueInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsALandingPadInst(Val::LLVMValueRef)
    ccall((:LLVMIsALandingPadInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAPHINode(Val::LLVMValueRef)
    ccall((:LLVMIsAPHINode,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsASelectInst(Val::LLVMValueRef)
    ccall((:LLVMIsASelectInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAShuffleVectorInst(Val::LLVMValueRef)
    ccall((:LLVMIsAShuffleVectorInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAStoreInst(Val::LLVMValueRef)
    ccall((:LLVMIsAStoreInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsATerminatorInst(Val::LLVMValueRef)
    ccall((:LLVMIsATerminatorInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsABranchInst(Val::LLVMValueRef)
    ccall((:LLVMIsABranchInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAIndirectBrInst(Val::LLVMValueRef)
    ccall((:LLVMIsAIndirectBrInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAInvokeInst(Val::LLVMValueRef)
    ccall((:LLVMIsAInvokeInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAReturnInst(Val::LLVMValueRef)
    ccall((:LLVMIsAReturnInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsASwitchInst(Val::LLVMValueRef)
    ccall((:LLVMIsASwitchInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAUnreachableInst(Val::LLVMValueRef)
    ccall((:LLVMIsAUnreachableInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAResumeInst(Val::LLVMValueRef)
    ccall((:LLVMIsAResumeInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsACleanupReturnInst(Val::LLVMValueRef)
    ccall((:LLVMIsACleanupReturnInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsACatchReturnInst(Val::LLVMValueRef)
    ccall((:LLVMIsACatchReturnInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAFuncletPadInst(Val::LLVMValueRef)
    ccall((:LLVMIsAFuncletPadInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsACatchPadInst(Val::LLVMValueRef)
    ccall((:LLVMIsACatchPadInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsACleanupPadInst(Val::LLVMValueRef)
    ccall((:LLVMIsACleanupPadInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAUnaryInstruction(Val::LLVMValueRef)
    ccall((:LLVMIsAUnaryInstruction,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAAllocaInst(Val::LLVMValueRef)
    ccall((:LLVMIsAAllocaInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsACastInst(Val::LLVMValueRef)
    ccall((:LLVMIsACastInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAAddrSpaceCastInst(Val::LLVMValueRef)
    ccall((:LLVMIsAAddrSpaceCastInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsABitCastInst(Val::LLVMValueRef)
    ccall((:LLVMIsABitCastInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAFPExtInst(Val::LLVMValueRef)
    ccall((:LLVMIsAFPExtInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAFPToSIInst(Val::LLVMValueRef)
    ccall((:LLVMIsAFPToSIInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAFPToUIInst(Val::LLVMValueRef)
    ccall((:LLVMIsAFPToUIInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAFPTruncInst(Val::LLVMValueRef)
    ccall((:LLVMIsAFPTruncInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAIntToPtrInst(Val::LLVMValueRef)
    ccall((:LLVMIsAIntToPtrInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAPtrToIntInst(Val::LLVMValueRef)
    ccall((:LLVMIsAPtrToIntInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsASExtInst(Val::LLVMValueRef)
    ccall((:LLVMIsASExtInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsASIToFPInst(Val::LLVMValueRef)
    ccall((:LLVMIsASIToFPInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsATruncInst(Val::LLVMValueRef)
    ccall((:LLVMIsATruncInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAUIToFPInst(Val::LLVMValueRef)
    ccall((:LLVMIsAUIToFPInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAZExtInst(Val::LLVMValueRef)
    ccall((:LLVMIsAZExtInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAExtractValueInst(Val::LLVMValueRef)
    ccall((:LLVMIsAExtractValueInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsALoadInst(Val::LLVMValueRef)
    ccall((:LLVMIsALoadInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAVAArgInst(Val::LLVMValueRef)
    ccall((:LLVMIsAVAArgInst,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAMDNode(Val::LLVMValueRef)
    ccall((:LLVMIsAMDNode,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMIsAMDString(Val::LLVMValueRef)
    ccall((:LLVMIsAMDString,libllvm),LLVMValueRef,(LLVMValueRef,),Val)
end

function LLVMGetFirstUse(Val::LLVMValueRef)
    ccall((:LLVMGetFirstUse,libllvm),LLVMUseRef,(LLVMValueRef,),Val)
end

function LLVMGetNextUse(U::LLVMUseRef)
    ccall((:LLVMGetNextUse,libllvm),LLVMUseRef,(LLVMUseRef,),U)
end

function LLVMGetUser(U::LLVMUseRef)
    ccall((:LLVMGetUser,libllvm),LLVMValueRef,(LLVMUseRef,),U)
end

function LLVMGetUsedValue(U::LLVMUseRef)
    ccall((:LLVMGetUsedValue,libllvm),LLVMValueRef,(LLVMUseRef,),U)
end

function LLVMGetOperand(Val::LLVMValueRef,Index::UInt32)
    ccall((:LLVMGetOperand,libllvm),LLVMValueRef,(LLVMValueRef,UInt32),Val,Index)
end

function LLVMGetOperandUse(Val::LLVMValueRef,Index::UInt32)
    ccall((:LLVMGetOperandUse,libllvm),LLVMUseRef,(LLVMValueRef,UInt32),Val,Index)
end

function LLVMSetOperand(User::LLVMValueRef,Index::UInt32,Val::LLVMValueRef)
    ccall((:LLVMSetOperand,libllvm),Void,(LLVMValueRef,UInt32,LLVMValueRef),User,Index,Val)
end

function LLVMGetNumOperands(Val::LLVMValueRef)
    ccall((:LLVMGetNumOperands,libllvm),Cint,(LLVMValueRef,),Val)
end

function LLVMConstNull(Ty::LLVMTypeRef)
    ccall((:LLVMConstNull,libllvm),LLVMValueRef,(LLVMTypeRef,),Ty)
end

function LLVMConstAllOnes(Ty::LLVMTypeRef)
    ccall((:LLVMConstAllOnes,libllvm),LLVMValueRef,(LLVMTypeRef,),Ty)
end

function LLVMGetUndef(Ty::LLVMTypeRef)
    ccall((:LLVMGetUndef,libllvm),LLVMValueRef,(LLVMTypeRef,),Ty)
end

function LLVMIsNull(Val::LLVMValueRef)
    ccall((:LLVMIsNull,libllvm),LLVMBool,(LLVMValueRef,),Val)
end

function LLVMConstPointerNull(Ty::LLVMTypeRef)
    ccall((:LLVMConstPointerNull,libllvm),LLVMValueRef,(LLVMTypeRef,),Ty)
end

function LLVMConstInt(IntTy::LLVMTypeRef,N::Culonglong,SignExtend::LLVMBool)
    ccall((:LLVMConstInt,libllvm),LLVMValueRef,(LLVMTypeRef,Culonglong,LLVMBool),IntTy,N,SignExtend)
end

function LLVMConstIntOfArbitraryPrecision(IntTy::LLVMTypeRef,NumWords::UInt32,Words)
    ccall((:LLVMConstIntOfArbitraryPrecision,libllvm),LLVMValueRef,(LLVMTypeRef,UInt32,Ptr{UInt64}),IntTy,NumWords,Words)
end

function LLVMConstIntOfString(IntTy::LLVMTypeRef,Text,Radix::UInt8)
    ccall((:LLVMConstIntOfString,libllvm),LLVMValueRef,(LLVMTypeRef,Cstring,UInt8),IntTy,Text,Radix)
end

function LLVMConstIntOfStringAndSize(IntTy::LLVMTypeRef,Text,SLen::UInt32,Radix::UInt8)
    ccall((:LLVMConstIntOfStringAndSize,libllvm),LLVMValueRef,(LLVMTypeRef,Cstring,UInt32,UInt8),IntTy,Text,SLen,Radix)
end

function LLVMConstReal(RealTy::LLVMTypeRef,N::Cdouble)
    ccall((:LLVMConstReal,libllvm),LLVMValueRef,(LLVMTypeRef,Cdouble),RealTy,N)
end

function LLVMConstRealOfString(RealTy::LLVMTypeRef,Text)
    ccall((:LLVMConstRealOfString,libllvm),LLVMValueRef,(LLVMTypeRef,Cstring),RealTy,Text)
end

function LLVMConstRealOfStringAndSize(RealTy::LLVMTypeRef,Text,SLen::UInt32)
    ccall((:LLVMConstRealOfStringAndSize,libllvm),LLVMValueRef,(LLVMTypeRef,Cstring,UInt32),RealTy,Text,SLen)
end

function LLVMConstIntGetZExtValue(ConstantVal::LLVMValueRef)
    ccall((:LLVMConstIntGetZExtValue,libllvm),Culonglong,(LLVMValueRef,),ConstantVal)
end

function LLVMConstIntGetSExtValue(ConstantVal::LLVMValueRef)
    ccall((:LLVMConstIntGetSExtValue,libllvm),Clonglong,(LLVMValueRef,),ConstantVal)
end

function LLVMConstRealGetDouble(ConstantVal::LLVMValueRef,losesInfo)
    ccall((:LLVMConstRealGetDouble,libllvm),Cdouble,(LLVMValueRef,Ptr{LLVMBool}),ConstantVal,losesInfo)
end

function LLVMConstStringInContext(C::LLVMContextRef,Str,Length::UInt32,DontNullTerminate::LLVMBool)
    ccall((:LLVMConstStringInContext,libllvm),LLVMValueRef,(LLVMContextRef,Cstring,UInt32,LLVMBool),C,Str,Length,DontNullTerminate)
end

function LLVMConstString(Str,Length::UInt32,DontNullTerminate::LLVMBool)
    ccall((:LLVMConstString,libllvm),LLVMValueRef,(Cstring,UInt32,LLVMBool),Str,Length,DontNullTerminate)
end

function LLVMIsConstantString(c::LLVMValueRef)
    ccall((:LLVMIsConstantString,libllvm),LLVMBool,(LLVMValueRef,),c)
end

function LLVMGetAsString(c::LLVMValueRef,Length)
    ccall((:LLVMGetAsString,libllvm),Cstring,(LLVMValueRef,Ptr{Csize_t}),c,Length)
end

function LLVMConstStructInContext(C::LLVMContextRef,ConstantVals,Count::UInt32,Packed::LLVMBool)
    ccall((:LLVMConstStructInContext,libllvm),LLVMValueRef,(LLVMContextRef,Ptr{LLVMValueRef},UInt32,LLVMBool),C,ConstantVals,Count,Packed)
end

function LLVMConstStruct(ConstantVals,Count::UInt32,Packed::LLVMBool)
    ccall((:LLVMConstStruct,libllvm),LLVMValueRef,(Ptr{LLVMValueRef},UInt32,LLVMBool),ConstantVals,Count,Packed)
end

function LLVMConstArray(ElementTy::LLVMTypeRef,ConstantVals,Length::UInt32)
    ccall((:LLVMConstArray,libllvm),LLVMValueRef,(LLVMTypeRef,Ptr{LLVMValueRef},UInt32),ElementTy,ConstantVals,Length)
end

function LLVMConstNamedStruct(StructTy::LLVMTypeRef,ConstantVals,Count::UInt32)
    ccall((:LLVMConstNamedStruct,libllvm),LLVMValueRef,(LLVMTypeRef,Ptr{LLVMValueRef},UInt32),StructTy,ConstantVals,Count)
end

function LLVMGetElementAsConstant(C::LLVMValueRef,idx::UInt32)
    ccall((:LLVMGetElementAsConstant,libllvm),LLVMValueRef,(LLVMValueRef,UInt32),C,idx)
end

function LLVMConstVector(ScalarConstantVals,Size::UInt32)
    ccall((:LLVMConstVector,libllvm),LLVMValueRef,(Ptr{LLVMValueRef},UInt32),ScalarConstantVals,Size)
end

function LLVMGetConstOpcode(ConstantVal::LLVMValueRef)
    ccall((:LLVMGetConstOpcode,libllvm),LLVMOpcode,(LLVMValueRef,),ConstantVal)
end

function LLVMAlignOf(Ty::LLVMTypeRef)
    ccall((:LLVMAlignOf,libllvm),LLVMValueRef,(LLVMTypeRef,),Ty)
end

function LLVMSizeOf(Ty::LLVMTypeRef)
    ccall((:LLVMSizeOf,libllvm),LLVMValueRef,(LLVMTypeRef,),Ty)
end

function LLVMConstNeg(ConstantVal::LLVMValueRef)
    ccall((:LLVMConstNeg,libllvm),LLVMValueRef,(LLVMValueRef,),ConstantVal)
end

function LLVMConstNSWNeg(ConstantVal::LLVMValueRef)
    ccall((:LLVMConstNSWNeg,libllvm),LLVMValueRef,(LLVMValueRef,),ConstantVal)
end

function LLVMConstNUWNeg(ConstantVal::LLVMValueRef)
    ccall((:LLVMConstNUWNeg,libllvm),LLVMValueRef,(LLVMValueRef,),ConstantVal)
end

function LLVMConstFNeg(ConstantVal::LLVMValueRef)
    ccall((:LLVMConstFNeg,libllvm),LLVMValueRef,(LLVMValueRef,),ConstantVal)
end

function LLVMConstNot(ConstantVal::LLVMValueRef)
    ccall((:LLVMConstNot,libllvm),LLVMValueRef,(LLVMValueRef,),ConstantVal)
end

function LLVMConstAdd(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstAdd,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstNSWAdd(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstNSWAdd,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstNUWAdd(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstNUWAdd,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstFAdd(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstFAdd,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstSub(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstSub,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstNSWSub(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstNSWSub,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstNUWSub(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstNUWSub,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstFSub(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstFSub,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstMul(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstMul,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstNSWMul(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstNSWMul,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstNUWMul(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstNUWMul,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstFMul(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstFMul,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstUDiv(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstUDiv,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstSDiv(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstSDiv,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstExactSDiv(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstExactSDiv,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstFDiv(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstFDiv,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstURem(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstURem,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstSRem(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstSRem,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstFRem(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstFRem,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstAnd(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstAnd,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstOr(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstOr,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstXor(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstXor,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstICmp(Predicate::LLVMIntPredicate,LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstICmp,libllvm),LLVMValueRef,(LLVMIntPredicate,LLVMValueRef,LLVMValueRef),Predicate,LHSConstant,RHSConstant)
end

function LLVMConstFCmp(Predicate::LLVMRealPredicate,LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstFCmp,libllvm),LLVMValueRef,(LLVMRealPredicate,LLVMValueRef,LLVMValueRef),Predicate,LHSConstant,RHSConstant)
end

function LLVMConstShl(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstShl,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstLShr(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstLShr,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstAShr(LHSConstant::LLVMValueRef,RHSConstant::LLVMValueRef)
    ccall((:LLVMConstAShr,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),LHSConstant,RHSConstant)
end

function LLVMConstGEP(ConstantVal::LLVMValueRef,ConstantIndices,NumIndices::UInt32)
    ccall((:LLVMConstGEP,libllvm),LLVMValueRef,(LLVMValueRef,Ptr{LLVMValueRef},UInt32),ConstantVal,ConstantIndices,NumIndices)
end

function LLVMConstInBoundsGEP(ConstantVal::LLVMValueRef,ConstantIndices,NumIndices::UInt32)
    ccall((:LLVMConstInBoundsGEP,libllvm),LLVMValueRef,(LLVMValueRef,Ptr{LLVMValueRef},UInt32),ConstantVal,ConstantIndices,NumIndices)
end

function LLVMConstTrunc(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstTrunc,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstSExt(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstSExt,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstZExt(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstZExt,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstFPTrunc(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstFPTrunc,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstFPExt(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstFPExt,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstUIToFP(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstUIToFP,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstSIToFP(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstSIToFP,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstFPToUI(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstFPToUI,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstFPToSI(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstFPToSI,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstPtrToInt(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstPtrToInt,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstIntToPtr(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstIntToPtr,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstBitCast(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstBitCast,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstAddrSpaceCast(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstAddrSpaceCast,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstZExtOrBitCast(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstZExtOrBitCast,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstSExtOrBitCast(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstSExtOrBitCast,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstTruncOrBitCast(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstTruncOrBitCast,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstPointerCast(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstPointerCast,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstIntCast(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef,isSigned::LLVMBool)
    ccall((:LLVMConstIntCast,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef,LLVMBool),ConstantVal,ToType,isSigned)
end

function LLVMConstFPCast(ConstantVal::LLVMValueRef,ToType::LLVMTypeRef)
    ccall((:LLVMConstFPCast,libllvm),LLVMValueRef,(LLVMValueRef,LLVMTypeRef),ConstantVal,ToType)
end

function LLVMConstSelect(ConstantCondition::LLVMValueRef,ConstantIfTrue::LLVMValueRef,ConstantIfFalse::LLVMValueRef)
    ccall((:LLVMConstSelect,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef,LLVMValueRef),ConstantCondition,ConstantIfTrue,ConstantIfFalse)
end

function LLVMConstExtractElement(VectorConstant::LLVMValueRef,IndexConstant::LLVMValueRef)
    ccall((:LLVMConstExtractElement,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef),VectorConstant,IndexConstant)
end

function LLVMConstInsertElement(VectorConstant::LLVMValueRef,ElementValueConstant::LLVMValueRef,IndexConstant::LLVMValueRef)
    ccall((:LLVMConstInsertElement,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef,LLVMValueRef),VectorConstant,ElementValueConstant,IndexConstant)
end

function LLVMConstShuffleVector(VectorAConstant::LLVMValueRef,VectorBConstant::LLVMValueRef,MaskConstant::LLVMValueRef)
    ccall((:LLVMConstShuffleVector,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef,LLVMValueRef),VectorAConstant,VectorBConstant,MaskConstant)
end

function LLVMConstExtractValue(AggConstant::LLVMValueRef,IdxList,NumIdx::UInt32)
    ccall((:LLVMConstExtractValue,libllvm),LLVMValueRef,(LLVMValueRef,Ptr{UInt32},UInt32),AggConstant,IdxList,NumIdx)
end

function LLVMConstInsertValue(AggConstant::LLVMValueRef,ElementValueConstant::LLVMValueRef,IdxList,NumIdx::UInt32)
    ccall((:LLVMConstInsertValue,libllvm),LLVMValueRef,(LLVMValueRef,LLVMValueRef,Ptr{UInt32},UInt32),AggConstant,ElementValueConstant,IdxList,NumIdx)
end

function LLVMConstInlineAsm(Ty::LLVMTypeRef,AsmString,Constraints,HasSideEffects::LLVMBool,IsAlignStack::LLVMBool)
    ccall((:LLVMConstInlineAsm,libllvm),LLVMValueRef,(LLVMTypeRef,Cstring,Cstring,LLVMBool,LLVMBool),Ty,AsmString,Constraints,HasSideEffects,IsAlignStack)
end

function LLVMBlockAddress(F::LLVMValueRef,BB::LLVMBasicBlockRef)
    ccall((:LLVMBlockAddress,libllvm),LLVMValueRef,(LLVMValueRef,LLVMBasicBlockRef),F,BB)
end

function LLVMGetGlobalParent(Global::LLVMValueRef)
    ccall((:LLVMGetGlobalParent,libllvm),LLVMModuleRef,(LLVMValueRef,),Global)
end

function LLVMIsDeclaration(Global::LLVMValueRef)
    ccall((:LLVMIsDeclaration,libllvm),LLVMBool,(LLVMValueRef,),Global)
end

function LLVMGetLinkage(Global::LLVMValueRef)
    ccall((:LLVMGetLinkage,libllvm),LLVMLinkage,(LLVMValueRef,),Global)
end

function LLVMSetLinkage(Global::LLVMValueRef,Linkage::LLVMLinkage)
    ccall((:LLVMSetLinkage,libllvm),Void,(LLVMValueRef,LLVMLinkage),Global,Linkage)
end

function LLVMGetSection(Global::LLVMValueRef)
    ccall((:LLVMGetSection,libllvm),Cstring,(LLVMValueRef,),Global)
end

function LLVMSetSection(Global::LLVMValueRef,Section)
    ccall((:LLVMSetSection,libllvm),Void,(LLVMValueRef,Cstring),Global,Section)
end

function LLVMGetVisibility(Global::LLVMValueRef)
    ccall((:LLVMGetVisibility,libllvm),LLVMVisibility,(LLVMValueRef,),Global)
end

function LLVMSetVisibility(Global::LLVMValueRef,Viz::LLVMVisibility)
    ccall((:LLVMSetVisibility,libllvm),Void,(LLVMValueRef,LLVMVisibility),Global,Viz)
end

function LLVMGetDLLStorageClass(Global::LLVMValueRef)
    ccall((:LLVMGetDLLStorageClass,libllvm),LLVMDLLStorageClass,(LLVMValueRef,),Global)
end

function LLVMSetDLLStorageClass(Global::LLVMValueRef,Class::LLVMDLLStorageClass)
    ccall((:LLVMSetDLLStorageClass,libllvm),Void,(LLVMValueRef,LLVMDLLStorageClass),Global,Class)
end

function LLVMHasUnnamedAddr(Global::LLVMValueRef)
    ccall((:LLVMHasUnnamedAddr,libllvm),LLVMBool,(LLVMValueRef,),Global)
end

function LLVMSetUnnamedAddr(Global::LLVMValueRef,HasUnnamedAddr::LLVMBool)
    ccall((:LLVMSetUnnamedAddr,libllvm),Void,(LLVMValueRef,LLVMBool),Global,HasUnnamedAddr)
end

function LLVMGetAlignment(V::LLVMValueRef)
    ccall((:LLVMGetAlignment,libllvm),UInt32,(LLVMValueRef,),V)
end

function LLVMSetAlignment(V::LLVMValueRef,Bytes::UInt32)
    ccall((:LLVMSetAlignment,libllvm),Void,(LLVMValueRef,UInt32),V,Bytes)
end

function LLVMAddGlobal(M::LLVMModuleRef,Ty::LLVMTypeRef,Name)
    ccall((:LLVMAddGlobal,libllvm),LLVMValueRef,(LLVMModuleRef,LLVMTypeRef,Cstring),M,Ty,Name)
end

function LLVMAddGlobalInAddressSpace(M::LLVMModuleRef,Ty::LLVMTypeRef,Name,AddressSpace::UInt32)
    ccall((:LLVMAddGlobalInAddressSpace,libllvm),LLVMValueRef,(LLVMModuleRef,LLVMTypeRef,Cstring,UInt32),M,Ty,Name,AddressSpace)
end

function LLVMGetNamedGlobal(M::LLVMModuleRef,Name)
    ccall((:LLVMGetNamedGlobal,libllvm),LLVMValueRef,(LLVMModuleRef,Cstring),M,Name)
end

function LLVMGetFirstGlobal(M::LLVMModuleRef)
    ccall((:LLVMGetFirstGlobal,libllvm),LLVMValueRef,(LLVMModuleRef,),M)
end

function LLVMGetLastGlobal(M::LLVMModuleRef)
    ccall((:LLVMGetLastGlobal,libllvm),LLVMValueRef,(LLVMModuleRef,),M)
end

function LLVMGetNextGlobal(GlobalVar::LLVMValueRef)
    ccall((:LLVMGetNextGlobal,libllvm),LLVMValueRef,(LLVMValueRef,),GlobalVar)
end

function LLVMGetPreviousGlobal(GlobalVar::LLVMValueRef)
    ccall((:LLVMGetPreviousGlobal,libllvm),LLVMValueRef,(LLVMValueRef,),GlobalVar)
end

function LLVMDeleteGlobal(GlobalVar::LLVMValueRef)
    ccall((:LLVMDeleteGlobal,libllvm),Void,(LLVMValueRef,),GlobalVar)
end

function LLVMGetInitializer(GlobalVar::LLVMValueRef)
    ccall((:LLVMGetInitializer,libllvm),LLVMValueRef,(LLVMValueRef,),GlobalVar)
end

function LLVMSetInitializer(GlobalVar::LLVMValueRef,ConstantVal::LLVMValueRef)
    ccall((:LLVMSetInitializer,libllvm),Void,(LLVMValueRef,LLVMValueRef),GlobalVar,ConstantVal)
end

function LLVMIsThreadLocal(GlobalVar::LLVMValueRef)
    ccall((:LLVMIsThreadLocal,libllvm),LLVMBool,(LLVMValueRef,),GlobalVar)
end

function LLVMSetThreadLocal(GlobalVar::LLVMValueRef,IsThreadLocal::LLVMBool)
    ccall((:LLVMSetThreadLocal,libllvm),Void,(LLVMValueRef,LLVMBool),GlobalVar,IsThreadLocal)
end

function LLVMIsGlobalConstant(GlobalVar::LLVMValueRef)
    ccall((:LLVMIsGlobalConstant,libllvm),LLVMBool,(LLVMValueRef,),GlobalVar)
end

function LLVMSetGlobalConstant(GlobalVar::LLVMValueRef,IsConstant::LLVMBool)
    ccall((:LLVMSetGlobalConstant,libllvm),Void,(LLVMValueRef,LLVMBool),GlobalVar,IsConstant)
end

function LLVMGetThreadLocalMode(GlobalVar::LLVMValueRef)
    ccall((:LLVMGetThreadLocalMode,libllvm),LLVMThreadLocalMode,(LLVMValueRef,),GlobalVar)
end

function LLVMSetThreadLocalMode(GlobalVar::LLVMValueRef,Mode::LLVMThreadLocalMode)
    ccall((:LLVMSetThreadLocalMode,libllvm),Void,(LLVMValueRef,LLVMThreadLocalMode),GlobalVar,Mode)
end

function LLVMIsExternallyInitialized(GlobalVar::LLVMValueRef)
    ccall((:LLVMIsExternallyInitialized,libllvm),LLVMBool,(LLVMValueRef,),GlobalVar)
end

function LLVMSetExternallyInitialized(GlobalVar::LLVMValueRef,IsExtInit::LLVMBool)
    ccall((:LLVMSetExternallyInitialized,libllvm),Void,(LLVMValueRef,LLVMBool),GlobalVar,IsExtInit)
end

function LLVMAddAlias(M::LLVMModuleRef,Ty::LLVMTypeRef,Aliasee::LLVMValueRef,Name)
    ccall((:LLVMAddAlias,libllvm),LLVMValueRef,(LLVMModuleRef,LLVMTypeRef,LLVMValueRef,Cstring),M,Ty,Aliasee,Name)
end

function LLVMDeleteFunction(Fn::LLVMValueRef)
    ccall((:LLVMDeleteFunction,libllvm),Void,(LLVMValueRef,),Fn)
end

function LLVMHasPersonalityFn(Fn::LLVMValueRef)
    ccall((:LLVMHasPersonalityFn,libllvm),LLVMBool,(LLVMValueRef,),Fn)
end

function LLVMGetPersonalityFn(Fn::LLVMValueRef)
    ccall((:LLVMGetPersonalityFn,libllvm),LLVMValueRef,(LLVMValueRef,),Fn)
end

function LLVMSetPersonalityFn(Fn::LLVMValueRef,PersonalityFn::LLVMValueRef)
    ccall((:LLVMSetPersonalityFn,libllvm),Void,(LLVMValueRef,LLVMValueRef),Fn,PersonalityFn)
end

function LLVMGetIntrinsicID(Fn::LLVMValueRef)
    ccall((:LLVMGetIntrinsicID,libllvm),UInt32,(LLVMValueRef,),Fn)
end

function LLVMGetFunctionCallConv(Fn::LLVMValueRef)
    ccall((:LLVMGetFunctionCallConv,libllvm),UInt32,(LLVMValueRef,),Fn)
end

function LLVMSetFunctionCallConv(Fn::LLVMValueRef,CC::UInt32)
    ccall((:LLVMSetFunctionCallConv,libllvm),Void,(LLVMValueRef,UInt32),Fn,CC)
end

function LLVMGetGC(Fn::LLVMValueRef)
    ccall((:LLVMGetGC,libllvm),Cstring,(LLVMValueRef,),Fn)
end

function LLVMSetGC(Fn::LLVMValueRef,Name)
    ccall((:LLVMSetGC,libllvm),Void,(LLVMValueRef,Cstring),Fn,Name)
end

function LLVMAddFunctionAttr(Fn::LLVMValueRef,PA::LLVMAttribute)
    ccall((:LLVMAddFunctionAttr,libllvm),Void,(LLVMValueRef,LLVMAttribute),Fn,PA)
end

function LLVMAddAttributeAtIndex(F::LLVMValueRef,Idx::LLVMAttributeIndex,A::LLVMAttributeRef)
    ccall((:LLVMAddAttributeAtIndex,libllvm),Void,(LLVMValueRef,LLVMAttributeIndex,LLVMAttributeRef),F,Idx,A)
end

function LLVMGetAttributeCountAtIndex(F::LLVMValueRef,Idx::LLVMAttributeIndex)
    ccall((:LLVMGetAttributeCountAtIndex,libllvm),UInt32,(LLVMValueRef,LLVMAttributeIndex),F,Idx)
end

function LLVMGetAttributesAtIndex(F::LLVMValueRef,Idx::LLVMAttributeIndex,Attrs)
    ccall((:LLVMGetAttributesAtIndex,libllvm),Void,(LLVMValueRef,LLVMAttributeIndex,Ptr{LLVMAttributeRef}),F,Idx,Attrs)
end

function LLVMGetEnumAttributeAtIndex(F::LLVMValueRef,Idx::LLVMAttributeIndex,KindID::UInt32)
    ccall((:LLVMGetEnumAttributeAtIndex,libllvm),LLVMAttributeRef,(LLVMValueRef,LLVMAttributeIndex,UInt32),F,Idx,KindID)
end

function LLVMGetStringAttributeAtIndex(F::LLVMValueRef,Idx::LLVMAttributeIndex,K,KLen::UInt32)
    ccall((:LLVMGetStringAttributeAtIndex,libllvm),LLVMAttributeRef,(LLVMValueRef,LLVMAttributeIndex,Cstring,UInt32),F,Idx,K,KLen)
end

function LLVMRemoveEnumAttributeAtIndex(F::LLVMValueRef,Idx::LLVMAttributeIndex,KindID::UInt32)
    ccall((:LLVMRemoveEnumAttributeAtIndex,libllvm),Void,(LLVMValueRef,LLVMAttributeIndex,UInt32),F,Idx,KindID)
end

function LLVMRemoveStringAttributeAtIndex(F::LLVMValueRef,Idx::LLVMAttributeIndex,K,KLen::UInt32)
    ccall((:LLVMRemoveStringAttributeAtIndex,libllvm),Void,(LLVMValueRef,LLVMAttributeIndex,Cstring,UInt32),F,Idx,K,KLen)
end

function LLVMAddTargetDependentFunctionAttr(Fn::LLVMValueRef,A,V)
    ccall((:LLVMAddTargetDependentFunctionAttr,libllvm),Void,(LLVMValueRef,Cstring,Cstring),Fn,A,V)
end

function LLVMGetFunctionAttr(Fn::LLVMValueRef)
    ccall((:LLVMGetFunctionAttr,libllvm),LLVMAttribute,(LLVMValueRef,),Fn)
end

function LLVMRemoveFunctionAttr(Fn::LLVMValueRef,PA::LLVMAttribute)
    ccall((:LLVMRemoveFunctionAttr,libllvm),Void,(LLVMValueRef,LLVMAttribute),Fn,PA)
end

function LLVMCountParams(Fn::LLVMValueRef)
    ccall((:LLVMCountParams,libllvm),UInt32,(LLVMValueRef,),Fn)
end

function LLVMGetParams(Fn::LLVMValueRef,Params)
    ccall((:LLVMGetParams,libllvm),Void,(LLVMValueRef,Ptr{LLVMValueRef}),Fn,Params)
end

function LLVMGetParam(Fn::LLVMValueRef,Index::UInt32)
    ccall((:LLVMGetParam,libllvm),LLVMValueRef,(LLVMValueRef,UInt32),Fn,Index)
end

function LLVMGetParamParent(Inst::LLVMValueRef)
    ccall((:LLVMGetParamParent,libllvm),LLVMValueRef,(LLVMValueRef,),Inst)
end

function LLVMGetFirstParam(Fn::LLVMValueRef)
    ccall((:LLVMGetFirstParam,libllvm),LLVMValueRef,(LLVMValueRef,),Fn)
end

function LLVMGetLastParam(Fn::LLVMValueRef)
    ccall((:LLVMGetLastParam,libllvm),LLVMValueRef,(LLVMValueRef,),Fn)
end

function LLVMGetNextParam(Arg::LLVMValueRef)
    ccall((:LLVMGetNextParam,libllvm),LLVMValueRef,(LLVMValueRef,),Arg)
end

function LLVMGetPreviousParam(Arg::LLVMValueRef)
    ccall((:LLVMGetPreviousParam,libllvm),LLVMValueRef,(LLVMValueRef,),Arg)
end

function LLVMAddAttribute(Arg::LLVMValueRef,PA::LLVMAttribute)
    ccall((:LLVMAddAttribute,libllvm),Void,(LLVMValueRef,LLVMAttribute),Arg,PA)
end

function LLVMRemoveAttribute(Arg::LLVMValueRef,PA::LLVMAttribute)
    ccall((:LLVMRemoveAttribute,libllvm),Void,(LLVMValueRef,LLVMAttribute),Arg,PA)
end

function LLVMGetAttribute(Arg::LLVMValueRef)
    ccall((:LLVMGetAttribute,libllvm),LLVMAttribute,(LLVMValueRef,),Arg)
end

function LLVMSetParamAlignment(Arg::LLVMValueRef,Align::UInt32)
    ccall((:LLVMSetParamAlignment,libllvm),Void,(LLVMValueRef,UInt32),Arg,Align)
end

function LLVMMDStringInContext(C::LLVMContextRef,Str,SLen::UInt32)
    ccall((:LLVMMDStringInContext,libllvm),LLVMValueRef,(LLVMContextRef,Cstring,UInt32),C,Str,SLen)
end

function LLVMMDString(Str,SLen::UInt32)
    ccall((:LLVMMDString,libllvm),LLVMValueRef,(Cstring,UInt32),Str,SLen)
end

function LLVMMDNodeInContext(C::LLVMContextRef,Vals,Count::UInt32)
    ccall((:LLVMMDNodeInContext,libllvm),LLVMValueRef,(LLVMContextRef,Ptr{LLVMValueRef},UInt32),C,Vals,Count)
end

function LLVMMDNode(Vals,Count::UInt32)
    ccall((:LLVMMDNode,libllvm),LLVMValueRef,(Ptr{LLVMValueRef},UInt32),Vals,Count)
end

function LLVMGetMDString(V::LLVMValueRef,Length)
    ccall((:LLVMGetMDString,libllvm),Cstring,(LLVMValueRef,Ptr{UInt32}),V,Length)
end

function LLVMGetMDNodeNumOperands(V::LLVMValueRef)
    ccall((:LLVMGetMDNodeNumOperands,libllvm),UInt32,(LLVMValueRef,),V)
end

function LLVMGetMDNodeOperands(V::LLVMValueRef,Dest)
    ccall((:LLVMGetMDNodeOperands,libllvm),Void,(LLVMValueRef,Ptr{LLVMValueRef}),V,Dest)
end

function LLVMBasicBlockAsValue(BB::LLVMBasicBlockRef)
    ccall((:LLVMBasicBlockAsValue,libllvm),LLVMValueRef,(LLVMBasicBlockRef,),BB)
end

function LLVMValueIsBasicBlock(Val::LLVMValueRef)
    ccall((:LLVMValueIsBasicBlock,libllvm),LLVMBool,(LLVMValueRef,),Val)
end

function LLVMValueAsBasicBlock(Val::LLVMValueRef)
    ccall((:LLVMValueAsBasicBlock,libllvm),LLVMBasicBlockRef,(LLVMValueRef,),Val)
end

function LLVMGetBasicBlockName(BB::LLVMBasicBlockRef)
    ccall((:LLVMGetBasicBlockName,libllvm),Cstring,(LLVMBasicBlockRef,),BB)
end

function LLVMGetBasicBlockParent(BB::LLVMBasicBlockRef)
    ccall((:LLVMGetBasicBlockParent,libllvm),LLVMValueRef,(LLVMBasicBlockRef,),BB)
end

function LLVMGetBasicBlockTerminator(BB::LLVMBasicBlockRef)
    ccall((:LLVMGetBasicBlockTerminator,libllvm),LLVMValueRef,(LLVMBasicBlockRef,),BB)
end

function LLVMCountBasicBlocks(Fn::LLVMValueRef)
    ccall((:LLVMCountBasicBlocks,libllvm),UInt32,(LLVMValueRef,),Fn)
end

function LLVMGetBasicBlocks(Fn::LLVMValueRef,BasicBlocks)
    ccall((:LLVMGetBasicBlocks,libllvm),Void,(LLVMValueRef,Ptr{LLVMBasicBlockRef}),Fn,BasicBlocks)
end

function LLVMGetFirstBasicBlock(Fn::LLVMValueRef)
    ccall((:LLVMGetFirstBasicBlock,libllvm),LLVMBasicBlockRef,(LLVMValueRef,),Fn)
end

function LLVMGetLastBasicBlock(Fn::LLVMValueRef)
    ccall((:LLVMGetLastBasicBlock,libllvm),LLVMBasicBlockRef,(LLVMValueRef,),Fn)
end

function LLVMGetNextBasicBlock(BB::LLVMBasicBlockRef)
    ccall((:LLVMGetNextBasicBlock,libllvm),LLVMBasicBlockRef,(LLVMBasicBlockRef,),BB)
end

function LLVMGetPreviousBasicBlock(BB::LLVMBasicBlockRef)
    ccall((:LLVMGetPreviousBasicBlock,libllvm),LLVMBasicBlockRef,(LLVMBasicBlockRef,),BB)
end

function LLVMGetEntryBasicBlock(Fn::LLVMValueRef)
    ccall((:LLVMGetEntryBasicBlock,libllvm),LLVMBasicBlockRef,(LLVMValueRef,),Fn)
end

function LLVMAppendBasicBlockInContext(C::LLVMContextRef,Fn::LLVMValueRef,Name)
    ccall((:LLVMAppendBasicBlockInContext,libllvm),LLVMBasicBlockRef,(LLVMContextRef,LLVMValueRef,Cstring),C,Fn,Name)
end

function LLVMAppendBasicBlock(Fn::LLVMValueRef,Name)
    ccall((:LLVMAppendBasicBlock,libllvm),LLVMBasicBlockRef,(LLVMValueRef,Cstring),Fn,Name)
end

function LLVMInsertBasicBlockInContext(C::LLVMContextRef,BB::LLVMBasicBlockRef,Name)
    ccall((:LLVMInsertBasicBlockInContext,libllvm),LLVMBasicBlockRef,(LLVMContextRef,LLVMBasicBlockRef,Cstring),C,BB,Name)
end

function LLVMInsertBasicBlock(InsertBeforeBB::LLVMBasicBlockRef,Name)
    ccall((:LLVMInsertBasicBlock,libllvm),LLVMBasicBlockRef,(LLVMBasicBlockRef,Cstring),InsertBeforeBB,Name)
end

function LLVMDeleteBasicBlock(BB::LLVMBasicBlockRef)
    ccall((:LLVMDeleteBasicBlock,libllvm),Void,(LLVMBasicBlockRef,),BB)
end

function LLVMRemoveBasicBlockFromParent(BB::LLVMBasicBlockRef)
    ccall((:LLVMRemoveBasicBlockFromParent,libllvm),Void,(LLVMBasicBlockRef,),BB)
end

function LLVMMoveBasicBlockBefore(BB::LLVMBasicBlockRef,MovePos::LLVMBasicBlockRef)
    ccall((:LLVMMoveBasicBlockBefore,libllvm),Void,(LLVMBasicBlockRef,LLVMBasicBlockRef),BB,MovePos)
end

function LLVMMoveBasicBlockAfter(BB::LLVMBasicBlockRef,MovePos::LLVMBasicBlockRef)
    ccall((:LLVMMoveBasicBlockAfter,libllvm),Void,(LLVMBasicBlockRef,LLVMBasicBlockRef),BB,MovePos)
end

function LLVMGetFirstInstruction(BB::LLVMBasicBlockRef)
    ccall((:LLVMGetFirstInstruction,libllvm),LLVMValueRef,(LLVMBasicBlockRef,),BB)
end

function LLVMGetLastInstruction(BB::LLVMBasicBlockRef)
    ccall((:LLVMGetLastInstruction,libllvm),LLVMValueRef,(LLVMBasicBlockRef,),BB)
end

function LLVMHasMetadata(Val::LLVMValueRef)
    ccall((:LLVMHasMetadata,libllvm),Cint,(LLVMValueRef,),Val)
end

function LLVMGetMetadata(Val::LLVMValueRef,KindID::UInt32)
    ccall((:LLVMGetMetadata,libllvm),LLVMValueRef,(LLVMValueRef,UInt32),Val,KindID)
end

function LLVMSetMetadata(Val::LLVMValueRef,KindID::UInt32,Node::LLVMValueRef)
    ccall((:LLVMSetMetadata,libllvm),Void,(LLVMValueRef,UInt32,LLVMValueRef),Val,KindID,Node)
end

function LLVMGetInstructionParent(Inst::LLVMValueRef)
    ccall((:LLVMGetInstructionParent,libllvm),LLVMBasicBlockRef,(LLVMValueRef,),Inst)
end

function LLVMGetNextInstruction(Inst::LLVMValueRef)
    ccall((:LLVMGetNextInstruction,libllvm),LLVMValueRef,(LLVMValueRef,),Inst)
end

function LLVMGetPreviousInstruction(Inst::LLVMValueRef)
    ccall((:LLVMGetPreviousInstruction,libllvm),LLVMValueRef,(LLVMValueRef,),Inst)
end

function LLVMInstructionRemoveFromParent(Inst::LLVMValueRef)
    ccall((:LLVMInstructionRemoveFromParent,libllvm),Void,(LLVMValueRef,),Inst)
end

function LLVMInstructionEraseFromParent(Inst::LLVMValueRef)
    ccall((:LLVMInstructionEraseFromParent,libllvm),Void,(LLVMValueRef,),Inst)
end

function LLVMGetInstructionOpcode(Inst::LLVMValueRef)
    ccall((:LLVMGetInstructionOpcode,libllvm),LLVMOpcode,(LLVMValueRef,),Inst)
end

function LLVMGetICmpPredicate(Inst::LLVMValueRef)
    ccall((:LLVMGetICmpPredicate,libllvm),LLVMIntPredicate,(LLVMValueRef,),Inst)
end

function LLVMGetFCmpPredicate(Inst::LLVMValueRef)
    ccall((:LLVMGetFCmpPredicate,libllvm),LLVMRealPredicate,(LLVMValueRef,),Inst)
end

function LLVMInstructionClone(Inst::LLVMValueRef)
    ccall((:LLVMInstructionClone,libllvm),LLVMValueRef,(LLVMValueRef,),Inst)
end

function LLVMGetNumArgOperands(Instr::LLVMValueRef)
    ccall((:LLVMGetNumArgOperands,libllvm),UInt32,(LLVMValueRef,),Instr)
end

function LLVMSetInstructionCallConv(Instr::LLVMValueRef,CC::UInt32)
    ccall((:LLVMSetInstructionCallConv,libllvm),Void,(LLVMValueRef,UInt32),Instr,CC)
end

function LLVMGetInstructionCallConv(Instr::LLVMValueRef)
    ccall((:LLVMGetInstructionCallConv,libllvm),UInt32,(LLVMValueRef,),Instr)
end

function LLVMAddInstrAttribute(Instr::LLVMValueRef,index::UInt32,arg1::LLVMAttribute)
    ccall((:LLVMAddInstrAttribute,libllvm),Void,(LLVMValueRef,UInt32,LLVMAttribute),Instr,index,arg1)
end

function LLVMRemoveInstrAttribute(Instr::LLVMValueRef,index::UInt32,arg1::LLVMAttribute)
    ccall((:LLVMRemoveInstrAttribute,libllvm),Void,(LLVMValueRef,UInt32,LLVMAttribute),Instr,index,arg1)
end

function LLVMSetInstrParamAlignment(Instr::LLVMValueRef,index::UInt32,Align::UInt32)
    ccall((:LLVMSetInstrParamAlignment,libllvm),Void,(LLVMValueRef,UInt32,UInt32),Instr,index,Align)
end

function LLVMAddCallSiteAttribute(C::LLVMValueRef,Idx::LLVMAttributeIndex,A::LLVMAttributeRef)
    ccall((:LLVMAddCallSiteAttribute,libllvm),Void,(LLVMValueRef,LLVMAttributeIndex,LLVMAttributeRef),C,Idx,A)
end

function LLVMGetCallSiteAttributeCount(C::LLVMValueRef,Idx::LLVMAttributeIndex)
    ccall((:LLVMGetCallSiteAttributeCount,libllvm),UInt32,(LLVMValueRef,LLVMAttributeIndex),C,Idx)
end

function LLVMGetCallSiteAttributes(C::LLVMValueRef,Idx::LLVMAttributeIndex,Attrs)
    ccall((:LLVMGetCallSiteAttributes,libllvm),Void,(LLVMValueRef,LLVMAttributeIndex,Ptr{LLVMAttributeRef}),C,Idx,Attrs)
end

function LLVMGetCallSiteEnumAttribute(C::LLVMValueRef,Idx::LLVMAttributeIndex,KindID::UInt32)
    ccall((:LLVMGetCallSiteEnumAttribute,libllvm),LLVMAttributeRef,(LLVMValueRef,LLVMAttributeIndex,UInt32),C,Idx,KindID)
end

function LLVMGetCallSiteStringAttribute(C::LLVMValueRef,Idx::LLVMAttributeIndex,K,KLen::UInt32)
    ccall((:LLVMGetCallSiteStringAttribute,libllvm),LLVMAttributeRef,(LLVMValueRef,LLVMAttributeIndex,Cstring,UInt32),C,Idx,K,KLen)
end

function LLVMRemoveCallSiteEnumAttribute(C::LLVMValueRef,Idx::LLVMAttributeIndex,KindID::UInt32)
    ccall((:LLVMRemoveCallSiteEnumAttribute,libllvm),Void,(LLVMValueRef,LLVMAttributeIndex,UInt32),C,Idx,KindID)
end

function LLVMRemoveCallSiteStringAttribute(C::LLVMValueRef,Idx::LLVMAttributeIndex,K,KLen::UInt32)
    ccall((:LLVMRemoveCallSiteStringAttribute,libllvm),Void,(LLVMValueRef,LLVMAttributeIndex,Cstring,UInt32),C,Idx,K,KLen)
end

function LLVMGetCalledValue(Instr::LLVMValueRef)
    ccall((:LLVMGetCalledValue,libllvm),LLVMValueRef,(LLVMValueRef,),Instr)
end

function LLVMIsTailCall(CallInst::LLVMValueRef)
    ccall((:LLVMIsTailCall,libllvm),LLVMBool,(LLVMValueRef,),CallInst)
end

function LLVMSetTailCall(CallInst::LLVMValueRef,IsTailCall::LLVMBool)
    ccall((:LLVMSetTailCall,libllvm),Void,(LLVMValueRef,LLVMBool),CallInst,IsTailCall)
end

function LLVMGetNormalDest(InvokeInst::LLVMValueRef)
    ccall((:LLVMGetNormalDest,libllvm),LLVMBasicBlockRef,(LLVMValueRef,),InvokeInst)
end

function LLVMGetUnwindDest(InvokeInst::LLVMValueRef)
    ccall((:LLVMGetUnwindDest,libllvm),LLVMBasicBlockRef,(LLVMValueRef,),InvokeInst)
end

function LLVMSetNormalDest(InvokeInst::LLVMValueRef,B::LLVMBasicBlockRef)
    ccall((:LLVMSetNormalDest,libllvm),Void,(LLVMValueRef,LLVMBasicBlockRef),InvokeInst,B)
end

function LLVMSetUnwindDest(InvokeInst::LLVMValueRef,B::LLVMBasicBlockRef)
    ccall((:LLVMSetUnwindDest,libllvm),Void,(LLVMValueRef,LLVMBasicBlockRef),InvokeInst,B)
end

function LLVMGetNumSuccessors(Term::LLVMValueRef)
    ccall((:LLVMGetNumSuccessors,libllvm),UInt32,(LLVMValueRef,),Term)
end

function LLVMGetSuccessor(Term::LLVMValueRef,i::UInt32)
    ccall((:LLVMGetSuccessor,libllvm),LLVMBasicBlockRef,(LLVMValueRef,UInt32),Term,i)
end

function LLVMSetSuccessor(Term::LLVMValueRef,i::UInt32,block::LLVMBasicBlockRef)
    ccall((:LLVMSetSuccessor,libllvm),Void,(LLVMValueRef,UInt32,LLVMBasicBlockRef),Term,i,block)
end

function LLVMIsConditional(Branch::LLVMValueRef)
    ccall((:LLVMIsConditional,libllvm),LLVMBool,(LLVMValueRef,),Branch)
end

function LLVMGetCondition(Branch::LLVMValueRef)
    ccall((:LLVMGetCondition,libllvm),LLVMValueRef,(LLVMValueRef,),Branch)
end

function LLVMSetCondition(Branch::LLVMValueRef,Cond::LLVMValueRef)
    ccall((:LLVMSetCondition,libllvm),Void,(LLVMValueRef,LLVMValueRef),Branch,Cond)
end

function LLVMGetSwitchDefaultDest(SwitchInstr::LLVMValueRef)
    ccall((:LLVMGetSwitchDefaultDest,libllvm),LLVMBasicBlockRef,(LLVMValueRef,),SwitchInstr)
end

function LLVMGetAllocatedType(Alloca::LLVMValueRef)
    ccall((:LLVMGetAllocatedType,libllvm),LLVMTypeRef,(LLVMValueRef,),Alloca)
end

function LLVMIsInBounds(GEP::LLVMValueRef)
    ccall((:LLVMIsInBounds,libllvm),LLVMBool,(LLVMValueRef,),GEP)
end

function LLVMSetIsInBounds(GEP::LLVMValueRef,InBounds::LLVMBool)
    ccall((:LLVMSetIsInBounds,libllvm),Void,(LLVMValueRef,LLVMBool),GEP,InBounds)
end

function LLVMAddIncoming(PhiNode::LLVMValueRef,IncomingValues,IncomingBlocks,Count::UInt32)
    ccall((:LLVMAddIncoming,libllvm),Void,(LLVMValueRef,Ptr{LLVMValueRef},Ptr{LLVMBasicBlockRef},UInt32),PhiNode,IncomingValues,IncomingBlocks,Count)
end

function LLVMCountIncoming(PhiNode::LLVMValueRef)
    ccall((:LLVMCountIncoming,libllvm),UInt32,(LLVMValueRef,),PhiNode)
end

function LLVMGetIncomingValue(PhiNode::LLVMValueRef,Index::UInt32)
    ccall((:LLVMGetIncomingValue,libllvm),LLVMValueRef,(LLVMValueRef,UInt32),PhiNode,Index)
end

function LLVMGetIncomingBlock(PhiNode::LLVMValueRef,Index::UInt32)
    ccall((:LLVMGetIncomingBlock,libllvm),LLVMBasicBlockRef,(LLVMValueRef,UInt32),PhiNode,Index)
end

function LLVMGetNumIndices(Inst::LLVMValueRef)
    ccall((:LLVMGetNumIndices,libllvm),UInt32,(LLVMValueRef,),Inst)
end

function LLVMGetIndices(Inst::LLVMValueRef)
    ccall((:LLVMGetIndices,libllvm),Ptr{UInt32},(LLVMValueRef,),Inst)
end

function LLVMCreateBuilderInContext(C::LLVMContextRef)
    ccall((:LLVMCreateBuilderInContext,libllvm),LLVMBuilderRef,(LLVMContextRef,),C)
end

function LLVMCreateBuilder()
    ccall((:LLVMCreateBuilder,libllvm),LLVMBuilderRef,())
end

function LLVMPositionBuilder(Builder::LLVMBuilderRef,Block::LLVMBasicBlockRef,Instr::LLVMValueRef)
    ccall((:LLVMPositionBuilder,libllvm),Void,(LLVMBuilderRef,LLVMBasicBlockRef,LLVMValueRef),Builder,Block,Instr)
end

function LLVMPositionBuilderBefore(Builder::LLVMBuilderRef,Instr::LLVMValueRef)
    ccall((:LLVMPositionBuilderBefore,libllvm),Void,(LLVMBuilderRef,LLVMValueRef),Builder,Instr)
end

function LLVMPositionBuilderAtEnd(Builder::LLVMBuilderRef,Block::LLVMBasicBlockRef)
    ccall((:LLVMPositionBuilderAtEnd,libllvm),Void,(LLVMBuilderRef,LLVMBasicBlockRef),Builder,Block)
end

function LLVMGetInsertBlock(Builder::LLVMBuilderRef)
    ccall((:LLVMGetInsertBlock,libllvm),LLVMBasicBlockRef,(LLVMBuilderRef,),Builder)
end

function LLVMClearInsertionPosition(Builder::LLVMBuilderRef)
    ccall((:LLVMClearInsertionPosition,libllvm),Void,(LLVMBuilderRef,),Builder)
end

function LLVMInsertIntoBuilder(Builder::LLVMBuilderRef,Instr::LLVMValueRef)
    ccall((:LLVMInsertIntoBuilder,libllvm),Void,(LLVMBuilderRef,LLVMValueRef),Builder,Instr)
end

function LLVMInsertIntoBuilderWithName(Builder::LLVMBuilderRef,Instr::LLVMValueRef,Name)
    ccall((:LLVMInsertIntoBuilderWithName,libllvm),Void,(LLVMBuilderRef,LLVMValueRef,Cstring),Builder,Instr,Name)
end

function LLVMDisposeBuilder(Builder::LLVMBuilderRef)
    ccall((:LLVMDisposeBuilder,libllvm),Void,(LLVMBuilderRef,),Builder)
end

function LLVMSetCurrentDebugLocation(Builder::LLVMBuilderRef,L::LLVMValueRef)
    ccall((:LLVMSetCurrentDebugLocation,libllvm),Void,(LLVMBuilderRef,LLVMValueRef),Builder,L)
end

function LLVMGetCurrentDebugLocation(Builder::LLVMBuilderRef)
    ccall((:LLVMGetCurrentDebugLocation,libllvm),LLVMValueRef,(LLVMBuilderRef,),Builder)
end

function LLVMSetInstDebugLocation(Builder::LLVMBuilderRef,Inst::LLVMValueRef)
    ccall((:LLVMSetInstDebugLocation,libllvm),Void,(LLVMBuilderRef,LLVMValueRef),Builder,Inst)
end

function LLVMBuildRetVoid(arg1::LLVMBuilderRef)
    ccall((:LLVMBuildRetVoid,libllvm),LLVMValueRef,(LLVMBuilderRef,),arg1)
end

function LLVMBuildRet(arg1::LLVMBuilderRef,V::LLVMValueRef)
    ccall((:LLVMBuildRet,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef),arg1,V)
end

function LLVMBuildAggregateRet(arg1::LLVMBuilderRef,RetVals,N::UInt32)
    ccall((:LLVMBuildAggregateRet,libllvm),LLVMValueRef,(LLVMBuilderRef,Ptr{LLVMValueRef},UInt32),arg1,RetVals,N)
end

function LLVMBuildBr(arg1::LLVMBuilderRef,Dest::LLVMBasicBlockRef)
    ccall((:LLVMBuildBr,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMBasicBlockRef),arg1,Dest)
end

function LLVMBuildCondBr(arg1::LLVMBuilderRef,If::LLVMValueRef,Then::LLVMBasicBlockRef,Else::LLVMBasicBlockRef)
    ccall((:LLVMBuildCondBr,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMBasicBlockRef,LLVMBasicBlockRef),arg1,If,Then,Else)
end

function LLVMBuildSwitch(arg1::LLVMBuilderRef,V::LLVMValueRef,Else::LLVMBasicBlockRef,NumCases::UInt32)
    ccall((:LLVMBuildSwitch,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMBasicBlockRef,UInt32),arg1,V,Else,NumCases)
end

function LLVMBuildIndirectBr(B::LLVMBuilderRef,Addr::LLVMValueRef,NumDests::UInt32)
    ccall((:LLVMBuildIndirectBr,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,UInt32),B,Addr,NumDests)
end

function LLVMBuildInvoke(arg1::LLVMBuilderRef,Fn::LLVMValueRef,Args,NumArgs::UInt32,Then::LLVMBasicBlockRef,Catch::LLVMBasicBlockRef,Name)
    ccall((:LLVMBuildInvoke,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,Ptr{LLVMValueRef},UInt32,LLVMBasicBlockRef,LLVMBasicBlockRef,Cstring),arg1,Fn,Args,NumArgs,Then,Catch,Name)
end

function LLVMBuildLandingPad(B::LLVMBuilderRef,Ty::LLVMTypeRef,PersFn::LLVMValueRef,NumClauses::UInt32,Name)
    ccall((:LLVMBuildLandingPad,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMTypeRef,LLVMValueRef,UInt32,Cstring),B,Ty,PersFn,NumClauses,Name)
end

function LLVMBuildResume(B::LLVMBuilderRef,Exn::LLVMValueRef)
    ccall((:LLVMBuildResume,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef),B,Exn)
end

function LLVMBuildUnreachable(arg1::LLVMBuilderRef)
    ccall((:LLVMBuildUnreachable,libllvm),LLVMValueRef,(LLVMBuilderRef,),arg1)
end

function LLVMAddCase(Switch::LLVMValueRef,OnVal::LLVMValueRef,Dest::LLVMBasicBlockRef)
    ccall((:LLVMAddCase,libllvm),Void,(LLVMValueRef,LLVMValueRef,LLVMBasicBlockRef),Switch,OnVal,Dest)
end

function LLVMAddDestination(IndirectBr::LLVMValueRef,Dest::LLVMBasicBlockRef)
    ccall((:LLVMAddDestination,libllvm),Void,(LLVMValueRef,LLVMBasicBlockRef),IndirectBr,Dest)
end

function LLVMGetNumClauses(LandingPad::LLVMValueRef)
    ccall((:LLVMGetNumClauses,libllvm),UInt32,(LLVMValueRef,),LandingPad)
end

function LLVMGetClause(LandingPad::LLVMValueRef,Idx::UInt32)
    ccall((:LLVMGetClause,libllvm),LLVMValueRef,(LLVMValueRef,UInt32),LandingPad,Idx)
end

function LLVMAddClause(LandingPad::LLVMValueRef,ClauseVal::LLVMValueRef)
    ccall((:LLVMAddClause,libllvm),Void,(LLVMValueRef,LLVMValueRef),LandingPad,ClauseVal)
end

function LLVMIsCleanup(LandingPad::LLVMValueRef)
    ccall((:LLVMIsCleanup,libllvm),LLVMBool,(LLVMValueRef,),LandingPad)
end

function LLVMSetCleanup(LandingPad::LLVMValueRef,Val::LLVMBool)
    ccall((:LLVMSetCleanup,libllvm),Void,(LLVMValueRef,LLVMBool),LandingPad,Val)
end

function LLVMBuildAdd(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildAdd,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildNSWAdd(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildNSWAdd,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildNUWAdd(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildNUWAdd,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildFAdd(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildFAdd,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildSub(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildSub,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildNSWSub(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildNSWSub,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildNUWSub(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildNUWSub,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildFSub(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildFSub,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildMul(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildMul,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildNSWMul(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildNSWMul,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildNUWMul(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildNUWMul,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildFMul(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildFMul,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildUDiv(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildUDiv,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildSDiv(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildSDiv,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildExactSDiv(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildExactSDiv,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildFDiv(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildFDiv,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildURem(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildURem,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildSRem(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildSRem,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildFRem(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildFRem,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildShl(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildShl,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildLShr(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildLShr,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildAShr(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildAShr,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildAnd(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildAnd,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildOr(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildOr,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildXor(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildXor,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildBinOp(B::LLVMBuilderRef,Op::LLVMOpcode,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildBinOp,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMOpcode,LLVMValueRef,LLVMValueRef,Cstring),B,Op,LHS,RHS,Name)
end

function LLVMBuildNeg(arg1::LLVMBuilderRef,V::LLVMValueRef,Name)
    ccall((:LLVMBuildNeg,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,Cstring),arg1,V,Name)
end

function LLVMBuildNSWNeg(B::LLVMBuilderRef,V::LLVMValueRef,Name)
    ccall((:LLVMBuildNSWNeg,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,Cstring),B,V,Name)
end

function LLVMBuildNUWNeg(B::LLVMBuilderRef,V::LLVMValueRef,Name)
    ccall((:LLVMBuildNUWNeg,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,Cstring),B,V,Name)
end

function LLVMBuildFNeg(arg1::LLVMBuilderRef,V::LLVMValueRef,Name)
    ccall((:LLVMBuildFNeg,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,Cstring),arg1,V,Name)
end

function LLVMBuildNot(arg1::LLVMBuilderRef,V::LLVMValueRef,Name)
    ccall((:LLVMBuildNot,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,Cstring),arg1,V,Name)
end

function LLVMBuildMalloc(arg1::LLVMBuilderRef,Ty::LLVMTypeRef,Name)
    ccall((:LLVMBuildMalloc,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMTypeRef,Cstring),arg1,Ty,Name)
end

function LLVMBuildArrayMalloc(arg1::LLVMBuilderRef,Ty::LLVMTypeRef,Val::LLVMValueRef,Name)
    ccall((:LLVMBuildArrayMalloc,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMTypeRef,LLVMValueRef,Cstring),arg1,Ty,Val,Name)
end

function LLVMBuildAlloca(arg1::LLVMBuilderRef,Ty::LLVMTypeRef,Name)
    ccall((:LLVMBuildAlloca,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMTypeRef,Cstring),arg1,Ty,Name)
end

function LLVMBuildArrayAlloca(arg1::LLVMBuilderRef,Ty::LLVMTypeRef,Val::LLVMValueRef,Name)
    ccall((:LLVMBuildArrayAlloca,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMTypeRef,LLVMValueRef,Cstring),arg1,Ty,Val,Name)
end

function LLVMBuildFree(arg1::LLVMBuilderRef,PointerVal::LLVMValueRef)
    ccall((:LLVMBuildFree,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef),arg1,PointerVal)
end

function LLVMBuildLoad(arg1::LLVMBuilderRef,PointerVal::LLVMValueRef,Name)
    ccall((:LLVMBuildLoad,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,Cstring),arg1,PointerVal,Name)
end

function LLVMBuildStore(arg1::LLVMBuilderRef,Val::LLVMValueRef,Ptr::LLVMValueRef)
    ccall((:LLVMBuildStore,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef),arg1,Val,Ptr)
end

function LLVMBuildGEP(B::LLVMBuilderRef,Pointer::LLVMValueRef,Indices,NumIndices::UInt32,Name)
    ccall((:LLVMBuildGEP,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,Ptr{LLVMValueRef},UInt32,Cstring),B,Pointer,Indices,NumIndices,Name)
end

function LLVMBuildInBoundsGEP(B::LLVMBuilderRef,Pointer::LLVMValueRef,Indices,NumIndices::UInt32,Name)
    ccall((:LLVMBuildInBoundsGEP,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,Ptr{LLVMValueRef},UInt32,Cstring),B,Pointer,Indices,NumIndices,Name)
end

function LLVMBuildStructGEP(B::LLVMBuilderRef,Pointer::LLVMValueRef,Idx::UInt32,Name)
    ccall((:LLVMBuildStructGEP,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,UInt32,Cstring),B,Pointer,Idx,Name)
end

function LLVMBuildGlobalString(B::LLVMBuilderRef,Str,Name)
    ccall((:LLVMBuildGlobalString,libllvm),LLVMValueRef,(LLVMBuilderRef,Cstring,Cstring),B,Str,Name)
end

function LLVMBuildGlobalStringPtr(B::LLVMBuilderRef,Str,Name)
    ccall((:LLVMBuildGlobalStringPtr,libllvm),LLVMValueRef,(LLVMBuilderRef,Cstring,Cstring),B,Str,Name)
end

function LLVMGetVolatile(MemoryAccessInst::LLVMValueRef)
    ccall((:LLVMGetVolatile,libllvm),LLVMBool,(LLVMValueRef,),MemoryAccessInst)
end

function LLVMSetVolatile(MemoryAccessInst::LLVMValueRef,IsVolatile::LLVMBool)
    ccall((:LLVMSetVolatile,libllvm),Void,(LLVMValueRef,LLVMBool),MemoryAccessInst,IsVolatile)
end

function LLVMGetOrdering(MemoryAccessInst::LLVMValueRef)
    ccall((:LLVMGetOrdering,libllvm),LLVMAtomicOrdering,(LLVMValueRef,),MemoryAccessInst)
end

function LLVMSetOrdering(MemoryAccessInst::LLVMValueRef,Ordering::LLVMAtomicOrdering)
    ccall((:LLVMSetOrdering,libllvm),Void,(LLVMValueRef,LLVMAtomicOrdering),MemoryAccessInst,Ordering)
end

function LLVMBuildTrunc(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildTrunc,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildZExt(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildZExt,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildSExt(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildSExt,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildFPToUI(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildFPToUI,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildFPToSI(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildFPToSI,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildUIToFP(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildUIToFP,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildSIToFP(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildSIToFP,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildFPTrunc(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildFPTrunc,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildFPExt(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildFPExt,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildPtrToInt(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildPtrToInt,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildIntToPtr(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildIntToPtr,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildBitCast(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildBitCast,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildAddrSpaceCast(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildAddrSpaceCast,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildZExtOrBitCast(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildZExtOrBitCast,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildSExtOrBitCast(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildSExtOrBitCast,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildTruncOrBitCast(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildTruncOrBitCast,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildCast(B::LLVMBuilderRef,Op::LLVMOpcode,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildCast,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMOpcode,LLVMValueRef,LLVMTypeRef,Cstring),B,Op,Val,DestTy,Name)
end

function LLVMBuildPointerCast(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildPointerCast,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildIntCast(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildIntCast,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildFPCast(arg1::LLVMBuilderRef,Val::LLVMValueRef,DestTy::LLVMTypeRef,Name)
    ccall((:LLVMBuildFPCast,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,Val,DestTy,Name)
end

function LLVMBuildICmp(arg1::LLVMBuilderRef,Op::LLVMIntPredicate,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildICmp,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMIntPredicate,LLVMValueRef,LLVMValueRef,Cstring),arg1,Op,LHS,RHS,Name)
end

function LLVMBuildFCmp(arg1::LLVMBuilderRef,Op::LLVMRealPredicate,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildFCmp,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMRealPredicate,LLVMValueRef,LLVMValueRef,Cstring),arg1,Op,LHS,RHS,Name)
end

function LLVMBuildPhi(arg1::LLVMBuilderRef,Ty::LLVMTypeRef,Name)
    ccall((:LLVMBuildPhi,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMTypeRef,Cstring),arg1,Ty,Name)
end

function LLVMBuildCall(arg1::LLVMBuilderRef,Fn::LLVMValueRef,Args,NumArgs::UInt32,Name)
    ccall((:LLVMBuildCall,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,Ptr{LLVMValueRef},UInt32,Cstring),arg1,Fn,Args,NumArgs,Name)
end

function LLVMBuildSelect(arg1::LLVMBuilderRef,If::LLVMValueRef,Then::LLVMValueRef,Else::LLVMValueRef,Name)
    ccall((:LLVMBuildSelect,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,If,Then,Else,Name)
end

function LLVMBuildVAArg(arg1::LLVMBuilderRef,List::LLVMValueRef,Ty::LLVMTypeRef,Name)
    ccall((:LLVMBuildVAArg,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMTypeRef,Cstring),arg1,List,Ty,Name)
end

function LLVMBuildExtractElement(arg1::LLVMBuilderRef,VecVal::LLVMValueRef,Index::LLVMValueRef,Name)
    ccall((:LLVMBuildExtractElement,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,VecVal,Index,Name)
end

function LLVMBuildInsertElement(arg1::LLVMBuilderRef,VecVal::LLVMValueRef,EltVal::LLVMValueRef,Index::LLVMValueRef,Name)
    ccall((:LLVMBuildInsertElement,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,VecVal,EltVal,Index,Name)
end

function LLVMBuildShuffleVector(arg1::LLVMBuilderRef,V1::LLVMValueRef,V2::LLVMValueRef,Mask::LLVMValueRef,Name)
    ccall((:LLVMBuildShuffleVector,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,V1,V2,Mask,Name)
end

function LLVMBuildExtractValue(arg1::LLVMBuilderRef,AggVal::LLVMValueRef,Index::UInt32,Name)
    ccall((:LLVMBuildExtractValue,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,UInt32,Cstring),arg1,AggVal,Index,Name)
end

function LLVMBuildInsertValue(arg1::LLVMBuilderRef,AggVal::LLVMValueRef,EltVal::LLVMValueRef,Index::UInt32,Name)
    ccall((:LLVMBuildInsertValue,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,UInt32,Cstring),arg1,AggVal,EltVal,Index,Name)
end

function LLVMBuildIsNull(arg1::LLVMBuilderRef,Val::LLVMValueRef,Name)
    ccall((:LLVMBuildIsNull,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,Cstring),arg1,Val,Name)
end

function LLVMBuildIsNotNull(arg1::LLVMBuilderRef,Val::LLVMValueRef,Name)
    ccall((:LLVMBuildIsNotNull,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,Cstring),arg1,Val,Name)
end

function LLVMBuildPtrDiff(arg1::LLVMBuilderRef,LHS::LLVMValueRef,RHS::LLVMValueRef,Name)
    ccall((:LLVMBuildPtrDiff,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,Cstring),arg1,LHS,RHS,Name)
end

function LLVMBuildFence(B::LLVMBuilderRef,ordering::LLVMAtomicOrdering,singleThread::LLVMBool,Name)
    ccall((:LLVMBuildFence,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMAtomicOrdering,LLVMBool,Cstring),B,ordering,singleThread,Name)
end

function LLVMBuildAtomicRMW(B::LLVMBuilderRef,op::LLVMAtomicRMWBinOp,PTR::LLVMValueRef,Val::LLVMValueRef,ordering::LLVMAtomicOrdering,singleThread::LLVMBool)
    ccall((:LLVMBuildAtomicRMW,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMAtomicRMWBinOp,LLVMValueRef,LLVMValueRef,LLVMAtomicOrdering,LLVMBool),B,op,PTR,Val,ordering,singleThread)
end

function LLVMBuildAtomicCmpXchg(B::LLVMBuilderRef,Ptr::LLVMValueRef,Cmp::LLVMValueRef,New::LLVMValueRef,SuccessOrdering::LLVMAtomicOrdering,FailureOrdering::LLVMAtomicOrdering,SingleThread::LLVMBool)
    ccall((:LLVMBuildAtomicCmpXchg,libllvm),LLVMValueRef,(LLVMBuilderRef,LLVMValueRef,LLVMValueRef,LLVMValueRef,LLVMAtomicOrdering,LLVMAtomicOrdering,LLVMBool),B,Ptr,Cmp,New,SuccessOrdering,FailureOrdering,SingleThread)
end

function LLVMIsAtomicSingleThread(AtomicInst::LLVMValueRef)
    ccall((:LLVMIsAtomicSingleThread,libllvm),LLVMBool,(LLVMValueRef,),AtomicInst)
end

function LLVMSetAtomicSingleThread(AtomicInst::LLVMValueRef,SingleThread::LLVMBool)
    ccall((:LLVMSetAtomicSingleThread,libllvm),Void,(LLVMValueRef,LLVMBool),AtomicInst,SingleThread)
end

function LLVMGetCmpXchgSuccessOrdering(CmpXchgInst::LLVMValueRef)
    ccall((:LLVMGetCmpXchgSuccessOrdering,libllvm),LLVMAtomicOrdering,(LLVMValueRef,),CmpXchgInst)
end

function LLVMSetCmpXchgSuccessOrdering(CmpXchgInst::LLVMValueRef,Ordering::LLVMAtomicOrdering)
    ccall((:LLVMSetCmpXchgSuccessOrdering,libllvm),Void,(LLVMValueRef,LLVMAtomicOrdering),CmpXchgInst,Ordering)
end

function LLVMGetCmpXchgFailureOrdering(CmpXchgInst::LLVMValueRef)
    ccall((:LLVMGetCmpXchgFailureOrdering,libllvm),LLVMAtomicOrdering,(LLVMValueRef,),CmpXchgInst)
end

function LLVMSetCmpXchgFailureOrdering(CmpXchgInst::LLVMValueRef,Ordering::LLVMAtomicOrdering)
    ccall((:LLVMSetCmpXchgFailureOrdering,libllvm),Void,(LLVMValueRef,LLVMAtomicOrdering),CmpXchgInst,Ordering)
end

function LLVMCreateModuleProviderForExistingModule(M::LLVMModuleRef)
    ccall((:LLVMCreateModuleProviderForExistingModule,libllvm),LLVMModuleProviderRef,(LLVMModuleRef,),M)
end

function LLVMDisposeModuleProvider(M::LLVMModuleProviderRef)
    ccall((:LLVMDisposeModuleProvider,libllvm),Void,(LLVMModuleProviderRef,),M)
end

function LLVMCreateMemoryBufferWithContentsOfFile(Path,OutMemBuf,OutMessage)
    ccall((:LLVMCreateMemoryBufferWithContentsOfFile,libllvm),LLVMBool,(Cstring,Ptr{LLVMMemoryBufferRef},Ptr{Cstring}),Path,OutMemBuf,OutMessage)
end

function LLVMCreateMemoryBufferWithSTDIN(OutMemBuf,OutMessage)
    ccall((:LLVMCreateMemoryBufferWithSTDIN,libllvm),LLVMBool,(Ptr{LLVMMemoryBufferRef},Ptr{Cstring}),OutMemBuf,OutMessage)
end

function LLVMCreateMemoryBufferWithMemoryRange(InputData,InputDataLength::Csize_t,BufferName,RequiresNullTerminator::LLVMBool)
    ccall((:LLVMCreateMemoryBufferWithMemoryRange,libllvm),LLVMMemoryBufferRef,(Cstring,Csize_t,Cstring,LLVMBool),InputData,InputDataLength,BufferName,RequiresNullTerminator)
end

function LLVMCreateMemoryBufferWithMemoryRangeCopy(InputData,InputDataLength::Csize_t,BufferName)
    ccall((:LLVMCreateMemoryBufferWithMemoryRangeCopy,libllvm),LLVMMemoryBufferRef,(Cstring,Csize_t,Cstring),InputData,InputDataLength,BufferName)
end

function LLVMGetBufferStart(MemBuf::LLVMMemoryBufferRef)
    ccall((:LLVMGetBufferStart,libllvm),Cstring,(LLVMMemoryBufferRef,),MemBuf)
end

function LLVMGetBufferSize(MemBuf::LLVMMemoryBufferRef)
    ccall((:LLVMGetBufferSize,libllvm),Csize_t,(LLVMMemoryBufferRef,),MemBuf)
end

function LLVMDisposeMemoryBuffer(MemBuf::LLVMMemoryBufferRef)
    ccall((:LLVMDisposeMemoryBuffer,libllvm),Void,(LLVMMemoryBufferRef,),MemBuf)
end

function LLVMGetGlobalPassRegistry()
    ccall((:LLVMGetGlobalPassRegistry,libllvm),LLVMPassRegistryRef,())
end

function LLVMCreatePassManager()
    ccall((:LLVMCreatePassManager,libllvm),LLVMPassManagerRef,())
end

function LLVMCreateFunctionPassManagerForModule(M::LLVMModuleRef)
    ccall((:LLVMCreateFunctionPassManagerForModule,libllvm),LLVMPassManagerRef,(LLVMModuleRef,),M)
end

function LLVMCreateFunctionPassManager(MP::LLVMModuleProviderRef)
    ccall((:LLVMCreateFunctionPassManager,libllvm),LLVMPassManagerRef,(LLVMModuleProviderRef,),MP)
end

function LLVMRunPassManager(PM::LLVMPassManagerRef,M::LLVMModuleRef)
    ccall((:LLVMRunPassManager,libllvm),LLVMBool,(LLVMPassManagerRef,LLVMModuleRef),PM,M)
end

function LLVMInitializeFunctionPassManager(FPM::LLVMPassManagerRef)
    ccall((:LLVMInitializeFunctionPassManager,libllvm),LLVMBool,(LLVMPassManagerRef,),FPM)
end

function LLVMRunFunctionPassManager(FPM::LLVMPassManagerRef,F::LLVMValueRef)
    ccall((:LLVMRunFunctionPassManager,libllvm),LLVMBool,(LLVMPassManagerRef,LLVMValueRef),FPM,F)
end

function LLVMFinalizeFunctionPassManager(FPM::LLVMPassManagerRef)
    ccall((:LLVMFinalizeFunctionPassManager,libllvm),LLVMBool,(LLVMPassManagerRef,),FPM)
end

function LLVMDisposePassManager(PM::LLVMPassManagerRef)
    ccall((:LLVMDisposePassManager,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMStartMultithreaded()
    ccall((:LLVMStartMultithreaded,libllvm),LLVMBool,())
end

function LLVMStopMultithreaded()
    ccall((:LLVMStopMultithreaded,libllvm),Void,())
end

function LLVMIsMultithreaded()
    ccall((:LLVMIsMultithreaded,libllvm),LLVMBool,())
end


# Julia wrapper for header: llvm-c/Disassembler.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMCreateDisasm(TripleName,DisInfo,TagType::Cint,GetOpInfo::LLVMOpInfoCallback,SymbolLookUp::LLVMSymbolLookupCallback)
    ccall((:LLVMCreateDisasm,libllvm),LLVMDisasmContextRef,(Cstring,Ptr{Void},Cint,LLVMOpInfoCallback,LLVMSymbolLookupCallback),TripleName,DisInfo,TagType,GetOpInfo,SymbolLookUp)
end

function LLVMCreateDisasmCPU(Triple,CPU,DisInfo,TagType::Cint,GetOpInfo::LLVMOpInfoCallback,SymbolLookUp::LLVMSymbolLookupCallback)
    ccall((:LLVMCreateDisasmCPU,libllvm),LLVMDisasmContextRef,(Cstring,Cstring,Ptr{Void},Cint,LLVMOpInfoCallback,LLVMSymbolLookupCallback),Triple,CPU,DisInfo,TagType,GetOpInfo,SymbolLookUp)
end

function LLVMCreateDisasmCPUFeatures(Triple,CPU,Features,DisInfo,TagType::Cint,GetOpInfo::LLVMOpInfoCallback,SymbolLookUp::LLVMSymbolLookupCallback)
    ccall((:LLVMCreateDisasmCPUFeatures,libllvm),LLVMDisasmContextRef,(Cstring,Cstring,Cstring,Ptr{Void},Cint,LLVMOpInfoCallback,LLVMSymbolLookupCallback),Triple,CPU,Features,DisInfo,TagType,GetOpInfo,SymbolLookUp)
end

function LLVMSetDisasmOptions(DC::LLVMDisasmContextRef,Options::UInt64)
    ccall((:LLVMSetDisasmOptions,libllvm),Cint,(LLVMDisasmContextRef,UInt64),DC,Options)
end

function LLVMDisasmDispose(DC::LLVMDisasmContextRef)
    ccall((:LLVMDisasmDispose,libllvm),Void,(LLVMDisasmContextRef,),DC)
end

function LLVMDisasmInstruction(DC::LLVMDisasmContextRef,Bytes,BytesSize::UInt64,PC::UInt64,OutString,OutStringSize::Csize_t)
    ccall((:LLVMDisasmInstruction,libllvm),Csize_t,(LLVMDisasmContextRef,Ptr{UInt8},UInt64,UInt64,Cstring,Csize_t),DC,Bytes,BytesSize,PC,OutString,OutStringSize)
end


# Julia wrapper for header: llvm-c/ExecutionEngine.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMLinkInMCJIT()
    ccall((:LLVMLinkInMCJIT,libllvm),Void,())
end

function LLVMLinkInInterpreter()
    ccall((:LLVMLinkInInterpreter,libllvm),Void,())
end

function LLVMCreateGenericValueOfInt(Ty::LLVMTypeRef,N::Culonglong,IsSigned::LLVMBool)
    ccall((:LLVMCreateGenericValueOfInt,libllvm),LLVMGenericValueRef,(LLVMTypeRef,Culonglong,LLVMBool),Ty,N,IsSigned)
end

function LLVMCreateGenericValueOfPointer(P)
    ccall((:LLVMCreateGenericValueOfPointer,libllvm),LLVMGenericValueRef,(Ptr{Void},),P)
end

function LLVMCreateGenericValueOfFloat(Ty::LLVMTypeRef,N::Cdouble)
    ccall((:LLVMCreateGenericValueOfFloat,libllvm),LLVMGenericValueRef,(LLVMTypeRef,Cdouble),Ty,N)
end

function LLVMGenericValueIntWidth(GenValRef::LLVMGenericValueRef)
    ccall((:LLVMGenericValueIntWidth,libllvm),UInt32,(LLVMGenericValueRef,),GenValRef)
end

function LLVMGenericValueToInt(GenVal::LLVMGenericValueRef,IsSigned::LLVMBool)
    ccall((:LLVMGenericValueToInt,libllvm),Culonglong,(LLVMGenericValueRef,LLVMBool),GenVal,IsSigned)
end

function LLVMGenericValueToPointer(GenVal::LLVMGenericValueRef)
    ccall((:LLVMGenericValueToPointer,libllvm),Ptr{Void},(LLVMGenericValueRef,),GenVal)
end

function LLVMGenericValueToFloat(TyRef::LLVMTypeRef,GenVal::LLVMGenericValueRef)
    ccall((:LLVMGenericValueToFloat,libllvm),Cdouble,(LLVMTypeRef,LLVMGenericValueRef),TyRef,GenVal)
end

function LLVMDisposeGenericValue(GenVal::LLVMGenericValueRef)
    ccall((:LLVMDisposeGenericValue,libllvm),Void,(LLVMGenericValueRef,),GenVal)
end

function LLVMCreateExecutionEngineForModule(OutEE,M::LLVMModuleRef,OutError)
    ccall((:LLVMCreateExecutionEngineForModule,libllvm),LLVMBool,(Ptr{LLVMExecutionEngineRef},LLVMModuleRef,Ptr{Cstring}),OutEE,M,OutError)
end

function LLVMCreateInterpreterForModule(OutInterp,M::LLVMModuleRef,OutError)
    ccall((:LLVMCreateInterpreterForModule,libllvm),LLVMBool,(Ptr{LLVMExecutionEngineRef},LLVMModuleRef,Ptr{Cstring}),OutInterp,M,OutError)
end

function LLVMCreateJITCompilerForModule(OutJIT,M::LLVMModuleRef,OptLevel::UInt32,OutError)
    ccall((:LLVMCreateJITCompilerForModule,libllvm),LLVMBool,(Ptr{LLVMExecutionEngineRef},LLVMModuleRef,UInt32,Ptr{Cstring}),OutJIT,M,OptLevel,OutError)
end

function LLVMInitializeMCJITCompilerOptions(Options,SizeOfOptions::Csize_t)
    ccall((:LLVMInitializeMCJITCompilerOptions,libllvm),Void,(Ptr{LLVMMCJITCompilerOptions},Csize_t),Options,SizeOfOptions)
end

function LLVMCreateMCJITCompilerForModule(OutJIT,M::LLVMModuleRef,Options,SizeOfOptions::Csize_t,OutError)
    ccall((:LLVMCreateMCJITCompilerForModule,libllvm),LLVMBool,(Ptr{LLVMExecutionEngineRef},LLVMModuleRef,Ptr{LLVMMCJITCompilerOptions},Csize_t,Ptr{Cstring}),OutJIT,M,Options,SizeOfOptions,OutError)
end

function LLVMDisposeExecutionEngine(EE::LLVMExecutionEngineRef)
    ccall((:LLVMDisposeExecutionEngine,libllvm),Void,(LLVMExecutionEngineRef,),EE)
end

function LLVMRunStaticConstructors(EE::LLVMExecutionEngineRef)
    ccall((:LLVMRunStaticConstructors,libllvm),Void,(LLVMExecutionEngineRef,),EE)
end

function LLVMRunStaticDestructors(EE::LLVMExecutionEngineRef)
    ccall((:LLVMRunStaticDestructors,libllvm),Void,(LLVMExecutionEngineRef,),EE)
end

function LLVMRunFunctionAsMain(EE::LLVMExecutionEngineRef,F::LLVMValueRef,ArgC::UInt32,ArgV,EnvP)
    ccall((:LLVMRunFunctionAsMain,libllvm),Cint,(LLVMExecutionEngineRef,LLVMValueRef,UInt32,Ptr{Cstring},Ptr{Cstring}),EE,F,ArgC,ArgV,EnvP)
end

function LLVMRunFunction(EE::LLVMExecutionEngineRef,F::LLVMValueRef,NumArgs::UInt32,Args)
    ccall((:LLVMRunFunction,libllvm),LLVMGenericValueRef,(LLVMExecutionEngineRef,LLVMValueRef,UInt32,Ptr{LLVMGenericValueRef}),EE,F,NumArgs,Args)
end

function LLVMFreeMachineCodeForFunction(EE::LLVMExecutionEngineRef,F::LLVMValueRef)
    ccall((:LLVMFreeMachineCodeForFunction,libllvm),Void,(LLVMExecutionEngineRef,LLVMValueRef),EE,F)
end

function LLVMAddModule(EE::LLVMExecutionEngineRef,M::LLVMModuleRef)
    ccall((:LLVMAddModule,libllvm),Void,(LLVMExecutionEngineRef,LLVMModuleRef),EE,M)
end

function LLVMRemoveModule(EE::LLVMExecutionEngineRef,M::LLVMModuleRef,OutMod,OutError)
    ccall((:LLVMRemoveModule,libllvm),LLVMBool,(LLVMExecutionEngineRef,LLVMModuleRef,Ptr{LLVMModuleRef},Ptr{Cstring}),EE,M,OutMod,OutError)
end

function LLVMFindFunction(EE::LLVMExecutionEngineRef,Name,OutFn)
    ccall((:LLVMFindFunction,libllvm),LLVMBool,(LLVMExecutionEngineRef,Cstring,Ptr{LLVMValueRef}),EE,Name,OutFn)
end

function LLVMRecompileAndRelinkFunction(EE::LLVMExecutionEngineRef,Fn::LLVMValueRef)
    ccall((:LLVMRecompileAndRelinkFunction,libllvm),Ptr{Void},(LLVMExecutionEngineRef,LLVMValueRef),EE,Fn)
end

function LLVMGetExecutionEngineTargetData(EE::LLVMExecutionEngineRef)
    ccall((:LLVMGetExecutionEngineTargetData,libllvm),LLVMTargetDataRef,(LLVMExecutionEngineRef,),EE)
end

function LLVMGetExecutionEngineTargetMachine(EE::LLVMExecutionEngineRef)
    ccall((:LLVMGetExecutionEngineTargetMachine,libllvm),LLVMTargetMachineRef,(LLVMExecutionEngineRef,),EE)
end

function LLVMAddGlobalMapping(EE::LLVMExecutionEngineRef,Global::LLVMValueRef,Addr)
    ccall((:LLVMAddGlobalMapping,libllvm),Void,(LLVMExecutionEngineRef,LLVMValueRef,Ptr{Void}),EE,Global,Addr)
end

function LLVMGetPointerToGlobal(EE::LLVMExecutionEngineRef,Global::LLVMValueRef)
    ccall((:LLVMGetPointerToGlobal,libllvm),Ptr{Void},(LLVMExecutionEngineRef,LLVMValueRef),EE,Global)
end

function LLVMGetGlobalValueAddress(EE::LLVMExecutionEngineRef,Name)
    ccall((:LLVMGetGlobalValueAddress,libllvm),UInt64,(LLVMExecutionEngineRef,Cstring),EE,Name)
end

function LLVMGetFunctionAddress(EE::LLVMExecutionEngineRef,Name)
    ccall((:LLVMGetFunctionAddress,libllvm),UInt64,(LLVMExecutionEngineRef,Cstring),EE,Name)
end

function LLVMCreateSimpleMCJITMemoryManager(Opaque,AllocateCodeSection::LLVMMemoryManagerAllocateCodeSectionCallback,AllocateDataSection::LLVMMemoryManagerAllocateDataSectionCallback,FinalizeMemory::LLVMMemoryManagerFinalizeMemoryCallback,Destroy::LLVMMemoryManagerDestroyCallback)
    ccall((:LLVMCreateSimpleMCJITMemoryManager,libllvm),LLVMMCJITMemoryManagerRef,(Ptr{Void},LLVMMemoryManagerAllocateCodeSectionCallback,LLVMMemoryManagerAllocateDataSectionCallback,LLVMMemoryManagerFinalizeMemoryCallback,LLVMMemoryManagerDestroyCallback),Opaque,AllocateCodeSection,AllocateDataSection,FinalizeMemory,Destroy)
end

function LLVMDisposeMCJITMemoryManager(MM::LLVMMCJITMemoryManagerRef)
    ccall((:LLVMDisposeMCJITMemoryManager,libllvm),Void,(LLVMMCJITMemoryManagerRef,),MM)
end


# Julia wrapper for header: llvm-c/Initialization.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMInitializeTransformUtils(R::LLVMPassRegistryRef)
    ccall((:LLVMInitializeTransformUtils,libllvm),Void,(LLVMPassRegistryRef,),R)
end

function LLVMInitializeScalarOpts(R::LLVMPassRegistryRef)
    ccall((:LLVMInitializeScalarOpts,libllvm),Void,(LLVMPassRegistryRef,),R)
end

function LLVMInitializeObjCARCOpts(R::LLVMPassRegistryRef)
    ccall((:LLVMInitializeObjCARCOpts,libllvm),Void,(LLVMPassRegistryRef,),R)
end

function LLVMInitializeVectorization(R::LLVMPassRegistryRef)
    ccall((:LLVMInitializeVectorization,libllvm),Void,(LLVMPassRegistryRef,),R)
end

function LLVMInitializeInstCombine(R::LLVMPassRegistryRef)
    ccall((:LLVMInitializeInstCombine,libllvm),Void,(LLVMPassRegistryRef,),R)
end

function LLVMInitializeIPO(R::LLVMPassRegistryRef)
    ccall((:LLVMInitializeIPO,libllvm),Void,(LLVMPassRegistryRef,),R)
end

function LLVMInitializeInstrumentation(R::LLVMPassRegistryRef)
    ccall((:LLVMInitializeInstrumentation,libllvm),Void,(LLVMPassRegistryRef,),R)
end

function LLVMInitializeAnalysis(R::LLVMPassRegistryRef)
    ccall((:LLVMInitializeAnalysis,libllvm),Void,(LLVMPassRegistryRef,),R)
end

function LLVMInitializeIPA(R::LLVMPassRegistryRef)
    ccall((:LLVMInitializeIPA,libllvm),Void,(LLVMPassRegistryRef,),R)
end

function LLVMInitializeCodeGen(R::LLVMPassRegistryRef)
    ccall((:LLVMInitializeCodeGen,libllvm),Void,(LLVMPassRegistryRef,),R)
end

function LLVMInitializeTarget(R::LLVMPassRegistryRef)
    ccall((:LLVMInitializeTarget,libllvm),Void,(LLVMPassRegistryRef,),R)
end


# Julia wrapper for header: llvm-c/IRReader.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMParseIRInContext(ContextRef::LLVMContextRef,MemBuf::LLVMMemoryBufferRef,OutM,OutMessage)
    ccall((:LLVMParseIRInContext,libllvm),LLVMBool,(LLVMContextRef,LLVMMemoryBufferRef,Ptr{LLVMModuleRef},Ptr{Cstring}),ContextRef,MemBuf,OutM,OutMessage)
end


# Julia wrapper for header: llvm-c/Linker.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMLinkModules2(Dest::LLVMModuleRef,Src::LLVMModuleRef)
    ccall((:LLVMLinkModules2,libllvm),LLVMBool,(LLVMModuleRef,LLVMModuleRef),Dest,Src)
end


# Julia wrapper for header: llvm-c/LinkTimeOptimizer.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function llvm_create_optimizer()
    ccall((:llvm_create_optimizer,libllvm),llvm_lto_t,())
end

function llvm_destroy_optimizer(lto::llvm_lto_t)
    ccall((:llvm_destroy_optimizer,libllvm),Void,(llvm_lto_t,),lto)
end

function llvm_read_object_file(lto::llvm_lto_t,input_filename)
    ccall((:llvm_read_object_file,libllvm),llvm_lto_status_t,(llvm_lto_t,Cstring),lto,input_filename)
end

function llvm_optimize_modules(lto::llvm_lto_t,output_filename)
    ccall((:llvm_optimize_modules,libllvm),llvm_lto_status_t,(llvm_lto_t,Cstring),lto,output_filename)
end


# Julia wrapper for header: llvm-c/lto.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function lto_get_version()
    ccall((:lto_get_version,libllvm),Cstring,())
end

function lto_get_error_message()
    ccall((:lto_get_error_message,libllvm),Cstring,())
end

function lto_module_is_object_file(path)
    ccall((:lto_module_is_object_file,libllvm),lto_bool_t,(Cstring,),path)
end

function lto_module_is_object_file_for_target(path,target_triple_prefix)
    ccall((:lto_module_is_object_file_for_target,libllvm),lto_bool_t,(Cstring,Cstring),path,target_triple_prefix)
end

function lto_module_has_objc_category(mem,length::Csize_t)
    ccall((:lto_module_has_objc_category,libllvm),lto_bool_t,(Ptr{Void},Csize_t),mem,length)
end

function lto_module_is_object_file_in_memory(mem,length::Csize_t)
    ccall((:lto_module_is_object_file_in_memory,libllvm),lto_bool_t,(Ptr{Void},Csize_t),mem,length)
end

function lto_module_is_object_file_in_memory_for_target(mem,length::Csize_t,target_triple_prefix)
    ccall((:lto_module_is_object_file_in_memory_for_target,libllvm),lto_bool_t,(Ptr{Void},Csize_t,Cstring),mem,length,target_triple_prefix)
end

function lto_module_create(path)
    ccall((:lto_module_create,libllvm),lto_module_t,(Cstring,),path)
end

function lto_module_create_from_memory(mem,length::Csize_t)
    ccall((:lto_module_create_from_memory,libllvm),lto_module_t,(Ptr{Void},Csize_t),mem,length)
end

function lto_module_create_from_memory_with_path(mem,length::Csize_t,path)
    ccall((:lto_module_create_from_memory_with_path,libllvm),lto_module_t,(Ptr{Void},Csize_t,Cstring),mem,length,path)
end

function lto_module_create_in_local_context(mem,length::Csize_t,path)
    ccall((:lto_module_create_in_local_context,libllvm),lto_module_t,(Ptr{Void},Csize_t,Cstring),mem,length,path)
end

function lto_module_create_in_codegen_context(mem,length::Csize_t,path,cg::lto_code_gen_t)
    ccall((:lto_module_create_in_codegen_context,libllvm),lto_module_t,(Ptr{Void},Csize_t,Cstring,lto_code_gen_t),mem,length,path,cg)
end

function lto_module_create_from_fd(fd::Cint,path,file_size::Csize_t)
    ccall((:lto_module_create_from_fd,libllvm),lto_module_t,(Cint,Cstring,Csize_t),fd,path,file_size)
end

function lto_module_create_from_fd_at_offset(fd::Cint,path,file_size::Csize_t,map_size::Csize_t,offset::Csize_t)
    ccall((:lto_module_create_from_fd_at_offset,libllvm),lto_module_t,(Cint,Cstring,Csize_t,Csize_t,Csize_t),fd,path,file_size,map_size,offset)
end

function lto_module_dispose(mod::lto_module_t)
    ccall((:lto_module_dispose,libllvm),Void,(lto_module_t,),mod)
end

function lto_module_get_target_triple(mod::lto_module_t)
    ccall((:lto_module_get_target_triple,libllvm),Cstring,(lto_module_t,),mod)
end

function lto_module_set_target_triple(mod::lto_module_t,triple)
    ccall((:lto_module_set_target_triple,libllvm),Void,(lto_module_t,Cstring),mod,triple)
end

function lto_module_get_num_symbols(mod::lto_module_t)
    ccall((:lto_module_get_num_symbols,libllvm),UInt32,(lto_module_t,),mod)
end

function lto_module_get_symbol_name(mod::lto_module_t,index::UInt32)
    ccall((:lto_module_get_symbol_name,libllvm),Cstring,(lto_module_t,UInt32),mod,index)
end

function lto_module_get_symbol_attribute(mod::lto_module_t,index::UInt32)
    ccall((:lto_module_get_symbol_attribute,libllvm),lto_symbol_attributes,(lto_module_t,UInt32),mod,index)
end

function lto_module_get_linkeropts(mod::lto_module_t)
    ccall((:lto_module_get_linkeropts,libllvm),Cstring,(lto_module_t,),mod)
end

function lto_codegen_set_diagnostic_handler(arg1::lto_code_gen_t,arg2::lto_diagnostic_handler_t,arg3)
    ccall((:lto_codegen_set_diagnostic_handler,libllvm),Void,(lto_code_gen_t,lto_diagnostic_handler_t,Ptr{Void}),arg1,arg2,arg3)
end

function lto_codegen_create()
    ccall((:lto_codegen_create,libllvm),lto_code_gen_t,())
end

function lto_codegen_create_in_local_context()
    ccall((:lto_codegen_create_in_local_context,libllvm),lto_code_gen_t,())
end

function lto_codegen_dispose(arg1::lto_code_gen_t)
    ccall((:lto_codegen_dispose,libllvm),Void,(lto_code_gen_t,),arg1)
end

function lto_codegen_add_module(cg::lto_code_gen_t,mod::lto_module_t)
    ccall((:lto_codegen_add_module,libllvm),lto_bool_t,(lto_code_gen_t,lto_module_t),cg,mod)
end

function lto_codegen_set_module(cg::lto_code_gen_t,mod::lto_module_t)
    ccall((:lto_codegen_set_module,libllvm),Void,(lto_code_gen_t,lto_module_t),cg,mod)
end

function lto_codegen_set_debug_model(cg::lto_code_gen_t,arg1::lto_debug_model)
    ccall((:lto_codegen_set_debug_model,libllvm),lto_bool_t,(lto_code_gen_t,lto_debug_model),cg,arg1)
end

function lto_codegen_set_pic_model(cg::lto_code_gen_t,arg1::lto_codegen_model)
    ccall((:lto_codegen_set_pic_model,libllvm),lto_bool_t,(lto_code_gen_t,lto_codegen_model),cg,arg1)
end

function lto_codegen_set_cpu(cg::lto_code_gen_t,cpu)
    ccall((:lto_codegen_set_cpu,libllvm),Void,(lto_code_gen_t,Cstring),cg,cpu)
end

function lto_codegen_set_assembler_path(cg::lto_code_gen_t,path)
    ccall((:lto_codegen_set_assembler_path,libllvm),Void,(lto_code_gen_t,Cstring),cg,path)
end

function lto_codegen_set_assembler_args(cg::lto_code_gen_t,args,nargs::Cint)
    ccall((:lto_codegen_set_assembler_args,libllvm),Void,(lto_code_gen_t,Ptr{Cstring},Cint),cg,args,nargs)
end

function lto_codegen_add_must_preserve_symbol(cg::lto_code_gen_t,symbol)
    ccall((:lto_codegen_add_must_preserve_symbol,libllvm),Void,(lto_code_gen_t,Cstring),cg,symbol)
end

function lto_codegen_write_merged_modules(cg::lto_code_gen_t,path)
    ccall((:lto_codegen_write_merged_modules,libllvm),lto_bool_t,(lto_code_gen_t,Cstring),cg,path)
end

function lto_codegen_compile(cg::lto_code_gen_t,length)
    ccall((:lto_codegen_compile,libllvm),Ptr{Void},(lto_code_gen_t,Ptr{Csize_t}),cg,length)
end

function lto_codegen_compile_to_file(cg::lto_code_gen_t,name)
    ccall((:lto_codegen_compile_to_file,libllvm),lto_bool_t,(lto_code_gen_t,Ptr{Cstring}),cg,name)
end

function lto_codegen_optimize(cg::lto_code_gen_t)
    ccall((:lto_codegen_optimize,libllvm),lto_bool_t,(lto_code_gen_t,),cg)
end

function lto_codegen_compile_optimized(cg::lto_code_gen_t,length)
    ccall((:lto_codegen_compile_optimized,libllvm),Ptr{Void},(lto_code_gen_t,Ptr{Csize_t}),cg,length)
end

function lto_api_version()
    ccall((:lto_api_version,libllvm),UInt32,())
end

function lto_codegen_debug_options(cg::lto_code_gen_t,arg1)
    ccall((:lto_codegen_debug_options,libllvm),Void,(lto_code_gen_t,Cstring),cg,arg1)
end

function lto_initialize_disassembler()
    ccall((:lto_initialize_disassembler,libllvm),Void,())
end

function lto_codegen_set_should_internalize(cg::lto_code_gen_t,ShouldInternalize::lto_bool_t)
    ccall((:lto_codegen_set_should_internalize,libllvm),Void,(lto_code_gen_t,lto_bool_t),cg,ShouldInternalize)
end

function lto_codegen_set_should_embed_uselists(cg::lto_code_gen_t,ShouldEmbedUselists::lto_bool_t)
    ccall((:lto_codegen_set_should_embed_uselists,libllvm),Void,(lto_code_gen_t,lto_bool_t),cg,ShouldEmbedUselists)
end

function thinlto_create_codegen()
    ccall((:thinlto_create_codegen,libllvm),thinlto_code_gen_t,())
end

function thinlto_codegen_dispose(cg::thinlto_code_gen_t)
    ccall((:thinlto_codegen_dispose,libllvm),Void,(thinlto_code_gen_t,),cg)
end

function thinlto_codegen_add_module(cg::thinlto_code_gen_t,identifier,data,length::Cint)
    ccall((:thinlto_codegen_add_module,libllvm),Void,(thinlto_code_gen_t,Cstring,Cstring,Cint),cg,identifier,data,length)
end

function thinlto_codegen_process(cg::thinlto_code_gen_t)
    ccall((:thinlto_codegen_process,libllvm),Void,(thinlto_code_gen_t,),cg)
end

function thinlto_module_get_num_objects(cg::thinlto_code_gen_t)
    ccall((:thinlto_module_get_num_objects,libllvm),UInt32,(thinlto_code_gen_t,),cg)
end

function thinlto_module_get_object(cg::thinlto_code_gen_t,index::UInt32)
    ccall((:thinlto_module_get_object,libllvm),LTOObjectBuffer,(thinlto_code_gen_t,UInt32),cg,index)
end

function thinlto_codegen_set_pic_model(cg::thinlto_code_gen_t,arg1::lto_codegen_model)
    ccall((:thinlto_codegen_set_pic_model,libllvm),lto_bool_t,(thinlto_code_gen_t,lto_codegen_model),cg,arg1)
end

function thinlto_codegen_set_cache_dir(cg::thinlto_code_gen_t,cache_dir)
    ccall((:thinlto_codegen_set_cache_dir,libllvm),Void,(thinlto_code_gen_t,Cstring),cg,cache_dir)
end

function thinlto_codegen_set_cache_pruning_interval(cg::thinlto_code_gen_t,interval::Cint)
    ccall((:thinlto_codegen_set_cache_pruning_interval,libllvm),Void,(thinlto_code_gen_t,Cint),cg,interval)
end

function thinlto_codegen_set_final_cache_size_relative_to_available_space(cg::thinlto_code_gen_t,percentage::UInt32)
    ccall((:thinlto_codegen_set_final_cache_size_relative_to_available_space,libllvm),Void,(thinlto_code_gen_t,UInt32),cg,percentage)
end

function thinlto_codegen_set_cache_entry_expiration(cg::thinlto_code_gen_t,expiration::UInt32)
    ccall((:thinlto_codegen_set_cache_entry_expiration,libllvm),Void,(thinlto_code_gen_t,UInt32),cg,expiration)
end

function thinlto_codegen_set_savetemps_dir(cg::thinlto_code_gen_t,save_temps_dir)
    ccall((:thinlto_codegen_set_savetemps_dir,libllvm),Void,(thinlto_code_gen_t,Cstring),cg,save_temps_dir)
end

function thinlto_codegen_set_cpu(cg::thinlto_code_gen_t,cpu)
    ccall((:thinlto_codegen_set_cpu,libllvm),Void,(thinlto_code_gen_t,Cstring),cg,cpu)
end

function thinlto_codegen_disable_codegen(cg::thinlto_code_gen_t,disable::lto_bool_t)
    ccall((:thinlto_codegen_disable_codegen,libllvm),Void,(thinlto_code_gen_t,lto_bool_t),cg,disable)
end

function thinlto_codegen_set_codegen_only(cg::thinlto_code_gen_t,codegen_only::lto_bool_t)
    ccall((:thinlto_codegen_set_codegen_only,libllvm),Void,(thinlto_code_gen_t,lto_bool_t),cg,codegen_only)
end

function thinlto_debug_options(options,number::Cint)
    ccall((:thinlto_debug_options,libllvm),Void,(Ptr{Cstring},Cint),options,number)
end

function lto_module_is_thinlto(mod::lto_module_t)
    ccall((:lto_module_is_thinlto,libllvm),lto_bool_t,(lto_module_t,),mod)
end

function thinlto_codegen_add_must_preserve_symbol(cg::thinlto_code_gen_t,name,length::Cint)
    ccall((:thinlto_codegen_add_must_preserve_symbol,libllvm),Void,(thinlto_code_gen_t,Cstring,Cint),cg,name,length)
end

function thinlto_codegen_add_cross_referenced_symbol(cg::thinlto_code_gen_t,name,length::Cint)
    ccall((:thinlto_codegen_add_cross_referenced_symbol,libllvm),Void,(thinlto_code_gen_t,Cstring,Cint),cg,name,length)
end


# Julia wrapper for header: llvm-c/OrcBindings.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMOrcCreateInstance(TM::LLVMTargetMachineRef)
    ccall((:LLVMOrcCreateInstance,libllvm),LLVMOrcJITStackRef,(LLVMTargetMachineRef,),TM)
end

function LLVMOrcGetErrorMsg(JITStack::LLVMOrcJITStackRef)
    ccall((:LLVMOrcGetErrorMsg,libllvm),Cstring,(LLVMOrcJITStackRef,),JITStack)
end

function LLVMOrcGetMangledSymbol(JITStack::LLVMOrcJITStackRef,MangledSymbol,Symbol)
    ccall((:LLVMOrcGetMangledSymbol,libllvm),Void,(LLVMOrcJITStackRef,Ptr{Cstring},Cstring),JITStack,MangledSymbol,Symbol)
end

function LLVMOrcDisposeMangledSymbol(MangledSymbol)
    ccall((:LLVMOrcDisposeMangledSymbol,libllvm),Void,(Cstring,),MangledSymbol)
end

function LLVMOrcCreateLazyCompileCallback(JITStack::LLVMOrcJITStackRef,Callback::LLVMOrcLazyCompileCallbackFn,CallbackCtx)
    ccall((:LLVMOrcCreateLazyCompileCallback,libllvm),LLVMOrcTargetAddress,(LLVMOrcJITStackRef,LLVMOrcLazyCompileCallbackFn,Ptr{Void}),JITStack,Callback,CallbackCtx)
end

function LLVMOrcCreateIndirectStub(JITStack::LLVMOrcJITStackRef,StubName,InitAddr::LLVMOrcTargetAddress)
    ccall((:LLVMOrcCreateIndirectStub,libllvm),LLVMOrcErrorCode,(LLVMOrcJITStackRef,Cstring,LLVMOrcTargetAddress),JITStack,StubName,InitAddr)
end

function LLVMOrcSetIndirectStubPointer(JITStack::LLVMOrcJITStackRef,StubName,NewAddr::LLVMOrcTargetAddress)
    ccall((:LLVMOrcSetIndirectStubPointer,libllvm),LLVMOrcErrorCode,(LLVMOrcJITStackRef,Cstring,LLVMOrcTargetAddress),JITStack,StubName,NewAddr)
end

function LLVMOrcAddEagerlyCompiledIR(JITStack::LLVMOrcJITStackRef,Mod::LLVMModuleRef,SymbolResolver::LLVMOrcSymbolResolverFn,SymbolResolverCtx)
    ccall((:LLVMOrcAddEagerlyCompiledIR,libllvm),LLVMOrcModuleHandle,(LLVMOrcJITStackRef,LLVMModuleRef,LLVMOrcSymbolResolverFn,Ptr{Void}),JITStack,Mod,SymbolResolver,SymbolResolverCtx)
end

function LLVMOrcAddLazilyCompiledIR(JITStack::LLVMOrcJITStackRef,Mod::LLVMModuleRef,SymbolResolver::LLVMOrcSymbolResolverFn,SymbolResolverCtx)
    ccall((:LLVMOrcAddLazilyCompiledIR,libllvm),LLVMOrcModuleHandle,(LLVMOrcJITStackRef,LLVMModuleRef,LLVMOrcSymbolResolverFn,Ptr{Void}),JITStack,Mod,SymbolResolver,SymbolResolverCtx)
end

function LLVMOrcAddObjectFile(JITStack::LLVMOrcJITStackRef,Obj::LLVMObjectFileRef,SymbolResolver::LLVMOrcSymbolResolverFn,SymbolResolverCtx)
    ccall((:LLVMOrcAddObjectFile,libllvm),LLVMOrcModuleHandle,(LLVMOrcJITStackRef,LLVMObjectFileRef,LLVMOrcSymbolResolverFn,Ptr{Void}),JITStack,Obj,SymbolResolver,SymbolResolverCtx)
end

function LLVMOrcRemoveModule(JITStack::LLVMOrcJITStackRef,H::LLVMOrcModuleHandle)
    ccall((:LLVMOrcRemoveModule,libllvm),Void,(LLVMOrcJITStackRef,LLVMOrcModuleHandle),JITStack,H)
end

function LLVMOrcGetSymbolAddress(JITStack::LLVMOrcJITStackRef,SymbolName)
    ccall((:LLVMOrcGetSymbolAddress,libllvm),LLVMOrcTargetAddress,(LLVMOrcJITStackRef,Cstring),JITStack,SymbolName)
end

function LLVMOrcDisposeInstance(JITStack::LLVMOrcJITStackRef)
    ccall((:LLVMOrcDisposeInstance,libllvm),Void,(LLVMOrcJITStackRef,),JITStack)
end


# Julia wrapper for header: llvm-c/Support.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMLoadLibraryPermanently(Filename)
    ccall((:LLVMLoadLibraryPermanently,libllvm),LLVMBool,(Cstring,),Filename)
end

function LLVMParseCommandLineOptions(argc::Cint,argv,Overview)
    ccall((:LLVMParseCommandLineOptions,libllvm),Void,(Cint,Ptr{Cstring},Cstring),argc,argv,Overview)
end

function LLVMSearchForAddressOfSymbol(symbolName)
    ccall((:LLVMSearchForAddressOfSymbol,libllvm),Ptr{Void},(Cstring,),symbolName)
end

function LLVMAddSymbol(symbolName,symbolValue)
    ccall((:LLVMAddSymbol,libllvm),Void,(Cstring,Ptr{Void}),symbolName,symbolValue)
end


# Julia wrapper for header: llvm-c/Transforms/IPO.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMAddArgumentPromotionPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddArgumentPromotionPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddConstantMergePass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddConstantMergePass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddDeadArgEliminationPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddDeadArgEliminationPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddFunctionAttrsPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddFunctionAttrsPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddFunctionInliningPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddFunctionInliningPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddAlwaysInlinerPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddAlwaysInlinerPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddGlobalDCEPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddGlobalDCEPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddGlobalOptimizerPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddGlobalOptimizerPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddIPConstantPropagationPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddIPConstantPropagationPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddPruneEHPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddPruneEHPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddIPSCCPPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddIPSCCPPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddInternalizePass(arg1::LLVMPassManagerRef,AllButMain::UInt32)
    ccall((:LLVMAddInternalizePass,libllvm),Void,(LLVMPassManagerRef,UInt32),arg1,AllButMain)
end

function LLVMAddStripDeadPrototypesPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddStripDeadPrototypesPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddStripSymbolsPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddStripSymbolsPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end


# Julia wrapper for header: llvm-c/Transforms/PassManagerBuilder.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMPassManagerBuilderCreate()
    ccall((:LLVMPassManagerBuilderCreate,libllvm),LLVMPassManagerBuilderRef,())
end

function LLVMPassManagerBuilderDispose(PMB::LLVMPassManagerBuilderRef)
    ccall((:LLVMPassManagerBuilderDispose,libllvm),Void,(LLVMPassManagerBuilderRef,),PMB)
end

function LLVMPassManagerBuilderSetOptLevel(PMB::LLVMPassManagerBuilderRef,OptLevel::UInt32)
    ccall((:LLVMPassManagerBuilderSetOptLevel,libllvm),Void,(LLVMPassManagerBuilderRef,UInt32),PMB,OptLevel)
end

function LLVMPassManagerBuilderSetSizeLevel(PMB::LLVMPassManagerBuilderRef,SizeLevel::UInt32)
    ccall((:LLVMPassManagerBuilderSetSizeLevel,libllvm),Void,(LLVMPassManagerBuilderRef,UInt32),PMB,SizeLevel)
end

function LLVMPassManagerBuilderSetDisableUnitAtATime(PMB::LLVMPassManagerBuilderRef,Value::LLVMBool)
    ccall((:LLVMPassManagerBuilderSetDisableUnitAtATime,libllvm),Void,(LLVMPassManagerBuilderRef,LLVMBool),PMB,Value)
end

function LLVMPassManagerBuilderSetDisableUnrollLoops(PMB::LLVMPassManagerBuilderRef,Value::LLVMBool)
    ccall((:LLVMPassManagerBuilderSetDisableUnrollLoops,libllvm),Void,(LLVMPassManagerBuilderRef,LLVMBool),PMB,Value)
end

function LLVMPassManagerBuilderSetDisableSimplifyLibCalls(PMB::LLVMPassManagerBuilderRef,Value::LLVMBool)
    ccall((:LLVMPassManagerBuilderSetDisableSimplifyLibCalls,libllvm),Void,(LLVMPassManagerBuilderRef,LLVMBool),PMB,Value)
end

function LLVMPassManagerBuilderUseInlinerWithThreshold(PMB::LLVMPassManagerBuilderRef,Threshold::UInt32)
    ccall((:LLVMPassManagerBuilderUseInlinerWithThreshold,libllvm),Void,(LLVMPassManagerBuilderRef,UInt32),PMB,Threshold)
end

function LLVMPassManagerBuilderPopulateFunctionPassManager(PMB::LLVMPassManagerBuilderRef,PM::LLVMPassManagerRef)
    ccall((:LLVMPassManagerBuilderPopulateFunctionPassManager,libllvm),Void,(LLVMPassManagerBuilderRef,LLVMPassManagerRef),PMB,PM)
end

function LLVMPassManagerBuilderPopulateModulePassManager(PMB::LLVMPassManagerBuilderRef,PM::LLVMPassManagerRef)
    ccall((:LLVMPassManagerBuilderPopulateModulePassManager,libllvm),Void,(LLVMPassManagerBuilderRef,LLVMPassManagerRef),PMB,PM)
end

function LLVMPassManagerBuilderPopulateLTOPassManager(PMB::LLVMPassManagerBuilderRef,PM::LLVMPassManagerRef,Internalize::LLVMBool,RunInliner::LLVMBool)
    ccall((:LLVMPassManagerBuilderPopulateLTOPassManager,libllvm),Void,(LLVMPassManagerBuilderRef,LLVMPassManagerRef,LLVMBool,LLVMBool),PMB,PM,Internalize,RunInliner)
end


# Julia wrapper for header: llvm-c/Transforms/Scalar.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMAddAggressiveDCEPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddAggressiveDCEPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddBitTrackingDCEPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddBitTrackingDCEPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddAlignmentFromAssumptionsPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddAlignmentFromAssumptionsPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddCFGSimplificationPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddCFGSimplificationPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddDeadStoreEliminationPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddDeadStoreEliminationPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddScalarizerPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddScalarizerPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddMergedLoadStoreMotionPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddMergedLoadStoreMotionPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddGVNPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddGVNPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddIndVarSimplifyPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddIndVarSimplifyPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddInstructionCombiningPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddInstructionCombiningPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddJumpThreadingPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddJumpThreadingPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddLICMPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddLICMPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddLoopDeletionPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddLoopDeletionPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddLoopIdiomPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddLoopIdiomPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddLoopRotatePass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddLoopRotatePass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddLoopRerollPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddLoopRerollPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddLoopUnrollPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddLoopUnrollPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddLoopUnswitchPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddLoopUnswitchPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddMemCpyOptPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddMemCpyOptPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddPartiallyInlineLibCallsPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddPartiallyInlineLibCallsPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddLowerSwitchPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddLowerSwitchPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddPromoteMemoryToRegisterPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddPromoteMemoryToRegisterPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddReassociatePass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddReassociatePass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddSCCPPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddSCCPPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddScalarReplAggregatesPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddScalarReplAggregatesPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddScalarReplAggregatesPassSSA(PM::LLVMPassManagerRef)
    ccall((:LLVMAddScalarReplAggregatesPassSSA,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddScalarReplAggregatesPassWithThreshold(PM::LLVMPassManagerRef,Threshold::Cint)
    ccall((:LLVMAddScalarReplAggregatesPassWithThreshold,libllvm),Void,(LLVMPassManagerRef,Cint),PM,Threshold)
end

function LLVMAddSimplifyLibCallsPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddSimplifyLibCallsPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddTailCallEliminationPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddTailCallEliminationPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddConstantPropagationPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddConstantPropagationPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddDemoteMemoryToRegisterPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddDemoteMemoryToRegisterPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddVerifierPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddVerifierPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddCorrelatedValuePropagationPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddCorrelatedValuePropagationPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddEarlyCSEPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddEarlyCSEPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddLowerExpectIntrinsicPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddLowerExpectIntrinsicPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddTypeBasedAliasAnalysisPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddTypeBasedAliasAnalysisPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddScopedNoAliasAAPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddScopedNoAliasAAPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddBasicAliasAnalysisPass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddBasicAliasAnalysisPass,libllvm),Void,(LLVMPassManagerRef,),PM)
end


# Julia wrapper for header: llvm-c/Transforms/Vectorize.h
# Automatically generated using Clang.jl wrap_c, version 0.1.0

function LLVMAddBBVectorizePass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddBBVectorizePass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddLoopVectorizePass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddLoopVectorizePass,libllvm),Void,(LLVMPassManagerRef,),PM)
end

function LLVMAddSLPVectorizePass(PM::LLVMPassManagerRef)
    ccall((:LLVMAddSLPVectorizePass,libllvm),Void,(LLVMPassManagerRef,),PM)
end
