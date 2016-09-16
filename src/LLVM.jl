module LLVM

using Compat
import Compat.String

module API
ext = joinpath(dirname(@__FILE__), "..", "deps", "ext.jl")
isfile(ext) || error("Unable to load $ext\n\nPlease re-run Pkg.build(\"LLVM\"), and restart Julia.")
include(ext)
end


include("logging.jl")
include("auxiliary.jl")

include("support.jl")
include("passregistry.jl")
include("init.jl")
include("core.jl")
include("irbuilder.jl")
include("analysis.jl")
include("moduleprovider.jl")
include("passmanager.jl")
include("execution.jl")
include("buffer.jl")
include("target.jl")
include("ir.jl")
include("bitcode.jl")
include("transform.jl")

end
