# Kaleidoscope

This contains an implmentation of a toy programming language, heavily inspired by the [Kaleidoscope tutorial](https://llvm.org/docs/tutorial/), using LLVM.jl.
It has basic support for functions, global variables, loops, mutable variables, if statements. The only data type used is `double`.


Some examples:

#### Recursion and conditionals

```
def fib(x) {
    if x < 3 then
        1
    else
        fib(x-1) + fib(x-2)
  }
```

#### Loops and mutating variables
```
def fib(x) {
    var a = 1, b = 1
    for i = 3, i < x {
        c = a + b
        a = b
        b = c
    }
    b
}
```

#### Global variables

```
var x = 10
def foo(y z) x + y + z
```

The LLVM IR is generated using `Kaleidoscope.generate_IR(::String)` where the argument is the source code.
This returns an (unoptimized) LLVM `Module`. Optimizations can be run on the module with `Kaleidoscope.optimize!(::LLVM.Module)`.

The module can be written to an object file using `Kaleidoscope.write_objectfile(::LLVM.Module, ::String)` where the `String` is the file to write to.
This object file can then be linked with e.g. a C program.

The module can be executed directly in Julia using `Kaleidoscope.run(::LLVM.Module)`. This will look for a function `main()` in the code and execute it. The return value of the main function is returned from `run` as a `Float64`.

