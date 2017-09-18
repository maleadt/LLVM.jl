# Logging functionality

# I/O without libuv, for use after STDOUT is finalized
raw_print(msg::AbstractString...) =
    ccall(:write, Cssize_t, (Cint, Cstring, Csize_t), 1, join(msg), length(join(msg)))
raw_println(msg::AbstractString...) = raw_print(msg..., "\n")

# safe version of `Base.print_with_color`, switching to raw I/O before finalizers are run
# (see `atexit` in `__init_logging__`)
const after_exit = Ref{Core.Core.Bool}(false)
function safe_print_with_color(color::Union{Int, Symbol}, io::IO, msg::AbstractString...)
    if after_exit[]
        raw_print(msg...)
    else
        print_with_color(color, io, msg...)
    end
end

const TRACE = haskey(ENV, "TRACE")
"Display a trace message. Only results in actual printing if the TRACE environment variable
is set."
@inline function trace(io::IO, msg...; prefix="TRACE: ", line=true)
    @static if TRACE
        safe_print_with_color(:cyan, io, prefix, chomp(string(msg...)), line ? "\n" : "")
    end
end
@inline trace(msg...; kwargs...) = trace(STDERR, msg...; kwargs...)

const DEBUG = TRACE || haskey(ENV, "DEBUG")
"Display a debug message. Only results in actual printing if the TRACE or DEBUG environment
variable is set."
@inline function debug(io::IO, msg...; prefix="DEBUG: ", line=true)
    @static if DEBUG
        safe_print_with_color(:green, io, prefix, chomp(string(msg...)), line ? "\n" : "")
    end
end
@inline debug(msg...; kwargs...) = debug(STDERR, msg...; kwargs...)

function __init_logging__()
    if TRACE
        trace("LLVM.jl is running in trace mode, this will generate a lot of additional output")
    elseif DEBUG
        debug("LLVM.jl is running in debug mode, this will generate additional output")
        debug("Run with TRACE=1 to enable even more output")
    end

    atexit(()->begin
        debug("Dropping down to post-finalizer I/O")
        after_exit[]=true
    end)
end
