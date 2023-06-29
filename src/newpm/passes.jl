abstract type Pass end
abstract type LLVMPass <: Pass end

MODULE_PASSES = Dict{Type, String}([
    # TODO
])

CGSCC_PASSES = Dict{Type, String}([
    # TODO
])

FUNCTION_PASSES = Dict{Type, String}([
    # TODO
])

LOOP_PASSES = Dict{Type, String}([
    # TODO
])

to_string(::Type{ModulePassManager}, pass::LLVMPass) = MODULE_PASSES[typeof(pass)]
to_string(::Type{CGSCCPassManager}, pass::LLVMPass) = CGSCC_PASSES[typeof(pass)]
to_string(::Type{FunctionPassManager}, pass::LLVMPass) = FUNCTION_PASSES[typeof(pass)]
to_string(::Type{LoopPassManager}, pass::LLVMPass) = LOOP_PASSES[typeof(pass)]
