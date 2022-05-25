@testset "passmanager" begin

let ctx = Context()
let mod = LLVM.Module("SomeModule"; ctx)
    mpm = ModulePassManager()
    @test !run!(mpm, mod)
end
end

let ctx = Context()
let mod = LLVM.Module("SomeModule"; ctx)
    fpm = FunctionPassManager(mod)
    ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int32Type(ctx)])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    @test !initialize!(fpm)
    @test !run!(fpm, fn)
    @test !finalize!(fpm)
end
end

end
