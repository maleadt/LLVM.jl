export PassManager,
       add!

# subtypes are expected to have a 'ref::API.LLVMPassManagerRef' field
abstract type PassManager end

Base.unsafe_convert(::Type{API.LLVMPassManagerRef}, pm::PassManager) = pm.ref

function add!(pm::PassManager, pass::Pass)
    push!(pm.roots, pass)
    API.LLVMAddPass(pm, pass)
end

unsafe_dispose!(pm::PassManager) = API.LLVMDisposePassManager(pm)


#
# Module pass manager
#

export ModulePassManager, run!

@checked mutable struct ModulePassManager <: PassManager
    ref::API.LLVMPassManagerRef
    roots::Vector{Any}
end

function ModulePassManager()
    mpm = ModulePassManager(API.LLVMCreatePassManager(), [])
    finalizer(unsafe_dispose!, mpm)
end

run!(mpm::ModulePassManager, mod::Module) =
    convert(Core.Bool, API.LLVMRunPassManager(mpm, mod))


#
# Function pass manager
#

export FunctionPassManager,
       initialize!, finalize!, run!

@checked mutable struct FunctionPassManager <: PassManager
    ref::API.LLVMPassManagerRef
    mod::Module
    roots::Vector{Any}
end

function FunctionPassManager(mod::Module)
    fpm = FunctionPassManager(API.LLVMCreateFunctionPassManagerForModule(mod), mod, [])
    finalizer(unsafe_dispose!, fpm)
end

initialize!(fpm::FunctionPassManager) =
    convert(Core.Bool, API.LLVMInitializeFunctionPassManager(fpm))
finalize!(fpm::FunctionPassManager) =
    convert(Core.Bool, API.LLVMFinalizeFunctionPassManager(fpm))

run!(fpm::FunctionPassManager, f::Function) =
    convert(Core.Bool, API.LLVMRunFunctionPassManager(fpm, f))
