@testset "pass" begin

Context() do ctx
Builder(ctx) do builder
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx))
    fn = LLVM.Function(mod, "SomeFunction", ft)

    bb = BasicBlock(fn, "SomeBasicBlock")
    position!(builder, bb)

    ret!(builder)

    verify(mod)


    # module pass

    function runOnModule(cur_mod::LLVM.Module)
        @test cur_mod == mod
        return false
    end
    pass = ModulePass("SomeModulePass", runOnModule)

    ModulePassManager() do mpm
        add!(mpm, pass)
        run!(mpm, mod)
    end

    # function pass

    function runOnFunction(cur_fn::LLVM.Function)
        @test cur_fn == fn
        return false
    end
    pass = FunctionPass("SomeFunctionPass", runOnFunction)

    FunctionPassManager(mod) do fpm
        add!(fpm, pass)
        run!(fpm, fn)
    end

    # basic block pass

    function runOnBasicBlock(cur_bb::BasicBlock)
        @test cur_bb == bb
        return false
    end
    pass = BasicBlockPass("SomeBasicBlockPass", runOnBasicBlock)

    FunctionPassManager(mod) do fpm
        add!(fpm, pass)
        run!(fpm, fn)
    end
end
end
end

end
