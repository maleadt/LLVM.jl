export Pass

# subtypes are expected to have a 'ref::API.LLVMPassRef' field
abstract type Pass end

Base.unsafe_convert(::Type{API.LLVMPassRef}, pass::Pass) = pass.ref


#
# Module passes
#

export ModulePass

@checked struct ModulePass <: Pass
    ref::API.LLVMPassRef
    root::Any

    function ModulePass(name::String, runner::Core.Function)
        function callback(ptr::Ptr{Cvoid})::Core.Bool
            mod = Module(convert(API.LLVMModuleRef, ptr))
            return runner(mod)::Core.Bool
        end

        ref = API.LLVMCreateModulePass(name, callback)
        refcheck(ModulePass, ref)

        return new(ref, callback)
    end
end


#
# Function passes
#

export FunctionPass

@checked struct FunctionPass <: Pass
    ref::API.LLVMPassRef
    root::Any

    function FunctionPass(name::String, runner::Core.Function)
        function callback(ptr::Ptr{Cvoid})::Core.Bool
            fn = Function(convert(API.LLVMValueRef, ptr))
            return runner(fn)::Core.Bool
        end

        ref = API.LLVMCreateFunctionPass(name, callback)
        refcheck(FunctionPass, ref)

        return new(ref, callback)
    end
end


#
# Basic block passes
#

export BasicBlockPass

@checked struct BasicBlockPass <: Pass
    ref::API.LLVMPassRef
    root::Any

    function BasicBlockPass(name::String, runner::Core.Function)
        VERSION >= v"1.4.0-DEV.589" && error("BasicBlockPass functionality has been removed from Julia and LLVM")

        function callback(ptr::Ptr{Cvoid})::Core.Bool
            bb = BasicBlock(convert(API.LLVMBasicBlockRef, ptr))
            return runner(bb)::Core.Bool
        end

        ref = API.LLVMCreateBasicBlockPass(name, callback)
        refcheck(BasicBlockPass, ref)

        return new(ref, callback)
    end
end

