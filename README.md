LLVM C API wrapper
==================

<!-- [![LLVM](http://pkg.julialang.org/badges/LLVM_0.4.svg)](http://pkg.julialang.org/?pkg=LLVM&ver=0.4) -->
<!-- [![LLVM](http://pkg.julialang.org/badges/LLVM_0.5.svg)](http://pkg.julialang.org/?pkg=LLVM&ver=0.5) -->

Linux: [![Build Status](https://travis-ci.org/maleadt/LLVM.jl.svg?branch=master)](https://travis-ci.org/maleadt/LLVM.jl)

Code Coverage: [![Coverage Status](https://codecov.io/gh/maleadt/LLVM.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/maleadt/LLVM.jl)

This package provides a shallow wrapper around the LLVM C API.

The entire API, wrapped by means of [Clang.jl](https://github.com/ihnorton/Clang.jl/), is
available in the `LLVM.API` submodule. Higher-level wrappers are part of the `LLVM`
top-level module, and are added as the need arises (see [COVERAGE.md](COVERAGE.md) for a
list of wrapped functions).


Installation
------------

Version requirements:

* LLVM 3.9 or higher, in full (ie. not only `libLLVM.so`, but also `llvm-config`, headers,
  etc)
* Julia 0.5 or higher
* C++ compiler

Either install the package using `Pkg`, or manually run `deps/build.jl` which detects
available LLVM installations (a version can be pinned by defining the `LLVM_VERSION`
environment variable). Define the `DEBUG` environment variable for more verbose printing.
