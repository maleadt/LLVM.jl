# An instruction builder represents a point within a basic block and is the exclusive means
# of building instructions using the C interface.

export Builder,
       position!,
       debuglocation, debuglocation!

import Base: position, insert!

@reftypedef ref=LLVMBuilderRef immutable Builder end

Builder() = Builder(API.LLVMCreateBuilder())
Builder(ctx::Context) = Builder(API.LLVMCreateBuilderInContext(ref(ctx)))

dispose(builder::Builder) = API.LLVMDisposeBuilder(ref(builder))

function Builder(f::Core.Function, args...)
    builder = Builder(args...)
    try
        f(builder)
    finally
        dispose(builder)
    end
end

position(builder::Builder) = BasicBlock(API.LLVMGetInsertBlock(ref(builder)))
position!(builder::Builder, inst::Instruction) =
    API.LLVMPositionBuilderBefore(ref(builder), ref(inst))
position!(builder::Builder, bb::BasicBlock) =
    API.LLVMPositionBuilderAtEnd(ref(builder), blockref(bb))
position!(builder::Builder) = API.LLVMClearInsertionPosition(ref(builder))

insert!(builder::Builder, inst::Instruction) =
    API.LLVMInsertIntoBuilder(ref(builder), ref(inst))
insert!(builder::Builder, inst::Instruction, name::String) =
    API.LLVMInsertIntoBuilderWithName(ref(builder), ref(inst), name)

debuglocation(builder::Builder) =
    construct(MetadataAsValue, API.LLVMGetCurrentDebugLocation(ref(builder)))
debuglocation!(builder::Builder) =
    API.LLVMSetCurrentDebugLocation(ref(builder), nullref(Value))
debuglocation!(builder::Builder, loc::MetadataAsValue) =
    API.LLVMSetCurrentDebugLocation(ref(builder), ref(loc))
debuglocation!(builder::Builder, inst::Instruction) =
    API.LLVMSetInstDebugLocation(ref(builder), ref(inst))


## build methods

export unreachable!, ret!, add!, br!, alloca!

unreachable!(builder::Builder) =
    construct(Instruction, API.LLVMBuildUnreachable(ref(builder)))

ret!(builder::Builder) =
    construct(Instruction, API.LLVMBuildRetVoid(ref(builder)))

ret!(builder::Builder, val::Value) =
    construct(Instruction, API.LLVMBuildRet(ref(builder), ref(val)))

add!(builder::Builder, lhs::Value, rhs::Value, name::String="") =
    construct(Instruction, API.LLVMBuildAdd(ref(builder), ref(lhs),
                                            ref(rhs), name))

br!(builder::Builder, dest::BasicBlock) =
    construct(Instruction, API.LLVMBuildBr(ref(builder), blockref(dest)))

br!(builder::Builder, ifval::Value, thenbb::BasicBlock, elsebb::BasicBlock) =
    construct(Instruction, API.LLVMBuildCondBr(ref(builder),
                                               ref(ifval),
                                               blockref(thenbb),
                                               blockref(elsebb)))

alloca!(builder::Builder, typ::LLVMType, name::String="") =
    construct(Instruction, API.LLVMBuildAlloca(ref(builder), ref(typ), name))
