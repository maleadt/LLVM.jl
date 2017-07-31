## forward declarations
# TODO: LLVM.Type once JuliaLang/Julia#18756 is backported
@reftypedef ref=LLVMTypeRef enum=LLVMTypeKind @compat abstract type LLVMType end
@reftypedef ref=LLVMValueRef enum=LLVMValueKind @compat abstract type Value end
@reftypedef ref=LLVMModuleRef immutable Module end
@reftypedef ref=LLVMTargetDataRef immutable DataLayout end


## bool

const True = API.LLVMBool(1)
const False = API.LLVMBool(0)

immutable Bool
    bool::Core.Bool
end

Base.convert(::Type{Bool}, bool::Core.Bool) = bool ? True : False

function Base.convert(::Type{Core.Bool}, bool::API.LLVMBool)
    if bool == True
        return true
    elseif bool == False
        return false
    else
        throw(ArgumentError("Invalid LLVMBool value $(bool)"))
    end
end
