export unsafe_delete!,
       personality, personality!,
       callconv, callconv!,
       gc, gc!,
       entry

# forward declaration of Function in src/core/basicblock.jl
identify(::Type{Value}, ::Val{API.LLVMFunctionValueKind}) = Function

Function(mod::Module, name::String, ft::FunctionType) =
    Function(API.LLVMAddFunction(mod, name, ft))

unsafe_delete!(::Module, f::Function) = API.LLVMDeleteFunction(f)

function personality(f::Function)
    has_personality = convert(Core.Bool, API.LLVMHasPersonalityFn(f))
    return has_personality ? Function(API.LLVMGetPersonalityFn(f)) : nothing
end
personality!(f::Function, persfn::Union{Nothing,Function}) =
    API.LLVMSetPersonalityFn(f, persfn===nothing ? C_NULL : persfn)

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
identify(::Type{Value}, ::Val{API.LLVMArgumentValueKind}) = Argument

struct FunctionParameterSet
    f::Function
end

parameters(f::Function) = FunctionParameterSet(f)

Base.eltype(::FunctionParameterSet) = Argument

function Base.getindex(iter::FunctionParameterSet, i)
    @boundscheck 1 <= i <= length(iter) || throw(BoundsError(iter, i))
    return Argument(API.LLVMGetParam(iter.f, i-1))
end

function Base.iterate(iter::FunctionParameterSet, state=API.LLVMGetFirstParam(iter.f))
    state == C_NULL ? nothing : (Argument(state), API.LLVMGetNextParam(state))
end

Base.last(iter::FunctionParameterSet) =
    Argument(API.LLVMGetLastParam(iter.f))

Base.isempty(iter::FunctionParameterSet) =
    API.LLVMGetLastParam(iter.f) == C_NULL

Base.length(iter::FunctionParameterSet) = API.LLVMCountParams(iter.f)

# NOTE: optimized `collect`
function Base.collect(iter::FunctionParameterSet)
    elems = Vector{API.LLVMValueRef}(undef, length(iter))
    API.LLVMGetParams(iter.f, elems)
    return map(el->Argument(el), elems)
end

# basic block iteration

export blocks

struct FunctionBlockSet
    f::Function
end

blocks(f::Function) = FunctionBlockSet(f)

Base.eltype(::FunctionBlockSet) = BasicBlock

function Base.iterate(iter::FunctionBlockSet, state=API.LLVMGetFirstBasicBlock(iter.f))
    state == C_NULL ? nothing : (BasicBlock(state), API.LLVMGetNextBasicBlock(state))
end

Base.last(iter::FunctionBlockSet) =
    BasicBlock(API.LLVMGetLastBasicBlock(iter.f))

Base.isempty(iter::FunctionBlockSet) =
    API.LLVMGetLastBasicBlock(iter.f) == C_NULL

Base.length(iter::FunctionBlockSet) = API.LLVMCountBasicBlocks(iter.f)

# NOTE: optimized `collect`
function Base.collect(iter::FunctionBlockSet)
    elems = Vector{API.LLVMValueRef}(undef, length(iter))
    API.LLVMGetBasicBlocks(iter.f, elems)
    return BasicBlock[BasicBlock(elem) for elem in elems]
end

# intrinsics

export isintrinsic, Intrinsic, isoverloaded, declaration

isintrinsic(f::Function) = API.LLVMGetIntrinsicID(f) != 0

struct Intrinsic
    id::UInt32

    function Intrinsic(f::Function)
        id = API.LLVMGetIntrinsicID(f)
        id == 0 && throw(ArgumentError("Function is not an intrinsic"))
        new(id)
    end

    function Intrinsic(name::String)
        @assert version() >= v"9"
        new(API.LLVMLookupIntrinsicID(name, length(name)))
    end
end

Base.convert(::Type{UInt32}, intr::Intrinsic) = intr.id

function name(intr::Intrinsic)
    @assert version() >= v"8"
    len = Ref{Csize_t}()
    str = API.LLVMIntrinsicGetName(intr, len)
    unsafe_string(convert(Ptr{Cchar}, str), len[])
end

function name(intr::Intrinsic, params::Vector{<:LLVMType})
    @assert version() >= v"8"
    len = Ref{Csize_t}()
    str = API.LLVMIntrinsicCopyOverloadedName(intr, params, length(params), len)
    unsafe_message(convert(Ptr{Cchar}, str), len[])
end

function isoverloaded(intr::Intrinsic)
    @assert version() >= v"8"
    convert(Core.Bool, API.LLVMIntrinsicIsOverloaded(intr))
end

function Function(mod::Module, intr::Intrinsic, params::Vector{<:LLVMType}=LLVMType[])
    @assert version() >= v"8"
    Value(API.LLVMGetIntrinsicDeclaration(mod, intr, params, length(params)))
end

function FunctionType(intr::Intrinsic, params::Vector{<:LLVMType}=LLVMType[];
                  ctx::Context=GlobalContext())
    @assert version() >= v"8"
    LLVMType(API.LLVMIntrinsicGetType(ctx, intr, params, length(params)))
end

function Base.show(io::IO, intr::Intrinsic)
    print(io, "Intrinsic($(intr.id))")
    if version() >= v"8"
        if isoverloaded(intr)
            print(io, ": overloaded intrinsic")
        else
            print(io, ": \"$(name(intr))\"")
        end
    end
end
