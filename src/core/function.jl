export unsafe_delete!,
       personality, personality!,
       callconv, callconv!,
       gc, gc!,
       entry, function_type

# forward declaration of Function in src/core/basicblock.jl
register(Function, API.LLVMFunctionValueKind)

Function(mod::Module, name::String, ft::FunctionType) =
    Function(API.LLVMAddFunction(mod, name, ft))

function_type(Fn::Function) = FunctionType(API.LLVMGetFunctionType(Fn))

Base.empty!(f::Function) = API.LLVMFunctionDeleteBody(f)

unsafe_delete!(::Module, f::Function) = API.LLVMDeleteFunction(f)

function personality(f::Function)
    has_personality = API.LLVMHasPersonalityFn(f) |> Bool
    return has_personality ? Function(API.LLVMGetPersonalityFn(f)) : nothing
end
personality!(f::Function, persfn::Union{Nothing,Function}) =
    API.LLVMSetPersonalityFn2(f, persfn===nothing ? C_NULL : persfn)

callconv(f::Function) = API.LLVMGetFunctionCallConv(f)
callconv!(f::Function, cc) = API.LLVMSetFunctionCallConv(f, cc)

function gc(f::Function)
  ptr = API.LLVMGetGC(f)
  return ptr==C_NULL ? "" :  unsafe_string(ptr)
end
gc!(f::Function, name::String) = API.LLVMSetGC(f, name)

entry(f::Function) = BasicBlock(API.LLVMGetEntryBasicBlock(f))

# attributes

export function_attributes, parameter_attributes, return_attributes

struct FunctionAttrSet
    f::Function
    idx::API.LLVMAttributeIndex
end

function_attributes(f::Function) = FunctionAttrSet(f, reinterpret(API.LLVMAttributeIndex, API.LLVMAttributeFunctionIndex))
parameter_attributes(f::Function, idx::Integer) = FunctionAttrSet(f, API.LLVMAttributeIndex(idx))
return_attributes(f::Function) = FunctionAttrSet(f, API.LLVMAttributeReturnIndex)

Base.eltype(::FunctionAttrSet) = Attribute

function Base.collect(iter::FunctionAttrSet)
    elems = Vector{API.LLVMAttributeRef}(undef, length(iter))
    if length(iter) > 0
      # FIXME: this prevents a nullptr ref in LLVM similar to D26392
      API.LLVMGetAttributesAtIndex(iter.f, iter.idx, elems)
    end
    return Attribute[Attribute(elem) for elem in elems]
end

Base.push!(iter::FunctionAttrSet, attr::Attribute) =
    API.LLVMAddAttributeAtIndex(iter.f, iter.idx, attr)

Base.delete!(iter::FunctionAttrSet, attr::EnumAttribute) =
    API.LLVMRemoveEnumAttributeAtIndex(iter.f, iter.idx, kind(attr))

Base.delete!(iter::FunctionAttrSet, attr::TypeAttribute) =
    API.LLVMRemoveEnumAttributeAtIndex(iter.f, iter.idx, kind(attr))

function Base.delete!(iter::FunctionAttrSet, attr::StringAttribute)
    k = kind(attr)
    API.LLVMRemoveStringAttributeAtIndex(iter.f, iter.idx, k, length(k))
end

function Base.length(iter::FunctionAttrSet)
    API.LLVMGetAttributeCountAtIndex(iter.f, iter.idx)
end

# parameter iteration

export Argument, parameters

@checked struct Argument <: Value
    ref::API.LLVMValueRef
end
register(Argument, API.LLVMArgumentValueKind)

struct FunctionParameterSet <: AbstractVector{Argument}
    f::Function
end

parameters(f::Function) = FunctionParameterSet(f)

Base.size(iter::FunctionParameterSet) = (API.LLVMCountParams(iter.f),)

Base.IndexStyle(::FunctionParameterSet) = IndexLinear()

function Base.getindex(iter::FunctionParameterSet, i::Int)
    @boundscheck 1 <= i <= length(iter) || throw(BoundsError(iter, i))
    return Argument(API.LLVMGetParam(iter.f, i-1))
end

function Base.iterate(iter::FunctionParameterSet, state=API.LLVMGetFirstParam(iter.f))
    state == C_NULL ? nothing : (Argument(state), API.LLVMGetNextParam(state))
end

Base.last(iter::FunctionParameterSet) = Argument(API.LLVMGetLastParam(iter.f))

# NOTE: optimized `collect`
function Base.collect(iter::FunctionParameterSet)
    elems = Vector{API.LLVMValueRef}(undef, length(iter))
    API.LLVMGetParams(iter.f, elems)
    return map(el->Argument(el), elems)
end

# basic block iteration

export blocks

struct FunctionBlockSet <: AbstractVector{BasicBlock}
    f::Function
    cache::Vector{API.LLVMValueRef}

    FunctionBlockSet(f::Function) = new(f, API.LLVMValueRef[])
end

blocks(f::Function) = FunctionBlockSet(f)

Base.size(iter::FunctionBlockSet) = (Int(API.LLVMCountBasicBlocks(iter.f)),)

function Base.first(iter::FunctionBlockSet)
    ref = API.LLVMGetFirstBasicBlock(iter.f)
    ref == C_NULL && throw(BoundsError(iter))
    BasicBlock(ref)
end
function Base.last(iter::FunctionBlockSet)
    ref = API.LLVMGetLastBasicBlock(iter.f)
    ref == C_NULL && throw(BoundsError(iter))
    BasicBlock(ref)
end

function Base.iterate(iter::FunctionBlockSet, state=API.LLVMGetFirstBasicBlock(iter.f))
    state == C_NULL ? nothing : (BasicBlock(state), API.LLVMGetNextBasicBlock(state))
end

# provide a random access interface by maintaining a cache of blocks
function Base.getindex(iter::FunctionBlockSet, i::Int)
    i <= 0 && throw(BoundsError(iter, i))
    i == 1 && return first(iter)
    while i > length(iter.cache)
        next = if isempty(iter.cache)
            iterate(iter)
        else
            iterate(iter, iter.cache[end])
        end
        next === nothing && throw(BoundsError(iter, i))
        push!(iter.cache, next[2])
    end
    return BasicBlock(iter.cache[i-1])
end

# NOTE: optimized `collect`
function Base.collect(iter::FunctionBlockSet)
    elems = Vector{API.LLVMBasicBlockRef}(undef, length(iter))
    API.LLVMGetBasicBlocks(iter.f, elems)
    return BasicBlock[BasicBlock(elem) for elem in elems]
end

# intrinsics

export isintrinsic, Intrinsic, isoverloaded

isintrinsic(f::Function) = API.LLVMGetIntrinsicID(f) != 0

struct Intrinsic
    id::UInt32

    function Intrinsic(f::Function)
        id = API.LLVMGetIntrinsicID(f)
        id == 0 && throw(ArgumentError("Function is not an intrinsic"))
        new(id)
    end

    function Intrinsic(name::String)
        new(API.LLVMLookupIntrinsicID(name, length(name)))
    end
end

Base.convert(::Type{UInt32}, intr::Intrinsic) = intr.id

function name(intr::Intrinsic)
    len = Ref{Csize_t}()
    str = API.LLVMIntrinsicGetName(intr, len)
    unsafe_string(convert(Ptr{Cchar}, str), len[])
end

function name(intr::Intrinsic, params::Vector{<:LLVMType})
    len = Ref{Csize_t}()
    str = API.LLVMIntrinsicCopyOverloadedName(intr, params, length(params), len)
    unsafe_message(convert(Ptr{Cchar}, str), len[])
end

function isoverloaded(intr::Intrinsic)
    API.LLVMIntrinsicIsOverloaded(intr) |> Bool
end

function Function(mod::Module, intr::Intrinsic, params::Vector{<:LLVMType}=LLVMType[])
    Value(API.LLVMGetIntrinsicDeclaration(mod, intr, params, length(params)))
end

function FunctionType(intr::Intrinsic, params::Vector{<:LLVMType}=LLVMType[])
    LLVMType(API.LLVMIntrinsicGetType(context(), intr, params, length(params)))
end

function Base.show(io::IO, intr::Intrinsic)
    print(io, "Intrinsic($(intr.id))")
    if isoverloaded(intr)
        print(io, ": overloaded intrinsic")
    else
        print(io, ": \"$(name(intr))\"")
    end
end
