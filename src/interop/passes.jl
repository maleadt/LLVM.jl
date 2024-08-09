# Julia's LLVM passes and pipelines

using ..LLVM: @pipeline, @module_pass, @function_pass, @loop_pass

@module_pass "CPUFeatures" CPUFeaturesPass
@module_pass "RemoveNI" RemoveNIPass
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
@loop_pass "LowerSIMDLoop" LowerSIMDLoopPass

struct JuliaPipelineOptions
    opt_level::Int
    lower_intrinsics::Bool
    dump_native::Bool
    external_use::Bool
    llvm_only::Bool
    always_inline::Bool
    enable_early_simplifications::Bool
    enable_early_optimizations::Bool
    enable_scalar_optimizations::Bool
    enable_loop_optimizations::Bool
    enable_vector_pipeline::Bool
    remove_ni::Bool
    cleanup::Bool
    warn_missed_transformations::Bool
end

JuliaPipelineOptions(; opt_level=Base.JLOptions().opt_level,
                      lower_intrinsics::Bool=true,
                      dump_native::Bool=false, external_use::Bool=false,
                      llvm_only::Bool=false, always_inline::Bool=true,
                      enable_early_simplifications::Bool=true, enable_early_optimizations::Bool=true,
                      enable_scalar_optimizations::Bool=true, enable_loop_optimizations::Bool=true,
                      enable_vector_pipeline::Bool=true, remove_ni::Bool=true, cleanup::Bool=true,
                      warn_missed_transformations::Bool=false) =
    JuliaPipelineOptions(convert(Int, opt_level), lower_intrinsics, dump_native,
                        external_use, llvm_only, always_inline, enable_early_simplifications,
                        enable_early_optimizations, enable_scalar_optimizations, enable_loop_optimizations,
                        enable_vector_pipeline, remove_ni, cleanup, warn_missed_transformations)

function Base.string(options::JuliaPipelineOptions)
    optlevel = "level=$(options.opt_level)"
    lower_intrinsics = options.lower_intrinsics ? "lower_intrinsics" : "no_lower_intrinsics"
    dump_native = options.dump_native ? "dump_native" : "no_dump_native"
    external_use = options.external_use ? "external_use" : "no_external_use"
    llvm_only = options.llvm_only ? "llvm_only" : "no_llvm_only"
    always_inline = options.always_inline ? "always_inline" : "no_always_inline"
    enable_early_simplifications = options.enable_early_simplifications ? "enable_early_simplifications" : "no_enable_early_simplifications"
    enable_early_optimizations = options.enable_early_optimizations ? "enable_early_optimizations" : "no_enable_early_optimizations"
    enable_scalar_optimizations = options.enable_scalar_optimizations ? "enable_scalar_optimizations" : "no_enable_scalar_optimizations"
    enable_loop_optimizations = options.enable_loop_optimizations ? "enable_loop_optimizations" : "no_enable_loop_optimizations"
    enable_vector_pipeline = options.enable_vector_pipeline ? "enable_vector_pipeline" : "no_enable_vector_pipeline"
    remove_ni = options.remove_ni ? "remove_ni" : "no_remove_ni"
    cleanup = options.cleanup ? "cleanup" : "no_cleanup"
    warn_missed_transformations = options.warn_missed_transformations ? "warn_missed_transformations" : "no_warn_missed_transformations"
    opt_string = "<$optlevel;$lower_intrinsics;$dump_native;$external_use;$llvm_only"
    if VERSION >= v"1.12.0-DEV.1029" || (v"1.11.0-rc3" <= VERSION < v"1.12-") # Extended string parsing
        opt_string *= ";$always_inline;$enable_early_simplifications;$enable_early_optimizations;$enable_scalar_optimizations"
        opt_string *= ";$enable_loop_optimizations;$enable_vector_pipeline;$remove_ni;$cleanup;$warn_missed_transformations"
    end
    opt_string *= ">"
    return opt_string
end

@pipeline "julia" JuliaPipeline JuliaPipelineOptions

# XXX: if we go through the PassBuilder parser, Julia won't insert the PassBuilder's
# callbacks in the right spots. that's why Julia also provides `jl_build_newpm_pipeline`.
# is this still true? can we fix that, and continue using the PassBuilder interface?

Base.@deprecate_binding JuliaPipelinePass JuliaPipeline
Base.@deprecate_binding JuliaPipelinePassOptions JuliaPipelineOptions false


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
