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
overridden by defining `USE_SYSTEM_LLVM`. However, that option is experimental and likely to
break. Your best bet is to build Julia from source, and run it from the build tree **without
running `make install`**. Binary versions of Julia are not compatible with LLVM.jl.

If installation fails, re-run the failing steps with the `DEBUG` environment variable set to
`1` and attach that output to a bug report:

```
$ DEBUG=1 julia
julia> Pkg.build("LLVM")
...
```


### System-provided LLVM

Loading LLVM.jl with a system-provided LLVM library is an experimental option, only
supported on Linux, and partially cripples functionality of this package. The problem stems
from how loading multiple copies of LLVM makes global symbols clash (despite using
`RTLD_LOCAL|RTLD_DEEPBIND`), corrupting the state of either library when performing certain
calls like `LLVMShutdown`.

On Linux, we have `dlmopen` to load the LLVM library in a separate library namespace
[^apple]. However, this newly created namespace is completely empty, and does not include
`libjulia` either. As a result, we cannot call back into the compiler, breaking
functionality such as the Julia-callbacks for LLVM passes.

[^apple]: This is supposed to work on macOS too, but I haven't been able to get it working.
    Certain lookups resolve across libraries, despite using `RTLD_DEEPBIND`:

    ```
    frame 0: libsystem_malloc.dylib  malloc_error_break
    frame 1: libsystem_malloc.dylib  free
    frame 2: libLLVM-3.7.dylib       llvm::DenseMapBase<...>*)
    frame 3: libLLVM-3.7.dylib       unsigned int llvm::DFSPass<...>::NodeType*, unsigned int)
    frame 4: libLLVM-3.7.dylib       void llvm::Calculate<...>&, llvm::Function&)
    frame 5: libLLVM.dylib           (anonymous namespace)::Verifier::verify(llvm::Function const&)
    frame 6: libLLVM.dylib           llvm::verifyModule(llvm::Module const&, llvm::raw_ostream*, bool*)
    frame 7: libLLVM.dylib           LLVMVerifyModule
    ```
