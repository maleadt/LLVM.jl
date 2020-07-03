export Pass

# subtypes are expected to have a 'ref::API.LLVMPassRef' field
abstract type Pass end
reftype(::Type{T}) where {T<:Pass} = API.LLVMPassRef

Base.unsafe_convert(::Type{API.LLVMPassRef}, pass::Pass) = pass.ref


#
# Module passes
#

export ModulePass

@checked struct ModulePass <: Pass
    ref::reftype(Pass)
    root::Any

    function ModulePass(name::String, runner::Core.Function)
        function callback(ptr::Ptr{Cvoid})::Core.Bool
            mod = Module(convert(reftype(Module), ptr))
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
            fn = Function(convert(reftype(Function), ptr))
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
        VERSION >= v"1.4.0-DEV.589" && error("BasicBlockPass functionality has been removed from Julia and LLVM")

        function callback(ptr::Ptr{Cvoid})::Core.Bool
            bb = BasicBlock(convert(reftype(BasicBlock), ptr))
            return runner(bb)::Core.Bool
        end

        return new(API.LLVMCreateBasicBlockPass(name, callback), callback)
    end
end

