export PassManager,
       add!, dispose

# subtypes are expected to have a 'ref::API.LLVMPassManagerRef' field
abstract type PassManager end

Base.unsafe_convert(::Type{API.LLVMPassManagerRef}, pm::PassManager) = pm.ref

function add!(pm::PassManager, pass::Pass)
    push!(pm.roots, pass)
    API.LLVMAddPass(pm, pass)
end

dispose(pm::PassManager) = API.LLVMDisposePassManager(pm)


#
# Module pass manager
#

export ModulePassManager, run!

@checked struct ModulePassManager <: PassManager
    ref::API.LLVMPassManagerRef
    roots::Vector{Any}
end

ModulePassManager() = ModulePassManager(API.LLVMCreatePassManager(), [])

function ModulePassManager(f::Core.Function, args...; kwargs...)
    mpm = ModulePassManager(args...; kwargs...)
    try
        f(mpm)
    finally
        dispose(mpm)
    end
end

run!(mpm::ModulePassManager, mod::Module) =
    convert(Core.Bool, API.LLVMRunPassManager(mpm, mod))



#
# Function pass manager
#

export FunctionPassManager,
       initialize!, finalize!, run!

@checked struct FunctionPassManager <: PassManager
    ref::API.LLVMPassManagerRef
    roots::Vector{Any}
end

FunctionPassManager(mod::Module) =
    FunctionPassManager(API.LLVMCreateFunctionPassManagerForModule(mod), [])

function FunctionPassManager(f::Core.Function, args...; kwargs...)
    fpm = FunctionPassManager(args...; kwargs...)
    try
        f(fpm)
    finally
        dispose(fpm)
    end
end

initialize!(fpm::FunctionPassManager) =
    convert(Core.Bool, API.LLVMInitializeFunctionPassManager(fpm))
finalize!(fpm::FunctionPassManager) =
    convert(Core.Bool, API.LLVMFinalizeFunctionPassManager(fpm))

run!(fpm::FunctionPassManager, f::Function) =
    convert(Core.Bool, API.LLVMRunFunctionPassManager(fpm, f))
