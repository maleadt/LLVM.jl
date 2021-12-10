using LLVM.Interop
using InteractiveUtils

@testset "interop" begin

@testset "base" begin

@generated function add_one(i)
    Context() do ctx
        T_int = convert(LLVMType, Int; ctx)

        f, ft = create_function(T_int, [T_int])

        Builder(ctx) do builder
            entry = BasicBlock(f, "entry"; ctx)
            position!(builder, entry)

            val = add!(builder, parameters(f)[1], ConstantInt(T_int, 1))

            ret!(builder, val)
        end

        call_function(f, Int, Tuple{Int}, :i)
    end
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

Context() do ctx
    @test isghosttype(GhostType; ctx)
    @test !isghosttype(NonGhostType1; ctx)
    @test !isghosttype(NonGhostType2; ctx)
end

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


@testset "passes" begin


Context() do ctx
LLVM.Module("SomeModule"; ctx) do mod
ModulePassManager() do pm

demote_float16!(pm)
julia_licm!(pm)
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
remove_ni!(pm)
late_lower_gc_frame!(pm)
final_lower_gc!(pm)
cpu_features!(pm)

end
end
end

end


@testset "intrinsics" begin
    @test assume(true) === nothing
    @test assume() do
        true
    end === nothing
    @test assume(rand()) do x
        0 <= x <= 1
    end isa Float64
end

using Core: LLVMPtr

@testset "pointer operations" begin
    a = LLVMPtr{Int,0}(0)
    b = LLVMPtr{Int,0}(1)
    c = LLVMPtr{UInt,0}(0)
    d = LLVMPtr{UInt,0}(1)
    e = LLVMPtr{Int,1}(0)
    f = LLVMPtr{Int,1}(1)

    @test UInt(a) == 0
    @test UInt(f) == 1

    @test isequal(a,a)
    @test !isequal(a,b)
    @test !isequal(a,c)
    @test !isequal(a,d)
    @test !isequal(a,e)
    @test !isequal(a,f)

    @test a == a
    @test a != b
    @test a == c
    @test a != d
    @test a != e
    @test a != f

    @test a < b
    @test a < d
    @test_throws MethodError a < f

    @test b - a == 1
    @test d - a == 1
    @test_throws MethodError  f - a

    @test a + 1 == b
    @test c + 1 == d
    @test e + 1 == f

    @test b - 1 == a
    @test d - 1 == c
    @test f - 1 == e
end

@testset "unsafe_load" begin
    a = Int64[1]
    ptr = reinterpret(Core.LLVMPtr{Int64,0}, pointer(a))
    @test unsafe_load(ptr) == 1
    unsafe_store!(ptr, 2)
    @test unsafe_load(ptr) == 2

    ir = sprint(io->code_llvm(io, unsafe_load, Tuple{typeof(ptr)}))
    if Sys.iswindows() && Sys.WORD_SIZE == 32
        # FIXME: Win32 nightly emits a i64*, even though bitstype_to_llvm uses T_int8
        @test_broken contains(ir, r"@julia_unsafe_load_\d+\(i8\*")
    else
        @test contains(ir, r"@julia_unsafe_load_\d+\(i8\*")
    end
    @test contains(ir, r"load i64, i64\* %\d+, align 1")

    ir = sprint(io->code_llvm(io, unsafe_load, Tuple{typeof(ptr), Int, Val{4}}))
    @test contains(ir, r"load i64, i64\* %\d+, align 4")
end

@testset "reinterpret(Nothing, nothing)" begin
    ptr = reinterpret(Core.LLVMPtr{Nothing,0}, C_NULL)
    @test unsafe_load(ptr) === nothing
end

@testset "TBAA" begin
    load(ptr) = unsafe_load(ptr)
    store(ptr) = unsafe_store!(ptr, 0)

    for f in (load, store)
        ir = sprint(io->code_llvm(io, f,
                                  Tuple{Core.LLVMPtr{Float32,1}};
                                  dump_module=true, raw=true))
        @test occursin("custom_tbaa_addrspace(1)", ir)

        # no TBAA on generic pointers
        ir = sprint(io->code_llvm(io, f,
                                  Tuple{Core.LLVMPtr{Float32,0}};
                                  dump_module=true, raw=true))
        @test !occursin("custom_tbaa", ir)
    end
end

@testset "ghost values" begin
    @eval struct Singleton end

    ir = sprint(io->code_llvm(io, unsafe_load,
                              Tuple{Core.LLVMPtr{Singleton,0}}))
    @test occursin("ret void", ir)
    @test unsafe_load(reinterpret(Core.LLVMPtr{Singleton,0}, C_NULL)) === Singleton()

    ir = sprint(io->code_llvm(io, unsafe_store!,
                              Tuple{Core.LLVMPtr{Singleton,0},
                              Singleton}))
    @test !occursin("\bstore\b", ir)
end

@testset "type-preserving ccall" begin
    # NOTE: the auto-upgrader will remangle these intrinsics, but only if they were
    #       specified in the first place (`if Name.startswith("ptr.annotation.")`)
    bad(ptr::Ptr{T}) where {T} = ccall("llvm.ptr.annotation.p0i64", llvmcall, Ptr{T}, (Ptr{T}, Ptr{Int8}, Ptr{Int8}, Int32), ptr, C_NULL, C_NULL, 0)
    good(ptr::Ptr{T}) where {T} = @typed_ccall("llvm.ptr.annotation.p0i64", llvmcall, Ptr{T}, (Ptr{T}, Ptr{Int8}, Ptr{Int8}, Int32), ptr, C_NULL, C_NULL, 0)

    ir = sprint(io->code_llvm(io, bad, Tuple{Ptr{Float64}}))
    @test occursin("i64 @llvm.ptr.annotation.p0i64(i64", ir)

    ir = sprint(io->code_llvm(io, good, Tuple{Ptr{Float64}}))
    @test occursin("double* @llvm.ptr.annotation.p0f64(double*", ir)

    bad(ptr::LLVMPtr{T}) where {T} = ccall("llvm.ptr.annotation.p0i64", llvmcall, LLVMPtr{T,1}, (LLVMPtr{T,1}, Ptr{Int8}, Ptr{Int8}, Int32), ptr, C_NULL, C_NULL, 0)
    good(ptr::LLVMPtr{T}) where {T} = @typed_ccall("llvm.ptr.annotation.p0i64", llvmcall, LLVMPtr{T,1}, (LLVMPtr{T,1}, Ptr{Int8}, Ptr{Int8}, Int32), ptr, C_NULL, C_NULL, 0)

    ir = sprint(io->code_llvm(io, bad, Tuple{LLVMPtr{Float64,1}}))
    # XXX: why isn't this remangled to p1i8? and why doesn't it currently assert somewhere?
    @test occursin("i8 addrspace(1)* @llvm.ptr.annotation.p0i64(i8 addrspace(1)*", ir)

    ir = sprint(io->code_llvm(io, good, Tuple{LLVMPtr{Float64,1}}))
    @test occursin("double addrspace(1)* @llvm.ptr.annotation.p1f64(double addrspace(1)*", ir)

    # test return nothing
    LLVM.Interop.@typed_ccall("llvm.donothing", llvmcall, Cvoid, ())
end

end
