module Interop

using ..LLVM
import ..LLVM: API

include("interop/base.jl")
include("interop/asmcall.jl")
include("interop/passes.jl")
include("interop/pointer.jl")
include("interop/utils.jl")
include("interop/intrinsics.jl")

if LLVM.has_newpm() && VERSION >= v"1.10.0-DEV.1622"
    include("interop/newpm.jl")
end

end
