export PassInstrumentationCallbacks, StandardInstrumentationCallbacks

export dispose

@checked struct PassInstrumentationCallbacks
    ref::API.LLVMPassInstrumentationCallbacksRef
    si::API.LLVMStandardInstrumentationsRef
    roots::Vector{Any}
end

Base.unsafe_convert(::Type{API.LLVMPassInstrumentationCallbacksRef}, pic::PassInstrumentationCallbacks) = pic.ref

PassInstrumentationCallbacks(si) = PassInstrumentationCallbacks(API.LLVMCreatePassInstrumentationCallbacks(), si, [])
PassInstrumentationCallbacks() = PassInstrumentationCallbacks(API.LLVMStandardInstrumentationsRef(C_NULL))

StandardInstrumentationCallbacks(; debug_logging::Bool=false, verify_each::Bool=false) =
    PassInstrumentationCallbacks(API.LLVMCreateStandardInstrumentations(context(), debug_logging, verify_each))

function PassInstrumentationCallbacks(f::Core.Function, args...; kwargs...)
    pic = PassInstrumentationCallbacks(args...; kwargs...)
    try
        f(pic)
    finally
        dispose(pic)
    end
end

function StandardInstrumentationCallbacks(f::Core.Function, args...; kwargs...)
    pic = StandardInstrumentationCallbacks(args...; kwargs...)
    try
        f(pic)
    finally
        dispose(pic)
    end
end

function dispose(pic::PassInstrumentationCallbacks)
    API.LLVMDisposePassInstrumentationCallbacks(pic)
    if pic.si != C_NULL
        API.LLVMDisposeStandardInstrumentations(pic.si)
    end
end
