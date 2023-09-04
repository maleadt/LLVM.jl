@testitem "ir" begin

@dispose ctx=Context() begin
    invalid_ir = "invalid"
    @test_throws LLVMException parse(LLVM.Module, invalid_ir)
end

@dispose ctx=Context() begin
    let builder = IRBuilder()
        dispose(builder)
    end

    IRBuilder() do builder
    end
end


@dispose ctx=Context() builder=IRBuilder() source_mod=LLVM.Module("SomeModule") begin
    ft = LLVM.FunctionType(LLVM.VoidType())
    fn = LLVM.Function(source_mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry")
    position!(builder, entry)

    ret!(builder)

    verify(source_mod)


    ir = string(source_mod)

    let
        mod = parse(LLVM.Module, ir)
        verify(mod)
        @test haskey(functions(mod), "SomeFunction")
        dispose(mod)
    end
end

end
