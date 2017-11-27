# Basic library functionality


#
# API call wrapper
#

macro apicall(fun, rettyp, argtypes, args...)
    if VERSION >= v"0.7.0-DEV.1729"
        isa(fun, QuoteNode) || error("first argument to @apicall should be a symbol")
    else
        if !isa(fun, Expr) || fun.head != :quote
            error("first argument to @apicall should be a symbol")
        end
    end

    target = if startswith(String(fun.value), "LLVMExtra")
        fun
    else
        :($fun, libllvm)
    end

    return quote
        ccall($target, $(esc(rettyp)), $(esc(argtypes)), $(map(esc, args)...))
    end
end
