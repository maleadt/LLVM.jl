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

    entry = BasicBlock(fn, "entry")
    position!(builder, entry)
    @assert position(builder) == entry

    loc = debuglocation(builder)
    md = MDNode([MDString("SomeMDString", ctx)], ctx)
    debuglocation!(builder, md)
    @test debuglocation(builder) == md
    debuglocation!(builder)
    @test debuglocation(builder) == loc

    retinst = ret!(builder, ConstantInt(LLVM.Int32Type(), 0))
    debuglocation!(builder, retinst)

    position!(builder, retinst)
    unrinst = unreachable!(builder)
    @test collect(instructions(entry)) == [unrinst, retinst]

    unsafe_delete!(entry, retinst)
    @test collect(instructions(entry)) == [unrinst]
    position!(builder, entry)
    retinst = ret!(builder)
    @test collect(instructions(entry)) == [unrinst, retinst]

    position!(builder, retinst)
    addinst = add!(builder, parameters(fn)[1],
                   ConstantInt(LLVM.Int32Type(), 1), "SomeAddition")
    @test collect(instructions(entry)) == [unrinst, addinst, retinst]
    retinst2 = Instruction(retinst)
    insert!(builder, retinst2)
    @test collect(instructions(entry)) == [unrinst, addinst, retinst2, retinst]

    position!(builder, retinst)
    icmpinst = icmp!(builder, LLVM.API.LLVMIntEQ, addinst, ConstantInt(LLVM.Int32Type(), 1))

    allocinst1 = alloca!(builder, LLVM.Int32Type(), "foo")
    allocinst2 = Instruction(allocinst1)
    @test name(allocinst2) == ""
    insert!(builder, allocinst2, "bar")
    @test name(allocinst2) == "bar"
    @test collect(instructions(entry)) == [unrinst, addinst, retinst2, icmpinst,
                                           allocinst1, allocinst2, retinst]

    trap = LLVM.Function(mod, "llvm.trap", LLVM.FunctionType(LLVM.VoidType(ctx)))
    callinst1 = call!(builder, trap)
    @test contains(string(callinst1), "call void @llvm.trap()")

    assume = LLVM.Function(mod, "llvm.assume",
                           LLVM.FunctionType(LLVM.VoidType(ctx),
                                             [LLVM.Int1Type(ctx)]))
    callinst2 = call!(builder, assume, [ConstantInt(LLVM.Int1Type(ctx), 1)])
    @test contains(string(callinst2), "call void @llvm.assume(i1 true)")

    gepinst = gep!(builder, allocinst1, [ConstantInt(LLVM.Int32Type(), 0)])
    @test contains(string(gepinst), "getelementptr i32, i32* %foo, i32 0")

    storeinst = store!(builder, ConstantInt(LLVM.Int32Type(), 0), allocinst1)
    @test contains(string(storeinst), "store i32 0, i32* %foo")

    position!(builder)
end
end
end

end
