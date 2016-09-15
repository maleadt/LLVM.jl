export verify

function verify(mod::Module)
    message = Ref{Cstring}()
    status =
        BoolFromLLVM(API.LLVMVerifyModule(ref(mod), API.LLVMReturnStatusAction, message))

    if status
        error = unsafe_string(message[])
        API.LLVMDisposeMessage(message[])
        throw(LLVMException(error))
    end
end

function verify(f::Function)
    status = BoolFromLLVM(API.LLVMVerifyFunction(ref(f), API.LLVMReturnStatusAction))

    if status
        throw(LLVMException("broken function"))
    end
end
