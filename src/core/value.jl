# The bulk of LLVM's object model consists of values, which comprise a very rich type
# hierarchy.

immutable Value
    handle::API.LLVMValueRef
end


## general APIs

export Value, name, name!, replace_uses!, isconstant, isundef

import Base: show

typeof(val::Value) = LLVMType(API.LLVMTypeOf(val.handle))

name(val::Value) = unsafe_string(API.LLVMGetValueName(val.handle))
name!(val::Value, name::String) = API.LLVMSetValueName(val.handle, name)

function show(io::IO, val::Value)
    output = unsafe_string(API.LLVMPrintValueToString(val.handle))
    print(io, output)
end

replace_uses!(old::Val, new::Val) = API.LLVMReplaceAllUsesWith(old.handle, new.handle)

isconstant(val::Value) = API.LLVMIsConstant(val.handle) == API.LLVMBool(1)

isundef(val::Value) = API.LLVMIsUndef(val.handle) == API.LLVMBool(1)


## constants

export ConstInt, value_zext, value_sext,
       ConstReal, value_double

ConstInt(typ::LLVMType, val::Integer, signed=false) =
    Value(API.LLVMConstInt(typ.handle, reinterpret(Culonglong, val), API.LLVMBool(signed)))

value_zext(val::Value) = API.LLVMConstIntGetZExtValue(val.handle)
value_sext(val::Value) = API.LLVMConstIntGetSExtValue(val.handle)

ConstReal(typ::LLVMType, val::Real) =
    Value(API.LLVMConstReal(typ.handle, Cdouble(val)))

value_double(val::Value) = API.LLVMConstRealGetDouble(val.handle, Ref{API.LLVMBool}())
