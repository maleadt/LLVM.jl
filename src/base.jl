# Basic library functionality


#
# API call wrapper
#

const libllvm = Ref{Ptr{Void}}()

macro apicall(fun, rettyp, argtypes, args...)
    if !isa(fun, Expr) || fun.head != :quote
        error("first argument to @apicall should be a symbol")
    end

    return quote
        @logging_ccall($fun, Libdl.dlsym(libllvm[], $fun),
                       $(esc(rettyp)), $(esc(argtypes)), $(map(esc, args)...))
    end
end
