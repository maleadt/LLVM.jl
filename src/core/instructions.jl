export Instruction, unsafe_delete!,
       hasmetadata, metadata, metadata!,
       parent, opcode,
       predicate_int, predicate_real

import Base: delete!

@reftypedef proxy=Value kind=LLVMInstructionValueKind immutable Instruction <: User end

# TODO: it would be nice to re-use the dynamic type reconstruction for instructions,
#       using the opcode to discriminate. Doesn't work now, because we need to be able to
#       convert to Instruction refs, and that machinery doesn't apply to abstract types.

Instruction(inst::Instruction) =
    construct(Instruction, API.LLVMInstructionClone(ref(inst)))

unsafe_delete!(::BasicBlock, inst::Instruction) =
    API.LLVMInstructionEraseFromParent(ref(inst))
delete!(::BasicBlock, inst::Instruction) =
    API.LLVMInstructionRemoveFromParent(ref(inst))

hasmetadata(inst::Instruction) = BoolFromLLVM(API.LLVMHasMetadata(ref(inst)))

metadata(inst::Instruction, kind) =
    construct(MetadataAsValue, API.LLVMGetMetadata(ref(inst), Cuint(kind)))
metadata!(inst::Instruction, kind, node::MetadataAsValue) =
    API.LLVMSetMetadata(ref(inst), Cuint(kind), ref(node))

parent(inst::Instruction) =
    BasicBlock(API.LLVMGetInstructionParent(ref(inst)))

opcode(inst::Instruction) = API.LLVMGetInstructionOpcode(ref(inst))

predicate_int(inst::Instruction) = API.LLVMGetICmpPredicate(ref(inst))
predicate_real(inst::Instruction) = API.LLVMGetFCmpPredicate(ref(inst))


## call sites and invocations

export callconv, callconv!,
       istailcall, tailcall!

callconv(inst::Instruction) = API.LLVMGetInstructionCallConv(ref(inst))
callconv!(inst::Instruction, cc) =
    API.LLVMSetInstructionCallConv(ref(inst), Cuint(cc))

istailcall(inst::Instruction) = BoolFromLLVM(API.LLVMIsTailCall(ref(inst)))
tailcall!(inst::Instruction, bool) = API.LLVMSetTailCall(ref(inst), BoolToLLVM(bool))

## terminators

export isconditional, condition, condition!, default_dest

isconditional(br::Instruction) = BoolFromLLVM(API.LLVMIsConditional(ref(br)))

condition(br::Instruction) =
    dynamic_construct(Value, API.LLVMGetCondition(ref(br)))
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
    tuple(construct(Value, API.LLVMGetIncomingValue(ref(iter.phi), Cuint(i-1))),
                BasicBlock(API.LLVMGetIncomingBlock(ref(iter.phi), Cuint(i-1))))

function append!(iter::PhiIncomingSet, args::Vector{Tuple{Value, BasicBlock}})
    vals, blocks = zip(args...)
    API.LLVMAddIncoming(ref(iter.phi), ref.(vals),
                        ref.(blocks), length(args))
end

length(iter::PhiIncomingSet) = API.LLVMCountIncoming(ref(iter.phi))
