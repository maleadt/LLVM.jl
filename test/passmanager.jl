@testset "passmanager" begin

@testcase "module pass manager" begin
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
ModulePassManager() do mpm
    @test !run!(mpm, mod)
end
end
end
end

@testcase "function pass manager" begin
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
FunctionPassManager(mod) do fpm
    ft = LLVM.FunctionType(LLVM.VoidType(), [LLVM.Int32Type()])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    @test !initialize!(fpm)
    @test !run!(fpm, fn)
    @test !finalize!(fpm)
end
end
end
end

end
