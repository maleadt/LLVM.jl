LLVM C API wrapper
==================

*A Julia wrapper for the LLVM C API.*

**Build status**: [![][travis-img]][travis-url] [![][appveyor-img]][appveyor-url]

**Documentation**: [![][docs-stable-img]][docs-stable-url] [![][docs-latest-img]][docs-latest-url]

**Code coverage**: [![][coverage-img]][coverage-url]

[travis-img]: https://travis-ci.org/maleadt/LLVM.jl.svg?branch=master
[travis-url]: https://travis-ci.org/maleadt/LLVM.jl

[appveyor-img]: https://ci.appveyor.com/api/projects/status/5069m449yvvkyn9q/branch/master?svg=true
[appveyor-url]: https://ci.appveyor.com/project/maleadt/llvm-jl

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: http://maleadt.github.io/LLVM.jl/stable
[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-latest-url]: http://maleadt.github.io/LLVM.jl/latest

[coverage-img]: https://codecov.io/gh/maleadt/LLVM.jl/coverage.svg
[coverage-url]: https://codecov.io/gh/maleadt/LLVM.jl



Installation
------------

LLVM.jl is a registered package, and can be installed using the Julia package manager:

```julia
Pkg.add("LLVM")
```

**NOTE**: the current version of this package requires Julia 0.7. Only older
versions of this package, v0.5.x, work with Julia 0.6, and require a
**source-build** of Julia.
