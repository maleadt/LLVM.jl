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

ismultithreaded()

InitializeCore(passreg)
include("core.jl")
include("linker.jl")
include("irbuilder.jl")
include("buffer.jl")
include("bitcode.jl")
include("ir.jl")

InitializeAnalysis(passreg)
include("analysis.jl")

include("moduleprovider.jl")
include("passmanager.jl")

# TODO: host
InitializeX86Target()
InitializeX86TargetInfo()
InitializeX86TargetMC()
InitializeX86AsmPrinter()
include("execution.jl")

InitializeTransformUtils(passreg)
include("transform.jl")

InitializeScalarOpts(passreg)

InitializeObjCARCOpts(passreg)

InitializeVectorization(passreg)

InitializeInstCombine(passreg)

InitializeIPO(passreg)

InitializeInstrumentation(passreg)

InitializeIPA(passreg)

InitializeCodeGen(passreg)

InitializeTarget(passreg)
include("target.jl")
include("targetmachine.jl")
include("datalayout.jl")


Shutdown()
