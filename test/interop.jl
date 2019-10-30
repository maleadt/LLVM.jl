using LLVM.Interop

@testset "interop" begin

@testset "base" begin

@test isa(JuliaContext(), Context)

@test isa(convert(LLVMType, Nothing), LLVM.VoidType)

@test_throws ErrorException convert(LLVMType, Ref)
convert(LLVMType, Ref, true)

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

@eval struct GhostType end
@eval struct NonGhostType1
    x::Int
end
@eval mutable struct NonGhostType2 end

@test isghosttype(GhostType)
@test !isghosttype(NonGhostType1)
@test !isghosttype(NonGhostType2)
@test isboxed(NonGhostType2)

end

@testset "asmcall" begin

# only asm

a1() = @asmcall("nop")
@test a1() == nothing

a2() = @asmcall("nop", Nothing)
@test a2() == nothing

a3() = @asmcall("nop", Nothing, Tuple{})
@test a3() == nothing

# asm + constraints

b1() = @asmcall("nop", "")
@test b1() == nothing

b2() = @asmcall("nop", "", Nothing)
@test b2() == nothing

b3() = @asmcall("nop", "", Nothing, Tuple{})
@test b3() == nothing

# asm + constraints + side-effects

c1() = @asmcall("nop", "", false)
@test c1() == nothing

c2() = @asmcall("nop", "", false, Nothing)
@test c2() == nothing

c3() = @asmcall("nop", "", false, Nothing, Tuple{})
@test c3() == nothing

if Sys.ARCH == :x86 || Sys.ARCH == :x86_64

# arguments

d1(a) = @asmcall("bswap \$0", "=r,r", Int32, Tuple{Int32}, a)
@test d1(Int32(1)) == Int32(16777216)

# multiple output registers

e1() = @asmcall("mov \$\$1, \$0; mov \$\$2, \$1;", "=r,=r", Tuple{Int16,Int32})
@test e1() == (Int16(1), Int32(2))

# TODO: alternative test snippets for other platforms

end

end


if VERSION >= v"1.2.0-DEV.531"
@testset "passes" begin


Context() do ctx
LLVM.Module("SomeModule", ctx) do mod
ModulePassManager() do pm

alloc_opt!(pm)
barrier_noop!(pm)
gc_invariant_verifier!(pm)
gc_invariant_verifier!(pm, true)
lower_exc_handlers!(pm)
combine_mul_add!(pm)
multi_versioning!(pm)
propagate_julia_addrsp!(pm)
lower_ptls!(pm)
lower_ptls!(pm, true)
lower_simdloop!(pm)
late_lower_gc_frame!(pm)
final_lower_gc!(pm)

end
end
end

end
end

end
