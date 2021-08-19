export Instruction, unsafe_delete!,
       metadata, metadata!,
       opcode,
       predicate_int, predicate_real

# forward definition of Instruction in src/core/value/constant.jl
value_kinds[API.LLVMInstructionValueKind] = Instruction

const instruction_opcodes = Dict{API.LLVMOpcode, Type{<:Instruction}}()
function identify(::Type{Instruction}, ref::API.LLVMValueRef)
    opcode = API.LLVMGetInstructionOpcode(ref)
    haskey(instruction_opcodes, opcode) || error("Unknown instruction opcode $opcode")
    return instruction_opcodes[opcode]
end

function refcheck(::Type{T}, ref::API.LLVMValueRef) where T<:Instruction
    ref==C_NULL && throw(UndefRefError())
    if Base.JLOptions().debug_level >= 2
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

Instruction(inst::Instruction) =
    Instruction(API.LLVMInstructionClone(inst))

unsafe_delete!(::BasicBlock, inst::Instruction) =
    API.LLVMInstructionEraseFromParent(inst)
Base.delete!(::BasicBlock, inst::Instruction) =
    API.LLVMInstructionRemoveFromParent(inst)

parent(inst::Instruction) =
    BasicBlock(API.LLVMGetInstructionParent(inst))

opcode(inst::Instruction) = API.LLVMGetInstructionOpcode(inst)

predicate_int(inst::Instruction) = API.LLVMGetICmpPredicate(inst)
predicate_real(inst::Instruction) = API.LLVMGetFCmpPredicate(inst)


## metadata iteration
# TODO: doesn't actually iterate, since we can't list the available keys

@enum(MD, MD_dbg = 0,
          MD_tbaa = 1,
          MD_prof = 2,
          MD_fpmath = 3,
          MD_range = 4,
          MD_tbaa_struct = 5,
          MD_invariant_load = 6,
          MD_alias_scope = 7,
          MD_noalias = 8,
          MD_nontemporal = 9,
          MD_mem_parallel_loop_access = 10,
          MD_nonnull = 11,
          MD_dereferenceable = 12,
          MD_dereferenceable_or_null = 13,
          MD_make_implicit = 14,
          MD_unpredictable = 15,
          MD_invariant_group = 16,
          MD_align = 17,
          MD_loop = 18,
          MD_type = 19,
          MD_section_prefix = 20,
          MD_absolute_symbol = 21,
          MD_associated = 22)

export InstructionMetadataDict

struct InstructionMetadataDict <: AbstractDict{MD,MetadataAsValue}
    inst::Instruction
end

metadata(inst::Instruction) = InstructionMetadataDict(inst)

Base.isempty(md::InstructionMetadataDict) =
  !convert(Core.Bool, API.LLVMHasMetadata(md.inst))

Base.haskey(md::InstructionMetadataDict, kind::MD) =
  API.LLVMGetMetadata(md.inst, kind) != C_NULL

function Base.getindex(md::InstructionMetadataDict, kind::MD)
    objref = API.LLVMGetMetadata(md.inst, kind)
    objref == C_NULL && throw(KeyError(kind))
    return Metadata(MetadataAsValue(objref))
  end

Base.setindex!(md::InstructionMetadataDict, node::Metadata, kind::MD) =
    API.LLVMSetMetadata(md.inst, kind, Value(node; ctx=context(md.inst)))

Base.delete!(md::InstructionMetadataDict, kind::MD) =
    API.LLVMSetMetadata(md.inst, kind, C_NULL)


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
        instruction_opcodes[API.$enum] = $typename
    end
end


## call sites and invocations

export callconv, callconv!,
       istailcall, tailcall!,
       called_value

callconv(inst::Instruction) = API.LLVMGetInstructionCallConv(inst)
callconv!(inst::Instruction, cc) =
    API.LLVMSetInstructionCallConv(inst, cc)

istailcall(inst::Instruction) = convert(Core.Bool, API.LLVMIsTailCall(inst))
tailcall!(inst::Instruction, bool) = API.LLVMSetTailCall(inst, convert(Bool, bool))

called_value(inst::Instruction) = Value(API.LLVMGetCalledValue(inst))


## terminators

export isterminator, isconditional, condition, condition!, default_dest

isterminator(inst::Instruction) = API.LLVMIsATerminatorInst(inst) != C_NULL

isconditional(br::Instruction) = convert(Core.Bool, API.LLVMIsConditional(br))

condition(br::Instruction) =
    Value(API.LLVMGetCondition(br))
condition!(br::Instruction, cond::Value) =
    API.LLVMSetCondition(br, cond)

default_dest(switch::Instruction) =
    BasicBlock(API.LLVMGetSwitchDefaultDest(switch))

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

export PhiIncomingSet

struct PhiIncomingSet <: AbstractVector{Tuple{Value,BasicBlock}}
    phi::Instruction
end

incoming(phi::Instruction) = PhiIncomingSet(phi)

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
