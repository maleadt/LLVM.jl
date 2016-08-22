# The bulk of LLVM's object model consists of values, which comprise a very rich type
# hierarchy.

@llvmtype abstract Value

dynamic_convert(::Type{Value}, ref::API.LLVMValueRef) =
    identify(ref, API.LLVMGetValueKind(ref))(ref)


## general APIs

export Value, name, name!, replace_uses!, isconstant, isundef

import Base: show

typeof(val::Value) = dynamic_convert(LLVMType, API.LLVMTypeOf(convert(API.LLVMValueRef, val)))

name(val::Value) = unsafe_string(API.LLVMGetValueName(convert(API.LLVMValueRef, val)))
name!(val::Value, name::String) = API.LLVMSetValueName(convert(API.LLVMValueRef, val), name)

function show(io::IO, val::Value)
    output = unsafe_string(API.LLVMPrintValueToString(convert(API.LLVMValueRef, val)))
    print(io, output)
end

replace_uses!(old::Val, new::Val) =
    API.LLVMReplaceAllUsesWith(convert(API.LLVMValueRef, old),
                               convert(API.LLVMValueRef, new))

isconstant(val::Value) = convert(Bool, API.LLVMIsConstant(convert(API.LLVMValueRef, val)))

isundef(val::Value) = convert(Bool, API.LLVMIsUndef(convert(API.LLVMValueRef, val)))


@llvmtype abstract User <: Value


## constants

include("value/constant.jl")
