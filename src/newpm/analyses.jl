export NewPMAnalysis, NewPMAliasAnalysis

export add!, analysis_string, analysis_managers

abstract type NewPMAnalysis end
abstract type NewPMAliasAnalysis end

macro alias_analysis(analysis_name, class_name)
    quote
        export $class_name
        struct $class_name <: NewPMAliasAnalysis end
        @eval analysis_string(::$class_name) = $analysis_name
    end
end

analysis_string(aa::AAManager) = join(aa.aas, ",")

Base.show(io::IO, analysis::NewPMAnalysis) = print(io, analysis_string(analysis))
Base.show(io::IO, aa::AAManager) = print(io, analysis_string(aa))

# Module Alias Analysis
@alias_analysis "globals-aa" GlobalsAA

# Function Alias Analysis
@alias_analysis "basic-aa" BasicAA
@alias_analysis "cfl-anders-aa" CFLAndersAA
@alias_analysis "cfl-steens-aa" CFLSteensAA
@alias_analysis "objc-arc-aa" ObjCARCAA
@alias_analysis "scev-aa" SCEVAA
@alias_analysis "scoped-noalias-aa" ScopedNoAliasAA
@alias_analysis "tbaa" TypeBasedAA

add!(am::AAManager, aa::NewPMAliasAnalysis) = push!(am.aas, analysis_string(aa))
add!(am::AAManager, aas::AbstractVector{<:NewPMAliasAnalysis}) =
    append!(am.aas, analysis_string.(aas))
add!(am::AAManager, tm::TargetMachine) = am.tm = tm

export TargetIRAnalysis, TargetLibraryAnalysis

struct TargetIRAnalysis
    tm::TargetMachine
end
analysis_string(::TargetIRAnalysis) = "target-ir-analysis"

struct TargetLibraryAnalysis
    triple::String
end
analysis_string(::TargetLibraryAnalysis) = "target-library-analysis"

add!(fam::FunctionAnalysisManager, analysis::TargetIRAnalysis) =
    convert(Core.Bool, API.LLVMRegisterTargetIRAnalysis(fam, analysis.tm))
add!(fam::FunctionAnalysisManager, analysis::TargetLibraryAnalysis) =
    convert(Core.Bool, API.LLVMRegisterTargetLibraryAnalysis(fam, analysis.triple,
                                                             length(analysis.triple)))

function analysis_managers(f::Core.Function, pb::Union{Nothing,PassBuilder}=nothing,
                           tm::Union{Nothing,TargetMachine}=nothing,
                           aa_stack::AbstractVector{<:NewPMAliasAnalysis}=NewPMAliasAnalysis[])
    @dispose lam=LoopAnalysisManager() fam=FunctionAnalysisManager() cam=CGSCCAnalysisManager() mam=ModuleAnalysisManager() begin
        if !isempty(aa_stack)
            add!(fam, AAManager) do aam
                add!(aam, aa_stack)
                if !isnothing(tm)
                    add!(aam, tm)
                end
            end
        end
        if !isnothing(tm)
            add!(fam, TargetIRAnalysis(tm))
            add!(fam, TargetLibraryAnalysis(triple(tm)))
        end
        if !isnothing(pb)
            register!(pb, lam, fam, cam, mam)
        end
        f(lam, fam, cam, mam)
    end
end
