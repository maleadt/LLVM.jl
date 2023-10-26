export Pass

# subtypes are expected to have a 'ref::API.LLVMPassRef' field
abstract type Pass end

Base.unsafe_convert(::Type{API.LLVMPassRef}, pass::Pass) = pass.ref


#
# Module passes
#

export ModulePass

function module_pass_callback(ptr, data)
    mod = Module(convert(API.LLVMModuleRef, ptr))
    runner_box = Base.unsafe_pointer_to_objref(data)
    runner = runner_box[]
    changed = runner(mod)::Bool
    convert(API.LLVMBool, changed)
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


#
# Function passes
#

export FunctionPass

function function_pass_callback(ptr, data)
    fn = Function(convert(API.LLVMValueRef, ptr))
    runner_box = Base.unsafe_pointer_to_objref(data)
    runner = runner_box[]
    changed = runner(fn)::Bool
    convert(API.LLVMBool, changed)
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
