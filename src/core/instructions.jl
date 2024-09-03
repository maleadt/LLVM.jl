export Instruction, unsafe_delete!,
       opcode,
       predicate_int, predicate_real

# forward definition of Instruction in src/core/value/constant.jl
register(Instruction, API.LLVMInstructionValueKind)

const instruction_opcodes = Vector{Type}(fill(Nothing, typemax(API.LLVMOpcode)+1))
function identify(::Type{Instruction}, ref::API.LLVMValueRef)
    opcode = API.LLVMGetInstructionOpcode(ref)
    typ = @inbounds instruction_opcodes[opcode+1]
    typ === Nothing && error("Unknown type opcode $opcode")
    return typ
end
function register(T::Type{<:Instruction}, opcode::API.LLVMOpcode)
    instruction_opcodes[opcode+1] = T
end

function refcheck(::Type{T}, ref::API.LLVMValueRef) where T<:Instruction
    ref==C_NULL && throw(UndefRefError())
    if typecheck_enabled
        T′ = identify(Instruction, ref)
        if T != T′
            error("invalid conversion of $T′ instruction reference to $T")
        end
    end
end

# Construct a concretely typed instruction object from an abstract value ref
function Instruction(ref::API.LLVMValueRef)
    ref == C_NULL && throw(UndefRefError())
    T = identify(Instruction, ref)
    return T(ref)
end

Base.copy(inst::Instruction) = Instruction(API.LLVMInstructionClone(inst))

unsafe_delete!(::BasicBlock, inst::Instruction) =
    API.LLVMInstructionEraseFromParent(inst)
Base.delete!(::BasicBlock, inst::Instruction) =
    API.LLVMInstructionRemoveFromParent(inst)

parent(inst::Instruction) =
    BasicBlock(API.LLVMGetInstructionParent(inst))

opcode(inst::Instruction) = API.LLVMGetInstructionOpcode(inst)

# strip unnecessary whitespace
Base.show(io::IO, ::MIME"text/plain", inst::Instruction) = print(io, lstrip(string(inst)))

# instructions are typically only a single line, so always display them in full
Base.show(io::IO, inst::Instruction) = print(io, typeof(inst), "(", lstrip(string(inst)), ")")


## instruction types

const opcodes = [:Ret, :Br, :Switch, :IndirectBr, :Invoke, :Unreachable, :CallBr, :FNeg,
                 :Add, :FAdd, :Sub, :FSub, :Mul, :FMul, :UDiv, :SDiv, :FDiv, :URem, :SRem,
                 :FRem, :Shl, :LShr, :AShr, :And, :Or, :Xor, :Alloca, :Load, :Store,
                 :GetElementPtr, :Trunc, :ZExt, :SExt, :FPToUI, :FPToSI, :UIToFP, :SIToFP,
                 :FPTrunc, :FPExt, :PtrToInt, :IntToPtr, :BitCast, :AddrSpaceCast, :ICmp,
                 :FCmp, :PHI, :Call, :Select, :UserOp1, :UserOp2, :VAArg, :ExtractElement,
                 :InsertElement, :ShuffleVector, :ExtractValue, :InsertValue, :Freeze,
                 :Fence, :AtomicCmpXchg, :AtomicRMW, :Resume, :LandingPad, :CleanupRet,
                 :CatchRet, :CatchPad, :CleanupPad, :CatchSwitch]

for op in opcodes
    typename = Symbol(op, :Inst)
    enum = Symbol(:LLVM, op)
    @eval begin
        @checked struct $typename <: Instruction
            ref::API.LLVMValueRef
        end
        register($typename, API.$enum)
    end
end


## comparisons

predicate_int(inst::ICmpInst) = API.LLVMGetICmpPredicate(inst)

predicate_real(inst::FCmpInst) = API.LLVMGetFCmpPredicate(inst)


## atomics

export is_atomic, ordering, ordering!, SyncScope, syncscope, syncscope!

const AtomicInst = Union{LoadInst, StoreInst, FenceInst, AtomicRMWInst, AtomicCmpXchgInst}

is_atomic(inst::Instruction) = API.LLVMIsAtomic(inst) |> Bool

function ordering(inst::AtomicInst)
    is_atomic(inst) || throw(ArgumentError("Instruction is not atomic"))
    API.LLVMGetOrdering(inst)
end
function ordering!(inst::AtomicInst, ord::API.LLVMAtomicOrdering)
    # loads and stores can be made atomic by setting an ordering
    API.LLVMSetOrdering(inst, ord)
end

struct SyncScope
    id::Cuint
end

function SyncScope(name::String)
    # the default, system syncscope gets encoded as an empty string
    if name == "system"
        name = ""
    end
    SyncScope(API.LLVMGetSyncScopeID(context(), name, length(name)))
end

Base.convert(::Type{Cuint}, scope::SyncScope) = scope.id

function Base.show(io::IO, scope::SyncScope)
    if scope.id == 0
        print(io, "SyncScope(\"singlethread\")")
    elseif scope.id == 1
        print(io, "SyncScope(\"system\")")
    else
        print(io, "SyncScope(target-specific scope $(scope.id))")
    end
end

function syncscope(inst::AtomicInst)
    is_atomic(inst) || throw(ArgumentError("Instruction is not atomic"))
    SyncScope(API.LLVMGetAtomicSyncScopeID(inst))
end

function syncscope!(inst::AtomicInst, scope::SyncScope)
    is_atomic(inst) || throw(ArgumentError("Instruction is not atomic"))
    API.LLVMSetAtomicSyncScopeID(inst, scope)
end


## call sites and invocations

# TODO: add this to the actual type hierarchy
const CallBase = Union{CallBrInst, CallInst, InvokeInst}

export callconv, callconv!,
       istailcall, tailcall!,
       called_operand, arguments, called_type,
       OperandBundle, operand_bundles

callconv(inst::CallBase) = API.LLVMGetInstructionCallConv(inst)
callconv!(inst::CallBase, cc) =
    API.LLVMSetInstructionCallConv(inst, cc)

istailcall(inst::CallBase) = API.LLVMIsTailCall(inst) |> Bool
tailcall!(inst::CallBase, bool) = API.LLVMSetTailCall(inst, bool)

called_operand(inst::CallBase) = Value(API.LLVMGetCalledValue(inst))

function called_type(inst::CallBase)
    @static if version() >= v"11"
        LLVMType(API.LLVMGetCalledFunctionType(inst))
    else
        value_type(called_operand(inst))
    end
end

function arguments(inst::CallBase)
    nargs = API.LLVMGetNumArgOperands(inst)
    operands(inst)[1:nargs]
end

# operand bundles

# NOTE: OperandBundle objects aren't LLVM IR objects, but created by the C API wrapper,
#       so we need to free them explicitly when we get or create them.

@checked mutable struct OperandBundle
    ref::API.LLVMOperandBundleRef
end
Base.unsafe_convert(::Type{API.LLVMOperandBundleRef}, bundle::OperandBundle) =
    bundle.ref

function OperandBundle(tag::String, args::Vector{<:Value}=Value[])
    bundle = OperandBundle(API.LLVMCreateOperandBundle(tag, length(tag), args, length(args)))
    finalizer(bundle) do obj
        API.LLVMDisposeOperandBundle(obj)
    end
end

struct OperandBundleIterator <: AbstractVector{OperandBundle}
    inst::Instruction
end

operand_bundles(inst::CallBase) = OperandBundleIterator(inst)

Base.size(iter::OperandBundleIterator) = (API.LLVMGetNumOperandBundles(iter.inst),)

Base.IndexStyle(::OperandBundleIterator) = IndexLinear()

function Base.getindex(iter::OperandBundleIterator, i::Int)
    @boundscheck 1 <= i <= length(iter) || throw(BoundsError(iter, i))
    bundle = OperandBundle(API.LLVMGetOperandBundleAtIndex(iter.inst, i-1))
    finalizer(bundle) do obj
        API.LLVMDisposeOperandBundle(obj)
    end
end

function tag(bundle::OperandBundle)
    len = Ref{Csize_t}()
    data = API.LLVMGetOperandBundleTag(bundle, len)
    unsafe_string(convert(Ptr{Int8}, data), len[])
end

struct OperandBundleInputIterator <: AbstractVector{Value}
    bundle::OperandBundle
end

inputs(bundle::OperandBundle) = OperandBundleInputIterator(bundle)

Base.size(iter::OperandBundleInputIterator) = (API.LLVMGetNumOperandBundleArgs(iter.bundle),)

Base.IndexStyle(::OperandBundleInputIterator) = IndexLinear()

function Base.getindex(iter::OperandBundleInputIterator, i::Int)
    @boundscheck 1 <= i <= length(iter) || throw(BoundsError(iter, i))
    Value(API.LLVMGetOperandBundleArgAtIndex(iter.bundle, i-1))
end

function Base.string(bundle::OperandBundle)
    # mimic how bundles are rendered in LLVM IR
    "\"$(tag(bundle))\"(" * join(string.(inputs(bundle)), ", ") * ")"
end

function Base.show(io::IO, ::MIME"text/plain", bundle::OperandBundle)
    print(io, string(bundle))
end

Base.show(io::IO, bundle::OperandBundle) =
    print(io, typeof(bundle), "(", string(bundle), ")")


## terminators

export isterminator, isconditional, condition, condition!, default_dest

isterminator(inst::Instruction) = API.LLVMIsATerminatorInst(inst) != C_NULL

isconditional(br::BrInst) = API.LLVMIsConditional(br) |> Bool

condition(br::BrInst) = Value(API.LLVMGetCondition(br))
condition!(br::BrInst, cond::Value) = API.LLVMSetCondition(br, cond)

default_dest(switch::SwitchInst) = BasicBlock(API.LLVMGetSwitchDefaultDest(switch))

# successor iteration

export successors

struct TerminatorSuccessorSet <: AbstractVector{BasicBlock}
    term::Instruction
end

successors(term::Instruction) = TerminatorSuccessorSet(term)

Base.size(iter::TerminatorSuccessorSet) = (API.LLVMGetNumSuccessors(iter.term),)

Base.IndexStyle(::TerminatorSuccessorSet) = IndexLinear()

function Base.getindex(iter::TerminatorSuccessorSet, i::Int)
    @boundscheck 1 <= i <= length(iter) || throw(BoundsError(iter, i))
    return BasicBlock(API.LLVMGetSuccessor(iter.term, i-1))
end

Base.setindex!(iter::TerminatorSuccessorSet, bb::BasicBlock, i::Int) =
    API.LLVMSetSuccessor(iter.term, i-1, bb)


## phi nodes

# incoming iteration

export incoming

struct PhiIncomingSet <: AbstractVector{Tuple{Value,BasicBlock}}
    phi::Instruction
end

incoming(phi::PHIInst) = PhiIncomingSet(phi)

Base.size(iter::PhiIncomingSet) = (API.LLVMCountIncoming(iter.phi),)

Base.IndexStyle(::PhiIncomingSet) = IndexLinear()

function Base.getindex(iter::PhiIncomingSet, i::Int)
    @boundscheck 1 <= i <= length(iter) || throw(BoundsError(iter, i))
    return tuple(Value(API.LLVMGetIncomingValue(iter.phi, i-1)),
                       BasicBlock(API.LLVMGetIncomingBlock(iter.phi, i-1)))
end

function Base.append!(iter::PhiIncomingSet, args::Vector{Tuple{V, BasicBlock}} where V <: Value)
    vals, blocks = zip(args...)
    API.LLVMAddIncoming(iter.phi, collect(vals), collect(blocks), length(args))
end

Base.push!(iter::PhiIncomingSet, args::Tuple{<:Value, BasicBlock}) = append!(iter, [args])


## floating point operations

export fast_math, fast_math!

"""
    fast_math(inst::Instruction)

Get the fast math flags on an instruction.
"""
function fast_math(inst::Instruction)
    if !Bool(API.LLVMCanValueUseFastMathFlags(inst))
        throw(ArgumentError("Instruction cannot use fast math flags"))
    end
    flags = API.LLVMGetFastMathFlags(inst)
    return (;
        nnan = flags & LLVM.API.LLVMFastMathNoNaNs != 0,
        ninf = flags & LLVM.API.LLVMFastMathNoInfs != 0,
        nsz = flags & LLVM.API.LLVMFastMathNoSignedZeros != 0,
        arcp = flags & LLVM.API.LLVMFastMathAllowReciprocal != 0,
        contract = flags & LLVM.API.LLVMFastMathAllowContract != 0,
        afn = flags & LLVM.API.LLVMFastMathApproxFunc != 0,
        reassoc = flags & LLVM.API.LLVMFastMathAllowReassoc != 0,
    )
end

"""
    fast_math!(inst::Instruction; [flag=...], [all=...])

Set the fast math flags on an instruction. If `all` is `true`, then all flags are set.

The following flags are supported:
 - `nnan`: assume arguments and results are not NaN
 - `ninf`: assume arguments and results are not Inf
 - `nsz`: treat the sign of zero arguments and results as insignificant
 - `arcp`: allow use of reciprocal rather than perform division
 - `contract`: allow contraction of operations
 - `afn`: allow substitution of approximate calculations for functions
 - `reassoc`: allow reassociation of operations
"""
function fast_math!(inst::Instruction; nnan=false, ninf=false, nsz=false, arcp=false,
                          contract=false, afn=false, reassoc=false, all=false)
    if !Bool(API.LLVMCanValueUseFastMathFlags(inst))
        throw(ArgumentError("Instruction cannot use fast math flags"))
    end
    if all
        API.LLVMSetFastMathFlags(inst, LLVM.API.LLVMFastMathAll)
    else
        flags = 0
        nnan && (flags |= LLVM.API.LLVMFastMathNoNaNs)
        ninf && (flags |= LLVM.API.LLVMFastMathNoInfs)
        nsz && (flags |= LLVM.API.LLVMFastMathNoSignedZeros)
        arcp && (flags |= LLVM.API.LLVMFastMathAllowReciprocal)
        contract && (flags |= LLVM.API.LLVMFastMathAllowContract)
        afn && (flags |= LLVM.API.LLVMFastMathApproxFunc)
        reassoc && (flags |= LLVM.API.LLVMFastMathAllowReassoc)
        API.LLVMSetFastMathFlags(inst, flags)
    end
end
