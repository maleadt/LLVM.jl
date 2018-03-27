# Basic library functionality


#
# API call wrapper
#

macro apicall(fun, rettyp, argtypes, args...)
    isa(fun, QuoteNode) || error("first argument to @apicall should be a symbol")

    target = if startswith(String(fun.value), "LLVMExtra")
        fun
    else
        :($fun, libllvm)
    end

    return quote
        ccall($target, $(esc(rettyp)), $(esc(argtypes)), $(map(esc, args)...))
    end
end
