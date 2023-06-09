export BasicBlock, unsafe_delete!,
       terminator, name,
       move_before, move_after

@checked struct BasicBlock <: Value
    ref::API.LLVMValueRef
end
register(BasicBlock, API.LLVMBasicBlockValueKind)

BasicBlock(ref::API.LLVMBasicBlockRef) = BasicBlock(API.LLVMBasicBlockAsValue(ref))
Base.unsafe_convert(::Type{API.LLVMBasicBlockRef}, bb::BasicBlock) = API.LLVMValueAsBasicBlock(bb)

# forward declarations
@checked struct Function <: GlobalObject
    ref::API.LLVMValueRef
end

# create empty
BasicBlock(name::String; ctx::Context) =
    BasicBlock(API.LLVMCreateBasicBlockInContext(ctx, name))
# append in function
# TODO: deprecate ctx keyword (why does the C API even have it?)
BasicBlock(f::Function, name::String; ctx) =
    BasicBlock(API.LLVMAppendBasicBlockInContext(context(f), f, name))
# insert before another
# TODO: deprecate ctx keyword (why does the C API even have it?)
BasicBlock(bb::BasicBlock, name::String; ctx) =
    BasicBlock(API.LLVMInsertBasicBlockInContext(context(bb), bb, name))

unsafe_delete!(::Function, bb::BasicBlock) = API.LLVMDeleteBasicBlock(bb)
Base.delete!(::Function, bb::BasicBlock) =
    API.LLVMRemoveBasicBlockFromParent(bb)

function parent(bb::BasicBlock)
    ref = API.LLVMGetBasicBlockParent(bb)
    ref == C_NULL && return nothing
    Function(ref)
end

function terminator(bb::BasicBlock)
    ref = API.LLVMGetBasicBlockTerminator(bb)
    ref == C_NULL && return nothing
    Instruction(ref)
end

name(bb::BasicBlock) = unsafe_string(API.LLVMGetBasicBlockName(bb))

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
