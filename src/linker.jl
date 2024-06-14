export link!

function link!(dst::Module, src::Module)
    status = API.LLVMLinkModules2(dst, mark_dispose(src)) |> Bool
    @assert !status # caught by diagnostics handler

    return nothing
end
