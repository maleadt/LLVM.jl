## data layout

export DataLayout, dispose,
       byteorder, pointersize, intptr,
       sizeof, storage_size, abi_size,
       abi_alignment, frame_alignment, preferred_alignment,
       element_at, offsetof

import Base: convert, show, sizeof

# forward definition of DataLayout in src/module.jl
reftype(::Type{DataLayout}) = API.LLVMTargetDataRef

DataLayout(rep::String) = DataLayout(API.LLVMCreateTargetData(rep))

DataLayout(tm::TargetMachine) = DataLayout(API.LLVMCreateTargetDataLayout(ref(tm)))

function DataLayout(f::Core.Function, args...)
    data = DataLayout(args...)
    try
        f(data)
    finally
        dispose(data)
    end
end

dispose(data::DataLayout) = API.LLVMDisposeTargetData(ref(data))

convert(::Type{String}, data::DataLayout) =
    unsafe_string(API.LLVMCopyStringRepOfTargetData(ref(data)))

function show(io::IO, data::DataLayout)
    @printf(io, "DataLayout(%s)", convert(String, data))
end

byteorder(data::DataLayout) = API.LLVMByteOrder(ref(data))

pointersize(data::DataLayout) = API.LLVMPointerSize(ref(data))
pointersize(data::DataLayout, addrspace::Integer) =
    API.LLVMPointerSizeForAS(ref(data), Cuint(addrspace))

intptr(data::DataLayout) = IntegerType(API.LLVMIntPtrType(ref(data)))
intptr(data::DataLayout, addrspace::Integer) =
    IntegerType(API.LLVMIntPtrTypeForAS(ref(data), Cuint(addrspace)))
intptr(data::DataLayout, ctx::Context) =
    IntegerType(API.LLVMIntPtrTypeInContext(ref(ctx), ref(data)))
intptr(data::DataLayout, addrspace::Integer, ctx::Context) =
    IntegerType(API.LLVMIntPtrTypeForASInContext(ref(ctx), ref(data),
                                                            Cuint(addrspace)))

sizeof(data::DataLayout, typ::LLVMType) =
    Cuint(API.LLVMSizeOfTypeInBits(ref(data), ref(typ)) / 8)
storage_size(data::DataLayout, typ::LLVMType) = API.LLVMStoreSizeOfType(ref(data), ref(typ))
abi_size(data::DataLayout, typ::LLVMType) = API.LLVMABISizeOfType(ref(data), ref(typ))

abi_alignment(data::DataLayout, typ::LLVMType) =
    API.LLVMABIAlignmentOfType(ref(data), ref(typ))
frame_alignment(data::DataLayout, typ::LLVMType) =
    API.LLVMCallFrameAlignmentOfType(ref(data), ref(typ))
preferred_alignment(data::DataLayout, typ::LLVMType) =
    API.LLVMPreferredAlignmentOfType(ref(data), ref(typ))
preferred_alignment(data::DataLayout, var::GlobalVariable) = 
    API.LLVMPreferredAlignmentOfGlobal(ref(data), ref(var))

element_at(data::DataLayout, typ::StructType, offset::Integer) =
    API.LLVMElementAtOffset(ref(data), ref(typ), Culonglong(offset))

offsetof(data::DataLayout, typ::StructType, element::Integer) =
    API.LLVMOffsetOfElement(ref(data), ref(typ), Cuint(element))
