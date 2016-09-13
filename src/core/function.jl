export Function,  unsafe_delete!,
       personality, personality!,
       callconv, callconv!,
       gc, gc!, intrinsic_id,
       entry

import Base: get, push!

Function(mod::Module, name::String, ft::FunctionType) =
    construct(Function,
              API.LLVMAddFunction(ref(mod), name,
                                  ref(ft)))

unsafe_delete!(::Module, f::Function) = API.LLVMDeleteFunction(ref(f))

personality(f::Function) =
    construct(Function, API.LLVMGetPersonalityFn(ref(f)))
personality!(f::Function, persfn::Function) =
    API.LLVMSetPersonalityFn(ref(f), ref(persfn))

intrinsic_id(f::Function) = API.LLVMGetIntrinsicID(ref(f))

callconv(f::Function) = API.LLVMGetFunctionCallConv(ref(f))
callconv!(f::Function, cc) =
    API.LLVMSetFunctionCallConv(ref(f), Cuint(cc))

function gc(f::Function)
  ptr = API.LLVMGetGC(ref(f))
  return ptr==C_NULL ? "" :  unsafe_string(ptr)
end
gc!(f::Function, name::String) = API.LLVMSetGC(ref(f), name)

entry(f::Function) = BasicBlock(API.LLVMGetEntryBasicBlock(ref(f)))

# attributes

export attributes

import Base: get, push!, delete!

immutable FunctionAttrSet
    f::Function
end

attributes(f::Function) = FunctionAttrSet(f)

get(iter::FunctionAttrSet) = API.LLVMGetFunctionAttr(ref(iter.f))

push!(iter::FunctionAttrSet, attr) = API.LLVMAddFunctionAttr(ref(iter.f), attr)

delete!(iter::FunctionAttrSet, attr) = API.LLVMRemoveFunctionAttr(ref(iter.f), attr)

# parameter iteration

export Argument, parameters

import Base: eltype, getindex, start, next, done, last, length, collect

@reftypedef proxy=Value kind=LLVMArgumentValueKind immutable Argument <: Value end

immutable FunctionParameterSet
    f::Function
end

parameters(f::Function) = FunctionParameterSet(f)

eltype(::FunctionParameterSet) = Argument

getindex(iter::FunctionParameterSet, i) =
  construct(Argument, API.LLVMGetParam(ref(iter.f), Cuint(i-1)))

start(iter::FunctionParameterSet) = API.LLVMGetFirstParam(ref(iter.f))

next(::FunctionParameterSet, state) =
    (construct(Argument, state), API.LLVMGetNextParam(state))

done(::FunctionParameterSet, state) = state == C_NULL

last(iter::FunctionParameterSet) =
    construct(Argument, API.LLVMGetLastParam(ref(iter.f)))

length(iter::FunctionParameterSet) = API.LLVMCountParams(ref(iter.f))

# NOTE: optimized `collect`
function collect(iter::FunctionParameterSet)
    elems = Vector{API.LLVMValueRef}(length(iter))
    API.LLVMGetParams(ref(iter.f), elems)
    return map(t->construct(Argument, t), elems)
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
