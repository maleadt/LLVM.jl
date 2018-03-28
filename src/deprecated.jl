# deprecated methods

import Base: get

@deprecate get(set::TargetSet, name::String) getindex(set, name)
