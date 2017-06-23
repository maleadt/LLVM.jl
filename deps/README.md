Build script for LLVM.jl
========================

Building LLVM.jl is somewhat complicated, because of version compatibility and/or different
possible sources for Julia, LLVM, and wrappers for `libLLVM`.

The set-up consists of three main pieces:

- `discover.jl`
- `select.jl`
- `compile.jl`

Each of these phases have a main-like function, and can be run from the command-line for
debugging purposes. In practice, that won't happen, and there are two main entry-points:

- `build.jl`: for the package manager
- `buildbot.jl`: for the buildbot, taking a single destination directory as argument
