abstract type PassManager end

struct ModulePassManager <: PassManager end
struct CGSCCPassManager <: PassManager end
struct FunctionPassManager <: PassManager end
struct LoopPassManager <: PassManager end

function ModulePassManager(f::Core.Function, args...; kwargs...)
    am = ModulePassManager(args...; kwargs...)
    try
        f(am)
    finally
        dispose(am)
    end
end
function CGSCCPassManager(f::Core.Function, args...; kwargs...)
    am = CGSCCPassManager(args...; kwargs...)
    try
        f(am)
    finally
        dispose(am)
    end
end
function FunctionPassManager(f::Core.Function, args...; kwargs...)
    am = FunctionPassManager(args...; kwargs...)
    try
        f(am)
    finally
        dispose(am)
    end
end
function LoopPassManager(f::Core.Function, args...; kwargs...)
    am = LoopPassManager(args...; kwargs...)
    try
        f(am)
    finally
        dispose(am)
    end
end

function add!(f::Core.Function, pm::NewPMModulePassManager, ::Type{NewPMModulePassManager})
    pm2 = NewPMModulePassManager()
    try
        f(pm2)
        add!(pm, pm2)
    finally
        dispose(pm2)
    end
end

function add!(f::Core.Function, pm::NewPMCGSCCPassManager, ::Type{NewPMCGSCCPassManager})
    pm2 = NewPMCGSCCPassManager()
    try
        f(pm2)
        add!(pm, pm2)
    finally
        dispose(pm2)
    end
end

function add!(f::Core.Function, pm::NewPMFunctionPassManager, ::Type{NewPMFunctionPassManager})
    pm2 = NewPMFunctionPassManager()
    try
        f(pm2)
        add!(pm, pm2)
    finally
        dispose(pm2)
    end
end

function add!(f::Core.Function, pm::NewPMLoopPassManager, ::Type{NewPMLoopPassManager})
    pm2 = NewPMLoopPassManager()
    try
        f(pm2)
        add!(pm, pm2)
    finally
        dispose(pm2)
    end
end

function add!(f::Core.Function, pm::NewPMModulePassManager, ::Type{NewPMCGSCCPassManager})
    pm2 = NewPMCGSCCPassManager()
    try
        f(pm2)
        add!(pm, pm2)
    finally
        dispose(pm2)
    end
end

function add!(f::Core.Function, pm::NewPMModulePassManager, ::Type{NewPMFunctionPassManager})
    pm2 = NewPMFunctionPassManager()
    try
        f(pm2)
        add!(pm, pm2)
    finally
        dispose(pm2)
    end
end

function add!(f::Core.Function, pm::NewPMCGSCCPassManager, ::Type{NewPMFunctionPassManager})
    pm2 = NewPMFunctionPassManager()
    try
        f(pm2)
        add!(pm, pm2)
    finally
        dispose(pm2)
    end
end

function add!(f::Core.Function, pm::NewPMFunctionPassManager, ::Type{NewPMLoopPassManager})
    pm2 = NewPMLoopPassManager()
    try
        f(pm2)
        add!(pm, pm2)
    finally
        dispose(pm2)
    end
end