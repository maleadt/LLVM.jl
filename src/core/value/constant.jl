# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueConstant.html


## scalar

# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueConstantScalar.html

import Base: convert

export ConstantInt, ConstantFP

@reftypedef proxy=Value kind=LLVMConstantIntValueKind immutable ConstantInt <: Constant end

ConstantInt(typ::LLVMInteger, val::Integer, signed=false) =
    construct(ConstantInt, API.LLVMConstInt(ref(LLVMType, typ),
                                            reinterpret(Culonglong, val),
                                            BoolToLLVM(signed)))

convert(::Type{UInt}, val::ConstantInt) =
    API.LLVMConstIntGetZExtValue(ref(Value, val))
convert(::Type{Int}, val::ConstantInt) =
    API.LLVMConstIntGetSExtValue(ref(Value, val))


@reftypedef proxy=Value kind=LLVMConstantFPValueKind immutable ConstantFP <: Constant end

ConstantFP(typ::LLVMDouble, val::Real) =
    construct(ConstantFP, API.LLVMConstReal(ref(LLVMType, typ), Cdouble(val)))

convert(::Type{Float64}, val::ConstantFP) =
    API.LLVMConstRealGetDouble(ref(Value, val), Ref{API.LLVMBool}())


## global variables

export GlobalVariable, unsafe_delete!,
       initializer, initializer!,
       isthreadlocal, threadlocal!,
       threadlocalmode, threadlocalmode!,
       isconstant, constant!,
       isextinit, extinit!

import Base: get, push!

# http://llvm.org/docs/doxygen/html/group__LLVMCoreValueConstantGlobalVariable.html

@reftypedef proxy=Value kind=LLVMGlobalVariableValueKind immutable GlobalVariable <: Constant end

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
