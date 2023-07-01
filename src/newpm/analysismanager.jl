export AnalysisManager, ModuleAnalysisManager, CGSCCAnalysisManager, FunctionAnalysisManager, LoopAnalysisManager, AAManager

export dispose, analysis_managers

abstract type AnalysisManager end

@checked struct ModuleAnalysisManager <: AnalysisManager
    ref::API.LLVMModuleAnalysisManagerRef
    roots::Vector{Any}
end
@checked struct CGSCCAnalysisManager <: AnalysisManager
    ref::API.LLVMCGSCCAnalysisManagerRef
    roots::Vector{Any}
end
@checked struct FunctionAnalysisManager <: AnalysisManager
    ref::API.LLVMFunctionAnalysisManagerRef
    roots::Vector{Any}
end
@checked struct LoopAnalysisManager <: AnalysisManager
    ref::API.LLVMLoopAnalysisManagerRef
    roots::Vector{Any}
end
@checked struct AAManager
    ref::API.LLVMAAManagerRef
    roots::Vector{Any}
end

Base.unsafe_convert(::Type{API.LLVMModuleAnalysisManagerRef}, am::ModuleAnalysisManager) = am.ref
Base.unsafe_convert(::Type{API.LLVMCGSCCAnalysisManagerRef}, am::CGSCCAnalysisManager) = am.ref
Base.unsafe_convert(::Type{API.LLVMFunctionAnalysisManagerRef}, am::FunctionAnalysisManager) = am.ref
Base.unsafe_convert(::Type{API.LLVMLoopAnalysisManagerRef}, am::LoopAnalysisManager) = am.ref
Base.unsafe_convert(::Type{API.LLVMAAManagerRef}, am::AAManager) = am.ref

ModuleAnalysisManager() = ModuleAnalysisManager(API.LLVMCreateNewPMModuleAnalysisManager(), [])
CGSCCAnalysisManager() = CGSCCAnalysisManager(API.LLVMCreateNewPMCGSCCAnalysisManager(), [])
FunctionAnalysisManager() = FunctionAnalysisManager(API.LLVMCreateNewPMFunctionAnalysisManager(), [])
LoopAnalysisManager() = LoopAnalysisManager(API.LLVMCreateNewPMLoopAnalysisManager(), [])
AAManager() = AAManager(API.LLVMCreateNewPMAAManager(), [])

dispose(mam::ModuleAnalysisManager) = API.LLVMDisposeNewPMModuleAnalysisManager(mam)
dispose(cgmam::CGSCCAnalysisManager) = API.LLVMDisposeNewPMCGSCCAnalysisManager(cgmam)
dispose(fam::FunctionAnalysisManager) = API.LLVMDisposeNewPMFunctionAnalysisManager(fam)
dispose(lam::LoopAnalysisManager) = API.LLVMDisposeNewPMLoopAnalysisManager(lam)
dispose(aam::AAManager) = API.LLVMDisposeNewPMAAManager(aam)

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
function AAManager(f::Core.Function, args...; kwargs...)
    am = AAManager(args...; kwargs...)
    try
        f(am)
    finally
        dispose(am)
    end
end

function analysis_managers(f::Core.Function)
    @dispose lam=LoopAnalysisManager() fam=FunctionAnalysisManager() cgam=CGSCCAnalysisManager() mam=ModuleAnalysisManager() begin
        f(lam, fam, cgam, mam)
    end
end
