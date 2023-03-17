# Work around JuliaLang/Pkg.jl#2500
if VERSION < v"1.8-"
    test_project = first(Base.load_path())
    preferences_file = "LocalPreferences.toml"
    test_preferences_file = joinpath(dirname(test_project), "LocalPreferences.toml")
    if isfile(preferences_file) && !isfile(test_preferences_file)
        cp(preferences_file, test_preferences_file)
    end
end

using LLVM
using Test

if Base.JLOptions().debug_level < 2
    @warn "It is recommended to run the LLVM.jl test suite with -g2"
end

@testset "LLVM" begin

# HACK: if a test throws within a Context() do block, displaying the LLVM value may crash
#       because the context has been disposed already. avoid that by disabling `dispose`
LLVM.dispose(::Context) = return

include("helpers.jl")

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
include("instructions.jl")
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
include("utils.jl")
if LLVM.has_orc_v1()
    include("orc.jl")
end
if LLVM.has_orc_v2() &&
   !(LLVM.version() < v"13" && LLVM.is_asserts()) # FIXME(@vchuravy)
    include("orcv2.jl")
end


include("Kaleidoscope.jl")

include("examples.jl")

include("interop.jl")
include("atomics.jl")

end
