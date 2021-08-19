export LLVMType, issized, context, show

# subtypes are expected to have a 'ref::API.LLVMTypeRef' field
abstract type LLVMType end

Base.eltype(typ::LLVMType) = Any

Base.unsafe_convert(::Type{API.LLVMTypeRef}, typ::LLVMType) = typ.ref

const type_kinds = Dict{API.LLVMTypeKind, Type{<:LLVMType}}()
function identify(::Type{LLVMType}, ref::API.LLVMTypeRef)
    kind = API.LLVMGetTypeKind(ref)
    haskey(type_kinds, kind) || error("Unknown type kind $kind")
    return type_kinds[kind]
end

@inline function refcheck(::Type{T}, ref::API.LLVMTypeRef) where T<:LLVMType
    ref==C_NULL && throw(UndefRefError())
    @static if Base.JLOptions().debug_level >= 2
        T′ = identify(LLVMType, ref)
        if T != T′
            error("invalid conversion of $T′ type reference to $T")
        end
    end
end

# Construct a concretely typed type object from an abstract type ref
function LLVMType(ref::API.LLVMTypeRef)
    ref == C_NULL && throw(UndefRefError())
    T = identify(LLVMType, ref)
    return T(ref)::LLVMType
end

issized(typ::LLVMType) =
    convert(Core.Bool, API.LLVMTypeIsSized(typ))
context(typ::LLVMType) = Context(API.LLVMGetTypeContext(typ))

function Base.show(io::IO, typ::LLVMType)
    output = unsafe_message(API.LLVMPrintTypeToString(typ))
    print(io, output)
end

Base.isempty(@nospecialize(T::LLVMType)) = false


## integer

export width

@checked struct IntegerType <: LLVMType
    ref::API.LLVMTypeRef
end
type_kinds[API.LLVMIntegerTypeKind] = IntegerType

for T in [:Int1, :Int8, :Int16, :Int32, :Int64, :Int128]
    jl_fname = Symbol(T, :Type)
    api_fname = Symbol(:LLVM, jl_fname)
    @eval begin
        $jl_fname(ctx::Context) =
            IntegerType(API.$(Symbol(api_fname, :InContext))(ctx))
    end
end

IntType(bits::Integer; ctx::Context) =
    IntegerType(API.LLVMIntTypeInContext(ctx, bits))

width(inttyp::IntegerType) = API.LLVMGetIntTypeWidth(inttyp)


## floating-point

# NOTE: this type doesn't exist in the LLVM API,
#       we add it for convenience of typechecking generic values (see execution.jl)
 abstract type FloatingPointType <: LLVMType end

# NOTE: we don't handle the obscure types here (:X86FP80, :FP128, :PPCFP128),
#       they would also need special casing as LLVMPPCFP128Type != LLVMPPC_FP128TypeKind
for T in [:Half, :Float, :Double]
    jl_fname = Symbol(T, :Type)
    api_typename = Symbol(:LLVM, T)
    api_fname = Symbol(:LLVM, jl_fname)
    enumkind = Symbol(:LLVM, T, :TypeKind)
    @eval begin
        @checked struct $api_typename <: FloatingPointType
            ref::API.LLVMTypeRef
        end
        type_kinds[API.$enumkind] = $api_typename

        $jl_fname(ctx::Context) =
            $api_typename(API.$(Symbol(api_fname, :InContext))(ctx))
    end
end


## function types

export isvararg, return_type, parameters

@checked struct FunctionType <: LLVMType
    ref::API.LLVMTypeRef
end
type_kinds[API.LLVMFunctionTypeKind] = FunctionType

FunctionType(rettyp::LLVMType, params::Vector{<:LLVMType}=LLVMType[];
             vararg::Core.Bool=false) =
    FunctionType(API.LLVMFunctionType(rettyp, params,
                                      length(params), convert(Bool, vararg)))

isvararg(ft::FunctionType) =
    convert(Core.Bool, API.LLVMIsFunctionVarArg(ft))

return_type(ft::FunctionType) =
    LLVMType(API.LLVMGetReturnType(ft))

function parameters(ft::FunctionType)
    nparams = API.LLVMCountParamTypes(ft)
    params = Vector{API.LLVMTypeRef}(undef, nparams)
    API.LLVMGetParamTypes(ft, params)
    return LLVMType[LLVMType(param) for param in params]
end



## composite types

abstract type CompositeType <: LLVMType end


## sequential types

export addrspace

abstract type SequentialType <: CompositeType end

Base.eltype(typ::SequentialType) = LLVMType(API.LLVMGetElementType(typ))


@checked struct PointerType <: SequentialType
    ref::API.LLVMTypeRef
end
type_kinds[API.LLVMPointerTypeKind] = PointerType

function PointerType(eltyp::LLVMType, addrspace=0)
    return PointerType(API.LLVMPointerType(eltyp, addrspace))
end

addrspace(ptrtyp::PointerType) =
    API.LLVMGetPointerAddressSpace(ptrtyp)


@checked struct ArrayType <: SequentialType
    ref::API.LLVMTypeRef
end
type_kinds[API.LLVMArrayTypeKind] = ArrayType

function ArrayType(eltyp::LLVMType, count)
    return ArrayType(API.LLVMArrayType(eltyp, count))
end

Base.length(arrtyp::ArrayType) = API.LLVMGetArrayLength(arrtyp)

Base.isempty(@nospecialize(T::ArrayType)) = length(T) == 0 || isempty(eltype(T))


@checked struct VectorType <: SequentialType
    ref::API.LLVMTypeRef
end
type_kinds[API.LLVMVectorTypeKind] = VectorType

function VectorType(eltyp::LLVMType, count)
    return VectorType(API.LLVMVectorType(eltyp, count))
end

Base.size(vectyp::VectorType) = API.LLVMGetVectorSize(vectyp)


## structure types

export name, ispacked, isopaque, elements!

@checked struct StructType <: SequentialType
    ref::API.LLVMTypeRef
end
type_kinds[API.LLVMStructTypeKind] = StructType

function StructType(name::String; ctx::Context)
    return StructType(API.LLVMStructCreateNamed(ctx, name))
end

StructType(elems::Vector{<:LLVMType}; packed::Core.Bool=false, ctx::Context) =
    StructType(API.LLVMStructTypeInContext(ctx, elems, length(elems), convert(Bool, packed)))

name(structtyp::StructType) =
    unsafe_string(API.LLVMGetStructName(structtyp))
ispacked(structtyp::StructType) =
    convert(Core.Bool, API.LLVMIsPackedStruct(structtyp))
isopaque(structtyp::StructType) =
    convert(Core.Bool, API.LLVMIsOpaqueStruct(structtyp))

elements!(structtyp::StructType, elems::Vector{<:LLVMType}, packed::Core.Bool=false) =
    API.LLVMStructSetBody(structtyp, elems,
                          length(elems), convert(Bool, packed))

Base.isempty(@nospecialize(T::StructType)) =
    isempty(elements(T)) || all(isempty, elements(T))

# element iteration

export elements

struct StructTypeElementSet
    typ::StructType
end

elements(typ::StructType) = StructTypeElementSet(typ)

Base.eltype(::StructTypeElementSet) = LLVMType

function Base.getindex(iter::StructTypeElementSet, i)
    @boundscheck 1 <= i <= length(iter) || throw(BoundsError(iter, i))
    return LLVMType(API.LLVMStructGetTypeAtIndex(iter.typ, i-1))
end

function Base.iterate(iter::StructTypeElementSet, i=1)
    i >= length(iter) + 1 ? nothing : (iter[i], i+1)
end

Base.length(iter::StructTypeElementSet) = API.LLVMCountStructElementTypes(iter.typ)

Base.lastindex(iter::StructTypeElementSet) = length(iter)

# NOTE: optimized `collect`
function Base.collect(iter::StructTypeElementSet)
    elems = Vector{API.LLVMTypeRef}(undef, length(iter))
    API.LLVMGetStructElementTypes(iter.typ, elems)
    return LLVMType[LLVMType(elem) for elem in elems]
end


## other

@checked struct VoidType <: LLVMType
    ref::API.LLVMTypeRef
end
type_kinds[API.LLVMVoidTypeKind] = VoidType

VoidType(ctx::Context) = VoidType(API.LLVMVoidTypeInContext(ctx))

@checked struct LabelType <: LLVMType
    ref::API.LLVMTypeRef
end
type_kinds[API.LLVMLabelTypeKind] = LabelType

LabelType(ctx::Context) = LabelType(API.LLVMLabelTypeInContext(ctx))

@checked struct MetadataType <: LLVMType
    ref::API.LLVMTypeRef
end
type_kinds[API.LLVMMetadataTypeKind] = MetadataType

MetadataType(ctx::Context) = MetadataType(API.LLVMMetadataTypeInContext(ctx))

@checked struct TokenType <: LLVMType
    ref::API.LLVMTypeRef
end
type_kinds[API.LLVMTokenTypeKind] = TokenType

TokenType(ctx::Context) = TokenType(API.LLVMTokenTypeInContext(ctx))


## type iteration

export types

struct ContextTypeDict <: AbstractDict{String,LLVMType}
    ctx::Context
end

# FIXME: remove on LLVM 12
function LLVMGetTypeByName2(ctx::Context, name)
    Module("dummy"; ctx) do mod
        API.LLVMGetTypeByName(mod, name)
    end
end

types(ctx::Context) = ContextTypeDict(ctx)

function Base.haskey(iter::ContextTypeDict, name::String)
    return LLVMGetTypeByName2(iter.ctx, name) != C_NULL
end

function Base.getindex(iter::ContextTypeDict, name::String)
    objref = LLVMGetTypeByName2(iter.ctx, name)
    objref == C_NULL && throw(KeyError(name))
    return LLVMType(objref)
end
