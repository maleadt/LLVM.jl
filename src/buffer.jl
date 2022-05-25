export MemoryBuffer, MemoryBufferFile

@checked mutable struct MemoryBuffer
    ref::API.LLVMMemoryBufferRef
end

Base.unsafe_convert(::Type{API.LLVMMemoryBufferRef}, membuf::MemoryBuffer) = membuf.ref

function MemoryBuffer(data::Vector{T}, name::String="", copy::Core.Bool=true) where T<:Union{UInt8,Int8}
    ptr = pointer(data)
    len = Csize_t(length(data))
    buf = if copy
        MemoryBuffer(API.LLVMCreateMemoryBufferWithMemoryRangeCopy(ptr, len, name))
    else
        MemoryBuffer(API.LLVMCreateMemoryBufferWithMemoryRange(ptr, len, name,
                                                               convert(Bool, false)))
    end
    finalizer(unsafe_dispose!, buf)
end

function MemoryBufferFile(path::String)
    out_ref = Ref{API.LLVMMemoryBufferRef}()

    out_error = Ref{Cstring}()
    status =
        convert(Core.Bool, API.LLVMCreateMemoryBufferWithContentsOfFile(path, out_ref, out_error))

    if status
        error = unsafe_message(out_error[])
        throw(LLVMException(error))
    end

    MemoryBuffer(out_ref[])
end

unsafe_dispose!(membuf::MemoryBuffer) = API.LLVMDisposeMemoryBuffer(membuf)

Base.length(membuf::MemoryBuffer) = API.LLVMGetBufferSize(membuf)

Base.pointer(membuf::MemoryBuffer) = convert(Ptr{UInt8}, API.LLVMGetBufferStart(membuf))

Base.convert(::Type{Vector{UInt8}}, membuf::MemoryBuffer) =
    unsafe_wrap(Array, pointer(membuf), length(membuf))
