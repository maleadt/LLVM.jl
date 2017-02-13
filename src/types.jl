## forward declarations
# TODO: LLVM.Type once JuliaLang/Julia#18756 is backported
@reftypedef ref=LLVMTypeRef enum=LLVMTypeKind @compat abstract type LLVMType end
@reftypedef ref=LLVMValueRef enum=LLVMValueKind @compat abstract type Value end
@reftypedef ref=LLVMModuleRef immutable Module end
@reftypedef ref=LLVMTargetDataRef immutable DataLayout end


## bool

import Base: convert

const True = API.LLVMBool(1)
const False = API.LLVMBool(0)

# NOTE: these 2 hacky functions are needed due to LLVMBool aliasing with Cuint,
#       making it impossible to define converts. A strongly-typed alias would fix this.

function BoolFromLLVM(bool::API.LLVMBool)
    if bool == True
        return true
    elseif bool == False
        return false
    else
        throw(ArgumentError("Invalid LLVMBool value $(bool)"))
    end
end

BoolToLLVM(bool::Bool) = bool ? True : False
