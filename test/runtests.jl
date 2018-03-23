using LLVM

using Test
import Pkg

@testset "LLVM" begin

include("util.jl")

@testset "types" begin
    @test convert(Bool, LLVM.True) == true
    @test convert(Bool, LLVM.False) == false

    @test_throws ArgumentError LLVM.convert(Bool, LLVM.API.LLVMBool(2))

    @test convert(LLVM.Bool, true) == LLVM.True
    @test convert(LLVM.Bool, false) == LLVM.False
end

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

include("Kaleidoscope.jl")

include("examples.jl")
if "Documenter" in keys(Pkg.installed())
    include("documentation.jl")
else
    @warn "Documenter.jl not installed, skipping documentation tests."
end

include("interop.jl")

end
