# HACK: work around Pkg.jl#2500
test_project = Base.active_project()
preferences_file = joinpath(dirname(@__DIR__), "LocalPreferences.toml")
test_preferences_file = joinpath(dirname(test_project), "LocalPreferences.toml")
if isfile(preferences_file) && !isfile(test_preferences_file)
    cp(preferences_file, test_preferences_file)
end

using LLVM
using LLVMExtra_jll
using Test

@info "Using libLLVMExtra from $(LLVM.API.libLLVMExtra)"

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

include("support.jl")
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
include("debuginfo.jl")
if LLVM.has_orc_v1()
    include("orc.jl")
end

include("Kaleidoscope.jl")

include("examples.jl")

include("interop.jl")

end
