module Interop

using ..LLVM

using Compat

const jlctx = Ref{LLVM.Context}()

include("interop/base.jl")
include("interop/asmcall.jl")

function __init__()
    jlctx[] = LLVM.Context(convert(LLVM.API.LLVMContextRef, cglobal(:jl_LLVMContext)))
end

end
