import Base: convert

export MDString, MDNode, operands

@reftypedef proxy=Value kind=LLVMMetadataAsValueValueKind immutable MetadataAsValue <: Value end

# NOTE: the C API doesn't allow us to differentiate between MD kinds,
#       all are wrapped by the opaque MetadataAsValue...

typealias MDString MetadataAsValue

MDString(val::String) = MDString(API.LLVMMDString(val, Cuint(length(val))))

MDString(val::String, ctx::Context) = 
    MDString(API.LLVMMDStringInContext(ref(ctx), val, Cuint(length(val))))

function convert(::Type{String}, md::MDString)
    len = Ref{Cuint}()
    ptr = API.LLVMGetMDString(ref(md), len)
    ptr == C_NULL && throw(ArgumentError("invalid metadata, not a MDString?"))
    return unsafe_string(convert(Ptr{Int8}, ptr), len[])
end


typealias MDNode MetadataAsValue

MDNode{T<:Value}(vals::Vector{T}) =
    MDNode(API.LLVMMDNode(ref.(vals), Cuint(length(vals))))

MDNode{T<:Value}(vals::Vector{T}, ctx::Context) =
    MDNode(API.LLVMMDNodeInContext(ref(ctx), ref.(vals),
                                   Cuint(length(vals))))

function operands(md::MDNode)
    nops = API.LLVMGetMDNodeNumOperands(ref(md))
    ops = Vector{API.LLVMValueRef}(nops)
    API.LLVMGetMDNodeOperands(ref(md), ops)
    return map(v->dynamic_construct(Value, v), ops)
end
