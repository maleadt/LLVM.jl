export link!

function link!(dst::Module, src::Module)
    status = convert(Bool, API.LLVMLinkModules2(dst, src))
    @assert !status # caught by diagnostics handler

    return nothing
end
