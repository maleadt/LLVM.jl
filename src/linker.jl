export link!

"""
    link!(dst::Module, src::Module)

Link the source module `src` into the destination module `dst`. The source module
is destroyed in the process.
"""
function link!(dst::Module, src::Module)
    status = API.LLVMLinkModules2(dst, src) |> Bool
    @assert !status # caught by diagnostics handler
    mark_dispose(src)

    return nothing
end
