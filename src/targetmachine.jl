## target machine

export TargetMachine,
       target, triple, cpu, features, asm_verbosity!,
       emit, add_transform_info!, add_library_info!
export JITTargetMachine

@checked mutable struct TargetMachine
    ref::API.LLVMTargetMachineRef
end

Base.unsafe_convert(::Type{API.LLVMTargetMachineRef}, tm::TargetMachine) = tm.ref

function TargetMachine(t::Target, triple::String, cpu::String="", features::String="";
                       optlevel::API.LLVMCodeGenOptLevel=API.LLVMCodeGenLevelDefault,
                       reloc::API.LLVMRelocMode=API.LLVMRelocDefault,
                       code::API.LLVMCodeModel=API.LLVMCodeModelDefault)
    tm = TargetMachine(API.LLVMCreateTargetMachine(t, triple, cpu, features, optlevel,
                                                   reloc, code))
    finalizer(unsafe_dispose!, tm)
end

unsafe_dispose!(tm::TargetMachine) = API.LLVMDisposeTargetMachine(tm)

target(tm::TargetMachine) = Target(API.LLVMGetTargetMachineTarget(tm))
triple(tm::TargetMachine) = unsafe_message(API.LLVMGetTargetMachineTriple(tm))
triple() = unsafe_message(API.LLVMGetDefaultTargetTriple())
normalize(triple) = unsafe_message(API.LLVMNormalizeTargetTriple(triple))
cpu(tm::TargetMachine) = unsafe_message(API.LLVMGetTargetMachineCPU(tm))
features(tm::TargetMachine) = unsafe_message(API.LLVMGetTargetMachineFeatureString(tm))

asm_verbosity!(tm::TargetMachine, verbose::Core.Bool) =
    API.LLVMSetTargetMachineAsmVerbosity(tm, convert(Bool, verbose))

function emit(tm::TargetMachine, mod::Module, filetype::API.LLVMCodeGenFileType)
    out_error = Ref{Cstring}()
    out_membuf = Ref{API.LLVMMemoryBufferRef}()
    status = convert(Core.Bool,
        API.LLVMTargetMachineEmitToMemoryBuffer(tm, mod, filetype,
                                                out_error, out_membuf))

    if status
        error = unsafe_message(out_error[])
        throw(LLVMException(error))
    end

    return convert(Vector{UInt8}, MemoryBuffer(out_membuf[]))
end

function emit(tm::TargetMachine, mod::Module, filetype::API.LLVMCodeGenFileType, path::String)
    out_error = Ref{Cstring}()
    status = convert(Core.Bool,
        API.LLVMTargetMachineEmitToFile(tm, mod, path, filetype, out_error))

    if status
        error = unsafe_message(out_error[])
        throw(LLVMException(error))
    end

    return nothing
end

function add_transform_info!(pm::PassManager, tm::Union{Nothing,TargetMachine}=nothing)
    if tm !== nothing
        API.LLVMAddAnalysisPasses(tm, pm)
    else
        API.LLVMExtraAddGenericAnalysisPasses(pm)
    end
end
add_library_info!(pm::PassManager, triple::String) =
    API.LLVMAddTargetLibraryInfoByTriple(triple, pm)

function JITTargetMachine(triple = LLVM.triple(),
                          cpu = "", features = "";
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

    tm = TargetMachine(target, triple, cpu, features;
                       optlevel,
                       reloc = LLVM.API.LLVMRelocStatic, # Generate simpler code for JIT
                       code = LLVM.API.LLVMCodeModelJITDefault, # Required to init TM as JIT
                       )
    return tm
end
