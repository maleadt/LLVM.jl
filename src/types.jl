## forward declarations
@reftypedef ref=LLVMTypeRef enum=LLVMTypeKind abstract LLVMType
@reftypedef ref=LLVMValueRef enum=LLVMValueKind abstract Value
@reftypedef ref=LLVMModuleRef immutable Module end
@reftypedef ref=LLVMTargetDataRef immutable DataLayout end


## bool

import Base: convert

export LLVMTrue, LLVMFalse

const LLVMTrue = API.LLVMBool(1)
const LLVMFalse = API.LLVMBool(0)

# NOTE: these 2 hacky functions are needed due to LLVMBool aliasing with Cuint,
#       making it impossible to define converts. A strongly-typed alias would fix this.

function BoolFromLLVM(bool::API.LLVMBool)
    if bool == LLVMTrue
        return true
    elseif bool == LLVMFalse
        return false
    else
        throw(ArgumentError("Invalid LLVMBool value $(bool)"))
    end
end

BoolToLLVM(bool::Bool) = bool ? LLVMTrue : LLVMFalse
