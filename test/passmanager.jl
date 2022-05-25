@testset "passmanager" begin

let
    mpm = ModulePassManager()
    dispose(mpm)
end

@dispose ctx=Context() mod=LLVM.Module("SomeModule"; ctx) mpm=ModulePassManager() begin
    @test !run!(mpm, mod)
end

@dispose ctx=Context() mod=LLVM.Module("SomeModule"; ctx) fpm=FunctionPassManager(mod) begin
    ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int32Type(ctx)])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    @test !initialize!(fpm)
    @test !run!(fpm, fn)
    @test !finalize!(fpm)
end

end
