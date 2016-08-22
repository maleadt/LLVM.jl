export MDString, mdstring,
       MDNode, mdoperands

function MDString(val::String, ctx::Context=GlobalContext())
    return Value(API.LLVMMDStringInContext(ctx.handle, val, Cuint(length(val))))
end

function mdstring(md::Value)
    len = Ref{Cuint}()
    ptr = API.LLVMGetMDString(md.handle, len)
    ptr == C_NULL && throw(ArgumentError("invalid value, not a MDString?"))
    return unsafe_string(convert(Ptr{Int8}, ptr), len[])
end

function MDNode(vals::Vector{Value}, ctx::Context=GlobalContext())
    _vals = map(v->v.handle, vals)
    return Value(API.LLVMMDNodeInContext(ctx.handle, _vals, Cuint(length(vals))))
end

function mdoperands(md::Value)
    nops = API.LLVMGetMDNodeNumOperands(md.handle)
    ops = Vector{API.LLVMValueRef}(nops)
    API.LLVMGetMDNodeOperands(md.handle, ops)
    return map(v->Value(v), ops)
end
