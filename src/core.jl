# Interface to libLLVMCore, which implements the LLVM intermediate representation as well as
# other related types and utilities.

# forward-declarations
@reftypedef @compat abstract type User <: Value end
@reftypedef @compat abstract type Constant <: User end
@reftypedef @compat abstract type GlobalValue <: Constant end
@reftypedef @compat abstract type GlobalObject <: GlobalValue end
@reftypedef proxy=Value kind=LLVMFunctionValueKind immutable Function <: GlobalObject end
@reftypedef proxy=Value kind=LLVMBasicBlockValueKind immutable BasicBlock <: Value end

# NOTE: we don't completely stick to the C API's organization here

include("core/context.jl")
include("core/type.jl")
include("core/value.jl")
include("core/metadata.jl")
include("core/module.jl")
include("core/basicblock.jl")
include("core/attributes.jl")
include("core/function.jl")
include("core/instructions.jl")
