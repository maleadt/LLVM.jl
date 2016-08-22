import Base: convert

export MDString, MDNode, operands

@llvmtype immutable MetadataAsValue <: Value end

# NOTE: the C API doesn't allow us to differentiate between MD kinds,
#       all are wrapped by the opaque MetadataAsValue...

typealias MDString MetadataAsValue

function MDString(val::String, ctx::Context=GlobalContext())
    return MDString(API.LLVMMDStringInContext(convert(API.LLVMContextRef, ctx), val, Cuint(length(val))))
end

function convert(::Type{String}, md::MDString)
    len = Ref{Cuint}()
    ptr = API.LLVMGetMDString(convert(API.LLVMValueRef, md), len)
    ptr == C_NULL && throw(ArgumentError("invalid metadata, not a MDString?"))
    return unsafe_string(convert(Ptr{Int8}, ptr), len[])
end


typealias MDNode MetadataAsValue

function MDNode{T<:Value}(vals::Vector{T}, ctx::Context=GlobalContext())
    _vals = map(v->convert(API.LLVMValueRef, v), vals)
    return MDNode(API.LLVMMDNodeInContext(convert(API.LLVMContextRef, ctx), _vals, Cuint(length(vals))))
end

function operands(md::MDNode)
    nops = API.LLVMGetMDNodeNumOperands(convert(API.LLVMValueRef, md))
    ops = Vector{API.LLVMValueRef}(nops)
    API.LLVMGetMDNodeOperands(convert(API.LLVMValueRef, md), ops)
    return map(v->dynamic_convert(Value, v), ops)
end
