## reader

function Base.parse(::Type{Module}, membuf::MemoryBuffer; ctx::Context)
    out_ref = Ref{API.LLVMModuleRef}()

    status = convert(Core.Bool, API.LLVMParseBitcodeInContext2(ctx, membuf, out_ref))
    @assert !status # caught by diagnostics handler

    Module(out_ref[])
end

Base.parse(::Type{Module}, data::Vector; ctx::Context) =
    parse(Module, MemoryBuffer(data, "", false); ctx)


## writer

Base.convert(::Type{MemoryBuffer}, mod::Module) = MemoryBuffer(
    API.LLVMWriteBitcodeToMemoryBuffer(mod))

function Base.convert(::Type{Vector{T}}, mod::Module) where {T<:Union{UInt8,Int8}}
    buf = convert(MemoryBuffer, mod)
    vec = convert(Vector{T}, buf)
    dispose(buf)
    return vec
end

function Base.write(io::IOStream, mod::Module)
    # XXX: can't use the LLVM API because it returns 0, not the number of bytes written
    #API.LLVMWriteBitcodeToFD(mod, Cint(fd(io)), convert(Bool, false), convert(Bool, true))
    buf = convert(MemoryBuffer, mod)
    vec = unsafe_wrap(Array, pointer(buf), length(buf))
    nb = write(io, vec)
    dispose(buf)
    return nb
end
