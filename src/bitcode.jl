## reader

import Base: parse

function parse(::Type{Module}, membuf::MemoryBuffer)
    out_ref = Ref{API.LLVMModuleRef}()

    status = BoolFromLLVM(API.LLVMParseBitcode2(ref(membuf), out_ref))
    @assert !status # caught by diagnostics handler

    Module(out_ref[])
end

function parse(::Type{Module}, membuf::MemoryBuffer, ctx::Context)
    out_ref = Ref{API.LLVMModuleRef}()

    status =
        BoolFromLLVM(API.LLVMParseBitcodeInContext2(ref(ctx), ref(membuf), out_ref))
    @assert !status # caught by diagnostics handler

    Module(out_ref[])
end


## writer

import Base: write, convert

write(io::IOStream, mod::Module) =
    API.LLVMWriteBitcodeToFD(ref(mod), Cint(fd(io)), BoolToLLVM(false), BoolToLLVM(true))

convert(::Type{MemoryBuffer}, mod::Module) = MemoryBuffer(
    API.LLVMWriteBitcodeToMemoryBuffer(ref(mod)))
