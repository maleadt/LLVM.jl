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

* Julia 0.7 or higher

```
Pkg.add("LLVM")
using LLVM

# optionally
Pkg.test("LLVM")
```

The package uses the LLVM library bundled with Julia. This is only possible when
the LLVM library is built dynamically (`USE_LLVM_SHLIB=1`), which has been the
default since Julia 0.5. Use of the system LLVM library is not possible; this
functionality has been removed from LLVM.jl starting with v1.0.
