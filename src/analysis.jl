export verify

function verify(mod::Module)
    message = Ref{Cstring}()
    status = API.LLVMVerifyModule(ref(mod), API.LLVMReturnStatusAction, message)

    if status != 0
        error = unsafe_string(message[])
        # TODO: this message often contains endlines, wrap in LLVM error type
        #       with a `showerror` rendering those endlines
        API.LLVMDisposeMessage(message[])
        throw(error)
    else
        API.LLVMDisposeMessage(message[])
    end
end
