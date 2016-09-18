## target machine

export TargetMachine, dispose,
       target, triple, cpu, features, asm_verbosity!,
       emit, populate!

@reftypedef ref=LLVMTargetMachineRef immutable TargetMachine end

TargetMachine(t::Target, triple::String, cpu::String, features::String,
              optlevel::API.LLVMCodeGenOptLevel, reloc::API.LLVMRelocMode,
              code::API.LLVMCodeModel) =
    TargetMachine(API.LLVMCreateTargetMachine(ref(t), triple, cpu, features, optlevel,
                                              reloc, code))

dispose(tm::TargetMachine) = API.LLVMDisposeTargetMachine(ref(tm))

function TargetMachine(f::Core.Function, args...)
    tm = TargetMachine(args...)
    try
        f(tm)
    finally
        dispose(tm)
    end
end

target(tm::TargetMachine) = Target(API.LLVMGetTargetMachineTarget(ref(tm)))
triple(tm::TargetMachine) = unsafe_string(API.LLVMGetTargetMachineTriple(ref(tm)))
triple() = unsafe_string(API.LLVMGetDefaultTargetTriple())
cpu(tm::TargetMachine) = unsafe_string(API.LLVMGetTargetMachineCPU(ref(tm)))
features(tm::TargetMachine) = unsafe_string(API.LLVMGetTargetMachineFeatureString(ref(tm)))

asm_verbosity!(tm::TargetMachine, verbose::Bool) =
    API.LLVMSetTargetMachineAsmVerbosity(ref(tm), BoolToLLVM(verbose))

function emit(tm::TargetMachine, mod::Module, filetype::API.LLVMCodeGenFileType)
    out_error = Ref{Cstring}()
    out_membuf = Ref{API.LLVMMemoryBufferRef}()
    status = BoolFromLLVM(
        API.LLVMTargetMachineEmitToMemoryBuffer(ref(tm), ref(mod), filetype,
                                                out_error, out_membuf))

    if status
        error = unsafe_string(out_error[])
        API.LLVMDisposeMessage(out_error[])
        throw(LLVMException(error))
    end

    return convert(Vector{UInt8}, MemoryBuffer(out_membuf[]))
end

function emit(tm::TargetMachine, mod::Module, filetype::API.LLVMCodeGenFileType, path::String)
    out_error = Ref{Cstring}()
    status = BoolFromLLVM(
        API.LLVMTargetMachineEmitToFile(ref(tm), ref(mod), path, filetype, out_error))

    if status
        error = unsafe_string(out_error[])
        API.LLVMDisposeMessage(out_error[])
        throw(LLVMException(error))
    end

    return nothing
end

populate!(pm::PassManager, tm::TargetMachine) = API.LLVMAddAnalysisPasses(ref(tm), ref(pm))
