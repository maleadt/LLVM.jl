export verify

function verify(mod::Module)
    out_error = Ref{Cstring}()
    status =
        BoolFromLLVM(API.LLVMVerifyModule(ref(mod), API.LLVMReturnStatusAction, out_error))

    if status
        error = unsafe_string(out_error[])
        API.LLVMDisposeMessage(out_error[])
        throw(LLVMException(error))
    end
end

function verify(f::Function)
    status = BoolFromLLVM(API.LLVMVerifyFunction(ref(f), API.LLVMReturnStatusAction))

    if status
        throw(LLVMException("broken function"))
    end
end
