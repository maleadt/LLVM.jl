export Pass

# subtypes are expected to have a 'ref::API.LLVMPassRef' field
abstract type Pass end

Base.unsafe_convert(::Type{API.LLVMPassRef}, pass::Pass) = pass.ref


#
# Module passes
#

export ModulePass

if VERSION >= v"1.6.0-DEV.809"

function module_pass_callback(ptr, data)
    mod = Module(convert(API.LLVMModuleRef, ptr))
    runner_box = Base.unsafe_pointer_to_objref(data)
    runner = runner_box[]
    changed = runner(mod)::Core.Bool
    convert(Bool, changed)
end

@checked struct ModulePass <: Pass
    ref::API.LLVMPassRef
    root::Any

    function ModulePass(name::String, runner::Core.Function)
        callback = @cfunction(module_pass_callback, API.LLVMBool, (Ptr{Cvoid}, Ptr{Cvoid}))
        runner_box = Ref(runner)

        ref = API.LLVMCreateModulePass2(name, callback, runner_box)
        refcheck(ModulePass, ref)

        return new(ref, runner_box)
    end
end

else

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

end


#
# Function passes
#

export FunctionPass

if VERSION >= v"1.6.0-DEV.809"

function function_pass_callback(ptr, data)
    fn = Function(convert(API.LLVMValueRef, ptr))
    runner_box = Base.unsafe_pointer_to_objref(data)
    runner = runner_box[]
    changed = runner(fn)::Core.Bool
    convert(Bool, changed)
end

@checked struct FunctionPass <: Pass
    ref::API.LLVMPassRef
    root::Any

    function FunctionPass(name::String, runner::Core.Function)
        callback = @cfunction(function_pass_callback, API.LLVMBool, (Ptr{Cvoid}, Ptr{Cvoid}))
        runner_box = Ref(runner)

        ref = API.LLVMCreateFunctionPass2(name, callback, runner_box)
        refcheck(FunctionPass, ref)

        return new(ref, runner_box)
    end
end

else

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

