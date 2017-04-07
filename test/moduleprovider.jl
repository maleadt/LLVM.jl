@testset "moduleprovider" begin

Context() do ctx
let
    mod = LLVM.Module("SomeModule", ctx)
    mp = ModuleProvider(mod)
    dispose(mp)
end
end

Context() do ctx
let
    mod = LLVM.Module("SomeModule", ctx)
    ModuleProvider(mod) do mp

    end
end
end

end
