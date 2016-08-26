# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueBasicBlock.html

export BasicBlock, unsafe_delete!,
       parent, terminator,
       move_before, move_after

import Base: delete!

BasicBlock(ref::API.LLVMBasicBlockRef) = BasicBlock(API.LLVMBasicBlockAsValue(ref))
blockref(bb::BasicBlock) = API.LLVMValueAsBasicBlock(ref(bb))

BasicBlock(fn::LLVMFunction, name::String) = 
    BasicBlock(API.LLVMAppendBasicBlock(ref(fn), name))
BasicBlock(fn::LLVMFunction, name::String, ctx::Context) = 
    BasicBlock(API.LLVMAppendBasicBlockInContext(ref(ctx), ref(fn), name))
BasicBlock(bb::BasicBlock, name::String) = 
    BasicBlock(API.LLVMInsertBasicBlock(blockref(bb), name))
BasicBlock(bb::BasicBlock, name::String, ctx::Context) = 
    BasicBlock(API.LLVMInsertBasicBlockInContext(ref(ctx), blockref(bb), name))

unsafe_delete!(::LLVMFunction, bb::BasicBlock) = API.LLVMDeleteBasicBlock(blockref(bb))
delete!(::LLVMFunction, bb::BasicBlock) =
    API.LLVMRemoveBasicBlockFromParent(blockref(bb))

parent(bb::BasicBlock) =
    construct(LLVMFunction, API.LLVMGetBasicBlockParent(blockref(bb)))

terminator(bb::BasicBlock) =
    construct(Instruction, API.LLVMGetBasicBlockTerminator(blockref(bb)))

move_before(bb::BasicBlock, pos::BasicBlock) =
    API.LLVMMoveBasicBlockBefore(blockref(bb), blockref(pos))
move_after(bb::BasicBlock, pos::BasicBlock) =
    API.LLVMMoveBasicBlockAfter(blockref(bb), blockref(pos))


## instruction iteration

export instructions

import Base: eltype, start, next, done, last, length

immutable BasicBlockInstructionSet
    bb::BasicBlock
end

instructions(bb::BasicBlock) = BasicBlockInstructionSet(bb)

eltype(::BasicBlockInstructionSet) = Instruction

start(iter::BasicBlockInstructionSet) = API.LLVMGetFirstInstruction(blockref(iter.bb))

next(::BasicBlockInstructionSet, state) =
    (construct(Instruction,state), API.LLVMGetNextInstruction(state))

done(::BasicBlockInstructionSet, state) = state == C_NULL

last(iter::BasicBlockInstructionSet) =
    construct(Instruction, API.LLVMGetLastInstruction(blockref(iter.bb)))

# NOTE: this is expensive, but the iteration interface requires it to be implemented
function length(iter::BasicBlockInstructionSet)
    count = 0
    for inst in iter
        count += 1
    end
    return count
end
