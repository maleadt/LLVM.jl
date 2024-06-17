export MemoryBuffer, MemoryBufferFile, dispose

@checked struct MemoryBuffer
    ref::API.LLVMMemoryBufferRef
end

Base.unsafe_convert(::Type{API.LLVMMemoryBufferRef}, membuf::MemoryBuffer) =
    mark_use(membuf).ref

function MemoryBuffer(data::Vector{T}, name::String="", copy::Bool=true) where T<:Union{UInt8,Int8}
    ptr = pointer(data)
    len = Csize_t(length(data))
    membuf = if copy
        MemoryBuffer(API.LLVMCreateMemoryBufferWithMemoryRangeCopy(ptr, len, name))
    else
        MemoryBuffer(API.LLVMCreateMemoryBufferWithMemoryRange(ptr, len, name, false))
    end
    mark_alloc(membuf)
end

function MemoryBuffer(f::Core.Function, args...; kwargs...)
    membuf = MemoryBuffer(args...; kwargs...)
    try
        f(membuf)
    finally
        dispose(membuf)
    end
end

function MemoryBufferFile(path::String)
    out_ref = Ref{API.LLVMMemoryBufferRef}()

    out_error = Ref{Cstring}()
    status = API.LLVMCreateMemoryBufferWithContentsOfFile(path, out_ref, out_error) |> Bool

    if status
        error = unsafe_message(out_error[])
        throw(LLVMException(error))
    end

    MemoryBuffer(out_ref[])
end

function MemoryBufferFile(f::Core.Function, args...; kwargs...)
    membuf = MemoryBufferFile(args...; kwargs...)
    try
        f(membuf)
    finally
        dispose(membuf)
    end
end

dispose(membuf::MemoryBuffer) = mark_dispose(API.LLVMDisposeMemoryBuffer, membuf)

Base.length(membuf::MemoryBuffer) = API.LLVMGetBufferSize(membuf)

Base.pointer(membuf::MemoryBuffer) = convert(Ptr{UInt8}, API.LLVMGetBufferStart(membuf))

Base.convert(::Type{Vector{UInt8}}, membuf::MemoryBuffer) =
    copy(unsafe_wrap(Array, pointer(membuf), length(membuf)))
