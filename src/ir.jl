## reader

function Base.parse(::Type{Module}, ir::String)
    data = unsafe_wrap(Vector{UInt8}, ir)
    membuf = MemoryBuffer(data, "", false)

    out_ref = Ref{API.LLVMModuleRef}()
    out_error = Ref{Cstring}()
    status = API.LLVMParseIRInContext(context(), membuf, out_ref, out_error) |> Bool
    mark_dispose(membuf)

    if status
        error = unsafe_message(out_error[])
        throw(LLVMException(error))
    end

    Module(out_ref[])
end


## writer

Base.string(mod::Module) = unsafe_message(API.LLVMPrintModuleToString(mod))
