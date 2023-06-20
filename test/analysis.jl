@testset "analysis" begin

@dispose ctx=Context() builder=IRBuilder() mod=LLVM.Module("SomeModule") begin
    ft = LLVM.FunctionType(LLVM.Int32Type())
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry")
    position!(builder, entry)

    ret!(builder)

    @test_throws LLVMException verify(mod)
    @test_throws LLVMException verify(fn)
end

@dispose ctx=Context() builder=IRBuilder() mod=LLVM.Module("SomeModule") begin
    ft = LLVM.FunctionType(LLVM.VoidType())
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry")
    position!(builder, entry)

    ret!(builder)

    verify(mod)
    verify(fn)
end

end
