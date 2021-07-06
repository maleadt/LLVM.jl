@testset "pass" begin

Context() do ctx
Builder(ctx) do builder
LLVM.Module("SomeModule"; ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx))
    fn = LLVM.Function(mod, "SomeFunction", ft)

    bb = BasicBlock(fn, "SomeBasicBlock"; ctx)
    position!(builder, bb)

    ret!(builder)

    verify(mod)


    # module pass

    function runOnModule(cur_mod::LLVM.Module)
        @test cur_mod == mod
        return false
    end

    let pass = ModulePass("SomeModulePass", runOnModule)

        ModulePassManager() do mpm
            add!(mpm, pass)
            run!(mpm, mod)
        end
    end

    # function pass

    function runOnFunction(cur_fn::LLVM.Function)
        @test cur_fn == fn
        return false
    end

    let pass = FunctionPass("SomeFunctionPass", runOnFunction)

        FunctionPassManager(mod) do fpm
            add!(fpm, pass)
            run!(fpm, fn)
        end
    end
end
end
end

end
