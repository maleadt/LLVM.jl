export PassManager, dispose

abstract PassManager

dispose(pm::PassManager) = API.LLVMDisposePassManager(ref(pm))


export ModulePassManager, run!

@reftypedef ref=LLVMPassManagerRef immutable ModulePassManager <: PassManager end

ModulePassManager() = ModulePassManager(API.LLVMCreatePassManager())

function ModulePassManager(f::Core.Function, args...)
    mpm = ModulePassManager(args...)
    try
        f(mpm)
    finally
        dispose(mpm)
    end
end

run!(mpm::ModulePassManager, mod::Module) = API.LLVMRunPassManager(ref(mpm), ref(mod))


export FunctionPassManager, run!, initialize!, finalize!

@reftypedef ref=LLVMPassManagerRef immutable FunctionPassManager <: PassManager end

function FunctionPassManager(mp::ModuleProvider)
    Base.depwarn("FunctionPassManager(::ModuleProvider) is deprecated, use FunctionPassManager(::Module) instead", :FunctionPassManager)
    FunctionPassManager(API.LLVMCreateFunctionPassManager(ref(mp)))
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
    BoolFromLLVM(API.LLVMInitializeFunctionPassManager(ref(fpm)))
finalize!(fpm::FunctionPassManager) =
    BoolFromLLVM(API.LLVMFinalizeFunctionPassManager(ref(fpm)))

run!(fpm::FunctionPassManager, fun::Function) =
    API.LLVMRunFunctionPassManager(ref(fpm), ref(fun))
