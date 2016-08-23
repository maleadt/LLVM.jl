# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueConstant.html

@llvmtype abstract Constant <: User


## scalar

# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueConstantScalar.html

import Base: convert

export ConstantInt, ConstantFP

@llvmtype immutable ConstantInt <: Constant end

ConstantInt(typ::LLVMInteger, val::Integer, signed=false) =
    ConstantInt(API.LLVMConstInt(convert(API.LLVMTypeRef, typ),
                                 reinterpret(Culonglong, val),
                                 convert(LLVMBool, signed)))

convert(::Type{UInt}, val::ConstantInt) =
    API.LLVMConstIntGetZExtValue(convert(API.LLVMValueRef, val))
convert(::Type{Int}, val::ConstantInt) =
    API.LLVMConstIntGetSExtValue(convert(API.LLVMValueRef, val))


@llvmtype immutable ConstantFP <: Constant end

ConstantFP(typ::LLVMFloat, val::Real) =
    ConstantFP(API.LLVMConstReal(convert(API.LLVMTypeRef, typ), Cdouble(val)))

convert(::Type{Float64}, val::ConstantFP) =
    API.LLVMConstRealGetDouble(convert(API.LLVMValueRef, val), Ref{API.LLVMBool}())


## function

# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueFunction.html

@llvmtype immutable LLVMFunction <: Constant end
