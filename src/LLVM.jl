module LLVM

using Unicode
using Printf
using Libdl


## source code includes

include("base.jl")
include("version.jl")

const libllvm = Base.libllvm_path()
if libllvm === nothing
    error("""Cannot find the LLVM library loaded by Julia.

             Please use a version of Julia that has been built with USE_LLVM_SHLIB=1 (like the official binaries).
             If you are, please file an issue and attach the output of `Libdl.dllist()`.""")
end

# our JLL doesn't support LLVM with assertions yet, so loading LLVMExtra might fail.
Libdl.dlopen(libllvm) do handle
    if Libdl.dlsym(handle, "_ZN4llvm23EnableABIBreakingChecksE"; throw_error=false) !== nothing
        @warn """You are using a version of Julia that links against a build of LLVM with assertions enabled.

                    This is not supported out-of-the-box, and you need a build of libLLVMExtra that supports this.
                    Use `deps/build_local.jl` for that, add the resulting LocalPreferences.toml to your project
                    and add a direct dependency on LLVMExtra_jll to pick up those preferences."""
    end
end

module API
using CEnum
using ..LLVM
using ..LLVM: libllvm

llvm_version = if version() < v"12"
    "11"
elseif version().major == 12
    "12"
else
    "13"
end
libdir = joinpath(@__DIR__, "..", "lib")

if !isdir(libdir)
    error("""
    The LLVM API bindings for v$llvm_version do not exist.
    You might need a newer version of LLVM.jl for this version of Julia.""")
end
import LLVMExtra_jll: libLLVMExtra

include(joinpath(libdir, llvm_version, "libLLVM_h.jl"))
include(joinpath(libdir, "libLLVM_extra.jl"))
include(joinpath(libdir, "libLLVM_julia.jl"))
end # module API

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
include("dibuilder.jl")
include("jitevents.jl")
include("utils.jl")

has_orc_v1() = v"8" <= LLVM.version() < v"12"
if has_orc_v1()
    include("orc.jl")
end

has_orc_v2() = v"12" <= LLVM.version()
if has_orc_v2()
    include("orcv2.jl")
end

include("interop.jl")

include("deprecated.jl")


## initialization

function __init__()
    # sanity checks
    @debug "Using LLVM $(version()) at $libllvm"
    if libllvm != Base.libllvm_path()
        @error "Mismatch between LLVM library used during precompilation ($libllvm) and the current run-time situation ($(Base.libllvm_path())). Please recompile the package."
    end
    if version() !== runtime_version()
        @error "Using a different version of LLVM ($(runtime_version())) than the one shipped with Julia ($(version())); this is unsupported"
    end

    _install_handlers()
    _install_handlers(GlobalContext())
end

end
