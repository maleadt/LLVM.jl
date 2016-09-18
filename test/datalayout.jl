Context() do ctx
DataLayout("E-p:32:32-f128:128:128") do data
    @test convert(String, data) == "E-p:32:32-f128:128:128"

    @test byteorder(data) == LLVM.API.LLVMBigEndian
    @test pointersize(data) == pointersize(data, 0) == 4

    @test intptr(data) == intptr(data, 0) == LLVM.Int32Type()
    @test intptr(data, ctx) == intptr(data, 0, ctx) == LLVM.Int32Type(ctx)

    @test sizeof(data, LLVM.Int32Type()) == storage_size(data, LLVM.Int32Type()) == abi_size(data, LLVM.Int32Type()) == 4

    @test abi_alignment(data, LLVM.Int32Type()) == frame_alignment(data, LLVM.Int32Type()) == preferred_alignment(data, LLVM.Int32Type()) == 4

    LLVM.Module("SomeModule") do mod
        gv = GlobalVariable(mod, LLVM.Int32Type(), "SomeGlobal")
        @test preferred_alignment(data, gv) == 4

        datalayout!(mod, data)
        @test convert(String, datalayout(mod)) == convert(String, data)
    end

    elem = [LLVM.Int32Type(ctx), LLVM.FloatType(ctx)]
    let st = LLVM.StructType(elem, ctx)
        @test element_at(data, st, 4) == 1
        @test offsetof(data, st, 1) == 4
    end
end
end