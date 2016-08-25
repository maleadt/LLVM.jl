# LLVMBool
let
    @test LLVM.BoolFromLLVM(LLVMTrue) == true
    @test LLVM.BoolFromLLVM(LLVMFalse) == false

    @test_throws ArgumentError LLVM.BoolFromLLVM(LLVM.API.LLVMBool(2))

    @test LLVM.BoolToLLVM(true) == LLVMTrue
    @test LLVM.BoolToLLVM(false) == LLVMFalse
end


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

Context() do ctx
    typ = LLVM.Int1Type(ctx)

    @test LLVM.construct(LLVM.LLVMInteger, LLVM.ref(LLVMType, typ)) == typ
    if LLVM.DEBUG
        @test_throws ErrorException LLVM.construct(LLVM.FunctionType, LLVM.ref(LLVMType, typ))
    end
    @test_throws NullException LLVM.construct(LLVM.FunctionType, LLVM.API.LLVMTypeRef(C_NULL))
    @test_throws ErrorException LLVM.construct(LLVMType, LLVM.API.LLVMTypeRef(C_NULL))

    @test LLVM.dynamic_construct(LLVMType, LLVM.ref(LLVMType, typ)) == typ
    @test_throws NullException LLVM.dynamic_construct(LLVMType, LLVM.API.LLVMTypeRef(C_NULL))

    @test width(LLVM.Int32Type(ctx)) == 32

    @test issized(LLVM.Int1Type(ctx))
    @test !issized(LLVM.VoidType(ctx))
end

# integer
let
    typ = LLVM.Int1Type()
    @test context(typ) == global_ctx
    @test LLVM.Int1Type(local_ctx) != typ

    show(DevNull, typ)
end
Context() do ctx
    typ = LLVM.Int1Type(ctx)
    @test context(typ) == ctx
end

# floating-point

# function
Context() do ctx
    x = LLVM.Int1Type(ctx)
    y = [LLVM.Int8Type(ctx), LLVM.Int16Type(ctx)]
    ft = LLVM.FunctionType(x, y)
    @test context(ft) == ctx

    @test !isvararg(ft)
    @test return_type(ft) == x
    @test parameters(ft) == y
end

# sequential
Context() do ctx
    eltyp = LLVM.Int32Type(ctx)

    ptrtyp = LLVM.PointerType(eltyp)
    @test eltype(ptrtyp) == eltyp
    @test context(ptrtyp) == context(eltyp)

    @test addrspace(ptrtyp) == 0

    ptrtyp = LLVM.PointerType(eltyp, 1)
    @test addrspace(ptrtyp) == 1
end
Context() do ctx
    eltyp = LLVM.Int32Type(ctx)

    arrtyp = LLVM.ArrayType(eltyp, 2)
    @test eltype(arrtyp) == eltyp
    @test context(arrtyp) == context(eltyp)

    @test length(arrtyp) == 2
end
Context() do ctx
    eltyp = LLVM.Int32Type(ctx)

    vectyp = LLVM.VectorType(eltyp, 2)
    @test eltype(vectyp) == eltyp
    @test context(vectyp) == context(eltyp)

    @test size(vectyp) == 2
end

# structure
let
    st = LLVM.StructType([LLVM.VoidType()])
    @test context(st) == global_ctx
end
Context() do ctx
    elem = [LLVM.Int32Type(ctx), LLVM.FloatType(ctx)]

    let st = LLVM.StructType(elem, ctx)
        @test context(st) == ctx        
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
let
    typ = LLVM.VoidType()
    @test context(typ) == global_ctx
end
Context() do ctx
    typ = LLVM.VoidType(ctx)
    @test context(typ) == ctx
end
let
    typ = LLVM.LabelType()
    @test context(typ) == global_ctx
end
Context() do ctx
    typ = LLVM.LabelType(ctx)
    @test context(typ) == ctx
end


## value

Context() do ctx
    typ = LLVM.Int32Type(ctx)
    val = ConstantInt(typ, 1)

    @test LLVM.construct(LLVM.ConstantInt, LLVM.ref(Value, val)) == val
    if LLVM.DEBUG
        @test_throws ErrorException LLVM.construct(LLVMFunction, LLVM.ref(Value, val))
    end
    @test_throws NullException LLVM.construct(LLVMFunction, LLVM.API.LLVMValueRef(C_NULL))
    @test_throws ErrorException LLVM.construct(Value, LLVM.API.LLVMValueRef(C_NULL))

    @test LLVM.dynamic_construct(Value, LLVM.ref(Value, val)) == val
    @test_throws NullException LLVM.dynamic_construct(Value, LLVM.API.LLVMValueRef(C_NULL))

    show(DevNull, val)

    @test llvmtype(val) == typ
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
    fn = LLVMFunction(mod, "bar", ft)

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
    mod = LLVMModule("SomeModule", ctx)
    gv = GlobalVariable(mod, LLVM.Int32Type(), "SomeGlobal")

    show(DevNull, gv)

    @test_throws NullException initializer(gv)
    init = ConstantInt(LLVM.Int32Type(), 0)
    initializer!(gv, init)
    @test initializer(gv) == init

    @test !isthreadlocal(gv)
    threadlocal!(gv, true)
    @test isthreadlocal(gv)

    @test !isconstant(gv)
    constant!(gv, true)
    @test isconstant(gv)

    @test !isextinit(gv)
    extinit!(gv, true)
    @test isextinit(gv)

    @test threadlocalmode(gv) == LLVM.API.LLVMGeneralDynamicTLSModel
    threadlocalmode!(gv, LLVM.API.LLVMNotThreadLocal)
    @test threadlocalmode(gv) == LLVM.API.LLVMNotThreadLocal

    @test last(globals(mod)) == gv
    delete!(gv)
    @test isempty(globals(mod))

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

    dispose(mod)
end

# type iteration

# function iteration
Context() do ctx
    mod = LLVMModule("SomeModule", ctx)

    st = LLVM.StructType("SomeType", ctx)
    ft = LLVM.FunctionType(st, [st])
    fn = LLVMFunction(mod, "SomeFunction", ft)

    @test get(types(mod), "SomeType") == st
    @test !haskey(types(mod), "SomeOtherType")
    @test_throws KeyError get(types(mod), "SomeOtherType")

    dispose(mod)
end

# function iteration
Context() do ctx
    mod = LLVMModule("SomeModule", ctx)

    st = LLVM.StructType("SomeType", ctx)
    ft = LLVM.FunctionType(st, [st])
    fn = LLVMFunction(mod, "SomeFunction", ft)

    fns = functions(mod)
    @test eltype(fns) == LLVMFunction

    @test get(fns, "SomeFunction") == fn
    @test first(fns) == fn
    fs = 0
    for f in fns
        fs += 1
        @test f == fn
    end
    @test fs == 1
    @test last(fns) == fn

    @test !haskey(fns, "SomeOtherFunction")
    @test_throws KeyError get(fns, "SomeOtherFunction")

    dispose(mod)
end

# metadata iteration
Context() do ctx
    mod = LLVMModule("SomeModule", ctx)

    node = MDNode([MDString("SomeMDString", ctx)], ctx)

    mds = metadata(mod)
    push!(mds, "SomeMDNode", node)

    @test haskey(mds, "SomeMDNode")
    nodeval = get(mds, "SomeMDNode")
    @test nodeval[1] == node

    @test !haskey(mds, "SomeOtherMDNode")
    @test_throws KeyError get(mds, "SomeOtherMDNode")

    dispose(mod)
end

# global iteration
Context() do ctx
    mod = LLVMModule("SomeModule", ctx)

    gv = GlobalVariable(mod, LLVM.Int32Type(), "SomeGlobal")

    gvs = globals(mod)
    @test eltype(gvs) == GlobalVariable

    @test get(gvs, "SomeGlobal") == gv
    @test first(gvs) == gv
    fs = 0
    for f in gvs
        fs += 1
        @test f == gv
    end
    @test fs == 1
    @test last(gvs) == gv

    @test !haskey(gvs, "SomeOtherGlobal")
    @test_throws KeyError get(gvs, "SomeOtherGlobal")

    dispose(mod)
end


## metadata

@test MDString("foo") == MDString("foo", global_ctx)

Context() do ctx
    str = MDString("foo", ctx)
    @test convert(String, str) == "foo"
end

@test MDNode([MDString("foo")]) == MDNode([MDString("foo", global_ctx)], global_ctx)

Context() do ctx
    str = MDString("foo", ctx)
    node = MDNode([str], ctx)
    ops = operands(node)
    @test length(ops) == 1
    @test ops[1] == str
end
