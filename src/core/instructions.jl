export Instruction, unsafe_delete!,
       hasmetadata, metadata, metadata!,
       parent, opcode,
       predicate_int, predicate_real

import Base: delete!

# forward definition of Instruction in src/core/value/constant.jl
identify(::Type{Value}, ::Val{API.LLVMInstructionValueKind}) = Instruction

identify(::Type{Instruction}, ref::API.LLVMValueRef) =
    identify(Instruction, Val{API.LLVMGetInstructionOpcode(ref)}())
identify{K}(::Type{Instruction}, ::Val{K}) = bug("Unknown instruction kind $K")

@inline function check{T<:Instruction}(::Type{T}, ref::API.LLVMValueRef)
    ref==C_NULL && throw(NullException())
    @static if DEBUG
        T′ = identify(Instruction, ref)
        if T != T′
            error("invalid conversion of $T′ instruction reference to $T")
        end
    end
end

# Construct a concretely typed instruction object from an abstract value ref
function Instruction(ref::API.LLVMValueRef)
    ref == C_NULL && throw(NullException())
    T = identify(Instruction, ref)
    return T(ref)
end

Instruction(inst::Instruction) =
    Instruction(API.LLVMInstructionClone(ref(inst)))

unsafe_delete!(::BasicBlock, inst::Instruction) =
    API.LLVMInstructionEraseFromParent(ref(inst))
delete!(::BasicBlock, inst::Instruction) =
    API.LLVMInstructionRemoveFromParent(ref(inst))


## metadata

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

hasmetadata(inst::Instruction) = convert(Core.Bool, API.LLVMHasMetadata(ref(inst)))

hasmetadata(inst::Instruction, kind::MD) = API.LLVMGetMetadata(ref(inst), Cuint(kind)) != C_NULL

metadata(inst::Instruction, kind::MD) =
    MetadataAsValue(API.LLVMGetMetadata(ref(inst), Cuint(kind)))
metadata!(inst::Instruction, kind::MD, node::MetadataAsValue) =
    API.LLVMSetMetadata(ref(inst), Cuint(kind), ref(node))
metadata!(inst::Instruction, kind::MD) =
    API.LLVMSetMetadata(ref(inst), Cuint(kind), convert(reftype(MetadataAsValue), C_NULL))

parent(inst::Instruction) =
    BasicBlock(API.LLVMGetInstructionParent(ref(inst)))

opcode(inst::Instruction) = API.LLVMGetInstructionOpcode(ref(inst))

predicate_int(inst::Instruction) = API.LLVMGetICmpPredicate(ref(inst))
predicate_real(inst::Instruction) = API.LLVMGetFCmpPredicate(ref(inst))


## instruction types

const opcodes = [:Ret, :Br, :Switch, :IndirectBr, :Invoke, :Unreachable, :Add, :FAdd, :Sub,
                 :FSub, :Mul, :FMul, :UDiv, :SDiv, :FDiv, :URem, :SRem, :FRem, :Shl, :LShr,
                 :AShr, :And, :Or, :Xor, :Alloca, :Load, :Store, :GetElementPtr, :Trunc,
                 :ZExt, :SExt, :FPToUI, :FPToSI, :UIToFP, :SIToFP, :FPTrunc, :FPExt,
                 :PtrToInt, :IntToPtr, :BitCast, :AddrSpaceCast, :ICmp, :FCmp, :PHI, :Call,
                 :Select, :UserOp1, :UserOp2, :VAArg, :ExtractElement, :InsertElement,
                 :ShuffleVector, :ExtractValue, :InsertValue, :Fence, :AtomicCmpXchg,
                 :AtomicRMW, :Resume, :LandingPad, :CleanupRet, :CatchRet, :CatchPad,
                 :CleanupPad, :CatchSwitch]

for op in opcodes
    typename = Symbol(op, :Inst)
    enum = Symbol(:LLVM, op)
    @eval begin
        @checked immutable $typename <: Instruction
            ref::reftype(Instruction)
        end
        identify(::Type{Instruction}, ::Val{API.$enum}) = $typename
    end
end


## call sites and invocations

export callconv, callconv!,
       istailcall, tailcall!,
       called_value

callconv(inst::Instruction) = API.LLVMGetInstructionCallConv(ref(inst))
callconv!(inst::Instruction, cc) =
    API.LLVMSetInstructionCallConv(ref(inst), Cuint(cc))

istailcall(inst::Instruction) = convert(Core.Bool, API.LLVMIsTailCall(ref(inst)))
tailcall!(inst::Instruction, bool) = API.LLVMSetTailCall(ref(inst), convert(Bool, bool))

called_value(inst::Instruction) = Value(API.LLVMGetCalledValue(ref( inst)))


## terminators

export isconditional, condition, condition!, default_dest

isconditional(br::Instruction) = convert(Core.Bool, API.LLVMIsConditional(ref(br)))

condition(br::Instruction) =
    Value(API.LLVMGetCondition(ref(br)))
condition!(br::Instruction, cond::Value) =
    API.LLVMSetCondition(ref(br), ref(cond))

default_dest(switch::Instruction) =
    BasicBlock(API.LLVMGetSwitchDefaultDest(ref(switch)))

# successor iteration

export successors

import Base: eltype, getindex, setindex!, start, next, done, length, endof

immutable TerminatorSuccessorSet
    term::Instruction
end

successors(term::Instruction) = TerminatorSuccessorSet(term)

eltype(::TerminatorSuccessorSet) = BasicBlock

getindex(iter::TerminatorSuccessorSet, i) =
    BasicBlock(API.LLVMGetSuccessor(ref(iter.term), Cuint(i-1)))

setindex!(iter::TerminatorSuccessorSet, bb::BasicBlock, i) =
    API.LLVMSetSuccessor(ref(iter.term), Cuint(i-1), blockref(bb))

start(iter::TerminatorSuccessorSet) = (1,length(iter))

next(iter::TerminatorSuccessorSet, state) =
    (iter[state[1]], (state[1]+1,state[2]))

done(::TerminatorSuccessorSet, state) = (state[1] > state[2])

length(iter::TerminatorSuccessorSet) = API.LLVMGetNumSuccessors(ref(iter.term))
endof(iter::TerminatorSuccessorSet) = length(iter)


## phi nodes

# incoming iteration

export PhiIncomingSet

import Base: eltype, getindex, append!, length

immutable PhiIncomingSet
    phi::Instruction
end

incoming(phi::Instruction) = PhiIncomingSet(phi)

eltype(::PhiIncomingSet) = Tuple{Value,BasicBlock}

getindex(iter::PhiIncomingSet, i) =
    tuple(Value(API.LLVMGetIncomingValue(ref(iter.phi), Cuint(i-1))),
                BasicBlock(API.LLVMGetIncomingBlock(ref(iter.phi), Cuint(i-1))))

function append!(iter::PhiIncomingSet, args::Vector{Tuple{Value, BasicBlock}})
    vals, blocks = zip(args...)
    API.LLVMAddIncoming(ref(iter.phi), ref.(vals),
                        ref.(blocks), length(args))
end

length(iter::PhiIncomingSet) = API.LLVMCountIncoming(ref(iter.phi))