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
        var c = a + b
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

The LLVM IR is generated using `Kaleidoscope.generate_IR(::String, ::Context)` where the first argument is the source code and the second an LLVM `Context`.
This returns an (unoptimized) LLVM `Module`. A chosen set of optimization passes can be run on the module with `Kaleidoscope.optimize!(::LLVM.Module)`.

The module can be written to an object file using `Kaleidoscope.write_objectfile(::LLVM.Module, ::String)` where the `String` is the file to write to.
This object file can then be linked with e.g. a C program.

The module can be executed directly in Julia using `Kaleidoscope.run(::LLVM.Module, entry::String)`. This will look for an entry function in the code and execute it. The return value of the entry function is returned from `run` as a `Float64`. After the module is executed, it is no longer valid.

# Possible future work

* Store line / column in each token and give better error messages.
* Add support for more types than double.
