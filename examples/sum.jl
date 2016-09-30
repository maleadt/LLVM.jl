# https://pauladamsmith.com/blog/2015/01/how-to-get-started-with-llvm-c-api.html

length(ARGS) == 2 || error("Usage: sum.jl INT INT")

using LLVM

# set-up
mod = LLVM.Module("my_module")

param_types = [LLVM.Int32Type(), LLVM.Int32Type()]
ret_type = LLVM.FunctionType(LLVM.Int32Type(), param_types)
sum = LLVM.Function(mod, "sum", ret_type)

# generate IR
Builder() do builder
    entry = BasicBlock(sum, "entry")
    position!(builder, entry)

    tmp = add!(builder, parameters(sum)[1], parameters(sum)[2], "tmp")
    ret!(builder, tmp)

    println(mod)
    verify(mod)
end

# analysis and execution
Interpreter(mod) do engine
    x, y = parse.([Int], ARGS[1:2])
    args = [GenericValue(LLVM.Int32Type(), x),
            GenericValue(LLVM.Int32Type(), y)]

    res = LLVM.run(engine, sum, args)
    println(convert(Int, res))

    dispose.(args)
    dispose(res)
end
