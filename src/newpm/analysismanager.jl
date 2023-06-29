abstract type AnalysisManager end

struct ModuleAnalysisManager <: AnalysisManager end
struct CGSCCAnalysisManager <: AnalysisManager end
struct FunctionAnalysisManager <: AnalysisManager end
struct LoopAnalysisManager <: AnalysisManager end
struct AAManager end

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