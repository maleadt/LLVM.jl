export MDString, MDNode, operands, Metadata

@checked struct MetadataAsValue <: Value
    ref::reftype(Value)
end
identify(::Type{Value}, ::Val{API.LLVMMetadataAsValueValueKind}) = MetadataAsValue

# NOTE: the C API doesn't allow us to differentiate between MD kinds,
#       all are wrapped by the opaque MetadataAsValue...

const MDString = MetadataAsValue

MDString(val::String) = MDString(API.LLVMMDString(val, Cuint(length(val))))

MDString(val::String, ctx::Context) =
    MDString(API.LLVMMDStringInContext(ref(ctx), val, Cuint(length(val))))

function Base.convert(::Type{String}, md::MDString)
    len = Ref{Cuint}()
    ptr = API.LLVMGetMDString(ref(md), len)
    ptr == C_NULL && throw(ArgumentError("invalid metadata, not a MDString?"))
    return unsafe_string(convert(Ptr{Int8}, ptr), len[])
end


const MDNode = MetadataAsValue

MDNode(vals::Vector{T}) where {T<:Value} =
    MDNode(API.LLVMMDNode(ref.(vals), Cuint(length(vals))))

MDNode(vals::Vector{T}, ctx::Context) where {T<:Value} =
    MDNode(API.LLVMMDNodeInContext(ref(ctx), ref.(vals),
                                   Cuint(length(vals))))

function operands(md::MDNode)
    nops = API.LLVMGetMDNodeNumOperands(ref(md))
    ops = Vector{API.LLVMValueRef}(undef, nops)
    API.LLVMGetMDNodeOperands(ref(md), ops)
    return Value[Value(op) for op in ops]
end


@checked struct Metadata
    ref::API.LLVMMetadataRef
end
reftype(::Type{Metadata}) = API.LLVMMetadataRef

function Metadata(val::Value)
    return Metadata(LLVM.API.LLVMValueAsMetadata(ref(val)))
end

function Value(md::Metadata, ctx::Context)
    return MetadataAsValue(API.LLVMMetadataAsValue(ref(ctx), ref(md)))
end
