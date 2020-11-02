module LLVM

using Unicode
using Printf
using Libdl


## source code includes

include("util.jl")
include("base.jl")

const libllvm = Ref{String}()
module API
using CEnum
using ..LLVM
using ..LLVM: libllvm, @runtime_ccall
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

has_orc_v1() = v"8" <= LLVM.version() < v"12"
include("orc.jl")

include("interop.jl")

include("deprecated.jl")


## initialization

function __init__()
    # find the libLLVM loaded by Julia
    #
    # we only support working with the copy of LLVM that Julia uses, because we have
    # additional library calls compiled in the Julia binary which cannot be used with
    # another copy of LLVM. loading multiple copies of LLVM typically breaks anyhow.
    libllvm[] = if VERSION >= v"1.6.0-DEV.1356"
        path = Base.libllvm()
        if path === nothing
            error("""Cannot find the LLVM library loaded by Julia.
                     Please use a version of Julia that has been built with USE_LLVM_SHLIB=1 (like the official binaries).
                     If you are, please file an issue and attach the output of `Libdl.dllist()`.""")
        end
        String(path)
    else
        libllvm_paths = filter(Libdl.dllist()) do lib
            occursin(r"LLVM\b", basename(lib))
        end
        if isempty(libllvm_paths)
            error("""Cannot find the LLVM library loaded by Julia.
                     Please use a version of Julia that has been built with USE_LLVM_SHLIB=1 (like the official binaries).
                     If you are, please file an issue and attach the output of `Libdl.dllist()`.""")
        end
        if length(libllvm_paths) > 1
            error("""Multiple LLVM libraries loaded by Julia.
                     Please file an issue and attach the output of `Libdl.dllist()`.""")
        end
        first(libllvm_paths)
    end

    @debug "Using LLVM $(version()) at $(Libdl.dlpath(libllvm[]))"
    if version() !== runtime_version()
        @error "Using a different version of LLVM ($(runtime_version())) than the one shipped with Julia ($(version())); this is unsupported"
    end

    _install_handlers()
    _install_handlers(GlobalContext())
end

end
