@testset "ir" begin

@dispose ctx=Context() begin
    invalid_ir = "invalid"
    @test_throws LLVMException parse(LLVM.Module, invalid_ir; ctx)
end

@dispose ctx=Context() begin
    let builder = Builder(ctx)
        dispose(builder)
    end

    Builder(ctx) do builder
    end
end


@dispose ctx=Context() builder=Builder(ctx) source_mod=LLVM.Module("SomeModule"; ctx) begin
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
