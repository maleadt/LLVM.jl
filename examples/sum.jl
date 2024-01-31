# https://pauladamsmith.com/blog/2015/01/how-to-get-started-with-llvm-c-api.html

using Test

using LLVM

if length(ARGS) == 2
    x, y = parse.([Int32], ARGS[1:2])
else
    x = Int32(1)
    y = Int32(2)
end

@dispose ctx=Context() begin
    # set-up
    mod = LLVM.Module("my_module")

    param_types = [LLVM.Int32Type(), LLVM.Int32Type()]
    ret_type = LLVM.Int32Type()
    fun_type = LLVM.FunctionType(ret_type, param_types)
    sum = LLVM.Function(mod, "sum", fun_type)

    # generate IR
    @dispose builder=IRBuilder() begin
        entry = BasicBlock(sum, "entry")
        position!(builder, entry)

        tmp = add!(builder, parameters(sum)[1], parameters(sum)[2], "tmp")
        ret!(builder, tmp)

        verify(mod)
    end

    # analysis and execution
    @dispose engine=Interpreter(mod) begin
        args = [GenericValue(LLVM.Int32Type(), x),
                GenericValue(LLVM.Int32Type(), y)]

        res = LLVM.run(engine, sum, args)
        @test convert(Int, res) == x + y

        dispose.(args)
        dispose(res)
    end
end
