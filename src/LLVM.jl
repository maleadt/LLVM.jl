module LLVM

using Unicode
using Printf
using Libdl


## discovery

export version

# make sure we precompile again when LLVM changes (some definitions are version-dependent)
global const libllvm = Sys.iswindows() ? :LLVM : :libLLVM
Base.include_dependency(Libdl.dlpath(libllvm))

const libllvm_version = Ref{VersionNumber}()
function version()
    if !isassigned(libllvm_version)
        # FIXME: add a proper C API to LLVM
        version_print = unsafe_string(
            ccall((:_ZN4llvm16LTOCodeGenerator16getVersionStringEv, libllvm), Cstring, ()))
        m = match(r"LLVM version (?<version>.+)", version_print)
        m === nothing && error("Unrecognized version string: '$version_print'")
        libllvm_version[] = if endswith(m[:version], "jl")
            # strip the "jl" SONAME suffix (JuliaLang/julia#33058)
            # (LLVM does never report a prerelease version anyway)
            VersionNumber(m[:version][1:end-2])
        else
            VersionNumber(m[:version])
        end
    end
    return libllvm_version[]
end


## source code includes

include("util.jl")

include("base.jl")

module API
using CEnum
using ..LLVM
using ..LLVM: @apicall
const off_t = Csize_t
libdir = joinpath(@__DIR__, "..", "lib")
include(joinpath(libdir, "libLLVM_common.jl"))
include(joinpath(libdir, "libLLVM_h.jl"))
include(joinpath(libdir, "libLLVM_extra.jl"))
end

# LLVM API wrappers
include("support.jl")
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
include("debuginfo.jl")

include("interop.jl")

include("deprecated.jl")


## initialization

function __init__()
    libllvm_version = version()
    @debug "Using LLVM $libllvm_version at $(Libdl.dlpath(libllvm))"
    if libllvm_version != Base.libllvm_version
        @warn "Using a different version of LLVM ($libllvm_version) than the one shipped with Julia ($(Base.libllvm_version)); this is unsupported"
    end

    _install_handlers()
    _install_handlers(GlobalContext())
end

end
