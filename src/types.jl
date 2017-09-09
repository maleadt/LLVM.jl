## bool

const True = API.LLVMBool(1)
const False = API.LLVMBool(0)

struct Bool
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
