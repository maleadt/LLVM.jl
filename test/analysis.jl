@testset "analysis" begin

let ctx = Context()
let builder = Builder(ctx)
let mod = LLVM.Module("SomeModule"; ctx)
    ft = LLVM.FunctionType(LLVM.Int32Type(ctx))
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry"; ctx)
    position!(builder, entry)

    ret!(builder)

    @test_throws LLVMException verify(mod)
    @test_throws LLVMException verify(fn)
end
end
end

let ctx = Context()
let builder = Builder(ctx)
let mod = LLVM.Module("SomeModule"; ctx)
    ft = LLVM.FunctionType(LLVM.VoidType(ctx))
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry"; ctx)
    position!(builder, entry)

    ret!(builder)

    verify(mod)
    verify(fn)
end
end
end

end
