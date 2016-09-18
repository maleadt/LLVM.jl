# Contexts are execution states for the core LLVM IR system.

export Context, dispose, GlobalContext

@reftypedef ref=LLVMContextRef immutable Context end

function Context()
    ctx = Context(API.LLVMContextCreate())
    install_handlers(ctx)
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

import Base: showerror

immutable LLVMException <: Exception
    info::String
end

function showerror(io::IO, err::LLVMException)
    @printf(io, "LLVM error: %s", err.info)
end


## diagnostics

export DiagnosticInfo, severity, message

@reftypedef ref=LLVMDiagnosticInfoRef immutable DiagnosticInfo end

severity(diag::DiagnosticInfo) = API.LLVMGetDiagInfoSeverity(ref(diag))
message(diag::DiagnosticInfo) = unsafe_string(API.LLVMGetDiagInfoDescription(ref(diag)))


## handlers

function handle_diagnostic(diag_ref::API.LLVMDiagnosticInfoRef, args::Ptr{Void})
    diag = DiagnosticInfo(diag_ref)

    sev = severity(diag)
    msg = message(diag)

    if sev == API.LLVMDSError
        throw(LLVMException(msg))
    elseif sev == API.LLVMDSWarning
        warn(msg)
    elseif sev == API.LLVMDSRemark || sev == API.LLVMDSNote
        info(msg)
    else
        error("unknown diagnostic severity level $sev")
    end

    return nothing
end

function yield_callback(ctx::Context, args::Ptr{Void})
    # TODO: is this allowed? can we yield out of an active `ccall`?
    yield()
end

function install_handlers(ctx::Context)
    # set yield callback
    callback = cfunction(yield_callback, Void, Tuple{Context, Ptr{Void}})
    # NOTE: disabled until proven safe
    #API.LLVMContextSetYieldCallback(ref(ctx), callback, C_NULL)

    # set diagnostic callback
    handler = cfunction(handle_diagnostic, Void, Tuple{API.LLVMDiagnosticInfoRef, Ptr{Void}})
    API.LLVMContextSetDiagnosticHandler(ref(ctx), handler, C_NULL)

    return nothing
end

install_handlers(GlobalContext())    # TODO: in `init` method for precompilation
