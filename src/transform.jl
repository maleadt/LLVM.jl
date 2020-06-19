## pass manager builder

export PassManagerBuilder, dispose,
       optlevel!, sizelevel!,
       unit_at_a_time!, unroll_loops!, simplify_libcalls!, inliner!,
       populate!

@checked struct PassManagerBuilder
    ref::API.LLVMPassManagerBuilderRef
end
reftype(::Type{PassManagerBuilder}) = API.LLVMPassManagerBuilderRef

PassManagerBuilder() = PassManagerBuilder(API.LLVMPassManagerBuilderCreate())

dispose(pmb::PassManagerBuilder) = API.LLVMPassManagerBuilderDispose(ref(pmb))

function PassManagerBuilder(f::Core.Function)
    pmb = PassManagerBuilder()
    try
        f(pmb)
    finally
        dispose(pmb)
    end
end

# 0 = -O0, 1 = -O1, 2 = -O2, 3 = -O3
optlevel!(pmb::PassManagerBuilder, level::Integer) =
    API.LLVMPassManagerBuilderSetOptLevel(ref(pmb), level)

# 0 = none, 1 = -Os, 2 = -Oz
sizelevel!(pmb::PassManagerBuilder, level::Integer) =
    API.LLVMPassManagerBuilderSetSizeLevel(ref(pmb), level)

unit_at_a_time!(pmb::PassManagerBuilder, flag::Core.Bool=true) =
    API.LLVMPassManagerBuilderSetDisableUnitAtATime(ref(pmb), convert(Bool, !flag))

unroll_loops!(pmb::PassManagerBuilder, flag::Core.Bool=true) =
    API.LLVMPassManagerBuilderSetDisableUnrollLoops(ref(pmb), convert(Bool, !flag))

simplify_libcalls!(pmb::PassManagerBuilder, flag::Core.Bool=true) =
    API.LLVMPassManagerBuilderSetDisableSimplifyLibCalls(ref(pmb), convert(Bool, !flag))

inliner!(pmb::PassManagerBuilder, threshold::Integer) =
    API.LLVMPassManagerBuilderUseInlinerWithThreshold(ref(pmb), threshold)

populate!(fpm::FunctionPassManager, pmb::PassManagerBuilder) =
    API.LLVMPassManagerBuilderPopulateFunctionPassManager(ref(pmb), ref(fpm))

populate!(mpm::ModulePassManager, pmb::PassManagerBuilder) =
    API.LLVMPassManagerBuilderPopulateModulePassManager(ref(pmb), ref(mpm))


## auxiliary

function define_transforms(transforms)
    for transform in transforms
        api_fname = Symbol(:LLVM, :Add, transform, :Pass)

        # deconstruct the camel-casing to get a nice function name
        str = string(transform)
        groups = Vector{SubString}()
        i = 1
        while i <= length(str)
            j = i
            while j < length(str) && all(isuppercase, str[i:j+1])
                # upper-case part
                j += 1
            end
            k = j
            while j < length(str) && all(islowercase, str[k+1:j+1])
                # optional lower-case part
                j += 1
            end

            push!(groups, SubString(str, i, j))
            i = j+1
        end
        jl_fname = Symbol(join(lowercase.(groups), '_'), '!')

        @eval begin
            export $jl_fname
            $jl_fname(pm::PassManager) = API.$api_fname(ref(pm))
        end
    end

    return nothing
end


## scalar transformations

define_transforms([
    :AggressiveDCE, :BitTrackingDCE, :AlignmentFromAssumptions, :CFGSimplification,
    :DeadStoreElimination, :Scalarizer, :MergedLoadStoreMotion, :GVN, :IndVarSimplify,
    :InstructionCombining, :JumpThreading, :LICM, :LoopDeletion, :LoopIdiom, :LoopRotate,
    :LoopReroll, :LoopUnroll, :LoopUnswitch, :MemCpyOpt, :PartiallyInlineLibCalls,
    :LowerSwitch, :PromoteMemoryToRegister, :Reassociate, :SCCP, :ScalarReplAggregates,
    :SimplifyLibCalls, :TailCallElimination, :ConstantPropagation, :DemoteMemoryToRegister,
    :Verifier, :CorrelatedValuePropagation, :EarlyCSE, :EarlyCSEMemSSA,
    :LowerExpectIntrinsic, :TypeBasedAliasAnalysis, :ScopedNoAliasAA, :BasicAliasAnalysis
])

export scalar_repl_aggregates!, scalar_repl_aggregates_ssa!

scalar_repl_aggregates!(pm::PassManager, threshold::Integer) =
    API.LLVMAddScalarReplAggregatesPassWithThreshold(ref(pm), Cint(threshold))

scalar_repl_aggregates_ssa!(pm::PassManager) =
    API.LLVMAddScalarReplAggregatesPassSSA(ref(pm))


## vectorization transformations

define_transforms([
    :LoopVectorize, :SLPVectorize
])


## interprocedural transformations

define_transforms([
    :ArgumentPromotion, :ConstantMerge, :DeadArgElimination, :FunctionAttrs,
    :FunctionInlining, :AlwaysInliner, :GlobalDCE, :GlobalOptimizer, :IPConstantPropagation,
    :PruneEH, :IPSCCP, :StripDeadPrototypes, :StripSymbols
])

export internalize!

internalize!(pm::PassManager, allbutmain::Core.Bool=true) =
    API.LLVMAddInternalizePass(ref(pm), convert(Bool, allbutmain))

internalize!(pm::PassManager, exports::Vector{String}) =
    API.LLVMAddInternalizePassWithExportList(ref(pm), exports, Csize_t(length(exports)))


## target-specific transformations

export nvvm_reflect!

function nvvm_reflect!(pm::PassManager, smversion=35)
    VERSION >= v"1.5.0-DEV.138" && error("NVVMReflect pass has been removed from Julia and LLVM")
    API.LLVMAddNVVMReflectPass(ref(pm), smversion)
end
