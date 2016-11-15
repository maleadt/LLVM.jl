module API

using LLVM: debug, DEBUG, trace, TRACE, repr_indented

const libllvm = Ref{Ptr{Void}}()
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
        $ret = ccall(Libdl.dlsym(libllvm[], $f), $rettyp,
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

end

function __init_api__()
    API.libllvm[] = Libdl.dlopen(API.libllvm_extra_path, Libdl.RTLD_LOCAL | Libdl.RTLD_DEEPBIND)
end
