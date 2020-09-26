export OrcJIT, OrcModule, OrcTargetAddress
export JITEventListener, GDBRegistrationListener, IntelJITEventListener,
       OProfileJITEventListener, PerfJITEventListener
export dispose, errormsg, compile!, remove!, add!,
       mangle, address, addressin, create_stub!, set_stub!,
       register!, unregister!, callback!
export JITTargetMachine

@checked struct OrcJIT 
    ref::API.LLVMOrcJITStackRef
end

Base.unsafe_convert(::Type{API.LLVMOrcJITStackRef}, orc::OrcJIT) = orc.ref

"""
    OrcJIT(::TargetMachine)

Creates a OrcJIT stack based on the provided target machine.

!!! warning
    Takes ownership of the provided target machine.
"""
function OrcJIT(tm::TargetMachine)
    OrcJIT(API.LLVMOrcCreateInstance(tm))
end

function dispose(orc::OrcJIT)
    API.LLVMOrcDisposeInstance(orc)
end

function errormsg(orc::OrcJIT)
    # The error message is owned by `orc`, and will
    # be disposed along-side the OrcJIT. 
    unsafe_string(LLVM.API.LLVMOrcGetErrorMsg(orc))
end

struct OrcModule 
    handle::API.LLVMOrcModuleHandle
end
Base.convert(::Type{API.LLVMOrcModuleHandle}, mod::OrcModule) = mod.handle

function compile!(orc::OrcJIT, mod::Module, resolver = C_NULL, ctx = C_NULL; lazy=false)
    r_mod = Ref{API.LLVMOrcModuleHandle}()
    if lazy
        API.LLVMOrcAddLazilyCompiledIR(orc, r_mod, mod, resolver, ctx)
    else
        API.LLVMOrcAddEagerlyCompiledIR(orc, r_mod, mod, resolver, ctx)
    end
    OrcModule(r_mod[])
end

function Base.delete!(orc::OrcJIT, mod::OrcModule)
    LLVM.API.LLVMOrcRemoveModule(orc, mod)
end

function add!(orc::OrcJIT, obj::MemoryBuffer, resolver = C_NULL, ctx = C_NULL)
    r_mod = Ref{API.LLVMOrcModuleHandle}()
    API.LLVMOrcAddObjectFile(orc, r_mod, obj, resolver, ctx)
    return OrcModule(r_mod[])
end

function mangle(orc::OrcJIT, name)
    r_symbol = Ref{Cstring}()
    LLVM.API.LLVMOrcGetMangledSymbol(orc, r_symbol, name)
    symbol = unsafe_string(r_symbol[])
    LLVM.API.LLVMOrcDisposeMangledSymbol(r_symbol[])
    return symbol
end

struct OrcTargetAddress
    ptr::API.LLVMOrcTargetAddress
end
Base.convert(::Type{API.LLVMOrcTargetAddress}, addr::OrcTargetAddress) = addr.ptr

Base.pointer(addr::OrcTargetAddress) = reinterpret(Ptr{Cvoid}, addr.ptr % UInt) # LLVMOrcTargetAddress is UInt64 even on 32-bit

OrcTargetAddress(ptr::Ptr{Cvoid}) = OrcTargetAddress(reinterpret(UInt, ptr))

function create_stub!(orc::OrcJIT, name, initial)
    LLVM.API.LLVMOrcCreateIndirectStub(orc, name, initial)
end

function set_stub!(orc::OrcJIT, name, new)
    LLVM.API.LLVMOrcSetIndirectStubPointer(orc, name, new)
end

function address(orc::OrcJIT, name)
    r_address = Ref{API.LLVMOrcTargetAddress}()
    API.LLVMOrcGetSymbolAddress(orc, r_address, name)
    OrcTargetAddress(r_address[])
end

function addressin(orc::OrcJIT, mod::OrcModule, name)
    r_address = Ref{API.LLVMOrcTargetAddress}()
    API.LLVMOrcGetSymbolAddressIn(orc, r_address, mod, name)
    OrcTargetAddress(r_address[])
end

function callback!(orc::OrcJIT, callback, ctx)
    r_address = Ref{API.LLVMOrcTargetAddress}()
    LLVM.API.LLVMOrcLazyCompileCallback(orc, r_address, callback, ctx)
    return OrcTargetAddress(r_address[])
end

@checked struct JITEventListener 
    ref::API.LLVMJITEventListenerRef
end
Base.unsafe_convert(::Type{API.LLVMJITEventListenerRef}, listener::JITEventListener) = listener.ref

function register!(orc::OrcJIT, listener::JITEventListener)
    LLVM.API.LLVMOrcRegisterJITEventListener(orc, listener)
end

function unregister!(orc::OrcJIT, listener::JITEventListener)
    LLVM.API.LLVMOrcUnregisterJITEventListener(orc, listener)
end

GDBRegistrationListener()  = JITEventListener(LLVM.API.LLVMCreateGDBRegistrationListener())
IntelJITEventListener()    = JITEventListener(LLVM.API.LLVMCreateIntelJITEventListener())
OProfileJITEventListener() = JITEventListener(LLVM.API.LLVMCreateOProfileJITEventListener())
PerfJITEventListener()     = JITEventListener(LLVM.API.LLVMCreatePerfJITEventListener())

function JITTargetMachine(;triple = LLVM.triple(),
                           cpu = "", features = "",
                           optlevel = LLVM.API.LLVMCodeGenLevelDefault)

    # Force ELF on windows,
    # Note: Without this call to normalize Orc get's confused
    #       and chooses the x86_64 SysV ABI on Win x64
    triple = LLVM.normalize(triple)
    if Sys.iswindows()
        triple *= "-elf"
    end
    target = LLVM.Target(triple=triple)
    @debug "Configuring OrcJIT with" triple cpu features optlevel

    tm = TargetMachine(target, triple, cpu, features,
                       optlevel,
                       LLVM.API.LLVMRelocStatic, # Generate simpler code for JIT
                       LLVM.API.LLVMCodeModelJITDefault, # Required to init TM as JIT
                       )
    return tm 
end
