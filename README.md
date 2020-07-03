# LLVM C API wrapper

*A Julia wrapper for the LLVM C API.*

| **Documentation**                                                         | **Build Status**                                                                                                                     | **Coverage**                    |
|:-------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------------------:|:-------------------------------:|
| [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][gitlab-img]][gitlab-url] [![][travis-img]][travis-url] [![][appveyor-img]][appveyor-url] [![PkgEval][pkgeval-img]][pkgeval-url] | [![][codecov-img]][codecov-url] |

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: http://maleadt.github.io/LLVM.jl/stable

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: http://maleadt.github.io/LLVM.jl/dev

[gitlab-img]: https://gitlab.com/JuliaGPU/LLVM.jl/badges/master/pipeline.svg
[gitlab-url]: https://gitlab.com/JuliaGPU/LLVM.jl/commits/master

[travis-img]: https://api.travis-ci.org/maleadt/LLVM.jl.svg?branch=master
[travis-url]: https://travis-ci.org/maleadt/LLVM.jl

[appveyor-img]: https://ci.appveyor.com/api/projects/status/5069m449yvvkyn9q/branch/master?svg=true
[appveyor-url]: https://ci.appveyor.com/project/maleadt/llvm-jl

[pkgeval-img]: https://juliaci.github.io/NanosoldierReports/pkgeval_badges/L/LLVM.svg
[pkgeval-url]: https://juliaci.github.io/NanosoldierReports/pkgeval_badges/L/LLVM.html

[codecov-img]: https://codecov.io/gh/maleadt/LLVM.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/maleadt/LLVM.jl

The LLVM.jl package is a Julia wrapper for the LLVM C API, and can be used to work with the
LLVM compiler framework from Julia. You can use the package to work with LLVM code generated
by Julia, to interoperate with the Julia compiler, or to create your own compiler. It is
heavily used by the different GPU compilers for the Julia programming language.


## Installation

LLVM.jl can be installed with the Julia package manager.
From the Julia REPL, type `]` to enter the Pkg REPL mode and run:

```
pkg> add LLVM
```

Or, equivalently, via the `Pkg` API:

```julia
julia> import Pkg; Pkg.add("LLVM")
```

Note that the package **is intended to be used with the LLVM library shipped with Julia**.
That means you can not use it with other LLVM libraries, like the one provided by your
operating system. It is recommended to use the official binaries from
[julialang.org](https://julialang.org/downloads/), but custom builds are supported too (as
long as they provide a dynamically-linked copy of the LLVM library).
