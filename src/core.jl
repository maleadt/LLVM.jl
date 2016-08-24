# Interface to libLLVMCore, which implements the LLVM intermediate representation as well as
# other related types and utilities.

## bool

import Base: convert

export LLVMBool, LLVMTrue, LLVMFalse

immutable LLVMBool
    val::API.LLVMBool
end

const LLVMTrue = LLVMBool(API.LLVMBool(1))
const LLVMFalse = LLVMBool(API.LLVMBool(0))

function convert(::Type{Bool}, bool::LLVMBool)
    if bool.val == LLVMTrue.val
        return true
    elseif bool.val == LLVMFalse.val
        return false
    else
        throw(ArgumentError("Invalid LLVMBool value $(bool.val)"))
    end
end

# NOTE: this is a hack, convert(LLVMBool) returns an API.LLVMBool (ie. typealiased Cuint)
#       as it is really only used when passing values to the API
convert(::Type{LLVMBool}, bool::Bool)::API.LLVMBool = bool ? LLVMTrue.val : LLVMFalse.val

# forward-definitions
@reftypedef apitype=LLVMModuleRef immutable LLVMModule end

include("core/context.jl")
include("core/type.jl")
include("core/value.jl")
include("core/module.jl")
include("core/metadata.jl")
