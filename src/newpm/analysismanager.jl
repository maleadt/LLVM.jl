export AnalysisManager, ModuleAnalysisManager, CGSCCAnalysisManager, FunctionAnalysisManager, LoopAnalysisManager, AAManager

export dispose

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

ModuleAnalysisManager() = ModuleAnalysisManager(API.LLVMCreateModuleAnalysisManager(), [])
CGSCCAnalysisManager() = CGSCCAnalysisManager(API.LLVMCreateCGSCCAnalysisManager(), [])
FunctionAnalysisManager() = FunctionAnalysisManager(API.LLVMCreateFunctionAnalysisManager(), [])
LoopAnalysisManager() = LoopAnalysisManager(API.LLVMCreateLoopAnalysisManager(), [])
AAManager() = AAManager(API.LLVMCreateAAManager(), [])

dispose(mam::ModuleAnalysisManager) = API.LLVMDisposeModuleAnalysisManager(mam)
dispose(cgmam::CGSCCAnalysisManager) = API.LLVMDisposeCGSCCAnalysisManager(cgmam)
dispose(fam::FunctionAnalysisManager) = API.LLVMDisposeFunctionAnalysisManager(fam)
dispose(lam::LoopAnalysisManager) = API.LLVMDisposeLoopAnalysisManager(lam)
dispose(aam::AAManager) = API.LLVMDisposeAAManager(aam)

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
