LLVM C API wrapper
==================

*A Julia wrapper for the LLVM C API.*

**Build status**: [![][gitlab-img]][gitlab-url] [![][travis-img]][travis-url] [![][appveyor-img]][appveyor-url]

**Code coverage**: [![][codecov-img]][codecov-url]

**Documentation**: [![][docs-stable-img]][docs-stable-url] [![][docs-latest-img]][docs-latest-url]

[gitlab-img]: https://gitlab.com/JuliaGPU/LLVM.jl/badges/master/pipeline.svg
[gitlab-url]: https://gitlab.com/JuliaGPU/LLVM.jl/pipelines

[travis-img]: https://travis-ci.org/maleadt/LLVM.jl.svg?branch=master
[travis-url]: https://travis-ci.org/maleadt/LLVM.jl

[appveyor-img]: https://ci.appveyor.com/api/projects/status/5069m449yvvkyn9q/branch/master?svg=true
[appveyor-url]: https://ci.appveyor.com/project/maleadt/llvm-jl

[codecov-img]: https://codecov.io/gh/maleadt/LLVM.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/maleadt/LLVM.jl

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: http://maleadt.github.io/LLVM.jl/stable
[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-latest-url]: http://maleadt.github.io/LLVM.jl/latest


Installation
------------

LLVM.jl is a registered package, and can be installed using the Julia package manager:

```julia
Pkg.add("LLVM")
```

**NOTE**: the current version of this package requires Julia 0.7. Only older
versions of this package, v0.5.x, work with Julia 0.6, and require a
**source-build** of Julia.


License
-------

LLVM.jl is licensed under the [NCSA license](LICENSE.md).

If you use this package in your research, please cite the [following
paper](https://ieeexplore.ieee.org/document/8471188):

```
@article{besard:2017,
  author    = {Besard, Tim and Foket, Christophe and De Sutter, Bjorn},
  title     = {Effective Extensible Programming: Unleashing {Julia} on {GPUs}},
  journal   = {IEEE Transactions on Parallel and Distributed Systems},
  year      = {2018},
  doi       = {10.1109/TPDS.2018.2872064},
  ISSN      = {1045-9219},
}
```
