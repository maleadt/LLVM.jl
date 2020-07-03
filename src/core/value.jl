# The bulk of LLVM's object model consists of values, which comprise a very rich type
# hierarchy.

export Value

# subtypes are expected to have a 'ref::API.LLVMValueRef' field
abstract type Value end
reftype(::Type{T}) where {T<:Value} = API.LLVMValueRef

Base.unsafe_convert(::Type{API.LLVMValueRef}, val::Value) = val.ref

identify(::Type{Value}, ref::API.LLVMValueRef) =
    identify(Value, Val{API.LLVMGetValueKind(ref)}())
identify(::Type{Value}, ::Val{K}) where {K} = error("Unknown value kind $K")

@inline function check(::Type{T}, ref::API.LLVMValueRef) where T<:Value
    ref==C_NULL && throw(UndefRefError())
    if Base.JLOptions().debug_level >= 2
        T′ = identify(Value, ref)
        if T != T′
            error("invalid conversion of $T′ value reference to $T")
        end
    end
end

# Construct a concretely typed value object from an abstract value ref
function Value(ref::API.LLVMValueRef)
    ref == C_NULL && throw(UndefRefError())
    T = identify(Value, ref)
    return T(ref)
end



## general APIs

export llvmtype, name, name!, replace_uses!, isconstant, isundef, context

llvmtype(val::Value) = LLVMType(API.LLVMTypeOf(val))

name(val::Value) = unsafe_string(API.LLVMGetValueName(val))
name!(val::Value, name::String) = API.LLVMSetValueName(val, name)

function Base.show(io::IO, val::Value)
    output = unsafe_message(API.LLVMPrintValueToString(val))
    print(io, output)
end

replace_uses!(old::Value, new::Value) = API.LLVMReplaceAllUsesWith(old, new)

isconstant(val::Value) = convert(Core.Bool, API.LLVMIsConstant(val))

isundef(val::Value) = convert(Core.Bool, API.LLVMIsUndef(val))

context(val::Value) = Context(API.LLVMGetValueContext(val))


## user values

include("value/user.jl")


## constants

include("value/constant.jl")


## usage

export Use, user, value

@checked struct Use
    ref::API.LLVMUseRef
end
reftype(::Type{Use}) = API.LLVMUseRef

Base.unsafe_convert(::Type{API.LLVMUseRef}, use::Use) = use.ref

user(use::Use) =  Value(API.LLVMGetUser(     use))
value(use::Use) = Value(API.LLVMGetUsedValue(use))

# use iteration

export uses

struct ValueUseSet
    val::Value
end

uses(val::Value) = ValueUseSet(val)

Base.eltype(::ValueUseSet) = Use

function Base.iterate(iter::ValueUseSet, state=API.LLVMGetFirstUse(iter.val))
    state == C_NULL ? nothing : (Use(state), API.LLVMGetNextUse(state))
end

Base.IteratorSize(::ValueUseSet) = Base.SizeUnknown()
