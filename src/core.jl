# Interface to libLLVMCore, which implements the LLVM intermediate representation as well as
# other related types and utilities.

# forward-define outer layers of the type hierarchy
@reftypedef reftype=LLVMModuleRef immutable LLVMModule end
@reftypedef reftype=LLVMTypeRef enum=LLVMTypeKind abstract LLVMType
@reftypedef reftype=LLVMValueRef enum=LLVMValueKind abstract Value

include("core/context.jl")
include("core/module.jl")
include("core/type.jl")
include("core/value.jl")
include("core/metadata.jl")
