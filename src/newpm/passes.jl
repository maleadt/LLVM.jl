export Pass, LLVMPass
export is_module_pass, is_cgscc_pass, is_function_pass, is_loop_pass, pass_string

# Export all the passes

export AlwaysInlinerPass,
    AttributorPass,
    Annotation2MetadataPass,
    OpenMPOptPass,
    CalledValuePropagationPass,
    CanonicalizeAliasesPass,
    CGProfilePass,
    NewPMCheckDebugifyPass,
    ConstantMergePass,
    CoroEarlyPass,
    CoroCleanupPass,
    CrossDSOCFIPass,
    DeadArgumentEliminationPass,
    NewPMDebugifyPass,
    CallGraphDOTPrinterPass,
    EliminateAvailableExternallyPass,
    BlockExtractorPass,
    ForceFunctionAttrsPass,
    FunctionImportPass,
    FunctionSpecializationPass,
    GlobalDCEPass,
    GlobalOptPass,
    GlobalSplitPass,
    HotColdSplittingPass,
    InferFunctionAttrsPass,
    ModuleInlinerWrapperPass,
    ModuleInlinerWrapperPass,
    InlineAdvisorAnalysisPrinterPass,
    ModuleInlinerWrapperPass,
    GCOVProfilerPass,
    InstrOrderFilePass,
    InternalizePass,
    InvalidateAllAnalysesPass,
    IPSCCPPass,
    IROutlinerPass,
    IRSimilarityAnalysisPrinterPass,
    LowerGlobalDtorsPass,
    LowerTypeTestsPass,
    MetaRenamerPass,
    MergeFunctionsPass,
    NameAnonGlobalPass,
    NoOpModulePass,
    ObjCARCAPElimPass,
    PartialInlinerPass,
    ProfileSummaryPrinterPass,
    CallGraphPrinterPass,
    PrintModulePass,
    LazyCallGraphPrinterPass,
    LazyCallGraphDOTPrinterPass,
    MustBeExecutedContextPrinterPass,
    StackSafetyGlobalPrinterPass,
    ModuleDebugInfoPrinterPass,
    RecomputeGlobalsAAPass,
    RelLookupTableConverterPass,
    RewriteSymbolPass,
    ReversePostOrderFunctionAttrsPass,
    SampleProfileLoaderPass,
    StripSymbolsPass,
    StripDeadDebugInfoPass,
    SampleProfileProbePass,
    StripDeadPrototypesPass,
    StripDebugDeclarePass,
    StripNonDebugSymbolsPass,
    StripNonLineTableDebugInfoPass,
    TriggerCrashPass,
    VerifierPass,
    CallGraphViewerPass,
    WholeProgramDevirtPass,
    DataFlowSanitizerPass,
    ModuleMemorySanitizerPass,
    ModuleInlinerPass,
    ModuleThreadSanitizerPass,
    ModuleSanitizerCoveragePass,
    ModuleMemProfilerPass,
    PoisonCheckingPass,
    PseudoProbeUpdatePass,
    LoopExtractorPass,
    HWAddressSanitizerPass,
    ModuleAddressSanitizerPass,
    ArgumentPromotionPass,
    InvalidateAllAnalysesPass,
    PostOrderFunctionAttrsPass,
    AttributorCGSCCPass,
    OpenMPOptCGSCCPass,
    NoOpCGSCCPass,
    InlinerPass,
    CoroSplitPass,
    ADCEPass,
    AddDiscriminatorsPass,
    AggressiveInstCombinePass,
    AssumeBuilderPass,
    AssumeSimplifyPass,
    AlignmentFromAssumptionsPass,
    AnnotationRemarksPass,
    BDCEPass,
    BoundsCheckingPass,
    BreakCriticalEdgesPass,
    CallSiteSplittingPass,
    ConstantHoistingPass,
    ConstraintEliminationPass,
    ControlHeightReductionPass,
    CoroElidePass,
    CorrelatedValuePropagationPass,
    DCEPass,
    DFAJumpThreadingPass,
    DivRemPairsPass,
    DSEPass,
    CFGPrinterPass,
    CFGOnlyPrinterPass,
    FixIrreduciblePass,
    FlattenCFGPass,
    MakeGuardsExplicitPass,
    GVNHoistPass,
    GVNSinkPass,
    HelloWorldPass,
    InferAddressSpacesPass,
    InstCombinePass,
    InstCountPass,
    InstSimplifyPass,
    InvalidateAllAnalysesPass,
    IRCEPass,
    Float2IntPass,
    NoOpFunctionPass,
    LibCallsShrinkWrapPass,
    LintPass,
    InstructionNamerPass,
    LowerAtomicPass,
    LowerExpectIntrinsicPass,
    LowerGuardIntrinsicPass,
    LowerConstantIntrinsicsPass,
    LowerWidenableConditionPass,
    GuardWideningPass,
    LoadStoreVectorizerPass,
    LoopSimplifyPass,
    LoopSinkPass,
    LowerInvokePass,
    LowerSwitchPass,
    PromotePass,
    MemCpyOptPass,
    MergeICmpsPass,
    UnifyFunctionExitNodesPass,
    NaryReassociatePass,
    NewGVNPass,
    JumpThreadingPass,
    PartiallyInlineLibCallsPass,
    LCSSAPass,
    LoopDataPrefetchPass,
    LoopLoadEliminationPass,
    LoopFusePass,
    LoopDistributePass,
    LoopVersioningPass,
    ObjCARCOptPass,
    ObjCARCContractPass,
    ObjCARCExpandPass,
    PrintFunctionPass,
    AssumptionPrinterPass,
    BlockFrequencyPrinterPass,
    BranchProbabilityPrinterPass,
    CostModelPrinterPass,
    CycleInfoPrinterPass,
    DependenceAnalysisPrinterPass,
    DivergenceAnalysisPrinterPass,
    DominatorTreePrinterPass,
    PostDominatorTreePrinterPass,
    DelinearizationPrinterPass,
    DemandedBitsPrinterPass,
    DominanceFrontierPrinterPass,
    FunctionPropertiesPrinterPass,
    InlineCostAnnotationPrinterPass,
    LoopPrinterPass,
    MemorySSAPrinterPass,
    MemorySSAWalkerPrinterPass,
    PhiValuesPrinterPass,
    RegionInfoPrinterPass,
    ScalarEvolutionPrinterPass,
    StackSafetyPrinterPass,
    AliasSetsPrinterPass,
    PredicateInfoPrinterPass,
    MustExecutePrinterPass,
    MemDerefPrinterPass,
    ReassociatePass,
    RedundantDbgInstEliminationPass,
    RegToMemPass,
    ScalarizeMaskedMemIntrinPass,
    ScalarizerPass,
    SeparateConstOffsetFromGEPPass,
    SCCPPass,
    SinkingPass,
    SLPVectorizerPass,
    StraightLineStrengthReducePass,
    SpeculativeExecutionPass,
    SROAPass,
    StructurizeCFGPass,
    TailCallElimPass,
    UnifyLoopExitsPass,
    VectorCombinePass,
    VerifierPass,
    DominatorTreeVerifierPass,
    LoopVerifierPass,
    MemorySSAVerifierPass,
    RegionInfoVerifierPass,
    SafepointIRVerifierPass,
    ScalarEvolutionVerifierPass,
    CFGViewerPass,
    CFGOnlyViewerPass,
    TLSVariableHoistPass,
    WarnMissedTransformationsPass,
    ThreadSanitizerPass,
    MemProfilerPass,
    EarlyCSEPass,
    EntryExitInstrumenterPass,
    LowerMatrixIntrinsicsPass,
    LoopUnrollPass,
    MemorySanitizerPass,
    SimplifyCFGPass,
    LoopVectorizePass,
    MergedLoadStoreMotionPass,
    GVNPass,
    StackLifetimePrinterPass,
    LoopFlattenPass,
    LoopInterchangePass,
    LoopUnrollAndJamPass,
    NoOpLoopNestPass,
    CanonicalizeFreezeInLoopsPass,
    DDGDotPrinterPass,
    InvalidateAllAnalysesPass,
    LoopIdiomRecognizePass,
    LoopInstSimplifyPass,
    LoopRotatePass,
    NoOpLoopPass,
    PrintLoopPass,
    LoopDeletionPass,
    LoopSimplifyCFGPass,
    LoopStrengthReducePass,
    IndVarSimplifyPass,
    LoopFullUnrollPass,
    LoopAccessInfoPrinterPass,
    DDGAnalysisPrinterPass,
    IVUsersPrinterPass,
    LoopNestPrinterPass,
    LoopCachePrinterPass,
    LoopPredicationPass,
    GuardWideningPass,
    LoopBoundSplitPass,
    LoopRerollPass,
    LoopVersioningLICMPass,
    SimpleLoopUnswitchPass,
    LICMPass,
    LNICMPass

abstract type Pass end
abstract type LLVMPass <: Pass end

is_module_pass(::Type{LLVMPass}) = false
is_cgscc_pass(::Type{LLVMPass}) = false
is_function_pass(::Type{LLVMPass}) = false
is_loop_pass(::Type{LLVMPass}) = false

Base.show(io::IO, pass::LLVMPass) = print(io, pass_string(pass))

# Module passes

struct AlwaysInlinerPass <: LLVMPass end
is_module_pass(::Type{AlwaysInlinerPass}) = true
pass_string(::AlwaysInlinerPass) = "always-inline"
struct AttributorPass <: LLVMPass end
is_module_pass(::Type{AttributorPass}) = true
pass_string(::AttributorPass) = "attributor"
struct Annotation2MetadataPass <: LLVMPass end
is_module_pass(::Type{Annotation2MetadataPass}) = true
pass_string(::Annotation2MetadataPass) = "annotation2metadata"
struct OpenMPOptPass <: LLVMPass end
is_module_pass(::Type{OpenMPOptPass}) = true
pass_string(::OpenMPOptPass) = "openmp-opt"
struct CalledValuePropagationPass <: LLVMPass end
is_module_pass(::Type{CalledValuePropagationPass}) = true
pass_string(::CalledValuePropagationPass) = "called-value-propagation"
struct CanonicalizeAliasesPass <: LLVMPass end
is_module_pass(::Type{CanonicalizeAliasesPass}) = true
pass_string(::CanonicalizeAliasesPass) = "canonicalize-aliases"
struct CGProfilePass <: LLVMPass end
is_module_pass(::Type{CGProfilePass}) = true
pass_string(::CGProfilePass) = "cg-profile"
struct NewPMCheckDebugifyPass <: LLVMPass end
is_module_pass(::Type{NewPMCheckDebugifyPass}) = true
pass_string(::NewPMCheckDebugifyPass) = "check-debugify"
struct ConstantMergePass <: LLVMPass end
is_module_pass(::Type{ConstantMergePass}) = true
pass_string(::ConstantMergePass) = "constmerge"
struct CoroEarlyPass <: LLVMPass end
is_module_pass(::Type{CoroEarlyPass}) = true
pass_string(::CoroEarlyPass) = "coro-early"
struct CoroCleanupPass <: LLVMPass end
is_module_pass(::Type{CoroCleanupPass}) = true
pass_string(::CoroCleanupPass) = "coro-cleanup"
struct CrossDSOCFIPass <: LLVMPass end
is_module_pass(::Type{CrossDSOCFIPass}) = true
pass_string(::CrossDSOCFIPass) = "cross-dso-cfi"
struct DeadArgumentEliminationPass <: LLVMPass end
is_module_pass(::Type{DeadArgumentEliminationPass}) = true
pass_string(::DeadArgumentEliminationPass) = "deadargelim"
struct NewPMDebugifyPass <: LLVMPass end
is_module_pass(::Type{NewPMDebugifyPass}) = true
pass_string(::NewPMDebugifyPass) = "debugify"
struct CallGraphDOTPrinterPass <: LLVMPass end
is_module_pass(::Type{CallGraphDOTPrinterPass}) = true
pass_string(::CallGraphDOTPrinterPass) = "dot-callgraph"
struct EliminateAvailableExternallyPass <: LLVMPass end
is_module_pass(::Type{EliminateAvailableExternallyPass}) = true
pass_string(::EliminateAvailableExternallyPass) = "elim-avail-extern"
struct BlockExtractorPass <: LLVMPass end
is_module_pass(::Type{BlockExtractorPass}) = true
pass_string(::BlockExtractorPass) = "extract-blocks"
struct ForceFunctionAttrsPass <: LLVMPass end
is_module_pass(::Type{ForceFunctionAttrsPass}) = true
pass_string(::ForceFunctionAttrsPass) = "forceattrs"
struct FunctionImportPass <: LLVMPass end
is_module_pass(::Type{FunctionImportPass}) = true
pass_string(::FunctionImportPass) = "function-import"
struct FunctionSpecializationPass <: LLVMPass end
is_module_pass(::Type{FunctionSpecializationPass}) = true
pass_string(::FunctionSpecializationPass) = "function-specialization"
struct GlobalDCEPass <: LLVMPass end
is_module_pass(::Type{GlobalDCEPass}) = true
pass_string(::GlobalDCEPass) = "globaldce"
struct GlobalOptPass <: LLVMPass end
is_module_pass(::Type{GlobalOptPass}) = true
pass_string(::GlobalOptPass) = "globalopt"
struct GlobalSplitPass <: LLVMPass end
is_module_pass(::Type{GlobalSplitPass}) = true
pass_string(::GlobalSplitPass) = "globalsplit"
struct HotColdSplittingPass <: LLVMPass end
is_module_pass(::Type{HotColdSplittingPass}) = true
pass_string(::HotColdSplittingPass) = "hotcoldsplit"
struct InferFunctionAttrsPass <: LLVMPass end
is_module_pass(::Type{InferFunctionAttrsPass}) = true
pass_string(::InferFunctionAttrsPass) = "inferattrs"
struct ModuleInlinerWrapperPass <: LLVMPass end
is_module_pass(::Type{ModuleInlinerWrapperPass}) = true
pass_string(::ModuleInlinerWrapperPass) = "inliner-wrapper"
struct ModuleInlinerWrapperPass <: LLVMPass end
is_module_pass(::Type{ModuleInlinerWrapperPass}) = true
pass_string(::ModuleInlinerWrapperPass) = "inliner-ml-advisor-release"
struct InlineAdvisorAnalysisPrinterPass <: LLVMPass end
is_module_pass(::Type{InlineAdvisorAnalysisPrinterPass}) = true
pass_string(::InlineAdvisorAnalysisPrinterPass) = "print<inline-advisor>"
struct ModuleInlinerWrapperPass <: LLVMPass end
is_module_pass(::Type{ModuleInlinerWrapperPass}) = true
pass_string(::ModuleInlinerWrapperPass) = "inliner-wrapper-no-mandatory-first"
struct GCOVProfilerPass <: LLVMPass end
is_module_pass(::Type{GCOVProfilerPass}) = true
pass_string(::GCOVProfilerPass) = "insert-gcov-profiling"
struct InstrOrderFilePass <: LLVMPass end
is_module_pass(::Type{InstrOrderFilePass}) = true
pass_string(::InstrOrderFilePass) = "instrorderfile"
struct InternalizePass <: LLVMPass end
is_module_pass(::Type{InternalizePass}) = true
pass_string(::InternalizePass) = "internalize"
struct InvalidateAllAnalysesPass <: LLVMPass end
is_module_pass(::Type{InvalidateAllAnalysesPass}) = true
pass_string(::InvalidateAllAnalysesPass) = "invalidate<all>"
struct IPSCCPPass <: LLVMPass end
is_module_pass(::Type{})
pass_string(::IPSCCPPass) = "ipscc::p" = true
struct IROutlinerPass <: LLVMPass end
is_module_pass(::Type{IROutlinerPass}) = true
pass_string(::IROutlinerPass) = "iroutliner"
struct IRSimilarityAnalysisPrinterPass <: LLVMPass end
is_module_pass(::Type{IRSimilarityAnalysisPrinterPass}) = true
pass_string(::IRSimilarityAnalysisPrinterPass) = "print-ir-similarity"
struct LowerGlobalDtorsPass <: LLVMPass end
is_module_pass(::Type{LowerGlobalDtorsPass}) = true
pass_string(::LowerGlobalDtorsPass) = "lower-global-dtors"
struct LowerTypeTestsPass <: LLVMPass end
is_module_pass(::Type{LowerTypeTestsPass}) = true
pass_string(::LowerTypeTestsPass) = "lowertypetests"
struct MetaRenamerPass <: LLVMPass end
is_module_pass(::Type{MetaRenamerPass}) = true
pass_string(::MetaRenamerPass) = "metarenamer"
struct MergeFunctionsPass <: LLVMPass end
is_module_pass(::Type{MergeFunctionsPass}) = true
pass_string(::MergeFunctionsPass) = "mergefunc"
struct NameAnonGlobalPass <: LLVMPass end
is_module_pass(::Type{NameAnonGlobalPass}) = true
pass_string(::NameAnonGlobalPass) = "name-anon-globals"
struct NoOpModulePass <: LLVMPass end
is_module_pass(::Type{NoOpModulePass}) = true
pass_string(::NoOpModulePass) = "no-op-module"
struct ObjCARCAPElimPass <: LLVMPass end
is_module_pass(::Type{ObjCARCAPElimPass}) = true
pass_string(::ObjCARCAPElimPass) = "objc-arc-apelim"
struct PartialInlinerPass <: LLVMPass end
is_module_pass(::Type{PartialInlinerPass}) = true
pass_string(::PartialInlinerPass) = "partial-inliner"
struct ProfileSummaryPrinterPass <: LLVMPass end
is_module_pass(::Type{ProfileSummaryPrinterPass}) = true
pass_string(::ProfileSummaryPrinterPass) = "print-profile-summary"
struct CallGraphPrinterPass <: LLVMPass end
is_module_pass(::Type{CallGraphPrinterPass}) = true
pass_string(::CallGraphPrinterPass) = "print-callgraph"
struct PrintModulePass <: LLVMPass end
is_module_pass(::Type{PrintModulePass}) = true
pass_string(::PrintModulePass) = "print"
struct LazyCallGraphPrinterPass <: LLVMPass end
is_module_pass(::Type{LazyCallGraphPrinterPass}) = true
pass_string(::LazyCallGraphPrinterPass) = "print-lcg"
struct LazyCallGraphDOTPrinterPass <: LLVMPass end
is_module_pass(::Type{LazyCallGraphDOTPrinterPass}) = true
pass_string(::LazyCallGraphDOTPrinterPass) = "print-lcg-dot"
struct MustBeExecutedContextPrinterPass <: LLVMPass end
is_module_pass(::Type{MustBeExecutedContextPrinterPass}) = true
pass_string(::MustBeExecutedContextPrinterPass) = "print-must-be-executed-contexts"
struct StackSafetyGlobalPrinterPass <: LLVMPass end
is_module_pass(::Type{StackSafetyGlobalPrinterPass}) = true
pass_string(::StackSafetyGlobalPrinterPass) = "print-stack-safety"
struct ModuleDebugInfoPrinterPass <: LLVMPass end
is_module_pass(::Type{ModuleDebugInfoPrinterPass}) = true
pass_string(::ModuleDebugInfoPrinterPass) = "print<module-debuginfo>"
struct RecomputeGlobalsAAPass <: LLVMPass end
is_module_pass(::Type{RecomputeGlobalsAAPass}) = true
pass_string(::RecomputeGlobalsAAPass) = "recompute-globalsaa"
struct RelLookupTableConverterPass <: LLVMPass end
is_module_pass(::Type{RelLookupTableConverterPass}) = true
pass_string(::RelLookupTableConverterPass) = "rel-lookup-table-converter"
struct RewriteSymbolPass <: LLVMPass end
is_module_pass(::Type{RewriteSymbolPass}) = true
pass_string(::RewriteSymbolPass) = "rewrite-symbols"
struct ReversePostOrderFunctionAttrsPass <: LLVMPass end
is_module_pass(::Type{ReversePostOrderFunctionAttrsPass}) = true
pass_string(::ReversePostOrderFunctionAttrsPass) = "rpo-function-attrs"
struct SampleProfileLoaderPass <: LLVMPass end
is_module_pass(::Type{SampleProfileLoaderPass}) = true
pass_string(::SampleProfileLoaderPass) = "sample-profile"
struct StripSymbolsPass <: LLVMPass end
is_module_pass(::Type{StripSymbolsPass}) = true
pass_string(::StripSymbolsPass) = "strip"
struct StripDeadDebugInfoPass <: LLVMPass end
is_module_pass(::Type{StripDeadDebugInfoPass}) = true
pass_string(::StripDeadDebugInfoPass) = "strip-dead-debug-info"
struct SampleProfileProbePass <: LLVMPass end
is_module_pass(::Type{SampleProfileProbePass}) = true
pass_string(::SampleProfileProbePass) = "pseudo-probe"
struct StripDeadPrototypesPass <: LLVMPass end
is_module_pass(::Type{StripDeadPrototypesPass}) = true
pass_string(::StripDeadPrototypesPass) = "strip-dead-prototypes"
struct StripDebugDeclarePass <: LLVMPass end
is_module_pass(::Type{StripDebugDeclarePass}) = true
pass_string(::StripDebugDeclarePass) = "strip-debug-declare"
struct StripNonDebugSymbolsPass <: LLVMPass end
is_module_pass(::Type{StripNonDebugSymbolsPass}) = true
pass_string(::StripNonDebugSymbolsPass) = "strip-nondebug"
struct StripNonLineTableDebugInfoPass <: LLVMPass end
is_module_pass(::Type{StripNonLineTableDebugInfoPass}) = true
pass_string(::StripNonLineTableDebugInfoPass) = "strip-nonlinetable-debuginfo"
struct TriggerCrashPass <: LLVMPass end
is_module_pass(::Type{TriggerCrashPass}) = true
pass_string(::TriggerCrashPass) = "trigger-crash"
struct VerifierPass <: LLVMPass end
is_module_pass(::Type{VerifierPass}) = true
pass_string(::VerifierPass) = "verify"
struct CallGraphViewerPass <: LLVMPass end
is_module_pass(::Type{CallGraphViewerPass}) = true
pass_string(::CallGraphViewerPass) = "view-callgraph"
struct WholeProgramDevirtPass <: LLVMPass end
is_module_pass(::Type{WholeProgramDevirtPass}) = true
pass_string(::WholeProgramDevirtPass) = "wholeprogramdevirt"
struct DataFlowSanitizerPass <: LLVMPass end
is_module_pass(::Type{DataFlowSanitizerPass}) = true
pass_string(::DataFlowSanitizerPass) = "dfsan"
struct ModuleMemorySanitizerPass <: LLVMPass end
is_module_pass(::Type{ModuleMemorySanitizerPass}) = true
pass_string(::ModuleMemorySanitizerPass) = "msan-module"
struct ModuleInlinerPass <: LLVMPass end
is_module_pass(::Type{ModuleInlinerPass}) = true
pass_string(::ModuleInlinerPass) = "module-inline"
struct ModuleThreadSanitizerPass <: LLVMPass end
is_module_pass(::Type{ModuleThreadSanitizerPass}) = true
pass_string(::ModuleThreadSanitizerPass) = "tsan-module"
struct ModuleSanitizerCoveragePass <: LLVMPass end
is_module_pass(::Type{ModuleSanitizerCoveragePass}) = true
pass_string(::ModuleSanitizerCoveragePass) = "sancov-module"
struct ModuleMemProfilerPass <: LLVMPass end
is_module_pass(::Type{ModuleMemProfilerPass}) = true
pass_string(::ModuleMemProfilerPass) = "memprof-module"
struct PoisonCheckingPass <: LLVMPass end
is_module_pass(::Type{PoisonCheckingPass}) = true
pass_string(::PoisonCheckingPass) = "poison-checking"
struct PseudoProbeUpdatePass <: LLVMPass end
is_module_pass(::Type{PseudoProbeUpdatePass}) = true
pass_string(::PseudoProbeUpdatePass) = "pseudo-probe-update"

# Module Passes With Params

struct LoopExtractorPassOptions
    single::Core.Bool
end
LoopExtractorPassOptions() = LoopExtractorPassOptions(false)
struct LoopExtractorPass <: LLVMPass
    options::LoopExtractorPassOptions
end
LoopExtractorPass() = LoopExtractorPass(LoopExtractorPassOptions())
is_module_pass(::Type{LoopExtractorPass}) = true
pass_string(pass::LoopExtractorPass) = ifelse(pass.options.single, "loop-extract<single>", "loop-extract")

struct HWAddressSanitizerPassOptions
    kernel::Core.Bool
    recover::Core.Bool
end
HWAddressSanitizerPassOptions() = HWAddressSanitizerPassOptions(false, false)
struct HWAddressSanitizerPass <: LLVMPass
    options::HWAddressSanitizerPassOptions
end
HWAddressSanitizerPass() = HWAddressSanitizerPass(HWAddressSanitizerPassOptions())
is_module_pass(::Type{HWAddressSanitizerPass}) = true
function pass_string(pass::HWAddressSanitizerPass)
    name = "hwasan"
    options = String[]
    if pass.options.kernel
        push!(options, "kernel")
    end
    if pass.options.recover
        push(options, "recover")
    end
    if !isempty(options)
        name *= "<" * join(options, ",") * ">"
    end
    name
end
struct ModuleAddressSanitizerPassOptions
    kernel::Core.Bool
end
ModuleAddressSanitizerPassOptions() = ModuleAddressSanitizerPassOptions(false)
struct ModuleAddressSanitizerPass <: LLVMPass
    options::ModuleAddressSanitizerPassOptions
end
ModuleAddressSanitizerPass() = ModuleAddressSanitizerPass(ModuleAddressSanitizerPassOptions())
is_module_pass(::Type{ModuleAddressSanitizerPass}) = true
pass_string(pass::ModuleAddressSanitizerPass) = ifelse(pass.options.kernel, "asan-module<kernel>", "asan-module")

# CGSCC Passes

struct ArgumentPromotionPass <: LLVMPass end
is_cgscc_pass(::Type{ArgumentPromotionPass}) = true
pass_string(::ArgumentPromotionPass) = "argpromotion"
struct InvalidateAllAnalysesPass <: LLVMPass end
is_cgscc_pass(::Type{InvalidateAllAnalysesPass}) = true
pass_string(::InvalidateAllAnalysesPass) = "invalidate<all>"
struct PostOrderFunctionAttrsPass <: LLVMPass end
is_cgscc_pass(::Type{PostOrderFunctionAttrsPass}) = true
pass_string(::PostOrderFunctionAttrsPass) = "function-attrs"
struct AttributorCGSCCPass <: LLVMPass end
is_cgscc_pass(::Type{AttributorCGSCCPass}) = true
pass_string(::AttributorCGSCCPass) = "attributor-cgscc"
struct OpenMPOptCGSCCPass <: LLVMPass end
is_cgscc_pass(::Type{OpenMPOptCGSCCPass}) = true
pass_string(::OpenMPOptCGSCCPass) = "openmp-opt-cgscc"
struct NoOpCGSCCPass <: LLVMPass end
is_cgscc_pass(::Type{NoOpCGSCCPass}) = true
pass_string(::NoOpCGSCCPass) = "no-op-cgscc"

# CGSCC Passes With Params

struct InlinerPassOptions
    onlymandatory::Core.Bool
end
InlinerPassOptions() = InlinerPassOptions(false)
struct InlinerPass <: LLVMPass
    options::InlinerPassOptions
end
InlinerPass() = InlinerPass(InlinerPassOptions())
is_cgscc_pass(::Type{InlinerPass}) = true
pass_string(pass::InlinerPass) = ifelse(pass.options.onlymandatory, "inline<only-mandatory>", "inline")
struct CoroSplitPassOptions
    reusestorage::Core.Bool
end
CoroSplitPassOptions() = CoroSplitPassOptions(false)
struct CoroSplitPass <: LLVMPass
    options::CoroSplitPassOptions
end
CoroSplitPass() = CoroSplitPass(CoroSplitPassOptions())
is_cgscc_pass(::Type{CoroSplitPass}) = true
pass_string(pass::CoroSplitPass) = ifelse(pass.options.reusestorage, "coro-split<reuse-storage>", "coro-split")

# Function Passes

struct AAEvaluator end
is_function_pass(::Type{AAEvaluator}) = true
pass_string(::AAEvaluator) = "aa-eval"
struct ADCEPass <: LLVMPass end
is_function_pass(::Type{ADCEPass}) = true
pass_string(::ADCEPass) = "adce"
struct AddDiscriminatorsPass <: LLVMPass end
is_function_pass(::Type{AddDiscriminatorsPass}) = true
pass_string(::AddDiscriminatorsPass) = "add-discriminators"
struct AggressiveInstCombinePass <: LLVMPass end
is_function_pass(::Type{AggressiveInstCombinePass}) = true
pass_string(::AggressiveInstCombinePass) = "aggressive-instcombine"
struct AssumeBuilderPass <: LLVMPass end
is_function_pass(::Type{AssumeBuilderPass}) = true
pass_string(::AssumeBuilderPass) = "assume-builder"
struct AssumeSimplifyPass <: LLVMPass end
is_function_pass(::Type{AssumeSimplifyPass}) = true
pass_string(::AssumeSimplifyPass) = "assume-simplify"
struct AlignmentFromAssumptionsPass <: LLVMPass end
is_function_pass(::Type{AlignmentFromAssumptionsPass}) = true
pass_string(::AlignmentFromAssumptionsPass) = "alignment-from-assumptions"
struct AnnotationRemarksPass <: LLVMPass end
is_function_pass(::Type{AnnotationRemarksPass}) = true
pass_string(::AnnotationRemarksPass) = "annotation-remarks"
struct BDCEPass <: LLVMPass end
is_function_pass(::Type{BDCEPass}) = true
pass_string(::BDCEPass) = "bdce"
struct BoundsCheckingPass <: LLVMPass end
is_function_pass(::Type{BoundsCheckingPass}) = true
pass_string(::BoundsCheckingPass) = "bounds-checking"
struct BreakCriticalEdgesPass <: LLVMPass end
is_function_pass(::Type{BreakCriticalEdgesPass}) = true
pass_string(::BreakCriticalEdgesPass) = "break-crit-edges"
struct CallSiteSplittingPass <: LLVMPass end
is_function_pass(::Type{CallSiteSplittingPass}) = true
pass_string(::CallSiteSplittingPass) = "callsite-splitting"
struct ConstantHoistingPass <: LLVMPass end
is_function_pass(::Type{ConstantHoistingPass}) = true
pass_string(::ConstantHoistingPass) = "consthoist"
struct ConstraintEliminationPass <: LLVMPass end
is_function_pass(::Type{ConstraintEliminationPass}) = true
pass_string(::ConstraintEliminationPass) = "constraint-elimination"
struct ControlHeightReductionPass <: LLVMPass end
is_function_pass(::Type{ControlHeightReductionPass}) = true
pass_string(::ControlHeightReductionPass) = "chr"
struct CoroElidePass <: LLVMPass end
is_function_pass(::Type{CoroElidePass}) = true
pass_string(::CoroElidePass) = "coro-elide"
struct CorrelatedValuePropagationPass <: LLVMPass end
is_function_pass(::Type{CorrelatedValuePropagationPass}) = true
pass_string(::CorrelatedValuePropagationPass) = "correlated-propagation"
struct DCEPass <: LLVMPass end
is_function_pass(::Type{DCEPass}) = true
pass_string(::DCEPass) = "dce"
struct DFAJumpThreadingPass <: LLVMPass end
is_function_pass(::Type{DFAJumpThreadingPass}) = true
pass_string(::DFAJumpThreadingPass) = "dfa-jump-threading"
struct DivRemPairsPass <: LLVMPass end
is_function_pass(::Type{DivRemPairsPass}) = true
pass_string(::DivRemPairsPass) = "div-rem-pairs"
struct DSEPass <: LLVMPass end
is_function_pass(::Type{DSEPass}) = true
pass_string(::DSEPass) = "dse"
struct CFGPrinterPass <: LLVMPass end
is_function_pass(::Type{CFGPrinterPass}) = true
pass_string(::CFGPrinterPass) = "dot-cfg"
struct CFGOnlyPrinterPass <: LLVMPass end
is_function_pass(::Type{CFGOnlyPrinterPass}) = true
pass_string(::CFGOnlyPrinterPass) = "dot-cfg-only"
struct DomPrinter end
is_function_pass(::Type{DomPrinter}) = true
pass_string(::DomPrinter) = "dot-dom"
struct DomOnlyPrinter end
is_function_pass(::Type{DomOnlyPrinter}) = true
pass_string(::DomOnlyPrinter) = "dot-dom-only"
struct PostDomPrinter end
is_function_pass(::Type{PostDomPrinter}) = true
pass_string(::PostDomPrinter) = "dot-post-dom"
struct PostDomOnlyPrinter end
is_function_pass(::Type{PostDomOnlyPrinter}) = true
pass_string(::PostDomOnlyPrinter) = "dot-post-dom-only"
struct DomViewer end
is_function_pass(::Type{DomViewer}) = true
pass_string(::DomViewer) = "view-dom"
struct DomOnlyViewer end
is_function_pass(::Type{DomOnlyViewer}) = true
pass_string(::DomOnlyViewer) = "view-dom-only"
struct PostDomViewer end
is_function_pass(::Type{PostDomViewer}) = true
pass_string(::PostDomViewer) = "view-post-dom"
struct PostDomOnlyViewer end
is_function_pass(::Type{PostDomOnlyViewer}) = true
pass_string(::PostDomOnlyViewer) = "view-post-dom-only"
struct FixIrreduciblePass <: LLVMPass end
is_function_pass(::Type{FixIrreduciblePass}) = true
pass_string(::FixIrreduciblePass) = "fix-irreducible"
struct FlattenCFGPass <: LLVMPass end
is_function_pass(::Type{FlattenCFGPass}) = true
pass_string(::FlattenCFGPass) = "flattencfg"
struct MakeGuardsExplicitPass <: LLVMPass end
is_function_pass(::Type{MakeGuardsExplicitPass}) = true
pass_string(::MakeGuardsExplicitPass) = "make-guards-explicit"
struct GVNHoistPass <: LLVMPass end
is_function_pass(::Type{GVNHoistPass}) = true
pass_string(::GVNHoistPass) = "gvn-hoist"
struct GVNSinkPass <: LLVMPass end
is_function_pass(::Type{GVNSinkPass}) = true
pass_string(::GVNSinkPass) = "gvn-sink"
struct HelloWorldPass <: LLVMPass end
is_function_pass(::Type{HelloWorldPass}) = true
pass_string(::HelloWorldPass) = "helloworld"
struct InferAddressSpacesPass <: LLVMPass end
is_function_pass(::Type{InferAddressSpacesPass}) = true
pass_string(::InferAddressSpacesPass) = "infer-address-spaces"
struct InstCombinePass <: LLVMPass end
is_function_pass(::Type{InstCombinePass}) = true
pass_string(::InstCombinePass) = "instcombine"
struct InstCountPass <: LLVMPass end
is_function_pass(::Type{InstCountPass}) = true
pass_string(::InstCountPass) = "instcount"
struct InstSimplifyPass <: LLVMPass end
is_function_pass(::Type{InstSimplifyPass}) = true
pass_string(::InstSimplifyPass) = "instsimplify"
struct InvalidateAllAnalysesPass <: LLVMPass end
is_function_pass(::Type{InvalidateAllAnalysesPass}) = true
pass_string(::InvalidateAllAnalysesPass) = "invalidate<all>"
struct IRCEPass <: LLVMPass end
is_function_pass(::Type{IRCEPass}) = true
pass_string(::IRCEPass) = "irce"
struct Float2IntPass <: LLVMPass end
is_function_pass(::Type{Float2IntPass}) = true
pass_string(::Float2IntPass) = "float2int"
struct NoOpFunctionPass <: LLVMPass end
is_function_pass(::Type{NoOpFunctionPass}) = true
pass_string(::NoOpFunctionPass) = "no-op-function"
struct LibCallsShrinkWrapPass <: LLVMPass end
is_function_pass(::Type{LibCallsShrinkWrapPass}) = true
pass_string(::LibCallsShrinkWrapPass) = "libcalls-shrinkwrap"
struct LintPass <: LLVMPass end
is_function_pass(::Type{LintPass}) = true
pass_string(::LintPass) = "lint"
struct InjectTLIMappings end
is_function_pass(::Type{InjectTLIMappings}) = true
pass_string(::InjectTLIMappings) = "inject-tli-mappings"
struct InstructionNamerPass <: LLVMPass end
is_function_pass(::Type{InstructionNamerPass}) = true
pass_string(::InstructionNamerPass) = "instnamer"
struct LowerAtomicPass <: LLVMPass end
is_function_pass(::Type{LowerAtomicPass}) = true
pass_string(::LowerAtomicPass) = "loweratomic"
struct LowerExpectIntrinsicPass <: LLVMPass end
is_function_pass(::Type{LowerExpectIntrinsicPass}) = true
pass_string(::LowerExpectIntrinsicPass) = "lower-expect"
struct LowerGuardIntrinsicPass <: LLVMPass end
is_function_pass(::Type{LowerGuardIntrinsicPass}) = true
pass_string(::LowerGuardIntrinsicPass) = "lower-guard-intrinsic"
struct LowerConstantIntrinsicsPass <: LLVMPass end
is_function_pass(::Type{LowerConstantIntrinsicsPass}) = true
pass_string(::LowerConstantIntrinsicsPass) = "lower-constant-intrinsics"
struct LowerWidenableConditionPass <: LLVMPass end
is_function_pass(::Type{LowerWidenableConditionPass}) = true
pass_string(::LowerWidenableConditionPass) = "lower-widenable-condition"
struct GuardWideningPass <: LLVMPass end
is_function_pass(::Type{GuardWideningPass}) = true
pass_string(::GuardWideningPass) = "guard-widening"
struct LoadStoreVectorizerPass <: LLVMPass end
is_function_pass(::Type{LoadStoreVectorizerPass}) = true
pass_string(::LoadStoreVectorizerPass) = "load-store-vectorizer"
struct LoopSimplifyPass <: LLVMPass end
is_function_pass(::Type{LoopSimplifyPass}) = true
pass_string(::LoopSimplifyPass) = "loop-simplify"
struct LoopSinkPass <: LLVMPass end
is_function_pass(::Type{LoopSinkPass}) = true
pass_string(::LoopSinkPass) = "loop-sink"
struct LowerInvokePass <: LLVMPass end
is_function_pass(::Type{LowerInvokePass}) = true
pass_string(::LowerInvokePass) = "lowerinvoke"
struct LowerSwitchPass <: LLVMPass end
is_function_pass(::Type{LowerSwitchPass}) = true
pass_string(::LowerSwitchPass) = "lowerswitch"
struct PromotePass <: LLVMPass end
is_function_pass(::Type{PromotePass}) = true
pass_string(::PromotePass) = "mem2reg"
struct MemCpyOptPass <: LLVMPass end
is_function_pass(::Type{MemCpyOptPass}) = true
pass_string(::MemCpyOptPass) = "memcpyopt"
struct MergeICmpsPass <: LLVMPass end
is_function_pass(::Type{MergeICmpsPass}) = true
pass_string(::MergeICmpsPass) = "mergeicmps"
struct UnifyFunctionExitNodesPass <: LLVMPass end
is_function_pass(::Type{UnifyFunctionExitNodesPass}) = true
pass_string(::UnifyFunctionExitNodesPass) = "mergereturn"
struct NaryReassociatePass <: LLVMPass end
is_function_pass(::Type{NaryReassociatePass}) = true
pass_string(::NaryReassociatePass) = "nary-reassociate"
struct NewGVNPass <: LLVMPass end
is_function_pass(::Type{NewGVNPass}) = true
pass_string(::NewGVNPass) = "newgvn"
struct JumpThreadingPass <: LLVMPass end
is_function_pass(::Type{JumpThreadingPass}) = true
pass_string(::JumpThreadingPass) = "jump-threading"
struct PartiallyInlineLibCallsPass <: LLVMPass end
is_function_pass(::Type{PartiallyInlineLibCallsPass}) = true
pass_string(::PartiallyInlineLibCallsPass) = "partially-inline-libcalls"
struct LCSSAPass <: LLVMPass end
is_function_pass(::Type{LCSSAPass}) = true
pass_string(::LCSSAPass) = "lcssa"
struct LoopDataPrefetchPass <: LLVMPass end
is_function_pass(::Type{LoopDataPrefetchPass}) = true
pass_string(::LoopDataPrefetchPass) = "loop-data-prefetch"
struct LoopLoadEliminationPass <: LLVMPass end
is_function_pass(::Type{LoopLoadEliminationPass}) = true
pass_string(::LoopLoadEliminationPass) = "loop-load-elim"
struct LoopFusePass <: LLVMPass end
is_function_pass(::Type{LoopFusePass}) = true
pass_string(::LoopFusePass) = "loop-fusion"
struct LoopDistributePass <: LLVMPass end
is_function_pass(::Type{LoopDistributePass}) = true
pass_string(::LoopDistributePass) = "loop-distribute"
struct LoopVersioningPass <: LLVMPass end
is_function_pass(::Type{LoopVersioningPass}) = true
pass_string(::LoopVersioningPass) = "loop-versioning"
struct ObjCARCOptPass <: LLVMPass end
is_function_pass(::Type{ObjCARCOptPass}) = true
pass_string(::ObjCARCOptPass) = "objc-arc"
struct ObjCARCContractPass <: LLVMPass end
is_function_pass(::Type{ObjCARCContractPass}) = true
pass_string(::ObjCARCContractPass) = "objc-arc-contract"
struct ObjCARCExpandPass <: LLVMPass end
is_function_pass(::Type{ObjCARCExpandPass}) = true
pass_string(::ObjCARCExpandPass) = "objc-arc-expand"
struct PGOMemOPSizeOpt end
is_function_pass(::Type{PGOMemOPSizeOpt}) = true
pass_string(::PGOMemOPSizeOpt) = "pgo-memop-opt"
struct PrintFunctionPass <: LLVMPass end
is_function_pass(::Type{PrintFunctionPass}) = true
pass_string(::PrintFunctionPass) = "print"
struct AssumptionPrinterPass <: LLVMPass end
is_function_pass(::Type{AssumptionPrinterPass}) = true
pass_string(::AssumptionPrinterPass) = "print<assumptions>"
struct BlockFrequencyPrinterPass <: LLVMPass end
is_function_pass(::Type{BlockFrequencyPrinterPass}) = true
pass_string(::BlockFrequencyPrinterPass) = "print<block-freq>"
struct BranchProbabilityPrinterPass <: LLVMPass end
is_function_pass(::Type{BranchProbabilityPrinterPass}) = true
pass_string(::BranchProbabilityPrinterPass) = "print<branch-prob>"
struct CostModelPrinterPass <: LLVMPass end
is_function_pass(::Type{CostModelPrinterPass}) = true
pass_string(::CostModelPrinterPass) = "print<cost-model>"
struct CycleInfoPrinterPass <: LLVMPass end
is_function_pass(::Type{CycleInfoPrinterPass}) = true
pass_string(::CycleInfoPrinterPass) = "print<cycles>"
struct DependenceAnalysisPrinterPass <: LLVMPass end
is_function_pass(::Type{DependenceAnalysisPrinterPass}) = true
pass_string(::DependenceAnalysisPrinterPass) = "print<da>"
struct DivergenceAnalysisPrinterPass <: LLVMPass end
is_function_pass(::Type{DivergenceAnalysisPrinterPass}) = true
pass_string(::DivergenceAnalysisPrinterPass) = "print<divergence>"
struct DominatorTreePrinterPass <: LLVMPass end
is_function_pass(::Type{DominatorTreePrinterPass}) = true
pass_string(::DominatorTreePrinterPass) = "print<domtree>"
struct PostDominatorTreePrinterPass <: LLVMPass end
is_function_pass(::Type{PostDominatorTreePrinterPass}) = true
pass_string(::PostDominatorTreePrinterPass) = "print<postdomtree>"
struct DelinearizationPrinterPass <: LLVMPass end
is_function_pass(::Type{DelinearizationPrinterPass}) = true
pass_string(::DelinearizationPrinterPass) = "print<delinearization>"
struct DemandedBitsPrinterPass <: LLVMPass end
is_function_pass(::Type{DemandedBitsPrinterPass}) = true
pass_string(::DemandedBitsPrinterPass) = "print<demanded-bits>"
struct DominanceFrontierPrinterPass <: LLVMPass end
is_function_pass(::Type{DominanceFrontierPrinterPass}) = true
pass_string(::DominanceFrontierPrinterPass) = "print<domfrontier>"
struct FunctionPropertiesPrinterPass <: LLVMPass end
is_function_pass(::Type{FunctionPropertiesPrinterPass}) = true
pass_string(::FunctionPropertiesPrinterPass) = "print<func-properties>"
struct InlineCostAnnotationPrinterPass <: LLVMPass end
is_function_pass(::Type{InlineCostAnnotationPrinterPass}) = true
pass_string(::InlineCostAnnotationPrinterPass) = "print<inline-cost>"
struct LoopPrinterPass <: LLVMPass end
is_function_pass(::Type{LoopPrinterPass}) = true
pass_string(::LoopPrinterPass) = "print<loops>"
struct MemorySSAPrinterPass <: LLVMPass end
is_function_pass(::Type{MemorySSAPrinterPass}) = true
pass_string(::MemorySSAPrinterPass) = "print<memoryssa>"
struct MemorySSAWalkerPrinterPass <: LLVMPass end
is_function_pass(::Type{MemorySSAWalkerPrinterPass}) = true
pass_string(::MemorySSAWalkerPrinterPass) = "print<memoryssa-walker>"
struct PhiValuesPrinterPass <: LLVMPass end
is_function_pass(::Type{PhiValuesPrinterPass}) = true
pass_string(::PhiValuesPrinterPass) = "print<phi-values>"
struct RegionInfoPrinterPass <: LLVMPass end
is_function_pass(::Type{RegionInfoPrinterPass}) = true
pass_string(::RegionInfoPrinterPass) = "print<regions>"
struct ScalarEvolutionPrinterPass <: LLVMPass end
is_function_pass(::Type{ScalarEvolutionPrinterPass}) = true
pass_string(::ScalarEvolutionPrinterPass) = "print<scalar-evolution>"
struct StackSafetyPrinterPass <: LLVMPass end
is_function_pass(::Type{StackSafetyPrinterPass}) = true
pass_string(::StackSafetyPrinterPass) = "print<stack-safety-local>"
struct AliasSetsPrinterPass <: LLVMPass end
is_function_pass(::Type{AliasSetsPrinterPass}) = true
pass_string(::AliasSetsPrinterPass) = "print-alias-sets"
struct PredicateInfoPrinterPass <: LLVMPass end
is_function_pass(::Type{PredicateInfoPrinterPass}) = true
pass_string(::PredicateInfoPrinterPass) = "print-predicateinfo"
struct MustExecutePrinterPass <: LLVMPass end
is_function_pass(::Type{MustExecutePrinterPass}) = true
pass_string(::MustExecutePrinterPass) = "print-mustexecute"
struct MemDerefPrinterPass <: LLVMPass end
is_function_pass(::Type{MemDerefPrinterPass}) = true
pass_string(::MemDerefPrinterPass) = "print-memderefs"
struct ReassociatePass <: LLVMPass end
is_function_pass(::Type{ReassociatePass}) = true
pass_string(::ReassociatePass) = "reassociate"
struct RedundantDbgInstEliminationPass <: LLVMPass end
is_function_pass(::Type{RedundantDbgInstEliminationPass}) = true
pass_string(::RedundantDbgInstEliminationPass) = "redundant-dbg-inst-elim"
struct RegToMemPass <: LLVMPass end
is_function_pass(::Type{RegToMemPass}) = true
pass_string(::RegToMemPass) = "reg2mem"
struct ScalarizeMaskedMemIntrinPass <: LLVMPass end
is_function_pass(::Type{ScalarizeMaskedMemIntrinPass}) = true
pass_string(::ScalarizeMaskedMemIntrinPass) = "scalarize-masked-mem-intrin"
struct ScalarizerPass <: LLVMPass end
is_function_pass(::Type{ScalarizerPass}) = true
pass_string(::ScalarizerPass) = "scalarizer"
struct SeparateConstOffsetFromGEPPass <: LLVMPass end
is_function_pass(::Type{SeparateConstOffsetFromGEPPass}) = true
pass_string(::SeparateConstOffsetFromGEPPass) = "separate-const-offset-from-gep"
struct SCCPPass <: LLVMPass end
is_function_pass(::Type{SCCPPass}) = true
pass_string(::SCCPPass) = "sccp"
struct SinkingPass <: LLVMPass end
is_function_pass(::Type{SinkingPass}) = true
pass_string(::SinkingPass) = "sink"
struct SLPVectorizerPass <: LLVMPass end
is_function_pass(::Type{SLPVectorizerPass}) = true
pass_string(::SLPVectorizerPass) = "slp-vectorizer"
struct StraightLineStrengthReducePass <: LLVMPass end
is_function_pass(::Type{StraightLineStrengthReducePass}) = true
pass_string(::StraightLineStrengthReducePass) = "slsr"
struct SpeculativeExecutionPass <: LLVMPass end
is_function_pass(::Type{SpeculativeExecutionPass}) = true
pass_string(::SpeculativeExecutionPass) = "speculative-execution"
struct SROAPass <: LLVMPass end
is_function_pass(::Type{SROAPass}) = true
pass_string(::SROAPass) = "sroa"
struct StripGCRelocates end
is_function_pass(::Type{StripGCRelocates}) = true
pass_string(::StripGCRelocates) = "strip-gc-relocates"
struct StructurizeCFGPass <: LLVMPass end
is_function_pass(::Type{StructurizeCFGPass}) = true
pass_string(::StructurizeCFGPass) = "structurizecfg"
struct TailCallElimPass <: LLVMPass end
is_function_pass(::Type{TailCallElimPass}) = true
pass_string(::TailCallElimPass) = "tailcallelim"
struct UnifyLoopExitsPass <: LLVMPass end
is_function_pass(::Type{UnifyLoopExitsPass}) = true
pass_string(::UnifyLoopExitsPass) = "unify-loop-exits"
struct VectorCombinePass <: LLVMPass end
is_function_pass(::Type{VectorCombinePass}) = true
pass_string(::VectorCombinePass) = "vector-combine"
struct VerifierPass <: LLVMPass end
is_function_pass(::Type{VerifierPass}) = true
pass_string(::VerifierPass) = "verify"
struct DominatorTreeVerifierPass <: LLVMPass end
is_function_pass(::Type{DominatorTreeVerifierPass}) = true
pass_string(::DominatorTreeVerifierPass) = "verify<domtree>"
struct LoopVerifierPass <: LLVMPass end
is_function_pass(::Type{LoopVerifierPass}) = true
pass_string(::LoopVerifierPass) = "verify<loops>"
struct MemorySSAVerifierPass <: LLVMPass end
is_function_pass(::Type{MemorySSAVerifierPass}) = true
pass_string(::MemorySSAVerifierPass) = "verify<memoryssa>"
struct RegionInfoVerifierPass <: LLVMPass end
is_function_pass(::Type{RegionInfoVerifierPass}) = true
pass_string(::RegionInfoVerifierPass) = "verify<regions>"
struct SafepointIRVerifierPass <: LLVMPass end
is_function_pass(::Type{SafepointIRVerifierPass}) = true
pass_string(::SafepointIRVerifierPass) = "verify<safepoint-ir>"
struct ScalarEvolutionVerifierPass <: LLVMPass end
is_function_pass(::Type{ScalarEvolutionVerifierPass}) = true
pass_string(::ScalarEvolutionVerifierPass) = "verify<scalar-evolution>"
struct CFGViewerPass <: LLVMPass end
is_function_pass(::Type{CFGViewerPass}) = true
pass_string(::CFGViewerPass) = "view-cfg"
struct CFGOnlyViewerPass <: LLVMPass end
is_function_pass(::Type{CFGOnlyViewerPass}) = true
pass_string(::CFGOnlyViewerPass) = "view-cfg-only"
struct TLSVariableHoistPass <: LLVMPass end
is_function_pass(::Type{TLSVariableHoistPass}) = true
pass_string(::TLSVariableHoistPass) = "tlshoist"
struct WarnMissedTransformationsPass <: LLVMPass end
is_function_pass(::Type{WarnMissedTransformationsPass}) = true
pass_string(::WarnMissedTransformationsPass) = "transform-warning"
struct ThreadSanitizerPass <: LLVMPass end
is_function_pass(::Type{ThreadSanitizerPass}) = true
pass_string(::ThreadSanitizerPass) = "tsan"
struct MemProfilerPass <: LLVMPass end
is_function_pass(::Type{MemProfilerPass}) = true
pass_string(::MemProfilerPass) = "memprof"

# Function Passes With Params

struct EarlyCSEPassOptions
    memssa::Core.Bool
end
EarlyCSEPassOptions() = EarlyCSEPassOptions(false)
struct EarlyCSEPass <: LLVMPass
    options::EarlyCSEPassOptions
end
EarlyCSEPass() = EarlyCSEPass(EarlyCSEPassOptions())
is_function_pass(::Type{EarlyCSEPass}) = true
pass_string(pass::EarlyCSEPass) = ifelse(pass.options.memssa, "early-cse<memssa>", "early-cse")
struct EntryExitInstrumenterPassOptions
    postinline::Core.Bool
end
EntryExitInstrumenterPassOptions() = EntryExitInstrumenterPassOptions(true)
struct EntryExitInstrumenterPass <: LLVMPass
    options::EntryExitInstrumenterPassOptions
end
EntryExitInstrumenterPass() = EntryExitInstrumenterPass(EntryExitInstrumenterPassOptions())
is_function_pass(::Type{EntryExitInstrumenterPass}) = true
pass_string(pass::EntryExitInstrumenterPass) = ifelse(pass.options.postinline, "entry-exit-instrumenter<post-inline>", "entry-exit-instrumenter")
struct LowerMatrixIntrinsicsPassOptions
    minimal::Core.Bool
end
LowerMatrixIntrinsicsPassOptions() = LowerMatrixIntrinsicsPassOptions(false)
struct LowerMatrixIntrinsicsPass <: LLVMPass
    options::LowerMatrixIntrinsicsPassOptions
end
LowerMatrixIntrinsicsPass() = LowerMatrixIntrinsicsPass(LowerMatrixIntrinsicsPassOptions())
is_function_pass(::Type{LowerMatrixIntrinsicsPass}) = true
pass_string(pass::LowerMatrixIntrinsicsPass) = ifelse(pass.options.minimal, "lower-matrix-intrinsics<minimal>", "lower-matrix-intrinsics")
struct LoopUnrollPassOptions
    speedup::Int
    fullunrollmax::Union{Nothing, Int}
    partial::Union{Nothing, Core.Bool}
    peeling::Union{Nothing, Core.Bool}
    profilepeeling::Union{Nothing, Core.Bool}
    runtime::Union{Nothing, Core.Bool}
    upperbound::Union{Nothing, Core.Bool}
end
LoopUnrollPassOptions() = LoopUnrollPassOptions(2, nothing, nothing, nothing, nothing, nothing, nothing)
struct LoopUnrollPass <: LLVMPass
    options::LoopUnrollPassOptions
end
LoopUnrollPass() = LoopUnrollPass(LoopUnrollPassOptions())
is_function_pass(::Type{LoopUnrollPass}) = true
function pass_string(pass::LoopUnrollPass)
    options = String[]
    push!(options, "O$(pass.options.speedup)")
    if pass.options.fullunrollmax !== nothing
        push!(options, "full-unroll-max=$(pass.options.fullunrollmax)")
    end
    if pass.options.partial !== nothing
        push!(options, ifelse(pass.options.partial, "partial", "no-partial"))
    end
    if pass.options.peeling !== nothing
        push!(options, ifelse(pass.options.peeling, "peeling", "no-peeling"))
    end
    if pass.options.profilepeeling !== nothing
        push!(options, ifelse(pass.options.profilepeeling, "profile-peeling", "no-profile-peeling"))
    end
    if pass.options.runtime !== nothing
        push!(options, ifelse(pass.options.runtime, "runtime", "no-runtime"))
    end
    if pass.options.upperbound !== nothing
        push!(options, ifelse(pass.options.upperbound, "upperbound", "no-upperbound"))
    end
    "loop-unroll<$(join(options, ","))>"
end
struct MemorySanitizerPassOptions
    recover::Core.Bool
    kernel::Core.Bool
    eagerchecks::Core.Bool
    trackorigins::Int
end
MemorySanitizerPassOptions(false, false, false, 0)
struct MemorySanitizerPass <: LLVMPass
    options::MemorySanitizerPassOptions
end
MemorySanitizerPass() = MemorySanitizerPass(MemorySanitizerPassOptions())
is_function_pass(::Type{MemorySanitizerPass}) = true
function pass_string(pass::MemorySanitizerPass)
    options = String[]
    if pass.options.recover
        push!(options, "recover")
    end
    if pass.options.kernel
        push!(options, "kernel")
    end
    if pass.options.eagerchecks
        push!(options, "eager-checks")
    end
    push!(options, "track-origins=$(pass.options.trackorigins)")
    "msan<$(join(options, ","))>"
end
struct SimplifyCFGPassOptions
    forwardswitchcond::Core.Bool
    switchrangetoicmp::Core.Bool
    switchtolookup::Core.Bool
    keeploops::Core.Bool
    hoistcommoninsts::Core.Bool
    sinkcommoninsts::Core.Bool
    bonusinstthreshold::Int
end
SimplifyCFGPassOptions() = SimplifyCFGPassOptions(false, false, false, true, false, false, 1)
struct SimplifyCFGPass <: LLVMPass
    options::SimplifyCFGPassOptions
end
SimplifyCFGPass() = SimplifyCFGPass(SimplifyCFGPassOptions())
is_function_pass(::Type{SimplifyCFGPass}) = true
function pass_string(pass::SimplifyCFGPass)
    forward = ifelse(pass.options.forwardswitchcond, "forward-switch-cond", "no-forward-switch-cond")
    s2i = ifelse(pass.options.switchrangetoicmp, "switch-range-to-icmp", "no-switch-range-to-icmp")
    s2l = ifelse(pass.options.switchtolookup, "switch-to-lookup", "no-switch-to-lookup")
    keeploops = ifelse(pass.options.keeploops, "keep-loops", "no-keep-loops")
    hoist = ifelse(pass.options.hoistcommoninsts, "hoist-common-insts", "no-hoist-common-insts")
    sink = ifelse(pass.options.sinkcommoninsts, "sink-common-insts", "no-sink-common-insts")
    bonus = "bonus-inst-threshold=$(pass.options.bonusinstthreshold)"
    "simplify-cfg<$forward,$s2i,$s2l,$keeploops,$hoist,$sink,$bonus>"
end
struct LoopVectorizePassOptions
    interleaveforcedonly::Core.Bool
    vectorizeforcedonly::Core.Bool
end
LoopVectorizePassOptions() = LoopVectorizePassOptions(false, false)
struct LoopVectorizePass <: LLVMPass
    options::LoopVectorizePassOptions
end
LoopVectorizePass() = LoopVectorizePass(LoopVectorizePassOptions())
is_function_pass(::Type{LoopVectorizePass}) = true
function pass_string(pass::LoopVectorizePass)
    interleave = ifelse(pass.options.interleaveforcedonly, "interleave-forced-only", "no-interleave-forced-only")
    vectorize = ifelse(pass.options.vectorizeforcedonly, "vectorize-forced-only", "no-vectorize-forced-only")
    "loop-vectorize<$interleave,$vectorize>"
end
struct MergedLoadStoreMotionPassOptions
    splitfooterbb::Core.Bool
end
MergedLoadStoreMotionPassOptions() = MergedLoadStoreMotionPassOptions(false)
struct MergedLoadStoreMotionPass <: LLVMPass
    options::MergedLoadStoreMotionPassOptions
end
MergedLoadStoreMotionPass() = MergedLoadStoreMotionPass(MergedLoadStoreMotionPassOptions())
is_function_pass(::Type{MergedLoadStoreMotionPass}) = true
pass_string(pass::MergedLoadStoreMotionPass) = ifelse(pass.options.splitfooterbb, "mldst-motion<split-footer-bb>", "mldst-motion<no-split-footer-bb>")
struct GVNPassOptions
    allowpre::Union{Nothing, Core.Bool}
    allowloadpre::Union{Nothing, Core.Bool}
    allowloadpresplitbackedge::Union{Nothing, Core.Bool}
    allowmemdep::Union{Nothing, Core.Bool}
end
GVNPassOptions() = GVNPassOptions(nothing, nothing, nothing, nothing)
struct GVNPass <: LLVMPass
    options::GVNPassOptions
end
GVNPass() = GVNPass(GVNPassOptions())
is_function_pass(::Type{GVNPass}) = true
function pass_string(pass::GVNPass)
    options = String[]
    if pass.options.allowpre != nothing
        if pass.options.allowpre
            push!(options, "pre")
        else
            push!(options, "no-pre")
        end
    end
    if pass.options.allowloadpre != nothing
        if pass.options.allowloadpre
            push!(options, "load-pre")
        else
            push!(options, "no-load-pre")
        end
    end
    if pass.options.allowloadpresplitbackedge != nothing
        if pass.options.allowloadpresplitbackedge
            push!(options, "split-backedge-load-pre")
        else
            push!(options, "no-split-backedge-load-pre")
        end
    end
    if pass.options.allowmemdep != nothing
        if pass.options.allowmemdep
            push!(options, "memdep")
        else
            push!(options, "no-memdep")
        end
    end
    if !isempty(options)
        return "gvn<$(join(options, ","))>"
    end
    return "gvn"
end
struct StackLifetimePrinterPassOptions
    must::Core.Bool
end
StackLifetimePrinterPassOptions() = StackLifetimePrinterPassOptions(false)
struct StackLifetimePrinterPass <: LLVMPass
    options::StackLifetimePrinterPassOptions
end
StackLifetimePrinterPass() = StackLifetimePrinterPass(StackLifetimePrinterPassOptions())
is_function_pass(::Type{StackLifetimePrinterPass}) = true
pass_string(pass::StackLifetimePrinterPass) = ifelse(pass.options.must, "print<stack-lifetime><must>", "print<stack-lifetime><may>")

# Loop Nest Passes

struct LoopFlattenPass <: LLVMPass end
is_loop_pass(::Type{LoopFlattenPass}) = true
pass_string(::LoopFlattenPass) = "loop-flatten"
struct LoopInterchangePass <: LLVMPass end
is_loop_pass(::Type{LoopInterchangePass}) = true
pass_string(::LoopInterchangePass) = "loop-interchange"
struct LoopUnrollAndJamPass <: LLVMPass end
is_loop_pass(::Type{LoopUnrollAndJamPass}) = true
pass_string(::LoopUnrollAndJamPass) = "loop-unroll-and-jam"
struct NoOpLoopNestPass <: LLVMPass end
is_loop_pass(::Type{NoOpLoopNestPass}) = true
pass_string(::NoOpLoopNestPass) = "no-op-loopnest"

# Loop Passes

struct CanonicalizeFreezeInLoopsPass <: LLVMPass end
is_loop_pass(::Type{CanonicalizeFreezeInLoopsPass}) = true
pass_string(::CanonicalizeFreezeInLoopsPass) = "canon-freeze"
struct DDGDotPrinterPass <: LLVMPass end
is_loop_pass(::Type{DDGDotPrinterPass}) = true
pass_string(::DDGDotPrinterPass) = "dot-ddg"
struct InvalidateAllAnalysesPass <: LLVMPass end
is_loop_pass(::Type{InvalidateAllAnalysesPass}) = true
pass_string(::InvalidateAllAnalysesPass) = "invalidate<all>"
struct LoopIdiomRecognizePass <: LLVMPass end
is_loop_pass(::Type{LoopIdiomRecognizePass}) = true
pass_string(::LoopIdiomRecognizePass) = "loop-idiom"
struct LoopInstSimplifyPass <: LLVMPass end
is_loop_pass(::Type{LoopInstSimplifyPass}) = true
pass_string(::LoopInstSimplifyPass) = "loop-instsimplify"
struct LoopRotatePass <: LLVMPass end
is_loop_pass(::Type{LoopRotatePass}) = true
pass_string(::LoopRotatePass) = "loop-rotate"
struct NoOpLoopPass <: LLVMPass end
is_loop_pass(::Type{NoOpLoopPass}) = true
pass_string(::NoOpLoopPass) = "no-op-loop"
struct PrintLoopPass <: LLVMPass end
is_loop_pass(::Type{PrintLoopPass}) = true
pass_string(::PrintLoopPass) = "print"
struct LoopDeletionPass <: LLVMPass end
is_loop_pass(::Type{LoopDeletionPass}) = true
pass_string(::LoopDeletionPass) = "loop-deletion"
struct LoopSimplifyCFGPass <: LLVMPass end
is_loop_pass(::Type{LoopSimplifyCFGPass}) = true
pass_string(::LoopSimplifyCFGPass) = "loop-simplifycfg"
struct LoopStrengthReducePass <: LLVMPass end
is_loop_pass(::Type{LoopStrengthReducePass}) = true
pass_string(::LoopStrengthReducePass) = "loop-reduce"
struct IndVarSimplifyPass <: LLVMPass end
is_loop_pass(::Type{IndVarSimplifyPass}) = true
pass_string(::IndVarSimplifyPass) = "indvars"
struct LoopFullUnrollPass <: LLVMPass end
is_loop_pass(::Type{LoopFullUnrollPass}) = true
pass_string(::LoopFullUnrollPass) = "loop-unroll-full"
struct LoopAccessInfoPrinterPass <: LLVMPass end
is_loop_pass(::Type{LoopAccessInfoPrinterPass}) = true
pass_string(::LoopAccessInfoPrinterPass) = "print-access-info"
struct DDGAnalysisPrinterPass <: LLVMPass end
is_loop_pass(::Type{DDGAnalysisPrinterPass}) = true
pass_string(::DDGAnalysisPrinterPass) = "print<ddg>"
struct IVUsersPrinterPass <: LLVMPass end
is_loop_pass(::Type{IVUsersPrinterPass}) = true
pass_string(::IVUsersPrinterPass) = "print<iv-users>"
struct LoopNestPrinterPass <: LLVMPass end
is_loop_pass(::Type{LoopNestPrinterPass}) = true
pass_string(::LoopNestPrinterPass) = "print<loopnest>"
struct LoopCachePrinterPass <: LLVMPass end
is_loop_pass(::Type{LoopCachePrinterPass}) = true
pass_string(::LoopCachePrinterPass) = "print<loop-cache-cost>"
struct LoopPredicationPass <: LLVMPass end
is_loop_pass(::Type{LoopPredicationPass}) = true
pass_string(::LoopPredicationPass) = "loop-predication"
struct GuardWideningPass <: LLVMPass end
is_loop_pass(::Type{GuardWideningPass}) = true
pass_string(::GuardWideningPass) = "guard-widening"
struct LoopBoundSplitPass <: LLVMPass end
is_loop_pass(::Type{LoopBoundSplitPass}) = true
pass_string(::LoopBoundSplitPass) = "loop-bound-split"
struct LoopRerollPass <: LLVMPass end
is_loop_pass(::Type{LoopRerollPass}) = true
pass_string(::LoopRerollPass) = "loop-reroll"
struct LoopVersioningLICMPass <: LLVMPass end
is_loop_pass(::Type{LoopVersioningLICMPass}) = true
pass_string(::LoopVersioningLICMPass) = "loop-versioning-licm"

# Loop Passes With Params

struct SimpleLoopUnswitchPassOptions
    nontrivial::Core.Bool
    trivial::Core.Bool
end
SimpleLoopUnswitchPassOptions() = SimpleLoopUnswitchPassOptions(false, true)
struct SimpleLoopUnswitchPass <: LLVMPass
    options::SimpleLoopUnswitchPassOptions
end
SimpleLoopUnswitchPass() = SimpleLoopUnswitchPass(SimpleLoopUnswitchPassOptions())
is_loop_pass(::Type{SimpleLoopUnswitchPass}) = true
function pass_string(pass::SimpleLoopUnswitchPass)
    nontrivial = ifelse(pass.options.nontrivial, "nontrivial", "no-nontrivial")
    trivial = ifelse(pass.options.trivial, "trivial", "no-trivial")
    "loop-unswitch<$nontrivial;$trivial>"
end
struct LICMPassOptions
    allowspeculation::Core.Bool
end
LICMPassOptions() = LICMPassOptions(true)
struct LICMPass <: LLVMPass
    options::LICMPassOptions
end
LICMPass() = LICMPass(LICMPassOptions())
is_loop_pass(::Type{LICMPass}) = true
pass_string(pass::LICMPass) = ifelse(pass.options.allowspeculation, "licm<allowspeculation>", "licm<no-allowspeculation>")
const LNICMPassOptions = LICMPassOptions
struct LNICMPass <: LLVMPass
    options::LNICMPassOptions
end
LNICMPass() = LNICMPass(LNICMPassOptions())
is_loop_pass(::Type{LNICMPass}) = true
pass_string(pass::LNICMPass) = ifelse(pass.options.allowspeculation, "lnicm<allowspeculation>", "lnicm<no-allowspeculation>")

# Add methods

function add!(pm::NewPMModulePassManager, pb::PassBuilder, pass::LLVMPass)
    if !is_module_pass(typeof(pass))
        error("Pass $pass is not a module pass")
    end
    parse!(pm, pb, pass_string(pass))
end

function add!(pm::NewPMCGSCCPassManager, pb::PassBuilder, pass::LLVMPass)
    if !is_cgscc_pass(typeof(pass))
        error("Pass $pass is not a cgscc pass")
    end
    parse!(pm, pb, pass_string(pass))
end

function add!(pm::NewPMFunctionPassManager, pb::PassBuilder, pass::LLVMPass)
    if !is_function_pass(typeof(pass))
        error("Pass $pass is not a function pass")
    end
    parse!(pm, pb, pass_string(pass))
end

function add!(pm::NewPMLoopPassManager, pb::PassBuilder, pass::LLVMPass)
    if !is_loop_pass(typeof(pass))
        error("Pass $pass is not a loop pass")
    end
    parse!(pm, pb, pass_string(pass))
end
