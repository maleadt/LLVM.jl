## data layout

export DataLayout, dispose,
       byteorder, pointersize, intptr,
       sizeof, storage_size, abi_size,
       abi_alignment, frame_alignment, preferred_alignment,
       element_at, offsetof

# forward definition of DataLayout in src/module.jl

Base.unsafe_convert(::Type{API.LLVMTargetDataRef}, dl::DataLayout) = mark_use(dl).ref

DataLayout(rep::String) = mark_alloc(DataLayout(API.LLVMCreateTargetData(rep)))

DataLayout(tm::TargetMachine) = mark_alloc(DataLayout(API.LLVMCreateTargetDataLayout(tm)))

function DataLayout(f::Core.Function, args...; kwargs...)
    data = DataLayout(args...; kwargs...)
    try
        f(data)
    finally
        dispose(data)
    end
end

dispose(data::DataLayout) = mark_dispose(API.LLVMDisposeTargetData, data)

Base.string(data::DataLayout) =
    unsafe_message(API.LLVMCopyStringRepOfTargetData(data))

function Base.show(io::IO, data::DataLayout)
    @printf(io, "DataLayout(%s)", string(data))
end

byteorder(data::DataLayout) = API.LLVMByteOrder(data)

pointersize(data::DataLayout) = API.LLVMPointerSize(data)
pointersize(data::DataLayout, addrspace::Integer) =
    API.LLVMPointerSizeForAS(data, addrspace)

intptr(data::DataLayout) =
    IntegerType(API.LLVMIntPtrTypeInContext(context(), data))
intptr(data::DataLayout, addrspace::Integer) =
    IntegerType(API.LLVMIntPtrTypeForASInContext(context(), data, addrspace))

Base.sizeof(data::DataLayout, typ::LLVMType) =
    Int(API.LLVMSizeOfTypeInBits(data, typ) / 8)
storage_size(data::DataLayout, typ::LLVMType) = API.LLVMStoreSizeOfType(data, typ)
abi_size(data::DataLayout, typ::LLVMType) = API.LLVMABISizeOfType(data, typ)

abi_alignment(data::DataLayout, typ::LLVMType) =
    API.LLVMABIAlignmentOfType(data, typ)
frame_alignment(data::DataLayout, typ::LLVMType) =
    API.LLVMCallFrameAlignmentOfType(data, typ)
preferred_alignment(data::DataLayout, typ::LLVMType) =
    API.LLVMPreferredAlignmentOfType(data, typ)
preferred_alignment(data::DataLayout, var::GlobalVariable) =
    API.LLVMPreferredAlignmentOfGlobal(data, var)

element_at(data::DataLayout, typ::StructType, offset::Integer) =
    API.LLVMElementAtOffset(data, typ, Culonglong(offset))

offsetof(data::DataLayout, typ::StructType, element::Integer) =
    API.LLVMOffsetOfElement(data, typ, element)
