export Pass

@compat abstract type Pass end

@inline function check_access()
    if libllvm_system
        error("LLVM passes are not supported with a system-provided LLVM library")
    end
end


#
# Module passes
#

export ModulePass

@reftypedef ref=LLVMPassRef immutable ModulePass <: Pass
    root::Any

    function ModulePass(name, runner)
        function callback(ptr::Ptr{Void})::Bool
            mod = LLVM.Module(ref(LLVM.Module, ptr))
            return runner(mod)::Bool
        end

        check_access()
        return new(API.LLVMCreateModulePass(name, callback), callback)
    end
end



#
# Function passes
#

export FunctionPass

@reftypedef ref=LLVMPassRef immutable FunctionPass <: Pass
    root::Any

    function FunctionPass(name, runner)
        function callback(ptr::Ptr{Void})::Bool
            fn = LLVM.Function(ref(LLVM.Function, ptr))
            return runner(fn)::Bool
        end

        check_access()
        return new(API.LLVMCreateFunctionPass(name, callback), callback)
    end
end


#
# Basic block passes
#

export BasicBlockPass

@reftypedef ref=LLVMPassRef immutable BasicBlockPass <: Pass
    root::Any

    function BasicBlockPass(name, runner)
        function callback(ptr::Ptr{Void})::Bool
            bb = BasicBlock(ref(BasicBlock, ptr))
            return runner(bb)::Bool
        end

        check_access()
        return new(API.LLVMCreateBasicBlockPass(name, callback), callback)
    end
end

