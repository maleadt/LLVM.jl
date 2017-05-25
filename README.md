LLVM C API wrapper
==================

**Build status**: 

- LLVM 3.9: 
[![](https://ci.maleadt.net/buildbot/julia/badge.svg?builder=LLVM.jl%3A%20Julia%200.5%2C%20system%20LLVM%203.9%20%28x86-64%29&badge=Julia%20v0.5)](https://ci.maleadt.net/buildbot/julia/builders/LLVM.jl%3A%20Julia%200.5%2C%20system%20LLVM%203.9%20%28x86-64%29)
[![](https://ci.maleadt.net/buildbot/julia/badge.svg?builder=LLVM.jl%3A%20Julia%200.6%2C%20system%20LLVM%203.9%20%28x86-64%29&badge=Julia%20v0.6)](https://ci.maleadt.net/buildbot/julia/builders/LLVM.jl%3A%20Julia%200.6%2C%20system%20LLVM%203.9%20%28x86-64%29)
- LLVM 4.0: 
[![](https://ci.maleadt.net/buildbot/julia/badge.svg?builder=LLVM.jl%3A%20Julia%200.6%2C%20system%20LLVM%204.0%20%28x86-64%29&badge=Julia%20v0.6)](https://ci.maleadt.net/buildbot/julia/builders/LLVM.jl%3A%20Julia%200.6%2C%20system%20LLVM%204.0%20%28x86-64%29)
- LLVM 5.0: 
[![](https://ci.maleadt.net/buildbot/julia/badge.svg?builder=LLVM.jl%3A%20Julia%200.6%2C%20system%20LLVM%205.0%20%28x86-64%29&badge=Julia%20v0.6)](https://ci.maleadt.net/buildbot/julia/builders/LLVM.jl%3A%20Julia%200.6%2C%20system%20LLVM%205.0%20%28x86-64%29)
- embedded:
[![](https://ci.maleadt.net/buildbot/julia/badge.svg?builder=LLVM.jl%3A%20Julia%200.6%2C%20embedded%20LLVM%20%28x86-64%29&badge=Julia%20v0.6)](https://ci.maleadt.net/buildbot/julia/builders/LLVM.jl%3A%20Julia%200.6%2C%20embedded%20LLVM%20%28x86-64%29)
[![](https://ci.maleadt.net/buildbot/julia/badge.svg?builder=LLVM.jl%3A%20Julia%20master%2C%20embedded%20LLVM%20%28x86-64%29&badge=Julia%20master)](https://ci.maleadt.net/buildbot/julia/builders/LLVM.jl%3A%20Julia%20master%2C%20embedded%20LLVM%20%28x86-64%29)

**Code coverage**: [![Coverage Status](https://codecov.io/gh/maleadt/LLVM.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/maleadt/LLVM.jl)

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



Troubleshooting
---------------

You can enable verbose logging using two environment variables:

* `DEBUG`: if set, enable additional (possibly costly) run-time checks, and some more
  verbose output
* `TRACE`: if set, the `DEBUG` level will be activated, in addition with a trace of every
  call to the underlying library

In order to avoid run-time cost for checking the log level, these flags are implemented by
means of global constants. As a result, you **need to run Julia with precompilation
disabled** if you want to modify these flags:

```
$ TRACE=1 julia --compilecache=no examples/sum.jl 1 2
TRACE: LLVM.jl is running in trace mode, this will generate a lot of additional output
...
```

Enabling colors with `--color=yes` is also recommended as it color-codes the output.

### Windows support from a binary build (experimental)
https://bintray.com/artifact/download/tkelman/generic/llvm-3.9.1-x86_64-w64-mingw32-juliadeps-r04.7z
- extract using 7z
- copy llvm-contrib.exe from the usr/tools directory to JULIA_HOME
- copy libLLVM.dll either from the usr/bin directory or JULIA_HOME to the directory JULIA_HOME/../lib directory
	(necessary because llvm-config.exe --libdir reports that this the library directory)
- copy the contents of the usr/lib  (except for the cmake folder) to the JULIA_HOME/../lib directory
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
