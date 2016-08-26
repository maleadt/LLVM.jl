export LLVMFunction,  unsafe_delete!,
       personality, personality!,
       callconv, callconv!,
       gc, gc!, intrinsic_id,
       entry

import Base: get, push!

# http://llvm.org/docs/doxygen/html/group__LLVMCCoreValueFunction.html

LLVMFunction(mod::LLVMModule, name::String, ft::FunctionType) =
    construct(LLVMFunction,
              API.LLVMAddFunction(ref(LLVMModule, mod), name,
                                  ref(LLVMType, ft)))

unsafe_delete!(::LLVMModule, fn::LLVMFunction) = API.LLVMDeleteFunction(ref(Value, fn))

personality(fn::LLVMFunction) =
    construct(LLVMFunction, API.LLVMGetPersonalityFn(ref(Value, fn)))
personality!(fn::LLVMFunction, persfn::LLVMFunction) =
    API.LLVMSetPersonalityFn(ref(Value, fn),
                             ref(Value, persfn))

intrinsic_id(fn::LLVMFunction) = API.LLVMGetIntrinsicID(ref(Value, fn))

callconv(fn::LLVMFunction) = API.LLVMGetFunctionCallConv(ref(Value, fn))
callconv!(fn::LLVMFunction, cc) =
    API.LLVMSetFunctionCallConv(ref(Value, fn), Cuint(cc))

function gc(fn::LLVMFunction)
  ptr = API.LLVMGetGC(ref(Value, fn))
  return ptr==C_NULL ? "" :  unsafe_string(ptr)
end
gc!(fn::LLVMFunction, name::String) = API.LLVMSetGC(ref(Value, fn), name)

entry(fn::LLVMFunction) = BasicBlock(API.LLVMGetEntryBasicBlock(ref(Value, fn)))

# attributes

export attributes

import Base: get, push!, delete!

immutable FunctionAttrSet
    fn::LLVMFunction
end

attributes(fn::LLVMFunction) = FunctionAttrSet(fn)

get(iter::FunctionAttrSet) = API.LLVMGetFunctionAttr(ref(Value, iter.fn))

push!(iter::FunctionAttrSet, attr) = API.LLVMAddFunctionAttr(ref(Value, iter.fn), attr)

delete!(iter::FunctionAttrSet, attr) = API.LLVMRemoveFunctionAttr(ref(Value, iter.fn), attr)

# parameter iteration

export Argument, parameters

import Base: eltype, getindex, start, next, done, last

@reftypedef argtype=Value kind=LLVMArgumentValueKind immutable Argument <: Value end

immutable FunctionParameterSet
    fn::LLVMFunction
end

parameters(fn::LLVMFunction) = FunctionParameterSet(fn)

eltype(::FunctionParameterSet) = Argument

getindex(iter::FunctionParameterSet, i) =
  construct(Argument, API.LLVMGetParam(ref(Value, iter.fn), Cuint(i-1)))

start(iter::FunctionParameterSet) = API.LLVMGetFirstParam(ref(Value, iter.fn))

next(::FunctionParameterSet, state) =
    (construct(Argument, state), API.LLVMGetNextParam(state))

done(::FunctionParameterSet, state) = state == C_NULL

last(iter::FunctionParameterSet) =
    construct(Argument, API.LLVMGetLastParam(ref(Value, iter.fn)))

length(iter::FunctionParameterSet) = API.LLVMCountParams(ref(Value, iter.fn))

# basic block iteration

export blocks

import Base: eltype, start, next, done, last, length

immutable FunctionBlockSet
    fn::LLVMFunction
end

blocks(fn::LLVMFunction) = FunctionBlockSet(fn)

eltype(::FunctionBlockSet) = BasicBlock

start(iter::FunctionBlockSet) = API.LLVMGetFirstBasicBlock(ref(Value, iter.fn))

next(::FunctionBlockSet, state) =
    (BasicBlock(state), API.LLVMGetNextBasicBlock(state))

done(::FunctionBlockSet, state) = state == C_NULL

last(iter::FunctionBlockSet) =
    BasicBlock(API.LLVMGetLastBasicBlock(ref(Value, iter.fn)))

length(iter::FunctionBlockSet) = API.LLVMCountBasicBlocks(ref(Value, iter.fn))
