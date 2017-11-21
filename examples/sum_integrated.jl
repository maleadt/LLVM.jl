# same as `sum.jl`, but reusing the Julia compiler to compile and execute the IR

using LLVM
LLVM.libllvm_system && exit() # cannot run this example if we have our own copy of LLVM
using LLVM.Interop

if length(ARGS) == 2
    x, y = parse.([Int32], ARGS[1:2])
else
    x = Int32(1)
    y = Int32(2)
end

# set-up
mod = LLVM.Module("my_module", JuliaContext())

param_types = [LLVM.Int32Type(JuliaContext()), LLVM.Int32Type(JuliaContext())]
ret_type = LLVM.Int32Type(JuliaContext())
sum, _ = create_function(ret_type, param_types)

# generate IR
Builder(JuliaContext()) do builder
    entry = BasicBlock(sum, "entry", JuliaContext())
    position!(builder, entry)

    tmp = add!(builder, parameters(sum)[1], parameters(sum)[2], "tmp")
    ret!(builder, tmp)

    println(mod)
    verify(mod)
end

# make Julia compile and execute the function
push!(function_attributes(sum), EnumAttribute("alwaysinline"))
call_sum(x, y) = Base.llvmcall(LLVM.ref(sum), Int32, Tuple{Int32, Int32}, x, y)
@show call_sum(x, y)
