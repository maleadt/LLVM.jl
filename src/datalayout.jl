## data layout

export DataLayout, dispose,
       byteorder, pointersize, intptr,
       sizeof, storage_size, abi_size,
       abi_alignment, frame_alignment, preferred_alignment,
       element_at, offsetof

"""
    DataLayout

A parsed version of the target data layout string in and methods for querying it.

The target data layout string is specified by the target - a frontend generating LLVM IR is
required to generate the right target data for the target being codegen'd to.
"""
DataLayout
# forward definition of DataLayout in src/module.jl

Base.unsafe_convert(::Type{API.LLVMTargetDataRef}, dl::DataLayout) = mark_use(dl).ref

"""
    DataLayout(rep::String)

Create a target data layout from the given string representation.

This object needs to be disposed of using [`dispose`](@ref).
"""
DataLayout(rep::String) = mark_alloc(DataLayout(API.LLVMCreateTargetData(rep)))

"""
    DataLayout(tm::TargetMachine)

Create a target data layout from the given target machine.

This object needs to be disposed of using [`dispose`](@ref).
"""
DataLayout(tm::TargetMachine) = mark_alloc(DataLayout(API.LLVMCreateTargetDataLayout(tm)))

"""
    dispose(data::DataLayout)

Dispose of the given target data layout.
"""
dispose(data::DataLayout) = mark_dispose(API.LLVMDisposeTargetData, data)

function DataLayout(f::Core.Function, args...; kwargs...)
    data = DataLayout(args...; kwargs...)
    try
        f(data)
    finally
        dispose(data)
    end
end

Base.string(data::DataLayout) =
    unsafe_message(API.LLVMCopyStringRepOfTargetData(data))

function Base.show(io::IO, data::DataLayout)
    @printf(io, "DataLayout(%s)", string(data))
end

"""
    byteorder(data::DataLayout)

Get the byte order of the target data layout.
"""
byteorder(data::DataLayout) = API.LLVMByteOrder(data)

"""
    pointersize(data::DataLayout, [addrspace::Integer])

Get the pointer size of the target data layout.
"""
pointersize(data::DataLayout, addrspace::Integer=0) =
    API.LLVMPointerSizeForAS(data, addrspace)

"""
    intptr(data::DataLayout, [addrspace::Integer])

Get the integer type that is the same size as a pointer for the target data layout.
"""
intptr(data::DataLayout, addrspace::Integer=0) =
    IntegerType(API.LLVMIntPtrTypeForASInContext(context(), data, addrspace))

"""
    sizeof(data::DataLayout, typ::LLVMType)

Get the size of the given type in bytes for the target data layout.
"""
Base.sizeof(data::DataLayout, typ::LLVMType) = Int(API.LLVMSizeOfTypeInBits(data, typ) / 8)

"""
    storage_size(data::DataLayout, typ::LLVMType)

Get the storage size of the given type in bytes for the target data layout.
"""
storage_size(data::DataLayout, typ::LLVMType) = API.LLVMStoreSizeOfType(data, typ)

"""
    abi_size(data::DataLayout, typ::LLVMType)

Get the ABI size of the given type in bytes for the target data layout.
"""
abi_size(data::DataLayout, typ::LLVMType) = API.LLVMABISizeOfType(data, typ)

"""
    abi_alignment(data::DataLayout, typ::LLVMType)

Get the ABI alignment of the given type in bytes for the target data layout.
"""
abi_alignment(data::DataLayout, typ::LLVMType) =
    API.LLVMABIAlignmentOfType(data, typ)

"""
    frame_alignment(data::DataLayout, typ::LLVMType)

Get the call frame alignment of the given type in bytes for the target data layout.
"""
frame_alignment(data::DataLayout, typ::LLVMType) =
    API.LLVMCallFrameAlignmentOfType(data, typ)


"""
    preferred_alignment(data::DataLayout, typ::LLVMType)
    preferred_alignment(data::DataLayout, var::GlobalVariable)

Get the preferred alignment of the given type or global variable in bytes for the target
data layout.
"""
preferred_alignment(::DataLayout, ::Union{LLVMType, GlobalVariable})

preferred_alignment(data::DataLayout, typ::LLVMType) =
    API.LLVMPreferredAlignmentOfType(data, typ)
preferred_alignment(data::DataLayout, var::GlobalVariable) =
    API.LLVMPreferredAlignmentOfGlobal(data, var)

"""
    element_at(data::DataLayout, typ::StructType, offset::Integer)

Get the element at the given offset in a struct type for the target data layout.

See also: [`offsetof`](@ref).
"""
element_at(data::DataLayout, typ::StructType, offset::Integer) =
    API.LLVMElementAtOffset(data, typ, Culonglong(offset))

"""
    offsetof(data::DataLayout, typ::StructType, element::Integer)

Get the offset of the given element in a struct type for the target data layout.

See also: [`element_at`](@ref).
"""
offsetof(data::DataLayout, typ::StructType, element::Integer) =
    API.LLVMOffsetOfElement(data, typ, element)
