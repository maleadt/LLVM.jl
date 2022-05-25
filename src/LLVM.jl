module LLVM

using Unicode
using Printf
using Libdl


## source code includes

include("base.jl")
include("version.jl")

# we don't embed the full path to LLVM, because the location might be different at run time.
const libllvm = basename(String(Base.libllvm_path()))
const libllvm_version = Base.libllvm_version

module API
using CEnum
using ..LLVM
using ..LLVM: libllvm

macro debug_ccall(target, rettyp, argtyps, args...)
    @assert Meta.isexpr(target, :tuple)
    f, lib = target.args

    quote
        # get the call target, as e.g. libcuda() triggers initialization, even though we
        # can't use the result in the ccall expression below as it's supposed to be constant
        $(esc(target))

        # printing without task switches
        io = Core.stdout

        print(io, $f, '(')
        for (i, arg) in enumerate(($(map(esc, args)...),))
            i > 1 && Core.print(io, ", ")
            render_arg(io, arg)
        end
        Core.print(io, ')')
        rv = ccall($(esc(target)), $(esc(rettyp)), $(esc(argtyps)), $(map(esc, args)...))
        Core.println(io, " = ", rv)
        for (i, arg) in enumerate(($(map(esc, args)...),))
            if arg isa Base.RefValue
                Core.println(io, " $i: ", arg[])
            end
        end
        rv
    end
end

render_arg(io, arg) = Core.print(io, arg)
render_arg(io, arg::Union{<:Base.RefValue, AbstractArray}) = summary(io, arg)

const llvm_version = if version() < v"12"
    "11"
elseif version().major == 12
    "12"
else
    "13"
end
const libdir = joinpath(@__DIR__, "..", "lib")

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
    @debug "Using LLVM $libllvm_version at $(Base.libllvm_path())"

    # sanity checks
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

    _install_handlers()
    _install_handlers(GlobalContext())
end

end
