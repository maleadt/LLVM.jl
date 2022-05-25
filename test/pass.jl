@testset "pass" begin

@dispose ctx=Context() builder=Builder(ctx) mod=LLVM.Module("SomeModule"; ctx) begin
    ft = LLVM.FunctionType(LLVM.VoidType(ctx))
    fn = LLVM.Function(mod, "SomeFunction", ft)

    bb = BasicBlock(fn, "SomeBasicBlock"; ctx)
    position!(builder, bb)

    ret!(builder)

    verify(mod)


    # module pass

    let mpm = ModulePassManager()
        dispose(mpm)
    end

    ModulePassManager() do mpm
    end

    function runOnModule(cur_mod::LLVM.Module)
        @test cur_mod == mod
        return false
    end

    let pass = ModulePass("SomeModulePass", runOnModule)
        @dispose mpm=ModulePassManager() begin
            add!(mpm, pass)
            run!(mpm, mod)
        end
    end

    # function pass

    let fpm = FunctionPassManager(mod)
        dispose(fpm)
    end

    FunctionPassManager(mod) do fpm
    end

    function runOnFunction(cur_fn::LLVM.Function)
        @test cur_fn == fn
        return false
    end

    let pass = FunctionPass("SomeFunctionPass", runOnFunction)
        @dispose fpm=FunctionPassManager(mod) begin
            add!(fpm, pass)
            run!(fpm, fn)
        end
    end
end

end
