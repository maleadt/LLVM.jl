export alloc_opt!, barrier_noop!, gc_invariant_verifier!, lower_exc_handlers!,
       combine_mul_add!, multi_versioning!, propagate_julia_addrsp!, lower_ptls!,
       lower_simdloop!, late_lower_gc_frame!, final_lower_gc!

alloc_opt!(pm::PassManager) =
    API.LLVMAddAllocOptPass(ref(pm))

barrier_noop!(pm::PassManager) =
    API.LLVMAddBarrierNoopPass(ref(pm))

gc_invariant_verifier!(pm::PassManager, strong::Bool=false) =
    API.LLVMAddGCInvariantVerifierPass(ref(pm), convert(Bool, strong))

lower_exc_handlers!(pm::PassManager) =
    API.LLVMAddLowerExcHandlersPass(ref(pm))

combine_mul_add!(pm::PassManager) =
    API.LLVMAddCombineMulAddPass(ref(pm))

multi_versioning!(pm::PassManager) =
    API.LLVMAddMultiVersioningPass(ref(pm))

propagate_julia_addrsp!(pm::PassManager) =
    API.LLVMAddPropagateJuliaAddrspaces(ref(pm))

lower_ptls!(pm::PassManager, imaging_mode::Bool=false) =
    API.LLVMAddLowerPTLSPass(ref(pm), convert(Bool, imaging_mode))

lower_simdloop!(pm::PassManager) =
    API.LLVMAddLowerSimdLoopPass(ref(pm))

late_lower_gc_frame!(pm::PassManager) =
    API.LLVMAddLateLowerGCFramePass(ref(pm))

if VERSION >= v"1.3.0-DEV.95"
    final_lower_gc!(pm::PassManager) =
        API.LLVMAddFinalLowerGCPass(ref(pm))
else
    final_lower_gc!(pm::PassManager) = nothing
end
