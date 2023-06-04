@testset "dibuilder" begin

Context() do ctx
LLVM.Module("SomeModule"; ctx) do mod
    builder = DIBuilder(mod)
    dispose(builder)
end
end

Context() do ctx
LLVM.Module("SomeModule"; ctx) do mod
    di_builder = DIBuilder(mod)
    file = LLVM.file!(di_builder, "test.jl", "src")

    @test LLVM.filename(file) == "test.jl"
    @test LLVM.directory(file) == "src"
    @test LLVM.source(file) == "" # No C-API to attach source

    cu = LLVM.compilationunit!(di_builder,
        LLVM.API.LLVMDWARFSourceLanguageJulia, file, "LLVM.jl Tests")

    finalize(di_builder)
    dispose(di_builder)
end
end

end # testset
