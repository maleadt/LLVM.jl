export Metadata

# subtypes are expected to have a 'ref::API.LLVMMetadataRef' field
abstract type Metadata end

Base.unsafe_convert(::Type{API.LLVMMetadataRef}, md::Metadata) = md.ref

const metadata_kinds = Dict{API.LLVMMetadataKind, Type{<:Metadata}}()
function identify(::Type{Metadata}, ref::API.LLVMMetadataRef)
    kind = API.LLVMGetMetadataKind(ref)
    haskey(metadata_kinds, kind) || error("Unknown metadata kind $kind")
    return metadata_kinds[kind]
end

@inline function refcheck(::Type{T}, ref::API.LLVMMetadataRef) where T<:Metadata
    ref==C_NULL && throw(UndefRefError())
    @static if Base.JLOptions().debug_level >= 2
        T′ = identify(Metadata, ref)
        if T != T′
            error("invalid conversion of $T′ metadata reference to $T")
        end
    end
end

# Construct a concretely typed metadata object from an abstract metadata ref
function Metadata(ref::API.LLVMMetadataRef)
    ref == C_NULL && throw(UndefRefError())
    T = identify(Metadata, ref)
    return T(ref)
end

function Base.show(io::IO, md::Metadata)
    output = unsafe_message(API.LLVMExtraPrintMetadataToString(md))
    print(io, output)
end


## metadata as value

# this is for interfacing with (older) APIs that accept a Value*, not a Metadata*

@checked struct MetadataAsValue <: Value
    ref::API.LLVMValueRef
end
value_kinds[API.LLVMMetadataAsValueValueKind] = MetadataAsValue

Value(md::Metadata; ctx::Context) = MetadataAsValue(API.LLVMMetadataAsValue(ctx, md))

# NOTE: we can't do this automatically, as we can't query the context of metadata...
#       add wrappers to do so? would also simplify, e.g., `string(::MDString)`


## value as metadata

abstract type ValueAsMetadata <: Metadata end

@checked struct ConstantAsMetadata <: ValueAsMetadata
    ref::API.LLVMMetadataRef
end
metadata_kinds[API.LLVMConstantAsMetadataMetadataKind] = ConstantAsMetadata

@checked struct LocalAsMetadata <: ValueAsMetadata
    ref::API.LLVMMetadataRef
end
metadata_kinds[API.LLVMLocalAsMetadataMetadataKind] = LocalAsMetadata

# NOTE: this can be used to both pack e.g. constants as metadata, and to extract the
#       metadata from an MetadataAsValue, so we don't type-assert narrowly here
Metadata(val::Value) = Metadata(API.LLVMValueAsMetadata(val))

Base.convert(::Type{Metadata}, val::Value) = Metadata(val)


## values

export MDString

@checked struct MDString <: Metadata
    ref::API.LLVMMetadataRef
end
metadata_kinds[API.LLVMMDStringMetadataKind] = MDString

MDString(val::String; ctx::Context) =
    MDString(API.LLVMMDStringInContext2(ctx, val, length(val)))

function Base.string(md::MDString)
    len = Ref{Cuint}()
    ptr = API.LLVMExtraGetMDString2(md, len)
    return unsafe_string(convert(Ptr{Int8}, ptr), len[])
end


## nodes

export MDNode, operands

abstract type MDNode <: Metadata end

function operands(md::MDNode)
    nops = API.LLVMExtraGetMDNodeNumOperands2(md)
    ops = Vector{API.LLVMMetadataRef}(undef, nops)
    API.LLVMExtraGetMDNodeOperands2(md, ops)
    return [Metadata(op) for op in ops]
end


## tuples

export MDTuple

@checked struct MDTuple <: MDNode
    ref::API.LLVMMetadataRef
end
metadata_kinds[API.LLVMMDTupleMetadataKind] = MDTuple

# MDTuples are commonly referred to as MDNodes, so keep that name
MDNode(mds::Vector{<:Metadata}; ctx::Context) =
    MDTuple(API.LLVMMDNodeInContext2(ctx, mds, length(mds)))
MDNode(vals::Vector; ctx::Context) =
    MDNode(convert(Vector{Metadata}, vals); ctx)
