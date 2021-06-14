@checked struct LLVMError
    ref::API.LLVMErrorRef
end
Base.unsafe_convert(::Type{API.LLVMErrorRef}, err::LLVMError) = err.ref

"""
    consume(err::LLVMError)

Consumes the error without handling it.
"""
function consume(err::LLVMError)
    API.LLVMConsumeError(err)
end

# NOTE: handles the error, calling consume on `err` is illegal
function Base.convert(::Type{LLVMException}, err::LLVMError)
    errmsg = API.LLVMGetErrorMessage(err)
    local msg
    try
        msg = Base.unsafe_string(errmsg)
    finally
        API.LLVMDisposeErrorMessage(errmsg)
    end
    LLVMException(msg)
end

macro check(expr)
    quote
        err_ref = $(esc(expr))
        if err_ref != C_NULL
            err = LLVMError(err_ref)
            throw(convert(LLVMException, err))
        end
    end
end
