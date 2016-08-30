export verify

function verify(mod::Module)
    message = Ref{Cstring}()
    status = API.LLVMVerifyModule(mod.handle, API.LLVMReturnStatusAction, message)

    if status != 0
        error = unsafe_string(message[])
        API.LLVMDisposeMessage(message[])
        throw(error)
    else
        API.LLVMDisposeMessage(message[])
    end
end
