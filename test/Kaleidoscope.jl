include(joinpath(@__DIR__, "..", "examples", "Kaleidoscope", "Kaleidoscope.jl"))

@testset "recursion" begin
    program = """
        def fib(x) {
            if x < 3 then
                1
            else
                fib(x-1) + fib(x-2)
        }

        def main() {
            fib(10)
        }
    """

    m = Kaleidoscope.generate_IR(program)
    m = Kaleidoscope.optimize!(m)
    v = Kaleidoscope.run(m)
    @test v == 55.0
    dispose(m)
end

@testset "loops" begin
    program = """
    def fib(x) {
        var a = 1, b = 1
        for i = 3, i < x, 1.0 {
            var c = a + b
            a = b
            b = c
        }
        b
    }

    def main() {
        fib(10)
    }
    """

    m = Kaleidoscope.generate_IR(program)
    m = Kaleidoscope.optimize!(m)
    v = Kaleidoscope.run(m)
    @test v == 55.0

    mktemp() do path, io
        Kaleidoscope.write_objectfile(m, path)
    end
    dispose(m)
end

@testset "global vars" begin
    program = """
    var x = 5
    var y = 3
    def foo(a b) a + b + x + y

    def main() foo(2, 3)
    """

    m = Kaleidoscope.generate_IR(program)
    m = Kaleidoscope.optimize!(m)
    v = Kaleidoscope.run(m)
    @test v == 13
    dispose(m)
end
