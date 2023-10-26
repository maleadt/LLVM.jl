@testitem "essentials" begin

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

    InitializeNativeTarget()
    InitializeAllTargetInfos()
    InitializeAllTargetMCs()
    InitializeNativeAsmPrinter()
end

end
