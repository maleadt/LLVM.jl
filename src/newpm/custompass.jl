export add!

function module_pass_callback_impl(mod, mam, thunk)
    m = Module(mod)
    am = NewPMModuleAnalysisManager(mam, Any[])
    pass = Base.unsafe_pointer_to_objref(thunk)::Ref{Core.Function}
    preserved = unsafe_run() do
        pa = pass[](m, am)::PreservedAnalyses
        return pa.ref
    end
    return preserved
end

function function_pass_callback_impl(fun, fam, thunk)
    f = Function(fun)
    am = NewPMFunctionAnalysisManager(fam, Any[])
    pass = Base.unsafe_pointer_to_objref(thunk)::Ref{Core.Function}
    preserved = unsafe_run() do
        pa = pass[](f, am)::PreservedAnalyses
        return pa.ref
    end
    return preserved
end

function add!(f::Core.Function, mpm::NewPMModulePassManager)
    cb = Ref{Core.Function}(f)
    julia_module_pass_callback = @cfunction(module_pass_callback_impl, API.LLVMPreservedAnalysesRef, (API.LLVMModuleRef, API.LLVMModuleAnalysisManagerRef, Ptr{Cvoid}))
    push!(mpm.roots, cb)
    GC.@preserve cb API.LLVMMPMAddJuliaPass(mpm, julia_module_pass_callback, Base.pointer_from_objref(cb))
end

function add!(f::Core.Function, fpm::NewPMFunctionPassManager)
    cb = Ref{Core.Function}(f)
    julia_function_pass_callback = @cfunction(function_pass_callback_impl, API.LLVMPreservedAnalysesRef, (API.LLVMValueRef, API.LLVMFunctionAnalysisManagerRef, Ptr{Cvoid}))
    push!(fpm.roots, cb)
    GC.@preserve cb API.LLVMFPMAddJuliaPass(fpm, julia_function_pass_callback, Base.pointer_from_objref(cb))
end
