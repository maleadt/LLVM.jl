# Julia's LLVM passes and pipelines

if LLVM.has_newpm() && VERSION >= v"1.10.0-DEV.1622"
using ..LLVM: @module_pass, @function_pass, @loop_pass
end

@static if LLVM.has_newpm() && VERSION >= v"1.10.0-DEV.1622"

@module_pass "CPUFeatures" CPUFeaturesPass
@module_pass "RemoveNI" RemoveNIPass
@static if VERSION < v"1.10.0-beta3.44"
    @module_pass "LowerSIMDLoop" LowerSIMDLoopPass
end
@module_pass "RemoveJuliaAddrspaces" RemoveJuliaAddrspacesPass
@module_pass "RemoveAddrspaces" RemoveAddrspacesPass
@static if VERSION < v"1.11.0-DEV.208"
    @module_pass "FinalLowerGC" FinalLowerGCPass
end

struct MultiVersioningPassOptions
    external::Bool
end
MultiVersioningPassOptions(; external::Bool=false) = MultiVersioningPassOptions(external)
Base.string(options::MultiVersioningPassOptions) = options.external ? "<external>" : ""
@module_pass "JuliaMultiVersioning" MultiVersioningPass MultiVersioningPassOptions

struct LowerPTLSPassOptions
    imaging::Bool
end
LowerPTLSPassOptions(; imaging::Bool=false) = LowerPTLSPassOptions(imaging)
Base.string(options::LowerPTLSPassOptions) = options.imaging ? "<imaging>" : ""
@module_pass "LowerPTLSPass" LowerPTLSPass LowerPTLSPassOptions

@function_pass "DemoteFloat16" DemoteFloat16Pass
@function_pass "CombineMulAdd" CombineMulAddPass
@function_pass "LateLowerGCFrame" LateLowerGCPass
@function_pass "AllocOpt" AllocOptPass
@function_pass "PropagateJuliaAddrspaces" PropagateJuliaAddrspacesPass
@function_pass "LowerExcHandlers" LowerExcHandlersPass
@static if VERSION >= v"1.11.0-DEV.208"
    @function_pass "FinalLowerGC" FinalLowerGCPass
end

struct GCInvariantVerifierPassOptions
    strong::Bool
end
GCInvariantVerifierPassOptions(; strong::Bool=false) =
    GCInvariantVerifierPassOptions(strong)
Base.string(options::GCInvariantVerifierPassOptions) = options.strong ? "<strong>" : ""
@function_pass "GCInvariantVerifier" GCInvariantVerifierPass GCInvariantVerifierPassOptions

@loop_pass "JuliaLICM" JuliaLICMPass
@static if VERSION >= v"1.10.0-beta3.44"
    @loop_pass "LowerSIMDLoop" LowerSIMDLoopPass
end

struct JuliaPipelinePassOptions
    opt_level::Int
    lower_intrinsics::Bool
    dump_native::Bool
    external_use::Bool
    llvm_only::Bool
end
JuliaPipelinePassOptions(; opt_level=Base.JLOptions().opt_level,
                           lower_intrinsics::Bool=true,
                           dump_native::Bool=false, external_use::Bool=false,
                           llvm_only::Bool=false) =
    JuliaPipelinePassOptions(convert(Int, opt_level), lower_intrinsics, dump_native,
                             external_use, llvm_only)
function Base.string(options::JuliaPipelinePassOptions)
    optlevel = "level=$(options.opt_level)"
    lower_intrinsics = options.lower_intrinsics ? "lower_intrinsics" : "no_lower_intrinsics"
    dump_native = options.dump_native ? "dump_native" : "no_dump_native"
    external_use = options.external_use ? "external_use" : "no_external_use"
    llvm_only = options.llvm_only ? "llvm_only" : "no_llvm_only"
    "<$optlevel;$lower_intrinsics;$dump_native;$external_use;$llvm_only>"
end
@module_pass "julia" JuliaPipelinePass JuliaPipelinePassOptions

# XXX: if we go through the PassBuilder parser, Julia won't insert the PassBuilder's
# callbacks in the right spots. that's why Julia also provides `jl_build_newpm_pipeline`.
# is this still true? can we fix that, and continue using the PassBuilder interface?

end


## legacy passes

@static if VERSION < v"1.11.0-DEV.428"

export alloc_opt!, barrier_noop!, gc_invariant_verifier!, lower_exc_handlers!,
       combine_mul_add!, multi_versioning!, propagate_julia_addrsp!, lower_ptls!,
       lower_simdloop!, late_lower_gc_frame!, final_lower_gc!, remove_julia_addrspaces!,
       demote_float16!, remove_ni!, julia_licm!, cpu_features!

alloc_opt!(pm::PassManager) = API.LLVMAddAllocOptPass(pm)

barrier_noop!(pm::PassManager) = API.LLVMAddBarrierNoopPass(pm)

gc_invariant_verifier!(pm::PassManager, strong::Bool=false) =
    API.LLVMAddGCInvariantVerifierPass(pm, strong)

lower_exc_handlers!(pm::PassManager) = API.LLVMAddLowerExcHandlersPass(pm)

combine_mul_add!(pm::PassManager) = API.LLVMAddCombineMulAddPass(pm)

multi_versioning!(pm::PassManager) = API.LLVMAddMultiVersioningPass(pm)

propagate_julia_addrsp!(pm::PassManager) = API.LLVMAddPropagateJuliaAddrspaces(pm)

lower_ptls!(pm::PassManager, imaging_mode::Bool=false) =
    API.LLVMAddLowerPTLSPass(pm, imaging_mode)

lower_simdloop!(pm::PassManager) = API.LLVMAddLowerSimdLoopPass(pm)

late_lower_gc_frame!(pm::PassManager) = API.LLVMAddLateLowerGCFramePass(pm)

final_lower_gc!(pm::PassManager) = API.LLVMAddFinalLowerGCPass(pm)

remove_julia_addrspaces!(pm::PassManager) = API.LLVMAddRemoveJuliaAddrspacesPass(pm)

demote_float16!(pm::PassManager) = API.LLVMAddDemoteFloat16Pass(pm)

remove_ni!(pm::PassManager) = API.LLVMAddRemoveNIPass(pm)

julia_licm!(pm::PassManager) = API.LLVMAddJuliaLICMPass(pm)

cpu_features!(pm::PassManager) = API.LLVMAddCPUFeaturesPass(pm)

end
