@testset "bitcode" begin

@dispose ctx=Context() begin
    invalid_bitcode = "invalid"
    @test_throws LLVMException parse(LLVM.Module, unsafe_wrap(Vector{UInt8}, invalid_bitcode))
end

@dispose ctx=Context() builder=IRBuilder() source_mod=LLVM.Module("SomeModule") begin
    ft = LLVM.FunctionType(LLVM.VoidType())
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


    bitcode = convert(Vector{UInt8}, source_mod)

    let
        mod = parse(LLVM.Module, bitcode)
        verify(mod)
        @test haskey(functions(mod), "SomeFunction")
        dispose(mod)
    end

    mktemp() do path, io
        mark(io)
        @test write(io, source_mod) > 0
        flush(io)
        reset(io)

        @test read(io) == bitcode
    end
end

end
