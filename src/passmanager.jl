export PassManager,
       add!, dispose

abstract type PassManager end
reftype(::Type{T}) where {T<:PassManager} = API.LLVMPassManagerRef

add!(pm::PassManager, pass::Pass) =
    API.LLVMAddPass(ref(pm), ref(pass))

dispose(pm::PassManager) = API.LLVMDisposePassManager(ref(pm))


#
# Module pass manager
#

export ModulePassManager, run!

@checked struct ModulePassManager <: PassManager
    ref::reftype(PassManager)
end

ModulePassManager() = ModulePassManager(API.LLVMCreatePassManager())

function ModulePassManager(f::Core.Function, args...)
    mpm = ModulePassManager(args...)
    try
        f(mpm)
    finally
        dispose(mpm)
    end
end

run!(mpm::ModulePassManager, mod::Module) =
    convert(Core.Bool, API.LLVMRunPassManager(ref(mpm), ref(mod)))



#
# Function pass manager
#

export FunctionPassManager,
       initialize!, finalize!, run!

@checked struct FunctionPassManager <: PassManager
    ref::reftype(PassManager)
end

FunctionPassManager(mod::Module) =
    FunctionPassManager(API.LLVMCreateFunctionPassManagerForModule(ref(mod)))

function FunctionPassManager(f::Core.Function, args...)
    fpm = FunctionPassManager(args...)
    try
        f(fpm)
    finally
        dispose(fpm)
    end
end

initialize!(fpm::FunctionPassManager) =
    convert(Core.Bool, API.LLVMInitializeFunctionPassManager(ref(fpm)))
finalize!(fpm::FunctionPassManager) =
    convert(Core.Bool, API.LLVMFinalizeFunctionPassManager(ref(fpm)))

run!(fpm::FunctionPassManager, f::Function) =
    convert(Core.Bool, API.LLVMRunFunctionPassManager(ref(fpm), ref(f)))
