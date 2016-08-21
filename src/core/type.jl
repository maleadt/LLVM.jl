export LLVMType, kind, issized, context, show

import Base: show

immutable LLVMType
    handle::API.LLVMTypeRef

    LLVMType(handle::API.LLVMTypeRef) = new(handle)
end

kind(typ::LLVMType) = API.LLVMGetTypeKind(typ.handle)
issized(typ::LLVMType) = API.LLVMTypeIsSized(typ.handle) == API.LLVMBool(1)
context(typ::LLVMType) = Context(API.LLVMGetTypeContext(typ.handle))

function show(io::IO, typ::LLVMType)
    output = unsafe_string(API.LLVMPrintTypeToString(typ.handle))
    print(io, output)
end

# TODO: try and model this hierarchy in the Julia type system


## integer & floating-point

export width

for T in [:Int1, :Int8, :Int16, :Int32, :Int64, :Int128,
          :Half, :Float, :Double, :X86FP80, :FP128, :PPCFP128]
    jlfun = Symbol(T, :Type)
    apifun = Symbol(:LLVM, jlfun)
    @eval begin
        $jlfun() = LLVMType(API.$apifun())
        $jlfun(ctx::Context) = LLVMType(API.$(Symbol(apifun, :InContext))(ctx.handle))
    end
end

width(typ::LLVMType) = API.LLVMGetIntTypeWidth(typ.handle)


## function types

export isvararg, return_type, parameters

function FunctionType(rettyp::LLVMType, params::Vector{LLVMType}, vararg::Bool=false)
    _params = map(t->t.handle, params)
    return LLVMType(API.LLVMFunctionType(rettyp.handle,
                                         _params, Cuint(length(_params)),
                                         API.LLVMBool(vararg)))
end

isvararg(ft::LLVMType) = API.LLVMIsFunctionVarArg(ft.handle) == API.LLVMBool(1)

return_type(ft::LLVMType) = LLVMType(API.LLVMGetReturnType(ft.handle))

function parameters(ft::LLVMType)
    nparams = API.LLVMCountParamTypes(ft.handle)
    params = Vector{API.LLVMTypeRef}(nparams)
    API.LLVMGetParamTypes(ft.handle, params)
    return map(t->LLVMType(t), params)
end


## sequential types

export addrspace

import Base: length, size, eltype

function PointerType(eltyp::LLVMType, addrspace=0)
    return LLVMType(API.LLVMPointerType(eltyp.handle, Cuint(addrspace)))
end

addrspace(ptrtyp::LLVMType) = API.LLVMGetPointerAddressSpace(ptrtyp.handle)

function ArrayType(eltyp::LLVMType, count)
    return LLVMType(API.LLVMArrayType(eltyp.handle, Cuint(count)))
end

length(arrtyp::LLVMType) = API.LLVMGetArrayLength(arrtyp.handle)

function VectorType(eltyp::LLVMType, count)
    return LLVMType(API.LLVMVectorType(eltyp.handle, Cuint(count)))
end

size(vectyp::LLVMType) = API.LLVMGetVectorSize(vectyp.handle)

eltype(typ::LLVMType) = LLVMType(API.LLVMGetElementType(typ.handle))


## structure types

export name, ispacked, isopaque, elements, elements!

function StructType(name::String, ctx::Context=GlobalContext())
    return LLVMType(API.LLVMStructCreateNamed(ctx.handle, name))
end

function StructType(elems::Vector{LLVMType}, ctx::Context=GlobalContext(), packed::Bool=false)
    _elems = map(t->t.handle, elems)

    return LLVMType(API.LLVMStructTypeInContext(ctx.handle, _elems, Cuint(length(_elems)),
                                                API.LLVMBool(packed)))
end

name(structtyp::LLVMType) = unsafe_string(API.LLVMGetStructName(structtyp.handle))
ispacked(structtyp::LLVMType) = API.LLVMIsPackedStruct(structtyp.handle) == API.LLVMBool(1)
isopaque(structtyp::LLVMType) = API.LLVMIsOpaqueStruct(structtyp.handle) == API.LLVMBool(1)

function elements(structtyp::LLVMType)
    nelems = API.LLVMCountStructElementTypes(structtyp.handle)
    elems = Vector{API.LLVMTypeRef}(nelems)
    API.LLVMGetStructElementTypes(structtyp.handle, elems)
    return map(t->LLVMType(t), elems)
end

function elements!(structtyp::LLVMType, elems::Vector{LLVMType}, packed::Bool=false)
    _elems = map(t->t.handle, elems)

    API.LLVMStructSetBody(structtyp.handle, _elems, Cuint(length(_elems)), API.LLVMBool(packed))
end
