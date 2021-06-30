module Interop

using ..LLVM
import ..LLVM: API


const jlctx = Ref{LLVM.Context}()

include("interop/base.jl")
include("interop/asmcall.jl")
include("interop/passes.jl")
include("interop/pointer.jl")
include("interop/utils.jl")
include("interop/intrinsics.jl")

end
