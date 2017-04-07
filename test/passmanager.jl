@testset "passmanager" begin

let
    mpm = ModulePassManager()
    dispose(mpm)
end

Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
ModulePassManager() do mpm
    run!(mpm, mod)
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

end
