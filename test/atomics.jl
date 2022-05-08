using InteractiveUtils
using LLVM.Interop
using Test

coreptr(r::Base.RefValue) = reinterpret(Ptr{eltype(r)}, pointer_from_objref(r))
llvmptr(r::Base.RefValue) = reinterpret(Core.LLVMPtr{eltype(r),0}, pointer_from_objref(r))

# Testing that ordering can be const-prop'ed
atomic_pointerref_monotonic(ptr) = Interop.atomic_pointerref(ptr, :monotonic)
atomic_pointerset_monotonic(ptr, x) = Interop.atomic_pointerset(ptr, x, :monotonic)
atomic_pointermodify_monotonic(ptr, op::OP, x) where {OP} =
    Interop.atomic_pointermodify(ptr, op, x, :monotonic)
atomic_pointerswap_monotonic(ptr, x) = Interop.atomic_pointerswap(ptr, x, :monotonic)
atomic_pointerreplace_monotonic(ptr, expected, desired) =
    Interop.atomic_pointerreplace(ptr, expected, desired, :monotonic, :monotonic)

muladd1(x, y) = muladd(x, y, one(x))

MONOTONIC = :monotonic

@testset for T in
             [Int8, Int16, Int32, Int64, UInt8, UInt16, UInt32, UInt64, Float32, Float64]
    r1 = Ref(one(T))
    r2 = Ref(one(T))
    GC.@preserve r1 r2 begin
        p1 = llvmptr(r1)
        sp1 = coreptr(r1)
        sp2 = coreptr(r2)

        @test atomic_pointerref_monotonic(p1) === r1[]
        @test Interop.atomic_pointerref(p1, MONOTONIC) === r1[]
        @test Interop.atomic_pointerref(p1, Val(:monotonic)) === r1[]
        @test Interop.atomic_pointerref(p1, Val(:monotonic)) ===
              Core.Intrinsics.atomic_pointerref(sp1, :monotonic)

        types = typeof((p1, Val(:sequentially_consistent)))
        ir = sprint(io -> code_llvm(io, Interop.atomic_pointerref, types))
        @test occursin(r"load atomic .* seq_cst"m, ir)

        ir = sprint(io -> code_llvm(io, atomic_pointerref_monotonic, Tuple{typeof(p1)}))
        @test occursin(r"load atomic .* monotonic"m, ir)
        @test !occursin(r"load atomic .* seq_cst"m, ir)

        val = r1[] + one(r1[])
        @test begin
            Interop.atomic_pointerset(p1, val, MONOTONIC)
            r1[]
        end === val

        val = r1[] + one(r1[])
        @test begin
            Interop.atomic_pointerset(p1, val, Val(:monotonic))
            r1[]
        end === val

        val = r1[] + one(r1[])
        r2[] = r1[]
        @test begin
            Interop.atomic_pointerset(p1, val, Val(:monotonic))
            r1[]
        end === begin
            Core.Intrinsics.atomic_pointerset(sp2, val, :monotonic)
            r2[]
        end

        types = typeof((p1, val, Val(:sequentially_consistent)))
        ir = sprint(io -> code_llvm(io, Interop.atomic_pointerset, types))
        @test occursin(r"store atomic .* seq_cst"m, ir)

        ir = sprint(io -> code_llvm(io, atomic_pointerset_monotonic, typeof((p1, val))))
        @test occursin(r"store atomic .* monotonic"m, ir)
        @test !occursin(r"store atomic .* seq_cst"m, ir)

        ops = if T <: AbstractFloat
            Any[Interop.right, +, -]
        else
            Any[op for (_, op, _) in Interop.binoptable]
        end
        push!(ops, muladd1)

        old = r1[]
        @testset for op in ops
            r1[] = old
            val = one(old)
            @test begin
                Interop.atomic_pointermodify(p1, op, val, MONOTONIC)
                r1[]
            end === op(old, val)

            r1[] = old
            val = one(old)
            @test begin
                Interop.atomic_pointermodify(p1, op, val, Val(:monotonic))
                r1[]
            end === op(old, val)

            r1[] = r2[] = old
            val = one(old)
            @test begin
                Interop.atomic_pointermodify(p1, op, val, Val(:monotonic))
                r1[]
            end === begin
                Core.Intrinsics.atomic_pointermodify(sp2, op, val, :monotonic)
                r2[]
            end

            types = typeof((p1, op, val, Val(:sequentially_consistent)))
            ir = sprint(io -> code_llvm(io, Interop.atomic_pointermodify, types))
            if op === muladd1
                @test occursin(r"cmpxchg .* seq_cst"m, ir)
            else
                @test occursin(r"atomicrmw .* seq_cst"m, ir)
            end

            types = typeof((p1, op, val))
            ir = sprint(io -> code_llvm(io, atomic_pointermodify_monotonic, types))
            if op === muladd1
                @test occursin(r"cmpxchg .* monotonic"m, ir)
                @test !occursin(r"cmpxchg .* seq_cst"m, ir)
            else
                @test occursin(r"atomicrmw .* monotonic"m, ir)
                @test !occursin(r"atomicrmw .* seq_cst"m, ir)
            end
        end

        r1[] = old
        val = one(old)
        @test (atomic_pointerswap_monotonic(p1, val), r1[]) === (old, val)

        r1[] = old
        val = one(old)
        @test (Interop.atomic_pointerswap(p1, val, MONOTONIC), r1[]) === (old, val)

        r1[] = old
        val = one(old)
        @test (Interop.atomic_pointerswap(p1, val, Val(:monotonic)), r1[]) === (old, val)

        r1[] = r2[] = old
        val = one(old)
        @test (Interop.atomic_pointerswap(p1, val, Val(:monotonic)), r1[]) ===
              (Core.Intrinsics.atomic_pointerswap(sp2, val, :monotonic), r2[])

        types = typeof((p1, val, Val(:sequentially_consistent)))
        ir = sprint(io -> code_llvm(io, Interop.atomic_pointerswap, types))
        @test occursin(r"atomicrmw xchg .* seq_cst"m, ir)

        ir = sprint(io -> code_llvm(io, atomic_pointerswap_monotonic, typeof((p1, val))))
        @test occursin(r"atomicrmw xchg .* monotonic"m, ir)
        @test !occursin(r"atomicrmw xchg .* seq_cst"m, ir)

        r1[] = old
        val = old + one(old)
        @test (atomic_pointerreplace_monotonic(p1, old, val), r1[]) ===
              ((; old, success = true), val)
        @test (atomic_pointerreplace_monotonic(p1, old, val), r1[]) ===
              ((; old = val, success = false), val)

        r1[] = old
        val = old + one(old)
        @test (Interop.atomic_pointerreplace(p1, old, val, MONOTONIC, MONOTONIC), r1[]) ===
              ((; old, success = true), val)
        @test (Interop.atomic_pointerreplace(p1, old, val, MONOTONIC, MONOTONIC), r1[]) ===
              ((; old = val, success = false), val)

        r1[] = old
        val = old + one(old)
        @test (
            Interop.atomic_pointerreplace(p1, old, val, Val(:monotonic), Val(:monotonic)),
            r1[],
        ) === ((; old, success = true), val)
        @test (
            Interop.atomic_pointerreplace(p1, old, val, Val(:monotonic), Val(:monotonic)),
            r1[],
        ) === ((; old = val, success = false), val)

        types = typeof((p1, old, val, Val(:acquire_release), Val(:acquire)))
        ir = sprint(io -> code_llvm(io, Interop.atomic_pointerreplace, types))
        @test occursin(r"cmpxchg .* acq_rel acquire"m, ir)

        types = typeof((p1, old, val))
        ir = sprint(io -> code_llvm(io, atomic_pointerreplace_monotonic, types))
        @test occursin(r"cmpxchg .* monotonic monotonic"m, ir)
        @test !occursin(r"cmpxchg .* seq_cst seq_cst"m, ir)
    end
end

primitive type B64 64 end
B64(x) = reinterpret(B64, convert(Int64, x))

@testset "primitive type" begin
    ref = Ref(B64(123))
    ord = Val(:monotonic)
    GC.@preserve ref begin
        ptr = llvmptr(ref)
        @test Interop.atomic_pointerref(ptr, ord) === ref[]
        @test begin
            Interop.atomic_pointerset(ptr, B64(456), ord)
            ref[]
        end === B64(456)
        @test Interop.atomic_pointerswap(ptr, B64(789), ord) === B64(456)
        @test ref[] === B64(789)
        @test Interop.atomic_pointerreplace(ptr, B64(789), B64(123), ord, ord) ===
              (old = B64(789), success = true)
        @test ref[] === B64(123)
        @test Interop.atomic_pointerreplace(ptr, B64(789), B64(123), ord, ord) ===
              (old = B64(123), success = false)
    end
end
