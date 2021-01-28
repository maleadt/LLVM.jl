@testcase "analysis" begin

Context() do ctx
Builder(ctx) do builder
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.Int32Type(ctx))
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry")
    position!(builder, entry)

    ret!(builder)

    @test_throws LLVMException verify(mod)
    @test_throws LLVMException verify(fn)
end
end
end

Context() do ctx
Builder(ctx) do builder
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx))
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry")
    position!(builder, entry)

    ret!(builder)

    verify(mod)
    verify(fn)
end
end
end

end
