@testitem "datalayout" begin

dlstr = "E-p:32:32-f128:128:128"

let
    data = DataLayout(dlstr)
    dispose(data)
end

DataLayout(dlstr) do data
end

@dispose ctx=Context() data=DataLayout(dlstr) begin
    @test string(data) == dlstr

    @test occursin(dlstr, sprint(io->show(io,data)))

    @test byteorder(data) == LLVM.API.LLVMBigEndian
    @test pointersize(data) == pointersize(data, 0) == 4

    @test intptr(data) == intptr(data, 0) == LLVM.Int32Type()

    @test sizeof(data, LLVM.Int32Type()) == storage_size(data, LLVM.Int32Type()) == abi_size(data, LLVM.Int32Type()) == 4

    @test abi_alignment(data, LLVM.Int32Type()) == frame_alignment(data, LLVM.Int32Type()) == preferred_alignment(data, LLVM.Int32Type()) == 4

    @dispose mod=LLVM.Module("SomeModule") begin
        gv = GlobalVariable(mod, LLVM.Int32Type(), "SomeGlobal")
        @test preferred_alignment(data, gv) == 4

        datalayout!(mod, data)
        @test string(datalayout(mod)) == string(data)
    end

    elem = [LLVM.Int32Type(), LLVM.FloatType()]
    let st = LLVM.StructType(elem)
        @test element_at(data, st, 4) == 1
        @test offsetof(data, st, 1) == 4
    end
end

end
