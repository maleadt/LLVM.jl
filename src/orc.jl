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
Base.unsafe_convert(::Type{Ptr{Cvoid}}, orc::OrcJIT) = Base.unsafe_convert(Ptr{Cvoid}, orc.ref)

OrcJIT(ref::Ptr{Cvoid}) = OrcJIT(Base.unsafe_convert(API.LLVMOrcJITStackRef, ref))

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

function OrcJIT(f::Core.Function, tm::TargetMachine)
    orc = OrcJIT(tm)
    try
        f(orc)
    finally
        dispose(orc)
    end
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

"""
   resolver(name, ctx)

Lookup the symbol `name`. Iff `ctx` is passed to this function it should be a
pointer to the OrcJIT we are compiling for.
"""
function resolver(name, ctx)
    name = unsafe_string(name)
    ## Step 0: Should have already resolved it iff it was in the
    ##         same module
    ## Step 1: See if it's something known to the execution engine
    ptr = C_NULL
    if ctx != C_NULL
        orc = OrcJIT(ctx)
        ptr = pointer(address(orc, name))
    end

    ## Step 2: Search the program symbols
    if ptr == C_NULL
        #
        # SearchForAddressOfSymbol expects an unmangled 'C' symbol name.
        # Iff we are on Darwin, strip the leading '_' off.
        @static if Sys.isapple()
            if name[1] == '_'
                name = name[2:end]
            end
        end
        ptr = LLVM.find_symbol(name)
    end

    ## Step 4: Lookup in libatomic
    # TODO: Do we need to do this?

    if ptr == C_NULL
        error("OrcJIT: Symbol `$name` lookup failed. Aborting!")
    end

    return UInt64(reinterpret(UInt, ptr))
end

function compile!(orc::OrcJIT, mod::Module, resolver = @cfunction(resolver, UInt64, (Cstring, Ptr{Cvoid})), resolver_ctx = orc; lazy=false)
    r_mod = Ref{API.LLVMOrcModuleHandle}()
    if lazy
        API.LLVMOrcAddLazilyCompiledIR(orc, r_mod, mod, resolver, resolver_ctx)
    else
        API.LLVMOrcAddEagerlyCompiledIR(orc, r_mod, mod, resolver, resolver_ctx)
    end
    OrcModule(r_mod[])
end

function Base.delete!(orc::OrcJIT, mod::OrcModule)
    LLVM.API.LLVMOrcRemoveModule(orc, mod)
end

function add!(orc::OrcJIT, obj::MemoryBuffer, resolver = @cfunction(resolver, UInt64, (Cstring, Ptr{Cvoid})), resolver_ctx = orc)
    r_mod = Ref{API.LLVMOrcModuleHandle}()
    API.LLVMOrcAddObjectFile(orc, r_mod, obj, resolver, resolver_ctx)
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
    API.LLVMOrcCreateLazyCompileCallback(orc, r_address, callback, ctx)
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
