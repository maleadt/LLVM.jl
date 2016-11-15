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
* C++ compiler, and possibly some development headers (like `libz1`, `zlib1g-dev` on many
  popular Linux distributions)

Either install the package using `Pkg`, or manually clone it and run `deps/build.jl` which
detects available LLVM installations and builds a library with additional API functions. The
best matching installation of LLVM will be selected, but any version can be forced by
setting the `LLVM_VER` environment variable at build time. The script will only load LLVM
libraries bundled with Julia, but that can be overridden by defining `USE_SYSTEM_LLVM`.

If installation fails, re-run with the `DEBUG` environment variable set to `1` (as well as
running Julia with `--compilecache=no`), and attach that output to a bug report.


Troubleshooting
---------------

### Building `llvm-extra` fails due to C++11 ABI issues

The build step might fail at building the `llvm-extra` wrapper with errors like the
following:

```
IR/Pass.o:(.data.rel.ro._ZTVN4llvm15JuliaModulePassE[_ZTVN4llvm15JuliaModulePassE]+0x40): undefined reference to `llvm::ModulePass::createPrinterPass(llvm::raw_ostream&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) const'
IR/Pass.o:(.data.rel.ro._ZTVN4llvm17JuliaFunctionPassE[_ZTVN4llvm17JuliaFunctionPassE]+0x40): undefined reference to `llvm::FunctionPass::createPrinterPass(llvm::raw_ostream&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) const'
IR/Pass.o:(.data.rel.ro._ZTVN4llvm19JuliaBasicBlockPassE[_ZTVN4llvm19JuliaBasicBlockPassE]+0x40): undefined reference to `llvm::BasicBlockPass::createPrinterPass(llvm::raw_ostream&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) const'
collect2: error: ld returned 1 exit status
```

```
IR/Pass.o:(.data.rel.ro._ZTVN4llvm15JuliaModulePassE[_ZTVN4llvm15JuliaModulePassE]+0x40): undefined reference to `llvm::ModulePass::createPrinterPass(llvm::raw_ostream&, std::string const&) const'
IR/Pass.o:(.data.rel.ro._ZTVN4llvm17JuliaFunctionPassE[_ZTVN4llvm17JuliaFunctionPassE]+0x40): undefined reference to `llvm::FunctionPass::createPrinterPass(llvm::raw_ostream&, std::string const&) const'
IR/Pass.o:(.data.rel.ro._ZTVN4llvm19JuliaBasicBlockPassE[_ZTVN4llvm19JuliaBasicBlockPassE]+0x40): undefined reference to `llvm::BasicBlockPass::createPrinterPass(llvm::raw_ostream&, std::string const&) const'
collect2: error: ld returned 1 exit status
```

These indicate a mismatch between the C++ ABI of the LLVM library (more specifically, caused
by [the C++11 ABI change](https://gcc.gnu.org/wiki/Cxx11AbiCompatibility)), and what your
compiler selects by default. The `Makefile` in this package tries to detect any C++11 ABI
symbols in the selected LLVM library and configures GLIBC accordingly, but this detection
might fail when `objdump` is not available on your system, or might not help if the target
compiler doesn't support said ABI.

Most if these issues can be fixed by using the same compiler LLVM was build with to compile
`llvm-extra`. You can override the selected compiler by defining the `CC` and `CXX`
environment variables, eg. `CC=clang CXX=clang++ julia -e 'Pkg.build("LLVM")'`.
