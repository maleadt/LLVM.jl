## reader

import Base: parse

function parse(::Type{Module}, membuf::MemoryBuffer)
    mod = Ref{API.LLVMModuleRef}()

    status =
        BoolFromLLVM(API.LLVMParseBitcode2(ref(membuf), mod))
    @assert !status # caught by diagnostics handler

    Module(mod[])
end

function parse(::Type{Module}, membuf::MemoryBuffer, ctx::Context)
    mod = Ref{API.LLVMModuleRef}()

    message = Ref{Cstring}()
    status =
        BoolFromLLVM(API.LLVMParseBitcodeInContext2(ref(ctx), ref(membuf), mod))
    @assert !status # caught by diagnostics handler

    Module(mod[])
end


## writer

import Base: write, convert

write(io::IOStream, mod::Module) =
    API.LLVMWriteBitcodeToFD(ref(mod), Cint(fd(io)), BoolToLLVM(false), BoolToLLVM(true))

convert(::Type{MemoryBuffer}, mod::Module) = MemoryBuffer(
    API.LLVMWriteBitcodeToMemoryBuffer(ref(mod)))
