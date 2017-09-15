# Move to LLVM.jl

function position_before_terminator!(builder::LLVM.Builder, bb::LLVM.BasicBlock)
    v = LLVM.API.LLVMGetBasicBlockTerminator(LLVM.blockref(bb))
    if v == C_NULL
        LLVM.position!(builder, bb)
    else
        i = LLVM.Instruction(LLVM.API.LLVMGetBasicBlockTerminator(LLVM.blockref(bb)))
        LLVM.position!(builder, i)
    end
end