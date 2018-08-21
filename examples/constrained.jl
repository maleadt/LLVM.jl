# Example on how access experimental intrinsic in LLVM
# Note:
#    that is example is using the constrained floating point instrinisc
#    https://releases.llvm.org/6.0.0/docs/LangRef.html#constrained-floating-point-intrinsics
#    but this will only change compile time behaviour/optimisations and not the actual runtime behaviour.
#    For changing runtime behaviour please use https://github.com/JuliaIntervals/SetRounding.jl/blob/master/src/SetRounding.jl
#    or a similar mechanism.
# Note:
#     This example is not complete and could use some better error handling

using LLVM
using LLVM.Interop

# Select the right intrinsic overload https://github.com/maleadt/LLVM.jl/issues/112
suffix(::Type{Float64}) = "f64"
suffix(::Type{Float32}) = "f32"

# Map Julia functions to llvm intrinsic
func(::Type{typeof(+)}) = "fadd"

# Stub of a Trait system for the different modes
abstract type Round end
abstract type FPExcept end

struct RoundUpward <: Round end
struct FPExceptStrict <: FPExcept end

meta(::Type{RoundUpward}) = "round.upward"
meta(::Type{FPExceptStrict}) = "fpexcept.strict"

@generated function constrained(::F, ::Type{round}, ::Type{fpexcept}, xs::Vararg{T,N}) where {F, round, fpexcept, T<:AbstractFloat, N}
    @assert N >= 0
    ctx = JuliaContext()

    # Create a llvm function for which we will build IR
    typ = convert(LLVMType, T)
    paramtyps = [typ for i in 1:N]
    llvmf, _ = create_function(typ, paramtyps)

    # Create the declaration of the instrinisc to be called
    mtyp = LLVM.MetadataType(JuliaContext())
    mround = MDString(meta(round), JuliaContext())
    mfpexcept = MDString(meta(fpexcept), JuliaContext())
    intrinsic, _ = create_function(typ, [paramtyps..., mtyp, mtyp],
                                   "llvm.experimental.constrained.$(func(F)).$(suffix(T))")

    # generate IR
    Builder(JuliaContext()) do builder
        entry = BasicBlock(llvmf, "entry", JuliaContext())
        position!(builder, entry)
        val = call!(builder, intrinsic, [parameters(llvmf)..., mround, mfpexcept])
        ret!(builder, val)
    end

    args = Expr(:tuple, (Expr(:ref, :xs, i) for i in 1:N)...)
    call_function(llvmf, T, Tuple{(T for i in 1:N)...}, args)
end

cadd(x, y) = constrained(+, RoundUpward, FPExceptStrict, x, y)

using Test
using InteractiveUtils
@test cadd(1.0, 2.0) == 3.0

io = IOBuffer()
code_llvm(io, cadd, (Float32, Float32))
seekstart(io)
@test occursin("@llvm.experimental.constrained.fadd.f32", String(take!(io)))