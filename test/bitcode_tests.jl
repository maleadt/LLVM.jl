@testitem "bitcode" begin

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


    @dispose bitcode_buf = convert(MemoryBuffer, source_mod) begin
        @dispose mod=parse(LLVM.Module, bitcode_buf) begin
            verify(mod)
            @test haskey(functions(mod), "SomeFunction")
        end
    end


    let bitcode = convert(Vector{UInt8}, source_mod)
        @dispose mod = parse(LLVM.Module, bitcode) begin
            verify(mod)
            @test haskey(functions(mod), "SomeFunction")
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

end
