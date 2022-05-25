@checked mutable struct LLJITBuilder
    ref::API.LLVMOrcLLJITBuilderRef
end
Base.unsafe_convert(::Type{API.LLVMOrcLLJITBuilderRef}, builder::LLJITBuilder) = builder.ref

function LLJITBuilder()
    ref = API.LLVMOrcCreateLLJITBuilder()
    builder = LLJITBuilder(ref)
    finalizer(unsafe_dispose!, builder)
end

function unsafe_dispose!(builder::LLJITBuilder)
    API.LLVMOrcDisposeLLJITBuilder(builder)
end

function targetmachinebuilder!(builder::LLJITBuilder, tmb::TargetMachineBuilder)
    API.LLVMOrcLLJITBuilderSetJITTargetMachineBuilder(builder, tmb)
end

function linkinglayercreator!(builder::LLJITBuilder, callback, ctx)
    API.LLVMOrcLLJITBuilderSetObjectLinkingLayerCreator(builder, callback, ctx)
end

@checked mutable struct LLJIT
    ref::API.LLVMOrcLLJITRef
end
Base.unsafe_convert(::Type{API.LLVMOrcLLJITRef}, lljit::LLJIT) = lljit.ref

"""
    LLJIT(::LLJITBuilder)

Creates a LLJIT stack based on the provided builder.

!!! note
    Takes ownership of the provided builder.
"""
function LLJIT(builder::LLJITBuilder)
    ref = Ref{API.LLVMOrcLLJITRef}()
    @check API.LLVMOrcCreateLLJIT(ref, builder)
    lljit = LLJIT(ref[])
    finalizer(unsafe_dispose!, lljit)
end

function unsafe_dispose!(lljit::LLJIT)
    API.LLVMOrcDisposeLLJIT(lljit)
end

"""
    LLJIT(;tm::Union{Nothing, TargetMachine})

Use the provided TargetMachine and construct an LLJIT from it.
"""
function LLJIT(; tm::Union{Nothing, TargetMachine} = nothing)
    builder = LLJITBuilder()
    if tm === nothing
        tmb = TargetMachineBuilder()
    else
        tmb = TargetMachineBuilder(tm)
    end
    targetmachinebuilder!(builder, tmb)
    LLJIT(builder)
end

function triple(lljit::LLJIT)
    cstr = API.LLVMOrcLLJITGetTripleString(lljit)
    Base.unsafe_string(cstr)
end

if version() < v"13"
function apply_datalayout!(lljit::LLJIT, mod::LLVM.Module)
    LLVM.API.LLVMOrcLLJITApplyDataLayout(lljit, mod)
end
else
function datalayout(lljit::LLJIT)
    Base.unsafe_string(API.LLVMOrcLLJITGetDataLayoutStr(lljit))
end
function apply_datalayout!(lljit::LLJIT, mod::LLVM.Module)
    datalayout!(mod, datalayout(lljit))
end
end

function get_prefix(lljit::LLJIT)
    return API.LLVMOrcLLJITGetGlobalPrefix(lljit)
end
