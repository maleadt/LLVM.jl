using Documenter, LLVM

makedocs(
    modules = [LLVM],
    format = Documenter.HTML(),
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
    doctest = true
)

deploydocs(
    repo = "github.com/maleadt/LLVM.jl.git"
)
