export link!

function link!(dst::Module, src::Module)
    status = BoolFromLLVM(API.LLVMLinkModules2(ref(dst), ref(src)))
    @assert !status # caught by diagnostics handler

    return nothing
end
