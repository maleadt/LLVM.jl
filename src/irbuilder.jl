# An instruction builder represents a point within a basic block and is the exclusive means
# of building instructions using the C interface.

export Builder,
       position!,
       debuglocation, debuglocation!

@checked struct Builder
    ref::API.LLVMBuilderRef
end

Base.unsafe_convert(::Type{API.LLVMBuilderRef}, builder::Builder) = builder.ref

Builder(ctx::Context) = Builder(API.LLVMCreateBuilderInContext(ctx))

dispose(builder::Builder) = API.LLVMDisposeBuilder(builder)

function Builder(f::Core.Function, args...; kwargs...)
    builder = Builder(args...; kwargs...)
    try
        f(builder)
    finally
        dispose(builder)
    end
end

Base.position(builder::Builder) = BasicBlock(API.LLVMGetInsertBlock(builder))
position!(builder::Builder, inst::Instruction) =
    API.LLVMPositionBuilderBefore(builder, inst)
position!(builder::Builder, bb::BasicBlock) =
    API.LLVMPositionBuilderAtEnd(builder, bb)
position!(builder::Builder) = API.LLVMClearInsertionPosition(builder)

Base.insert!(builder::Builder, inst::Instruction) =
    API.LLVMInsertIntoBuilder(builder, inst)
Base.insert!(builder::Builder, inst::Instruction, name::String) =
    API.LLVMInsertIntoBuilderWithName(builder, inst, name)

function debuglocation(builder::Builder)
    ref = API.LLVMGetCurrentDebugLocation2(builder)
    ref == C_NULL ? nothing : Metadata(ref)
end
debuglocation!(builder::Builder) =
    API.LLVMSetCurrentDebugLocation2(builder, C_NULL)
debuglocation!(builder::Builder, loc::Metadata) =
    API.LLVMSetCurrentDebugLocation2(builder, loc)
debuglocation!(builder::Builder, loc::MetadataAsValue) =
    API.LLVMSetCurrentDebugLocation2(builder, Metadata(loc))
debuglocation!(builder::Builder, inst::Instruction) =
    API.LLVMSetInstDebugLocation(builder, inst)


## build methods

# TODO/IDEAS:
# - dynamic dispatch based on `llvmtype` (eg. disambiguating `add!` and `fadd!`)

# NOTE: the return values for these operations are, according to the C API, always a Value.
#       however, the C++ API learns us that we can be more strict.

export ret!, br!, switch!, indirectbr!, invoke!, resume!, unreachable!,

       binop!, add!, nswadd!, nuwadd!, fadd!, sub!, nswsub!, nuwsub!, fsub!, mul!, nswmul!,
       nuwmul!, fmul!, udiv!, sdiv!, exactsdiv!, fdiv!, urem!, srem!, frem!, neg!, nswneg!,
       nuwneg!, fneg!,

       shl!, lshr!, ashr!, and!, or!, xor!, not!,

       extract_element!, insert_element!, shuffle_vector!,

       extract_value!, insert_value!,

       alloca!, array_alloca!, malloc!, array_malloc!, free!, load!, store!, fence!,
       atomic_rmw!, atomic_cmpxchg!, gep!, inbounds_gep!, struct_gep!,

       trunc!, zext!, sext!, fptoui!, fptosi!, uitofp!, sitofp!, fptrunc!, fpext!,
       ptrtoint!, inttoptr!, bitcast!, addrspacecast!, zextorbitcast!, sextorbitcast!,
       truncorbitcast!, cast!, pointercast!, intcast!, fpcast!,

       icmp!, fcmp!, phi!, select!, call!, va_arg!, landingpad!,

       globalstring!, globalstring_ptr!, isnull!, isnotnull!, ptrdiff!


# terminator instructions

ret!(builder::Builder) =
    Instruction(API.LLVMBuildRetVoid(builder))

ret!(builder::Builder, V::Value) =
    Instruction(API.LLVMBuildRet(builder, V))

ret!(builder::Builder, RetVals::Vector{<:Value}) =
    Instruction(API.LLVMBuildAggregateRet(builder, RetVals, length(RetVals)))

br!(builder::Builder, Dest::BasicBlock) =
    Instruction(API.LLVMBuildBr(builder, Dest))

br!(builder::Builder, If::Value, Then::BasicBlock, Else::BasicBlock) =
    Instruction(API.LLVMBuildCondBr(builder, If, Then, Else))

switch!(builder::Builder, V::Value, Else::BasicBlock, NumCases::Integer=10) =
    Instruction(API.LLVMBuildSwitch(builder, V, Else, NumCases))

indirectbr!(builder::Builder, Addr::Value, NumDests::Integer=10) =
    Instruction(API.LLVMBuildIndirectBr(builder, Addr, NumDests))

invoke!(builder::Builder, Fn::Value, Args::Vector{<:Value}, Then::BasicBlock, Catch::BasicBlock, Name::String="") =
    Instruction(API.LLVMBuildInvoke(builder, Fn, Args, length(Args), Then, Catch, Name))

resume!(builder::Builder, Exn::Value) =
    Instruction(API.LLVMBuildResume(builder, Exn))

unreachable!(builder::Builder) =
    Instruction(API.LLVMBuildUnreachable(builder))


# binary operations

binop!(builder::Builder, Op::API.LLVMOpcode, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildBinOp(builder, Op, LHS, RHS, Name))

add!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildAdd(builder, LHS, RHS, Name))

nswadd!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildNSWAdd(builder, LHS, RHS, Name))

nuwadd!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildNUWAdd(builder, LHS, RHS, Name))

fadd!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildFAdd(builder, LHS, RHS, Name))

sub!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildSub(builder, LHS, RHS, Name))

nswsub!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildNSWSub(builder, LHS, RHS, Name))

nuwsub!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildNUWSub(builder, LHS, RHS, Name))

fsub!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildFSub(builder, LHS, RHS, Name))

mul!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildMul(builder, LHS, RHS, Name))

nswmul!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildNSWMul(builder, LHS, RHS, Name))

nuwmul!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildNUWMul(builder, LHS, RHS, Name))

fmul!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildFMul(builder, LHS, RHS, Name))

udiv!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildUDiv(builder, LHS, RHS, Name))

sdiv!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildSDiv(builder, LHS, RHS, Name))

exactsdiv!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildExactSDiv(builder, LHS, RHS, Name))

fdiv!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildFDiv(builder, LHS, RHS, Name))

urem!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildURem(builder, LHS, RHS, Name))

srem!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildSRem(builder, LHS, RHS, Name))

frem!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildFRem(builder, LHS, RHS, Name))


# bitwise binary operations

shl!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildShl(builder, LHS, RHS, Name))

lshr!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildLShr(builder, LHS, RHS, Name))

ashr!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildAShr(builder, LHS, RHS, Name))

and!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildAnd(builder, LHS, RHS, Name))

or!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildOr(builder, LHS, RHS, Name))

xor!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildXor(builder, LHS, RHS, Name))


# vector operations

extract_element!(builder::Builder, VecVal::Value, Index::Value, Name::String="") =
    Value(API.LLVMBuildExtractElement(builder, VecVal, Index, Name))

insert_element!(builder::Builder, VecVal::Value, EltVal::Value, Index::Value, Name::String="") =
    Value(API.LLVMBuildInsertElement(builder, VecVal, EltVal, Index, Name))

shuffle_vector!(builder::Builder, V1::Value, V2::Value, Mask::Value, Name::String="") =
    Value(API.LLVMBuildShuffleVector(builder, V1, V2, Mask, Name))


# aggregate operations

extract_value!(builder::Builder, AggVal::Value, Index, Name::String="") =
    Value(API.LLVMBuildExtractValue(builder, AggVal, Index, Name))

insert_value!(builder::Builder, AggVal::Value, EltVal::Value, Index, Name::String="") =
    Value(API.LLVMBuildInsertValue(builder, AggVal, EltVal, Index, Name))


# memory access and addressing operations

alloca!(builder::Builder, Ty::LLVMType, Name::String="") =
    Instruction(API.LLVMBuildAlloca(builder, Ty, Name))

array_alloca!(builder::Builder, Ty::LLVMType, Val::Value, Name::String="") =
    Instruction(API.LLVMBuildArrayAlloca(builder, Ty, Val, Name))

malloc!(builder::Builder, Ty::LLVMType, Name::String="") =
    Instruction(API.LLVMBuildMalloc(builder, Ty, Name))

array_malloc!(builder::Builder, Ty::LLVMType, Val::Value, Name::String="") =
    Instruction(API.LLVMBuildArrayMalloc(builder, Ty, Val, Name))

free!(builder::Builder, PointerVal::Value) =
    Instruction(API.LLVMBuildFree(builder, PointerVal))

load!(builder::Builder, PointerVal::Value, Name::String="") =
    Instruction(API.LLVMBuildLoad(builder, PointerVal, Name))

store!(builder::Builder, Val::Value, Ptr::Value) =
    Instruction(API.LLVMBuildStore(builder, Val, Ptr))

fence!(builder::Builder, ordering::API.LLVMAtomicOrdering, singleThread::Core.Bool=false, Name::String="") =
    Instruction(API.LLVMBuildFence(builder, ordering, convert(Bool, singleThread), Name))
Ptr
atomic_rmw!(builder::Builder, op::API.LLVMAtomicRMWBinOp, Ptr::Value, Val::Value, ordering::API.LLVMAtomicOrdering, singleThread::Core.Bool) =
    Instruction(API.LLVMBuildAtomicRMW(builder, op, Ptr, Val, ordering, convert(Bool, singleThread)))

atomic_cmpxchg!(builder::Builder, Ptr::Value, Cmp::Value, New::Value, SuccessOrdering::API.LLVMAtomicOrdering, FailureOrdering::API.LLVMAtomicOrdering, SingleThread::Core.Bool) =
    Instruction(API.LLVMBuildAtomicCmpXchg(builder, Ptr, Cmp, New, SuccessOrdering,FailureOrdering, convert(Bool, SingleThread)))

gep!(builder::Builder, Pointer::Value, Indices::Vector{<:Value}, Name::String="") =
    Value(API.LLVMBuildGEP(builder, Pointer, Indices, length(Indices), Name))

inbounds_gep!(builder::Builder, Pointer::Value, Indices::Vector{<:Value}, Name::String="") =
    Value(API.LLVMBuildInBoundsGEP(builder, Pointer, Indices, length(Indices), Name))

struct_gep!(builder::Builder, Pointer::Value, Idx, Name::String="") =
    Value(API.LLVMBuildStructGEP(builder, Pointer, Idx, Name))


# conversion operations

trunc!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildTrunc(builder, Val, DestTy, Name))

zext!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildZExt(builder, Val, DestTy, Name))

sext!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildSExt(builder, Val, DestTy, Name))

fptoui!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildFPToUI(builder, Val, DestTy, Name))

fptosi!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildFPToSI(builder, Val, DestTy, Name))

uitofp!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildUIToFP(builder, Val, DestTy, Name))

sitofp!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildSIToFP(builder, Val, DestTy, Name))

fptrunc!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildFPTrunc(builder, Val, DestTy, Name))

fpext!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildFPExt(builder, Val, DestTy, Name))

ptrtoint!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildPtrToInt(builder, Val, DestTy, Name))

inttoptr!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildIntToPtr(builder, Val, DestTy, Name))

bitcast!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildBitCast(builder, Val, DestTy, Name))

addrspacecast!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildAddrSpaceCast(builder, Val, DestTy, Name))

zextorbitcast!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildZExtOrBitCast(builder, Val, DestTy, Name))

sextorbitcast!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildSExtOrBitCast(builder, Val, DestTy, Name))

truncorbitcast!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildTruncOrBitCast(builder, Val, DestTy, Name))

cast!(builder::Builder, Op::API.LLVMOpcode, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildCast(builder, Op, Val, DestTy, Name))

pointercast!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildPointerCast(builder, Val, DestTy, Name))

intcast!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildIntCast(builder, Val, DestTy, Name))

fpcast!(builder::Builder, Val::Value, DestTy::LLVMType, Name::String="") =
    Value(API.LLVMBuildFPCast(builder, Val, DestTy, Name))


# other operations

icmp!(builder::Builder, Op::API.LLVMIntPredicate, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildICmp(builder, Op, LHS, RHS, Name))

fcmp!(builder::Builder, Op::API.LLVMRealPredicate, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildFCmp(builder, Op, LHS, RHS, Name))

phi!(builder::Builder, Ty::LLVMType, Name::String="") =
    Instruction(API.LLVMBuildPhi(builder, Ty, Name))

select!(builder::Builder, If::Value, Then::Value, Else::Value, Name::String="") =
    Value(API.LLVMBuildSelect(builder, If, Then, Else, Name))

call!(builder::Builder, Fn::Value, Args::Vector{<:Value}=Value[], Name::String="") =
    Instruction(API.LLVMBuildCall(builder, Fn, Args, length(Args), Name))

call!(builder::Builder, Fn::Value, Args::Vector{<:Value},
      Bundles::Vector{OperandBundleDef}, Name::String="") =
    Instruction(API.LLVMBuildCallWithOpBundle(builder, Fn, Args, length(Args), Bundles,
                                              length(Bundles), Name))

va_arg!(builder::Builder, List::Value, Ty::LLVMType, Name::String="") =
    Instruction(API.LLVMBuildVAArg(builder, List, Ty, Name))

landingpad!(builder::Builder, Ty::LLVMType, PersFn::Value, NumClauses::Integer, Name::String="") =
    Instruction(API.LLVMBuildLandingPad(builder, Ty, PersFn, NumClauses, Name))

neg!(builder::Builder, V::Value, Name::String="") =
    Value(API.LLVMBuildNeg(builder, V, Name))

nswneg!(builder::Builder, V::Value, Name::String="") =
    Value(API.LLVMBuildNSWNeg(builder, V, Name))

nuwneg!(builder::Builder, V::Value, Name::String="") =
    Value(API.LLVMBuildNUWNeg(builder, V, Name))

fneg!(builder::Builder, V::Value, Name::String="") =
    Value(API.LLVMBuildFNeg(builder, V, Name))

not!(builder::Builder, V::Value, Name::String="") =
    Value(API.LLVMBuildNot(builder, V, Name))


# other build methods

globalstring!(builder::Builder, Str::String, Name::String="") =
    Value(API.LLVMBuildGlobalString(builder, Str, Name))

globalstring_ptr!(builder::Builder, Str::String, Name::String="") =
    Value(API.LLVMBuildGlobalStringPtr(builder, Str, Name))

isnull!(builder::Builder, Val::Value, Name::String="") =
    Value(API.LLVMBuildIsNull(builder, Val, Name))

isnotnull!(builder::Builder, Val::Value, Name::String="") =
    Value(API.LLVMBuildIsNotNull(builder, Val, Name))

ptrdiff!(builder::Builder, LHS::Value, RHS::Value, Name::String="") =
    Value(API.LLVMBuildPtrDiff(builder, LHS, RHS, Name))
