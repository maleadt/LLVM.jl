export LLVMType, issized, context, show

abstract type LLVMType end
reftype(::Type{T}) where {T<:LLVMType} = API.LLVMTypeRef

identify(::Type{LLVMType}, ref::API.LLVMTypeRef) =
    identify(LLVMType, Val{API.LLVMGetTypeKind(ref)}())
identify(::Type{LLVMType}, ::Val{K}) where {K} = error("Unknown type kind $K")

@inline function check(::Type{T}, ref::API.LLVMTypeRef) where T<:LLVMType
    ref==C_NULL && throw(UndefRefError())
    if Base.JLOptions().debug_level >= 2
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
    convert(Core.Bool, API.LLVMTypeIsSized(ref(typ)))
context(typ::LLVMType) = Context(API.LLVMGetTypeContext(ref(typ)))

function Base.show(io::IO, typ::LLVMType)
    output = unsafe_string(API.LLVMPrintTypeToString(ref(typ)))
    print(io, output)
end


## integer

export width

@checked struct IntegerType <: LLVMType
    ref::reftype(LLVMType)
end
identify(::Type{LLVMType}, ::Val{API.LLVMIntegerTypeKind}) = IntegerType

for T in [:Int1, :Int8, :Int16, :Int32, :Int64, :Int128]
    jl_fname = Symbol(T, :Type)
    api_fname = Symbol(:LLVM, jl_fname)
    @eval begin
        $jl_fname() = IntegerType(API.$api_fname())
        $jl_fname(ctx::Context) =
            IntegerType(
                      API.$(Symbol(api_fname, :InContext))(ref(ctx)))
    end
end

IntType(bits::Integer) = IntegerType(API.LLVMIntType(Cuint(bits)))
IntType(bits::Integer, ctx::Context) =
    IntegerType(API.LLVMIntTypeInContext(ref(ctx), Cuint(bits)))

width(inttyp::IntegerType) = API.LLVMGetIntTypeWidth(ref(inttyp))


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
            ref::reftype(FloatingPointType)
        end
        identify(::Type{LLVMType}, ::Val{API.$enumkind}) = $api_typename

        $jl_fname() = $api_typename(API.$api_fname())
        $jl_fname(ctx::Context) =
            $api_typename(API.$(Symbol(api_fname, :InContext))(ref(ctx)))
    end
end


## function types

export isvararg, return_type, parameters

@checked struct FunctionType <: LLVMType
    ref::reftype(LLVMType)
end
identify(::Type{LLVMType}, ::Val{API.LLVMFunctionTypeKind}) = FunctionType

FunctionType(rettyp::LLVMType, params::Vector{T}=LLVMType[], vararg::Core.Bool=false) where {T<:LLVMType} =
    FunctionType(API.LLVMFunctionType(ref(rettyp), ref.(params),
                                      Cuint(length(params)), convert(Bool, vararg)))

isvararg(ft::FunctionType) =
    convert(Core.Bool, API.LLVMIsFunctionVarArg(ref(ft)))

return_type(ft::FunctionType) =
    LLVMType(API.LLVMGetReturnType(ref(ft)))

function parameters(ft::FunctionType)
    nparams = API.LLVMCountParamTypes(ref(ft))
    params = Vector{API.LLVMTypeRef}(undef, nparams)
    API.LLVMGetParamTypes(ref(ft), params)
    return LLVMType[LLVMType(param) for param in params]
end



## composite types

abstract type CompositeType <: LLVMType end


## sequential types

export addrspace

abstract type SequentialType <: CompositeType end

Base.eltype(typ::SequentialType) = LLVMType(API.LLVMGetElementType(ref(typ)))


@checked struct PointerType <: SequentialType
    ref::reftype(SequentialType)
end
identify(::Type{LLVMType}, ::Val{API.LLVMPointerTypeKind}) = PointerType

function PointerType(eltyp::LLVMType, addrspace=0)
    return PointerType(API.LLVMPointerType(ref(eltyp),
                                           Cuint(addrspace)))
end

addrspace(ptrtyp::PointerType) =
    API.LLVMGetPointerAddressSpace(ref(ptrtyp))


@checked struct ArrayType <: SequentialType
    ref::reftype(SequentialType)
end
identify(::Type{LLVMType}, ::Val{API.LLVMArrayTypeKind}) = ArrayType

function ArrayType(eltyp::LLVMType, count)
    return ArrayType(API.LLVMArrayType(ref(eltyp), Cuint(count)))
end

Base.length(arrtyp::ArrayType) = API.LLVMGetArrayLength(ref(arrtyp))


@checked struct VectorType <: SequentialType
    ref::reftype(SequentialType)
end
identify(::Type{LLVMType}, ::Val{API.LLVMVectorTypeKind}) = VectorType

function VectorType(eltyp::LLVMType, count)
    return VectorType(API.LLVMVectorType(ref(eltyp), Cuint(count)))
end

Base.size(vectyp::VectorType) = API.LLVMGetVectorSize(ref(vectyp))


## structure types

export name, ispacked, isopaque, elements!

@checked struct StructType <: SequentialType
    ref::reftype(SequentialType)
end
identify(::Type{LLVMType}, ::Val{API.LLVMStructTypeKind}) = StructType

function StructType(name::String, ctx::Context=GlobalContext())
    return StructType(API.LLVMStructCreateNamed(ref(ctx), name))
end

StructType(elems::Vector{T}, packed::Core.Bool=false) where {T<:LLVMType} =
    StructType(API.LLVMStructType(ref.(elems), Cuint(length(elems)),
                                  convert(Bool, packed)))

StructType(elems::Vector{T}, ctx::Context, packed::Core.Bool=false) where {T<:LLVMType} =
    StructType(API.LLVMStructTypeInContext(ref(ctx), ref.(elems),
                                           Cuint(length(elems)), convert(Bool, packed)))

name(structtyp::StructType) =
    unsafe_string(API.LLVMGetStructName(ref(structtyp)))
ispacked(structtyp::StructType) =
    convert(Core.Bool, API.LLVMIsPackedStruct(ref(structtyp)))
isopaque(structtyp::StructType) =
    convert(Core.Bool, API.LLVMIsOpaqueStruct(ref(structtyp)))

elements!(structtyp::StructType, elems::Vector{T}, packed::Core.Bool=false) where {T<:LLVMType} =
    API.LLVMStructSetBody(ref(structtyp), ref.(elems),
                          Cuint(length(elems)), convert(Bool, packed))

# element iteration

export elements

struct StructTypeElementSet
    typ::StructType
end

elements(typ::StructType) = StructTypeElementSet(typ)

Base.eltype(::StructTypeElementSet) = LLVMType

Base.getindex(iter::StructTypeElementSet, i) =
    LLVMType(API.LLVMStructGetTypeAtIndex(ref(iter.typ), Cuint(i-1)))

function Base.iterate(iter::StructTypeElementSet, i=1)
    i >= length(iter) + 1 ? nothing : (iter[i], i+1)
end

Base.length(iter::StructTypeElementSet) = API.LLVMCountStructElementTypes(ref(iter.typ))

Base.lastindex(iter::StructTypeElementSet) = length(iter)

# NOTE: optimized `collect`
function Base.collect(iter::StructTypeElementSet)
    elems = Vector{API.LLVMTypeRef}(undef, length(iter))
    API.LLVMGetStructElementTypes(ref(iter.typ), elems)
    return LLVMType[LLVMType(elem) for elem in elems]
end


## other

@checked struct VoidType <: LLVMType
    ref::reftype(LLVMType)
end
identify(::Type{LLVMType}, ::Val{API.LLVMVoidTypeKind}) = VoidType

VoidType() = VoidType(API.LLVMVoidType())
VoidType(ctx::Context) =
    VoidType(API.LLVMVoidTypeInContext(ref(ctx)))

@checked struct LabelType <: LLVMType
    ref::reftype(LLVMType)
end
identify(::Type{LLVMType}, ::Val{API.LLVMLabelTypeKind}) = LabelType

LabelType() = LabelType(API.LLVMLabelType())
LabelType(ctx::Context) =
    LabelType(API.LLVMLabelTypeInContext(ref(ctx)))

@checked struct MetadataType <: LLVMType
    ref::reftype(LLVMType)
end
identify(::Type{LLVMType}, ::Val{API.LLVMMetadataTypeKind}) = MetadataType

MetadataType(ctx::Context) =
    MetadataType(API.LLVMMetadataTypeInContext(ref(ctx)))

@checked struct TokenType <: LLVMType
    ref::reftype(LLVMType)
end
identify(::Type{LLVMType}, ::Val{API.LLVMTokenTypeKind}) = TokenType

TokenType(ctx::Context) =
    TokenType(API.LLVMTokenTypeInContext(ref(ctx)))
