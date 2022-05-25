@testset "moduleprovider" begin

@dispose ctx=Context() begin
    mod = LLVM.Module("SomeModule"; ctx)
    mp = ModuleProvider(mod)
    dispose(mp)
end

@dispose ctx=Context() begin
    mod = LLVM.Module("SomeModule"; ctx)
    ModuleProvider(mod) do md
    end
end

@dispose ctx=Context() begin
    mod = LLVM.Module("SomeModule"; ctx)
    @dispose mp=ModuleProvider(mod) begin

    end
end

end
