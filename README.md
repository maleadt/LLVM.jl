LLVM C API wrapper
==================

*A Julia wrapper for the LLVM C API.*

**Build status**: 

- LLVM 3.9: 
[![][buildbot-julia06-llvm39-img]][buildbot-julia06-llvm39-url]
- LLVM 4.0: 
[![][buildbot-julia06-llvm40-img]][buildbot-julia06-llvm40-url]
- LLVM 5.0: 
[![][buildbot-julia06-llvm50-img]][buildbot-julia06-llvm50-url]
- embedded:
[![][buildbot-julia06-img]][buildbot-julia06-url]
[![][buildbot-juliadev-img]][buildbot-juliadev-url]

**Documentation**: [![][docs-stable-img]][docs-stable-url] [![][docs-latest-img]][docs-latest-url]

**Code coverage**: [![][coverage-img]][coverage-url]

[buildbot-julia06-llvm39-img]: http://ci.maleadt.net/shields/build.php?builder=LLVM-julia06-llvm39-x86-64bit&name=julia%200.6
[buildbot-julia06-llvm39-url]: http://ci.maleadt.net/shields/url.php?builder=LLVM-julia06-llvm39-x86-64bit

[buildbot-julia06-llvm40-img]: http://ci.maleadt.net/shields/build.php?builder=LLVM-julia06-llvm40-x86-64bit&name=julia%200.6
[buildbot-julia06-llvm40-url]: http://ci.maleadt.net/shields/url.php?builder=LLVM-julia06-llvm40-x86-64bit

[buildbot-julia06-llvm50-img]: http://ci.maleadt.net/shields/build.php?builder=LLVM-julia06-llvm50-x86-64bit&name=julia%200.6
[buildbot-julia06-llvm50-url]: http://ci.maleadt.net/shields/url.php?builder=LLVM-julia06-llvm50-x86-64bit

[buildbot-julia06-img]: http://ci.maleadt.net/shields/build.php?builder=LLVM-julia06-x86-64bit&name=julia%200.6
[buildbot-julia06-url]: http://ci.maleadt.net/shields/url.php?builder=LLVM-julia06-x86-64bit
[buildbot-juliadev-img]: http://ci.maleadt.net/shields/build.php?builder=LLVM-juliadev-x86-64bit&name=julia%20dev
[buildbot-juliadev-url]: http://ci.maleadt.net/shields/url.php?builder=LLVM-juliadev-x86-64bit

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

However, in most cases **you need a source-build of Julia**. Refer to [the
documentation][docs-stable-url] for more information on how to install or use this package.
