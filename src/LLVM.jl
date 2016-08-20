module LLVM

using Compat
import Compat.String

module API
include(joinpath(dirname(@__FILE__), "..", "deps", "ext.jl"))
end

include("core.jl")

end