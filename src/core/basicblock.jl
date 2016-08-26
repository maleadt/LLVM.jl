# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueBasicBlock.html

export BasicBlock, unsafe_delete!,
       parent, terminator,
       move_before, move_after

import Base: delete!

# NOTE: BasicBlock is the only class which can be represented by two ref kinds, which
#       the @reftypedef macro now plainly emits two `ref` methods for`
#       This matches the LLVMValueAsBasicBlock/LLVMBasicBlockAsValue behavior.
#       If it ever doesn't, we need to provide custom `ref` methods here.
# TODO: just do it already

BasicBlock(fn::LLVMFunction, name::String) = 
    BasicBlock(API.LLVMAppendBasicBlock(ref(Value, fn), name))
BasicBlock(fn::LLVMFunction, name::String, ctx::Context) = 
    BasicBlock(API.LLVMAppendBasicBlockInContext(ref(Context, ctx), ref(Value, fn), name))
BasicBlock(bb::BasicBlock, name::String) = 
    BasicBlock(API.LLVMInsertBasicBlock(ref(BasicBlock, bb), name))
BasicBlock(bb::BasicBlock, name::String, ctx::Context) = 
    BasicBlock(API.LLVMInsertBasicBlockInContext(ref(Context, ctx), ref(BasicBlock, bb), name))

unsafe_delete!(::LLVMFunction, bb::BasicBlock) = API.LLVMDeleteBasicBlock(ref(BasicBlock, bb))
delete!(::LLVMFunction, bb::BasicBlock) =
    API.LLVMRemoveBasicBlockFromParent(ref(BasicBlock, bb))

parent(bb::BasicBlock) =
    construct(LLVMfunction, API.LLVMGetBasicBlockParent(ref(BasicBlock, bb)))

terminator(bb::BasicBlock) =
    construct(Instruction, API.LLVMGetBasicBlockTerminator(ref(BasicBlock, bb)))

move_before(bb::BasicBlock, pos::BasicBlock) =
    API.LLVMMoveBasicBlockBefore(ref(BasicBlock, bb), ref(BasicBlock, pos))
move_after(bb::BasicBlock, pos::BasicBlock) =
    API.LLVMMoveBasicBlockAfter(ref(BasicBlock, bb), ref(BasicBlock, pos))


## instruction iteration

export instructions

import Base: eltype, start, next, done, last, collect

immutable BasicBlockInstructionSet
    bb::BasicBlock
end

instructions(bb::BasicBlock) = BasicBlockInstructionSet(bb)

eltype(::BasicBlockInstructionSet) = Instruction

start(iter::BasicBlockInstructionSet) = API.LLVMGetFirstInstruction(ref(BasicBlock, iter.bb))

next(::BasicBlockInstructionSet, state) =
    (construct(Instruction,state), API.LLVMGetNextInstruction(state))

done(::BasicBlockInstructionSet, state) = state == C_NULL

last(iter::BasicBlockInstructionSet) =
    construct(Instruction, API.LLVMGetLastInstruction(ref(BasicBlock, iter.bb)))

# NOTE: lacking length(), we need to implement this ourselves
function collect(iter::BasicBlockInstructionSet)
    els = Vector{eltype(iter)}()
    for el in iter
        push!(els, el)
    end
    return els
end
