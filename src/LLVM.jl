__precompile__()

module LLVM

using Compat
import Compat.String

module API
ext = joinpath(dirname(@__FILE__), "..", "deps", "ext.jl")
isfile(ext) || error("Unable to load $ext\n\nPlease re-run Pkg.build(\"LLVM\"), and restart Julia.")
include(ext)

# check whether the chosen LLVM is loaded already, ie. before having loaded it via `ccall`.
# if it isn't, we have exclusive access, allowing destructive operations (like shutting LLVM
# down).
#
# this check doesn't work in `__init__` because in the case of precompilation the
# deserializer already loads the library.
isfile(libllvm_path) ||
    error("LLVM library missing, run Pkg.build(\"LLVM\") to reconfigure LLVM.jl")
const exclusive = Libdl.dlopen_e(libllvm_path, Libdl.RTLD_NOLOAD) == C_NULL

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
        warn("LLVM library has been modified, run Pkg.build(\"LLVM\") to reconfigure LLVM.jl")

    _install_handlers()
    _install_handlers(GlobalContext())
end

end
