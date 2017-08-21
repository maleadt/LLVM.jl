export unsafe_delete!,
       personality, personality!,
       callconv, callconv!,
       gc, gc!, intrinsic_id,
       entry

import Base: get, push!

# forward declaration of Function in src/core/basicblock.jl

Function(mod::Module, name::String, ft::FunctionType) =
    Function(API.LLVMAddFunction(ref(mod), name, ref(ft)))

unsafe_delete!(::Module, f::Function) = API.LLVMDeleteFunction(ref(f))

personality(f::Function) = Function(API.LLVMGetPersonalityFn(ref(f)))
personality!(f::Function, persfn::Function) = API.LLVMSetPersonalityFn(ref(f), ref(persfn))

intrinsic_id(f::Function) = API.LLVMGetIntrinsicID(ref(f))

callconv(f::Function) = API.LLVMGetFunctionCallConv(ref(f))
callconv!(f::Function, cc) = API.LLVMSetFunctionCallConv(ref(f), Cuint(cc))

function gc(f::Function)
  ptr = API.LLVMGetGC(ref(f))
  return ptr==C_NULL ? "" :  unsafe_string(ptr)
end
gc!(f::Function, name::String) = API.LLVMSetGC(ref(f), name)

entry(f::Function) = BasicBlock(API.LLVMGetEntryBasicBlock(ref(f)))

# attributes

export function_attributes, parameter_attributes, return_attributes

import Base: collect, push!, delete!

immutable FunctionAttrSet
    f::Function
    idx::API.LLVMAttributeIndex
end

function_attributes(f::Function) = FunctionAttrSet(f, API.LLVMAttributeFunctionIndex)
parameter_attributes(f::Function, idx::Integer) = FunctionAttrSet(f, API.LLVMAttributeIndex(idx))
return_attributes(f::Function) = FunctionAttrSet(f, API.LLVMAttributeReturnIndex)

eltype(::FunctionAttrSet) = Attribute

function collect(iter::FunctionAttrSet)
    elems = Vector{API.LLVMAttributeRef}(length(iter))
    if length(iter) > 0
      # FIXME: this prevents a nullptr ref in LLVM similar to D26392
      API.LLVMGetAttributesAtIndex(ref(iter.f), iter.idx, elems)
    end
    return Attribute.(elems)
end

push!(iter::FunctionAttrSet, attr::Attribute) =
    API.LLVMAddAttributeAtIndex(ref(iter.f), iter.idx, ref(attr))

delete!(iter::FunctionAttrSet, attr::EnumAttribute) =
    API.LLVMRemoveEnumAttributeAtIndex(ref(iter.f), iter.idx, kind(attr))

function delete!(iter::FunctionAttrSet, attr::StringAttribute)
    k = kind(attr)
    API.LLVMRemoveStringAttributeAtIndex(ref(iter.f), iter.idx, k, Cuint(length(k)))
end

function length(iter::FunctionAttrSet)
    # FIXME: apt nightlies report themselves as v"4.0" instead of "4.0-svn"
    #        alternatively, make the revision number part of the version string?
    if libllvm_version <= v"4.0"
        API.LLVMGetAttributeCountAtIndex_D26392(ref(iter.f), iter.idx)
    else
        API.LLVMGetAttributeCountAtIndex(ref(iter.f), iter.idx)
    end
end

# parameter iteration

export Argument, parameters

import Base: eltype, getindex, start, next, done, last, length, collect

@checked immutable Argument <: Value
    ref::reftype(Value)
end
identify(::Type{Value}, ::Val{API.LLVMArgumentValueKind}) = Argument

immutable FunctionParameterSet
    f::Function
end

parameters(f::Function) = FunctionParameterSet(f)

eltype(::FunctionParameterSet) = Argument

getindex(iter::FunctionParameterSet, i) =
  Argument(API.LLVMGetParam(ref(iter.f), Cuint(i-1)))

start(iter::FunctionParameterSet) = API.LLVMGetFirstParam(ref(iter.f))

next(::FunctionParameterSet, state) =
    (Argument(state), API.LLVMGetNextParam(state))

done(::FunctionParameterSet, state) = state == C_NULL

last(iter::FunctionParameterSet) =
    Argument(API.LLVMGetLastParam(ref(iter.f)))

length(iter::FunctionParameterSet) = API.LLVMCountParams(ref(iter.f))

# NOTE: optimized `collect`
function collect(iter::FunctionParameterSet)
    elems = Vector{API.LLVMValueRef}(length(iter))
    API.LLVMGetParams(ref(iter.f), elems)
    return map(el->Argument(el), elems)
end

# basic block iteration

export blocks

import Base: eltype, start, next, done, last, length

immutable FunctionBlockSet
    f::Function
end

blocks(f::Function) = FunctionBlockSet(f)

eltype(::FunctionBlockSet) = BasicBlock

start(iter::FunctionBlockSet) = API.LLVMGetFirstBasicBlock(ref(iter.f))

next(::FunctionBlockSet, state) =
    (BasicBlock(state), API.LLVMGetNextBasicBlock(state))

done(::FunctionBlockSet, state) = state == C_NULL

last(iter::FunctionBlockSet) =
    BasicBlock(API.LLVMGetLastBasicBlock(ref(iter.f)))

length(iter::FunctionBlockSet) = API.LLVMCountBasicBlocks(ref(iter.f))

# NOTE: optimized `collect`
function collect(iter::FunctionBlockSet)
    elems = Vector{API.LLVMValueRef}(length(iter))
    API.LLVMGetBasicBlocks(ref(iter.f), elems)
    return BasicBlock.(elems)
end
