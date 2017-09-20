# Keeps track of the variables that are in the current scope
struct Scope
    values::Dict{String, LLVM.User}
    parent::Scope

    Scope() = new(Dict{String, LLVM.AllocaInst}())
    Scope(parent::Scope) = new(Dict{String, LLVM.User}(), parent)
end

# Look for variable in `scope` and if not found, look recursively in parent
function _get(scope::Scope, var::String, default)
    v = get(scope.values, var, nothing)
    if v != nothing
        return v
    else
        return isdefined(scope, :parent) ? _get(scope.parent, var, default) : default
    end
end

mutable struct CurrentScope
    scope::Scope
end

CurrentScope() = CurrentScope(Scope())
isglobalscope(c::CurrentScope) = !isdefined(c.scope, :parent)
open_scope!(currentscope::CurrentScope) = (currentscope.scope = Scope(currentscope.scope); currentscope)
Base.pop!(currentscope::CurrentScope) = (currentscope.scope = currentscope.scope.parent)
Base.setindex!(currentscope::CurrentScope, v::LLVM.User, var::String) = currentscope.scope.values[var] = v
Base.get(currentscope::CurrentScope, var::String, default) = _get(currentscope.scope, var, default)
