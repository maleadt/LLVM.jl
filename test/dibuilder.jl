@testset "dibuilder" begin

Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    builder = DIBuilder(mod)
    dispose(builder)
end
end

Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    dibuilder = DIBuilder(mod)
    file = DIFile("test.jl", "src")
    file_md = LLVM.file!(dibuilder, file)
    cu = DICompileUnit(file_md, LLVM.API.LLVMDWARFSourceLanguageJulia, "LLVM.jl Tests", "/", "LLVM.jl", "", false, 4)
    cu_md = LLVM.compileunit!(dibuilder, cu)

    Builder(ctx) do builder
        ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int32Type(ctx)])
        fn = LLVM.Function(mod, "SomeFunction", ft)

        entrybb = BasicBlock(fn, "entry")
        position!(builder, entrybb)

        block = DILexicalBlock(file_md, 1, 1)
        block_md = LLVM.lexicalblock!(dibuilder, file_md, block) # could also be file
        debuglocation!(builder, LLVM.MetadataAsValue(LLVM.API.LLVMMetadataAsValue(ctx, block_md)))
        ret!(builder)
    end

    finalize(dibuilder)
    dispose(dibuilder)

    fun = functions(mod)["SomeFunction"]
    bb = entry(fun)
    inst = first(instructions(bb))
    @test !isempty(metadata(inst))
    inst_str = sprint(io->Base.show(io, inst))
    @test occursin("!dbg", inst_str)
    @show mod inst

    @test !isempty(metadata(inst))
    mod_str = sprint(io->Base.show(io, mod))
    @test occursin("!llvm.dbg.cu", mod_str)
    @test occursin("!DICompileUnit", mod_str)
    @test occursin("!DIFile", mod_str)
    @test occursin("!DILexicalBlock", mod_str)
    @test !occursin("scope: null", mod_str)

    strip_debuginfo!(mod)
    @test isempty(metadata(inst))
end
end

end

