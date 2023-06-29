export PassInstrumentationCallbacks

export dispose, standard_instrumentations!

@checked struct PassInstrumentationCallbacks
    ref::API.LLVMPassInstrumentationCallbacksRef
    si::API.LLVMStandardInstrumentationsRef
    roots::Vector{Any}
end

Base.unsafe_convert(::Type{API.LLVMPassInstrumentationCallbacksRef}, pic::PassInstrumentationCallbacks) = pic.ref

PassInstrumentationCallbacks() = PassInstrumentationCallbacks(API.LLVMCreatePassInstrumentationCallbacks(), C_NULL, [])

function PassInstrumentationCallbacks(f::Core.Function, args...; kwargs...)
    pic = PassInstrumentationCallbacks(args...; kwargs...)
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

function standard_instrumentations!(pic::PassInstrumentationCallbacks)
    pic.si = API.LLVMCreateStandardInstrumentations()
    API.LLVMAddStandardInstrumentations(pic.ref, pic.si)
end
