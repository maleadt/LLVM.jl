@testset "datalayout" begin

let ctx = Context()
let data = DataLayout("E-p:32:32-f128:128:128")
    @test string(data) == "E-p:32:32-f128:128:128"

    @test occursin("E-p:32:32-f128:128:128", sprint(io->show(io,data)))

    @test byteorder(data) == LLVM.API.LLVMBigEndian
    @test pointersize(data) == pointersize(data, 0) == 4

    @test intptr(data; ctx) == intptr(data, 0; ctx) == LLVM.Int32Type(ctx)

    @test sizeof(data, LLVM.Int32Type(ctx)) == storage_size(data, LLVM.Int32Type(ctx)) == abi_size(data, LLVM.Int32Type(ctx)) == 4

    @test abi_alignment(data, LLVM.Int32Type(ctx)) == frame_alignment(data, LLVM.Int32Type(ctx)) == preferred_alignment(data, LLVM.Int32Type(ctx)) == 4

    let mod = LLVM.Module("SomeModule"; ctx)
        gv = GlobalVariable(mod, LLVM.Int32Type(ctx), "SomeGlobal")
        @test preferred_alignment(data, gv) == 4

        datalayout!(mod, data)
        @test string(datalayout(mod)) == string(data)
    end

    elem = [LLVM.Int32Type(ctx), LLVM.FloatType(ctx)]
    let st = LLVM.StructType(elem; ctx)
        @test element_at(data, st, 4) == 1
        @test offsetof(data, st, 1) == 4
    end
end
end

end
