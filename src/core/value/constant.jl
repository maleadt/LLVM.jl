## scalar

import Base: convert

export ConstantInt, ConstantFP

@reftypedef proxy=Value kind=LLVMConstantIntValueKind immutable ConstantInt <: Constant end

ConstantInt(typ::LLVMInteger, val::Int) =
    construct(ConstantInt, API.LLVMConstInt(ref(typ),
                                            reinterpret(Culonglong, val), LLVMTrue))

ConstantInt(typ::LLVMInteger, val::UInt) =
    construct(ConstantInt, API.LLVMConstInt(ref(typ),
                                            reinterpret(Culonglong, val), LLVMFalse))

convert(::Type{UInt}, val::ConstantInt) =
    API.LLVMConstIntGetZExtValue(ref(val))

convert(::Type{Int}, val::ConstantInt) =
    API.LLVMConstIntGetSExtValue(ref(val))


@reftypedef proxy=Value kind=LLVMConstantFPValueKind immutable ConstantFP <: Constant end

ConstantFP(typ::LLVMDouble, val::Real) =
    construct(ConstantFP, API.LLVMConstReal(ref(typ), Cdouble(val)))

convert(::Type{Float64}, val::ConstantFP) =
    API.LLVMConstRealGetDouble(ref(val), Ref{API.LLVMBool}())


## global variables

export GlobalVariable, unsafe_delete!,
       initializer, initializer!,
       isthreadlocal, threadlocal!,
       threadlocalmode, threadlocalmode!,
       isconstant, constant!,
       isextinit, extinit!

import Base: get, push!

@reftypedef proxy=Value kind=LLVMGlobalVariableValueKind immutable GlobalVariable <: Constant end

GlobalVariable(mod::Module, typ::LLVMType, name::String) =
    construct(GlobalVariable,
              API.LLVMAddGlobal(ref(mod),
                                ref(typ), name))

GlobalVariable(mod::Module, typ::LLVMType, name::String, addrspace::Integer) =
    construct(GlobalVariable,
              API.LLVMAddGlobalInAddressSpace(ref(mod), ref(typ),
                                              name, Cuint(addrspace)))

unsafe_delete!(::Module, gv::GlobalVariable) = API.LLVMDeleteGlobal(ref(gv))

initializer(gv::GlobalVariable) =
  dynamic_construct(Value, API.LLVMGetInitializer(ref(gv)))
initializer!(gv::GlobalVariable, val::Constant) =
  API.LLVMSetInitializer(ref(gv), ref(val))

isthreadlocal(gv::GlobalVariable) = BoolFromLLVM(API.LLVMIsThreadLocal(ref(gv)))
threadlocal!(gv::GlobalVariable, bool) =
  API.LLVMSetThreadLocal(ref(gv), BoolToLLVM(bool))

isconstant(gv::GlobalVariable) = BoolFromLLVM(API.LLVMIsGlobalConstant(ref(gv)))
constant!(gv::GlobalVariable, bool) =
  API.LLVMSetGlobalConstant(ref(gv), BoolToLLVM(bool))

threadlocalmode(gv::GlobalVariable) = API.LLVMGetThreadLocalMode(ref(gv))
threadlocalmode!(gv::GlobalVariable, mode) =
  API.LLVMSetThreadLocalMode(ref(gv), Cuint(mode))

isextinit(gv::GlobalVariable) =
  BoolFromLLVM(API.LLVMIsExternallyInitialized(ref(gv)))
extinit!(gv::GlobalVariable, bool) =
  API.LLVMSetExternallyInitialized(ref(gv), BoolToLLVM(bool))
