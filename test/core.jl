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

    @test LLVM.construct(LLVM.IntegerType, LLVM.ref(typ)) == typ
    if LLVM.DEBUG
        @test_throws ErrorException LLVM.construct(LLVM.FunctionType, LLVM.ref(typ))
    end
    @test_throws NullException LLVM.construct(LLVM.FunctionType, LLVM.API.LLVMTypeRef(C_NULL))
    @test_throws ErrorException LLVM.construct(LLVMType, LLVM.API.LLVMTypeRef(C_NULL))

    @test LLVM.dynamic_construct(LLVMType, LLVM.ref(typ)) == typ
    @test_throws NullException LLVM.dynamic_construct(LLVMType, LLVM.API.LLVMTypeRef(C_NULL))

    LLVM.IntType(8)
    @test width(LLVM.IntType(8, ctx)) == 8

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

        let elem_it = elements(st)
            @test eltype(elem_it) == LLVMType

            @test length(elem_it) == length(elem)

            @test first(elem_it) == elem[1]
            @test last(elem_it) == elem[end]

            i = 1
            for el in elem_it
                @test el == elem[i]
                i += 1
            end

            @test collect(elem_it) == elem
        end
    end

    let st = LLVM.StructType("foo", ctx)
        @test name(st) == "foo"
        @test isopaque(st)
        elements!(st, elem)
        @test collect(elements(st)) == elem
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
Builder(ctx) do builder
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(), [LLVM.Int32Type()])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry")
    position!(builder, entry)

    typ = LLVM.Int32Type(ctx)
    val = alloca!(builder, typ, "foo")

    @test LLVM.construct(LLVM.Instruction, LLVM.ref(val)) == val
    if LLVM.DEBUG
        @test_throws ErrorException LLVM.construct(LLVM.Function, LLVM.ref(val))
    end
    @test_throws NullException LLVM.construct(LLVM.Function, LLVM.API.LLVMValueRef(C_NULL))
    @test_throws ErrorException LLVM.construct(Value, LLVM.API.LLVMValueRef(C_NULL))

    @test LLVM.dynamic_construct(Value, LLVM.ref(val)) == val
    @test_throws NullException LLVM.dynamic_construct(Value, LLVM.API.LLVMValueRef(C_NULL))

    show(DevNull, val)

    @test llvmtype(val) == LLVM.PointerType(typ)
    @test name(val) == "foo"
    @test !isconstant(val)
    @test !isundef(val)

    name!(val, "bar")
    @test name(val) == "bar"
end
end
end

# usage

Context() do ctx
Builder(ctx) do builder
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int32Type(ctx)])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry")
    position!(builder, entry)

    valueinst1 = add!(builder, parameters(fn)[1],
                      ConstantInt(LLVM.Int32Type(ctx), 1))

    userinst = add!(builder, valueinst1,
                    ConstantInt(LLVM.Int32Type(ctx), 1))

    let usepairs = uses(valueinst1)
        @test eltype(usepairs) == Use

        @test length(usepairs) == 1

        usepair = first(usepairs)
        @test value(usepair) == valueinst1
        @test user(usepair) == userinst

        for _usepair in usepairs
            @test usepair == _usepair
        end

        @test value.(collect(usepairs)) == [valueinst1]
        @test user.(collect(usepairs)) == [userinst]
    end

    valueinst2 = add!(builder, parameters(fn)[1],
                    ConstantInt(LLVM.Int32Type(ctx), 2))

    replace_uses!(valueinst1, valueinst2)
    @test user.(collect(uses(valueinst2))) == [userinst]
end
end
end

# constants

# scalar
Context() do ctx
    t1 = LLVM.Int32Type(ctx)
    c1 = ConstantInt(t1, UInt(1))
    @test convert(UInt, c1) == 1
    c2 = ConstantInt(t1, -1)
    @test convert(Int, c2) == -1

    t2 = LLVM.DoubleType(ctx)
    c = ConstantFP(t2, 1.1)
    @test convert(Float64, c) == 1.1
end

# global variables
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
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

    gvars = globals(mod)
    @test gv in gvars
    unsafe_delete!(mod, gv)
    @test isempty(gvars)
end
end

Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    gv = GlobalVariable(mod, LLVM.Int32Type(), "SomeGlobal", 1)

    @test addrspace(llvmtype(gv)) == 1
end
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


## module

let
    mod = LLVM.Module("SomeModule")
    @test context(mod) == global_ctx

    dispose(mod)
end

Context() do ctx
    mod = LLVM.Module("SomeModule", ctx)
    @test context(mod) == ctx
end

Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    clone = LLVM.Module(mod)
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
end
end

# type iteration
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    st = LLVM.StructType("SomeType", ctx)
    ft = LLVM.FunctionType(st, [st])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    @test haskey(types(mod), "SomeType")
    @test get(types(mod), "SomeType") == st

    @test !haskey(types(mod), "SomeOtherType")
    @test_throws KeyError get(types(mod), "SomeOtherType")
end
end

# metadata iteration
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    node = MDNode([MDString("SomeMDString", ctx)], ctx)

    mds = metadata(mod)
    push!(mds, "SomeMDNode", node)

    @test haskey(mds, "SomeMDNode")
    nodeval = get(mds, "SomeMDNode")
    @test nodeval[1] == node

    @test !haskey(mds, "SomeOtherMDNode")
    @test_throws KeyError get(mds, "SomeOtherMDNode")
end
end

# global iteration
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    dummygv = GlobalVariable(mod, LLVM.Int32Type(), "SomeGlobal")

    let gvs = globals(mod)
        @test eltype(gvs) == GlobalVariable

        @test length(gvs) == 1

        @test first(gvs) == dummygv
        @test last(gvs) == dummygv

        for gv in gvs
            @test gv == dummygv
        end

        @test collect(gvs) == [dummygv]

        @test haskey(gvs, "SomeGlobal")
        @test get(gvs, "SomeGlobal") == dummygv

        @test !haskey(gvs, "SomeOtherGlobal")
        @test_throws KeyError get(gvs, "SomeOtherGlobal")
    end
end
end

# function iteration
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    st = LLVM.StructType("SomeType", ctx)
    ft = LLVM.FunctionType(st, [st])

    dummyfn = LLVM.Function(mod, "SomeFunction", ft)
    let fns = functions(mod)
        @test eltype(fns) == LLVM.Function

        @test length(fns) == 1

        @test first(fns) == dummyfn
        @test last(fns) == dummyfn

        for fn in fns
            @test fn == dummyfn
        end

        @test collect(fns) == [dummyfn]

        @test haskey(fns, "SomeFunction")
        @test get(fns, "SomeFunction") == dummyfn

        @test !haskey(fns, "SomeOtherFunction")
        @test_throws KeyError get(fns, "SomeOtherFunction")
    end
end
end


## function

Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int32Type(ctx)])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    show(DevNull, fn)

    # @show personality(fn)

    @test intrinsic_id(fn) == 0

    @test callconv(fn) == LLVM.API.LLVMCCallConv
    callconv!(fn, LLVM.API.LLVMFastCallConv)
    @test callconv(fn) == LLVM.API.LLVMFastCallConv

    @test LLVM.gc(fn) == ""
    gc!(fn, "SomeGC")
    @test LLVM.gc(fn) == "SomeGC"

    fns = functions(mod)
    @test fn in fns
    unsafe_delete!(mod, fn)
    @test isempty(fns)
end
end

# attributes
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int32Type(ctx)])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    let attrs = attributes(fn)
        @test get(attrs) == 0

        push!(attrs, LLVM.API.LLVMNoUnwindAttribute)
        @test get(attrs) == LLVM.API.LLVMNoUnwindAttribute

        push!(attrs, LLVM.API.LLVMNoInlineAttribute)
        @test get(attrs) == LLVM.API.LLVMNoUnwindAttribute|LLVM.API.LLVMNoInlineAttribute

        delete!(attrs, LLVM.API.LLVMNoUnwindAttribute)
        @test get(attrs) == LLVM.API.LLVMNoInlineAttribute
    end
end
end

# parameter iteration
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int32Type(ctx)])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    let params = parameters(fn)
        @test eltype(params) == Argument

        @test length(params) == 1

        intparam = params[1]
        @test first(params) == intparam
        @test last(params) == intparam

        for param in params
            @test param == intparam
        end

        @test collect(params) == [intparam]
    end
end
end

# basic block iteration
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx))
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entrybb = BasicBlock(fn, "SomeBasicBlock")
    @test entry(fn) == entrybb
    let bbs = blocks(fn)
        @test eltype(bbs) == BasicBlock

        @test length(bbs) == 1

        @test first(bbs) == entrybb
        @test last(bbs) == entrybb

        for bb in bbs
            @test bb == entrybb
        end

        @test collect(bbs) == [entrybb]
    end
end
end


## basic blocks

Builder() do builder
LLVM.Module("SomeModule") do mod
    ft = LLVM.FunctionType(LLVM.VoidType())
    fn = LLVM.Function(mod, "SomeFunction", ft)
    bbs = blocks(fn)

    bb2 = BasicBlock(fn, "SomeOtherBasicBlock")
    @test LLVM.parent(bb2) == fn

    bb1 = BasicBlock(bb2, "SomeBasicBlock")
    @test LLVM.parent(bb2) == fn

    @test collect(bbs) == [bb1, bb2]

    move_before(bb2, bb1)
    @test collect(bbs) == [bb2, bb1]

    move_after(bb2, bb1)
    @test collect(bbs) == [bb1, bb2]

    @test bb1 in bbs
    @test bb2 in bbs
    delete!(fn, bb1)
    unsafe_delete!(fn, bb2)
    @test isempty(bbs)
end
end

Context() do ctx
Builder(ctx) do builder
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx))
    fn = LLVM.Function(mod, "SomeFunction", ft)

    bb2 = BasicBlock(fn, "SomeOtherBasicBlock", ctx)
    @test LLVM.parent(bb2) == fn

    bb1 = BasicBlock(bb2, "SomeBasicBlock", ctx)
    @test LLVM.parent(bb2) == fn
    position!(builder, bb1)
    brinst = br!(builder, bb2)
    position!(builder, bb2)
    retinst = ret!(builder)

    @test terminator(bb1) == brinst
    @test terminator(bb2) == retinst

    # instruction iteration
    let insts = instructions(bb1)
        @test eltype(insts) == Instruction

        @test length(insts) == 1

        @test first(insts) == brinst
        @test last(insts) == brinst

        for inst in insts
            @test inst == brinst
        end

        @test collect(insts) == [brinst]
    end
end
end
end


## instructions

Context() do ctx
Builder(ctx) do builder
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int1Type(ctx), LLVM.Int1Type(ctx)])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    bb1 = BasicBlock(fn, "entry", ctx)
    bb2 = BasicBlock(fn, "then", ctx)
    bb3 = BasicBlock(fn, "else", ctx)

    position!(builder, bb1)
    brinst = br!(builder, parameters(fn)[1], bb2, bb3)

    position!(builder, bb2)
    retinst = ret!(builder)

    position!(builder, bb3)
    retinst = ret!(builder)

    # terminators

    @test isconditional(brinst)
    @test condition(brinst) == parameters(fn)[1]
    condition!(brinst, parameters(fn)[2])
    @test condition(brinst) == parameters(fn)[2]

    let succ = successors(terminator(bb1))
        @test eltype(succ) == BasicBlock

        @test length(succ) == 2

        @test succ[1] == bb2
        @test succ[2] == bb3

        @test collect(succ) == [bb2, bb3]
        @test first(succ) == bb2
        @test last(succ) == bb3

        i = 1
        for bb in succ
            @test 1 <= i <= 2
            if i == 1
                @test bb == bb2
            elseif i == 2
                @test bb == bb3
            end
            i += 1
        end

        succ[2] = bb3
        @test succ[2] == bb3
    end

    # general stuff

    @test LLVM.parent(brinst) == bb1

    @test !hasmetadata(brinst)
    md = MDNode([MDString("foo", ctx)], ctx)
    metadata!(brinst, 0, md)
    @test metadata(brinst, 0) == md

    @test brinst in instructions(bb1)
    unsafe_delete!(bb1, brinst)
    @test !(brinst in instructions(bb1))
end
end
end
