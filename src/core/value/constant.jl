# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueConstant.html

@llvmtype abstract Constant <: User


## scalar

# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueConstantScalar.html

import Base: convert

export ConstantInt, ConstantFP

@llvmtype immutable ConstantInt <: Constant end

ConstantInt(typ::LLVMInteger, val::Integer, signed=false) =
    construct(ConstantInt, API.LLVMConstInt(convert(API.LLVMTypeRef, typ),
                                            reinterpret(Culonglong, val),
                                            convert(LLVMBool, signed)))

convert(::Type{UInt}, val::ConstantInt) =
    API.LLVMConstIntGetZExtValue(convert(API.LLVMValueRef, val))
convert(::Type{Int}, val::ConstantInt) =
    API.LLVMConstIntGetSExtValue(convert(API.LLVMValueRef, val))


@llvmtype immutable ConstantFP <: Constant end

ConstantFP(typ::LLVMDouble, val::Real) =
    construct(ConstantFP, API.LLVMConstReal(convert(API.LLVMTypeRef, typ), Cdouble(val)))

convert(::Type{Float64}, val::ConstantFP) =
    API.LLVMConstRealGetDouble(convert(API.LLVMValueRef, val), Ref{API.LLVMBool}())


## function

# TODO: ctor from Module

import Base: delete!, get, push!

export personality, personality!, callconv, callconv!, gc, gc!, intrinsic_id

# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueFunction.html

@llvmtype immutable LLVMFunction <: Constant end

delete!(fn::LLVMFunction) = API.LLVMDeleteFunction(convert(API.LLVMValueRef, fn))

personality(fn::LLVMFunction) =
    construct(LLVMFunction, API.LLVMGetPersonalityFn(convert(API.LLVMValueRef, fn)))
personality!(fn::LLVMFunction, persfn::LLVMFunction) =
    API.LLVMSetPersonalityFn(convert(API.LLVMValueRef, fn),
                             convert(API.LLVMValueRef, persfn))

intrinsic_id(fn::LLVMFunction) = API.LLVMGetIntrinsicID(convert(API.LLVMValueRef, fn))

callconv(fn::LLVMFunction) = API.LLVMGetFunctionCallConv(convert(API.LLVMValueRef, fn))
callconv!(fn::LLVMFunction, cc::Integer) =
    API.LLVMSetFunctionCallConv(convert(API.LLVMValueRef, fn), Cuint(cc))

gc(fn::LLVMFunction) = unsafe_string(API.LLVMGetGC(convert(API.LLVMValueRef, fn)))
gc!(fn::LLVMFunction, name::String) = API.LLVMSetGC(convert(API.LLVMValueRef, fn), name)

# attributes

export attributes

immutable FunctionAttrIterator
    fn::LLVMFunction
end

attributes(fn::LLVMFunction) = FunctionAttrIterator(fn)

get(it::FunctionAttrIterator) =
    API.LLVMGetFunctionAttr(convert(API.LLVMValueRef, it.fn))

push!(it::FunctionAttrIterator, attr) =
    API.LLVMAddFunctionAttr(convert(API.LLVMValueRef, it.fn), attr)

delete!(it::FunctionAttrIterator, attr) =
    API.LLVMRemoveFunctionAttr(convert(API.LLVMValueRef, it.fn), attr)


## global variables

export GlobalVariable

# http://llvm.org/docs/doxygen/html/group__LLVMCoreValueConstantGlobalVariable.html

@llvmtype immutable GlobalVariable <: Constant end

GlobalVariable(mod::LLVMModule, typ::LLVMType, name::String) =
    construct(GlobalVariable,
              API.LLVMAddGlobal(convert(API.LLVMModuleRef, mod),
                                convert(API.LLVMTypeRef, typ), name))

GlobalVariable(mod::LLVMModule, typ::LLVMType, name::String, addrspace) =
    construct(GlobalVariable,
              API.LLVMAddGlobalInAddressSpace(convert(API.LLVMModuleRef, mod),
                                              convert(API.LLVMTypeRef, typ), name,
                                              Cuint(addrspace)))
