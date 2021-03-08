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
        ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int64Type(ctx)])
        rt_md = LLVM.basictype!(dibuilder, "Nothing", 0, 0)
        param_md = LLVM.basictype!(dibuilder, "Int64", sizeof(Int64), 0)
        dift_md = LLVM.subroutinetype!(dibuilder, file_md, rt_md, param_md)
        fn = LLVM.Function(mod, "SomeFunction", ft)
        difn = DISubprogram(LLVM.name(fn), "linkage", file_md, 3, dift_md, true, true, 5, LLVM.API.LLVMDIFlagPublic, false)
        difn_md = LLVM.subprogram!(dibuilder, difn)
        LLVM.set_subprogram!(fn, difn_md)

        entrybb = BasicBlock(fn, "entry")
        position!(builder, entrybb)

        ptr = inttoptr!(builder, parameters(fn)[1], LLVM.PointerType(LLVM.Int64Type(ctx)))
        ptr_md = LLVM.pointertype!(dibuilder, param_md, sizeof(Ptr{Int64}), LLVM.addrspace(llvmtype(ptr)), 0, "MyPtr")
        # TODO: LLVM.dbg_declare!(builder, mod, ptr, ptr_md)
        val = ptrtoint!(builder, ptr, LLVM.Int64Type(ctx))

        block = DILexicalBlock(file_md, 1, 1)
        block_md = LLVM.lexicalblock!(dibuilder, file_md, block) # could also be file
        debuglocation!(builder, LLVM.MetadataAsValue(LLVM.API.LLVMMetadataAsValue(ctx, block_md)))
        ret!(builder)
    end

    finalize(dibuilder)
    dispose(dibuilder)

    fun = functions(mod)["SomeFunction"]
    bb = entry(fun)
    inst = last(instructions(bb))
    @test !isempty(metadata(inst))
    inst_str = sprint(io->Base.show(io, inst))
    @test occursin("!dbg", inst_str)

    @test !isempty(metadata(inst))
    mod_str = sprint(io->Base.show(io, mod))
    @test occursin("!llvm.dbg.cu", mod_str)
    @test occursin("!DICompileUnit", mod_str)
    @test occursin("!DIFile", mod_str)
    @test occursin("!DILexicalBlock", mod_str)
    @test !occursin("scope: null", mod_str)
    @test occursin("DISubprogram", mod_str)
    @test occursin("DISubroutineType", mod_str)
    @test occursin("DIBasicType", mod_str)

    strip_debuginfo!(mod)
    @test isempty(metadata(inst))
end
end

end

