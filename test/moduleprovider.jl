@testset "moduleprovider" begin

@dispose ctx=Context() begin
    mod = LLVM.Module("SomeModule")
    mp = ModuleProvider(mod)
    dispose(mp)
end

@dispose ctx=Context() begin
    mod = LLVM.Module("SomeModule")
    ModuleProvider(mod) do md
    end
end

@dispose ctx=Context() begin
    mod = LLVM.Module("SomeModule")
    @dispose mp=ModuleProvider(mod) begin

    end
end

end
