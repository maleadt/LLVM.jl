# The bulk of LLVM's object model consists of values, which comprise a very rich type
# hierarchy.

@reftypedef abstract Value

# Construct an unknown type of value object from a value ref.
dynamic_construct(::Type{Value}, ref::API.LLVMValueRef) =
    identify(ref, API.LLVMGetValueKind(ref))(ref)

# Construct an specific type of value object from a value ref.
# In debug mode, this checks if the object type matches the underlying ref type.
@inline function construct{T<:Value}(::Type{T}, ref::API.LLVMValueRef)
    @static if DEBUG
        RealT = identify(ref, API.LLVMGetValueKind(ref))
        if T != RealT
            error("invalid conversion of $RealT reference to $T")
        end
    end
    return T(ref)
end


## general APIs

export Value, name, name!, replace_uses!, isconstant, isundef

import Base: show

typeof(val::Value) = dynamic_construct(LLVMType, API.LLVMTypeOf(ref(Value, val)))

name(val::Value) = unsafe_string(API.LLVMGetValueName(ref(Value, val)))
name!(val::Value, name::String) = API.LLVMSetValueName(ref(Value, val), name)

function show(io::IO, val::Value)
    output = unsafe_string(API.LLVMPrintValueToString(ref(Value, val)))
    print(io, output)
end

replace_uses!(old::Val, new::Val) =
    API.LLVMReplaceAllUsesWith(ref(Value, old),
                               ref(Value, new))

isconstant(val::Value) = convert(Bool, API.LLVMIsConstant(ref(Value, val)))

isundef(val::Value) = convert(Bool, API.LLVMIsUndef(ref(Value, val)))


@reftypedef abstract User <: Value


## constants

include("value/constant.jl")
