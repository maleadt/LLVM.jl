# deprecated methods

Base.@deprecate llvmtype(x) value_type(x)
Base.@deprecate llvmeltype(x) eltype(value_type(x))

Base.@deprecate_binding Builder IRBuilder

# NOTE: there's more deprecated methods in irbuilder.jl
