@testset "bitcode" begin

let
    invalid_bitcode = "invalid"
    @test_throws LLVMException parse(LLVM.Module, unsafe_wrap(Vector{UInt8}, invalid_bitcode))
end

Context() do ctx
Builder(ctx) do builder
LLVM.Module("SomeModule", ctx) do source_mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx))
    fn = LLVM.Function(source_mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry")
    position!(builder, entry)

    ret!(builder)

    verify(source_mod)


    bitcode_buf = convert(MemoryBuffer, source_mod)

    let
        mod = parse(LLVM.Module, bitcode_buf)
        verify(mod)
        @test haskey(functions(mod), "SomeFunction")
        dispose(mod)
    end

    let
        mod = parse(LLVM.Module, bitcode_buf, ctx)
        verify(mod)
        @test haskey(functions(mod), "SomeFunction")
        dispose(mod)
    end


    bitcode = convert(Vector{UInt8}, source_mod)

    let
        mod = parse(LLVM.Module, bitcode)
        verify(mod)
        @test haskey(functions(mod), "SomeFunction")
        dispose(mod)
    end

    let
        mod = parse(LLVM.Module, bitcode, ctx)
        verify(mod)
        @test haskey(functions(mod), "SomeFunction")
        dispose(mod)
    end

    mktemp() do path, io
        mark(io)
        write(io, source_mod)
        flush(io)
        reset(io)

        @test read(io) == bitcode
    end
end
end
end

end
