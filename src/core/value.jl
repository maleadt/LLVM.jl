# The bulk of LLVM's object model consists of values, which comprise a very rich type
# hierarchy.

export Value

abstract type Value end
reftype(::Type{T}) where {T<:Value} = API.LLVMValueRef

identify(::Type{Value}, ref::API.LLVMValueRef) =
    identify(Value, Val{API.LLVMGetValueKind(ref)}())
identify(::Type{Value}, ::Val{K}) where {K} = bug("Unknown value kind $K")

@inline function check(::Type{T}, ref::API.LLVMValueRef) where T<:Value
    ref==C_NULL && throw(UndefRefError())
    @static if DEBUG
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

llvmtype(val::Value) = LLVMType(API.LLVMTypeOf(ref(val)))

name(val::Value) = unsafe_string(API.LLVMGetValueName(ref(val)))
name!(val::Value, name::String) = API.LLVMSetValueName(ref(val), name)

function Base.show(io::IO, val::Value)
    output = unsafe_string(API.LLVMPrintValueToString(ref(val)))
    print(io, output)
end

replace_uses!(old::Value, new::Value) =
    API.LLVMReplaceAllUsesWith(ref(old),
                               ref(new))

isconstant(val::Value) = convert(Core.Bool, API.LLVMIsConstant(ref(val)))

isundef(val::Value) = convert(Core.Bool, API.LLVMIsUndef(ref(val)))

context(val::Value) = Context(API.LLVMGetValueContext(ref(val)))


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

user(use::Use) =  Value(API.LLVMGetUser(     ref(use)))
value(use::Use) = Value(API.LLVMGetUsedValue(ref(use)))

# use iteration

export uses

struct ValueUseSet
    val::Value
end

uses(val::Value) = ValueUseSet(val)

Base.eltype(::ValueUseSet) = Use

Base.start(iter::ValueUseSet) = API.LLVMGetFirstUse(ref(iter.val))

Base.next(::ValueUseSet, state) =
    (Use(state), API.LLVMGetNextUse(state))

Base.done(::ValueUseSet, state) = state == C_NULL

Base.iteratorsize(::ValueUseSet) = Base.SizeUnknown()
