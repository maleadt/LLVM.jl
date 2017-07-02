using LLVM
using Base.Test

using Compat

@testset "LLVM" begin

include("util.jl")

@testset "types" begin
    @test LLVM.BoolFromLLVM(LLVM.True) == true
    @test LLVM.BoolFromLLVM(LLVM.False) == false

    @test_throws ArgumentError LLVM.BoolFromLLVM(LLVM.API.LLVMBool(2))

    @test LLVM.BoolToLLVM(true) == LLVM.True
    @test LLVM.BoolToLLVM(false) == LLVM.False
end

if LLVM.configured
    @testset "pass registry" begin
        passreg = GlobalPassRegistry()

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
    end

    include("core.jl")
    include("linker.jl")
    include("irbuilder.jl")
    include("buffer.jl")
    include("bitcode.jl")
    include("ir.jl")
    include("analysis.jl")
    include("moduleprovider.jl")
    include("passmanager.jl")
    include("pass.jl")
    include("execution.jl")
    include("transform.jl")
    include("target.jl")
    include("targetmachine.jl")
    include("datalayout.jl")

    include("examples.jl")
    include("documentation.jl")

    LLVM.libllvm_system && Shutdown()
else
    warn("LLVM.jl has not been configured; skipping most tests.")
end

end
