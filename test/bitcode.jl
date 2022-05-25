@testset "bitcode" begin

let ctx = Context()
    invalid_bitcode = "invalid"
    @test_throws LLVMException parse(LLVM.Module, unsafe_wrap(Vector{UInt8}, invalid_bitcode); ctx)
end

let ctx = Context()
let builder = Builder(ctx)
let source_mod = LLVM.Module("SomeModule"; ctx)
    ft = LLVM.FunctionType(LLVM.VoidType(ctx))
    fn = LLVM.Function(source_mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry"; ctx)
    position!(builder, entry)

    ret!(builder)

    verify(source_mod)


    bitcode_buf = convert(MemoryBuffer, source_mod)

    let
        mod = parse(LLVM.Module, bitcode_buf; ctx)
        verify(mod)
        @test haskey(functions(mod), "SomeFunction")
    end


    bitcode = convert(Vector{UInt8}, source_mod)

    let
        mod = parse(LLVM.Module, bitcode; ctx)
        verify(mod)
        @test haskey(functions(mod), "SomeFunction")
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
