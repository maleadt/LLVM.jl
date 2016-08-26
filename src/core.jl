# Interface to libLLVMCore, which implements the LLVM intermediate representation as well as
# other related types and utilities.
#
# http://llvm.org/docs/doxygen/html/group__LLVMCCore.html

# forward-define outer layers of the type hierarchy
@reftypedef reftype=LLVMTypeRef enum=LLVMTypeKind abstract LLVMType
@reftypedef reftype=LLVMValueRef enum=LLVMValueKind abstract Value
@reftypedef abstract User <: Value
@reftypedef abstract Constant <: User
@reftypedef reftype=LLVMModuleRef immutable LLVMModule end
@reftypedef argtype=Value kind=LLVMFunctionValueKind immutable LLVMFunction <: Constant end
@reftypedef reftype=LLVMBasicBlockRef argtype=Value kind=LLVMBasicBlockValueKind immutable BasicBlock <: Value end

# NOTE: simplifying the two-ref types obviates need for a ref(T, obj)

# NOTE: we don't completely stick to the C API's organization here

include("core/context.jl")
include("core/type.jl")
include("core/value.jl")
include("core/metadata.jl")
include("core/module.jl")
include("core/basicblock.jl")
include("core/function.jl")
include("core/instructions.jl")
