
## context

global_ctx = GlobalContext()
local_ctx = Context()

let
    ctx = Context()
    @assert local_ctx != GlobalContext()
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


## type

let
    typ = LLVM.Int1Type()
    @test context(typ) == global_ctx
    @test LLVM.Int1Type(local_ctx) != typ

    # type agnostic
    @test kind(typ) == LLVM.API.LLVMIntegerTypeKind
    @test issized(typ)

    # int specific
    @test width(LLVM.Int32Type()) == 32
end

let
    x = LLVM.Int1Type()
    y = [LLVM.Int8Type(), LLVM.Int16Type()]
    ft = LLVM.FunctionType(x, y)

    @test !isvararg(ft)
    @test return_type(ft) == x
    @test parameters(ft) == y
end

let
    eltyp = LLVM.Int32Type()

    ptrtyp = LLVM.PointerType(eltyp)
    @test eltype(ptrtyp) == eltyp
    @test addrspace(ptrtyp) == 0

    ptrtyp = LLVM.PointerType(eltyp, 1)
    @test addrspace(ptrtyp) == 1
end

let
    eltyp = LLVM.Int32Type()

    arrtyp = LLVM.ArrayType(eltyp, 2)
    @test eltype(arrtyp) == eltyp
    @test length(arrtyp) == 2
end

let
    eltyp = LLVM.Int32Type()

    vectyp = LLVM.VectorType(eltyp, 2)
    @test eltype(vectyp) == eltyp
    @test size(vectyp) == 2
end

let
    elem = [LLVM.Int32Type(), LLVM.FloatType()]

    let st = LLVM.StructType(elem)
        @test !ispacked(st)
        @test !isopaque(st)
        @test elements(st) == elem
    end

    let st = LLVM.StructType("foo")
        @test name(st) == "foo"
        @test isopaque(st)
        elements!(st, elem)
        @test elements(st) == elem
        @test !isopaque(st)
    end
end
