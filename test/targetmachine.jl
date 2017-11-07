@testset "targetmachine" begin

host_triple = triple()
host_t = Target(host_triple)

let
    tm = TargetMachine(host_t, host_triple)
    dispose(tm)
end

TargetMachine(host_t, host_triple) do tm
    @test target(tm) == host_t
    @test triple(tm) == host_triple
    @test cpu(tm) == ""
    @test features(tm) == ""
    asm_verbosity!(tm, true)

    # emission
    Context() do ctx
    Builder(ctx) do builder
    LLVM.Module("SomeModule", ctx) do mod
        ft = LLVM.FunctionType(LLVM.VoidType(ctx))
        fn = LLVM.Function(mod, "SomeFunction", ft)

        entry = BasicBlock(fn, "entry")
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

    Context() do ctx
    LLVM.Module("SomeModule", ctx) do mod
        FunctionPassManager(mod) do fpm
            add_transform_info!(fpm, tm)
            add_library_info!(fpm, triple(tm))
        end
        ModulePassManager() do mpm
            add_transform_info!(mpm, tm)
            add_library_info!(mpm, triple(tm))
        end
    end
    end

    DataLayout(tm)
end

end
