export TargetData, dispose, add!, convert,
       byteorder, pointersize, intptr,
       sizeof, storage_size, abi_size,
       abi_alignment, frame_alignment, preferred_alignment,
       element_at, offsetof

import Base: convert, sizeof

@reftypedef ref=LLVMTargetDataRef immutable TargetData end

TargetData(rep::String) = TargetData(API.LLVMCreateTargetData(rep))

function TargetData(f::Core.Function, args...)
    data = TargetData(args...)
    try
        f(data)
    finally
        dispose(data)
    end
end

dispose(data::TargetData) = API.LLVMDisposeTargetData(ref(data))

convert(::Type{String}, data::TargetData) =
    unsafe_string(API.LLVMCopyStringRepOfTargetData(ref(data)))

byteorder(data::TargetData) = API.LLVMByteOrder(ref(data))

pointersize(data::TargetData) = API.LLVMPointerSize(ref(data))
pointersize(data::TargetData, addrspace::Integer) =
    API.LLVMPointerSizeForAS(ref(data), Cuint(addrspace))

intptr(data::TargetData) = construct(IntegerType, API.LLVMIntPtrType(ref(data)))
intptr(data::TargetData, addrspace::Integer) =
    construct(IntegerType, API.LLVMIntPtrTypeForAS(ref(data), Cuint(addrspace)))
intptr(data::TargetData, ctx::Context) =
    construct(IntegerType, API.LLVMIntPtrTypeInContext(ref(ctx), ref(data)))
intptr(data::TargetData, addrspace::Integer, ctx::Context) =
    construct(IntegerType, API.LLVMIntPtrTypeForASInContext(ref(ctx), ref(data),
                                                            Cuint(addrspace)))

sizeof(data::TargetData, typ::LLVMType) =
    Cuint(API.LLVMSizeOfTypeInBits(ref(data), ref(typ)) / 8)
storage_size(data::TargetData, typ::LLVMType) = API.LLVMStoreSizeOfType(ref(data), ref(typ))
abi_size(data::TargetData, typ::LLVMType) = API.LLVMABISizeOfType(ref(data), ref(typ))

abi_alignment(data::TargetData, typ::LLVMType) =
    API.LLVMABIAlignmentOfType(ref(data), ref(typ))
frame_alignment(data::TargetData, typ::LLVMType) =
    API.LLVMCallFrameAlignmentOfType(ref(data), ref(typ))
preferred_alignment(data::TargetData, typ::LLVMType) =
    API.LLVMPreferredAlignmentOfType(ref(data), ref(typ))
preferred_alignment(data::TargetData, var::GlobalVariable) = 
    API.LLVMPreferredAlignmentOfGlobal(ref(data), ref(var))

element_at(data::TargetData, typ::StructType, offset::Integer) =
    API.LLVMElementAtOffset(ref(data), ref(typ), Culonglong(offset))

offsetof(data::TargetData, typ::StructType, element::Integer) =
    API.LLVMOffsetOfElement(ref(data), ref(typ), Cuint(element))
