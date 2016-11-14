__precompile__()

module LLVM

using Compat
import Compat.String

# auxiliary functionality
include("logging.jl")
include("util.jl")
include("api.jl")

# libLLVM wrapping
include("types.jl")
include("passregistry.jl")
include("init.jl")
include("core.jl")
include("linker.jl")
include("irbuilder.jl")
include("analysis.jl")
include("moduleprovider.jl")
include("pass.jl")
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
    # check validity of LLVM library
    debug("Checking validity of $(API.libllvm_path) (", (API.exclusive?"exclusive":"non-exclusive"), " access)")
    stat(API.libllvm_path).mtime == API.libllvm_mtime ||
        warn("LLVM library has been modified. Please re-run Pkg.build(\"LLVM\") and restart Julia.")

    __init_logging__()
   __init_api__()

    _install_handlers()
    _install_handlers(GlobalContext())
end

end
