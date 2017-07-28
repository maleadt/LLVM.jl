@testset "irbuilder" begin

let
    builder = Builder()
    dispose(builder)
end

Builder() do builder
end

Context() do ctx
Builder(ctx) do builder
LLVM.Module("SomeModule", ctx) do mod
    ft = LLVM.FunctionType(LLVM.VoidType(), [LLVM.Int32Type()])
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entrybb = BasicBlock(fn, "entry")
    position!(builder, entrybb)
    @assert position(builder) == entrybb

    loc = debuglocation(builder)
    md = MDNode([MDString("SomeMDString", ctx)], ctx)
    debuglocation!(builder, md)
    @test debuglocation(builder) == md
    debuglocation!(builder)
    @test debuglocation(builder) == loc

    ## WIP

    check(inst, str) = @test contains(string(inst), str)

    retinst1 = ret!(builder)
    check(retinst1, "ret void")
    debuglocation!(builder, retinst1)

    retinst2 = ret!(builder, ConstantInt(LLVM.Int32Type(ctx), 0))
    check(retinst2, "ret i32 0")

    retinst3 = ret!(builder, Value[])
    check(retinst3, "ret void undef")

    thenbb = BasicBlock(fn, "then")
    elsebb = BasicBlock(fn, "else")

    brinst1 = br!(builder, thenbb)
    check(brinst1, "br label %then")

    condinst = isnull!(builder, parameters(fn)[1], "cond")
    brinst2 = br!(builder, condinst, thenbb, elsebb)
    check(brinst2, "br i1 %cond, label %then, label %else")

    resumeinst = resume!(builder, UndefValue(LLVM.Int32Type(ctx)))
    check(resumeinst, "resume i32 undef")

    unreachableinst = unreachable!(builder)
    check(unreachableinst, "unreachable")

    # TODO: needs many more tests

    position!(builder)
end
end
end

end
