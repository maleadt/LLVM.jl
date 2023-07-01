import ..LLVM: @module_pass, @function_pass, @loop_pass
import ..LLVM: is_module_pass, is_cgscc_pass, is_function_pass, is_loop_pass
import ..LLVM: pass_string, options_string, add!

@module_pass "CPUFeatures" CPUFeaturesPass
@module_pass "RemoveNI" RemoveNIPass
@module_pass "LowerSIMDLoop" LowerSIMDLoopPass
@module_pass "FinalLowerGC" FinalLowerGCPass
@module_pass "RemoveJuliaAddrspaces" RemoveJuliaAddrspacesPass
@module_pass "RemoveAddrspaces" RemoveAddrspacesPass

struct MultiVersioningPassOptions
    external::Core.Bool
end
MultiVersioningPassOptions(; external::Core.Bool=false) = MultiVersioningPassOptions(external)
options_string(options::MultiVersioningPassOptions) = ifelse(options.external, "<external>", "")
@module_pass "JuliaMultiVersioning" MultiVersioningPass MultiVersioningPassOptions

struct LowerPTLSPassOptions
    imaging::Core.Bool
end
LowerPTLSPassOptions(; imaging::Core.Bool=false) = LowerPTLSPassOptions(imaging)
options_string(options::LowerPTLSPassOptions) = ifelse(options.imaging, "<imaging>", "")
@module_pass "LowerPTLSPass" LowerPTLSPass LowerPTLSPassOptions

@function_pass "DemoteFloat16" DemoteFloat16Pass
@function_pass "CombineMulAdd" CombineMulAddPass
@function_pass "LateLowerGCFrame" LateLowerGCPass
@function_pass "AllocOpt" AllocOptPass
@function_pass "PropagateJuliaAddrspaces" PropagateJuliaAddrspacesPass
@function_pass "LowerExcHandlers" LowerExcHandlersPass

struct GCInvariantVerifierPassOptions
    strong::Core.Bool
end
GCInvariantVerifierPassOptions(; strong::Core.Bool=false) = GCInvariantVerifierPassOptions(strong)
options_string(options::GCInvariantVerifierPassOptions) = ifelse(options.strong, "<strong>", "")
@function_pass "GCInvariantVerifier" GCInvariantVerifierPass GCInvariantVerifierPassOptions

@loop_pass "JuliaLICM" JuliaLICMPass

# The entire Julia pipeline
struct JuliaPipelinePassOptions
    speedup::Int
    lower_intrinsics::Core.Bool
    dump_native::Core.Bool
    external_use::Core.Bool
    llvm_only::Core.Bool
end
JuliaPipelinePassOptions(; speedup=Base.JLOptions().opt_level, lower_intrinsics::Core.Bool=true,
    dump_native::Core.Bool=false, external_use::Core.Bool=false,
    llvm_only::Core.Bool=false) = JuliaPipelinePassOptions(convert(Int, speedup), lower_intrinsics, dump_native, external_use, llvm_only)
function options_string(options::JuliaPipelinePassOptions)
    optlevel = "O$(options.speedup)"
    lower_intrinsics = ifelse(options.lower_intrinsics, "lower_intrinsics", "no_lower_intrinsics")
    dump_native = ifelse(options.dump_native, "dump_native", "no_dump_native")
    external_use = ifelse(options.external_use, "external_use", "no_external_use")
    llvm_only = ifelse(options.llvm_only, "llvm_only", "no_llvm_only")
    "<$optlevel;$lower_intrinsics;$dump_native;$external_use;$llvm_only>"
end
@module_pass "julia" JuliaPipelinePass JuliaPipelinePassOptions

# We specialize the add! here because if we go through the PassBuilder parser,
# Julia won't insert the PassBuilder's callbacks in the right spots.
# Using the specific method call here allows insertion of those callbacks.
function add!(pm::NewPMModulePassManager, pb::PassBuilder, pass::JuliaPipelinePass)
    API.LLVMAddJuliaPipelinePass(pm, pb, pass.options.speedup, 0, pass.options.lower_intrinsics,
                                 pass.options.dump_native, pass.options.external_use,
                                 pass.options.llvm_only)
end
