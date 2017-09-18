# Basic library functionality


#
# API call wrapper
#

const libllvm = Ref{Ptr{Void}}()

macro apicall(funspec, rettyp, argtypes, args...)
    fun = if VERSION >= v"0.7.0-DEV.1729"
        isa(funspec, QuoteNode) || error("first argument to @apicall should be a symbol")
        funspec.value
    else
        if !isa(funspec, Expr) || funspec.head != :quote
            error("first argument to @apicall should be a symbol")
        end
        funspec.args[1]
    end

    configured || return :(error("LLVM.jl has not been configured."))

    return quote
        @logging_ccall($fun, Libdl.dlsym(libllvm[], $fun),
                       $(esc(rettyp)), $(esc(argtypes)), $(map(esc, args)...))
    end
end
