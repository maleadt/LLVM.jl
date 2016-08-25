# An instruction builder represents a point within a basic block and is the exclusive means
# of building instructions using the C interface.

export Builder,
       position!,
       debuglocation, debuglocation!

import Base: position, insert!

@reftypedef reftype=LLVMBuilderRef immutable Builder end

Builder() = Builder(API.LLVMCreateBuilder())
Builder(ctx::Context) = Builder(API.LLVMCreateBuilderInContext(ref(Context, ctx)))

dispose(builder::Builder) = API.LLVMDisposeBuilder(ref(Builder, builder))

function Builder(f::Function, args...)
    builder = Builder(args...)
    try
        f(builder)
    finally
        dispose(builder)
    end
end

position(builder::Builder) = BasicBlock(API.LLVMGetInsertBlock(ref(Builder, builder)))
position!(builder::Builder, inst::Instruction) = 
    API.LLVMPositionBuilderBefore(ref(Builder, builder), ref(Value, inst))
position!(builder::Builder, bb::BasicBlock) = 
    API.LLVMPositionBuilderAtEnd(ref(Builder, builder), ref(BasicBlock, bb))
position!(builder::Builder) = API.LLVMClearInsertionPosition(ref(Builder, builder))

insert!(builder::Builder, inst::Instruction) =
    API.LLVMInsertIntoBuilder(ref(Builder, builder), ref(Value, inst))
insert!(builder::Builder, inst::Instruction, name::String) =
    API.LLVMInsertIntoBuilderWithName(ref(Builder, builder), ref(Value, inst), name)

debuglocation(builder::Builder) = 
    construct(MetadataAsValue, API.LLVMGetCurrentDebugLocation(ref(Builder, builder)))
debuglocation!(builder::Builder) = 
    API.LLVMSetCurrentDebugLocation(ref(Builder, builder), nullref(Value))
debuglocation!(builder::Builder, loc::MetadataAsValue) =
    API.LLVMSetCurrentDebugLocation(ref(Builder, builder), ref(Value, loc))
debuglocation!(builder::Builder, inst::Instruction) =
    API.LLVMSetInstDebugLocation(ref(Builder, builder), ref(Value, inst))


## build methods

export unreachable!, ret!, add!

unreachable!(builder::Builder) =
    construct(Instruction, API.LLVMBuildUnreachable(ref(Builder, builder)))

ret!(builder::Builder) =
    construct(Instruction, API.LLVMBuildRetVoid(ref(Builder, builder)))

ret!(builder::Builder, val::Value) =
    construct(Instruction, API.LLVMBuildRet(ref(Builder, builder), ref(Value, val)))

add!(builder::Builder, lhs::Value, rhs::Value, name="") = 
    construct(Instruction, API.LLVMBuildAdd(ref(Builder, builder), ref(Value, lhs),
                                            ref(Value, rhs), name))
