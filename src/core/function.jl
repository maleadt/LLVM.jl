export unsafe_delete!,
       personality, personality!,
       callconv, callconv!,
       gc, gc!, intrinsic_id,
       entry

# forward declaration of Function in src/core/basicblock.jl
identify(::Type{Value}, ::Val{API.LLVMFunctionValueKind}) = Function

Function(mod::Module, name::String, ft::FunctionType) =
    Function(API.LLVMAddFunction(ref(mod), name, ref(ft)))

unsafe_delete!(::Module, f::Function) = API.LLVMDeleteFunction(ref(f))

personality(f::Function) = Function(API.LLVMGetPersonalityFn(ref(f)))
personality!(f::Function, persfn::Function) = API.LLVMSetPersonalityFn(ref(f), ref(persfn))

intrinsic_id(f::Function) = API.LLVMGetIntrinsicID(ref(f))

callconv(f::Function) = API.LLVMGetFunctionCallConv(ref(f))
callconv!(f::Function, cc) = API.LLVMSetFunctionCallConv(ref(f), cc)

function gc(f::Function)
  ptr = API.LLVMGetGC(ref(f))
  return ptr==C_NULL ? "" :  unsafe_string(ptr)
end
gc!(f::Function, name::String) = API.LLVMSetGC(ref(f), name)

entry(f::Function) = BasicBlock(API.LLVMGetEntryBasicBlock(ref(f)))

# attributes

export function_attributes, parameter_attributes, return_attributes

struct FunctionAttrSet
    f::Function
    idx::API.LLVMAttributeIndex
end

function_attributes(f::Function) = FunctionAttrSet(f, API.LLVMAttributeFunctionIndex)
parameter_attributes(f::Function, idx::Integer) = FunctionAttrSet(f, API.LLVMAttributeIndex(idx))
return_attributes(f::Function) = FunctionAttrSet(f, API.LLVMAttributeReturnIndex)

Base.eltype(::FunctionAttrSet) = Attribute

function Base.collect(iter::FunctionAttrSet)
    elems = Vector{API.LLVMAttributeRef}(undef, length(iter))
    if length(iter) > 0
      # FIXME: this prevents a nullptr ref in LLVM similar to D26392
      API.LLVMGetAttributesAtIndex(ref(iter.f), iter.idx, elems)
    end
    return Attribute[Attribute(elem) for elem in elems]
end

Base.push!(iter::FunctionAttrSet, attr::Attribute) =
    API.LLVMAddAttributeAtIndex(ref(iter.f), iter.idx, ref(attr))

Base.delete!(iter::FunctionAttrSet, attr::EnumAttribute) =
    API.LLVMRemoveEnumAttributeAtIndex(ref(iter.f), iter.idx, kind(attr))

function Base.delete!(iter::FunctionAttrSet, attr::StringAttribute)
    k = kind(attr)
    API.LLVMRemoveStringAttributeAtIndex(ref(iter.f), iter.idx, k, length(k))
end

function Base.length(iter::FunctionAttrSet)
    API.LLVMGetAttributeCountAtIndex(ref(iter.f), iter.idx)
end

# parameter iteration

export Argument, parameters

@checked struct Argument <: Value
    ref::reftype(Value)
end
identify(::Type{Value}, ::Val{API.LLVMArgumentValueKind}) = Argument

struct FunctionParameterSet
    f::Function
end

parameters(f::Function) = FunctionParameterSet(f)

Base.eltype(::FunctionParameterSet) = Argument

Base.getindex(iter::FunctionParameterSet, i) =
  Argument(API.LLVMGetParam(ref(iter.f), i-1))

function Base.iterate(iter::FunctionParameterSet, state=API.LLVMGetFirstParam(ref(iter.f)))
    state == C_NULL ? nothing : (Argument(state), API.LLVMGetNextParam(state))
end

Base.last(iter::FunctionParameterSet) =
    Argument(API.LLVMGetLastParam(ref(iter.f)))

Base.isempty(iter::FunctionParameterSet) =
    API.LLVMGetLastParam(ref(iter.f)) == C_NULL

Base.length(iter::FunctionParameterSet) = API.LLVMCountParams(ref(iter.f))

# NOTE: optimized `collect`
function Base.collect(iter::FunctionParameterSet)
    elems = Vector{API.LLVMValueRef}(undef, length(iter))
    API.LLVMGetParams(ref(iter.f), elems)
    return map(el->Argument(el), elems)
end

# basic block iteration

export blocks

struct FunctionBlockSet
    f::Function
end

blocks(f::Function) = FunctionBlockSet(f)

Base.eltype(::FunctionBlockSet) = BasicBlock

function Base.iterate(iter::FunctionBlockSet, state=API.LLVMGetFirstBasicBlock(ref(iter.f)))
    state == C_NULL ? nothing : (BasicBlock(state), API.LLVMGetNextBasicBlock(state))
end

Base.last(iter::FunctionBlockSet) =
    BasicBlock(API.LLVMGetLastBasicBlock(ref(iter.f)))

Base.isempty(iter::FunctionBlockSet) =
    API.LLVMGetLastBasicBlock(ref(iter.f)) == C_NULL

Base.length(iter::FunctionBlockSet) = API.LLVMCountBasicBlocks(ref(iter.f))

# NOTE: optimized `collect`
function Base.collect(iter::FunctionBlockSet)
    elems = Vector{API.LLVMValueRef}(undef, length(iter))
    API.LLVMGetBasicBlocks(ref(iter.f), elems)
    return BasicBlock[BasicBlock(elem) for elem in elems]
end
