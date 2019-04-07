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
    file = LLVM.file!(dibuilder, "test.jl", "src")
    cu = LLVM.compileunit!(dibuilder, LLVM.API.LLVMDWARFSourceLanguageJulia, file, "LLVM.jl Tests", LLVM.False,
                           "", UInt32(0), "", LLVM.API.LLVMDWARFEmissionFull, UInt32(4), LLVM.False, LLVM.False)

    Builder(ctx) do builder
        ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int32Type(ctx)])
        fn = LLVM.Function(mod, "SomeFunction", ft)

        entrybb = BasicBlock(fn, "entry")
        position!(builder, entrybb)

        md = LLVM.location!(ctx, UInt32(1), UInt32(1), cu) # could also be file
        debuglocation!(builder, LLVM.MetadataAsValue(LLVM.API.LLVMMetadataAsValue(LLVM.ref(ctx), md)))
        ret!(builder)
    end

    finalize(dibuilder)
    dispose(dibuilder)

    fun = functions(mod)["SomeFunction"]
    bb = entry(fun)
    inst = first(instructions(bb))

    @test !isempty(metadata(inst))
    strip_debuginfo!(mod)
    @test isempty(metadata(inst))
end
end

end

