# Attributes that can be associated with parameters, function results, or the function
# itself.

export Attribute,
       EnumAttribute, StringAttribute,
       kind, value

abstract type Attribute end
reftype(::Type{T}) where {T<:Attribute} = API.LLVMAttributeRef

@checked struct EnumAttribute <: Attribute
    ref::reftype(Attribute)
end

@checked struct StringAttribute <: Attribute
    ref::reftype(Attribute)
end

# TODO: make @reftype's identify mechanism flexible enough to cover cases like this one,
#       and not only Value and Type

function Attribute(ref::API.LLVMAttributeRef)
    ref == C_NULL && throw(NullException())
    if convert(Core.Bool, API.LLVMIsEnumAttribute(ref))
        return EnumAttribute(ref)
    elseif convert(Core.Bool, API.LLVMIsStringAttribute(ref))
        return StringAttribute(ref)
    else
        error("unknown attribute kind")
    end
end

function Base.show(io::IO, attr::T) where T<:Attribute
    print(io, "$T $(kind(attr))=$(value(attr))")
end


## enum attribute

# NOTE: the AttrKind enum is not exported in the C API,
#       so we don't expose a way to construct EnumAttribute from its raw enum value
#       (which also would conflict with the inner ref constructor)
function EnumAttribute(kind::String, value::Integer=0, ctx::Context=GlobalContext())
    enum_kind = API.LLVMGetEnumAttributeKindForName(kind, Csize_t(length(kind)))
    return EnumAttribute(API.LLVMCreateEnumAttribute(ref(ctx), enum_kind, UInt64(value)))
end

kind(attr::EnumAttribute) = API.LLVMGetEnumAttributeKind(ref(attr))

value(attr::EnumAttribute) = API.LLVMGetEnumAttributeValue(ref(attr))


## string attribute

StringAttribute(kind::String, value::String="", ctx::Context=GlobalContext()) =
    StringAttribute(API.LLVMCreateStringAttribute(ref(ctx), kind, Cuint(length(kind)),
                                                  value, Cuint(length(value))))

function kind(attr::StringAttribute)
    len = Ref{Cuint}()
    data = API.LLVMGetStringAttributeKind(ref(attr), len)
    return unsafe_string(convert(Ptr{Int8}, data), len[])
end

function value(attr::StringAttribute)
    len = Ref{Cuint}()
    data = API.LLVMGetStringAttributeValue(ref(attr), len)
    return unsafe_string(convert(Ptr{Int8}, data), len[])
end
