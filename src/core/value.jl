# The bulk of LLVM's object model consists of values, which comprise a very rich type
# hierarchy.

export Value

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

llvmtype(val::Value) = dynamic_construct(LLVMType, API.LLVMTypeOf(ref(val)))

name(val::Value) = unsafe_string(API.LLVMGetValueName(ref(val)))
name!(val::Value, name::String) = API.LLVMSetValueName(ref(val), name)

function show(io::IO, val::Value)
    output = unsafe_string(API.LLVMPrintValueToString(ref(val)))
    print(io, output)
end

replace_uses!(old::Val, new::Val) =
    API.LLVMReplaceAllUsesWith(ref(old),
                               ref(new))

isconstant(val::Value) = BoolFromLLVM(API.LLVMIsConstant(ref(val)))

isundef(val::Value) = BoolFromLLVM(API.LLVMIsUndef(ref(val)))


## constants

include("value/constant.jl")


## usage

export Use, user, value

@reftypedef ref=LLVMUseRef immutable Use end

user(use::Use) =  dynamic_construct(Value, API.LLVMGetUser(     ref(use)))
value(use::Use) = dynamic_construct(Value, API.LLVMGetUsedValue(ref(use)))

# use iteration

export uses

import Base: eltype, start, next, done

immutable ValueUseSet
    val::Value
end

uses(val::Value) = ValueUseSet(val)

eltype(::ValueUseSet) = Use

start(iter::ValueUseSet) = API.LLVMGetFirstUse(ref(iter.val))

next(::ValueUseSet, state) =
    (Use(state), API.LLVMGetNextUse(state))

done(::ValueUseSet, state) = state == C_NULL

# NOTE: this is expensive, but the iteration interface requires it to be implemented
function length(iter::ValueUseSet)
    count = 0
    for inst in iter
        count += 1
    end
    return count
end
