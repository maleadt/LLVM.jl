# Basic library functionality


#
# API call wrapper
#

const libllvm = Ref{Ptr{Void}}()

macro apicall(fun, rettyp, argtypes, args...)
    if VERSION >= v"0.7.0-DEV.1729"
        isa(fun, QuoteNode) || error("first argument to @apicall should be a symbol")
    else
        if !isa(fun, Expr) || fun.head != :quote
            error("first argument to @apicall should be a symbol")
        end
    end

    configured || return :(error("LLVM.jl has not been configured."))

    return quote
        ccall(Libdl.dlsym(libllvm[], $fun), $(esc(rettyp)),
              $(esc(argtypes)), $(map(esc, args)...))
    end
end
