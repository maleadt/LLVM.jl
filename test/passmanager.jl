let
    pm = PassManager()
    dispose(pm)
end

Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
PassManager() do pm
    run!(pm, mod)
end
end
end

Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
FunctionPassManager(mod) do fpm
    ft = LLVM.FunctionType(LLVM.VoidType(), [LLVM.Int32Type()])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    @test !initialize!(fpm)
    run!(fpm, fn)
    @test !finalize!(fpm)
end
end
end
