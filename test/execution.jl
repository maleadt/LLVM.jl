@testset "execution" begin

@testset "generic values" begin

let
    val = GenericValue(LLVM.Int32Type(), -1)
    @test intwidth(val) == 32
    @test convert(Int, val) == -1
    dispose(val)
end

let
    val = GenericValue(LLVM.Int32Type(), UInt(1))
    @test convert(Int, val) == 1
    @test convert(UInt, val) == 1
    dispose(val)
end

let
    val = GenericValue(LLVM.DoubleType(), Float32(1.1))
    @test convert(Float32, val, LLVM.DoubleType()) == Float32(1.1)
    @test convert(Float64, val, LLVM.DoubleType()) == Float64(Float32(1.1))
    dispose(val)
end

let
    val = GenericValue(LLVM.DoubleType(), 1.1)
    @test convert(Float32, val, LLVM.DoubleType()) == Float32(1.1)
    @test convert(Float64, val, LLVM.DoubleType()) == 1.1
    dispose(val)
end

let
    obj = "whatever"
    val = GenericValue(pointer(obj))
    @test convert(Ptr{Void}, val) == pointer(obj)
    dispose(val)
end

end


@testset "execution engine" begin

Context() do ctx
    mod = LLVM.Module("SomeModule", ctx)
    ExecutionEngine(mod) do mod end
end

function emit_sum(ctx::Context)
    mod = LLVM.Module("SomeModule", ctx)

    param_types = [LLVM.Int32Type(ctx), LLVM.Int32Type(ctx)]
    ret_type = LLVM.FunctionType(LLVM.Int32Type(ctx), param_types)

    sum = LLVM.Function(mod, "SomeFunction", ret_type)

    entry = BasicBlock(sum, "entry")

    Builder(ctx) do builder
        position!(builder, entry)

        tmp = add!(builder, parameters(sum)[1], parameters(sum)[2])
        ret!(builder, tmp)

        verify(mod)
    end

    return mod
end

function emit_retint(ctx::Context, val)
    mod = LLVM.Module("SomeModule", ctx)

    ret_type = LLVM.FunctionType(LLVM.Int32Type(ctx))

    fn = LLVM.Function(mod, "SomeFunction", ret_type)

    entry = BasicBlock(fn, "entry")

    Builder(ctx) do builder
        position!(builder, entry)

        ret!(builder, ConstantInt(LLVM.Int32Type(ctx), val))

        verify(mod)
    end

    return mod
end

Context() do ctx
    mod = emit_sum(ctx)

    args = [GenericValue(LLVM.Int32Type(), 1),
            GenericValue(LLVM.Int32Type(), 2)]

    let mod = LLVM.Module(mod)
        fn = functions(mod)["SomeFunction"]
        Interpreter(mod) do engine
            res = LLVM.run(engine, fn, args)
            @test convert(Int, res) == 3
            dispose(res)
        end
    end

    dispose.(args)

    let mod = emit_retint(ctx, 42)
        fn = functions(mod)["SomeFunction"]
        JIT(mod) do engine
            res = LLVM.run(engine, fn)
            @test convert(Int, res) == 42
            dispose(res)
        end
    end

    let mod = emit_retint(ctx, 42)
        fn = functions(mod)["SomeFunction"]
        ExecutionEngine(mod) do engine
            res = LLVM.run(engine, fn)
            @test convert(Int, res) == 42
            dispose(res)
        end
    end
end

end

end
