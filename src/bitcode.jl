## reader

import Base: parse

function parse{T<:Union{UInt8,Int8}}(::Type{Module}, data::Vector{T})
    membuf = MemoryBuffer(data, "", false)
    out_ref = Ref{API.LLVMModuleRef}()

    status = BoolFromLLVM(API.LLVMParseBitcode2(ref(membuf), out_ref))
    @assert !status # caught by diagnostics handler

    Module(out_ref[])
end

function parse{T<:Union{UInt8,Int8}}(::Type{Module}, data::Vector{T}, ctx::Context)
    membuf = MemoryBuffer(data, "", false)
    out_ref = Ref{API.LLVMModuleRef}()

    status = BoolFromLLVM(API.LLVMParseBitcodeInContext2(ref(ctx), ref(membuf), out_ref))
    @assert !status # caught by diagnostics handler

    Module(out_ref[])
end


## writer

import Base: write, convert

write(io::IOStream, mod::Module) =
    API.LLVMWriteBitcodeToFD(ref(mod), Cint(fd(io)), BoolToLLVM(false), BoolToLLVM(true))

convert(::Type{MemoryBuffer}, mod::Module) = MemoryBuffer(
    API.LLVMWriteBitcodeToMemoryBuffer(ref(mod)))

convert{T<:Union{UInt8,Int8}}(::Type{Vector{T}}, mod::Module) =
    convert(Vector{T}, convert(MemoryBuffer, mod))
