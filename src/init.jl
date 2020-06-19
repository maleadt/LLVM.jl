## subsystem initialization

export Shutdown, ismultithreaded

ismultithreaded() = convert(Core.Bool, API.LLVMIsMultithreaded())

for subsystem in [:Core, :TransformUtils, :ScalarOpts, :ObjCARCOpts, :Vectorization,
                  :InstCombine, :IPO, :Instrumentation, :Analysis, :IPA, :CodeGen, :Target]
    jl_fname = Symbol(:Initialize, subsystem)
    api_fname = Symbol(:LLVM, jl_fname)
    @eval begin
        export $jl_fname
        $jl_fname(R::PassRegistry) = API.$api_fname(ref(R))
    end
end


## target initialization

# figure out the supported targets by looking at initialization routines
# TODO: figure out the name of the native target
let
    lib = Libdl.dlopen(libllvm)
    known_targets = [:AArch64, :AMDGPU, :ARC, :ARM, :AVR, :BPF, :Hexagon, :Lanai, :MSP430,
                     :Mips, :NVPTX, :PowerPC, :RISCV, :Sparc, :SystemZ, :WebAssembly, :X86,
                     :XCore]
    global const libllvm_targets = filter(known_targets) do target
        sym = Libdl.dlsym_e(lib, Symbol("LLVMInitialize$(target)Target"))
        sym !== nothing
    end
end

for component in [:TargetInfo, :Target, :TargetMC, :AsmPrinter, :AsmParser, :Disassembler]
    jl_fname = Symbol(:Initialize, :All, component, :s)
    api_fname = Symbol(:LLVM, jl_fname)
    @eval begin
        export $jl_fname
        $jl_fname() = API.$api_fname()
    end
end

for component in [:Target, :AsmPrinter, :AsmParser, :Disassembler]
    jl_fname = Symbol(:Initialize, :Native, component)
    api_fname = Symbol(:LLVM, jl_fname)
    @eval begin
        export $jl_fname
        $jl_fname() = convert(Core.Bool, API.$api_fname()) &&
                      throw(LLVMException($"Could not initialize native $component"))
    end
end

for target in libllvm_targets,
    component in [:Target, :AsmPrinter, :AsmParser, :Disassembler, :TargetInfo, :TargetMC]
    jl_fname = Symbol(:Initialize, target, component)
    api_fname = Symbol(:LLVM, jl_fname)

    @eval begin
        export $jl_fname
        $jl_fname() = API.@apicall($(QuoteNode(api_fname)), Cvoid, ())
    end
end
