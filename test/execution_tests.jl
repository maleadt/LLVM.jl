@testitem "execution" begin

@testset "generic values" begin

@dispose ctx=Context() begin
    val = GenericValue(LLVM.Int32Type(), -1)
    @test intwidth(val) == 32
    @test convert(Int, val) == -1
    dispose(val)
end

@dispose ctx=Context() begin
    val = GenericValue(LLVM.Int32Type(), UInt(1))
    @test convert(Int, val) == 1
    @test convert(UInt, val) == 1
    dispose(val)
end

@dispose ctx=Context() begin
    val = GenericValue(LLVM.DoubleType(), Float32(1.1))
    @test convert(Float32, val, LLVM.DoubleType()) == Float32(1.1)
    @test convert(Float64, val, LLVM.DoubleType()) == Float64(Float32(1.1))
    dispose(val)
end

@dispose ctx=Context() begin
    val = GenericValue(LLVM.DoubleType(), 1.1)
    @test convert(Float32, val, LLVM.DoubleType()) == Float32(1.1)
    @test convert(Float64, val, LLVM.DoubleType()) == 1.1
    dispose(val)
end

let
    obj = "whatever"
    val = GenericValue(pointer(obj))
    @test convert(Ptr{Cvoid}, val) == pointer(obj)
    dispose(val)
end

end


@testset "execution engine" begin

@dispose ctx=Context() begin
    mod = LLVM.Module("SomeModule")
    @dispose engine=ExecutionEngine(mod) begin end
end

function emit_sum()
    mod = LLVM.Module("SomeModule")

    param_types = [LLVM.Int32Type(), LLVM.Int32Type()]
    ret_type = LLVM.FunctionType(LLVM.Int32Type(), param_types)

    sum = LLVM.Function(mod, "SomeFunctionSum", ret_type)

    entry = BasicBlock(sum, "entry")

    @dispose builder=IRBuilder() begin
        position!(builder, entry)

        tmp = add!(builder, parameters(sum)[1], parameters(sum)[2])
        ret!(builder, tmp)

        verify(mod)
    end

    return mod
end

function emit_retint(val)
    mod = LLVM.Module("SomeModule")

    ret_type = LLVM.FunctionType(LLVM.Int32Type())

    fn = LLVM.Function(mod, "SomeFunction", ret_type)

    entry = BasicBlock(fn, "entry")

    @dispose builder=IRBuilder() begin
        position!(builder, entry)

        ret!(builder, ConstantInt(LLVM.Int32Type(), val))

        verify(mod)
    end

    return mod
end


function emit_phi()
    # if %1 > %2 then %1+2 else %2-5
    mod = LLVM.Module("sommod")
    params = [LLVM.Int32Type(), LLVM.Int32Type()]

    ft = LLVM.FunctionType(LLVM.Int32Type(), params)
    fn = LLVM.Function(mod, "gt", ft)

    entry = BasicBlock(fn, "entry")
    then = BasicBlock(fn, "then")
    elsee = BasicBlock(fn, "else")
    merge = BasicBlock(fn, "ifcont")

    @dispose builder=IRBuilder() begin
        position!(builder, entry)

        cond = LLVM.icmp!(builder, LLVM.API.LLVMIntSGT, parameters(fn)[1], parameters(fn)[2], "ifcond")
        br!(builder, cond, then, elsee)

        position!(builder, then)
        thencg = add!(builder, parameters(fn)[1], ConstantInt(LLVM.Int32Type(), 2))
        br!(builder, merge)

        position!(builder, elsee)
        elsecg = sub!(builder, LLVM.parameters(fn)[2], LLVM.ConstantInt(LLVM.Int32Type(), 5))
        br!(builder, merge)

        position!(builder, merge)
        phi = phi!(builder, LLVM.Int32Type(), "iftmp")

        append!(LLVM.incoming(phi), [(thencg, then), (elsecg, elsee)])

        @test length(LLVM.incoming(phi)) == 2
        @test_throws BoundsError LLVM.incoming(phi)[3]

        ret!(builder, phi)
    end
    verify(mod)
    return mod
end

@dispose ctx=Context() begin
    mod = emit_sum()

    args = [GenericValue(LLVM.Int32Type(), 1),
            GenericValue(LLVM.Int32Type(), 2)]

    let mod = copy(mod)
        engine = Interpreter(mod)
        dispose(engine)
    end

    let mod = copy(mod)
        Interpreter(mod) do engine
        end
    end

    let mod = copy(mod)
        fn = functions(mod)["SomeFunctionSum"]
        @dispose engine=Interpreter(mod) begin
            res = LLVM.run(engine, fn, args)
            @test convert(Int, res) == 3
            dispose(res)
        end
    end

    dispose(mod)
    dispose.(args)
end

@dispose ctx=Context() begin
    let mod = emit_retint(42)
        engine = JIT(mod)
        dispose(engine)
    end

    let mod = emit_retint(42)
        JIT(mod) do engine
        end
    end

    let mod = emit_retint(42)
        fn = functions(mod)["SomeFunction"]
        @dispose engine=JIT(mod) begin
            res = LLVM.run(engine, fn)
            @test convert(Int, res) == 42
            dispose(res)
        end
    end
end

@dispose ctx=Context() begin
    let mod = emit_retint(42)
        engine = ExecutionEngine(mod)
        dispose(engine)
    end

    let mod = emit_retint(42)
        ExecutionEngine(mod) do engine
        end
    end

    let mod = emit_retint(42)
        fn = functions(mod)["SomeFunction"]
        @dispose engine=ExecutionEngine(mod) begin
            res = LLVM.run(engine, fn)
            @test convert(Int, res) == 42
            dispose(res)
        end
    end
end

@dispose ctx=Context() begin
    args1 = [GenericValue(LLVM.Int32Type(), 1),
             GenericValue(LLVM.Int32Type(), 2)]

    args2 = [GenericValue(LLVM.Int32Type(), 2),
             GenericValue(LLVM.Int32Type(), 1)]

    for (args, true_res) in ((args1, -3), (args2, 4))
        let mod = emit_phi()
            fn = functions(mod)["gt"]
            @dispose engine=Interpreter(mod) begin
                res = LLVM.run(engine, fn, args)
                @test convert(Int, res) == true_res
                dispose(res)
            end
        end
        dispose.(args)
    end

    let mod1 = emit_sum(), mod2 = emit_retint(42)
        @dispose engine=Interpreter(mod1) begin
            @test_throws ErrorException collect(functions(engine))
            @test haskey(functions(engine), "SomeFunctionSum")
            @test functions(engine)["SomeFunctionSum"] isa LLVM.Function
            delete!(engine, mod1)
            @test_throws KeyError functions(engine)["SomeFunctionSum"]
            @test !haskey(functions(engine), "SomeFunctionSum")
            dispose(mod1)
            push!(engine, mod2)
            @test haskey(functions(engine), "SomeFunction")
            @test functions(engine)["SomeFunction"] isa LLVM.Function

            res = LLVM.run(engine, functions(engine)["SomeFunction"])
            @test convert(Int, res) == 42
            dispose(res)
        end
    end
end

end

end
