__precompile__()

module LLVM

using Compat
import Compat.String

const ext = joinpath(@__DIR__, "..", "deps", "ext.jl")
if isfile(ext)
    include(ext)
elseif haskey(ENV, "ONLY_LOAD")
    # special mode where the package is loaded without requiring a successful build.
    # this is useful for loading in unsupported environments, eg. Travis + Documenter.jl
    warn("Only loading the package, without activating any functionality.")
    const libllvm_version = v"4.0"
    const libllvm_targets = Symbol[]
    const llvmjl_wrapper = "4.0"
else
    error("Unable to load $ext\n\nPlease run Pkg.build(\"LLVM\") and restart Julia.")
end

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

if is_linux()
    @compat const Lmid = Clong
    const LM_ID_BASE = 0
    const LM_ID_NEWLM = -1
    const RTLD_LAZY = 1
    function dlmopen(linkmap::Lmid, library::String, flags::Integer=RTLD_LAZY)
        handle = ccall((:dlmopen, :libdl), Ptr{Void}, (Lmid, Cstring, Cint), linkmap, library, flags)
        if handle == C_NULL
            error(unsafe_string(ccall((:dlerror, :libdl), Cstring, ())))
        end
        return handle
    end
end

function __init__()
    haskey(ENV, "ONLY_LOAD") && return

    # check validity of LLVM library
    debug("Checking validity of ", (libllvm_system?"system":"bundled"), " library at $libllvm_path")
    stat(libllvm_path).mtime == libllvm_mtime ||
        warn("LLVM library has been modified. Please re-run Pkg.build(\"LLVM\") and restart Julia.")

    __init_logging__()
    if !libllvm_system
        libllvm[] = Libdl.dlopen(libllvm_extra_path)
    elseif is_linux()
        libllvm[] = dlmopen(LM_ID_NEWLM, libllvm_extra_path)
    else
        error("System LLVM mode only supported on Linux")
    end

    _install_handlers()
    _install_handlers(GlobalContext())
end

end
