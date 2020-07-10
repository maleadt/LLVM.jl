# Example on how access experimental intrinsic in LLVM
#
# This example uses the constrained floating point intrinsics
# https://releases.llvm.org/6.0.0/docs/LangRef.html#constrained-floating-point-intrinsics
#
# Note that this will only change compile time behavior/optimizations and not the actual
# runtime behavior. For changing runtime behavior please use the SetRounding.jl package or a
# similar mechanism.
#
# This example is not complete and could use some better error handling

using LLVM
using LLVM.Interop

# TODO: select the right intrinsic overload (https://github.com/maleadt/LLVM.jl/issues/112)
suffix(::Type{Float64}) = "f64"
suffix(::Type{Float32}) = "f32"

# map Julia functions to llvm intrinsic
func(::Type{typeof(+)}) = "fadd"

# stub of a Trait system for the different modes
abstract type Round end
abstract type FPExcept end

struct RoundUpward <: Round end
struct FPExceptStrict <: FPExcept end

meta(::Type{RoundUpward}) = "round.upward"
meta(::Type{FPExceptStrict}) = "fpexcept.strict"

@generated function constrained(::F, ::Type{round}, ::Type{fpexcept}, xs::Vararg{T,N}) where
                               {F, round, fpexcept, T<:AbstractFloat, N}
    @assert N >= 0

    JuliaContext() do ctx
        typ = convert(LLVMType, T, ctx)

        # create a function
        paramtyps = [typ for i in 1:N]
        llvm_f, _ = create_function(typ, paramtyps)

        # create the intrinsic
        mtyp = LLVM.MetadataType(ctx)
        mround = MDString(meta(round), ctx)
        mfpexcept = MDString(meta(fpexcept), ctx)
        mod = LLVM.parent(llvm_f)
        intrinsic_typ = LLVM.FunctionType(typ, [paramtyps..., mtyp, mtyp])
        intrinsic = LLVM.Function(mod, "llvm.experimental.constrained.$(func(F)).$(suffix(T))",
                                intrinsic_typ)

        # generate IR
        Builder(ctx) do builder
            entry = BasicBlock(llvm_f, "entry", ctx)
            position!(builder, entry)
            val = call!(builder, intrinsic, [parameters(llvm_f)..., mround, mfpexcept])
            ret!(builder, val)
        end

        args = Expr(:tuple, (Expr(:ref, :xs, i) for i in 1:N)...)
        call_function(llvm_f, T, Tuple{(T for i in 1:N)...}, args)
    end
end

cadd(x, y) = constrained(+, RoundUpward, FPExceptStrict, x, y)

using Test
@test cadd(1.0, 2.0) == 3.0

using InteractiveUtils
io = IOBuffer()
code_llvm(io, cadd, (Float32, Float32))
seekstart(io)
@test occursin("@llvm.experimental.constrained.fadd.f32", String(take!(io)))
