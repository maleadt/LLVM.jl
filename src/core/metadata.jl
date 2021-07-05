export Metadata

# subtypes are expected to have a 'ref::API.LLVMMetadataRef' field
abstract type Metadata end

Base.unsafe_convert(::Type{API.LLVMMetadataRef}, md::Metadata) = md.ref

identify(::Type{Metadata}, ref::API.LLVMMetadataRef) =
    identify(Metadata, Val{API.LLVMGetMetadataKind(ref)}())
identify(::Type{Metadata}, ::Val{K}) where {K} = error("Unknown metadata kind $K")

@inline function refcheck(::Type{T}, ref::API.LLVMMetadataRef) where T<:Metadata
    ref==C_NULL && throw(UndefRefError())
    T′ = identify(Metadata, ref)
    if T != T′
        error("invalid conversion of $T′ metadata reference to $T")
    end
end

# Construct a concretely typed metadata object from an abstract metadata ref
function Metadata(ref::API.LLVMMetadataRef)
    ref == C_NULL && throw(UndefRefError())
    T = identify(Metadata, ref)
    return T(ref)
end


## metadata as value

# this is for interfacing with (older) APIs that accept a Value*, not a Metadata*

@checked struct MetadataAsValue <: Value
    ref::API.LLVMValueRef
end
identify(::Type{Value}, ::Val{API.LLVMMetadataAsValueValueKind}) = MetadataAsValue

# NOTE: we can't do this automatically, as we can't query the context of metadata...
Value(md::Metadata, ctx::Context=GlobalContext()) =
    MetadataAsValue(API.LLVMMetadataAsValue(ctx, md))


## value as metadata

abstract type ValueAsMetadata <: Metadata end

@checked struct ConstantAsMetadata <: ValueAsMetadata
    ref::API.LLVMMetadataRef
end
identify(::Type{Metadata}, ::Val{API.LLVMConstantAsMetadataMetadataKind}) = ConstantAsMetadata

@checked struct LocalAsMetadata <: ValueAsMetadata
    ref::API.LLVMMetadataRef
end
identify(::Type{Metadata}, ::Val{API.LLVMLocalAsMetadataMetadataKind}) = LocalAsMetadata

# NOTE: this can be used to both pack e.g. constants as metadata, and to extract the
#       metadata from an MetadataAsValue, so we don't type-assert narrowly here
Metadata(val::Value) = Metadata(API.LLVMValueAsMetadata(val))


## values

export MDString

@checked struct MDString <: Metadata
    ref::API.LLVMMetadataRef
end
identify(::Type{Metadata}, ::Val{API.LLVMMDStringMetadataKind}) = MDString

MDString(val::String, ctx::Context=GlobalContext()) =
    MDString(API.LLVMMDStringInContext2(ctx, val, length(val)))

function Base.string(md::MDString)
    len = Ref{Cuint}()
    ptr = API.LLVMGetMDString(Value(md), len)
    ptr == C_NULL && throw(ArgumentError("invalid metadata, not a MDString?"))
    return unsafe_string(convert(Ptr{Int8}, ptr), len[])
end


## nodes

export MDNode, operands

abstract type MDNode <: Metadata end

function operands(md::MDNode)
    nops = API.LLVMGetMDNodeNumOperands(Value(md))
    ops = Vector{API.LLVMValueRef}(undef, nops)
    API.LLVMGetMDNodeOperands(Value(md), ops)
    return Metadata[Metadata(Value(op)) for op in ops]
end


## tuples

export MDTuple

@checked struct MDTuple <: MDNode
    ref::API.LLVMMetadataRef
end
identify(::Type{Metadata}, ::Val{API.LLVMMDTupleMetadataKind}) = MDTuple

# MDTuples are commonly referred to as MDNodes, so keep that name
MDNode(mds::Vector{<:Metadata}, ctx::Context=GlobalContext()) =
    MDTuple(API.LLVMMDNodeInContext2(ctx, mds, length(mds)))
