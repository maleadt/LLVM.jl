@testitem "essentials" begin

@testset "types" begin
    @test convert(Bool, LLVM.True) == true
    @test convert(Bool, LLVM.False) == false

    @test_throws ArgumentError LLVM.convert(Bool, LLVM.API.LLVMBool(2))

    @test convert(LLVM.Bool, true) == LLVM.True
    @test convert(LLVM.Bool, false) == LLVM.False
end

@testset "pass registry" begin
    passreg = GlobalPassRegistry()

    @test version() isa VersionNumber
    @test ismultithreaded() isa Bool

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

end
