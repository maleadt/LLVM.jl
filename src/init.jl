export InitializeCore,
       InitializeTransformUtils,
       InitializeScalarOpts,
       InitializeObjCARCOpts,
       InitializeVectorization,
       InitializeInstCombine,
       InitializeIPO,
       InitializeInstrumentation,
       InitializeAnalysis,
       InitializeIPA,
       InitializeCodeGen,
       InitializeTarget,
       Shutdown,
       ismultithreaded

InitializeCore(R::PassRegistry) = API.LLVMInitializeCore(ref(R))
InitializeTransformUtils(R::PassRegistry) = API.LLVMInitializeTransformUtils(ref(R))
InitializeScalarOpts(R::PassRegistry) = API.LLVMInitializeScalarOpts(ref(R))
InitializeObjCARCOpts(R::PassRegistry) = API.LLVMInitializeObjCARCOpts(ref(R))
InitializeVectorization(R::PassRegistry) = API.LLVMInitializeVectorization(ref(R))
InitializeInstCombine(R::PassRegistry) = API.LLVMInitializeInstCombine(ref(R))
InitializeIPO(R::PassRegistry) = API.LLVMInitializeIPO(ref(R))
InitializeInstrumentation(R::PassRegistry) = API.LLVMInitializeInstrumentation(ref(R))
InitializeAnalysis(R::PassRegistry) = API.LLVMInitializeAnalysis(ref(R))
InitializeIPA(R::PassRegistry) = API.LLVMInitializeIPA(ref(R))
InitializeCodeGen(R::PassRegistry) = API.LLVMInitializeCodeGen(ref(R))
InitializeTarget(R::PassRegistry) = API.LLVMInitializeTarget(ref(R))

# TODO: detect this (without relying on llvm-config)
for target in [:X86, :NVPTX],
    component in [:TargetInfo, :Target, :TargetMC, :AsmPrinter, :AsmParser, :Disassembler]
       jl_fname = Symbol(:Initialize, target, component)
       api_fname = Symbol(:LLVM, jl_fname)
       @eval begin
              export $jl_fname
              $jl_fname() = API.$api_fname()
       end
end

Shutdown() = API.LLVMShutdown()

ismultithreaded() = BoolFromLLVM(API.LLVMIsMultithreaded())
