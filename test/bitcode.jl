MemoryBuffer("invalid", "invalid") do membuf
    @test_throws LLVMException parse(LLVM.Module, membuf)
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
    

    membuf = convert(MemoryBuffer, source_mod)

    let
        mod = parse(LLVM.Module, membuf)
        verify(mod)
        @test haskey(functions(mod), "SomeFunction")
        dispose(mod)
    end

    let
        mod = parse(LLVM.Module, membuf, ctx)
        verify(mod)
        @test haskey(functions(mod), "SomeFunction")
        dispose(mod)
    end

    mktemp() do path, io
        mark(io)
        write(io, source_mod)
        flush(io)
        reset(io)

        @test read(io) == convert(Vector{UInt8}, membuf)
    end
end
end
end
