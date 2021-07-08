@testset "orcv2" begin

@testset "ThreadSafeModule" begin
    ts_mod = ThreadSafeModule("jit")
    @test_throws LLVMException ts_mod() do mod
        error("Error")
    end
    run = Ref{Bool}(false)
    ts_mod() do mod
        run[] = true
    end
    @test run[]
end

@testset "JITDylib" begin
    LLJIT() do lljit
        es = ExecutionSession(lljit)

        @test LLVM.lookup_dylib(es, "my.so") === nothing

        jd = JITDylib(es, "my.so")
        jd_bare = JITDylib(es, "mybare.so", bare=true)

        @test LLVM.lookup_dylib(es, "my.so") === jd

        jd_main = JITDylib(lljit)

        prefix = LLVM.get_prefix(lljit)
        dg = LLVM.CreateDynamicLibrarySearchGeneratorForProcess(prefix)
        add!(jd_main, dg)

        addr = lookup(lljit, "jl_apply_generic")
        @test pointer(addr) != C_NULL
    end
end

@testset "Undefined Symbol" begin
    LLJIT() do lljit
        @test_throws LLVMException lookup(lljit, string(gensym()))
    end

    LLJIT(;tm=JITTargetMachine()) do lljit
        jd = JITDylib(lljit)

        ThreadSafeContext() do ts_ctx
            ctx = context(ts_ctx)
            mod = LLVM.Module("jit"; ctx)

            T_Int32 = LLVM.Int32Type(ctx)
            ft = LLVM.FunctionType(T_Int32, [T_Int32, T_Int32])
            fn = LLVM.Function(mod, "mysum", ft)
            linkage!(fn, LLVM.API.LLVMExternalLinkage)

            fname = "wrapper"
            wrapper = LLVM.Function(mod, fname, ft)
            # generate IR
            Builder(ctx) do builder
                entry = BasicBlock(wrapper, "entry"; ctx)
                position!(builder, entry)

                tmp = call!(builder, fn, [parameters(wrapper)...])
                ret!(builder, tmp)
            end

            # TODO: Get TM from lljit?
            tm = JITTargetMachine()
            triple!(mod, triple(lljit))
            ModulePassManager() do pm
                add_library_info!(pm, triple(mod))
                add_transform_info!(pm, tm)
                run!(pm, mod)
            end
            verify(mod)

            ts_mod = ThreadSafeModule(mod; ctx=ts_ctx)

            add!(lljit, jd, ts_mod)
            @test_throws LLVMException lookup(lljit, fname)
        end
    end
end

@testset "Loading ObjectFile" begin
    LLJIT(;tm=JITTargetMachine()) do lljit
        jd = JITDylib(lljit)

        ThreadSafeContext() do ts_ctx
            ctx = context(ts_ctx)
            sym = "SomeFunction"

            mod = LLVM.Module("jit"; ctx)
            ft = LLVM.FunctionType(LLVM.VoidType(ctx))
            fn = LLVM.Function(mod, sym, ft)

            Builder(ctx) do builder
                entry = BasicBlock(fn, "entry"; ctx)
                position!(builder, entry)
                ret!(builder)
            end
            verify(mod)

            tm  = JITTargetMachine()
            obj = emit(tm, mod, LLVM.API.LLVMObjectFile)
            add!(lljit, jd, MemoryBuffer(obj))

            addr = lookup(lljit, sym)

            @test pointer(addr) != C_NULL

            empty!(jd)
            @test_throws LLVMException lookup(lljit, sym)
        end
    end
end

@testset "ObjectLinkingLayer" begin
    called_oll = Ref{Int}(0)

    ollc = LLVM.ObjectLinkingLayerCreator() do es, triple
        oll = ObjectLinkingLayer(es)
        register!(oll, GDBRegistrationListener())
        called_oll[] += 1
        return oll
    end

    GC.@preserve ollc begin
        builder = LLJITBuilder()
        linkinglayercreator!(builder, ollc)
        LLJIT(builder) do lljit
            jd = JITDylib(lljit)

            ThreadSafeContext() do ts_ctx
                ctx = context(ts_ctx)
                sym = "SomeFunctionOLL"

                mod = LLVM.Module("jit"; ctx)
                ft = LLVM.FunctionType(LLVM.VoidType(ctx))
                fn = LLVM.Function(mod, sym, ft)

                Builder(ctx) do builder
                    entry = BasicBlock(fn, "entry"; ctx)
                    position!(builder, entry)
                    ret!(builder)
                end
                verify(mod)

                ts_mod = ThreadSafeModule(mod; ctx=ts_ctx)
                add!(lljit, jd, ts_mod)

                addr = lookup(lljit, sym)

                @test pointer(addr) != C_NULL
            end
        end
    end
    @test called_oll[] >= 1
end

@testset "Lazy" begin
    LLJIT() do lljit
        jd = JITDylib(lljit)
        es = ExecutionSession(lljit)

        lctm = LLVM.LocalLazyCallThroughManager(triple(lljit), es)
        ism = LLVM.LocalIndirectStubsManager(triple(lljit))
        try
            # 1. define entry symbol
            entry_sym = "foo_entry"
            flags = LLVM.API.LLVMJITSymbolFlags(
                LLVM.API.LLVMJITSymbolGenericFlagsCallable |
                LLVM.API.LLVMJITSymbolGenericFlagsExported, 0)
            entry = LLVM.API.LLVMOrcCSymbolAliasMapPair(
                mangle(lljit, entry_sym),
                LLVM.API.LLVMOrcCSymbolAliasMapEntry(
                    mangle(lljit, "foo"), flags))

            mu = LLVM.reexports(lctm, ism, jd, Ref(entry))
            LLVM.define(jd, mu)

            # 2. Lookup address of entry symbol
            addr = lookup(lljit, entry_sym)
            @test pointer(addr) != C_NULL

            # 3. add MU that will call back into the compiler
            sym = LLVM.API.LLVMOrcCSymbolFlagsMapPair(mangle(lljit, "foo"), flags)

            function materialize(mr)
                syms = LLVM.get_requested_symbols(mr)
                @assert length(syms) == 1

                # syms contains mangled symbols
                # we need to emit an unmangled one

                TSM = ThreadSafeModule("jit")
                TSM() do mod
                    LLVM.apply_datalayout!(lljit, mod)

                    ctx = context(mod)
                    T_Int32 = LLVM.Int32Type(ctx)
                    ft = LLVM.FunctionType(T_Int32, [T_Int32, T_Int32])

                    fn = LLVM.Function(mod, "foo", ft)

                    # generate IR
                    Builder(ctx) do builder
                        entry = BasicBlock(fn, "entry"; ctx)
                        position!(builder, entry)

                        tmp = add!(builder, parameters(fn)...)
                        ret!(builder, tmp)
                    end
                end

                il = LLVM.IRTransformLayer(lljit)
                LLVM.emit(il, mr, TSM)

                return nothing
            end

            function discard(jd, sym)
            end

            mu = LLVM.CustomMaterializationUnit("fooMU", Ref(sym), materialize, discard)
            LLVM.define(jd, mu)

            @test ccall(pointer(addr), Int32, (Int32, Int32), 1, 2) == 3
        finally
            dispose(lctm)
            dispose(ism)
        end
    end
end

end
