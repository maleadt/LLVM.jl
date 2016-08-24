# NOTE: make sure this files doesn't contain complex definitions,
#       as it is imported by deps/build.jl as well

const DEBUG = haskey(ENV, "DEBUG")
"Display a debug message. Only results in actual printing if the TRACE or DEBUG environment
variable is set."
@inline function debug(io::IO, msg...; prefix="DEBUG: ", line=true)
    @static if DEBUG
        Base.print_with_color(:green, io, prefix, chomp(string(msg...)))
        if line
            println(io)
        end
    end
end
@inline debug(msg...; kwargs...) = debug(STDERR, msg...; kwargs...)
