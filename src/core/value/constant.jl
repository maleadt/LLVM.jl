## scalar

import Base: convert

export ConstantInt, ConstantFP

@reftypedef proxy=Value kind=LLVMConstantIntValueKind immutable ConstantInt <: Constant end

# NOTE: fixed set for dispatch, and because we can't rely on sizeof(T)==width(T)
typealias SmallInteger Union{Int8, Int16, Int32, Int64, UInt8, UInt16, UInt32, UInt64}
function ConstantInt{T<:SmallInteger}(typ::IntegerType, val::T, signed=false)
    wideval = convert(Int, val)
    bits = reinterpret(Culonglong, wideval)
    return construct(ConstantInt, API.LLVMConstInt(ref(typ), bits, BoolToLLVM(signed)))
end

function ConstantInt{T<:Integer}(typ::IntegerType, val::T, signed=false)
    valbits = ceil(Int, log2(abs(val))) + 1
    numwords = ceil(Int, valbits / 64)
    words = Vector{Culonglong}(numwords)
    for i in 1:numwords
        words[i] = (val >> 64(i-1)) % Culonglong
    end
    return construct(ConstantInt,
                     API.LLVMConstIntOfArbitraryPrecision(ref(typ), Cuint(numwords), words))
end

# NOTE: fixed set where sizeof(T) does match the numerical width
typealias SizeableIntegers Union{Int8, Int16, Int32, Int64, Int128, UInt8, UInt16, UInt32, UInt64, UInt128}
function ConstantInt{T<:Integer}(val::T, ctx::Context=GlobalContext())
    typ = IntType(sizeof(T)*8, ctx)
    return ConstantInt(typ, val, T<:Signed)
end

convert{T<:Unsigned}(::Type{T}, val::ConstantInt) =
    convert(T, API.LLVMConstIntGetZExtValue(ref(val)))

convert{T<:Signed}(::Type{T}, val::ConstantInt) =
    convert(T, API.LLVMConstIntGetSExtValue(ref(val)))


@reftypedef proxy=Value kind=LLVMConstantFPValueKind immutable ConstantFP <: Constant end

ConstantFP(typ::LLVMDouble, val::Real) =
    construct(ConstantFP, API.LLVMConstReal(ref(typ), Cdouble(val)))

convert(::Type{Float64}, val::ConstantFP) =
    API.LLVMConstRealGetDouble(ref(val), Ref{API.LLVMBool}())


## global values

export GlobalValue,
       parent, isdeclaration,
       linkage, linkage!,
       section, section!,
       visibility, visibility!,
       dllstorage, dllstorage!,
       unnamed_addr, unnamed_addr!,
       alignment, alignment!

parent(val::GlobalValue) = LLVM.Module(API.LLVMGetGlobalParent(ref(val)))

isdeclaration(val::GlobalValue) = BoolFromLLVM(API.LLVMIsDeclaration(ref(val)))

linkage(val::GlobalValue) = API.LLVMGetLinkage(ref(val))
linkage!(val::GlobalValue, linkage::API.LLVMLinkage) =
    API.LLVMSetLinkage(ref(val), Cuint(linkage))

section(val::GlobalValue) = unsafe_string(API.LLVMGetSection(ref(val)))
section!(val::GlobalValue, sec::String) = API.LLVMSetSection(ref(val), sec)

visibility(val::GlobalValue) = API.LLVMGetVisibility(ref(val))
visibility!(val::GlobalValue, viz::API.LLVMVisibility) =
    API.LLVMSetVisibility(ref(val), Cuint(viz))

dllstorage(val::GlobalValue) = API.LLVMGetDLLStorageClass(ref(val))
dllstorage!(val::GlobalValue, storage::API.LLVMDLLStorageClass) =
    API.LLVMSetDLLStorageClass(ref(val), Cuint(storage))

unnamed_addr(val::GlobalValue) = BoolFromLLVM(API.LLVMHasUnnamedAddr(ref(val)))
unnamed_addr!(val::GlobalValue, flag::Bool) =
    API.LLVMSetUnnamedAddr(ref(val), BoolToLLVM(flag))

alignment(val::GlobalValue) = API.LLVMGetAlignment(ref(val))
alignment!(val::GlobalValue, bytes::Integer) = API.LLVMSetAlignment(ref(val), Cuint(bytes))


## global variables

export GlobalVariable, unsafe_delete!,
       initializer, initializer!,
       isthreadlocal, threadlocal!,
       threadlocalmode, threadlocalmode!,
       isconstant, constant!,
       isextinit, extinit!

import Base: get, push!

@reftypedef proxy=Value kind=LLVMGlobalVariableValueKind immutable GlobalVariable <: GlobalObject end

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
