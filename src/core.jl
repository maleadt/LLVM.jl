# Interface to libLLVMCore, which implements the LLVM intermediate representation as well as
# other related types and utilities.

# forward-definitions
@reftypedef ref=LLVMModuleRef immutable LLVMModule end

include("core/context.jl")
include("core/type.jl")
include("core/value.jl")
include("core/module.jl")
include("core/metadata.jl")
