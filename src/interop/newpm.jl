import ..LLVM: @module_pass, @function_pass, @loop_pass
import ..LLVM: is_module_pass, is_cgscc_pass, is_function_pass, is_loop_pass
import ..LLVM: pass_string, options_string, add!

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
options_string(options::MultiVersioningPassOptions) = options.external ? "<external>" : ""
@module_pass "JuliaMultiVersioning" MultiVersioningPass MultiVersioningPassOptions

struct LowerPTLSPassOptions
    imaging::Bool
end
LowerPTLSPassOptions(; imaging::Bool=false) = LowerPTLSPassOptions(imaging)
options_string(options::LowerPTLSPassOptions) = options.imaging ? "<imaging>" : ""
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
options_string(options::GCInvariantVerifierPassOptions) = options.strong ? "<strong>" : ""
@function_pass "GCInvariantVerifier" GCInvariantVerifierPass GCInvariantVerifierPassOptions

@loop_pass "JuliaLICM" JuliaLICMPass
@static if VERSION >= v"1.10.0-beta3.44"
    @loop_pass "LowerSIMDLoop" LowerSIMDLoopPass
end

# The entire Julia pipeline
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
function options_string(options::JuliaPipelinePassOptions)
    optlevel = "O$(options.opt_level)"
    lower_intrinsics = options.lower_intrinsics ? "lower_intrinsics" : "no_lower_intrinsics"
    dump_native = options.dump_native ? "dump_native" : "no_dump_native"
    external_use = options.external_use ? "external_use" : "no_external_use"
    llvm_only = options.llvm_only ? "llvm_only" : "no_llvm_only"
    "<$optlevel;$lower_intrinsics;$dump_native;$external_use;$llvm_only>"
end
@module_pass "julia" JuliaPipelinePass JuliaPipelinePassOptions

# We specialize the add! here because if we go through the PassBuilder parser,
# Julia won't insert the PassBuilder's callbacks in the right spots.
# Using the specific method call here allows insertion of those callbacks.
function add!(pm::NewPMModulePassManager, pb::PassBuilder, pass::JuliaPipelinePass)
    cfg = API.PipelineConfig(; Speedup = pass.options.opt_level, Size = 0,
        pass.options.lower_intrinsics,
        pass.options.dump_native,
        pass.options.external_use,
        pass.options.llvm_only
    )
    API.LLVMAddJuliaPipelinePass(pm, pb, cfg)
end
