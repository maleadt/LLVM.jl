__precompile__()

module LLVM

using Compat
import Compat.String

const ext = joinpath(@__DIR__, "..", "deps", "ext.jl")
const configured = if isfile(ext)
    include(ext)
    true
else
    # enable LLVM.jl to be loaded when the build failed, simplifying downstream use.
    # remove this when we have proper support for conditional modules.
    const libllvm_targets = Symbol[]
    const libllvm_path = nothing
    const llvmjl_wrapper = "4.0"
    false
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

include("deprecated.jl")

if is_linux()
    const Lmid = Clong
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
    __init_logging__()

    if !configured
        warn("LLVM.jl has not been configured, and will not work properly.")
        warn("Please run Pkg.build(\"LLVM\") and restart Julia.")
        return
    end

    # check validity of LLVM library
    debug("Checking validity of ", (libllvm_system ? "system" : "bundled"), " library at $libllvm_path")
    stat(libllvm_path).mtime == libllvm_mtime ||
        warn("LLVM library has been modified. Please run Pkg.build(\"LLVM\") and restart Julia.")

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
