@testset "pass" begin

let ctx = Context()
let builder = Builder(ctx)
let mod = LLVM.Module("SomeModule"; ctx)
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

        let mpm = ModulePassManager()
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

        let fpm = FunctionPassManager(mod)
            add!(fpm, pass)
            run!(fpm, fn)
        end
    end
end
end
end

end
