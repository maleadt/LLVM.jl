LLVM C API wrapper
==================

<!-- [![LLVM](http://pkg.julialang.org/badges/LLVM_0.4.svg)](http://pkg.julialang.org/?pkg=LLVM&ver=0.4) -->
<!-- [![LLVM](http://pkg.julialang.org/badges/LLVM_0.5.svg)](http://pkg.julialang.org/?pkg=LLVM&ver=0.5) -->

Linux: [![Build Status](https://travis-ci.org/maleadt/LLVM.jl.svg?branch=master)](https://travis-ci.org/maleadt/LLVM.jl)

Code Coverage: [![Coverage Status](https://codecov.io/gh/maleadt/LLVM.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/maleadt/LLVM.jl)

This package provides a shallow wrapper around the LLVM C API. The API, wrapped by means of
[Clang.jl](https://github.com/ihnorton/Clang.jl/), is available in the `LLVM.API` module.
Higher-level wrappers will be added to the `LLVM` module as the need arises.
