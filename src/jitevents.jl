export JITEventListener, GDBRegistrationListener, IntelJITEventListener,
       OProfileJITEventListener, PerfJITEventListener

@checked struct JITEventListener
    ref::API.LLVMJITEventListenerRef
end
Base.unsafe_convert(::Type{API.LLVMJITEventListenerRef}, listener::JITEventListener) = listener.ref

GDBRegistrationListener()  = JITEventListener(LLVM.API.LLVMCreateGDBRegistrationListener())
IntelJITEventListener()    = JITEventListener(LLVM.API.LLVMCreateIntelJITEventListener())
OProfileJITEventListener() = JITEventListener(LLVM.API.LLVMCreateOProfileJITEventListener())
PerfJITEventListener()     = JITEventListener(LLVM.API.LLVMCreatePerfJITEventListener())
