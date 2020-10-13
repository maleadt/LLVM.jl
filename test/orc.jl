@testset "orc" begin

@testset "Undefined Symbol" begin
    tm  = JITTargetMachine()
    OrcJIT(tm) do orc
       Context() do ctx
            mod = LLVM.Module("jit", ctx)
            T_Int32 = LLVM.Int32Type(ctx)
            ft = LLVM.FunctionType(T_Int32, [T_Int32, T_Int32])
            fn = LLVM.Function(mod, "mysum", ft)
            linkage!(fn, LLVM.API.LLVMExternalLinkage)

            fname = mangle(orc, "wrapper")
            wrapper = LLVM.Function(mod, fname, ft)
            # generate IR
            Builder(ctx) do builder
                entry = BasicBlock(wrapper, "entry", ctx)
                position!(builder, entry)

                tmp = call!(builder, fn, [parameters(wrapper)...])
                ret!(builder, tmp)
            end

            triple!(mod, triple(tm))
            ModulePassManager() do pm
                add_library_info!(pm, triple(mod))
                add_transform_info!(pm, tm)
                run!(pm, mod)
            end
            verify(mod)

            orc_mod = compile!(orc, mod)
            @test_throws ErrorException address(orc, fname) == C_NULL

            delete!(orc, orc_mod)
        end
    end
end

@testset "Custom Resolver" begin
    tm  = JITTargetMachine()
    OrcJIT(tm) do orc
       Context() do ctx
            known_functions = Dict{String, OrcTargetAddress}()
            fnames = Dict{String, Int}()
            function lookup(name, ctx)
                name = unsafe_string(name)
                try
                    if !haskey(fnames, name)
                        fnames[name] = 0
                    end
                    fnames[name] += 1

                    return known_functions[name].ptr
                catch ex
                    @error "Exception during lookup" name exception=(ex, catch_backtrace())
                    error("OrcJIT: Could not find symbol")
                end
            end

            mod = LLVM.Module("jit", ctx)
            T_Int32 = LLVM.Int32Type(ctx)
            ft = LLVM.FunctionType(T_Int32, [T_Int32, T_Int32])
            fn = LLVM.Function(mod, "mysum", ft)
            linkage!(fn, LLVM.API.LLVMExternalLinkage)

            fname = mangle(orc, "wrapper")
            wrapper = LLVM.Function(mod, fname, ft)
            # generate IR
            Builder(ctx) do builder
                entry = BasicBlock(wrapper, "entry", ctx)
                position!(builder, entry)

                tmp = call!(builder, fn, [parameters(wrapper)...])
                ret!(builder, tmp)
            end

            triple!(mod, triple(tm))
            ModulePassManager() do pm
                add_library_info!(pm, triple(mod))
                add_transform_info!(pm, tm)
                run!(pm, mod)
            end
            verify(mod)

            mysum_name = mangle(orc, "mysum")
            known_functions[mysum_name] = OrcTargetAddress(@cfunction(+, Int32, (Int32, Int32)))

            f_lookup = @cfunction($lookup, UInt64, (Cstring, Ptr{Cvoid}))
            GC.@preserve f_lookup begin
                orc_mod = compile!(orc, mod, f_lookup, C_NULL, lazy=true) # will capture f_lookup

                addr = address(orc, fname)
                @test errormsg(orc) == ""
                addr2 = addressin(orc, orc_mod, fname)

                @test addr == addr2
                @test addr.ptr != 0
                @test !haskey(fnames, mysum_name)

                r = ccall(pointer(addr), Int32, (Int32, Int32), 1, 2) # uses f_lookup
                @test r == 3
            end

            @test haskey(fnames, mysum_name)
            @test fnames[mysum_name] == 1

            empty!(fnames)
            delete!(orc, orc_mod)
        end
    end
end

@testset "Default Resolver + Stub" begin
    tm  = JITTargetMachine()
    OrcJIT(tm) do orc
            Context() do ctx
            mod = LLVM.Module("jit", ctx)
            T_Int32 = LLVM.Int32Type(ctx)
            ft = LLVM.FunctionType(T_Int32, [T_Int32, T_Int32])
            fn = LLVM.Function(mod, "mysum", ft)
            linkage!(fn, LLVM.API.LLVMExternalLinkage)

            fname = mangle(orc, "wrapper")
            wrapper = LLVM.Function(mod, fname, ft)
            # generate IR
            Builder(ctx) do builder
                entry = BasicBlock(wrapper, "entry", ctx)
                position!(builder, entry)

                tmp = call!(builder, fn, [parameters(wrapper)...])
                ret!(builder, tmp)
            end

            triple!(mod, triple(tm))
            ModulePassManager() do pm
                add_library_info!(pm, triple(mod))
                add_transform_info!(pm, tm)
                run!(pm, mod)
            end
            verify(mod)

            create_stub!(orc, mangle(orc, "mysum"), OrcTargetAddress(@cfunction(+, Int32, (Int32, Int32))))

            orc_mod = compile!(orc, mod)

            addr = address(orc, fname)
            @test errormsg(orc) == ""

            r = ccall(pointer(addr), Int32, (Int32, Int32), 1, 2)
            @test r == 3

            delete!(orc, orc_mod)
        end
    end
end

@testset "Default Resolver + Global Symbol" begin
    tm  = JITTargetMachine()
    OrcJIT(tm) do orc
        Context() do ctx
            mod = LLVM.Module("jit", ctx)
            T_Int32 = LLVM.Int32Type(ctx)
            ft = LLVM.FunctionType(T_Int32, [T_Int32, T_Int32])
            mysum = mangle(orc, "mysum")
            fn = LLVM.Function(mod, mysum, ft)
            linkage!(fn, LLVM.API.LLVMExternalLinkage)

            fname = mangle(orc, "wrapper")
            wrapper = LLVM.Function(mod, fname, ft)
            # generate IR
            Builder(ctx) do builder
                entry = BasicBlock(wrapper, "entry", ctx)
                position!(builder, entry)

                tmp = call!(builder, fn, [parameters(wrapper)...])
                ret!(builder, tmp)
            end

            triple!(mod, triple(tm))
            ModulePassManager() do pm
                add_library_info!(pm, triple(mod))
                add_transform_info!(pm, tm)
                run!(pm, mod)
            end
            verify(mod)

            # Should do pretty much the same as `@ccallable`
            LLVM.add_symbol(mysum, @cfunction(+, Int32, (Int32, Int32)))
            ptr = LLVM.find_symbol(mysum)
            @test ptr !== C_NULL
            @test ccall(ptr, Int32, (Int32, Int32), 1, 2) == 3

            orc_mod = compile!(orc, mod, lazy=true)

            addr = address(orc, fname)
            @test errormsg(orc) == ""

            r = ccall(pointer(addr), Int32, (Int32, Int32), 1, 2)
            @test r == 3

            delete!(orc, orc_mod)
        end
    end
end

@testset "Loading ObjectFile" begin
    tm  = JITTargetMachine()
    OrcJIT(tm) do orc
        Context() do ctx
            sym = mangle(orc, "SomeFunction")

            mod = LLVM.Module("jit", ctx)
            ft = LLVM.FunctionType(LLVM.VoidType(ctx))
            fn = LLVM.Function(mod, sym, ft)

            Builder(ctx) do builder
                entry = BasicBlock(fn, "entry")
                position!(builder, entry)
                ret!(builder)
            end
            verify(mod)

            obj = emit(tm, mod, LLVM.API.LLVMObjectFile)

            orc_m = add!(orc, MemoryBuffer(obj))
            addr = address(orc, sym)

            @test addr.ptr != 0
            delete!(orc, orc_m)
        end
    end
end

@testset "Stubs" begin
    tm  = JITTargetMachine()
    OrcJIT(tm) do orc
        Context() do ctx
            toggle = Ref{Bool}(false)
            on()  = (toggle[] = true; nothing)
            off() = (toggle[] = false; nothing)

            # Note that `CFunction` objects can be GC'd (???)
            # and we capture them below.
            func_on = @cfunction($on, Cvoid, ())
            GC.@preserve func_on begin
                ptr = Base.unsafe_convert(Ptr{Cvoid}, func_on)

                create_stub!(orc, "mystub", OrcTargetAddress(ptr))
                addr = address(orc, "mystub")

                @test addr.ptr != 0
                @test toggle[] == false

                ccall(pointer(addr), Cvoid, ())
                @test toggle[] == true
            end

            func_off = @cfunction($off, Cvoid, ())
            GC.@preserve func_off begin
                ptr = Base.unsafe_convert(Ptr{Cvoid}, func_off)

                set_stub!(orc, "mystub", OrcTargetAddress(ptr))

                @test addr == address(orc, "mystub")
                @test toggle[] == true

                ccall(pointer(addr), Cvoid, ())
                @test toggle[] == false
            end
        end
    end
end

@testset "callback!" begin
    tm  = JITTargetMachine()
    OrcJIT(tm) do orc
        triggered = Ref{Bool}(false)

        # Setup the lazy callback for creating a module
        function callback(orc_ref::LLVM.API.LLVMOrcJITStackRef, callback_ctx::Ptr{Cvoid})
            orc = OrcJIT(orc_ref)
            sym = mangle(orc, "SomeFunction")

            # 1. IRGen & Optimize the module
            orc_mod = Context() do ctx
                mod = LLVM.Module("jit", ctx)
                ft = LLVM.FunctionType(LLVM.VoidType(ctx))
                fn = LLVM.Function(mod, sym, ft)

                Builder(ctx) do builder
                    entry = BasicBlock(fn, "entry")
                    position!(builder, entry)
                    ret!(builder)
                end
                verify(mod)

                triple!(mod, triple(tm))
                ModulePassManager() do pm
                    add_library_info!(pm, triple(mod))
                    add_transform_info!(pm, tm)
                    run!(pm, mod)
                end
                verify(mod)

                # 2. Add the IR module to the JIT
                return compile!(orc, mod)
            end

            # 3. Obtain address of compiled module
            addr = addressin(orc, orc_mod, sym)

            # 4. Update the stub pointer to point to the recently compiled module
            set_stub!(orc, "lazystub", addr)

            # 5. Return the address of tie implementation, since we are going to call it now
            triggered[] = true
            return addr.ptr
        end
        c_callback = @cfunction($callback, UInt64, (LLVM.API.LLVMOrcJITStackRef, Ptr{Cvoid}))

        GC.@preserve c_callback begin
            initial_addr = callback!(orc, c_callback, C_NULL)
            create_stub!(orc, "lazystub", initial_addr)
            addr = address(orc, "lazystub")

            ccall(pointer(addr), Cvoid, ()) # Triggers compilation
        end
        @test triggered[]
    end
end

end