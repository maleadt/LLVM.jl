
@testitem "newpm" begin

using InteractiveUtils  # for subtypes

@testset "newpm pass managers" begin

let mpm = NewPMModulePassManager()
    dispose(mpm)
end

NewPMModulePassManager() do mpm end

@test "NewPMModulePassManager didn't crash!" != ""

let cpm = NewPMCGSCCPassManager()
    dispose(cpm)
end

NewPMCGSCCPassManager() do cpm end

@test "NewPMCGSCCPassManager didn't crash!" != ""

let fpm = NewPMFunctionPassManager()
    dispose(fpm)
end

NewPMFunctionPassManager() do fpm end

@test "NewPMFunctionPassManager didn't crash!" != ""

let lpm = NewPMLoopPassManager()
    dispose(lpm)
end

NewPMLoopPassManager() do lpm end

@test "NewPMLoopPassManager didn't crash!" != ""

end # testset "newpm pass managers"

@testset "newpm pass builder" begin
@dispose ctx=Context() begin

let pic = PassInstrumentationCallbacks()
    dispose(pic)
end

PassInstrumentationCallbacks() do pic end

@test "PassInstrumentationCallbacks didn't crash!" != ""

StandardInstrumentationCallbacks() do pic end

@test "StandardInstrumentations didn't crash!" != ""

let pb = PassBuilder()
    dispose(pb)
end

PassBuilder() do pb end

host_triple = triple()
host_t = Target(triple=host_triple)

TargetMachine(host_t, host_triple) do tm
    PassBuilder(tm) do pb end

    PassInstrumentationCallbacks() do pic
        PassBuilder(tm, pic) do pb end
    end
end

@test "PassBuilder didn't crash!" != ""

end
end # testset "newpm pass builder"

@testset "newpm analysis managers" begin

let mpm = ModuleAnalysisManager()
    dispose(mpm)
end

ModuleAnalysisManager() do mam end

@test "ModuleAnalysisManager didn't crash!" != ""

let cam = CGSCCAnalysisManager()
    dispose(cam)
end

CGSCCAnalysisManager() do cam end

@test "CGSCCAnalysisManager didn't crash!" != ""

let fam = FunctionAnalysisManager()
    dispose(fam)
end

FunctionAnalysisManager() do fam end

@test "FunctionAnalysisManager didn't crash!" != ""

let lam = LoopAnalysisManager()
    dispose(lam)
end

LoopAnalysisManager() do lam end

@test "LoopAnalysisManager didn't crash!" != ""

end # testset "newpm analysis managers"

@testset "newpm analysis registration" begin

host_triple = triple()
host_t = Target(triple=host_triple)

@dispose tm=TargetMachine(host_t, host_triple) pic=PassInstrumentationCallbacks() pb=PassBuilder(tm, pic) begin
    analysis_managers() do lam, fam, cam, mam
        register!(pb, lam, fam, cam, mam)
    end
end

@test "Successfully registered all analysis managers!" != ""

end # testset "newpm analysis registration"

@testset "newpm passes" begin

host_triple = triple()
host_t = Target(triple=host_triple)

@dispose ctx=Context() tm=TargetMachine(host_t, host_triple) pb=PassBuilder(tm) begin
    analysis_managers() do lam, fam, cam, mam
        register!(pb, lam, fam, cam, mam)

        NewPMModulePassManager(pb) do mpm
            for pass in filter(is_module_pass, subtypes(NewPMLLVMPass))
                try
                    add!(mpm, pass())
                    @test "Successfully added $(pass)!" != ""
                catch err
                    @test "Failed to add $(pass)!" == ""
                    @error err
                end
            end
        end
        @test "Successfully added all module passes!" != ""

        NewPMModulePassManager(pb) do mpm
            add!(mpm, NewPMCGSCCPassManager) do cgpm
                for pass in filter(is_cgscc_pass, subtypes(NewPMLLVMPass))
                    try
                        add!(cgpm, pass())
                        @test "Successfully added $(pass)!" != ""
                    catch err
                        @test "Failed to add $(pass)!" == ""
                        @error err
                    end
                end
            end
        end

        @test "Successfully added all CGSCC passes!" != ""

        NewPMModulePassManager(pb) do mpm
            add!(mpm, NewPMFunctionPassManager) do fpm
                for pass in filter(is_function_pass, subtypes(NewPMLLVMPass))
                    try
                        add!(fpm, pass())
                        @test "Successfully added $(pass)!" != ""
                    catch err
                        @test "Failed to add $(pass)!" == ""
                        @error err
                    end
                end
            end
        end

        @test "Successfully added all function passes!" != ""

        NewPMModulePassManager(pb) do mpm
            add!(mpm, NewPMFunctionPassManager) do fpm
                add!(fpm, NewPMLoopPassManager) do lpm
                    for pass in filter(is_loop_pass, subtypes(NewPMLLVMPass))
                        try
                            add!(lpm, pass())
                            @test "Successfully added $(pass)!" != ""
                        catch err
                            @test "Failed to add $(pass)!" == ""
                            @error err
                        end
                    end
                end
            end
        end

        @test "Successfully added all loop passes!" != ""

        NewPMModulePassManager(pb) do mpm
            add!(mpm, NewPMModulePassManager) do mpm2
                add!(mpm2, NewPMCGSCCPassManager) do cgpm
                    add!(cgpm, NewPMCGSCCPassManager) do cgpm2
                        add!(cgpm2, NewPMFunctionPassManager) do fpm
                            add!(fpm, NewPMFunctionPassManager) do fpm2
                                add!(fpm2, NewPMLoopPassManager) do lpm
                                    add!(lpm, NewPMLoopPassManager) do lpm2
                                        @test_throws LLVMException parse!(pb, lpm2, "nonexistent")
                                    end
                                end
                                @test_throws LLVMException parse!(pb, fpm2, "nonexistent")
                            end
                        end
                        @test_throws LLVMException parse!(pb, cgpm2, "nonexistent")
                    end
                end
                @test_throws LLVMException parse!(pb, mpm2, "nonexistent")
            end
        end

        @test "Successfully added nested pass managers!" != ""
    end
end

end # testset "newpm passes"

@testset "newpm custom passes" begin

host_triple = triple()
host_t = Target(triple=host_triple)

@dispose ctx=Context() tm=TargetMachine(host_t, host_triple) pb=PassBuilder(tm) begin
    analysis_managers() do lam, fam, cam, mam
        register!(pb, lam, fam, cam, mam)

        observed_modules = 0
        observed_functions = 0

        NewPMModulePassManager(pb) do mpm
            add!(mpm) do mod, mam
                observed_modules += 1
                all_analyses_preserved()
            end
            add!(mpm, NewPMFunctionPassManager) do fpm
                add!(fpm) do fun, fam
                    observed_functions += 1
                    all_analyses_preserved()
                end
            end

            @test "Successfully added custom module and function passes!" != ""

            @dispose builder=IRBuilder() mod=LLVM.Module("test") begin
                @dispose pa=run!(mpm, mod, mam) begin
                    @test observed_modules == 1
                    @test observed_functions == 0
                    @test are_all_preserved(pa)
                end

                ft = LLVM.FunctionType(LLVM.VoidType())
                fn = LLVM.Function(mod, "SomeFunction", ft)

                entry = BasicBlock(fn, "entry")
                position!(builder, entry)

                ret!(builder)

                @dispose pa=run!(mpm, mod, mam) begin
                    @test observed_modules == 2
                    @test observed_functions == 1
                    @test are_all_preserved(pa)
                end
            end
        end
    end
end

function fake_custom_legacy_pass(counter::Ref{Int})
    return ir -> begin
        counter[] += 1
        return false
    end
end

@dispose ctx=Context() tm=TargetMachine(host_t, host_triple) pb=PassBuilder(tm) begin
    observed_modules = Ref{Int}(0)
    observed_functions = Ref{Int}(0)
    @dispose mpm=NewPMModulePassManager(pb) begin
        add!(legacy2newpm(fake_custom_legacy_pass(observed_modules)), mpm)
        add!(mpm, NewPMFunctionPassManager) do fpm
            add!(legacy2newpm(fake_custom_legacy_pass(observed_functions)), fpm)
        end

        @dispose builder=IRBuilder() mod=LLVM.Module("test") begin
            run!(mpm, mod)

            @test observed_modules[] == 1
            @test observed_functions[] == 0

            ft = LLVM.FunctionType(LLVM.VoidType())
            fn = LLVM.Function(mod, "SomeFunction", ft)

            entry = BasicBlock(fn, "entry")
            position!(builder, entry)

            ret!(builder)

            run!(mpm, mod)
            @test observed_modules[] == 2
            @test observed_functions[] == 1
        end
    end
end

end # testset "newpm custom passes"

@testset "newpm analyses" begin

host_triple = triple()
host_t = Target(triple=host_triple)

@dispose ctx=Context() tm=TargetMachine(host_t, host_triple) pb=PassBuilder(tm) begin
    analysis_managers() do lam, fam, cam, mam
        @test add!(fam, AAManager) do aam
            # Do nothing
        end
        @test !add!(fam, AAManager) do aam
            # Shouldn't run
            @test "Ran an AA manager callback when another AA manager was already registered"
        end
        register!(pb, lam, fam, cam, mam)
    end
    @test "Registered an empty AA manager!" != ""

    analysis_managers() do lam, fam, cam, mam
        add!(fam, AAManager) do aam
            add!(aam, BasicAA())
        end
        register!(pb, lam, fam, cam, mam)
    end
    @test "Registered a single alias analysis pass!" != ""

    analysis_managers() do lam, fam, cam, mam
        add!(fam, AAManager) do aam
            add!(aam, BasicAA())
            add!(aam, ObjCARCAA())
            add!(aam, ScopedNoAliasAA())
            add!(aam, TypeBasedAA())
            add!(aam, GlobalsAA())
            if LLVM.version() < v"16"
                add!(aam, CFLAndersAA())
                add!(aam, CFLSteensAA())
            end
        end
        register!(pb, lam, fam, cam, mam)
    end
    @test "Registered all alias analysis passes!" != ""

    analysis_managers() do lam, fam, cam, mam
        add!(fam, TargetIRAnalysis(tm))
        add!(fam, TargetLibraryAnalysis(host_triple))
        register!(pb, lam, fam, cam, mam)
    end
    @test "Registered target analyses!" != ""

    aa_stack = [BasicAA(), ScopedNoAliasAA(), TypeBasedAA()]
    analysis_managers(nothing, tm, aa_stack) do lam, fam, cam, mam
        register!(pb, lam, fam, cam, mam)
    end
    @test "Implicitly registered alias analyses and target analyses!" != ""
end

end # testset "newpm analyses"

@testset "newpm convenience functions" begin

@dispose ctx=Context() builder=IRBuilder() mod=LLVM.Module("test") begin
    ft = LLVM.FunctionType(LLVM.VoidType())
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry")
    position!(builder, entry)

    ret!(builder)

    @test isnothing(run!(ForceFunctionAttrsPass(), mod))

    @test "Successfully ran with just module pass and module!" != ""

    @test isnothing(run!(ArgumentPromotionPass(), mod))

    @test "Successfully ran with just cgscc pass and module!" != ""

    @test isnothing(run!(SimplifyCFGPass(), mod))

    @test "Successfully ran with just function pass and module!" != ""

    @test isnothing(run!(LICMPass(), mod))

    @test "Successfully ran with just loop pass and module!" != ""

    @test isnothing(run!(SimplifyCFGPass(), fn))

    @test "Successfully ran with just function pass and function!" != ""

    @test isnothing(run!(LICMPass(), fn))

    @test "Successfully ran with just loop pass and function!" != ""

    host_triple = triple()
    host_t = Target(triple=host_triple)

    @dispose tm=TargetMachine(host_t, host_triple) begin
        @test isnothing(run!(SimplifyCFGPass(), fn, tm))
    end

    @test "Successfully forwarded target machine and alias analyses!" != ""
end

end # testset "newpm convenience functions"

@testset "newpm error checking" begin
@dispose mpm=NewPMModulePassManager() begin
    @test_throws ArgumentError add!(mpm, RecomputeGlobalsAAPass())
end

@dispose cpm=NewPMCGSCCPassManager() begin
    @test_throws ArgumentError add!(cpm, ArgumentPromotionPass())
end

@dispose fpm=NewPMFunctionPassManager() begin
    @test_throws ArgumentError add!(fpm, SimplifyCFGPass())
end

@dispose lpm=NewPMLoopPassManager() begin
    @test_throws ArgumentError add!(lpm, LICMPass())
end

@dispose ctx=Context() pb=PassBuilder() begin
    @dispose mpm=NewPMModulePassManager(pb) begin
        @test_throws ArgumentError add!(mpm, SimplifyCFGPass())
    end

    @dispose cpm=NewPMCGSCCPassManager(pb) begin
        @test_throws ArgumentError add!(cpm, SimplifyCFGPass())
    end

    @dispose fpm=NewPMFunctionPassManager(pb) begin
        @test_throws ArgumentError add!(fpm, RecomputeGlobalsAAPass())
    end

    @dispose lpm=NewPMLoopPassManager(pb) begin
        @test_throws ArgumentError add!(lpm, RecomputeGlobalsAAPass())
    end
end

@dispose ctx=Context() builder=IRBuilder() mod=LLVM.Module("test") begin
    ft = LLVM.FunctionType(LLVM.VoidType())
    fn = LLVM.Function(mod, "SomeFunction", ft)

    entry = BasicBlock(fn, "entry")
    position!(builder, entry)

    ret!(builder)

    host_triple = triple()
    host_t = Target(triple=host_triple)

    @dispose tm=TargetMachine(host_t, host_triple) begin
        @test isnothing(run!(SimplifyCFGPass(), mod, tm, [GlobalsAA()]))
        @test_throws ArgumentError run!(SimplifyCFGPass(), fn, tm, [GlobalsAA()])
    end
end

end # testset "newpm error checking"

if VERSION >= v"1.10.0-DEV.1622"

using LLVM.Interop

# Copy of the julia pipeline from julia/src/pipeline.cpp
@testset "newpm julia pipeline" begin
host_triple = triple()
host_t = Target(triple=host_triple)
@dispose ctx=Context() tm=TargetMachine(host_t, host_triple) pb=PassBuilder(tm) begin
    basicSimplifyCFGOptions =
        SimplifyCFGPassOptions(; forward_switch_cond_to_phi=true,
                                 convert_switch_range_to_icmp=true,
                                 convert_switch_to_lookup_table=true)
    aggressiveSimplifyCFGOptions =
        SimplifyCFGPassOptions(; forward_switch_cond_to_phi=true,
                                 convert_switch_range_to_icmp=true,
                                 convert_switch_to_lookup_table=true,
                                 hoist_common_insts=true)
    NewPMModulePassManager(pb) do mpm
        add!(mpm, NewPMFunctionPassManager) do fpm
            add!(fpm, GCInvariantVerifierPass())
        end
        add!(mpm, VerifierPass())
        add!(mpm, ForceFunctionAttrsPass())
        add!(mpm, Annotation2MetadataPass())
        add!(mpm, ConstantMergePass())
        add!(mpm, NewPMFunctionPassManager) do fpm
            add!(fpm, LowerExpectIntrinsicPass())
            add!(fpm, PropagateJuliaAddrspacesPass())
            add!(fpm, SimplifyCFGPass(basicSimplifyCFGOptions))
            add!(fpm, DCEPass())
            add!(fpm, SROAPass())
        end
        add!(mpm, AlwaysInlinerPass())
        add!(mpm, NewPMCGSCCPassManager) do cgpm
            add!(cgpm, NewPMFunctionPassManager) do fpm
                add!(fpm, AllocOptPass())
                add!(fpm, Float2IntPass())
                add!(fpm, LowerConstantIntrinsicsPass())
            end
        end
        add!(mpm, CPUFeaturesPass())
        add!(mpm, NewPMFunctionPassManager) do fpm
            add!(fpm, SROAPass())
            add!(fpm, InstCombinePass())
            add!(fpm, JumpThreadingPass())
            add!(fpm, CorrelatedValuePropagationPass())
            add!(fpm, ReassociatePass())
            add!(fpm, EarlyCSEPass())
            add!(fpm, AllocOptPass())
        end
        add!(mpm, LowerSIMDLoopPass())
        add!(mpm, NewPMFunctionPassManager) do fpm
            add!(fpm, NewPMLoopPassManager) do lpm
                add!(lpm, LoopRotatePass())
            end
            add!(fpm, NewPMLoopPassManager, #=UseMemorySSA=#true) do lpm
                add!(lpm, LICMPass())
                add!(lpm, JuliaLICMPass())
                add!(lpm, SimpleLoopUnswitchPass())
                add!(lpm, LICMPass())
                add!(lpm, JuliaLICMPass())
            end
            add!(fpm, IRCEPass())
            add!(fpm, NewPMLoopPassManager) do lpm
                add!(lpm, LoopInstSimplifyPass())
                add!(lpm, LoopIdiomRecognizePass())
                add!(lpm, IndVarSimplifyPass())
                add!(lpm, LoopDeletionPass())
                add!(lpm, LoopFullUnrollPass())
            end
            add!(fpm, SROAPass())
            add!(fpm, InstSimplifyPass())
            add!(fpm, GVNPass())
            add!(fpm, MemCpyOptPass())
            add!(fpm, SCCPPass())
            add!(fpm, CorrelatedValuePropagationPass())
            add!(fpm, DCEPass())
            add!(fpm, IRCEPass())
            add!(fpm, InstCombinePass())
            add!(fpm, JumpThreadingPass())
            add!(fpm, GVNPass())
            add!(fpm, DSEPass())
            add!(fpm, SimplifyCFGPass(aggressiveSimplifyCFGOptions))
            add!(fpm, AllocOptPass())
            add!(fpm, NewPMLoopPassManager) do lpm
                add!(lpm, LoopDeletionPass())
                add!(lpm, LoopInstSimplifyPass())
            end
            add!(fpm, LoopDistributePass())
            add!(fpm, InjectTLIMappings())
            add!(fpm, LoopVectorizePass())
            add!(fpm, LoopLoadEliminationPass())
            add!(fpm, InstCombinePass())
            add!(fpm, SimplifyCFGPass(aggressiveSimplifyCFGOptions))
            add!(fpm, SLPVectorizerPass())
            add!(fpm, VectorCombinePass())
            add!(fpm, ADCEPass())
            add!(fpm, LoopUnrollPass())
            add!(fpm, WarnMissedTransformationsPass())
        end
        add!(mpm, NewPMFunctionPassManager) do fpm
            add!(fpm, LowerExcHandlersPass())
            add!(fpm, GCInvariantVerifierPass())
        end
        add!(mpm, RemoveNIPass())
        add!(mpm, NewPMFunctionPassManager) do fpm
            add!(fpm, LateLowerGCPass())
            if VERSION >= v"1.11.0-DEV.208"
                add!(fpm, FinalLowerGCPass())
            end
        end
        if VERSION < v"1.11.0-DEV.208"
            add!(mpm, FinalLowerGCPass())
        end
        add!(mpm, NewPMFunctionPassManager) do fpm
            add!(fpm, GVNPass())
            add!(fpm, SCCPPass())
            add!(fpm, DCEPass())
        end
        add!(mpm, LowerPTLSPass())
        add!(mpm, NewPMFunctionPassManager) do fpm
            add!(fpm, InstCombinePass())
            add!(fpm, SimplifyCFGPass(aggressiveSimplifyCFGOptions))
        end
        add!(mpm, NewPMFunctionPassManager) do fpm
            add!(fpm, CombineMulAddPass())
            add!(fpm, DivRemPairsPass())
        end
        add!(mpm, NewPMFunctionPassManager) do fpm
            add!(fpm, AnnotationRemarksPass())
        end
        add!(mpm, NewPMFunctionPassManager) do fpm
            add!(fpm, DemoteFloat16Pass())
            add!(fpm, GVNPass())
        end

        @test "Successfully created julia pipeline!" != ""

        @dispose builder=IRBuilder() mod=LLVM.Module("test") begin
            ft = LLVM.FunctionType(LLVM.VoidType())
            fn = LLVM.Function(mod, "SomeFunction", ft)

            entry = BasicBlock(fn, "entry")
            position!(builder, entry)

            ret!(builder)

            run!(mpm, mod, tm)
        end
    end
end

@test "Successfully ran julia pipeline!" != ""

@test string(JuliaPipelinePass(; opt_level=2)) ==
      "julia<O2;lower_intrinsics;no_dump_native;no_external_use;no_llvm_only>"

end # testset "newpm julia pipeline"

end # VERSION >= v"1.10.0-DEV.1622"

end
