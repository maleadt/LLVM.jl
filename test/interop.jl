using LLVM.Interop

@testset "interop" begin

@testset "base" begin

@test isa(JuliaContext(), Context)

@test isa(convert(LLVMType, Void), LLVM.VoidType)

@generated function add_one(i)
    T_int = convert(LLVMType, Int)

    f, ft = create_function(T_int, [T_int])

    Builder(JuliaContext()) do builder
        entry = BasicBlock(f, "entry", JuliaContext())
        position!(builder, entry)

        val = add!(builder, parameters(f)[1], ConstantInt(T_int, 1))

        ret!(builder, val)
    end

    call_function(f, Int, Tuple{Int}, :((i,)))
end

@test add_one(1) == 2

end

@testset "asmcall" begin

# only asm

a1() = @asmcall("nop")
@test a1() == nothing

a2() = @asmcall("nop", Void)
@test a2() == nothing

a3() = @asmcall("nop", Void, Tuple{})
@test a3() == nothing

# asm + constraints

b1() = @asmcall("nop", "")
@test b1() == nothing

b2() = @asmcall("nop", "", Void)
@test b2() == nothing

b3() = @asmcall("nop", "", Void, Tuple{})
@test b3() == nothing

# asm + constraints + side-effects

c1() = @asmcall("nop", "", false)
@test c1() == nothing

c2() = @asmcall("nop", "", false, Void)
@test c2() == nothing

c3() = @asmcall("nop", "", false, Void, Tuple{})
@test c3() == nothing

# arguments

d1(a) = @asmcall("bswap \$0", "=r,r", Int32, Tuple{Int32}, a)
@test d1(Int32(1)) == Int32(16777216)

end

end
