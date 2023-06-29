struct PassBuilder
    roots::Vector{Any}
end

function PassBuilder(f::Core.Function, args...; kwargs...)
    pb = PassBuilder(args...; kwargs...)
    try
        f(pb)
    finally
        dispose(pb)
    end
end
