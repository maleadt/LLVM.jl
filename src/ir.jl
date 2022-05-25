## reader

function Base.parse(::Type{Module}, ir::String; ctx::Context)
    data = unsafe_wrap(Vector{UInt8}, ir)
    membuf = MemoryBuffer(data, "", false)

    out_ref = Ref{API.LLVMModuleRef}()
    out_error = Ref{Cstring}()
    status = convert(Core.Bool, API.LLVMParseIRInContext(ctx, membuf, out_ref, out_error))

    if status
        error = unsafe_message(out_error[])
        throw(LLVMException(error))
    end

    mod = Module(out_ref[], ctx)
    finalizer(unsafe_dispose!, mod)
end


## writer

Base.string(mod::Module) = unsafe_message(API.LLVMPrintModuleToString(mod))
