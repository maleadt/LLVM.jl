export verify

function verify(mod::Module)
    out_error = Ref{Cstring}()
    status =
        convert(Core.Bool, API.LLVMVerifyModule(mod, API.LLVMReturnStatusAction, out_error))

    if status
        error = unsafe_message(out_error[])
        throw(LLVMException(error))
    end
end

function verify(f::Function)
    status = convert(Core.Bool, API.LLVMVerifyFunction(f, API.LLVMReturnStatusAction))

    if status
        throw(LLVMException("broken function"))
    end
end
