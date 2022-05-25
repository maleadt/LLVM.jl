@testset "ir" begin

let ctx = Context()
    invalid_ir = "invalid"
    @test_throws LLVMException parse(LLVM.Module, invalid_ir; ctx)
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


    ir = string(source_mod)

    let
        mod = parse(LLVM.Module, ir; ctx)
        verify(mod)
        @test haskey(functions(mod), "SomeFunction")
    end
end
end
end

end
