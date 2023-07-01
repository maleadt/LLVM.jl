export AnalysisManager, ModuleAnalysisManager, CGSCCAnalysisManager, FunctionAnalysisManager, LoopAnalysisManager, AAManager

export dispose, add!

abstract type AnalysisManager end

@checked struct ModuleAnalysisManager <: AnalysisManager
    ref::API.LLVMModuleAnalysisManagerRef
    roots::Vector{Any}
end
@checked struct CGSCCAnalysisManager <: AnalysisManager
    ref::API.LLVMCGSCCAnalysisManagerRef
    roots::Vector{Any}
end
mutable struct AAManager
    aas::Vector{String}
    tm::Union{Nothing,TargetMachine}
end
@checked mutable struct FunctionAnalysisManager <: AnalysisManager
    ref::API.LLVMFunctionAnalysisManagerRef
    aa::Union{Nothing,AAManager}
    roots::Vector{Any}
end
@checked struct LoopAnalysisManager <: AnalysisManager
    ref::API.LLVMLoopAnalysisManagerRef
    roots::Vector{Any}
end

Base.unsafe_convert(::Type{API.LLVMModuleAnalysisManagerRef}, am::ModuleAnalysisManager) = am.ref
Base.unsafe_convert(::Type{API.LLVMCGSCCAnalysisManagerRef}, am::CGSCCAnalysisManager) = am.ref
Base.unsafe_convert(::Type{API.LLVMFunctionAnalysisManagerRef}, am::FunctionAnalysisManager) = am.ref
Base.unsafe_convert(::Type{API.LLVMLoopAnalysisManagerRef}, am::LoopAnalysisManager) = am.ref

ModuleAnalysisManager() = ModuleAnalysisManager(API.LLVMCreateNewPMModuleAnalysisManager(), [])
CGSCCAnalysisManager() = CGSCCAnalysisManager(API.LLVMCreateNewPMCGSCCAnalysisManager(), [])
FunctionAnalysisManager() = FunctionAnalysisManager(API.LLVMCreateNewPMFunctionAnalysisManager(), nothing, [])
LoopAnalysisManager() = LoopAnalysisManager(API.LLVMCreateNewPMLoopAnalysisManager(), [])
AAManager() = AAManager([], nothing)

dispose(mam::ModuleAnalysisManager) = API.LLVMDisposeNewPMModuleAnalysisManager(mam)
dispose(cgmam::CGSCCAnalysisManager) = API.LLVMDisposeNewPMCGSCCAnalysisManager(cgmam)
dispose(fam::FunctionAnalysisManager) = API.LLVMDisposeNewPMFunctionAnalysisManager(fam)
dispose(lam::LoopAnalysisManager) = API.LLVMDisposeNewPMLoopAnalysisManager(lam)

function ModuleAnalysisManager(f::Core.Function, args...; kwargs...)
    am = ModuleAnalysisManager(args...; kwargs...)
    try
        f(am)
    finally
        dispose(am)
    end
end
function CGSCCAnalysisManager(f::Core.Function, args...; kwargs...)
    am = CGSCCAnalysisManager(args...; kwargs...)
    try
        f(am)
    finally
        dispose(am)
    end
end
function FunctionAnalysisManager(f::Core.Function, args...; kwargs...)
    am = FunctionAnalysisManager(args...; kwargs...)
    try
        f(am)
    finally
        dispose(am)
    end
end
function LoopAnalysisManager(f::Core.Function, args...; kwargs...)
    am = LoopAnalysisManager(args...; kwargs...)
    try
        f(am)
    finally
        dispose(am)
    end
end

function add!(fam::FunctionAnalysisManager, aa::AAManager)
    if isnothing(fam.aa)
        fam.aa = aa
        return true
    else
        return false
    end
end

function add!(f::Core.Function, fam::FunctionAnalysisManager, ::Type{AAManager})
    if !isnothing(fam.aa)
        return false
    end
    aa = AAManager()
    f(aa)
    add!(fam, aa)
    return true
end
