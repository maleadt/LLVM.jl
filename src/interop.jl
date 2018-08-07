module Interop

using ..LLVM


const jlctx = Ref{LLVM.Context}()

include("interop/base.jl")
include("interop/asmcall.jl")

end
