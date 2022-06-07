# The bulk of LLVM's object model consists of values, which comprise a very rich type
# hierarchy.

export Value

# subtypes are expected to have a 'ref::API.LLVMValueRef' field
abstract type Value end

Base.unsafe_convert(::Type{API.LLVMValueRef}, val::Value) = val.ref

const value_kinds = Vector{Type}(fill(Nothing, typemax(API.LLVMValueKind)+1))
function identify(::Type{Value}, ref::API.LLVMValueRef)
    kind = API.LLVMGetValueKind(ref)
    typ = @inbounds value_kinds[kind+1]
    typ === Nothing && error("Unknown value kind $kind")
    return typ
end
function register(T::Type{<:Value}, kind::API.LLVMValueKind)
    value_kinds[kind+1] = T
end

function refcheck(::Type{T}, ref::API.LLVMValueRef) where T<:Value
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

export llvmtype, llvmeltype, name, name!, replace_uses!, replace_metadata_uses!, isconstant, isundef, ispoison, context

llvmtype(val::Value) = LLVMType(API.LLVMTypeOf(val))
llvmeltype(val::Value) = eltype(llvmtype(val))

# defer size queries to the LLVM type (where we'll error)
Base.sizeof(val::Value) = sizeof(llvmtype(val))

name(val::Value) = unsafe_string(API.LLVMGetValueName(val))
name!(val::Value, name::String) = API.LLVMSetValueName(val, name)

function Base.show(io::IO, val::Value)
    output = unsafe_message(API.LLVMPrintValueToString(val))
    print(io, output)
end

replace_uses!(old::Value, new::Value) = API.LLVMReplaceAllUsesWith(old, new)

function replace_metadata_uses!(old::Value, new::Value)
    if llvmtype(old) == llvmtype(new)
        API.LLVMReplaceAllMetadataUsesWith(old, new)
    else
        # NOTE: LLVM does not support replacing values of different types, either using
        #       regular RAUW or only on metadata. The latter should probably be supported.
        #       Instead, we replace by a bitcast to the old type.
        compat_new = const_bitcast(new, llvmtype(old))
        replace_metadata_uses!(old, compat_new)

        # the above is often invalid, e.g. for module-level metadata identifying functions.
        # so we peek into such metadata and try to get rid of the bitcast. see also
        # https://discourse.llvm.org/t/replacing-module-metadata-uses-of-function/62431/4
        mod = LLVM.parent(new)
        while !isa(mod, LLVM.Module)
            mod = LLVM.parent(new)
        end
        ctx = context(mod)
        function recurse(md)
            for (i, op) in enumerate(operands(md))
                if op isa ValueAsMetadata && Value(op; ctx) == compat_new
                    LLVM.replace_operand(md, i, Metadata(new))
                elseif isa(op, MDTuple)
                    recurse(op)
                end
            end
        end
        for (key, md) in metadata(mod)
            recurse(md)
        end
    end
end

isconstant(val::Value) = convert(Core.Bool, API.LLVMIsConstant(val))

isundef(val::Value) = convert(Core.Bool, API.LLVMIsUndef(val))

ispoison(val::Value) = convert(Core.Bool, API.LLVMIsPoison(val))

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
