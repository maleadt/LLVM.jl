export MemoryBuffer, MemoryBufferFile, dispose

import Base: start, size

@reftypedef ref=LLVMMemoryBufferRef immutable MemoryBuffer end

MemoryBuffer(data::String, name::String) = MemoryBuffer(
    API.LLVMCreateMemoryBufferWithMemoryRangeCopy(data, Csize_t(length(data)), name))

function MemoryBuffer(f::Core.Function, args...)
    membuf = MemoryBuffer(args...)
    try
        f(membuf)
    finally
        dispose(membuf)
    end
end

function MemoryBufferFile(path::String)
    membuf = Ref{API.LLVMMemoryBufferRef}()

    message = Ref{Cstring}()
    status =
        BoolFromLLVM(API.LLVMCreateMemoryBufferWithContentsOfFile(path, membuf, message))

    if status
        error = unsafe_string(message[])
        API.LLVMDisposeMessage(message[])
        throw(error)
    end

    MemoryBuffer(membuf[])
end

function MemoryBufferFile(f::Core.Function, args...)
    membuf = MemoryBufferFile(args...)
    try
        f(membuf)
    finally
        dispose(membuf)
    end
end

dispose(membuf::MemoryBuffer) = API.LLVMDisposeMemoryBuffer(ref(membuf))

size(membuf::MemoryBuffer) = API.LLVMGetBufferSize(ref(membuf))

# NOTE: we don't return a string, because we can't access the length
start(membuf::MemoryBuffer) = convert(Ptr{UInt8}, API.LLVMGetBufferStart(ref(membuf)))
