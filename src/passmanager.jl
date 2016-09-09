export PassManager, run!

@reftypedef ref=LLVMPassManagerRef immutable PassManager end

PassManager() = PassManager(API.LLVMCreatePassManager())

function PassManager(f::Core.Function, args...)
    pm = PassManager(args...)
    try
        f(pm)
    finally
        dispose(pm)
    end
end

run!(pm::PassManager, mod::Module) = API.LLVMRunPassManager(ref(pm), ref(mod))


export FunctionPassManager, run!, initialize!, finalize!

@reftypedef ref=LLVMPassManagerRef immutable FunctionPassManager end

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


export dispose

dispose(pm::Union{PassManager,FunctionPassManager}) = API.LLVMDisposePassManager(ref(pm))
