export PassManager, ModulePassManager, CGSCCPassManager, FunctionPassManager, LoopPassManager

export dispose, add!

abstract type PassManager end

@checked struct ModulePassManager <: PassManager
    ref::API.LLVMModulePassManagerRef
    roots::Vector{Any}
end
@checked struct CGSCCPassManager <: PassManager
    ref::API.LLVMCGSCCPassManagerRef
    roots::Vector{Any}
end
@checked struct FunctionPassManager <: PassManager
    ref::API.LLVMFunctionPassManagerRef
    roots::Vector{Any}
end
@checked struct LoopPassManager <: PassManager
    ref::API.LLVMLoopPassManagerRef
    roots::Vector{Any}
end

Base.unsafe_convert(::Type{API.LLVMModulePassManagerRef}, pm::ModulePassManager) = pm.ref
Base.unsafe_convert(::Type{API.LLVMCGSCCPassManagerRef}, pm::CGSCCPassManager) = pm.ref
Base.unsafe_convert(::Type{API.LLVMFunctionPassManagerRef}, pm::FunctionPassManager) = pm.ref
Base.unsafe_convert(::Type{API.LLVMLoopPassManagerRef}, pm::LoopPassManager) = pm.ref

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

add!(pm::ModulePassManager, pm2::ModulePassManager) = API.LLVMMPMAddMPM(pm, pm2)
add!(pm::CGSCCPassManager, pm2::CGSCCPassManager) = API.LLVMCGPMAddCGPM(pm, pm2)
add!(pm::FunctionPassManager, pm2::FunctionPassManager) = API.LLVMFPMAddFPM(pm, pm2)
add!(pm::LoopPassManager, pm2::LoopPassManager) = API.LLVMLPMAddLPM(pm, pm2)

add!(pm::ModulePassManager, pm2::CGSCCPassManager) = API.LLVMMPMAddCGPM(pm, pm2)
add!(pm::ModulePassManager, pm2::FunctionPassManager) = API.LLVMMPMAddFPM(pm, pm2)
add!(pm::CGSCCPassManager, pm2::FunctionPassManager) = API.LLVMCGPMAddFPM(pm, pm2)
add!(pm::FunctionPassManager, pm2::LoopPassManager) = API.LLVMFPMAddLPM(pm, pm2)

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