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

unsafe_delete!(::Module, fn::Function) = API.LLVMDeleteFunction(ref(fn))

personality(fn::Function) =
    construct(Function, API.LLVMGetPersonalityFn(ref(fn)))
personality!(fn::Function, persfn::Function) =
    API.LLVMSetPersonalityFn(ref(fn),
                             ref(persfn))

intrinsic_id(fn::Function) = API.LLVMGetIntrinsicID(ref(fn))

callconv(fn::Function) = API.LLVMGetFunctionCallConv(ref(fn))
callconv!(fn::Function, cc) =
    API.LLVMSetFunctionCallConv(ref(fn), Cuint(cc))

function gc(fn::Function)
  ptr = API.LLVMGetGC(ref(fn))
  return ptr==C_NULL ? "" :  unsafe_string(ptr)
end
gc!(fn::Function, name::String) = API.LLVMSetGC(ref(fn), name)

entry(fn::Function) = BasicBlock(API.LLVMGetEntryBasicBlock(ref(fn)))

# attributes

export attributes

import Base: get, push!, delete!

immutable FunctionAttrSet
    fn::Function
end

attributes(fn::Function) = FunctionAttrSet(fn)

get(iter::FunctionAttrSet) = API.LLVMGetFunctionAttr(ref(iter.fn))

push!(iter::FunctionAttrSet, attr) = API.LLVMAddFunctionAttr(ref(iter.fn), attr)

delete!(iter::FunctionAttrSet, attr) = API.LLVMRemoveFunctionAttr(ref(iter.fn), attr)

# parameter iteration

export Argument, parameters

import Base: eltype, getindex, start, next, done, last

@reftypedef proxy=Value kind=LLVMArgumentValueKind immutable Argument <: Value end

immutable FunctionParameterSet
    fn::Function
end

parameters(fn::Function) = FunctionParameterSet(fn)

eltype(::FunctionParameterSet) = Argument

getindex(iter::FunctionParameterSet, i) =
  construct(Argument, API.LLVMGetParam(ref(iter.fn), Cuint(i-1)))

start(iter::FunctionParameterSet) = API.LLVMGetFirstParam(ref(iter.fn))

next(::FunctionParameterSet, state) =
    (construct(Argument, state), API.LLVMGetNextParam(state))

done(::FunctionParameterSet, state) = state == C_NULL

last(iter::FunctionParameterSet) =
    construct(Argument, API.LLVMGetLastParam(ref(iter.fn)))

length(iter::FunctionParameterSet) = API.LLVMCountParams(ref(iter.fn))

# basic block iteration

export blocks

import Base: eltype, start, next, done, last, length

immutable FunctionBlockSet
    fn::Function
end

blocks(fn::Function) = FunctionBlockSet(fn)

eltype(::FunctionBlockSet) = BasicBlock

start(iter::FunctionBlockSet) = API.LLVMGetFirstBasicBlock(ref(iter.fn))

next(::FunctionBlockSet, state) =
    (BasicBlock(state), API.LLVMGetNextBasicBlock(state))

done(::FunctionBlockSet, state) = state == C_NULL

last(iter::FunctionBlockSet) =
    BasicBlock(API.LLVMGetLastBasicBlock(ref(iter.fn)))

length(iter::FunctionBlockSet) = API.LLVMCountBasicBlocks(ref(iter.fn))
