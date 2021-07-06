@testset "passmanager" begin

let
    mpm = ModulePassManager()
    dispose(mpm)
end

Context() do ctx
LLVM.Module("SomeModule"; ctx) do mod
ModulePassManager() do mpm
    @test !run!(mpm, mod)
end
end
end

Context() do ctx
LLVM.Module("SomeModule"; ctx) do mod
FunctionPassManager(mod) do fpm
    ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int32Type(ctx)])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    @test !initialize!(fpm)
    @test !run!(fpm, fn)
    @test !finalize!(fpm)
end
end
end

end
