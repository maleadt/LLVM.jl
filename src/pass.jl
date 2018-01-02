export Pass

abstract type Pass end
reftype(::Type{T}) where {T<:Pass} = API.LLVMPassRef


#
# Module passes
#

export ModulePass

@checked struct ModulePass <: Pass
    ref::reftype(Pass)
    root::Any

    function ModulePass(name::String, runner::Core.Function)
        function callback(ptr::Ptr{Cvoid})::Core.Bool
            mod = LLVM.Module(convert(reftype(Module), ptr))
            return runner(mod)::Core.Bool
        end

        return new(API.LLVMCreateModulePass(name, callback), callback)
    end
end



#
# Function passes
#

export FunctionPass

@checked struct FunctionPass <: Pass
    ref::reftype(Pass)
    root::Any

    function FunctionPass(name::String, runner::Core.Function)
        function callback(ptr::Ptr{Cvoid})::Core.Bool
            fn = LLVM.Function(convert(reftype(Function), ptr))
            return runner(fn)::Core.Bool
        end

        return new(API.LLVMCreateFunctionPass(name, callback), callback)
    end
end


#
# Basic block passes
#

export BasicBlockPass

@checked struct BasicBlockPass <: Pass
    ref::reftype(Pass)
    root::Any

    function BasicBlockPass(name::String, runner::Core.Function)
        function callback(ptr::Ptr{Cvoid})::Core.Bool
            bb = BasicBlock(convert(reftype(BasicBlock), ptr))
            return runner(bb)::Core.Bool
        end

        return new(API.LLVMCreateBasicBlockPass(name, callback), callback)
    end
end

