export verify

function verify(mod::Module)
    outerror = Ref{Cstring}()
    status =
        BoolFromLLVM(API.LLVMVerifyModule(ref(mod), API.LLVMReturnStatusAction, outerror))

    if status
        error = unsafe_string(outerror[])
        API.LLVMDisposeMessage(outerror[])
        throw(error)
    else
        API.LLVMDisposeMessage(outerror[])
    end
end
