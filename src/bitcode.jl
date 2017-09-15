## reader

function Base.parse(::Type{Module}, data::Vector{T}) where T<:Union{UInt8,Int8}
    membuf = MemoryBuffer(data, "", false)
    out_ref = Ref{API.LLVMModuleRef}()

    status = convert(Core.Bool, API.LLVMParseBitcode2(ref(membuf), out_ref))
    @assert !status # caught by diagnostics handler

    Module(out_ref[])
end

function Base.parse(::Type{Module}, data::Vector{T}, ctx::Context) where T<:Union{UInt8,Int8}
    membuf = MemoryBuffer(data, "", false)
    out_ref = Ref{API.LLVMModuleRef}()

    status = convert(Core.Bool, API.LLVMParseBitcodeInContext2(ref(ctx), ref(membuf), out_ref))
    @assert !status # caught by diagnostics handler

    Module(out_ref[])
end


## writer

Base.write(io::IOStream, mod::Module) =
    API.LLVMWriteBitcodeToFD(ref(mod), Cint(fd(io)), convert(Bool, false), convert(Bool, true))

Base.convert(::Type{MemoryBuffer}, mod::Module) = MemoryBuffer(
    API.LLVMWriteBitcodeToMemoryBuffer(ref(mod)))

Base.convert(::Type{Vector{T}}, mod::Module) where {T<:Union{UInt8,Int8}} =
    convert(Vector{T}, convert(MemoryBuffer, mod))
