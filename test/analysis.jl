@testset "analysis" begin

@dispose ctx=Context() builder=Builder(ctx) mod=LLVM.Module("SomeModule"; ctx) begin
    ft = LLVM.FunctionType(LLVM.Int32Type(ctx))
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry"; ctx)
    position!(builder, entry)

    ret!(builder)

    @test_throws LLVMException verify(mod)
    @test_throws LLVMException verify(fn)
end

@dispose ctx=Context() builder=Builder(ctx) mod=LLVM.Module("SomeModule"; ctx) begin
    ft = LLVM.FunctionType(LLVM.VoidType(ctx))
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry"; ctx)
    position!(builder, entry)

    ret!(builder)

    verify(mod)
    verify(fn)
end

end
