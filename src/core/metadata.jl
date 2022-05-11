export Metadata

# subtypes are expected to have a 'ref::API.LLVMMetadataRef' field
abstract type Metadata end

Base.unsafe_convert(::Type{API.LLVMMetadataRef}, md::Metadata) = md.ref

const metadata_kinds = Vector{Type}(fill(Nothing, typemax(API.LLVMMetadataKind)+1))
function identify(::Type{Metadata}, ref::API.LLVMMetadataRef)
    kind = API.LLVMGetMetadataKind(ref)
    typ = @inbounds metadata_kinds[kind+1]
    typ === Nothing && error("Unknown metadata kind $kind")
    return typ
end
function register(T::Type{<:Metadata}, kind::API.LLVMMetadataKind)
    metadata_kinds[kind+1] = T
end

function refcheck(::Type{T}, ref::API.LLVMMetadataRef) where T<:Metadata
    ref==C_NULL && throw(UndefRefError())
    if Base.JLOptions().debug_level >= 2
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
register(MetadataAsValue, API.LLVMMetadataAsValueValueKind)

# NOTE: this can be used to both pack e.g. metadata as a value, and to extract the
#       value from an ValueAsMetadata, so we don't type-assert narrowly here
Value(md::Metadata; ctx::Context) = Value(API.LLVMMetadataAsValue2(ctx, md))

Base.convert(T::Type{<:Value}, val::Metadata) = Value(val)::T

# NOTE: we can't do this automatically, as we can't query the context of metadata...
#       add wrappers to do so? would also simplify, e.g., `string(::MDString)`


## value as metadata

abstract type ValueAsMetadata <: Metadata end

@checked struct ConstantAsMetadata <: ValueAsMetadata
    ref::API.LLVMMetadataRef
end
register(ConstantAsMetadata, API.LLVMConstantAsMetadataMetadataKind)

@checked struct LocalAsMetadata <: ValueAsMetadata
    ref::API.LLVMMetadataRef
end
register(LocalAsMetadata, API.LLVMLocalAsMetadataMetadataKind)

# NOTE: this can be used to both pack e.g. constants as metadata, and to extract the
#       metadata from an MetadataAsValue, so we don't type-assert narrowly here
Metadata(val::Value) = Metadata(API.LLVMValueAsMetadata(val))

Base.convert(T::Type{<:Metadata}, val::Value) = Metadata(val)::T


## values

export MDString

@checked struct MDString <: Metadata
    ref::API.LLVMMetadataRef
end
register(MDString, API.LLVMMDStringMetadataKind)

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

# TODO: setindex?
function replace_operand(md::MDNode, i, new::Metadata)
    API.LLVMReplaceMDNodeOperandWith(md, i-1, new)
end


## tuples

export MDTuple

@checked struct MDTuple <: MDNode
    ref::API.LLVMMetadataRef
end
register(MDTuple, API.LLVMMDTupleMetadataKind)

# MDTuples are commonly referred to as MDNodes, so keep that name
MDNode(mds::Vector{<:Metadata}; ctx::Context) =
    MDTuple(API.LLVMMDNodeInContext2(ctx, mds, length(mds)))
MDNode(vals::Vector; ctx::Context) =
    MDNode(convert(Vector{Metadata}, vals); ctx)
