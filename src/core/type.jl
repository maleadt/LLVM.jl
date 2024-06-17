export LLVMType, issized, context, show

# subtypes are expected to have a 'ref::API.LLVMTypeRef' field
abstract type LLVMType end

Base.eltype(typ::LLVMType) = Any
Base.sizeof(typ::LLVMType) = error("LLVM types are not sized")
# TODO: expose LLVMSizeOf/LLVMAlignOf, yielding run-time values?
# XXX: can we query type sizes from the data layout or target?

Base.unsafe_convert(::Type{API.LLVMTypeRef}, typ::LLVMType) = typ.ref

const type_kinds = Vector{Type}(fill(Nothing, typemax(API.LLVMTypeKind)+1))
function identify(::Type{LLVMType}, ref::API.LLVMTypeRef)
    kind = API.LLVMGetTypeKind(ref)
    typ = @inbounds type_kinds[kind+1]
    typ === Nothing && error("Unknown type kind $kind")
    return typ
end
function register(T::Type{<:LLVMType}, kind::API.LLVMTypeKind)
    type_kinds[kind+1] = T
end

function refcheck(::Type{T}, ref::API.LLVMTypeRef) where T<:LLVMType
    ref==C_NULL && throw(UndefRefError())
    if typecheck_enabled
        T′ = identify(LLVMType, ref)
        if T != T′
            error("invalid conversion of $T′ type reference to $T")
        end
    end
end

# Construct a concretely typed type object from an abstract type ref
function LLVMType(ref::API.LLVMTypeRef)
    ref == C_NULL && throw(UndefRefError())
    T = identify(LLVMType, ref)
    return T(ref)::LLVMType
end

issized(typ::LLVMType) = API.LLVMTypeIsSized(typ) |> Bool
context(typ::LLVMType) = Context(API.LLVMGetTypeContext(typ))

Base.string(typ::LLVMType) = unsafe_message(API.LLVMPrintTypeToString(typ))

function Base.show(io::IO, ::MIME"text/plain", typ::LLVMType)
    print(io, string(typ))
end

function Base.show(io::IO, typ::LLVMType)
    print(io, typeof(typ), "(", string(typ), ")")
end

Base.isempty(@nospecialize(T::LLVMType)) = false


## integer

export width

@checked struct IntegerType <: LLVMType
    ref::API.LLVMTypeRef
end
register(IntegerType, API.LLVMIntegerTypeKind)

for T in [:Int1, :Int8, :Int16, :Int32, :Int64, :Int128]
    jl_fname = Symbol(T, :Type)
    api_fname = Symbol(:LLVM, jl_fname)
    @eval begin
        $jl_fname() =
            IntegerType(API.$(Symbol(api_fname, :InContext))(context()))
    end
end

IntType(bits::Integer) =
    IntegerType(API.LLVMIntTypeInContext(context(), bits))

width(inttyp::IntegerType) = API.LLVMGetIntTypeWidth(inttyp)


## floating-point

# NOTE: this type doesn't exist in the LLVM API,
#       we add it for convenience of typechecking generic values (see execution.jl)
 abstract type FloatingPointType <: LLVMType end

for T in [:Half, :Float, :Double, :BFloat, :FP128, :X86_FP80, :PPC_FP128]
    CleanT = Symbol(replace(String(T), "_"=>""))    # only the type kind retains the underscore
    jl_fname = Symbol(CleanT, :Type)
    api_typename = Symbol(:LLVM, CleanT)
    api_fname = Symbol(:LLVM, jl_fname)
    enumkind = Symbol(:LLVM, T, :TypeKind)
    @eval begin
        @checked struct $api_typename <: FloatingPointType
            ref::API.LLVMTypeRef
        end
        register($api_typename, API.$enumkind)

        $jl_fname() =
            $api_typename(API.$(Symbol(api_fname, :InContext))(context()))
    end
end


## function types

export isvararg, return_type, parameters

@checked struct FunctionType <: LLVMType
    ref::API.LLVMTypeRef
end
register(FunctionType, API.LLVMFunctionTypeKind)

FunctionType(rettyp::LLVMType, params::Vector{<:LLVMType}=LLVMType[];
             vararg::Bool=false) =
    FunctionType(API.LLVMFunctionType(rettyp, params,
                                      length(params), vararg))

isvararg(ft::FunctionType) = API.LLVMIsFunctionVarArg(ft) |> Bool

return_type(ft::FunctionType) =
    LLVMType(API.LLVMGetReturnType(ft))

function parameters(ft::FunctionType)
    nparams = API.LLVMCountParamTypes(ft)
    params = Vector{API.LLVMTypeRef}(undef, nparams)
    API.LLVMGetParamTypes(ft, params)
    return LLVMType[LLVMType(param) for param in params]
end



## composite types

abstract type CompositeType <: LLVMType end


## sequential types

export addrspace, is_opaque

abstract type SequentialType <: CompositeType end

Base.eltype(typ::SequentialType) = LLVMType(API.LLVMGetElementType(typ))


@checked struct PointerType <: SequentialType
    ref::API.LLVMTypeRef
end
register(PointerType, API.LLVMPointerTypeKind)

function PointerType(eltyp::LLVMType, addrspace=0)
    return PointerType(API.LLVMPointerType(eltyp, addrspace))
end

function PointerType(addrspace=0)
    return PointerType(API.LLVMPointerTypeInContext(context(), addrspace))
end

if version() >= v"13"
    is_opaque(ptrtyp::PointerType) = API.LLVMPointerTypeIsOpaque(ptrtyp) |> Bool

    function Base.eltype(typ::PointerType)
        is_opaque(typ) && throw(error("Taking the type of an opaque pointer is illegal"))
        invoke(eltype, Tuple{SequentialType}, typ)
    end
else
    is_opaque(ptrtyp::PointerType) = false
end

addrspace(ptrtyp::PointerType) =
    API.LLVMGetPointerAddressSpace(ptrtyp)

@checked struct ArrayType <: SequentialType
    ref::API.LLVMTypeRef
end
register(ArrayType, API.LLVMArrayTypeKind)

function ArrayType(eltyp::LLVMType, count)
    return ArrayType(API.LLVMArrayType(eltyp, count))
end

Base.length(arrtyp::ArrayType) = Int(API.LLVMGetArrayLength(arrtyp))

Base.isempty(@nospecialize(T::ArrayType)) = length(T) == 0 || isempty(eltype(T))


@checked struct VectorType <: SequentialType
    ref::API.LLVMTypeRef
end
register(VectorType, API.LLVMVectorTypeKind)

function VectorType(eltyp::LLVMType, count)
    return VectorType(API.LLVMVectorType(eltyp, count))
end

Base.size(vectyp::VectorType) = API.LLVMGetVectorSize(vectyp)


## structure types

export name, ispacked, isopaque, elements!

@checked struct StructType <: SequentialType
    ref::API.LLVMTypeRef
end
register(StructType, API.LLVMStructTypeKind)

function StructType(name::String)
    return StructType(API.LLVMStructCreateNamed(context(), name))
end

StructType(elems::Vector{<:LLVMType}; packed::Bool=false) =
    StructType(API.LLVMStructTypeInContext(context(), elems, length(elems), packed))

function name(structtyp::StructType)
    cstr = API.LLVMGetStructName(structtyp)
    cstr == C_NULL ? nothing : unsafe_string(cstr)
end
ispacked(structtyp::StructType) = API.LLVMIsPackedStruct(structtyp) |> Bool
isopaque(structtyp::StructType) = API.LLVMIsOpaqueStruct(structtyp) |> Bool

elements!(structtyp::StructType, elems::Vector{<:LLVMType}, packed::Bool=false) =
    API.LLVMStructSetBody(structtyp, elems, length(elems), packed)

Base.isempty(@nospecialize(T::StructType)) =
    isempty(elements(T)) || all(isempty, elements(T))

# element iteration

export elements

struct StructTypeElementSet
    typ::StructType
end

elements(typ::StructType) = StructTypeElementSet(typ)

Base.eltype(::StructTypeElementSet) = LLVMType

function Base.getindex(iter::StructTypeElementSet, i)
    @boundscheck 1 <= i <= length(iter) || throw(BoundsError(iter, i))
    return LLVMType(API.LLVMStructGetTypeAtIndex(iter.typ, i-1))
end

function Base.iterate(iter::StructTypeElementSet, i=1)
    i >= length(iter) + 1 ? nothing : (iter[i], i+1)
end

Base.length(iter::StructTypeElementSet) = API.LLVMCountStructElementTypes(iter.typ)

Base.lastindex(iter::StructTypeElementSet) = length(iter)

# NOTE: optimized `collect`
function Base.collect(iter::StructTypeElementSet)
    elems = Vector{API.LLVMTypeRef}(undef, length(iter))
    API.LLVMGetStructElementTypes(iter.typ, elems)
    return LLVMType[LLVMType(elem) for elem in elems]
end


## other

@checked struct VoidType <: LLVMType
    ref::API.LLVMTypeRef
end
register(VoidType, API.LLVMVoidTypeKind)

VoidType() = VoidType(API.LLVMVoidTypeInContext(context()))

@checked struct LabelType <: LLVMType
    ref::API.LLVMTypeRef
end
register(LabelType, API.LLVMLabelTypeKind)

LabelType() = LabelType(API.LLVMLabelTypeInContext(context()))

@checked struct MetadataType <: LLVMType
    ref::API.LLVMTypeRef
end
register(MetadataType, API.LLVMMetadataTypeKind)

MetadataType() = MetadataType(API.LLVMMetadataTypeInContext(context()))

@checked struct TokenType <: LLVMType
    ref::API.LLVMTypeRef
end
register(TokenType, API.LLVMTokenTypeKind)

TokenType() = TokenType(API.LLVMTokenTypeInContext(context()))


## type iteration

export types

struct ContextTypeDict <: AbstractDict{String,LLVMType}
    ctx::Context
end

types(ctx::Context) = ContextTypeDict(ctx)

function Base.haskey(iter::ContextTypeDict, name::String)
    @static if version() >= v"12"
        API.LLVMGetTypeByName2(iter.ctx, name) != C_NULL
    else
        context!(iter.ctx) do
            @dispose mod=Module("dummy") begin
                API.LLVMGetTypeByName(mod, name) != C_NULL
            end
        end
    end
end

function Base.getindex(iter::ContextTypeDict, name::String)
    objref = @static if version() >= v"12"
        API.LLVMGetTypeByName2(iter.ctx, name)
    else
        context!(iter.ctx) do
            @dispose mod=Module("dummy") begin
                API.LLVMGetTypeByName(mod, name)
            end
        end
    end
    objref == C_NULL && throw(KeyError(name))
    return LLVMType(objref)
end
