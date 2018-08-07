__precompile__()

module LLVM

using Unicode
using Printf


const ext = joinpath(@__DIR__, "..", "deps", "ext.jl")
isfile(ext) || error("LLVM.jl has not been built, please run Pkg.build(\"LLVM\").")
include(ext)
const libllvm = libllvm_path

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

function __init__()
    _install_handlers()
    _install_handlers(GlobalContext())
end

end
