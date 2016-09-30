export Pass

abstract Pass

# NOTE: we pass 'data' arguments because closures aren't c-callable yet


#
# Module passes
#

export ModulePass

@reftypedef ref=LLVMPassRef immutable ModulePass <: Pass end

function ModulePass(name, runner, data)
    function compat_runner(ref::API.LLVMModuleRef, data)::API.LLVMBool
        mod = LLVM.Module(ref)
        return BoolToLLVM(runner(mod, unsafe_pointer_to_objref(data)))
    end
    compat_callback = cfunction(compat_runner, API.LLVMBool,
                                Tuple{API.LLVMModuleRef, Ptr{Void}})

    return ModulePass(API.LLVMExtraCreateModulePass(name, compat_callback,
                                                    pointer_from_objref(data)))
end


#
# Function passes
#

export FunctionPass

@reftypedef ref=LLVMPassRef immutable FunctionPass <: Pass end

function FunctionPass(name, runner, data)
    function compat_runner(ref::API.LLVMValueRef, data)::API.LLVMBool
        fn = construct(LLVM.Function, ref)
        return BoolToLLVM(runner(fn, unsafe_pointer_to_objref(data)))
    end
    compat_callback = cfunction(compat_runner, API.LLVMBool,
                                Tuple{API.LLVMValueRef, Ptr{Void}})

    return FunctionPass(API.LLVMExtraCreateFunctionPass(name, compat_callback,
                                                        pointer_from_objref(data)))
end


#
# Basic block passes
#

export BasicBlockPass

@reftypedef ref=LLVMPassRef immutable BasicBlockPass <: Pass end

function BasicBlockPass(name, runner, data)
    function compat_runner(ref::API.LLVMBasicBlockRef, data)::API.LLVMBool
        bb = BasicBlock(ref)
        return BoolToLLVM(runner(bb, unsafe_pointer_to_objref(data)))
    end
    compat_callback = cfunction(compat_runner, API.LLVMBool,
                                Tuple{API.LLVMBasicBlockRef, Ptr{Void}})

    return BasicBlockPass(API.LLVMExtraCreateBasicBlockPass(name, compat_callback,
                                                            pointer_from_objref(data)))
end
