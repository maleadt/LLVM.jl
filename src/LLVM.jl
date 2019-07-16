module LLVM

using Unicode
using Printf
using Libdl


## discovery

using Libdl

VERSION >= v"0.7.0-DEV.2576" || error("This version of LLVM.jl requires Julia 0.7")

# figure out the path to libLLVM by looking at the libraries loaded by Julia
const libllvm_paths = filter(Libdl.dllist()) do lib
    occursin("LLVM", basename(lib))
end
if isempty(libllvm_paths)
    error("""
        Cannot find the LLVM library loaded by Julia.
        Please use a version of Julia that has been built with USE_LLVM_SHLIB=1 (like the official binaries).
        If you are, please file an issue and attach the output of `Libdl.dllist()`.""")
end
if length(libllvm_paths) > 1
    error("""
        Multiple LLVM libraries loaded by Julia.
        Please file an issue and attach the output of `Libdl.dllist()`.""")
end
const libllvm = first(libllvm_paths)
const libllvm_version = Base.libllvm_version::VersionNumber
@debug "Discovered LLVM v$libllvm_version at $libllvm"
Base.include_dependency(libllvm)

vercmp_match(a,b)  = a.major==b.major &&  a.minor==b.minor
vercmp_compat(a,b) = a.major>b.major  || (a.major==b.major && a.minor>=b.minor)

const llvmjl_wrappers_path = joinpath(@__DIR__, "..", "lib")
Base.include_dependency(llvmjl_wrappers_path)

const llvmjl_wrappers = filter(path->isdir(joinpath(llvmjl_wrappers_path, path)),
                                     readdir(llvmjl_wrappers_path))
@assert !isempty(llvmjl_wrappers)

# figure out which wrapper to use
const matching_wrappers = filter(wrapper->vercmp_match(libllvm_version,
                                                        VersionNumber(wrapper)),
                                 llvmjl_wrappers)
const llvmjl_wrapper = if !isempty(matching_wrappers)
    @assert length(matching_wrappers) == 1
    matching_wrappers[1]
else
    compatible_wrappers = filter(wrapper->vercmp_compat(libllvm_version,
                                                        VersionNumber(wrapper)),
                                 llvmjl_wrappers)
    isempty(compatible_wrappers) && error("Could not find any compatible wrapper for LLVM $(libllvm_version)")
    last(compatible_wrappers)
end
@debug "Using LLVM.jl wrapper for v$llvmjl_wrapper"

# TODO: figure out the name of the native target
const libllvm_targets = [:NVPTX, :AMDGPU]

# backwards-compatible flags
const libllvm_system = false
const configured = true


## source code includes

include("util/types.jl")

include("base.jl")

module API
using LLVM
using LLVM: @apicall, libllvm_version
libdir = joinpath(@__DIR__, "..", "lib", LLVM.llvmjl_wrapper)
include(joinpath(libdir, "libLLVM_common.jl"))
include(joinpath(libdir, "libLLVM_h.jl"))
include(joinpath(libdir, "..", "libLLVM_extra.jl"))
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
    libllvm_paths = filter(Libdl.dllist()) do lib
        occursin("LLVM", basename(lib))
    end
    if length(libllvm_paths) > 1
        # NOTE: this still allows switching to a non-USE_LLVM_SHLIB version, but
        #       there's no way to detect that since the new libLLVM is loaded before this...
        cachefile = Base.compilecache(Base.PkgId(LLVM))
        rm(cachefile)
        error("Your set-up changed, and LLVM.jl needs to be reconfigured. Please load the package again.")
    end

    _install_handlers()
    _install_handlers(GlobalContext())
end

end
