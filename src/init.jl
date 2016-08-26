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
       Shutdown

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

Shutdown() = API.LLVMShutdown()
