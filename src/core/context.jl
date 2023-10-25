# Contexts are execution states for the core LLVM IR system.

export Context, dispose, GlobalContext

@checked struct Context
    ref::API.LLVMContextRef
end

Base.unsafe_convert(::Type{API.LLVMContextRef}, ctx::Context) = ctx.ref

function Context(; opaque_pointers=false)
    # during the transition to opaque pointers, contexts can be configured to use
    # typed or opaque pointers. this can lead to incompatibilities: opaque IR cannot
    # be used in a typed context. the reverse is not true though, so we make sure to
    # configure LLVM.jl contexts to use typed pointers by default, resulting in simple
    # `Context()` constructors (e.g. as used in LLVM.jl-based generators) generating IR
    # that's compatible regardless of the compiler's choice of pointers.

    ctx = Context(API.LLVMContextCreate())
    opaque_pointers!(ctx, opaque_pointers)
    _install_handlers(ctx)
    activate(ctx)
    ctx
end

function dispose(ctx::Context)
    deactivate(ctx)
    API.LLVMContextDispose(ctx)
end

function Context(f::Core.Function; kwargs...)
    ctx = Context(; kwargs...)
    try
        f(ctx)
    finally
        dispose(ctx)
    end
end

GlobalContext() = Context(API.LLVMGetGlobalContext())

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


## opaque pointer handling

export typed_pointers

if version() >= v"13"
    typed_pointers(ctx::Context) =
        convert(Core.Bool, API.LLVMContextSupportsTypedPointers(ctx))

    if version() >= v"15"
        has_set_opaque_pointers_value(ctx::Context) =
            convert(Core.Bool, API.LLVMContextHasSetOpaquePointersValue(ctx))
    end

    function unsafe_opaque_pointers!(ctx::Context, enable::Core.Bool)
        @static if version() >= v"15"
            if has_set_opaque_pointers_value(ctx)
                error("Opaque pointers value has already been set!")
            end
        end
        API.LLVMContextSetOpaquePointers(ctx, enable)
    end
else
    typed_pointers(ctx::Context) = true
end

function opaque_pointers!(ctx::Context, opaque_pointers)
    if opaque_pointers === nothing
        # the user explicitly opted out of configuring the context
        return
    end

    @static if version() < v"13"
        if opaque_pointers
            error("LLVM <13 does not support opaque pointers")
        end
    end

    @static if version() >= v"17"
        if !opaque_pointers
            error("LLVM >=17 does not support typed pointers")
        end
    end

    @static if v"13" <= version() < v"17"
        # the opaque pointer setting can only be set once
        @static if version() >= v"15"
            # on LLVM 15, we can check whether the context has been configured already
            if has_set_opaque_pointers_value(ctx)
                return
            end
        else
            # we also know that Julia used to set this value to `false` by default
            if VERSION < v"1.11-"
                return
            end
        end

        unsafe_opaque_pointers!(ctx, opaque_pointers)
    end
end


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

