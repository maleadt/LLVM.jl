
## context

global_ctx = GlobalContext()

let
    ctx = Context()
    @assert ctx != GlobalContext()
    dispose(ctx)
end


## module

let
    mod = LLVM.Module("foo")

    show(DevNull, mod)

    dummyTarget = "SomeTarget"
    setTarget(mod, dummyTarget)
    @test target(mod) == dummyTarget

    dummyLayout = "e-p:64:64:64"
    setDatalayout(mod, dummyLayout)
    @test datalayout(mod) == dummyLayout

    dispose(mod)
end

let
    mod = LLVM.Module("foo", global_ctx)
    dispose(mod)
end
