## generic value

let
    val = GenericValue(LLVM.Int32Type(), -1)
    @test convert(Int, val) == -1
    dispose(val)
end

let
    val = GenericValue(LLVM.Int32Type(), UInt(1))
    @test convert(UInt, val) == 1
    dispose(val)
end

let
    val = GenericValue(LLVM.DoubleType(), 1.1)
    @test convert(Float64, val, LLVM.DoubleType()) == 1.1
    dispose(val)
end

let
    obj = "whatever"
    val = GenericValue(pointer(obj))
    @test convert(Ptr{Void}, val) == pointer(obj)
    dispose(val)
end


## execution engine

function emit_sum(ctx::Context)
    mod = LLVM.Module("sum_module", ctx)

    param_types = [LLVM.Int32Type(ctx), LLVM.Int32Type(ctx)]
    ret_type = LLVM.FunctionType(LLVM.Int32Type(ctx), param_types)

    sum = LLVM.Function(mod, "sum", ret_type)

    entry = BasicBlock(sum, "entry")

    Builder(ctx) do builder
        position!(builder, entry)

        tmp = add!(builder, parameters(sum)[1], parameters(sum)[2])
        ret!(builder, tmp)

        verify(mod)
    end

    return mod, sum
end

Context() do ctx
    mod, sum = emit_sum(ctx)
    link_jit()

    engine = ExecutionEngine(mod)

    args = [GenericValue(LLVM.Int32Type(), 1),
            GenericValue(LLVM.Int32Type(), 2)]

    res = LLVM.run(engine, sum, args)
    @test convert(Int, res) == 3

    dispose.(args)
    dispose(res)
    dispose(mod)
end
