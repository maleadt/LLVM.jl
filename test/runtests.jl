using LLVM
using Base.Test

# types
let
    @test LLVM.BoolFromLLVM(LLVM.True) == true
    @test LLVM.BoolFromLLVM(LLVM.False) == false

    @test_throws ArgumentError LLVM.BoolFromLLVM(LLVM.API.LLVMBool(2))

    @test LLVM.BoolToLLVM(true) == LLVM.True
    @test LLVM.BoolToLLVM(false) == LLVM.False
end


# pass registry
passreg = GlobalPassRegistry()

# initialization
version()
ismultithreaded()
InitializeCore(passreg)
InitializeTransformUtils(passreg)
InitializeScalarOpts(passreg)
InitializeObjCARCOpts(passreg)
InitializeVectorization(passreg)
InitializeInstCombine(passreg)
InitializeIPO(passreg)
InitializeInstrumentation(passreg)
InitializeAnalysis(passreg)
InitializeIPA(passreg)
InitializeCodeGen(passreg)
InitializeTarget(passreg)

InitializeNativeTarget()
InitializeAllTargetInfos()
InitializeAllTargetMCs()
InitializeNativeAsmPrinter()

include("core.jl")
include("linker.jl")
include("irbuilder.jl")
include("buffer.jl")
include("bitcode.jl")
include("ir.jl")
include("analysis.jl")
include("moduleprovider.jl")
include("passmanager.jl")
include("execution.jl")
include("transform.jl")
include("target.jl")
include("targetmachine.jl")
include("datalayout.jl")

LLVM.API.exclusive && Shutdown()
