__precompile__()

module LLVM

using Compat
import Compat.String

include("logging.jl")
include("auxiliary.jl")

module API

using LLVM: debug, DEBUG, trace, TRACE, repr_indented

# TODO: put this in package
macro apicall(f, rettyp, argtyps, args...)
    # Escape the tuple of arguments, making sure it is evaluated in caller scope
    # (there doesn't seem to be inline syntax like `$(esc(argtyps))` for this)
    esc_args = [esc(arg) for arg in args]

    blk = Expr(:block)

    if !isa(f, Expr) || f.head != :quote
        error("first argument to @apicall should be a symbol")
    end

    # Print the function name & arguments
    @static if TRACE
        push!(blk.args, :(trace($(sprint(Base.show_unquoted,f.args[1])*"("); line=false)))
        i=length(args)
        for arg in args
            i-=1
            sep = (i>0 ? ", " : "")

            # TODO: we should only do this if evaluating `arg` has no side effects
            push!(blk.args, :(trace(repr_indented($(esc(arg))), $sep;
                  prefix=$(sprint(Base.show_unquoted,arg))*"=", line=false)))
        end
        push!(blk.args, :(trace(""; prefix=") =", line=false)))
    end

    # Generate the actual call
    @gensym ret
    push!(blk.args, quote
        $ret = ccall(($f, libllvm), $rettyp,
                     $(esc(argtyps)), $(esc_args...))
    end)

    # Print the results
    @static if TRACE
        push!(blk.args, :(trace($ret; prefix=" ")))
    end

    # Return the result
    push!(blk.args, quote
        $ret
    end)

    return blk
end

ext = joinpath(dirname(@__FILE__), "..", "deps", "ext.jl")
isfile(ext) || error("Unable to load $ext\n\nPlease re-run Pkg.build(\"LLVM\"), and restart Julia.")
include(ext)

# check whether the chosen LLVM is loaded already, ie. before having loaded it via `ccall`.
# if it isn't, we have exclusive access, allowing destructive operations (like shutting LLVM
# down).
#
# this check doesn't work in `__init__` because in the case of precompilation the
# deserializer already loads the library.
isfile(libllvm_path) ||
    error("LLVM library missing. Please re-run Pkg.build(\"LLVM\") and restart Julia.")
const exclusive = Libdl.dlopen_e(libllvm_path, Libdl.RTLD_NOLOAD) == C_NULL

end

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
    debug("Checking validity of $(API.libllvm_path) (", (API.exclusive?"exclusive":"non-exclusive"), " access)")
    stat(API.libllvm_path).mtime == API.libllvm_mtime ||
        warn("LLVM library has been modified. Please re-run Pkg.build(\"LLVM\") and restart Julia.")

    __init_logging__()

    _install_handlers()
    _install_handlers(GlobalContext())
end

end
