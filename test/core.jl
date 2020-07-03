@testset "core" begin

@testset "context" begin

global global_ctx
global_ctx = GlobalContext()
local_ctx = Context()

let
    ctx = Context()
    @assert local_ctx != GlobalContext()
    dispose(ctx)
end

Context() do ctx end

end


@testset "type" begin

Context() do ctx
    typ = LLVM.Int1Type(ctx)
    @test typeof(typ.ref) == LLVM.API.LLVMTypeRef                 # untyped

    @test typeof(LLVM.IntegerType(typ.ref)) == LLVM.IntegerType   # type reconstructed
    @test_throws ErrorException LLVM.FunctionType(typ.ref)        # wrong type
    @test_throws UndefRefError LLVM.FunctionType(LLVM.API.LLVMTypeRef(C_NULL))

    @test typeof(typ.ref) == LLVM.API.LLVMTypeRef
    @test typeof(LLVMType(typ.ref)) == LLVM.IntegerType           # type reconstructed
    @test_throws UndefRefError LLVMType(LLVM.API.LLVMTypeRef(C_NULL))

    LLVM.IntType(8)
    @test width(LLVM.IntType(8, ctx)) == 8

    @test issized(LLVM.Int1Type(ctx))
    @test !issized(LLVM.VoidType(ctx))
end

# integer
let
    typ = LLVM.Int1Type()
    @test context(typ) == global_ctx

    show(devnull, typ)

    @test !isempty(typ)

    Context() do ctx
        typ2 = LLVM.Int1Type(ctx)
        @test context(typ2) == ctx
        @test typ2 != typ
    end
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
    @test_throws BoundsError parameters(ft)[3]
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
    @test !isempty(arrtyp)

    @test length(arrtyp) == 2
end
Context() do ctx
    eltyp = LLVM.Int32Type(ctx)

    arrtyp = LLVM.ArrayType(eltyp, 0)
    @test isempty(arrtyp)
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
    @test !isempty(st)

    st2 = LLVM.StructType("foo")
    @test context(st2) == global_ctx
    @test isempty(st2)
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
            @test_throws BoundsError elem_it[3]

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
Context() do ctx
    typ = LLVM.MetadataType(ctx)
    @test context(typ) == ctx
end
Context() do ctx
    typ = LLVM.TokenType(ctx)
    @test context(typ) == ctx
end

end


@testset "value" begin

Context() do ctx
Builder(ctx) do builder
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int32Type(ctx)])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry")
    position!(builder, entry)
    @test name(entry) == "entry"

    typ = LLVM.Int32Type(ctx)
    val = alloca!(builder, typ, "foo")
    @test context(val) == ctx
    @test typeof(val.ref) == LLVM.API.LLVMValueRef                # untyped

    @test typeof(LLVM.Instruction(val.ref)) == LLVM.AllocaInst    # type reconstructed
    @test_throws ErrorException LLVM.Function(val.ref)            # wrong
    @test_throws UndefRefError LLVM.Function(LLVM.API.LLVMValueRef(C_NULL))

    @test typeof(Value(val.ref)) == LLVM.AllocaInst               # type reconstructed
    @test_throws UndefRefError Value(LLVM.API.LLVMValueRef(C_NULL))

    show(devnull, val)

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
                      ConstantInt(Int32(1), ctx))
    @test !isterminator(valueinst1)

    userinst = add!(builder, valueinst1,
                    ConstantInt(Int32(1), ctx))

    # use iteration
    let usepairs = uses(valueinst1)
        @test eltype(usepairs) == Use

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
                    ConstantInt(Int32(2), ctx))

    replace_uses!(valueinst1, valueinst2)
    @test user.(collect(uses(valueinst2))) == [userinst]
end
end
end

# users

Context() do ctx
    # operand iteration
    mod = parse(LLVM.Module,  """
        define void @fun(i32) {
        top:
          %1 = add i32 %0, 1
          ret void
        }""", ctx)
    fun = functions(mod)["fun"]

    for (i, instr) in enumerate(instructions(first(blocks(fun))))
        ops = operands(instr)
        @test eltype(ops) == Value
        if i == 1
            @test length(ops) == 2
            @test ops[1] == first(parameters(fun))
            @test ops[2] == ConstantInt(LLVM.Int32Type(ctx), 1)
            @test_throws BoundsError ops[3]
        elseif i == 2
            @test length(ops) == 0
            @test collect(ops) == []
        end
    end
end

# constants

Context() do ctx
    @testset "constants" begin

    typ = LLVM.Int32Type(ctx)
    ptrtyp = LLVM.PointerType(typ)

    let val = null(typ)
        @test isnull(val)
    end

    let val = all_ones(typ)
        @test !isnull(val)
    end

    let val = PointerNull(ptrtyp)
        @test isnull(val)
    end

    let val = UndefValue(typ)
        @test isundef(val)
    end

    end
end

# scalar
Context() do ctx
    @testset "integer constants" begin

    # manual construction of small values
    let
        typ = LLVM.Int32Type(ctx)
        constval = ConstantInt(typ, -1)
        @test convert(Int, constval) == -1
        @test convert(UInt32, constval) == typemax(UInt32)
    end

    # manual construction of large values
    let
        typ = LLVM.Int64Type(ctx)
        constval = ConstantInt(typ, BigInt(2)^100-1)
        @test convert(Int, constval) == -1
    end

    # automatic construction
    let
        constval = ConstantInt(UInt32(1))
        @test convert(UInt, constval) == 1
    end

    # issue #81
    for T in [Int32, UInt32, Int64, UInt64]
        constval = ConstantInt(typemax(T))
        @test convert(T, constval) == typemax(T)
    end

    end


    @testset "floating point constants" begin

    t2 = LLVM.DoubleType(ctx)
    c = ConstantFP(t2, 1.1)
    @test convert(Float64, c) == 1.1

    end
end

# constant expressions
Context() do ctx
    @testset "constant expressions" begin

    # inline assembly
    let
        ft = LLVM.FunctionType(LLVM.VoidType(ctx))
        asm = InlineAsm(ft, "nop", "", false)
        @check_ir asm "void ()* asm \"nop\", \"\""
    end

    end
end

# global values
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    st = LLVM.StructType("SomeType", ctx)
    ft = LLVM.FunctionType(st, [st])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    @test isdeclaration(fn)
    @test linkage(fn) == LLVM.API.LLVMExternalLinkage
    linkage!(fn, LLVM.API.LLVMAvailableExternallyLinkage)
    @test linkage(fn) == LLVM.API.LLVMAvailableExternallyLinkage

    @test section(fn) == ""
    section!(fn, "SomeSection")
    @test section(fn) == "SomeSection"

    @test visibility(fn) == LLVM.API.LLVMDefaultVisibility
    visibility!(fn, LLVM.API.LLVMHiddenVisibility)
    @test visibility(fn) == LLVM.API.LLVMHiddenVisibility

    @test dllstorage(fn) == LLVM.API.LLVMDefaultStorageClass
    dllstorage!(fn, LLVM.API.LLVMDLLImportStorageClass)
    @test dllstorage(fn) == LLVM.API.LLVMDLLImportStorageClass

    @test !unnamed_addr(fn)
    unnamed_addr!(fn, true)
    @test unnamed_addr(fn)

    @test alignment(fn) == 0
    alignment!(fn, 4)
    @test alignment(fn) == 4
end
end

# global variables
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    @test isempty(globals(mod))
    gv = GlobalVariable(mod, LLVM.Int32Type(ctx), "SomeGlobal")
    @test !isempty(globals(mod))

    show(devnull, gv)

    @test initializer(gv) === nothing
    init = ConstantInt(Int32(0), ctx)
    initializer!(gv, init)
    @test initializer(gv) == init
    initializer!(gv, nothing)
    @test initializer(gv) === nothing

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

    if VERSION >= v"1.5" && !(v"1.6-" <= VERSION < v"1.6.0-DEV.90")
        @test !haskey(globals(mod), "llvm.used")
        set_used!(mod, gv)
        @test haskey(globals(mod), "llvm.used")
        unsafe_delete!(mod, globals(mod)["llvm.used"])

        @test !haskey(globals(mod), "llvm.compiler.used")
        set_compiler_used!(mod, gv)
        @test haskey(globals(mod), "llvm.compiler.used")
        unsafe_delete!(mod, globals(mod)["llvm.compiler.used"])
    end

    let gvars = globals(mod)
        @test gv in gvars
        unsafe_delete!(mod, gv)
        @test isempty(gvars)
    end
end
end

Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    st = LLVM.StructType("SomeType", ctx)
    gv = GlobalVariable(mod, st, "SomeGlobal")

    init = null(st)
    initializer!(gv, init)
    @test initializer(gv) == init
end
end

Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    gv = GlobalVariable(mod, LLVM.Int32Type(ctx), "SomeGlobal", 1)

    @test addrspace(llvmtype(gv)) == 1
end
end

end


@testset "metadata" begin

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

end


@testset "module" begin

let
    mod = LLVM.Module("SomeModule")
    @test context(mod) == global_ctx

    @test name(mod) == "SomeModule"
    name!(mod, "SomeOtherName")
    @test name(mod) == "SomeOtherName"

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

    show(devnull, mod)

    inline_asm!(mod, "nop")
    @test occursin("module asm", sprint(io->show(io,mod)))

    dummyTriple = "SomeTriple"
    triple!(mod, dummyTriple)
    @test triple(mod) == dummyTriple

    dummyLayout = "e-p:64:64:64"
    datalayout!(mod, dummyLayout)
    @test convert(String, datalayout(mod)) == dummyLayout

    if LLVM.version() >= v"8.0"
        md = Metadata(ConstantInt(42, ctx))

        mod_flags = flags(mod)
        mod_flags["foobar", LLVM.API.LLVMModuleFlagBehaviorError] = md

        @test occursin("!llvm.module.flags = !{!0}", sprint(io->show(io,mod)))
        @test occursin(r"!0 = !\{i\d+ 1, !\"foobar\", i\d+ 42\}", sprint(io->show(io,mod)))

        @test mod_flags["foobar"] == md
        @test_throws KeyError mod_flags["foobaz"]
    end
end
end

# type iteration
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    st = LLVM.StructType("SomeType", ctx)
    ft = LLVM.FunctionType(st, [st])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    let ts = types(mod)
        @test keytype(ts) == String
        @test valtype(ts) == LLVMType

        @test haskey(ts, "SomeType")
        @test ts["SomeType"] == st

        @test !haskey(ts, "SomeOtherType")
        @test_throws KeyError ts["SomeOtherType"]
    end
end
end

# metadata iteration
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    node = MDNode([MDString("SomeMDString", ctx)], ctx)

    let mds = metadata(mod)
        @test keytype(mds) == String
        @test valtype(mds) == Vector{LLVM.MetadataAsValue}

        push!(mds, "SomeMDNode", node)

        @test haskey(mds, "SomeMDNode")
        mdvals = mds["SomeMDNode"]
        @test mdvals[1] == node

        @test !haskey(mds, "SomeOtherMDNode")
        @test_throws KeyError mds["SomeOtherMDNode"]
    end
end
end

# global variable iteration
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    dummygv = GlobalVariable(mod, LLVM.Int32Type(ctx), "SomeGlobal")

    let gvs = globals(mod)
        @test eltype(gvs) == typeof(dummygv)

        @test first(gvs) == dummygv
        @test last(gvs) == dummygv

        for gv in gvs
            @test gv == dummygv
        end

        @test collect(gvs) == [dummygv]

        @test haskey(gvs, "SomeGlobal")
        @test gvs["SomeGlobal"] == dummygv

        @test !haskey(gvs, "SomeOtherGlobal")
        @test_throws KeyError gvs["SomeOtherGlobal"]
    end
end
end

# function iteration
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    st = LLVM.StructType("SomeType", ctx)
    ft = LLVM.FunctionType(st, [st])
    @test isempty(functions(mod))

    dummyfn = LLVM.Function(mod, "SomeFunction", ft)
    let fns = functions(mod)
        @test eltype(fns) == LLVM.Function

        @test !isempty(fns)

        @test first(fns) == dummyfn
        @test last(fns) == dummyfn

        for fn in fns
            @test fn == dummyfn
        end

        @test collect(fns) == [dummyfn]

        @test haskey(fns, "SomeFunction")
        @test fns["SomeFunction"] == dummyfn

        @test !haskey(fns, "SomeOtherFunction")
        @test_throws KeyError fns["SomeOtherFunction"]
    end
end
end

end


@testset "function" begin

Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int32Type(ctx)])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    show(devnull, fn)

    @test personality(fn) === nothing
    pers_ft = LLVM.FunctionType(LLVM.Int32Type(ctx); vararg=true)
    pers_fn = LLVM.Function(mod, "PersonalityFunction", ft)
    personality!(fn, pers_fn)
    @test personality(fn) == pers_fn
    personality!(fn, nothing)
    @test personality(fn) === nothing
    unsafe_delete!(mod, pers_fn)

    @test !isintrinsic(fn)

    @test callconv(fn) == LLVM.API.LLVMCCallConv
    callconv!(fn, LLVM.API.LLVMFastCallConv)
    @test callconv(fn) == LLVM.API.LLVMFastCallConv

    @test LLVM.gc(fn) == ""
    gc!(fn, "SomeGC")
    @test LLVM.gc(fn) == "SomeGC"

    let fns = functions(mod)
        @test fn in fns
        unsafe_delete!(mod, fn)
        @test isempty(fns)
    end
end
end

Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    intr_ft = LLVM.FunctionType(LLVM.DoubleType(ctx), [LLVM.DoubleType(ctx)])
    intr_fn = LLVM.Function(mod, "llvm.sin.f64", intr_ft)
    @test isintrinsic(intr_fn)

    intr = Intrinsic(intr_fn)
    show(devnull, intr)

    if LLVM.version() >= v"8"
        @test isoverloaded(intr)

        @test name(intr) == "llvm.sin"
        @test name(intr, [LLVM.DoubleType(ctx)]) == "llvm.sin.f64"

        ft = FunctionType(intr, [LLVM.DoubleType(ctx)])
        @test ft isa FunctionType
        @test return_type(ft) == LLVM.DoubleType(ctx)

        fn = LLVM.Function(mod, intr, [LLVM.DoubleType(ctx)])
        @test fn isa LLVM.Function
        @test eltype(llvmtype(fn)) == ft
        @test isintrinsic(fn)
    end

    if LLVM.version() >= v"9"
        @test intr == Intrinsic("llvm.sin")
    end
end
end

# attributes
Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int32Type(ctx)])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    let attrs = function_attributes(fn)
        @test eltype(attrs) == Attribute

        @test length(attrs) == 0

        let attr = EnumAttribute("sspreq", 0, ctx)
            @test kind(attr) != 0
            @test value(attr) == 0
            push!(attrs, attr)
            @test collect(attrs) == [attr]

            delete!(attrs, attr)
            @test length(attrs) == 0
        end

        let attr = EnumAttribute("sspreq")
            @test value(attr) == 0
        end

        let attr = StringAttribute("nounwind", "", ctx)
            @test kind(attr) == "nounwind"
            @test value(attr) == ""
            push!(attrs, attr)
            @test collect(attrs) == [attr]

            delete!(attrs, attr)
            @test length(attrs) == 0
        end

        let attr = StringAttribute("nounwind")
            @test value(attr) == ""
        end
    end

    for i in 1:length(parameters(fn))
        let attrs = parameter_attributes(fn, i)
            @test eltype(attrs) == Attribute
            @test length(attrs) == 0
        end
    end

    let attrs = return_attributes(fn)
        @test eltype(attrs) == Attribute
        @test length(attrs) == 0
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
    @test isempty(blocks(fn))

    entrybb = BasicBlock(fn, "SomeBasicBlock")
    @test entry(fn) == entrybb
    let bbs = blocks(fn)
        @test eltype(bbs) == BasicBlock

        @test !isempty(bbs)
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

end


@testset "basic blocks" begin

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
    @test isempty(instructions(bb2))

    bb1 = BasicBlock(bb2, "SomeBasicBlock", ctx)
    @test LLVM.parent(bb2) == fn
    position!(builder, bb1)
    brinst = br!(builder, bb2)
    position!(builder, bb2)
    retinst = ret!(builder)
    @test !isempty(instructions(bb2))

    @test terminator(bb1) == brinst
    @test terminator(bb2) == retinst

    # instruction iteration
    let insts = instructions(bb1)
        @test eltype(insts) == Instruction

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

end


@testset "instructions" begin

Context() do ctx
Builder(ctx) do builder
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(ctx))
    fn = LLVM.Function(mod, "SomeFunction", ft)
    @test isempty(parameters(fn))

    ft = LLVM.FunctionType(LLVM.VoidType(ctx), [LLVM.Int1Type(ctx), LLVM.Int1Type(ctx)])
    fn = LLVM.Function(mod, "SomeOtherFunction", ft)
    @test !isempty(parameters(fn))

    bb1 = BasicBlock(fn, "entry", ctx)
    bb2 = BasicBlock(fn, "then", ctx)
    bb3 = BasicBlock(fn, "else", ctx)

    position!(builder, bb1)
    brinst = br!(builder, parameters(fn)[1], bb2, bb3)
    @test opcode(brinst) == LLVM.API.LLVMBr

    position!(builder, bb2)
    retinst = ret!(builder)

    position!(builder, bb3)
    retinst = ret!(builder)

    # terminators

    @test isterminator(brinst)
    @test isconditional(brinst)
    @test condition(brinst) == parameters(fn)[1]
    condition!(brinst, parameters(fn)[2])
    @test condition(brinst) == parameters(fn)[2]

    let succ = successors(terminator(bb1))
        @test eltype(succ) == BasicBlock

        @test length(succ) == 2

        @test succ[1] == bb2
        @test succ[2] == bb3
        @test_throws BoundsError succ[3]

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

    # metadata
    mdval = MDNode([MDString("whatever", ctx)], ctx)
    let md = metadata(brinst)
        @test keytype(md) == LLVM.MD
        @test valtype(md) == LLVM.MetadataAsValue

        @test isempty(md)
        @test !haskey(md, LLVM.MD_dbg)

        md[LLVM.MD_dbg] = mdval
        @test md[LLVM.MD_dbg] == mdval

        @test !isempty(md)
        @test haskey(md, LLVM.MD_dbg)

        @test !haskey(md, LLVM.MD_tbaa)
        @test_throws KeyError md[LLVM.MD_tbaa]

        delete!(md, LLVM.MD_dbg)

        @test isempty(md)
        @test !haskey(md, LLVM.MD_dbg)
    end
    let val = ConstantInt(42, ctx)
        md = Metadata(val)
        @test first(operands(LLVM.Value(md, ctx))) == val
    end

    @test retinst in instructions(bb3)
    delete!(bb3, retinst)
    @test !(retinst in instructions(bb3))
    @test opcode(retinst) == LLVM.API.LLVMRet   # make sure retinst is still alive

    @test brinst in instructions(bb1)
    unsafe_delete!(bb1, brinst)
    @test !(brinst in instructions(bb1))
end
end
end

end

end
