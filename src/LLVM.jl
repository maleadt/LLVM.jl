__precompile__()

module LLVM

using Compat
import Compat.String

ext = joinpath(dirname(@__FILE__), "..", "deps", "ext.jl")
isfile(ext) || error("Unable to load $ext\n\nPlease run Pkg.build(\"LLVM\"), and restart Julia.")
include(ext)

include("util/logging.jl")
include("util/types.jl")

include("base.jl")

module API
using Compat
using LLVM: @apicall, llvmjl_wrapper
libdir = joinpath(@__DIR__, "..", "lib", llvmjl_wrapper)
include(joinpath(libdir, "libLLVM_common.jl"))
include(joinpath(libdir, "libLLVM_h.jl"))
include(joinpath(libdir, "..", "libLLVM_extra.jl"))
end

# LLVM API wrappers
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
    debug("Checking validity of $libllvm_path (", (libllvm_exclusive?"exclusive":"non-exclusive"), " access)")
    stat(libllvm_path).mtime == libllvm_mtime ||
        warn("LLVM library has been modified. Please re-run Pkg.build(\"LLVM\") and restart Julia.")

    __init_logging__()
    libllvm[] = Libdl.dlopen(libllvm_extra_path, Libdl.RTLD_LOCAL | Libdl.RTLD_DEEPBIND)

    _install_handlers()
    _install_handlers(GlobalContext())
end

end
