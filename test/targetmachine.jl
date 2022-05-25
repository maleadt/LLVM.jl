@testset "targetmachine" begin

host_triple = triple()
host_t = Target(triple=host_triple)

let tm = TargetMachine(host_t, host_triple)
    @test target(tm) == host_t
    @test triple(tm) == host_triple
    @test cpu(tm) == ""
    @test features(tm) == ""
    asm_verbosity!(tm, true)

    # emission
    let ctx = Context()
    let builder = Builder(ctx)
    let mod = LLVM.Module("SomeModule"; ctx)
        ft = LLVM.FunctionType(LLVM.VoidType(ctx))
        fn = LLVM.Function(mod, "SomeFunction", ft)

        entry = BasicBlock(fn, "entry"; ctx)
        position!(builder, entry)

        ret!(builder)

        asm = String(convert(Vector{UInt8}, emit(tm, mod, LLVM.API.LLVMAssemblyFile)))

        mktemp() do path, io
            emit(tm, mod, LLVM.API.LLVMAssemblyFile, path)
            @test asm == read(path, String)
        end

        @test_throws LLVMException emit(tm, mod, LLVM.API.LLVMAssemblyFile, "/")
    end
    end
    end

    let ctx = Context()
    let mod = LLVM.Module("SomeModule"; ctx)
        let fpm = FunctionPassManager(mod)
            add_transform_info!(fpm)
            add_transform_info!(fpm, tm)
            add_library_info!(fpm, triple(tm))
        end
        let mpm = ModulePassManager()
            add_transform_info!(mpm)
            add_transform_info!(mpm, tm)
            add_library_info!(mpm, triple(tm))
        end
    end
    end

    DataLayout(tm)
end

end
