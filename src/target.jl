## target

export Target,
       name, description,
       hasjit, hastargetmachine, hasasmparser

@reftypedef ref=LLVMTargetRef immutable Target end

function Target(triple::String)
    out_ref = Ref{API.LLVMTargetRef}()
    out_error = Ref{Cstring}()
    status = BoolFromLLVM(API.LLVMGetTargetFromTriple(triple, out_ref, out_error))

    if status
        error = unsafe_string(out_error[])
        API.LLVMDisposeMessage(out_error[])
        throw(LLVMException(error))
    end

    return Target(out_ref[])
end

name(t::Target) = unsafe_string(API.LLVMGetTargetName(ref(t)))

description(t::Target) = unsafe_string(API.LLVMGetTargetDescription(ref(t)))

hasjit(t::Target) = BoolFromLLVM(API.LLVMTargetHasJIT(ref(t)))
hastargetmachine(t::Target) = BoolFromLLVM(API.LLVMTargetHasTargetMachine(ref(t)))
hasasmparser(t::Target) = BoolFromLLVM(API.LLVMTargetHasAsmBackend(ref(t)))

# target iteration

export targets

immutable TargetSet end

targets() = TargetSet()

eltype(::TargetSet) = Target

function haskey(::TargetSet, name::String)
    return API.LLVMGetTargetFromName(name) != C_NULL
end

function get(::TargetSet, name::String)
    objref = API.LLVMGetTargetFromName(name)
    objref == C_NULL && throw(KeyError(name))
    return Target(objref)
end

start(::TargetSet) = API.LLVMGetFirstTarget()

next(::TargetSet, state) =
    (Target(state), API.LLVMGetNextTarget(state))

done(::TargetSet, state) = state == C_NULL

# NOTE: this is expensive, but the iteration interface requires it to be implemented
function length(iter::TargetSet)
    count = 0
    for _ in iter
        count += 1
    end
    count
end

# NOTE: `length` is iterating, so avoid `collect` calling it
function collect(iter::TargetSet)
    vals = Vector{eltype(iter)}()
    for val in iter
        push!(vals, val)
    end
    vals
end


## target machine

export TargetMachine, dispose,
       target, triple, cpu, features, asm_verbosity!,
       emit, populate!

@reftypedef ref=LLVMTargetMachineRef immutable TargetMachine end

TargetMachine(t::Target, triple::String, cpu::String, features::String,
              optlevel::API.LLVMCodeGenOptLevel, reloc::API.LLVMRelocMode,
              code::API.LLVMCodeModel) =
    TargetMachine(API.LLVMCreateTargetMachine(ref(t), triple, cpu, features, optlevel,
                                              reloc, code))

dispose(tm::TargetMachine) = API.LLVMDisposeTargetMachine(ref(tm))

function TargetMachine(f::Core.Function, args...)
    tm = TargetMachine(args...)
    try
        f(tm)
    finally
        dispose(tm)
    end
end

target(tm::TargetMachine) = Target(API.LLVMGetTargetMachineTarget(ref(tm)))
triple(tm::TargetMachine) = unsafe_string(API.LLVMGetTargetMachineTriple(ref(tm)))
triple() = unsafe_string(API.LLVMGetDefaultTargetTriple())
cpu(tm::TargetMachine) = unsafe_string(API.LLVMGetTargetMachineCPU(ref(tm)))
features(tm::TargetMachine) = unsafe_string(API.LLVMGetTargetMachineFeatureString(ref(tm)))

asm_verbosity!(tm::TargetMachine, verbose::Bool) =
    API.LLVMSetTargetMachineAsmVerbosity(ref(tm), BoolToLLVM(verbose))

function emit(tm::TargetMachine, mod::Module, filetype::API.LLVMCodeGenFileType)
    out_error = Ref{Cstring}()
    out_membuf = Ref{API.LLVMMemoryBufferRef}()
    status = BoolFromLLVM(
        API.LLVMTargetMachineEmitToMemoryBuffer(ref(tm), ref(mod), filetype,
                                                out_error, out_membuf))

    if status
        error = unsafe_string(out_error[])
        API.LLVMDisposeMessage(out_error[])
        throw(LLVMException(error))
    end

    return convert(Vector{UInt8}, MemoryBuffer(out_membuf[]))
end

function emit(tm::TargetMachine, mod::Module, filetype::API.LLVMCodeGenFileType, path::String)
    out_error = Ref{Cstring}()
    status = BoolFromLLVM(
        API.LLVMTargetMachineEmitToFile(ref(tm), ref(mod), path, filetype, out_error))

    if status
        error = unsafe_string(out_error[])
        API.LLVMDisposeMessage(out_error[])
        throw(LLVMException(error))
    end

    return nothing
end

populate!(pm::PassManager, tm::TargetMachine) = API.LLVMAddAnalysisPasses(ref(tm), ref(pm))


## target data

export TargetData, dispose,
       byteorder, pointersize, intptr,
       sizeof, storage_size, abi_size,
       abi_alignment, frame_alignment, preferred_alignment,
       element_at, offsetof

import Base: convert, sizeof

@reftypedef ref=LLVMTargetDataRef immutable TargetData end

TargetData(rep::String) = TargetData(API.LLVMCreateTargetData(rep))

TargetData(tm::TargetMachine) = TargetData(API.LLVMCreateTargetDataLayout(ref(tm)))

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
