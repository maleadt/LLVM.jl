
## context

global_ctx = GlobalContext()
local_ctx = Context()

let
    ctx = Context()
    @assert local_ctx != GlobalContext()
    dispose(ctx)
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


## value

let
    typ = LLVM.Int32Type()
    val = ConstInt(typ, 1)

    show(DevNull, val)

    @test LLVM.typeof(val) == typ
    @test name(val) == ""
    @test isconstant(val)
    @test !isundef(val)

    # TODO: name! and replace_uses! if embedded in module
end

let
    t1 = LLVM.Int32Type()
    c1 = ConstInt(t1, 1)
    @test value_zext(c1) == 1
    c2 = ConstInt(t1, -1, true)
    @test value_sext(c2) == -1

    t2 = LLVM.DoubleType()
    c = ConstReal(t2, 1.1)
    @test value_double(c) == 1.1
end


## module

let
    mod = LLVM.Module("foo")

    show(DevNull, mod)

    dummyTarget = "SomeTarget"
    target!(mod, dummyTarget)
    @test target(mod) == dummyTarget

    dummyLayout = "e-p:64:64:64"
    datalayout!(mod, dummyLayout)
    @test datalayout(mod) == dummyLayout

    dispose(mod)
end

let
    mod = LLVM.Module("foo", global_ctx)
    dispose(mod)
end