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

InitializeCore(R::PassRegistry) = API.LLVMInitializeCore(ref(PassRegistry, R))
InitializeTransformUtils(R::PassRegistry) = API.LLVMInitializeTransformUtils(ref(PassRegistry, R))
InitializeScalarOpts(R::PassRegistry) = API.LLVMInitializeScalarOpts(ref(PassRegistry, R))
InitializeObjCARCOpts(R::PassRegistry) = API.LLVMInitializeObjCARCOpts(ref(PassRegistry, R))
InitializeVectorization(R::PassRegistry) = API.LLVMInitializeVectorization(ref(PassRegistry, R))
InitializeInstCombine(R::PassRegistry) = API.LLVMInitializeInstCombine(ref(PassRegistry, R))
InitializeIPO(R::PassRegistry) = API.LLVMInitializeIPO(ref(PassRegistry, R))
InitializeInstrumentation(R::PassRegistry) = API.LLVMInitializeInstrumentation(ref(PassRegistry, R))
InitializeAnalysis(R::PassRegistry) = API.LLVMInitializeAnalysis(ref(PassRegistry, R))
InitializeIPA(R::PassRegistry) = API.LLVMInitializeIPA(ref(PassRegistry, R))
InitializeCodeGen(R::PassRegistry) = API.LLVMInitializeCodeGen(ref(PassRegistry, R))
InitializeTarget(R::PassRegistry) = API.LLVMInitializeTarget(ref(PassRegistry, R))

Shutdown() = API.LLVMShutdown()
