export Pass

abstract Pass


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

        return new(API.LLVMExtraCreateModulePass(name, callback), callback)
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

        return new(API.LLVMExtraCreateFunctionPass(name, callback), callback)
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

        return new(API.LLVMExtraCreateBasicBlockPass(name, callback), callback)
    end
end

