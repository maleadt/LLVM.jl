__precompile__()

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

include("types.jl")
include("passregistry.jl")
include("init.jl")
include("core.jl")
include("linker.jl")
include("irbuilder.jl")
include("analysis.jl")
include("moduleprovider.jl")
include("passmanager.jl")
include("execution.jl")
include("buffer.jl")
include("target.jl")
include("targetmachine.jl")
include("datalayout.jl")
include("ir.jl")
include("bitcode.jl")
include("transform.jl")

function __init__()
    debug("Checking validity of $(API.lib_path) (", (API.exclusive?"exclusive":"non-exclusive"), " access)")
    isfile(API.lib_path) ||
        error("LLVM library missing, run Pkg.build(\"LLVM\") to reconfigure LLVM.jl")
    stat(API.lib_path).mtime == API.lib_mtime ||
        warn("LLVM library has been modified, run Pkg.build(\"LLVM\") to reconfigure LLVM.jl")

    _install_handlers()
    _install_handlers(GlobalContext())
end

end
