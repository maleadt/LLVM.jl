using LLVM
using Base.Test

# support
let
    @test LLVM.BoolFromLLVM(LLVMTrue) == true
    @test LLVM.BoolFromLLVM(LLVMFalse) == false

    @test_throws ArgumentError LLVM.BoolFromLLVM(LLVM.API.LLVMBool(2))

    @test LLVM.BoolToLLVM(true) == LLVMTrue
    @test LLVM.BoolToLLVM(false) == LLVMFalse
end


# pass registry
passreg = GlobalPassRegistry()

InitializeCore(passreg)
include("core.jl")
include("irbuilder.jl")

InitializeAnalysis(passreg)
include("analysis.jl")

include("moduleprovider.jl")
include("passmanager.jl")

InitializeX86Target()
InitializeX86TargetInfo()
InitializeX86TargetMC()
InitializeX86AsmPrinter()
include("execution.jl")

InitializeTransformUtils(passreg)

InitializeScalarOpts(passreg)

InitializeObjCARCOpts(passreg)

InitializeVectorization(passreg)

InitializeInstCombine(passreg)

InitializeIPO(passreg)

InitializeInstrumentation(passreg)

InitializeIPA(passreg)

InitializeCodeGen(passreg)

InitializeTarget(passreg)


Shutdown()
