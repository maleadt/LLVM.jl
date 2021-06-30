## subsystem initialization

export Shutdown, ismultithreaded

ismultithreaded() = convert(Core.Bool, API.LLVMIsMultithreaded())

for subsystem in [:Core, :TransformUtils, :ScalarOpts, :ObjCARCOpts, :Vectorization,
                  :InstCombine, :IPO, :Instrumentation, :Analysis, :IPA, :CodeGen, :Target]
    jl_fname = Symbol(:Initialize, subsystem)
    api_fname = Symbol(:LLVM, jl_fname)
    @eval begin
        export $jl_fname
        $jl_fname(R::PassRegistry) = API.$api_fname(R)
    end
end


## back-end initialization

export backends

const libllvm_backends = [:AArch64, :AMDGPU, :ARC, :ARM, :AVR, :BPF, :Hexagon, :Lanai,
                          :MSP430, :Mips, :NVPTX, :PowerPC, :RISCV, :Sparc, :SystemZ,
                          :WebAssembly, :X86, :XCore]

function backends()
    filter(libllvm_backends) do backend
        library = Libdl.dlopen(libllvm[])
        initializer = "LLVMInitialize$(backend)Target"
        Libdl.dlsym_e(library, initializer) !== C_NULL
    end
end

# generate subsystem initialization routines for every back-end
for backend in libllvm_backends,
    component in [:Target, :AsmPrinter, :AsmParser, :Disassembler, :TargetInfo, :TargetMC]

    initializer = "LLVMInitialize$(backend)Target"
    supported = :(Libdl.dlsym_e(Libdl.dlopen(libllvm[]), $initializer) !== C_NULL)

    jl_fname = Symbol(:Initialize, backend, component)
    api_fname = Symbol(:LLVM, jl_fname)
    @eval begin
        export $jl_fname
        $jl_fname() =
            $supported ? ccall(($(QuoteNode(api_fname)),libllvm[]), Cvoid, ()) :
                         error($"The $backend back-end is not part of your LLVM library.")

    end
end

# same, for initializing subsystems for all back-ends at once
for component in [:TargetInfo, :Target, :TargetMC, :AsmPrinter, :AsmParser, :Disassembler]
    jl_fname = Symbol(:Initialize, :All, component, :s)
    api_fname = Symbol(:LLVM, jl_fname)
    @eval begin
        export $jl_fname
        $jl_fname() = API.$api_fname()
    end
end

# same, for the native back-end
for component in [:Target, :AsmPrinter, :AsmParser, :Disassembler]
    jl_fname = Symbol(:Initialize, :Native, component)
    api_fname = Symbol(:LLVM, jl_fname)
    @eval begin
        export $jl_fname
        $jl_fname() = convert(Core.Bool, API.$api_fname()) &&
                      throw(LLVMException($"Could not initialize native $component"))
    end
end
