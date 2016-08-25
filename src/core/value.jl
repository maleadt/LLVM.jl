# The bulk of LLVM's object model consists of values, which comprise a very rich type
# hierarchy.

export Value

@reftypedef abstract User <: Value

# Construct an unknown type of value object from a value ref.
function dynamic_construct(::Type{Value}, ref::API.LLVMValueRef)
    ref == C_NULL && throw(NullException())
    return identify(Value, API.LLVMGetValueKind(ref))(ref)
end

# Construct an specific type of value object from a value ref.
# In debug mode, this checks if the object type matches the underlying ref type.
@inline function construct{T<:Value}(::Type{T}, ref::API.LLVMValueRef)
    T.abstract && error("Cannot construct an abstract type, use a concrete type instead (use dynamic_construct if unknown)")
    ref == C_NULL && throw(NullException())
    @static if DEBUG
        RealT = identify(Value, API.LLVMGetValueKind(ref))
        if T != RealT
            error("invalid conversion of $RealT reference to $T")
        end
    end
    return T(ref)
end


## general APIs

export llvmtype, name, name!, replace_uses!, isconstant, isundef

import Base: show

# TODO: missing LLVMGetValueContext

llvmtype(val::Value) = dynamic_construct(LLVMType, API.LLVMTypeOf(ref(Value, val)))

name(val::Value) = unsafe_string(API.LLVMGetValueName(ref(Value, val)))
name!(val::Value, name::String) = API.LLVMSetValueName(ref(Value, val), name)

function show(io::IO, val::Value)
    output = unsafe_string(API.LLVMPrintValueToString(ref(Value, val)))
    print(io, output)
end

replace_uses!(old::Val, new::Val) =
    API.LLVMReplaceAllUsesWith(ref(Value, old),
                               ref(Value, new))

isconstant(val::Value) = BoolFromLLVM(API.LLVMIsConstant(ref(Value, val)))

isundef(val::Value) = BoolFromLLVM(API.LLVMIsUndef(ref(Value, val)))


## constants

include("value/constant.jl")
