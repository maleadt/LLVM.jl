# deprecated methods

import Base: get

@deprecate get(set::TargetSet, name::String) getindex(set, name)

@deprecate FunctionType(rettyp, params, vararg) FunctionType(rettyp, params; vararg=vararg)
