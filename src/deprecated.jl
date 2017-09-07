# deprecated methods

export populate!

@deprecate populate!(pm::PassManager, tm::TargetMachine) add_transform_info!(pm, tm)

import Base: get

@deprecate get(iter::ModuleTypeDict, name::String) getindex(iter, name)
@deprecate get(iter::ModuleMetadataDict, name::String) getindex(iter, name)
@deprecate get(iter::ModuleGlobalSet, name::String) getindex(iter, name)
@deprecate get(iter::ModuleFunctionSet, name::String) getindex(iter, name)
