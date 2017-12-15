# Contexts are execution states for the core LLVM IR system.

export Context, dispose, GlobalContext

@checked struct Context
    ref::API.LLVMContextRef
end
reftype(::Type{Context}) = API.LLVMContextRef

function Context()
    ctx = Context(API.LLVMContextCreate())
    _install_handlers(ctx)
    ctx
end

dispose(ctx::Context) = API.LLVMContextDispose(ref(ctx))

function Context(f::Core.Function)
    ctx = Context()
    try
        f(ctx)
    finally
        dispose(ctx)
    end
end

GlobalContext() = Context(API.LLVMGetGlobalContext())


## wrapper exception type

export LLVMException

struct LLVMException <: Exception
    info::String
end

function Base.showerror(io::IO, err::LLVMException)
    @printf(io, "LLVM error: %s", err.info)
end


## diagnostics

export DiagnosticInfo, severity, message

@checked struct DiagnosticInfo
    ref::API.LLVMDiagnosticInfoRef
end
reftype(::Type{DiagnosticInfo}) = API.LLVMDiagnosticInfoRef

severity(di::DiagnosticInfo) = API.LLVMGetDiagInfoSeverity(ref(di))
message(di::DiagnosticInfo) = unsafe_string(API.LLVMGetDiagInfoDescription(ref(di)))


## handlers

function handle_diagnostic(diag_ref::API.LLVMDiagnosticInfoRef, args::Ptr{Void})
    di = DiagnosticInfo(diag_ref)
    @assert args == C_NULL

    sev = severity(di)
    msg = message(di)

    if sev == API.LLVMDSError
        throw(LLVMException(msg))
    elseif sev == API.LLVMDSWarning
        @warn msg
    elseif sev == API.LLVMDSRemark || sev == API.LLVMDSNote
        @debug msg
    else
        error("unknown diagnostic severity level $sev")
    end

    return nothing
end

function yield_callback(ctx_ref::API.LLVMContextRef, args::Ptr{Void})
    ctx = Context(ctx_ref)
    @assert args == C_NULL

    # TODO: is this allowed? can we yield out of an active `ccall`?
    yield()
end

function _install_handlers(ctx::Context)
    # set yield callback
    callback = cfunction(yield_callback, Void, Tuple{Context, Ptr{Void}})
    # NOTE: disabled until proven safe
    #API.LLVMContextSetYieldCallback(ref(ctx), callback, C_NULL)

    # set diagnostic callback
    handler = cfunction(handle_diagnostic, Void, Tuple{API.LLVMDiagnosticInfoRef, Ptr{Void}})
    API.LLVMContextSetDiagnosticHandler(ref(ctx), handler, C_NULL)

    return nothing
end

function handle_error(reason::Cstring)
    throw(LLVMException(unsafe_string(reason)))
end

function _install_handlers()
    handler = cfunction(handle_error, Void, Tuple{Cstring})

    # NOTE: LLVM doesn't support re-installing the error handler, which happens when we
    #       `reload("LLVM")`, so reset it instead. This isn't correct, as the installed
    #       handler might not have been ours. Ideally we'd have module finalizers...
    API.LLVMResetFatalErrorHandler()
    API.LLVMInstallFatalErrorHandler(handler)
end
