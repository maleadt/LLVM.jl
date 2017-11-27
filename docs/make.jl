using Documenter, LLVM

const test = haskey(ENV, "TEST")    # are we running as part of the test suite?

makedocs(
    modules = [LLVM],
    format = :html,
    sitename = "LLVM.jl",
    pages = [
        "Home"    => "index.md",
        "Manual"  => [
            "man/usage.md",
            "man/troubleshooting.md"
        ],
        "Library" => [
            "lib/api.md",
            "lib/interop.md"
        ]
    ],
    doctest = test
)

test || deploydocs(
    repo = "github.com/maleadt/LLVM.jl.git",
    julia = "nightly",
    # no need to build anything here, re-use output of `makedocs`
    target = "build",
    deps = nothing,
    make = nothing
)
