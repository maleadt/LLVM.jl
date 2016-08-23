export issized, context, show

import Base: show

@llvmtype abstract LLVMType

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
    convert(Bool, API.LLVMTypeIsSized(convert(API.LLVMTypeRef, typ)))
context(typ::LLVMType) = Context(API.LLVMGetTypeContext(convert(API.LLVMTypeRef, typ)))

function show(io::IO, typ::LLVMType)
    output = unsafe_string(API.LLVMPrintTypeToString(convert(API.LLVMTypeRef, typ)))
    print(io, output)
end


## integer

export width

@llvmtype immutable LLVMInteger <: LLVMType end

for T in [:Int1, :Int8, :Int16, :Int32, :Int64, :Int128]
    jlfun = Symbol(T, :Type)
    apifun = Symbol(:LLVM, jlfun)
    @eval begin
        $jlfun() = construct(LLVMInteger, API.$apifun())
        $jlfun(ctx::Context) =
            construct(LLVMInteger,
                      API.$(Symbol(apifun, :InContext))(convert(API.LLVMContextRef, ctx)))
    end
end

width(inttyp::LLVMInteger) = API.LLVMGetIntTypeWidth(convert(API.LLVMTypeRef, inttyp))


## floating-point

# NOTE: we don't handle the obscure types here (:X86FP80, :FP128, :PPCFP128),
#       they would also need special casing as LLVMPPCFP128Type != LLVMPPC_FP128TypeKind
for T in [:Half, :Float, :Double]
    jlfun = Symbol(T, :Type)
    apityp = Symbol(:LLVM, T)
    apifun = Symbol(:LLVM, jlfun)
    @eval begin
        @llvmtype immutable $apityp <: LLVMType end

        $jlfun() = construct($apityp, API.$apifun())
        $jlfun(ctx::Context) =
            construct($apityp,
                      API.$(Symbol(apifun, :InContext))(convert(API.LLVMContextRef, ctx)))
    end
end


## function types

export isvararg, return_type, parameters

@llvmtype immutable FunctionType <: LLVMType end

function FunctionType{T<:LLVMType}(rettyp::LLVMType, params::Vector{T}, vararg::Bool=false)
    _params = map(t->convert(API.LLVMTypeRef, t), params)
    return FunctionType(API.LLVMFunctionType(convert(API.LLVMTypeRef, rettyp),
                                         _params, Cuint(length(_params)),
                                         convert(LLVMBool, vararg)))
end

isvararg(ft::FunctionType) =
    convert(Bool, API.LLVMIsFunctionVarArg(convert(API.LLVMTypeRef, ft)))

return_type(ft::FunctionType) =
    dynamic_convert(LLVMType, API.LLVMGetReturnType(convert(API.LLVMTypeRef, ft)))

function parameters(ft::FunctionType)
    nparams = API.LLVMCountParamTypes(convert(API.LLVMTypeRef, ft))
    params = Vector{API.LLVMTypeRef}(nparams)
    API.LLVMGetParamTypes(convert(API.LLVMTypeRef, ft), params)
    return map(t->dynamic_convert(LLVMType, t), params)
end



## composite types

@llvmtype abstract CompositeType <: LLVMType


## sequential types

export addrspace

@llvmtype abstract SequentialType <: CompositeType

import Base: length, size, eltype

eltype(typ::SequentialType) =
    dynamic_convert(LLVMType, API.LLVMGetElementType(convert(API.LLVMTypeRef, typ)))

@llvmtype immutable PointerType <: SequentialType end

function PointerType(eltyp::LLVMType, addrspace=0)
    return PointerType(API.LLVMPointerType(convert(API.LLVMTypeRef, eltyp),
                                           Cuint(addrspace)))
end

addrspace(ptrtyp::PointerType) =
    API.LLVMGetPointerAddressSpace(convert(API.LLVMTypeRef, ptrtyp))

@llvmtype immutable ArrayType <: SequentialType end

function ArrayType(eltyp::LLVMType, count)
    return ArrayType(API.LLVMArrayType(convert(API.LLVMTypeRef, eltyp), Cuint(count)))
end

length(arrtyp::ArrayType) = API.LLVMGetArrayLength(convert(API.LLVMTypeRef, arrtyp))

@llvmtype immutable VectorType <: SequentialType end

function VectorType(eltyp::LLVMType, count)
    return VectorType(API.LLVMVectorType(convert(API.LLVMTypeRef, eltyp), Cuint(count)))
end

size(vectyp::VectorType) = API.LLVMGetVectorSize(convert(API.LLVMTypeRef, vectyp))


## structure types

export name, ispacked, isopaque, elements, elements!

@llvmtype immutable StructType <: SequentialType end

function StructType(name::String, ctx::Context=GlobalContext())
    return StructType(API.LLVMStructCreateNamed(convert(API.LLVMContextRef, ctx), name))
end

function StructType{T<:LLVMType}(elems::Vector{T}, ctx::Context=GlobalContext(),
                                 packed::Bool=false)
    _elems = map(t->convert(API.LLVMTypeRef, t), elems)

    return StructType(API.LLVMStructTypeInContext(convert(API.LLVMContextRef, ctx), _elems,
                                                  Cuint(length(_elems)),
                                                  convert(LLVMBool, packed)))
end

name(structtyp::StructType) =
    unsafe_string(API.LLVMGetStructName(convert(API.LLVMTypeRef, structtyp)))
ispacked(structtyp::StructType) =
    convert(Bool, API.LLVMIsPackedStruct(convert(API.LLVMTypeRef, structtyp)))
isopaque(structtyp::StructType) =
    convert(Bool, API.LLVMIsOpaqueStruct(convert(API.LLVMTypeRef, structtyp)))

function elements(structtyp::StructType)
    nelems = API.LLVMCountStructElementTypes(convert(API.LLVMTypeRef, structtyp))
    elems = Vector{API.LLVMTypeRef}(nelems)
    API.LLVMGetStructElementTypes(convert(API.LLVMTypeRef, structtyp), elems)
    return map(t->dynamic_convert(LLVMType, t), elems)
end

function elements!{T<:LLVMType}(structtyp::StructType, elems::Vector{T}, packed::Bool=false)
    _elems = map(t->convert(API.LLVMTypeRef, t), elems)

    API.LLVMStructSetBody(convert(API.LLVMTypeRef, structtyp), _elems,
                          Cuint(length(_elems)), convert(LLVMBool, packed))
end


## other

@llvmtype immutable LLVMVoid <: LLVMType end

VoidType() = construct(LLVMVoid, API.LLVMVoidType())
VoidType(ctx::Context) =
    construct(LLVMVoid, API.LLVMVoidTypeInContext(convert(API.LLVMContextRef, ctx)))

@llvmtype immutable LLVMLabel <: LLVMType end

LabelType() = construct(LLVMLabel, API.LLVMLabelType())
LabelType(ctx::Context) =
    construct(LLVMLabel, API.LLVMLabelTypeInContext(convert(API.LLVMContextRef, ctx)))
