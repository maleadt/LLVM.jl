# Julia/LLVM interop

This section lists functionality for connecting Julia with LLVM.jl, e.g.
emitting code for the Julia JIT or creating types that are compatible with
Julia's global state.


## Base functionality

```@docs
Base.convert(::Type{LLVMType}, ::Type)
LLVM.Interop.create_function
LLVM.Interop.call_function
```


## Inline assembly

```@docs
LLVM.Interop.@asmcall
```


## LLVM type support

```@docs
LLVM.Interop.@typed_ccall
```
