export Instruction, unsafe_delete!,
       hasmetadata, metadata, metadata!,
       parent,
       predicate_int, predicate_real

@reftypedef argtype=Value kind=LLVMInstructionValueKind immutable Instruction <: User end

# TODO: it would be nice to re-use the dynamic type reconstruction for instructions,
#       using the opcode to discriminate. Doesn't work now, because we need to be able to
#       convert to Instruction refs, and that machinery doesn't apply to abstract types.

Instruction(inst::Instruction) =
    construct(Instruction, API.LLVMInstructionClone(ref(Value, inst)))

unsafe_delete!(::BasicBlock, inst::Instruction) =
    API.LLVMInstructionEraseFromParent(ref(Value, inst))

hasmetadata(inst::Instruction) = BoolFromLLVM(API.LLVMHasMetadata(ref(Value, inst)))

metadata(inst::Instruction, kind) =
    construct(MetadataAsValue, API.LLVMGetMetadata(ref(Value, inst), Cuint(kind)))
metadata!(inst::Instruction, kind, node::MetadataAsValue) =
    API.LLVMSetMetadata(ref(Value, inst), Cuint(kind), ref(Value, node))

parent(inst::Instruction) =
    BasicBlock(API.LLVMGetInstructionParent(ref(Value, inst)))

predicate_int(inst::Instruction) = API.LLVMGetICmpPredicate(ref(Value, inst))
predicate_real(inst::Instruction) = API.LLVMGetFCmpPredicate(ref(Value, inst))


## call sites and invocations

export callconv, callconv!,
       istailcall, tailcall!

callconv(inst::Instruction) = API.LLVMGetInstructionCallConv(ref(Value, inst))
callconv!(inst::Instruction, cc) =
    API.LLVMSetInstructionCallConv(ref(Value, inst), Cuint(cc))

istailcall(inst::Instruction) = BoolFromLLVM(API.LLVMIsTailCall(ref(Value, inst)))
tailcall!(inst::Instruction, bool) = API.LLVMSetTailCall(ref(Value, inst), BoolToLLVM(bool))

## terminators

export isconditional, condition, condition!, default_dest

isconditional(br::Instruction) = BoolFromLLVM(API.LLVMIsConditional(ref(Value, br)))

condition(br::Instruction) =
    construct(Instruction, API.LLVMGetCondition(ref(Value, br)))
condition!(br::Instruction, cond::Value) =
    construct(Instruction, API.LLVMSetCondition(ref(Value, br), ref(Value, cond)))

default_dest(switch::Instruction) =
    BasicBlock(API.LLVMGetSwitchDefaultDest(ref(Value, switch)))

# successor iteration

import Base: eltype, getindex, setindex!, length

immutable TerminatorSuccessorSet
    term::Instruction
end

successors(term::Instruction) = TerminatorSuccessorSet(term)

eltype(::TerminatorSuccessorSet) = BasicBlock

getindex(iter::TerminatorSuccessorSet, i) =
    BasicBlock(API.LLVMGetSuccessor(ref(Value, iter.term), Cuint(i-1)))

setindex!(iter::TerminatorSuccessorSet, i, bb::BasicBlock) =
    BasicBlock(API.LLVMSetSuccessor(ref(Value, iter.term), Cuint(i), ref(BasicBlock, bb)))

length(iter::TerminatorSuccessorSet) = API.LLVMGetNumSuccessors(ref(Value, iter.term))


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
    tuple(construct(Value, API.LLVMGetIncomingValue(ref(Value, iter.phi), Cuint(i-1))),
                BasicBlock(API.LLVMGetIncomingBlock(ref(Value, iter.phi), Cuint(i-1))))

function append!(iter::PhiIncomingSet, args::Vector{Tuple{Value, BasicBlock}})
    vals, blocks = zip(args...)
    API.LLVMAddIncoming(ref(Value, iter.phi), ref.([Value], vals),
                        ref.([BasicBlock], blocks), length(args))
end

length(iter::PhiIncomingSet) = API.LLVMCountIncoming(ref(Value, iter.phi))
