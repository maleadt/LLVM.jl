export LLVMType, issized, context, show

import Base: show

# Construct an unknown type of type object from a type ref.
function dynamic_construct(::Type{LLVMType}, ref::API.LLVMTypeRef)
    ref == C_NULL && throw(NullException())
    return identify(LLVMType, API.LLVMGetTypeKind(ref))(ref)
end

# Construct an specific type of type object from a type ref.
# In debug mode, this checks if the object type matches the underlying ref type.
@inline function construct{T<:LLVMType}(::Type{T}, ref::API.LLVMTypeRef)
    T.abstract && error("Cannot construct an abstract type, use a concrete type instead (use dynamic_construct if unknown)")
    ref == C_NULL && throw(NullException())
    @static if DEBUG
        RealT = identify(LLVMType, API.LLVMGetTypeKind(ref))
        if T != RealT
            error("invalid conversion of $RealT reference to $T")
        end
    end
    return T(ref)
end

issized(typ::LLVMType) =
    BoolFromLLVM(API.LLVMTypeIsSized(ref(typ)))
context(typ::LLVMType) = Context(API.LLVMGetTypeContext(ref(typ)))

function show(io::IO, typ::LLVMType)
    output = unsafe_string(API.LLVMPrintTypeToString(ref(typ)))
    print(io, output)
end


## integer

export width

@reftypedef proxy=LLVMType kind=LLVMIntegerTypeKind immutable IntegerType <: LLVMType end

for T in [:Int1, :Int8, :Int16, :Int32, :Int64, :Int128]
    jl_fname = Symbol(T, :Type)
    api_fname = Symbol(:LLVM, jl_fname)
    @eval begin
        $jl_fname() = construct(IntegerType, API.$api_fname())
        $jl_fname(ctx::Context) =
            construct(IntegerType,
                      API.$(Symbol(api_fname, :InContext))(ref(ctx)))
    end
end

IntType(bits::Integer) = construct(IntegerType, API.LLVMIntType(Cuint(bits)))
IntType(bits::Integer, ctx::Context) =
    construct(IntegerType, API.LLVMIntTypeInContext(ref(ctx), Cuint(bits)))

width(inttyp::IntegerType) = API.LLVMGetIntTypeWidth(ref(inttyp))


## floating-point

# NOTE: this type doesn't exist in the LLVM API,
#       we add it for convenience of typechecking generic values (see execution.jl)
@reftypedef abstract FloatingPointType <: LLVMType

# NOTE: we don't handle the obscure types here (:X86FP80, :FP128, :PPCFP128),
#       they would also need special casing as LLVMPPCFP128Type != LLVMPPC_FP128TypeKind
for T in [:Half, :Float, :Double]
    jl_fname = Symbol(T, :Type)
    api_typename = Symbol(:LLVM, T)
    api_fname = Symbol(:LLVM, jl_fname)
    enumkind = Symbol(:LLVM, T, :TypeKind)
    @eval begin
        @reftypedef proxy=LLVMType kind=$enumkind immutable $api_typename <: FloatingPointType end

        $jl_fname() = construct($api_typename, API.$api_fname())
        $jl_fname(ctx::Context) =
            construct($api_typename,
                      API.$(Symbol(api_fname, :InContext))(ref(ctx)))
    end
end


## function types

export isvararg, return_type, parameters

@reftypedef proxy=LLVMType kind=LLVMFunctionTypeKind immutable FunctionType <: LLVMType end

FunctionType{T<:LLVMType}(rettyp::LLVMType, params::Vector{T}=LLVMType[], vararg::Bool=false) =
    FunctionType(API.LLVMFunctionType(ref(rettyp), ref.(params),
                                      Cuint(length(params)), BoolToLLVM(vararg)))

isvararg(ft::FunctionType) =
    BoolFromLLVM(API.LLVMIsFunctionVarArg(ref(ft)))

return_type(ft::FunctionType) =
    dynamic_construct(LLVMType, API.LLVMGetReturnType(ref(ft)))

function parameters(ft::FunctionType)
    nparams = API.LLVMCountParamTypes(ref(ft))
    params = Vector{API.LLVMTypeRef}(nparams)
    API.LLVMGetParamTypes(ref(ft), params)
    return map(t->dynamic_construct(LLVMType, t), params)
end



## composite types

@reftypedef abstract CompositeType <: LLVMType


## sequential types

export addrspace

@reftypedef abstract SequentialType <: CompositeType

import Base: length, size, eltype

eltype(typ::SequentialType) =
    dynamic_construct(LLVMType, API.LLVMGetElementType(ref(typ)))

@reftypedef proxy=LLVMType kind=LLVMPointerTypeKind immutable PointerType <: SequentialType end

function PointerType(eltyp::LLVMType, addrspace=0)
    return PointerType(API.LLVMPointerType(ref(eltyp),
                                           Cuint(addrspace)))
end

addrspace(ptrtyp::PointerType) =
    API.LLVMGetPointerAddressSpace(ref(ptrtyp))

@reftypedef proxy=LLVMType kind=LLVMArrayTypeKind immutable ArrayType <: SequentialType end

function ArrayType(eltyp::LLVMType, count)
    return ArrayType(API.LLVMArrayType(ref(eltyp), Cuint(count)))
end

length(arrtyp::ArrayType) = API.LLVMGetArrayLength(ref(arrtyp))

@reftypedef proxy=LLVMType kind=LLVMVectorTypeKind immutable VectorType <: SequentialType end

function VectorType(eltyp::LLVMType, count)
    return VectorType(API.LLVMVectorType(ref(eltyp), Cuint(count)))
end

size(vectyp::VectorType) = API.LLVMGetVectorSize(ref(vectyp))


## structure types

export name, ispacked, isopaque, elements!

@reftypedef proxy=LLVMType kind=LLVMStructTypeKind immutable StructType <: SequentialType end

function StructType(name::String, ctx::Context)
    return StructType(API.LLVMStructCreateNamed(ref(ctx), name))
end

StructType{T<:LLVMType}(elems::Vector{T}, packed::Bool=false) =
    StructType(API.LLVMStructType(ref.(elems), Cuint(length(elems)),
                                  BoolToLLVM(packed)))

StructType{T<:LLVMType}(elems::Vector{T}, ctx::Context, packed::Bool=false) =
    StructType(API.LLVMStructTypeInContext(ref(ctx), ref.(elems),
                                           Cuint(length(elems)), BoolToLLVM(packed)))

name(structtyp::StructType) =
    unsafe_string(API.LLVMGetStructName(ref(structtyp)))
ispacked(structtyp::StructType) =
    BoolFromLLVM(API.LLVMIsPackedStruct(ref(structtyp)))
isopaque(structtyp::StructType) =
    BoolFromLLVM(API.LLVMIsOpaqueStruct(ref(structtyp)))

elements!{T<:LLVMType}(structtyp::StructType, elems::Vector{T}, packed::Bool=false) =
    API.LLVMStructSetBody(ref(structtyp), ref.(elems),
                          Cuint(length(elems)), BoolToLLVM(packed))

# element iteration

export elements

import Base: eltype, getindex, setindex!, start, next, done, length, endof, collect

immutable StructTypeElementSet
    typ::StructType
end

elements(typ::StructType) = StructTypeElementSet(typ)

eltype(::StructTypeElementSet) = LLVMType

getindex(iter::StructTypeElementSet, i) =
    dynamic_construct(LLVMType, API.LLVMStructGetTypeAtIndex(ref(iter.typ), Cuint(i-1)))

start(iter::StructTypeElementSet) = (1,length(iter))

next(iter::StructTypeElementSet, state) =
    (iter[state[1]], (state[1]+1,state[2]))

done(iter::StructTypeElementSet, state) = (state[1] > state[2])

length(iter::StructTypeElementSet) = API.LLVMCountStructElementTypes(ref(iter.typ))
endof(iter::StructTypeElementSet) = length(iter)

# NOTE: optimized `collect`
function collect(iter::StructTypeElementSet)
    elems = Vector{API.LLVMTypeRef}(length(iter))
    API.LLVMGetStructElementTypes(ref(iter.typ), elems)
    return map(el->dynamic_construct(LLVMType, el), elems)
end


## other

@reftypedef proxy=LLVMType kind=LLVMVoidTypeKind immutable VoidType <: LLVMType end

VoidType() = construct(VoidType, API.LLVMVoidType())
VoidType(ctx::Context) =
    construct(VoidType, API.LLVMVoidTypeInContext(ref(ctx)))

@reftypedef proxy=LLVMType kind=LLVMLabelTypeKind immutable LabelType <: LLVMType end

LabelType() = construct(LabelType, API.LLVMLabelType())
LabelType(ctx::Context) =
    construct(LabelType, API.LLVMLabelTypeInContext(ref(ctx)))
