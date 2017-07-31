export link!

function link!(dst::Module, src::Module)
    status = convert(Core.Bool, API.LLVMLinkModules2(ref(dst), ref(src)))
    @assert !status # caught by diagnostics handler

    return nothing
end
