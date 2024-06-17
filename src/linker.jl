export link!

function link!(dst::Module, src::Module)
    status = API.LLVMLinkModules2(dst, src) |> Bool
    @assert !status # caught by diagnostics handler
    mark_dispose(src)

    return nothing
end
