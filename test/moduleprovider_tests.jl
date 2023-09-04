@testitem "moduleprovider" begin

@dispose ctx=Context() begin
    mod = LLVM.Module("SomeModule")
    mp = ModuleProvider(mod)
    dispose(mp)

    @test "we didn't crash!" != ""
end

@dispose ctx=Context() begin
    mod = LLVM.Module("SomeModule")
    ModuleProvider(mod) do md
    end

    @test "we didn't crash!" != ""
end

@dispose ctx=Context() begin
    mod = LLVM.Module("SomeModule")
    @dispose mp=ModuleProvider(mod) begin
    end

    @test "we didn't crash!" != ""
end

end
