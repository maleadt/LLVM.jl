Context() do ctx
Builder(ctx) do builder
    mod1 = let
        mod = LLVM.Module("SomeModule", ctx)
        ft = LLVM.FunctionType(LLVM.VoidType(ctx))
        fn = LLVM.Function(mod, "SomeFunction", ft)

        entry = BasicBlock(fn, "entry")
        position!(builder, entry)

        ret!(builder)

        mod
    end

    mod2 = let
        mod = LLVM.Module("SomeOtherModule", ctx)
        ft = LLVM.FunctionType(LLVM.VoidType(ctx))
        fn = LLVM.Function(mod, "SomeOtherFunction", ft)

        entry = BasicBlock(fn, "entry")
        position!(builder, entry)

        ret!(builder)

        mod
    end

    link!(mod1, mod2)
    @test haskey(functions(mod1), "SomeFunction")
    @test haskey(functions(mod1), "SomeOtherFunction")
end
end
