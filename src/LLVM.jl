__precompile__()

module LLVM

using Compat
import Compat.String

module API
ext = joinpath(dirname(@__FILE__), "..", "deps", "ext.jl")
isfile(ext) || error("Unable to load $ext\n\nPlease re-run Pkg.build(\"LLVM\"), and restart Julia.")
include(ext)

# check validity of LLVM and Julia libraries
#
# NOTE: these checks are precompile-incompatible (because they check whether loading our
#       LLVM wrapper library might fail) as the deserializer already loads the library.
#       They also need to happen before loading the library (which might fail),
#       so we put it here rather than in __init__.
isfile(libllvm_path) ||
    error("LLVM library missing, run Pkg.build(\"LLVM\") to reconfigure LLVM.jl")
julia_library = if ccall(:jl_is_debugbuild, Cint, ()) != 0
    abspath(Libdl.dlpath("libjulia-debug"))
else
    abspath(Libdl.dlpath("libjulia"))
end
julia_library == libjulia_path ||   # loading 2 instances of libjulia fails horribly
    error("Using a different Julia instance, run Pkg.build(\"LLVM\") to reconfigure LLVM.jl")

# check whether the chosen LLVM is loaded already, ie. before having loaded it via `ccall`.
# if it isn't, we have exclusive access, allowing destructive operations (like shutting LLVM
# down).
#
# this check doesn't work in `__init__` because in the case of precompilation the
# deserializer already loads the library.
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
