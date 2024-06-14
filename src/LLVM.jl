module LLVM

using Preferences
using Unicode
using Printf
using Libdl

if !isdefined(Base, :get_extension)
    using Requires: @require
end


## source code includes

include("base.jl")
include("version.jl")

# we don't embed the full path to LLVM, because the location might be different at run time.
const libllvm = basename(String(Base.libllvm_path()))
const libllvm_version = Base.libllvm_version

module API
using CEnum
using Preferences

using ..LLVM

# library handles
using ..LLVM: libllvm
using LLVMExtra_jll
if has_preference(LLVM, "libLLVMExtra")
    const libLLVMExtra = load_preference(LLVM, "libLLVMExtra")
else
    if isdefined(LLVMExtra_jll, :libLLVMExtra)
        import LLVMExtra_jll: libLLVMExtra
    end
end

# auto-generated wrappers
let
    if version().major < 13
        error("LLVM.jl only supports LLVM 13 and later.")
    end
    dir = if version().major > 17
        @warn "LLVM.jl has not been tested with LLVM versions newer than 17."
        joinpath(@__DIR__, "..", "lib", "17")
    else
        joinpath(@__DIR__, "..", "lib", string(version().major))
    end
    @assert isdir(dir)

    include(joinpath(dir, "libLLVM.jl"))
    include(joinpath(dir, "libLLVM_extra.jl"))
end
include(joinpath(@__DIR__, "..", "lib", "libLLVM_julia.jl"))

end # module API

has_oldpm() = LLVM.version() < v"17"
has_newpm() = LLVM.version() >= v"15"
has_julia_ojit() = VERSION >= v"1.10.0-DEV.1395"

# helpers
include("debug.jl")

# LLVM API wrappers
include("support.jl")
if LLVM.version() < v"17"
    include("passregistry.jl")
end
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
if has_oldpm()
    include("transform.jl")
end
include("debuginfo.jl")
include("dibuilder.jl")
include("jitevents.jl")
include("utils.jl")
include("orc.jl")
if has_newpm()
    include("newpm.jl")
end

# high-level functionality
include("state.jl")
include("interop.jl")

include("deprecated.jl")


## initialization

function __init__()
    @debug "Using LLVM $libllvm_version at $(Base.libllvm_path())"

    # sanity checks
    if !isdefined(API, :libLLVMExtra)
        @error """LLVM extensions library unavailable for your platform:
                    $(Base.BinaryPlatforms.triplet(API.LLVMExtra_jll.host_platform))
                  LLVM.jl will not be functional.

                  If you are using a custom version of LLVM, try building a
                  custom version of LLVMExtra_jll using `deps/build_local.jl`"""
    end
    if libllvm_version != Base.libllvm_version
        # this checks that the precompilation image isn't being used
        # after having upgraded Julia and the contained LLVM library.
        @error """LLVM.jl was precompiled for LLVM $libllvm_version, whereas you are now using LLVM $(Base.libllvm_version).
                  Please re-compile LLVM.jl."""
    end
    if version() !== runtime_version()
        # this is probably caused by a combination of USE_SYSTEM_LLVM
        # and an LLVM upgrade without recompiling Julia.
        @error """Julia was compiled for LLVM $(version()), whereas you are now using LLVM $(runtime_version()).
                  Please re-compile Julia and LLVM.jl (but note that USE_SYSTEM_LLVM is not a supported configuration)."""
    end

    @static if !isdefined(Base, :get_extension)
        @require BFloat16s = "ab4f0b2a-ad5b-11e8-123f-65d77653426b" begin
            include("../ext/BFloat16sExt.jl")
        end
    end

    _install_handlers()
    _install_handlers(GlobalContext())
    atexit(report_leaks)
end

end
