
## context

global_ctx = GlobalContext()
local_ctx = Context()

let
    ctx = Context()
    @assert local_ctx != GlobalContext()
    dispose(ctx)
end

Context() do ctx end


## type

let
    typ = LLVM.Int1Type()
    @test context(typ) == global_ctx
    @test LLVM.Int1Type(local_ctx) != typ
end

Context() do ctx
    typ = LLVM.Int1Type(ctx)

    # type agnostic
    @test kind(typ) == LLVM.API.LLVMIntegerTypeKind
    @test issized(typ)

    # int specific
    @test width(LLVM.Int32Type()) == 32
end

Context() do ctx
    x = LLVM.Int1Type(ctx)
    y = [LLVM.Int8Type(ctx), LLVM.Int16Type(ctx)]
    ft = LLVM.FunctionType(x, y)

    @test !isvararg(ft)
    @test return_type(ft) == x
    @test parameters(ft) == y
end

Context() do ctx
    eltyp = LLVM.Int32Type(ctx)

    ptrtyp = LLVM.PointerType(eltyp)
    @test eltype(ptrtyp) == eltyp
    @test addrspace(ptrtyp) == 0

    ptrtyp = LLVM.PointerType(eltyp, 1)
    @test addrspace(ptrtyp) == 1
end

Context() do ctx
    eltyp = LLVM.Int32Type(ctx)

    arrtyp = LLVM.ArrayType(eltyp, 2)
    @test eltype(arrtyp) == eltyp
    @test length(arrtyp) == 2
end

Context() do ctx
    eltyp = LLVM.Int32Type(ctx)

    vectyp = LLVM.VectorType(eltyp, 2)
    @test eltype(vectyp) == eltyp
    @test size(vectyp) == 2
end

Context() do ctx
    elem = [LLVM.Int32Type(ctx), LLVM.FloatType(ctx)]

    let st = LLVM.StructType(elem, ctx)
        @test !ispacked(st)
        @test !isopaque(st)
        @test elements(st) == elem
    end

    let st = LLVM.StructType("foo", ctx)
        @test name(st) == "foo"
        @test isopaque(st)
        elements!(st, elem)
        @test elements(st) == elem
        @test !isopaque(st)
    end
end


## value

Context() do ctx
    typ = LLVM.Int32Type(ctx)
    val = ConstInt(typ, 1)

    show(DevNull, val)

    @test LLVM.typeof(val) == typ
    @test name(val) == ""
    @test isconstant(val)
    @test !isundef(val)

    # TODO: name! and replace_uses! if embedded in module
end

Context() do ctx
    t1 = LLVM.Int32Type(ctx)
    c1 = ConstInt(t1, 1)
    @test value_zext(c1) == 1
    c2 = ConstInt(t1, -1, true)
    @test value_sext(c2) == -1

    t2 = LLVM.DoubleType(ctx)
    c = ConstReal(t2, 1.1)
    @test value_double(c) == 1.1
end


## module

let
    mod = LLVMModule("foo")
    @test context(mod) == global_ctx

    dispose(mod)
end

Context() do ctx
    mod = LLVMModule("foo", ctx)
    @test context(mod) == ctx

    clone = LLVMModule(mod)
    @test mod != clone
    @test context(clone) == ctx
    dispose(clone)

    show(DevNull, mod)

    inline_asm!(mod, "nop")
    @test contains(sprint(io->show(io,mod)), "module asm")

    dummyTarget = "SomeTarget"
    target!(mod, dummyTarget)
    @test target(mod) == dummyTarget

    dummyLayout = "e-p:64:64:64"
    datalayout!(mod, dummyLayout)
    @test datalayout(mod) == dummyLayout

    st = LLVM.StructType("foo", ctx)
    ft = LLVM.FunctionType(st, [st])
    add!(functions(mod), "bar", ft)

    @test get(types(mod), "foo") == st
    @test_throws KeyError get(types(mod), "bar")

    f = get(functions(mod), "bar")
    @test first(functions(mod)) == f
    fs = 0
    for f in functions(mod)
        fs += 1
    end
    @test fs == 1
    @test last(functions(mod)) == f

    dispose(mod)
end
