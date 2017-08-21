export Pass

@compat abstract type Pass end
reftype{T<:Pass}(::Type{T}) = API.LLVMPassRef

@inline function check_access()
    if libllvm_system
        error("LLVM passes are not supported with a system-provided LLVM library")
    end
end


#
# Module passes
#

export ModulePass

@checked immutable ModulePass <: Pass
    ref::reftype(Pass)
    root::Any

    function ModulePass(name::String, runner::Core.Function)
        function callback(ptr::Ptr{Void})::Core.Bool
            mod = LLVM.Module(convert(reftype(Module), ptr))
            return runner(mod)::Core.Bool
        end

        check_access()
        return new(API.LLVMCreateModulePass(name, callback), callback)
    end
end



#
# Function passes
#

export FunctionPass

@checked immutable FunctionPass <: Pass
    ref::reftype(Pass)
    root::Any

    function FunctionPass(name::String, runner::Core.Function)
        function callback(ptr::Ptr{Void})::Core.Bool
            fn = LLVM.Function(convert(reftype(Function), ptr))
            return runner(fn)::Core.Bool
        end

        check_access()
        return new(API.LLVMCreateFunctionPass(name, callback), callback)
    end
end


#
# Basic block passes
#

export BasicBlockPass

@checked immutable BasicBlockPass <: Pass
    ref::reftype(Pass)
    root::Any

    function BasicBlockPass(name::String, runner::Core.Function)
        function callback(ptr::Ptr{Void})::Core.Bool
            bb = BasicBlock(convert(reftype(BasicBlock), ptr))
            return runner(bb)::Core.Bool
        end

        check_access()
        return new(API.LLVMCreateBasicBlockPass(name, callback), callback)
    end
end

