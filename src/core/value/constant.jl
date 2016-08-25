# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueConstant.html

@reftypedef abstract Constant <: User


## scalar

# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueConstantScalar.html

import Base: convert

export ConstantInt, ConstantFP

@reftypedef argtype=Value kind=LLVMConstantIntValueKind immutable ConstantInt <: Constant end

ConstantInt(typ::LLVMInteger, val::Integer, signed=false) =
    construct(ConstantInt, API.LLVMConstInt(ref(LLVMType, typ),
                                            reinterpret(Culonglong, val),
                                            BoolToLLVM(signed)))

convert(::Type{UInt}, val::ConstantInt) =
    API.LLVMConstIntGetZExtValue(ref(Value, val))
convert(::Type{Int}, val::ConstantInt) =
    API.LLVMConstIntGetSExtValue(ref(Value, val))


@reftypedef argtype=Value kind=LLVMConstantFPValueKind immutable ConstantFP <: Constant end

ConstantFP(typ::LLVMDouble, val::Real) =
    construct(ConstantFP, API.LLVMConstReal(ref(LLVMType, typ), Cdouble(val)))

convert(::Type{Float64}, val::ConstantFP) =
    API.LLVMConstRealGetDouble(ref(Value, val), Ref{API.LLVMBool}())


## function

export LLVMFunction,  unsafe_delete!,
       personality, personality!,
       callconv, callconv!,
       gc, gc!, intrinsic_id

import Base: get, push!

# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueFunction.html

@reftypedef argtype=Value kind=LLVMFunctionValueKind immutable LLVMFunction <: Constant end

LLVMFunction(mod::LLVMModule, name::String, ft::FunctionType) =
    construct(LLVMFunction,
              API.LLVMAddFunction(ref(LLVMModule, mod), name,
                                  ref(LLVMType, ft)))

unsafe_delete!(::LLVMModule, fn::LLVMFunction) = API.LLVMDeleteFunction(ref(Value, fn))

personality(fn::LLVMFunction) =
    construct(LLVMFunction, API.LLVMGetPersonalityFn(ref(Value, fn)))
personality!(fn::LLVMFunction, persfn::LLVMFunction) =
    API.LLVMSetPersonalityFn(ref(Value, fn),
                             ref(Value, persfn))

intrinsic_id(fn::LLVMFunction) = API.LLVMGetIntrinsicID(ref(Value, fn))

callconv(fn::LLVMFunction) = API.LLVMGetFunctionCallConv(ref(Value, fn))
callconv!(fn::LLVMFunction, cc) =
    API.LLVMSetFunctionCallConv(ref(Value, fn), Cuint(cc))

gc(fn::LLVMFunction) = unsafe_string(API.LLVMGetGC(ref(Value, fn)))
gc!(fn::LLVMFunction, name::String) = API.LLVMSetGC(ref(Value, fn), name)

# attributes

export attributes

import Base: get, push!, delete!

immutable FunctionAttrSet
    fn::LLVMFunction
end

attributes(fn::LLVMFunction) = FunctionAttrSet(fn)

get(iter::FunctionAttrSet) = API.LLVMGetFunctionAttr(ref(Value, iter.fn))

push!(iter::FunctionAttrSet, attr) = API.LLVMAddFunctionAttr(ref(Value, iter.fn), attr)

delete!(iter::FunctionAttrSet, attr) = API.LLVMRemoveFunctionAttr(ref(Value, iter.fn), attr)


## global variables

export GlobalVariable, unsafe_delete!,
       initializer, initializer!,
       isthreadlocal, threadlocal!,
       threadlocalmode, threadlocalmode!,
       isconstant, constant!,
       isextinit, extinit!

import Base: get, push!

# http://llvm.org/docs/doxygen/html/group__LLVMCoreValueConstantGlobalVariable.html

@reftypedef argtype=Value kind=LLVMGlobalVariableValueKind immutable GlobalVariable <: Constant end

GlobalVariable(mod::LLVMModule, typ::LLVMType, name::String) =
    construct(GlobalVariable,
              API.LLVMAddGlobal(ref(LLVMModule, mod),
                                ref(LLVMType, typ), name))

GlobalVariable(mod::LLVMModule, typ::LLVMType, name::String, addrspace::Integer) =
    construct(GlobalVariable,
              API.LLVMAddGlobalInAddressSpace(ref(LLVMModule, mod), ref(LLVMType, typ),
                                              name, Cuint(addrspace)))

unsafe_delete!(::LLVMModule, gv::GlobalVariable) = API.LLVMDeleteGlobal(ref(Value, gv))

initializer(gv::GlobalVariable) =
  dynamic_construct(Value, API.LLVMGetInitializer(ref(Value, gv)))
initializer!(gv::GlobalVariable, val::Constant) =
  API.LLVMSetInitializer(ref(Value, gv), ref(Value, val))

isthreadlocal(gv::GlobalVariable) = BoolFromLLVM(API.LLVMIsThreadLocal(ref(Value, gv)))
threadlocal!(gv::GlobalVariable, bool) =
  API.LLVMSetThreadLocal(ref(Value, gv), BoolToLLVM(bool))

isconstant(gv::GlobalVariable) = BoolFromLLVM(API.LLVMIsGlobalConstant(ref(Value, gv)))
constant!(gv::GlobalVariable, bool) =
  API.LLVMSetGlobalConstant(ref(Value, gv), BoolToLLVM(bool))

threadlocalmode(gv::GlobalVariable) = API.LLVMGetThreadLocalMode(ref(Value, gv))
threadlocalmode!(gv::GlobalVariable, mode) =
  API.LLVMSetThreadLocalMode(ref(Value, gv), Cuint(mode))

isextinit(gv::GlobalVariable) =
  BoolFromLLVM(API.LLVMIsExternallyInitialized(ref(Value, gv)))
extinit!(gv::GlobalVariable, bool) =
  API.LLVMSetExternallyInitialized(ref(Value, gv), BoolToLLVM(bool))
