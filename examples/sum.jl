# https://pauladamsmith.com/blog/2015/01/how-to-get-started-with-llvm-c-api.html

using Test

using LLVM

if length(ARGS) == 2
    x, y = parse.([Int32], ARGS[1:2])
else
    x = Int32(1)
    y = Int32(2)
end

let ctx = Context()
    # set-up
    mod = LLVM.Module("my_module"; ctx)

    param_types = [LLVM.Int32Type(ctx), LLVM.Int32Type(ctx)]
    ret_type = LLVM.Int32Type(ctx)
    fun_type = LLVM.FunctionType(ret_type, param_types)
    sum = LLVM.Function(mod, "sum", fun_type)

    # generate IR
    let builder = Builder(ctx)
        entry = BasicBlock(sum, "entry"; ctx)
        position!(builder, entry)

        tmp = add!(builder, parameters(sum)[1], parameters(sum)[2], "tmp")
        ret!(builder, tmp)

        println(mod)
        verify(mod)
    end

    # analysis and execution
    let engine = Interpreter(mod)
        args = [GenericValue(LLVM.Int32Type(ctx), x),
                GenericValue(LLVM.Int32Type(ctx), y)]

        res = LLVM.run(engine, sum, args)
        @test convert(Int, res) == x + y
    end
end
