# deprecated methods

@deprecate FunctionType(rettyp, params, vararg) FunctionType(rettyp, params; vararg=vararg)

# Target non-kwarg constructor
@deprecate Target(triple::String) Target(; triple=triple)

# TargetIterator dict-like behavior
import Base: haskey, getindex, get
@deprecate get(set::TargetIterator, name::String) getindex(set, name)
@deprecate haskey(::TargetIterator, name::String) Target(;name=name) !== nothing
@deprecate getindex(iter::TargetIterator, name::String) Target(;name=name)
@deprecate get(::TargetIterator, name::String, default) try Target(;name=name) catch; default end

@deprecate intrinsic_id(f::Function) isintrinsic(f) ? Intrinsic(f) : 0
