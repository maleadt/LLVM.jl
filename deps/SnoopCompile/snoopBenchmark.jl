using SnoopCompile


println("loading infer benchmark")

@snoopi_bench "LLVM" using LLVM


println("examples infer benchmark")

@snoopi_bench "LLVM" begin
    using LLVM
    examplePath = joinpath(dirname(dirname(pathof(LLVM))), "examples")
    include(joinpath(examplePath, "sum.jl"))
end
