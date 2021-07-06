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

Base.write(io::IOStream, mod::Module) =
    API.LLVMWriteBitcodeToFD(mod, Cint(fd(io)), convert(Bool, false), convert(Bool, true))

Base.convert(::Type{MemoryBuffer}, mod::Module) = MemoryBuffer(
    API.LLVMWriteBitcodeToMemoryBuffer(mod))

Base.convert(::Type{Vector{T}}, mod::Module) where {T<:Union{UInt8,Int8}} =
    convert(Vector{T}, convert(MemoryBuffer, mod))
