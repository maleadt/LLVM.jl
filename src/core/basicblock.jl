export BasicBlock, unsafe_delete!,
       terminator, name,
       move_before, move_after

@checked struct BasicBlock <: Value
    ref::API.LLVMValueRef
end
value_kinds[API.LLVMBasicBlockValueKind] = BasicBlock

BasicBlock(ref::API.LLVMBasicBlockRef) = BasicBlock(API.LLVMBasicBlockAsValue(ref))
Base.unsafe_convert(::Type{API.LLVMBasicBlockRef}, bb::BasicBlock) = API.LLVMValueAsBasicBlock(bb)

# forward declarations
@checked struct Function <: GlobalObject
    ref::API.LLVMValueRef
end

BasicBlock(f::Function, name::String; ctx::Context) =
    BasicBlock(API.LLVMAppendBasicBlockInContext(ctx, f, name))
BasicBlock(bb::BasicBlock, name::String; ctx::Context) =
    BasicBlock(API.LLVMInsertBasicBlockInContext(ctx, bb, name))

unsafe_delete!(::Function, bb::BasicBlock) = API.LLVMDeleteBasicBlock(bb)
Base.delete!(::Function, bb::BasicBlock) =
    API.LLVMRemoveBasicBlockFromParent(bb)

parent(bb::BasicBlock) = Function(API.LLVMGetBasicBlockParent(bb))

terminator(bb::BasicBlock) = Instruction(API.LLVMGetBasicBlockTerminator(bb))

name(bb::BasicBlock) =
    unsafe_string(API.LLVMGetBasicBlockName(bb))

move_before(bb::BasicBlock, pos::BasicBlock) =
    API.LLVMMoveBasicBlockBefore(bb, pos)
move_after(bb::BasicBlock, pos::BasicBlock) =
    API.LLVMMoveBasicBlockAfter(bb, pos)


## instruction iteration

export instructions

struct BasicBlockInstructionSet
    bb::BasicBlock
end

instructions(bb::BasicBlock) = BasicBlockInstructionSet(bb)

Base.eltype(::BasicBlockInstructionSet) = Instruction

function Base.iterate(iter::BasicBlockInstructionSet,
                      state=API.LLVMGetFirstInstruction(iter.bb))
    state == C_NULL ? nothing : (Instruction(state), API.LLVMGetNextInstruction(state))
end

Base.last(iter::BasicBlockInstructionSet) =
    Instruction(API.LLVMGetLastInstruction(iter.bb))

Base.isempty(iter::BasicBlockInstructionSet) =
    API.LLVMGetLastInstruction(iter.bb) == C_NULL

Base.IteratorSize(::BasicBlockInstructionSet) = Base.SizeUnknown()
