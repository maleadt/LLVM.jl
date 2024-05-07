## subsystem initialization

export ismultithreaded

ismultithreaded() = API.LLVMIsMultithreaded() |> Bool

if LLVM.version() < v"17"
    const subsystems = [:Core, :TransformUtils, :ScalarOpts, :Vectorization, :InstCombine,
                        :IPO, :Analysis, :IPA, :CodeGen, :Target]
    if LLVM.version() < v"16"
        append!(subsystems, [:ObjCARCOpts, :Instrumentation])
    end
    for subsystem in subsystems
        jl_fname = Symbol(:Initialize, subsystem)
        api_fname = Symbol(:LLVM, jl_fname)
        @eval begin
            export $jl_fname
            $jl_fname(R::PassRegistry) = API.$api_fname(R)
        end
    end
end


## back-end initialization

export backends

const libllvm_backends = [:AArch64, :AMDGPU, :ARC, :ARM, :AVR, :BPF, :Hexagon, :Lanai,
                          :MSP430, :Mips, :NVPTX, :PowerPC, :RISCV, :Sparc, :SystemZ,
                          :VE, :WebAssembly, :X86, :XCore,
                          # Unofficial backends
                          :Colossus,
]
const libllvm_components = [:Target, :TargetInfo, :TargetMC, :AsmPrinter, :AsmParser, :Disassembler]

# discover supported back-ends and their components by looking at available symbols.
# this reimplements LLVM macros and `static inline` functions that are hard to call.
Libdl.dlopen(libllvm) do library
    supported_backends = filter(libllvm_backends) do backend
        initializer = "LLVMInitialize$(backend)Target"
        Libdl.dlsym(library, initializer; throw_error=false) !== nothing
    end
    @eval backends() = $supported_backends

    # generate subsystem initialization routines for every back-end
    supported_components = Dict(component => [] for component in libllvm_components)
    for backend in libllvm_backends
        backend_supported = backend in supported_backends

        for component in libllvm_components
            jl_fname = Symbol(:Initialize, backend, component)
            @eval export $jl_fname

            api_fname = Symbol(:LLVM, jl_fname)
            if backend_supported
                component_supported = Libdl.dlsym(library, api_fname; throw_error=false) !== nothing
                if component_supported
                    push!(supported_components[component], backend)
                    @eval $jl_fname() = ccall(($(QuoteNode(api_fname)),libllvm), Cvoid, ())
                else
                    @eval $jl_fname() = error($"The $backend back-end does not contain a $component component.")
                end
            else
                @eval $jl_fname() = error($"The $backend back-end is not part of your LLVM library.")
            end
        end
    end

    # same, for initializing subsystems for all back-ends at once
    for component in keys(supported_components)
        jl_fname = Symbol(:Initialize, :All, component, :s)
        exprs = Expr[]
        for backend in supported_components[component]
            fname = Symbol(:Initialize, backend, component)
            push!(exprs, :($fname()))
        end

        @eval begin
            export $jl_fname
            function $jl_fname()
                $(exprs...)
                return
            end
        end
    end
end

# same, for the native back-end
for component in [:Target, :AsmPrinter, :AsmParser, :Disassembler]
    jl_fname = Symbol(:Initialize, :Native, component)
    api_fname = Symbol(:LLVMExtra, jl_fname)
    @eval begin
        export $jl_fname
        $jl_fname() = Bool(API.$api_fname()) &&
                      throw(LLVMException($"Could not initialize native $component"))
    end
end
