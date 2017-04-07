@testset "ir" begin

let
    invalid_ir = "invalid"
    @test_throws LLVMException parse(LLVM.Module, invalid_ir)
end

Context() do ctx
Builder(ctx) do builder
LLVM.Module("SomeModule", ctx) do source_mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx))
    fn = LLVM.Function(source_mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry")
    position!(builder, entry)

    ret!(builder)

    verify(source_mod)
    

    ir = convert(String, source_mod)

    let
        mod = parse(LLVM.Module, ir)
        verify(mod)
        @test haskey(functions(mod), "SomeFunction")
        dispose(mod)
    end

    let
        mod = parse(LLVM.Module, ir, ctx)
        verify(mod)
        @test haskey(functions(mod), "SomeFunction")
        dispose(mod)
    end
end
end
end

end
