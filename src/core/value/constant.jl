# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueConstant.html

@reftypedef abstract Constant <: User


## scalar

# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueConstantScalar.html

import Base: convert

export ConstantInt, ConstantFP

@reftypedef ref=Value kind=LLVMConstantIntValueKind immutable ConstantInt <: Constant end

ConstantInt(typ::LLVMInteger, val::Integer, signed=false) =
    construct(ConstantInt, API.LLVMConstInt(ref(LLVMType, typ),
                                            reinterpret(Culonglong, val),
                                            convert(LLVMBool, signed)))

convert(::Type{UInt}, val::ConstantInt) =
    API.LLVMConstIntGetZExtValue(ref(Value, val))
convert(::Type{Int}, val::ConstantInt) =
    API.LLVMConstIntGetSExtValue(ref(Value, val))


@reftypedef ref=Value kind=LLVMConstantFPValueKind immutable ConstantFP <: Constant end

ConstantFP(typ::LLVMDouble, val::Real) =
    construct(ConstantFP, API.LLVMConstReal(ref(LLVMType, typ), Cdouble(val)))

convert(::Type{Float64}, val::ConstantFP) =
    API.LLVMConstRealGetDouble(ref(Value, val), Ref{API.LLVMBool}())


## function

import Base: delete!, get, push!

export LLVMFunction, personality, personality!, callconv, callconv!, gc, gc!, intrinsic_id

# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueFunction.html

@reftypedef ref=Value kind=LLVMFunctionValueKind immutable LLVMFunction <: Constant end

LLVMFunction(mod::LLVMModule, name::String, ft::FunctionType) =
    construct(LLVMFunction,
              API.LLVMAddFunction(ref(LLVMModule, mod), name,
                                  ref(LLVMType, ft)))

delete!(fn::LLVMFunction) = API.LLVMDeleteFunction(ref(Value, fn))

personality(fn::LLVMFunction) =
    construct(LLVMFunction, API.LLVMGetPersonalityFn(ref(Value, fn)))
personality!(fn::LLVMFunction, persfn::LLVMFunction) =
    API.LLVMSetPersonalityFn(ref(Value, fn),
                             ref(Value, persfn))

intrinsic_id(fn::LLVMFunction) = API.LLVMGetIntrinsicID(ref(Value, fn))

callconv(fn::LLVMFunction) = API.LLVMGetFunctionCallConv(ref(Value, fn))
callconv!(fn::LLVMFunction, cc::Integer) =
    API.LLVMSetFunctionCallConv(ref(Value, fn), Cuint(cc))

gc(fn::LLVMFunction) = unsafe_string(API.LLVMGetGC(ref(Value, fn)))
gc!(fn::LLVMFunction, name::String) = API.LLVMSetGC(ref(Value, fn), name)

# attributes

export attributes

immutable FunctionAttrIterator
    fn::LLVMFunction
end

attributes(fn::LLVMFunction) = FunctionAttrIterator(fn)

get(it::FunctionAttrIterator) =
    API.LLVMGetFunctionAttr(ref(Value, it.fn))

push!(it::FunctionAttrIterator, attr) =
    API.LLVMAddFunctionAttr(ref(Value, it.fn), attr)

delete!(it::FunctionAttrIterator, attr) =
    API.LLVMRemoveFunctionAttr(ref(Value, it.fn), attr)


## global variables

export GlobalVariable

# http://llvm.org/docs/doxygen/html/group__LLVMCoreValueConstantGlobalVariable.html

@reftypedef ref=Value kind=LLVMGlobalVariableValueKind immutable GlobalVariable <: Constant end

GlobalVariable(mod::LLVMModule, typ::LLVMType, name::String) =
    construct(GlobalVariable,
              API.LLVMAddGlobal(ref(LLVMModule, mod),
                                ref(LLVMType, typ), name))

GlobalVariable(mod::LLVMModule, typ::LLVMType, name::String, addrspace) =
    construct(GlobalVariable,
              API.LLVMAddGlobalInAddressSpace(ref(LLVMModule, mod),
                                              ref(LLVMType, typ), name,
                                              Cuint(addrspace)))
