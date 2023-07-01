export PassBuilder

export dispose, register!, cross_register_proxies!, parse!

@checked struct PassBuilder
    ref::API.LLVMPassBuilderRef
    owned_pic::Union{Nothing,PassInstrumentationCallbacks}
    roots::Vector{Any}
end

Base.unsafe_convert(::Type{API.LLVMPassBuilderRef}, pb::PassBuilder) = pb.ref

function create_passbuilder_internal(tm, pic)
    pb = API.LLVMCreatePassBuilder(tm, pic)
    if VERSION >= v"1.10.0-DEV.1622"
        API.LLVMRegisterJuliaPassBuilderCallbacks(pb)
    end
    pb
end

function PassBuilder(tm::Union{Nothing,TargetMachine} = nothing, pic::Union{Nothing,PassInstrumentationCallbacks} = nothing; si::Core.Bool=false)
    if !isnothing(pic) && si
        throw(ArgumentError("Cannot provide explicit PassInstrumentationCallbacks and request StandardInstrumentations!"))
    end
    tm_internal = ifelse(isnothing(tm), C_NULL, tm)
    if !isnothing(pic)
        pic_internal = pic
    elseif si
        pic_internal = StandardInstrumentationCallbacks()
    else
        pic_internal = C_NULL
    end
    pb = create_passbuilder_internal(tm_internal, pic_internal)
    PassBuilder(pb, ifelse(si, pic_internal, nothing), [])
end

function dispose(pb::PassBuilder)
    API.LLVMDisposePassBuilder(pb)
    if !isnothing(pb.owned_pic)
        dispose(pb.owned_pic)
    end
end

function PassBuilder(f::Core.Function, args...; kwargs...)
    pb = PassBuilder(args...; kwargs...)
    try
        f(pb)
    finally
        dispose(pb)
    end
end

register!(pb::PassBuilder, am::ModuleAnalysisManager) = API.LLVMPassBuilderRegisterModuleAnalyses(pb, am)
register!(pb::PassBuilder, am::CGSCCAnalysisManager) = API.LLVMPassBuilderRegisterCGSCCAnalyses(pb, am)
register!(pb::PassBuilder, am::LoopAnalysisManager) = API.LLVMPassBuilderRegisterLoopAnalyses(pb, am)
# FunctionAnalysisManager is special because we can build alias analysis pipelines on top of it
function register!(pb::PassBuilder, am::FunctionAnalysisManager)
    if !isnothing(am.aa)
        pipeline = analysis_string(am.aa)
        tm = ifelse(isnothing(am.aa.tm), C_NULL, am.aa.tm)
        @check API.LLVMRegisterAliasAnalyses(am, pb, tm, pipeline, length(pipeline))
    end
    API.LLVMPassBuilderRegisterFunctionAnalyses(pb, am)
end

cross_register_proxies!(pb::PassBuilder, lam::LoopAnalysisManager, fam::FunctionAnalysisManager, cgam::CGSCCAnalysisManager, mam::ModuleAnalysisManager) = API.LLVMPassBuilderCrossRegisterProxies(pb, lam, fam, cgam, mam)

function register!(pb::PassBuilder, lam::LoopAnalysisManager, fam::FunctionAnalysisManager, cgam::CGSCCAnalysisManager, mam::ModuleAnalysisManager)
    register!(pb, lam)
    register!(pb, fam)
    register!(pb, cgam)
    register!(pb, mam)
    cross_register_proxies!(pb, lam, fam, cgam, mam)
end

parse!(pb::PassBuilder, pm::NewPMModulePassManager, s::String) = @check API.LLVMPassBuilderParseModulePassPipeline(pb, pm, s, length(s))
parse!(pb::PassBuilder, pm::NewPMCGSCCPassManager, s::String) = @check API.LLVMPassBuilderParseCGSCCPassPipeline(pb, pm, s, length(s))
parse!(pb::PassBuilder, pm::NewPMFunctionPassManager, s::String) = @check API.LLVMPassBuilderParseFunctionPassPipeline(pb, pm, s, length(s))
parse!(pb::PassBuilder, pm::NewPMLoopPassManager, s::String) = @check API.LLVMPassBuilderParseLoopPassPipeline(pb, pm, s, length(s))

function passbuilder(pm::NewPMPassManager)::PassBuilder
    if isnothing(pm.pb)
        throw(ArgumentError("PassManager was not initialized with a PassBuilder, please provide a PassBuilder to add!."))
    end
    pm.pb
end
