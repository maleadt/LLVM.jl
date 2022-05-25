@testset "moduleprovider" begin

let ctx = Context()
let
    mod = LLVM.Module("SomeModule"; ctx)
    mp = ModuleProvider(mod)
end
end

end
