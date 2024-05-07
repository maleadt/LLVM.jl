@testitem "essentials" begin

if LLVM.version() < v"17"
@testset "pass registry" begin
    passreg = GlobalPassRegistry()

    @test version() isa VersionNumber
    @test ismultithreaded() isa Bool

    InitializeCore(passreg)
    InitializeTransformUtils(passreg)
    InitializeScalarOpts(passreg)
    if LLVM.version() < v"16"
        InitializeObjCARCOpts(passreg)
        InitializeInstrumentation(passreg)
    end
    InitializeVectorization(passreg)
    InitializeInstCombine(passreg)
    InitializeIPO(passreg)
    InitializeAnalysis(passreg)
    InitializeIPA(passreg)
    InitializeCodeGen(passreg)
    InitializeTarget(passreg)
end
end

InitializeNativeTarget()
InitializeAllTargetInfos()
InitializeAllTargetMCs()
InitializeNativeAsmPrinter()

end
