export NewPMPass, NewPMLLVMPass
export is_module_pass, is_cgscc_pass, is_function_pass, is_loop_pass, pass_string

# Export all the passes

macro module_pass(pass_name, class_name)
    quote
        export $class_name
        struct $class_name <: NewPMLLVMPass end
        @eval is_module_pass(::Type{$class_name}) = true
        @eval pass_string(::$class_name) = $pass_name
    end
end

macro module_pass(pass_name, class_name, params)
    quote
        export $params
        export $class_name
        struct $class_name <: NewPMLLVMPass
            options::$(esc(params))
        end
        @eval $class_name(; kwargs...) = $class_name($params(; kwargs...))
        @eval is_module_pass(::Type{$class_name}) = true
        @eval pass_string(pass::$class_name) = $pass_name * options_string(pass.options)
    end
end

macro cgscc_pass(pass_name, class_name)
    quote
        export $class_name
        struct $class_name <: NewPMLLVMPass end
        @eval is_cgscc_pass(::Type{$class_name}) = true
        @eval pass_string(::$class_name) = $pass_name
    end
end

macro cgscc_pass(pass_name, class_name, params)
    quote
        export $params
        export $class_name
        struct $class_name <: NewPMLLVMPass
            options::$(esc(params))
        end
        @eval $class_name(; kwargs...) = $class_name($params(; kwargs...))
        @eval is_cgscc_pass(::Type{$class_name}) = true
        @eval pass_string(pass::$class_name) = $pass_name * options_string(pass.options)
    end
end

macro function_pass(pass_name, class_name)
    quote
        export $class_name
        struct $class_name <: NewPMLLVMPass end
        @eval is_function_pass(::Type{$class_name}) = true
        @eval pass_string(::$class_name) = $pass_name
    end
end

macro function_pass(pass_name, class_name, params)
    quote
        export $params
        export $class_name
        struct $class_name <: NewPMLLVMPass
            options::$(esc(params))
        end
        @eval $class_name(; kwargs...) = $class_name($params(; kwargs...))
        @eval is_function_pass(::Type{$class_name}) = true
        @eval pass_string(pass::$class_name) = $pass_name * options_string(pass.options)
    end
end

macro loop_pass(pass_name, class_name)
    quote
        export $class_name
        struct $class_name <: NewPMLLVMPass end
        @eval is_loop_pass(::Type{$class_name}) = true
        @eval pass_string(::$class_name) = $pass_name
    end
end

macro loop_pass(pass_name, class_name, params)
    quote
        export $params
        export $class_name
        struct $class_name <: NewPMLLVMPass
            options::$(esc(params))
        end
        @eval $class_name(; kwargs...) = $class_name($params(; kwargs...))
        @eval is_loop_pass(::Type{$class_name}) = true
        @eval pass_string(pass::$class_name) = $pass_name * options_string(pass.options)
    end
end

abstract type NewPMPass end
abstract type NewPMLLVMPass <: NewPMPass end

is_module_pass(::Type{<:NewPMLLVMPass}) = false
is_cgscc_pass(::Type{<:NewPMLLVMPass}) = false
is_function_pass(::Type{<:NewPMLLVMPass}) = false
is_loop_pass(::Type{<:NewPMLLVMPass}) = false

Base.show(io::IO, pass::NewPMLLVMPass) = print(io, pass_string(pass))

# Module passes

@module_pass "always-inline" AlwaysInlinerPass
@module_pass "attributor" AttributorPass
@module_pass "annotation2metadata" Annotation2MetadataPass
@module_pass "openmp-opt" OpenMPOptPass
@module_pass "called-value-propagation" CalledValuePropagationPass
@module_pass "canonicalize-aliases" CanonicalizeAliasesPass
@module_pass "cg-profile" CGProfilePass
@module_pass "check-debugify" NewPMCheckDebugifyPass
@module_pass "constmerge" ConstantMergePass
@module_pass "coro-early" CoroEarlyPass
@module_pass "coro-cleanup" CoroCleanupPass
@module_pass "cross-dso-cfi" CrossDSOCFIPass
@module_pass "deadargelim" DeadArgumentEliminationPass
@module_pass "debugify" NewPMDebugifyPass
@module_pass "dot-callgraph" CallGraphDOTPrinterPass
@module_pass "elim-avail-extern" EliminateAvailableExternallyPass
@module_pass "extract-blocks" BlockExtractorPass
@module_pass "forceattrs" ForceFunctionAttrsPass
@module_pass "function-import" FunctionImportPass
@module_pass "function-specialization" FunctionSpecializationPass
@module_pass "globaldce" GlobalDCEPass
@module_pass "globalopt" GlobalOptPass
@module_pass "globalsplit" GlobalSplitPass
@module_pass "hotcoldsplit" HotColdSplittingPass
@module_pass "inferattrs" InferFunctionAttrsPass
@module_pass "inliner-wrapper" ModuleInlinerWrapperPass
@module_pass "inliner-ml-advisor-release" ModuleInlinerMLAdvisorReleasePass
@module_pass "print<inline-advisor>" InlineAdvisorAnalysisPrinterPass
@module_pass "inliner-wrapper-no-mandatory-first" ModuleInlinerWrapperNoMandatoryFirstPass
@module_pass "insert-gcov-profiling" GCOVProfilerPass
@module_pass "instrorderfile" InstrOrderFilePass
@module_pass "instrprof" InstrProfiling
@module_pass "internalize" InternalizePass
@module_pass "invalidate<all>" InvalidateAllAnalysesPass
@module_pass "ipsccp" IPSCCPPass
@module_pass "iroutliner" IROutlinerPass
@module_pass "print-ir-similarity" IRSimilarityAnalysisPrinterPass
@module_pass "lower-global-dtors" LowerGlobalDtorsPass
@module_pass "lowertypetests" LowerTypeTestsPass
@module_pass "metarenamer" MetaRenamerPass
@module_pass "mergefunc" MergeFunctionsPass
@module_pass "name-anon-globals" NameAnonGlobalPass
@module_pass "no-op-module" NoOpModulePass
@module_pass "objc-arc-apelim" ObjCARCAPElimPass
@module_pass "partial-inliner" PartialInlinerPass
@module_pass "pgo-icall-prom" PGOIndirectCallPromotion
@module_pass "pgo-instr-gen" PGOInstrumentationGen
@module_pass "pgo-instr-use" PGOInstrumentationUse
@module_pass "print-profile-summary" ProfileSummaryPrinterPass
@module_pass "print-callgraph" CallGraphPrinterPass
@module_pass "print" PrintModulePass
@module_pass "print-lcg" LazyCallGraphPrinterPass
@module_pass "print-lcg-dot" LazyCallGraphDOTPrinterPass
@module_pass "print-must-be-executed-contexts" MustBeExecutedContextPrinterPass
@module_pass "print-stack-safety" StackSafetyGlobalPrinterPass
@module_pass "print<module-debuginfo>" ModuleDebugInfoPrinterPass
@module_pass "recompute-globalsaa" RecomputeGlobalsAAPass
@module_pass "rel-lookup-table-converter" RelLookupTableConverterPass
@module_pass "rewrite-statepoints-for-gc" RewriteStatepointsForGC
@module_pass "rewrite-symbols" RewriteSymbolPass
@module_pass "rpo-function-attrs" ReversePostOrderFunctionAttrsPass
@module_pass "sample-profile" SampleProfileLoaderPass
@module_pass "strip" StripSymbolsPass
@module_pass "strip-dead-debug-info" StripDeadDebugInfoPass
@module_pass "pseudo-probe" SampleProfileProbePass
@module_pass "strip-dead-prototypes" StripDeadPrototypesPass
@module_pass "strip-debug-declare" StripDebugDeclarePass
@module_pass "strip-nondebug" StripNonDebugSymbolsPass
@module_pass "strip-nonlinetable-debuginfo" StripNonLineTableDebugInfoPass
@module_pass "synthetic-counts-propagation" SyntheticCountsPropagation
@module_pass "trigger-crash" TriggerCrashPass
@module_pass "verify" VerifierPass
@module_pass "view-callgraph" CallGraphViewerPass
@module_pass "wholeprogramdevirt" WholeProgramDevirtPass
@module_pass "dfsan" DataFlowSanitizerPass
@module_pass "msan-module" ModuleMemorySanitizerPass
@module_pass "module-inline" ModuleInlinerPass
@module_pass "tsan-module" ModuleThreadSanitizerPass
@module_pass "sancov-module" ModuleSanitizerCoveragePass
@module_pass "memprof-module" ModuleMemProfilerPass
@module_pass "poison-checking" PoisonCheckingPass
@module_pass "pseudo-probe-update" PseudoProbeUpdatePass

# Module Passes With Params

struct LoopExtractorPassOptions
    single::Core.Bool
end
LoopExtractorPassOptions(; single::Core.Bool = false) = LoopExtractorPassOptions(single)
options_string(options::LoopExtractorPassOptions) = ifelse(options.single, "<single>", "")
@module_pass "loop-extract" LoopExtractorPass LoopExtractorPassOptions

struct HWAddressSanitizerPassOptions
    kernel::Core.Bool
    recover::Core.Bool
end
HWAddressSanitizerPassOptions(; kernel::Core.Bool = false, recover::Core.Bool = false) = HWAddressSanitizerPassOptions(kernel, recover)
function options_string(options::HWAddressSanitizerPassOptions)
    s = String[]
    if options.kernel
        push!(s, "kernel")
    end
    if options.recover
        push!(s, "recover")
    end
    if !isempty(s)
        "<" * join(s, ";") * ">"
    else
        ""
    end
end
@module_pass "hwasan" HWAddressSanitizerPass HWAddressSanitizerPassOptions

struct ModuleAddressSanitizerPassOptions
    kernel::Core.Bool
end
ModuleAddressSanitizerPassOptions(; kernel::Core.Bool = false) = ModuleAddressSanitizerPassOptions(kernel)
options_string(options::ModuleAddressSanitizerPassOptions) = ifelse(options.kernel, "<kernel>", "")
@module_pass "asan-module" ModuleAddressSanitizerPass ModuleAddressSanitizerPassOptions

# CGSCC Passes

@cgscc_pass "argpromotion" ArgumentPromotionPass
# @cgscc_pass "invalidate<all>" InvalidateAllAnalysesPass
is_cgscc_pass(::Type{InvalidateAllAnalysesPass}) = true
@cgscc_pass "function-attrs" PostOrderFunctionAttrsPass
@cgscc_pass "attributor-cgscc" AttributorCGSCCPass
@cgscc_pass "openmp-opt-cgscc" OpenMPOptCGSCCPass
@cgscc_pass "no-op-cgscc" NoOpCGSCCPass

# CGSCC Passes With Params

struct InlinerPassOptions
    onlymandatory::Core.Bool
end
InlinerPassOptions(; onlymandatory::Core.Bool = false) = InlinerPassOptions(onlymandatory)
options_string(options::InlinerPassOptions) = ifelse(options.onlymandatory, "<only-mandatory>", "")
@cgscc_pass "inline" InlinerPass InlinerPassOptions

struct CoroSplitPassOptions
    reusestorage::Core.Bool
end
CoroSplitPassOptions(; reusestorage::Core.Bool = false) = CoroSplitPassOptions(reusestorage)
options_string(options::CoroSplitPassOptions) = ifelse(options.reusestorage, "<reuse-storage>", "")
@cgscc_pass "coro-split" CoroSplitPass CoroSplitPassOptions

# Function Passes

@function_pass "aa-eval" AAEvaluator
@function_pass "adce" ADCEPass
@function_pass "add-discriminators" AddDiscriminatorsPass
@function_pass "aggressive-instcombine" AggressiveInstCombinePass
@function_pass "assume-builder" AssumeBuilderPass
@function_pass "assume-simplify" AssumeSimplifyPass
@function_pass "alignment-from-assumptions" AlignmentFromAssumptionsPass
@function_pass "annotation-remarks" AnnotationRemarksPass
@function_pass "bdce" BDCEPass
@function_pass "bounds-checking" BoundsCheckingPass
@function_pass "break-crit-edges" BreakCriticalEdgesPass
@function_pass "callsite-splitting" CallSiteSplittingPass
@function_pass "consthoist" ConstantHoistingPass
@function_pass "constraint-elimination" ConstraintEliminationPass
@function_pass "chr" ControlHeightReductionPass
@function_pass "coro-elide" CoroElidePass
@function_pass "correlated-propagation" CorrelatedValuePropagationPass
@function_pass "dce" DCEPass
@function_pass "dfa-jump-threading" DFAJumpThreadingPass
@function_pass "div-rem-pairs" DivRemPairsPass
@function_pass "dse" DSEPass
@function_pass "dot-cfg" CFGPrinterPass
@function_pass "dot-cfg-only" CFGOnlyPrinterPass
@function_pass "dot-dom" DomPrinter
@function_pass "dot-dom-only" DomOnlyPrinter
@function_pass "dot-post-dom" PostDomPrinter
@function_pass "dot-post-dom-only" PostDomOnlyPrinter
@function_pass "view-dom" DomViewer
@function_pass "view-dom-only" DomOnlyViewer
@function_pass "view-post-dom" PostDomViewer
@function_pass "view-post-dom-only" PostDomOnlyViewer
@function_pass "fix-irreducible" FixIrreduciblePass
@function_pass "flattencfg" FlattenCFGPass
@function_pass "make-guards-explicit" MakeGuardsExplicitPass
@function_pass "gvn-hoist" GVNHoistPass
@function_pass "gvn-sink" GVNSinkPass
@function_pass "helloworld" HelloWorldPass
@function_pass "infer-address-spaces" InferAddressSpacesPass
@function_pass "instcombine" InstCombinePass
@function_pass "instcount" InstCountPass
@function_pass "instsimplify" InstSimplifyPass
# @function_pass "invalidate<all>" InvalidateAllAnalysesPass
is_function_pass(::Type{InvalidateAllAnalysesPass}) = true
@function_pass "irce" IRCEPass
@function_pass "float2int" Float2IntPass
@function_pass "no-op-function" NoOpFunctionPass
@function_pass "libcalls-shrinkwrap" LibCallsShrinkWrapPass
@function_pass "lint" LintPass
@function_pass "inject-tli-mappings" InjectTLIMappings
@function_pass "instnamer" InstructionNamerPass
@function_pass "loweratomic" LowerAtomicPass
@function_pass "lower-expect" LowerExpectIntrinsicPass
@function_pass "lower-guard-intrinsic" LowerGuardIntrinsicPass
@function_pass "lower-constant-intrinsics" LowerConstantIntrinsicsPass
@function_pass "lower-widenable-condition" LowerWidenableConditionPass
@function_pass "guard-widening" GuardWideningPass
@function_pass "load-store-vectorizer" LoadStoreVectorizerPass
@function_pass "loop-simplify" LoopSimplifyPass
@function_pass "loop-sink" LoopSinkPass
@function_pass "lowerinvoke" LowerInvokePass
@function_pass "lowerswitch" LowerSwitchPass
@function_pass "mem2reg" PromotePass
@function_pass "memcpyopt" MemCpyOptPass
@function_pass "mergeicmps" MergeICmpsPass
@function_pass "mergereturn" UnifyFunctionExitNodesPass
@function_pass "nary-reassociate" NaryReassociatePass
@function_pass "newgvn" NewGVNPass
@function_pass "jump-threading" JumpThreadingPass
@function_pass "partially-inline-libcalls" PartiallyInlineLibCallsPass
@function_pass "lcssa" LCSSAPass
@function_pass "loop-data-prefetch" LoopDataPrefetchPass
@function_pass "loop-load-elim" LoopLoadEliminationPass
@function_pass "loop-fusion" LoopFusePass
@function_pass "loop-distribute" LoopDistributePass
@function_pass "loop-versioning" LoopVersioningPass
@function_pass "objc-arc" ObjCARCOptPass
@function_pass "objc-arc-contract" ObjCARCContractPass
@function_pass "objc-arc-expand" ObjCARCExpandPass
@function_pass "pgo-memop-opt" PGOMemOPSizeOpt
@function_pass "print" PrintFunctionPass
@function_pass "print<assumptions>" AssumptionPrinterPass
@function_pass "print<block-freq>" BlockFrequencyPrinterPass
@function_pass "print<branch-prob>" BranchProbabilityPrinterPass
@function_pass "print<cost-model>" CostModelPrinterPass
@function_pass "print<cycles>" CycleInfoPrinterPass
@function_pass "print<da>" DependenceAnalysisPrinterPass
@function_pass "print<divergence>" DivergenceAnalysisPrinterPass
@function_pass "print<domtree>" DominatorTreePrinterPass
@function_pass "print<postdomtree>" PostDominatorTreePrinterPass
@function_pass "print<delinearization>" DelinearizationPrinterPass
@function_pass "print<demanded-bits>" DemandedBitsPrinterPass
@function_pass "print<domfrontier>" DominanceFrontierPrinterPass
@function_pass "print<func-properties>" FunctionPropertiesPrinterPass
@function_pass "print<inline-cost>" InlineCostAnnotationPrinterPass
@function_pass "print<loops>" LoopPrinterPass
@function_pass "print<memoryssa>" MemorySSAPrinterPass
@function_pass "print<memoryssa-walker>" MemorySSAWalkerPrinterPass
@function_pass "print<phi-values>" PhiValuesPrinterPass
@function_pass "print<regions>" RegionInfoPrinterPass
@function_pass "print<scalar-evolution>" ScalarEvolutionPrinterPass
@function_pass "print<stack-safety-local>" StackSafetyPrinterPass
@function_pass "print-alias-sets" AliasSetsPrinterPass
@function_pass "print-predicateinfo" PredicateInfoPrinterPass
@function_pass "print-mustexecute" MustExecutePrinterPass
@function_pass "print-memderefs" MemDerefPrinterPass
@function_pass "reassociate" ReassociatePass
@function_pass "redundant-dbg-inst-elim" RedundantDbgInstEliminationPass
@function_pass "reg2mem" RegToMemPass
@function_pass "scalarize-masked-mem-intrin" ScalarizeMaskedMemIntrinPass
@function_pass "scalarizer" ScalarizerPass
@function_pass "separate-const-offset-from-gep" SeparateConstOffsetFromGEPPass
@function_pass "sccp" SCCPPass
@function_pass "sink" SinkingPass
@function_pass "slp-vectorizer" SLPVectorizerPass
@function_pass "slsr" StraightLineStrengthReducePass
@function_pass "speculative-execution" SpeculativeExecutionPass
@function_pass "sroa" SROAPass
@function_pass "strip-gc-relocates" StripGCRelocates
@function_pass "structurizecfg" StructurizeCFGPass
@function_pass "tailcallelim" TailCallElimPass
@function_pass "unify-loop-exits" UnifyLoopExitsPass
@function_pass "vector-combine" VectorCombinePass
# @function_pass "verify" VerifierPass
is_function_pass(::Type{VerifierPass}) = true
@function_pass "verify<domtree>" DominatorTreeVerifierPass
@function_pass "verify<loops>" LoopVerifierPass
@function_pass "verify<memoryssa>" MemorySSAVerifierPass
@function_pass "verify<regions>" RegionInfoVerifierPass
@function_pass "verify<safepoint-ir>" SafepointIRVerifierPass
@function_pass "verify<scalar-evolution>" ScalarEvolutionVerifierPass
@function_pass "view-cfg" CFGViewerPass
@function_pass "view-cfg-only" CFGOnlyViewerPass
@function_pass "tlshoist" TLSVariableHoistPass
@function_pass "transform-warning" WarnMissedTransformationsPass
@function_pass "tsan" ThreadSanitizerPass
@function_pass "memprof" MemProfilerPass

# Function Passes With Params

struct EarlyCSEPassOptions
    memssa::Core.Bool
end
EarlyCSEPassOptions(; memssa::Core.Bool = false) = EarlyCSEPassOptions(memssa)
options_string(options::EarlyCSEPassOptions) = ifelse(options.memssa, "<memssa>", "")
@function_pass "early-cse" EarlyCSEPass EarlyCSEPassOptions

struct EntryExitInstrumenterPassOptions
    postinline::Core.Bool
end
EntryExitInstrumenterPassOptions(; postinline::Core.Bool = false) = EntryExitInstrumenterPassOptions(postinline)
options_string(options::EntryExitInstrumenterPassOptions) = ifelse(options.postinline, "<post-inline>", "")
@function_pass "ee-instrument" EntryExitInstrumenterPass EntryExitInstrumenterPassOptions

struct LowerMatrixIntrinsicsPassOptions
    minimal::Core.Bool
end
LowerMatrixIntrinsicsPassOptions(; minimal::Core.Bool = false) = LowerMatrixIntrinsicsPassOptions(minimal)
options_string(options::LowerMatrixIntrinsicsPassOptions) = ifelse(options.minimal, "<minimal>", "")
@function_pass "lower-matrix-intrinsics" LowerMatrixIntrinsicsPass LowerMatrixIntrinsicsPassOptions

struct LoopUnrollPassOptions
    speedup::Int
    fullunrollmax::Union{Nothing, Int}
    partial::Union{Nothing, Core.Bool}
    peeling::Union{Nothing, Core.Bool}
    profilepeeling::Union{Nothing, Core.Bool}
    runtime::Union{Nothing, Core.Bool}
    upperbound::Union{Nothing, Core.Bool}
end
LoopUnrollPassOptions(; speedup::Int = 2,
                       fullunrollmax::Union{Nothing, Int} = nothing,
                       partial::Union{Nothing, Bool} = nothing,
                       peeling::Union{Nothing, Bool} = nothing,
                       profilepeeling::Union{Nothing, Bool} = nothing,
                       runtime::Union{Nothing, Bool} = nothing,
                       upperbound::Union{Nothing, Bool} = nothing) = LoopUnrollPassOptions(speedup, fullunrollmax, partial, peeling, profilepeeling, runtime, upperbound)
function options_string(options::LoopUnrollPassOptions)
    final_options = String[]
    push!(final_options, "O$(options.speedup)")
    if options.fullunrollmax !== nothing
        push!(final_options, "full-unroll-max=$(options.fullunrollmax)")
    end
    if options.partial !== nothing
        push!(final_options, ifelse(options.partial, "partial", "no-partial"))
    end
    if options.peeling !== nothing
        push!(final_options, ifelse(options.peeling, "peeling", "no-peeling"))
    end
    if options.profilepeeling !== nothing
        push!(final_options, ifelse(options.profilepeeling, "profile-peeling", "no-profile-peeling"))
    end
    if options.runtime !== nothing
        push!(final_options, ifelse(options.runtime, "runtime", "no-runtime"))
    end
    if options.upperbound !== nothing
        push!(final_options, ifelse(options.upperbound, "upperbound", "no-upperbound"))
    end
    "<" * join(final_options, ";") * ">"
end
@function_pass "loop-unroll" LoopUnrollPass LoopUnrollPassOptions

struct MemorySanitizerPassOptions
    recover::Core.Bool
    kernel::Core.Bool
    eagerchecks::Core.Bool
    trackorigins::Int
end
MemorySanitizerPassOptions(; recover::Core.Bool = false,
                            kernel::Core.Bool = false,
                            eagerchecks::Core.Bool = false,
                            trackorigins::Int = 0) = MemorySanitizerPassOptions(recover, kernel, eagerchecks, trackorigins)
function options_string(options::MemorySanitizerPassOptions)
    final_options = String[]
    if options.recover
        push!(final_options, "recover")
    end
    if options.kernel
        push!(final_options, "kernel")
    end
    if options.eagerchecks
        push!(final_options, "eager-checks")
    end
    push!(final_options, "track-origins=$(options.trackorigins)")
    "<" * join(final_options, ";") * ">"
end
@function_pass "msan" MemorySanitizerPass MemorySanitizerPassOptions

struct SimplifyCFGPassOptions
    forwardswitchcond::Core.Bool
    switchrangetoicmp::Core.Bool
    switchtolookup::Core.Bool
    keeploops::Core.Bool
    hoistcommoninsts::Core.Bool
    sinkcommoninsts::Core.Bool
    bonusinstthreshold::Int
end
SimplifyCFGPassOptions(; forwardswitchcond::Core.Bool = false,
                        switchrangetoicmp::Core.Bool = false,
                        switchtolookup::Core.Bool = false,
                        keeploops::Core.Bool = true,
                        hoistcommoninsts::Core.Bool = false,
                        sinkcommoninsts::Core.Bool = false,
                        bonusinstthreshold::Int = 1) = SimplifyCFGPassOptions(forwardswitchcond, switchrangetoicmp, switchtolookup, keeploops, hoistcommoninsts, sinkcommoninsts, bonusinstthreshold)
function options_string(options::SimplifyCFGPassOptions)
    forward = ifelse(options.forwardswitchcond, "forward-switch-cond", "no-forward-switch-cond")
    s2i = ifelse(options.switchrangetoicmp, "switch-range-to-icmp", "no-switch-range-to-icmp")
    s2l = ifelse(options.switchtolookup, "switch-to-lookup", "no-switch-to-lookup")
    keeploops = ifelse(options.keeploops, "keep-loops", "no-keep-loops")
    hoist = ifelse(options.hoistcommoninsts, "hoist-common-insts", "no-hoist-common-insts")
    sink = ifelse(options.sinkcommoninsts, "sink-common-insts", "no-sink-common-insts")
    bonus = "bonus-inst-threshold=$(options.bonusinstthreshold)"
    "<" * join([forward, s2i, s2l, keeploops, hoist, sink, bonus], ";") * ">"
end
@function_pass "simplifycfg" SimplifyCFGPass SimplifyCFGPassOptions

struct LoopVectorizePassOptions
    interleaveforcedonly::Core.Bool
    vectorizeforcedonly::Core.Bool
end
LoopVectorizePassOptions(; interleaveforcedonly::Core.Bool = false,
                          vectorizeforcedonly::Core.Bool = false) = LoopVectorizePassOptions(interleaveforcedonly, vectorizeforcedonly)
function options_string(options::LoopVectorizePassOptions)
    interleave = ifelse(options.interleaveforcedonly, "interleave-forced-only", "no-interleave-forced-only")
    vectorize = ifelse(options.vectorizeforcedonly, "vectorize-forced-only", "no-vectorize-forced-only")
    "<" * join([interleave, vectorize], ";") * ">"
end
@function_pass "loop-vectorize" LoopVectorizePass LoopVectorizePassOptions

struct MergedLoadStoreMotionPassOptions
    splitfooterbb::Core.Bool
end
MergedLoadStoreMotionPassOptions(; splitfooterbb::Core.Bool = false) = MergedLoadStoreMotionPassOptions(splitfooterbb)
options_string(options::MergedLoadStoreMotionPassOptions) = ifelse(options.splitfooterbb, "<split-footer-bb>", "<no-split-footer-bb>")
@function_pass "mldst-motion" MergedLoadStoreMotionPass MergedLoadStoreMotionPassOptions

struct GVNPassOptions
    allowpre::Union{Nothing, Core.Bool}
    allowloadpre::Union{Nothing, Core.Bool}
    allowloadpresplitbackedge::Union{Nothing, Core.Bool}
    allowmemdep::Union{Nothing, Core.Bool}
end
GVNPassOptions(; allowpre::Union{Nothing, Core.Bool} = nothing,
                allowloadpre::Union{Nothing, Core.Bool} = nothing,
                allowloadpresplitbackedge::Union{Nothing, Core.Bool} = nothing,
                allowmemdep::Union{Nothing, Core.Bool} = nothing) = GVNPassOptions(allowpre, allowloadpre, allowloadpresplitbackedge, allowmemdep)
function options_string(options::GVNPassOptions)
    final_options = String[]
    if options.allowpre !== nothing
        if options.allowpre
            push!(final_options, "pre")
        else
            push!(final_options, "no-pre")
        end
    end
    if options.allowloadpre !== nothing
        if options.allowloadpre
            push!(final_options, "load-pre")
        else
            push!(final_options, "no-load-pre")
        end
    end
    if options.allowloadpresplitbackedge !== nothing
        if options.allowloadpresplitbackedge
            push!(final_options, "split-backedge-load-pre")
        else
            push!(final_options, "no-split-backedge-load-pre")
        end
    end
    if options.allowmemdep !== nothing
        if options.allowmemdep
            push!(final_options, "memdep")
        else
            push!(final_options, "no-memdep")
        end
    end
    "<" * join(final_options, ";") * ">"
end
@function_pass "gvn" GVNPass GVNPassOptions

struct StackLifetimePrinterPassOptions
    must::Core.Bool
end
StackLifetimePrinterPassOptions(; must::Core.Bool = false) = StackLifetimePrinterPassOptions(must)
function options_string(options::StackLifetimePrinterPassOptions)
    ifelse(options.must, "<must>", "<may>")
end
@function_pass "print<stack-lifetime>" StackLifetimePrinterPass StackLifetimePrinterPassOptions

# Loop Nest Passes

@loop_pass "loop-flatten" LoopFlattenPass
@loop_pass "loop-interchange" LoopInterchangePass
@loop_pass "loop-unroll-and-jam" LoopUnrollAndJamPass
@loop_pass "no-op-loopnest" NoOpLoopNestPass

# Loop Passes

@loop_pass "canon-freeze" CanonicalizeFreezeInLoopsPass
@loop_pass "dot-ddg" DDGDotPrinterPass
# @loop_pass "invalidate<all>" InvalidateAllAnalysesPass
is_loop_pass(::Type{InvalidateAllAnalysesPass}) = true
@loop_pass "loop-idiom" LoopIdiomRecognizePass
@loop_pass "loop-instsimplify" LoopInstSimplifyPass
@loop_pass "loop-rotate" LoopRotatePass
@loop_pass "no-op-loop" NoOpLoopPass
@loop_pass "print" PrintLoopPass
@loop_pass "loop-deletion" LoopDeletionPass
@loop_pass "loop-simplifycfg" LoopSimplifyCFGPass
@loop_pass "loop-reduce" LoopStrengthReducePass
@loop_pass "indvars" IndVarSimplifyPass
@loop_pass "loop-unroll-full" LoopFullUnrollPass
@loop_pass "print-access-info" LoopAccessInfoPrinterPass
@loop_pass "print<ddg>" DDGAnalysisPrinterPass
@loop_pass "print<iv-users>" IVUsersPrinterPass
@loop_pass "print<loopnest>" LoopNestPrinterPass
@loop_pass "print<loop-cache-cost>" LoopCachePrinterPass
@loop_pass "loop-predication" LoopPredicationPass
# @loop_pass "guard-widening" GuardWideningPass
is_loop_pass(::Type{GuardWideningPass}) = true
@loop_pass "loop-bound-split" LoopBoundSplitPass
@loop_pass "loop-reroll" LoopRerollPass
@loop_pass "loop-versioning-licm" LoopVersioningLICMPass

# Loop Passes With Params

struct SimpleLoopUnswitchPassOptions
    nontrivial::Core.Bool
    trivial::Core.Bool
end
SimpleLoopUnswitchPassOptions(; nontrivial::Core.Bool = false, trivial::Core.Bool = true) = SimpleLoopUnswitchPassOptions(nontrivial, trivial)
function options_string(options::SimpleLoopUnswitchPassOptions)
    nontrivial = ifelse(options.nontrivial, "nontrivial", "no-nontrivial")
    trivial = ifelse(options.trivial, "trivial", "no-trivial")
    "<$nontrivial;$trivial>"
end
@loop_pass "simple-loop-unswitch" SimpleLoopUnswitchPass SimpleLoopUnswitchPassOptions

struct LICMPassOptions
    allowspeculation::Core.Bool
end
LICMPassOptions(; allowspeculation::Core.Bool = true) = LICMPassOptions(allowspeculation)
options_string(options::LICMPassOptions) = ifelse(options.allowspeculation, "<allowspeculation>", "<no-allowspeculation>")
@loop_pass "licm" LICMPass LICMPassOptions

const LNICMPassOptions = LICMPassOptions
@loop_pass "lnicm" LNICMPass LNICMPassOptions

# Add methods

function add!(pm::NewPMModulePassManager, pb::PassBuilder, pass::NewPMLLVMPass)
    if !is_module_pass(typeof(pass))
        throw(ArgumentError("Pass $pass is not a module pass"))
    end
    parse!(pb, pm, pass_string(pass))
end

function add!(pm::NewPMCGSCCPassManager, pb::PassBuilder, pass::NewPMLLVMPass)
    if !is_cgscc_pass(typeof(pass))
        throw(ArgumentError("Pass $pass is not a cgscc pass"))
    end
    parse!(pb, pm, pass_string(pass))
end

function add!(pm::NewPMFunctionPassManager, pb::PassBuilder, pass::NewPMLLVMPass)
    if !is_function_pass(typeof(pass))
        throw(ArgumentError("Pass $pass is not a function pass"))
    end
    parse!(pb, pm, pass_string(pass))
end

function add!(pm::NewPMLoopPassManager, pb::PassBuilder, pass::NewPMLLVMPass)
    if !is_loop_pass(typeof(pass))
        throw(ArgumentError("Pass $pass is not a loop pass"))
    end
    parse!(pb, pm, pass_string(pass))
end

function add!(pm::NewPMPassManager, pass::NewPMLLVMPass)
    add!(pm, passbuilder(pm), pass)
end

function run!(pm::NewPMModulePassManager, m::Module, tm::Union{Nothing,TargetMachine}=nothing, aa_stack::AbstractVector{<:NewPMAliasAnalysis}=NewPMAliasAnalysis[])
    pb = passbuilder(pm)
    analysis_managers(pb, tm, aa_stack) do lam, fam, cam, mam
        dispose(run!(pm, m, mam))
    end
end

function run!(pm::NewPMFunctionPassManager, f::Function, tm::Union{Nothing,TargetMachine}=nothing, aa_stack::AbstractVector{<:NewPMAliasAnalysis}=NewPMAliasAnalysis[])
    pb = passbuilder(pm)
    analysis_managers(pb, tm, aa_stack) do lam, fam, cam, mam
        dispose(run!(pm, f, fam))
    end
end

function run!(pass::NewPMLLVMPass, m::Module, tm::Union{Nothing,TargetMachine}=nothing, aa_stack::AbstractVector{<:NewPMAliasAnalysis}=NewPMAliasAnalysis[])
    needs_globals_aa_recompute = any(aa_stack) do aa
        isa(aa, GlobalsAA)
    end
    @dispose pic=StandardInstrumentationCallbacks() pb=PassBuilder(tm, pic) mpm=NewPMModulePassManager(pb) begin
        # GlobalsAA needs to be computed before it can be used
        if needs_globals_aa_recompute
            add!(mpm, RecomputeGlobalsAAPass())
        end
        if is_module_pass(typeof(pass))
            add!(mpm, pb, pass)
        elseif is_cgscc_pass(typeof(pass))
            add!(mpm, NewPMCGSCCPassManager) do cpm
                add!(cpm, pass)
            end
        elseif is_function_pass(typeof(pass))
            add!(mpm, NewPMFunctionPassManager) do fpm
                add!(fpm, pass)
            end
        else
            @assert is_loop_pass(typeof(pass))
            add!(mpm, NewPMFunctionPassManager) do fpm
                add!(fpm, NewPMLoopPassManager) do lpm
                    add!(lpm, pass)
                end
            end
        end
        run!(mpm, m, tm, aa_stack)
    end
end

function run!(pass::NewPMLLVMPass, f::Function, tm::Union{Nothing,TargetMachine}=nothing, aa_stack::AbstractVector{<:NewPMAliasAnalysis}=NewPMAliasAnalysis[])
    needs_globals_aa_recompute = any(aa_stack) do aa
        isa(aa, GlobalsAA)
    end
    if needs_globals_aa_recompute
        throw(ArgumentError("GlobalsAA needs to be computed on a module, not a function!"))
    end
    @dispose pic=StandardInstrumentationCallbacks() pb=PassBuilder(tm, pic) fpm=NewPMFunctionPassManager(pb) begin
        if is_function_pass(typeof(pass))
            add!(fpm, pb, pass)
        elseif is_loop_pass(typeof(pass))
            add!(fpm, NewPMLoopPassManager) do lpm
                add!(lpm, pass)
            end
        else
            throw(ArgumentError("Pass $pass is not a function or loop pass"))
        end
        run!(fpm, f, tm, aa_stack)
    end
end
