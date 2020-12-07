export null, isnull, all_ones, UndefValue, PointerNull

null(typ::LLVMType) = Value(API.LLVMConstNull(typ))

all_ones(typ::LLVMType) = Value(API.LLVMConstAllOnes(typ))

isnull(val::Value) = convert(Core.Bool, API.LLVMIsNull(val))


abstract type Constant <: User end

# forward declarations
@checked mutable struct Module
    ref::API.LLVMModuleRef
end
abstract type Instruction <: User end


@checked struct PointerNull <: Constant
    ref::API.LLVMValueRef
end
identify(::Type{Value}, ::Val{API.LLVMConstantPointerNullValueKind}) = PointerNull

PointerNull(typ::PointerType) = PointerNull(API.LLVMConstPointerNull(typ))


@checked struct UndefValue <: Constant
    ref::API.LLVMValueRef
end
identify(::Type{Value}, ::Val{API.LLVMUndefValueValueKind}) = UndefValue

UndefValue(typ::LLVMType) = UndefValue(API.LLVMGetUndef(typ))


## scalar

export ConstantInt, ConstantFP

@checked struct ConstantInt <: Constant
    ref::API.LLVMValueRef
end
identify(::Type{Value}, ::Val{API.LLVMConstantIntValueKind}) = ConstantInt

# NOTE: fixed set for dispatch, also because we can't rely on sizeof(T)==width(T)
const WideInteger = Union{Int64, UInt64}
ConstantInt(typ::IntegerType, val::WideInteger, signed=false) =
    ConstantInt(API.LLVMConstInt(typ, reinterpret(Culonglong, val),
                convert(Bool, signed)))
const SmallInteger = Union{Int8, Int16, Int32, UInt8, UInt16, UInt32}
ConstantInt(typ::IntegerType, val::SmallInteger, signed=false) =
    ConstantInt(typ, convert(Int64, val), signed)

function ConstantInt(typ::IntegerType, val::Integer, signed=false)
    valbits = ceil(Int, log2(abs(val))) + 1
    numwords = ceil(Int, valbits / 64)
    words = Vector{Culonglong}(undef, numwords)
    for i in 1:numwords
        words[i] = (val >> 64(i-1)) % Culonglong
    end
    return ConstantInt(API.LLVMConstIntOfArbitraryPrecision(typ, numwords, words))
end

# NOTE: fixed set where sizeof(T) does match the numerical width
const SizeableInteger = Union{Int8, Int16, Int32, Int64, Int128, UInt8, UInt16, UInt32, UInt64, UInt128}
function ConstantInt(val::T, ctx::Context) where T<:SizeableInteger
    typ = IntType(sizeof(T)*8, ctx)
    return ConstantInt(typ, val, T<:Signed)
end

Base.convert(::Type{T}, val::ConstantInt) where {T<:Unsigned} =
    convert(T, API.LLVMConstIntGetZExtValue(val))

Base.convert(::Type{T}, val::ConstantInt) where {T<:Signed} =
    convert(T, API.LLVMConstIntGetSExtValue(val))


@checked struct ConstantFP <: Constant
    ref::API.LLVMValueRef
end
identify(::Type{Value}, ::Val{API.LLVMConstantFPValueKind}) = ConstantFP

ConstantFP(typ::FloatingPointType, val::Real) =
    ConstantFP(API.LLVMConstReal(typ, Cdouble(val)))

ConstantFP(val::Float16, ctx::Context) =
    ConstantFP(HalfType(ctx), val)
ConstantFP(val::Float32, ctx::Context) =
    ConstantFP(FloatType(ctx), val)
ConstantFP(val::Float64, ctx::Context) =
    ConstantFP(DoubleType(ctx), val)

Base.convert(::Type{T}, val::ConstantFP) where {T<:AbstractFloat} =
    convert(T, API.LLVMConstRealGetDouble(val, Ref{API.LLVMBool}()))


## aggregate

export ConstantAggregateZero

@checked struct ConstantAggregateZero <: Constant
    ref::API.LLVMValueRef
end
identify(::Type{Value}, ::Val{API.LLVMConstantAggregateZeroValueKind}) = ConstantAggregateZero

# there currently seems to be no function in the LLVM-C interface which returns a
# ConstantAggregateZero value directly, but values can occur through calls to LLVMConstNull


## constant expressions

export ConstantExpr, ConstantAggregate, ConstantArray, ConstantStruct, ConstantVector, InlineAsm

@checked struct ConstantExpr <: Constant
    ref::API.LLVMValueRef
end
identify(::Type{Value}, ::Val{API.LLVMConstantExprValueKind}) = ConstantExpr

abstract type ConstantAggregate <: Constant end

@checked struct ConstantArray <: ConstantAggregate
    ref::API.LLVMValueRef
end
identify(::Type{Value}, ::Val{API.LLVMConstantArrayValueKind}) = ConstantArray
identify(::Type{Value}, ::Val{API.LLVMConstantDataArrayValueKind}) = ConstantArray

function ConstantArray(typ::LLVMType, data::AbstractArray{T,N}) where {T<:Constant,N}
    if N == 1
        return ConstantArray(API.LLVMConstArray(typ, Array(data), length(data)))
    end

    # FIXME: once we drop support for julia 1.0, we can use `eachslice(data, dims=1)` instead of this monstrosity
    ca_vec = map(x->ConstantArray(typ, x), (view(data, i, ntuple(d->(:), N-1)...) for i in axes(data, 1)))
    ca_typ = llvmtype(first(ca_vec))

    return ConstantArray(API.LLVMConstArray(ca_typ, ca_vec, length(ca_vec)))
end
ConstantArray(typ::IntegerType, data::AbstractArray{T,N}) where {T<:Integer,N} =
    ConstantArray(typ, map(x->ConstantInt(typ, x), data))
ConstantArray(typ::FloatingPointType, data::AbstractArray{T,N}) where {T<:AbstractFloat,N} =
    ConstantArray(typ, map(x->ConstantFP(typ, x), data))

# NOTE: getindex is not supported for multidimensionsal constant arrays
Base.getindex(ca::ConstantArray, idx::Integer) =
    API.LLVMGetElementAsConstant(ca, idx-1)
Base.length(ca::ConstantArray) = length(llvmtype(ca))
Base.eltype(ca::ConstantArray) = eltype(llvmtype(ca))
Base.convert(::Type{Array{T,1}}, ca::ConstantArray) where {T<:Integer} =
    [convert(T,ConstantInt(ca[i])) for i in 1:length(ca)]
Base.convert(::Type{Array{T,1}}, ca::ConstantArray) where {T<:AbstractFloat} =
    [convert(T,ConstantFP(ca[i])) for i in 1:length(ca)]

@checked struct ConstantStruct <: ConstantAggregate
    ref::API.LLVMValueRef
end
identify(::Type{Value}, ::Val{API.LLVMConstantStructValueKind}) = ConstantStruct

ConstantStruct(constant_vals::Vector{T}, packed::Core.Bool=false) where {T<:Constant} =
    ConstantStruct(API.LLVMConstStruct(constant_vals, length(constant_vals), convert(Bool, packed)))
ConstantStruct(constant_vals::Vector{T}, ctx::Context, packed::Core.Bool=false) where {T<:Constant} =
    ConstantStruct(API.LLVMConstStructInContext(ctx, constant_vals, length(constant_vals), convert(Bool, packed)))
ConstantStruct(constant_vals::Vector{T}, typ::LLVMType) where {T<:Constant} =
    ConstantStruct(API.LLVMConstNamedStruct(typ, constant_vals, length(constant_vals)))

function struct_to_constants(value, ctx::Context)
    constants = Vector{Constant}()

    for fieldname in fieldnames(typeof(value))
        field = getfield(value, fieldname)

        if isa(field, Core.Bool)
            typ = LLVM.Int1Type(ctx)
            push!(constants, ConstantInt(typ, Int(field)))
        elseif isa(field, Integer)
            push!(constants, ConstantInt(field, ctx))
        elseif isa(field, AbstractFloat)
            push!(constants, ConstantFP(field, ctx))
        else # TODO: nested structs?
            throw(ArgumentError("only structs with boolean, integer and floating point fields are allowed"))
        end
    end

    return constants
end

function ConstantStruct(value, packed::Core.Bool=false)
    isbits(value) || throw(ArgumentError("`value` must be isbits"))
    constants = struct_to_constants(value, GlobalContext())
    return ConstantStruct(constants, packed)
end

function ConstantStruct(value, ctx::Context, packed::Core.Bool=false)
    isbits(value) || throw(ArgumentError("`value` must be isbits"))
    constants = struct_to_constants(value, ctx)
    return ConstantStruct(constants, ctx, packed)
end

function ConstantStruct(value, typ::LLVMType)
    isbits(value) || throw(ArgumentError("`value` must be isbits"))
    constants = struct_to_constants(value, context(typ))
    return ConstantStruct(constants, typ)
end

@checked struct ConstantVector <: ConstantAggregate
    ref::API.LLVMValueRef
end
identify(::Type{Value}, ::Val{API.LLVMConstantVectorValueKind}) = ConstantVector

@checked struct InlineAsm <: Constant
    ref::API.LLVMValueRef
end
identify(::Type{Value}, ::Val{API.LLVMInlineAsmValueKind}) = InlineAsm

InlineAsm(typ::FunctionType, asm::String, constraints::String,
          side_effects::Core.Bool, align_stack::Core.Bool=false) =
    InlineAsm(API.LLVMConstInlineAsm(typ, asm, constraints,
                                     convert(Bool, side_effects),
                                     convert(Bool, align_stack)))


## global values

abstract type GlobalValue <: Constant end

export GlobalValue,
       isdeclaration,
       linkage, linkage!,
       section, section!,
       visibility, visibility!,
       dllstorage, dllstorage!,
       unnamed_addr, unnamed_addr!,
       alignment, alignment!

parent(val::GlobalValue) = Module(API.LLVMGetGlobalParent(val))

isdeclaration(val::GlobalValue) = convert(Core.Bool, API.LLVMIsDeclaration(val))

linkage(val::GlobalValue) = API.LLVMGetLinkage(val)
linkage!(val::GlobalValue, linkage::API.LLVMLinkage) =
    API.LLVMSetLinkage(val, linkage)

function section(val::GlobalValue)
  #=
  The following started to fail on LLVM 4.0:
    Context() do ctx
      LLVM.Module("SomeModule", ctx) do mod
        st = LLVM.StructType("SomeType", ctx)
        ft = LLVM.FunctionType(st, [st])
        fn = LLVM.Function(mod, "SomeFunction", ft)
        section(fn) == ""
      end
      end
  =#
  section_ptr = API.LLVMGetSection(val)
  return section_ptr != C_NULL ? unsafe_string(section_ptr) : ""
end
section!(val::GlobalValue, sec::String) = API.LLVMSetSection(val, sec)

visibility(val::GlobalValue) = API.LLVMGetVisibility(val)
visibility!(val::GlobalValue, viz::API.LLVMVisibility) =
    API.LLVMSetVisibility(val, viz)

dllstorage(val::GlobalValue) = API.LLVMGetDLLStorageClass(val)
dllstorage!(val::GlobalValue, storage::API.LLVMDLLStorageClass) =
    API.LLVMSetDLLStorageClass(val, storage)

unnamed_addr(val::GlobalValue) = convert(Core.Bool, API.LLVMHasUnnamedAddr(val))
unnamed_addr!(val::GlobalValue, flag::Core.Bool) =
    API.LLVMSetUnnamedAddr(val, convert(Bool, flag))

const AlignedValue = Union{GlobalValue,Instruction}   # load, store, alloca
alignment(val::AlignedValue) = API.LLVMGetAlignment(val)
alignment!(val::AlignedValue, bytes::Integer) = API.LLVMSetAlignment(val, bytes)


## global variables

abstract type GlobalObject <: GlobalValue end

export GlobalVariable, unsafe_delete!,
       initializer, initializer!,
       isthreadlocal, threadlocal!,
       threadlocalmode, threadlocalmode!,
       isconstant, constant!,
       isextinit, extinit!

@checked struct GlobalVariable <: GlobalObject
    ref::API.LLVMValueRef
end
identify(::Type{Value}, ::Val{API.LLVMGlobalVariableValueKind}) = GlobalVariable

GlobalVariable(mod::Module, typ::LLVMType, name::String) =
    GlobalVariable(API.LLVMAddGlobal(mod, typ, name))

GlobalVariable(mod::Module, typ::LLVMType, name::String, addrspace::Integer) =
    GlobalVariable(API.LLVMAddGlobalInAddressSpace(mod, typ,
                                                   name, addrspace))

unsafe_delete!(::Module, gv::GlobalVariable) = API.LLVMDeleteGlobal(gv)

function initializer(gv::GlobalVariable)
    init = API.LLVMGetInitializer(gv)
    init == C_NULL ? nothing : Value(init)
end
initializer!(gv::GlobalVariable, val::Constant) =
  API.LLVMSetInitializer(gv, val)
initializer!(gv::GlobalVariable, ::Nothing) =
  API.LLVMSetInitializer(gv, C_NULL)

isthreadlocal(gv::GlobalVariable) = convert(Core.Bool, API.LLVMIsThreadLocal(gv))
threadlocal!(gv::GlobalVariable, bool) =
  API.LLVMSetThreadLocal(gv, convert(Bool, bool))

isconstant(gv::GlobalVariable) = convert(Core.Bool, API.LLVMIsGlobalConstant(gv))
constant!(gv::GlobalVariable, bool) =
  API.LLVMSetGlobalConstant(gv, convert(Bool, bool))

threadlocalmode(gv::GlobalVariable) = API.LLVMGetThreadLocalMode(gv)
threadlocalmode!(gv::GlobalVariable, mode) =
  API.LLVMSetThreadLocalMode(gv, mode)

isextinit(gv::GlobalVariable) =
  convert(Core.Bool, API.LLVMIsExternallyInitialized(gv))
extinit!(gv::GlobalVariable, bool) =
  API.LLVMSetExternallyInitialized(gv, convert(Bool, bool))
