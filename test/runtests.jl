using LLVM
using Base.Test

# types
let
    @test LLVM.BoolFromLLVM(LLVMTrue) == true
    @test LLVM.BoolFromLLVM(LLVMFalse) == false

    @test_throws ArgumentError LLVM.BoolFromLLVM(LLVM.API.LLVMBool(2))

    @test LLVM.BoolToLLVM(true) == LLVMTrue
    @test LLVM.BoolToLLVM(false) == LLVMFalse
end


# pass registry
passreg = GlobalPassRegistry()

# initialization
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

include("core.jl")
include("linker.jl")
include("irbuilder.jl")
include("buffer.jl")
include("bitcode.jl")
include("ir.jl")

include("analysis.jl")

include("moduleprovider.jl")
include("passmanager.jl")

InitializeNativeTarget()
InitializeAllTargetInfos()
InitializeAllTargetMCs()
InitializeNativeAsmPrinter()
include("execution.jl")

include("transform.jl")
include("target.jl")
include("targetmachine.jl")
include("datalayout.jl")

if LLVM.exclusive[]
    Shutdown()
end
