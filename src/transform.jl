## pass manager builder

export PassManagerBuilder, dispose,
       optlevel!, sizelevel!,
       unit_at_a_time!, unroll_loops!, simplify_libcalls!, inliner!,
       populate!

@reftypedef ref=LLVMPassManagerBuilderRef immutable PassManagerBuilder end

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
    API.LLVMPassManagerBuilderSetOptLevel(ref(pmb), Cuint(level))

# 0 = none, 1 = -Os, 2 = -Oz
sizelevel!(pmb::PassManagerBuilder, level::Integer) =
    API.LLVMPassManagerBuilderSetSizeLevel(ref(pmb), Cuint(level))

unit_at_a_time!(pmb::PassManagerBuilder, flag::Bool=true) =
    API.LLVMPassManagerBuilderSetDisableUnitAtATime(ref(pmb), BoolToLLVM(!flag))

unroll_loops!(pmb::PassManagerBuilder, flag::Bool=true) =
    API.LLVMPassManagerBuilderSetDisableUnrollLoops(ref(pmb), BoolToLLVM(!flag))

simplify_libcalls!(pmb::PassManagerBuilder, flag::Bool=true) =
    API.LLVMPassManagerBuilderSetDisableSimplifyLibCalls(ref(pmb), BoolToLLVM(!flag))

inliner!(pmb::PassManagerBuilder, threshold::Integer) =
    API.LLVMPassManagerBuilderUseInlinerWithThreshold(ref(pmb), Cuint(threshold))

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
            while j < length(str) && all(isupper, str[i:j+1])
                # upper-case part
                j += 1
            end
            k = j
            while j < length(str) && all(islower, str[k+1:j+1])
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
    :Verifier, :CorrelatedValuePropagation, :EarlyCSE, :LowerExpectIntrinsic,
    :TypeBasedAliasAnalysis, :ScopedNoAliasAA, :BasicAliasAnalysis
])

export scalar_repl_aggregates!, scalar_repl_aggregates_ssa!

scalar_repl_aggregates!(pm::PassManager, threshold::Integer) =
    API.LLVMAddScalarReplAggregatesPassWithThreshold(ref(pm), Cint(threshold))

scalar_repl_aggregates_ssa!(pm::PassManager) =
    API.LLVMAddScalarReplAggregatesPassSSA(ref(pm))


## vectorization transformations

define_transforms([
    :BBVectorize, :LoopVectorize, :SLPVectorize
])


## interprocedural transformations

define_transforms([
    :ArgumentPromotion, :ConstantMerge, :DeadArgElimination, :FunctionAttrs,
    :FunctionInlining, :AlwaysInliner, :GlobalDCE, :GlobalOptimizer, :IPConstantPropagation,
    :PruneEH, :IPSCCP, :StripDeadPrototypes, :StripSymbols
])

export internalize!

internalize!(pm::PassManager, allbutmain::Bool=true) =
    API.LLVMAddInternalizePass(ref(pm), Cuint(BoolToLLVM(allbutmain)))

internalize!(pm::PassManager, exports::Vector{String}) =
    API.LLVMAddInternalizePassWithExportList(ref(pm), exports, Csize_t(length(exports)))


## target-specific transformations

export nvvm_reflect!

nvvm_reflect!(pm::PassManager) = API.LLVMAddNVVMReflectPass(ref(pm))
