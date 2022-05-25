export JITEventListener, GDBRegistrationListener, IntelJITEventListener,
       OProfileJITEventListener, PerfJITEventListener

@checked struct JITEventListener
    ref::API.LLVMJITEventListenerRef
end
Base.unsafe_convert(::Type{API.LLVMJITEventListenerRef}, listener::JITEventListener) = listener.ref

GDBRegistrationListener()  = JITEventListener(API.LLVMCreateGDBRegistrationListener())
IntelJITEventListener()    = JITEventListener(API.LLVMCreateIntelJITEventListener())
OProfileJITEventListener() = JITEventListener(API.LLVMCreateOProfileJITEventListener())
PerfJITEventListener()     = JITEventListener(API.LLVMCreatePerfJITEventListener())
