
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

# integer
let
    typ = LLVM.Int1Type()
    @test context(typ) == global_ctx
    @test LLVM.Int1Type(local_ctx) != typ

    show(DevNull, typ)
end
Context() do ctx
    typ = LLVM.Int1Type(ctx)

    # type agnostic
    @test issized(typ)

    # int specific
    @test width(LLVM.Int32Type()) == 32
end

# function
Context() do ctx
    x = LLVM.Int1Type(ctx)
    y = [LLVM.Int8Type(ctx), LLVM.Int16Type(ctx)]
    ft = LLVM.FunctionType(x, y)

    @test !isvararg(ft)
    @test return_type(ft) == x
    @test parameters(ft) == y
end

# sequential
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

# structure
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

# other
Context() do ctx
    LLVM.VoidType()
    LLVM.LabelType()
end


## value

Context() do ctx
    typ = LLVM.Int32Type(ctx)
    val = ConstantInt(typ, 1)

    show(DevNull, val)

    @test LLVM.typeof(val) == typ
    @test name(val) == ""
    @test isconstant(val)
    @test !isundef(val)

    # TODO: name! and replace_uses! if embedded in module
end

# constants

# scalar
Context() do ctx
    t1 = LLVM.Int32Type(ctx)
    c1 = ConstantInt(t1, 1)
    @test convert(UInt, c1) == 1
    c2 = ConstantInt(t1, -1, true)
    @test convert(Int, c2) == -1

    t2 = LLVM.DoubleType(ctx)
    c = ConstantFP(t2, 1.1)
    @test convert(Float64, c) == 1.1
end

# function
Context() do ctx
    mod = LLVMModule("foo", ctx)
    ft = LLVM.FunctionType(LLVM.VoidType(), LLVMType[])
    fn = add!(functions(mod), "bar", ft)    # TODO: ctor with mod?

    show(DevNull, fn)

    @test last(functions(mod)) == fn
    delete!(fn)
    @test isempty(functions(mod))

    #personality(fn)

    @test intrinsic_id(fn) == 0

    @test callconv(fn) == LLVM.API.LLVMCCallConv
    callconv!(fn, LLVM.API.LLVMFastCallConv)
    @test callconv(fn) == LLVM.API.LLVMFastCallConv

    #LLVM.gc(fn)

    attr = attributes(fn)
    # @show get(attr)

    dispose(mod)
end

# global variables
Context() do ctx
    mod = LLVMModule("foo", ctx)
    gv = GlobalVariable(mod, LLVM.Int32Type(), "bar")

    show(DevNull, gv)

    dispose(mod)
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
    @test !haskey(types(mod), "bar")
    @test_throws KeyError get(types(mod), "bar")

    f = get(functions(mod), "bar")
    @test first(functions(mod)) == f
    fs = 0
    for f in functions(mod)
        fs += 1
    end
    @test fs == 1
    @test last(functions(mod)) == f

    mdit = metadata(mod)
    md = MDNode([MDString("bar", ctx)], ctx)
    add!(mdit, "foo", md)
    @test haskey(mdit, "foo")
    mds = get(mdit, "foo")
    @test mds[1] == md
    @test !haskey(mdit, "bar")
    @test_throws KeyError get(mdit, "bar")

    dispose(mod)
end


## metadata

Context() do ctx
    str = MDString("foo", ctx)
    @test convert(String, str) == "foo"
end

Context() do ctx
    str = MDString("foo", ctx)
    node = MDNode([str], ctx)
    ops = operands(node)
    @test length(ops) == 1
    @test ops[1] == str
end
