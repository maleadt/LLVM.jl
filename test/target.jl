## target

let
    @test_throws LLVMException Target("invalid")

    host_triple = triple()
    host_t = Target(host_triple)

    host_name = name(host_t)
    description(host_t)

    @test hasjit(host_t)
    @test hastargetmachine(host_t)
    @test hasasmparser(host_t)

    # target iteration
    let ts = targets()
        @test haskey(ts, host_name)
        @test get(ts, host_name) == host_t

        @test !haskey(ts, "invalid")
        @test_throws KeyError get(ts, "invalid")

        @test eltype(ts) == Target
        @test length(ts) > 0

        first(ts)

        for t in ts
            # ...
        end

        @test any(t -> t == host_t, collect(ts))
    end
end


## target machine

host_triple = triple()
host_t = Target(host_triple)

let
    tm = TargetMachine(host_t, host_triple, "", "", LLVM.API.LLVMCodeGenLevelDefault,
                       LLVM.API.LLVMRelocDefault, LLVM.API.LLVMCodeModelDefault)
    dispose(tm)
end

TargetMachine(host_t, host_triple, "", "", LLVM.API.LLVMCodeGenLevelDefault,
              LLVM.API.LLVMRelocDefault, LLVM.API.LLVMCodeModelDefault) do tm
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
            @test asm == readstring(path)
        end

        @test_throws LLVMException emit(tm, mod, LLVM.API.LLVMAssemblyFile, "/")
    end
    end
    end

    Context() do ctx
    LLVM.Module("SomeModule", ctx) do mod
        FunctionPassManager(mod) do fpm
            populate!(fpm, tm)
        end
        ModulePassManager() do mpm
            populate!(mpm, tm)
        end
    end
    end

    TargetData(tm)
end


## target data

Context() do ctx
TargetData("E-p:32:32-f128:128:128") do data
    @test convert(String, data) == "E-p:32:32-f128:128:128"

    @test byteorder(data) == LLVM.API.LLVMBigEndian
    @test pointersize(data) == pointersize(data, 0) == 4

    @test intptr(data) == intptr(data, 0) == LLVM.Int32Type()
    @test intptr(data, ctx) == intptr(data, 0, ctx) == LLVM.Int32Type(ctx)

    @test sizeof(data, LLVM.Int32Type()) == storage_size(data, LLVM.Int32Type()) == abi_size(data, LLVM.Int32Type()) == 4

    @test abi_alignment(data, LLVM.Int32Type()) == frame_alignment(data, LLVM.Int32Type()) == preferred_alignment(data, LLVM.Int32Type()) == 4

    LLVM.Module("SomeModule") do mod
        gv = GlobalVariable(mod, LLVM.Int32Type(), "SomeGlobal")
        @test preferred_alignment(data, gv) == 4
    end

    elem = [LLVM.Int32Type(ctx), LLVM.FloatType(ctx)]
    let st = LLVM.StructType(elem, ctx)
        @test element_at(data, st, 4) == 1
        @test offsetof(data, st, 1) == 4
    end
end
end