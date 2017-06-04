# LLVM.jl

*A Julia wrapper for the LLVM C API.*

This package provides a shallow wrapper around the LLVM C API. The entire API, wrapped by
means of [Clang.jl](https://github.com/ihnorton/Clang.jl/), is available in the `LLVM.API`
submodule. Higher-level wrappers are part of the `LLVM` top-level module, and are added as
the need arises (see
[COVERAGE.md](https://github.com/maleadt/LLVM.jl/blob/master/COVERAGE.md) for a list of
wrapped functions).


## Installation

Requirements:

* LLVM 3.9 or higher, in full (ie. not only `libLLVM.so`, but also `llvm-config`, headers,
  etc)
* Julia 0.5 or higher
* C++ compiler, and possibly some development headers (like `libz1`, `zlib1g-dev` on many
  popular Linux distributions)

```
Pkg.add("LLVM")
Pkg.test("LLVM")
```

The build step (executed by `Pkg.add`) detects available LLVM installations and builds a
library with additional API functions. The best matching installation of LLVM will be
selected, but any version can be forced by setting the `LLVM_VER` environment variable at
build time. The script will only load LLVM libraries bundled with Julia, but that can be
overridden by defining `USE_SYSTEM_LLVM`.

**IMPORTANT NOTE**: `USE_SYSTEM_LLVM` is an experimental option, and not supported on all
platforms. Meanwhile, even though Julia 0.5 is supported, the bundled LLVM 3.7 is not
compatible with LLVM.jl. The best option is to build Julia 0.6 from source, which results in
a compatible LLVM 3.9 without the dangers of `USE_SYSTEM_LLVM`. **Do not** `make install`
Julia, but run it from the folder you've compiled it in. Binary versions of Julia 0.6 are
not yet compatible because they don't provide the necessary build artifacts.

If installation fails, re-run the failing steps with the `DEBUG` environment variable set to
`1` and attach that output to a bug report:

```
$ DEBUG=1 julia
julia> Pkg.build("LLVM")
...
```
