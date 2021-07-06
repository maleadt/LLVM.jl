@testset "ir" begin

Context() do ctx
    invalid_ir = "invalid"
    @test_throws LLVMException parse(LLVM.Module, invalid_ir; ctx)
end

Context() do ctx
Builder(ctx) do builder
LLVM.Module("SomeModule"; ctx) do source_mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx))
    fn = LLVM.Function(source_mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry"; ctx)
    position!(builder, entry)

    ret!(builder)

    verify(source_mod)


    ir = string(source_mod)

    let
        mod = parse(LLVM.Module, ir; ctx)
        verify(mod)
        @test haskey(functions(mod), "SomeFunction")
        dispose(mod)
    end
end
end
end

end
