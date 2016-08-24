export LLVMType, issized, context, show

import Base: show

@reftypedef abstract LLVMType

dynamic_convert(::Type{LLVMType}, ref::API.LLVMTypeRef) =
    identify(ref, API.LLVMGetTypeKind(ref))(ref)

@inline function construct{T<:LLVMType}(::Type{T}, ref::API.LLVMTypeRef)
    @static if DEBUG
        RealT = identify(ref, API.LLVMGetTypeKind(ref))
        if T != RealT
            error("invalid conversion of $RealT reference to $T")
        end
    end
    return T(ref)
end

issized(typ::LLVMType) =
    convert(Bool, API.LLVMTypeIsSized(ref(LLVMType, typ)))
context(typ::LLVMType) = Context(API.LLVMGetTypeContext(ref(LLVMType, typ)))

function show(io::IO, typ::LLVMType)
    output = unsafe_string(API.LLVMPrintTypeToString(ref(LLVMType, typ)))
    print(io, output)
end


## integer

export width

@reftypedef immutable LLVMInteger <: LLVMType end

for T in [:Int1, :Int8, :Int16, :Int32, :Int64, :Int128]
    jlfun = Symbol(T, :Type)
    apifun = Symbol(:LLVM, jlfun)
    @eval begin
        $jlfun() = construct(LLVMInteger, API.$apifun())
        $jlfun(ctx::Context) =
            construct(LLVMInteger,
                      API.$(Symbol(apifun, :InContext))(ref(Context, ctx)))
    end
end

width(inttyp::LLVMInteger) = API.LLVMGetIntTypeWidth(ref(LLVMType, inttyp))


## floating-point

# NOTE: we don't handle the obscure types here (:X86FP80, :FP128, :PPCFP128),
#       they would also need special casing as LLVMPPCFP128Type != LLVMPPC_FP128TypeKind
for T in [:Half, :Float, :Double]
    jlfun = Symbol(T, :Type)
    apityp = Symbol(:LLVM, T)
    apifun = Symbol(:LLVM, jlfun)
    @eval begin
        @reftypedef immutable $apityp <: LLVMType end

        $jlfun() = construct($apityp, API.$apifun())
        $jlfun(ctx::Context) =
            construct($apityp,
                      API.$(Symbol(apifun, :InContext))(ref(Context, ctx)))
    end
end


## function types

export isvararg, return_type, parameters

@reftypedef immutable FunctionType <: LLVMType end

function FunctionType{T<:LLVMType}(rettyp::LLVMType, params::Vector{T}, vararg::Bool=false)
    _params = map(t->ref(LLVMType, t), params)
    return FunctionType(API.LLVMFunctionType(ref(LLVMType, rettyp),
                                         _params, Cuint(length(_params)),
                                         convert(LLVMBool, vararg)))
end

isvararg(ft::FunctionType) =
    convert(Bool, API.LLVMIsFunctionVarArg(ref(LLVMType, ft)))

return_type(ft::FunctionType) =
    dynamic_convert(LLVMType, API.LLVMGetReturnType(ref(LLVMType, ft)))

function parameters(ft::FunctionType)
    nparams = API.LLVMCountParamTypes(ref(LLVMType, ft))
    params = Vector{API.LLVMTypeRef}(nparams)
    API.LLVMGetParamTypes(ref(LLVMType, ft), params)
    return map(t->dynamic_convert(LLVMType, t), params)
end



## composite types

@reftypedef abstract CompositeType <: LLVMType


## sequential types

export addrspace

@reftypedef abstract SequentialType <: CompositeType

import Base: length, size, eltype

eltype(typ::SequentialType) =
    dynamic_convert(LLVMType, API.LLVMGetElementType(ref(LLVMType, typ)))

@reftypedef immutable PointerType <: SequentialType end

function PointerType(eltyp::LLVMType, addrspace=0)
    return PointerType(API.LLVMPointerType(ref(LLVMType, eltyp),
                                           Cuint(addrspace)))
end

addrspace(ptrtyp::PointerType) =
    API.LLVMGetPointerAddressSpace(ref(LLVMType, ptrtyp))

@reftypedef immutable ArrayType <: SequentialType end

function ArrayType(eltyp::LLVMType, count)
    return ArrayType(API.LLVMArrayType(ref(LLVMType, eltyp), Cuint(count)))
end

length(arrtyp::ArrayType) = API.LLVMGetArrayLength(ref(LLVMType, arrtyp))

@reftypedef immutable VectorType <: SequentialType end

function VectorType(eltyp::LLVMType, count)
    return VectorType(API.LLVMVectorType(ref(LLVMType, eltyp), Cuint(count)))
end

size(vectyp::VectorType) = API.LLVMGetVectorSize(ref(LLVMType, vectyp))


## structure types

export name, ispacked, isopaque, elements, elements!

@reftypedef immutable StructType <: SequentialType end

function StructType(name::String, ctx::Context=GlobalContext())
    return StructType(API.LLVMStructCreateNamed(ref(Context, ctx), name))
end

function StructType{T<:LLVMType}(elems::Vector{T}, ctx::Context=GlobalContext(),
                                 packed::Bool=false)
    _elems = map(t->ref(LLVMType, t), elems)

    return StructType(API.LLVMStructTypeInContext(ref(Context, ctx), _elems,
                                                  Cuint(length(_elems)),
                                                  convert(LLVMBool, packed)))
end

name(structtyp::StructType) =
    unsafe_string(API.LLVMGetStructName(ref(LLVMType, structtyp)))
ispacked(structtyp::StructType) =
    convert(Bool, API.LLVMIsPackedStruct(ref(LLVMType, structtyp)))
isopaque(structtyp::StructType) =
    convert(Bool, API.LLVMIsOpaqueStruct(ref(LLVMType, structtyp)))

function elements(structtyp::StructType)
    nelems = API.LLVMCountStructElementTypes(ref(LLVMType, structtyp))
    elems = Vector{API.LLVMTypeRef}(nelems)
    API.LLVMGetStructElementTypes(ref(LLVMType, structtyp), elems)
    return map(t->dynamic_convert(LLVMType, t), elems)
end

function elements!{T<:LLVMType}(structtyp::StructType, elems::Vector{T}, packed::Bool=false)
    _elems = map(t->ref(LLVMType, t), elems)

    API.LLVMStructSetBody(ref(LLVMType, structtyp), _elems,
                          Cuint(length(_elems)), convert(LLVMBool, packed))
end


## other

@reftypedef immutable LLVMVoid <: LLVMType end

VoidType() = construct(LLVMVoid, API.LLVMVoidType())
VoidType(ctx::Context) =
    construct(LLVMVoid, API.LLVMVoidTypeInContext(ref(Context, ctx)))

@reftypedef immutable LLVMLabel <: LLVMType end

LabelType() = construct(LLVMLabel, API.LLVMLabelType())
LabelType(ctx::Context) =
    construct(LLVMLabel, API.LLVMLabelTypeInContext(ref(Context, ctx)))
