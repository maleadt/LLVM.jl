# Contexts are execution states for the core LLVM IR system.

export Context, dispose, GlobalContext, typed_pointers, opaque_pointers!

@checked struct Context
    ref::API.LLVMContextRef
end

Base.unsafe_convert(::Type{API.LLVMContextRef}, ctx::Context) = ctx.ref

function Context()
    ctx = Context(API.LLVMContextCreate())
    _install_handlers(ctx)
    activate(ctx)
    ctx
end

function dispose(ctx::Context)
    deactivate(ctx)
    API.LLVMContextDispose(ctx)
end

function Context(f::Core.Function)
    ctx = Context()
    try
        f(ctx)
    finally
        dispose(ctx)
    end
end

GlobalContext() = Context(API.LLVMGetGlobalContext())

if version() >= v"13"
    typed_pointers(ctx::Context) =
        convert(Core.Bool, API.LLVMContextSupportsTypedPointers(ctx))

    opaque_pointers!(ctx::Context, enable::Core.Bool) =
        API.LLVMContextSetOpaquePointers(ctx, enable)
else
    typed_pointers(ctx::Context) = true

    opaque_pointers!(ctx::Context, enable::Bool) =
        error("Opaque pointers not supported")
end

function Base.show(io::IO, ctx::Context)
    @printf(io, "LLVM.Context(%p", ctx.ref)
    if ctx == GlobalContext()
        print(io, ", global instance")
    end
    if v"14" <= version() < v"17"
        # migration to opaque pointers
        print(io, ", ", typed_pointers(ctx) ? "typed ptrs" : "opaque ptrs")
    end
    print(io, ")")
end

@noinline throw_typedpointererror() =
    error("""Typed pointers are not supported.

             You are invoking an API without specifying the pointer type, but this LLVM context
             uses opaque pointers. You should either pass the element type of the pointer as an
             argument, or use an environment that sypports typed pointers.""")


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

Base.unsafe_convert(::Type{API.LLVMDiagnosticInfoRef}, di::DiagnosticInfo) = di.ref

severity(di::DiagnosticInfo) = API.LLVMGetDiagInfoSeverity(di)
message(di::DiagnosticInfo) = unsafe_message(API.LLVMGetDiagInfoDescription(di))


## handlers

function handle_diagnostic(diag_ref::API.LLVMDiagnosticInfoRef, args::Ptr{Cvoid})
    di = DiagnosticInfo(diag_ref)
    @assert args == C_NULL

    sev = severity(di)
    msg = message(di)

    if sev == API.LLVMDSError
        # NOTE: it might be more true to the API to just report an error here,
        #       and require callers to verify whether operations succeeded,
        #       but throwing here fails faster with better backtraces.
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

function yield_callback(ctx_ref::API.LLVMContextRef, args::Ptr{Cvoid})
    ctx = Context(ctx_ref)
    @assert args == C_NULL

    # TODO: is this allowed? can we yield out of an active `ccall`?
    yield()
end

function _install_handlers(ctx::Context)
    # set yield callback
    callback = @cfunction(yield_callback, Cvoid, (Context, Ptr{Cvoid}))
    # NOTE: disabled until proven safe
    #API.LLVMContextSetYieldCallback(ctx, callback, C_NULL)

    # set diagnostic callback
    handler = @cfunction(handle_diagnostic, Cvoid, (API.LLVMDiagnosticInfoRef, Ptr{Cvoid}))
    API.LLVMContextSetDiagnosticHandler(ctx, handler, C_NULL)

    return nothing
end

function handle_error(reason::Cstring)
    throw(LLVMException(unsafe_string(reason)))
end

function _install_handlers()
    handler = @cfunction(handle_error, Cvoid, (Cstring,))
    API.LLVMInstallFatalErrorHandler(handler)
end

