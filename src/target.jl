## target

export Target,
       name, description,
       hasjit, hastargetmachine, hasasmparser

@checked immutable Target
    ref::API.LLVMTargetRef
end
reftype(::Type{Target}) = API.LLVMTargetRef

function Target(triple::String)
    out_ref = Ref{API.LLVMTargetRef}()
    out_error = Ref{Cstring}()
    status = convert(Core.Bool, API.LLVMGetTargetFromTriple(triple, out_ref, out_error))

    if status
        error = unsafe_string(out_error[])
        API.LLVMDisposeMessage(out_error[])
        throw(LLVMException(error))
    end

    return Target(out_ref[])
end

name(t::Target) = unsafe_string(API.LLVMGetTargetName(ref(t)))

description(t::Target) = unsafe_string(API.LLVMGetTargetDescription(ref(t)))

hasjit(t::Target) = convert(Core.Bool, API.LLVMTargetHasJIT(ref(t)))
hastargetmachine(t::Target) = convert(Core.Bool, API.LLVMTargetHasTargetMachine(ref(t)))
hasasmparser(t::Target) = convert(Core.Bool, API.LLVMTargetHasAsmBackend(ref(t)))

# target iteration

export targets

import Base: eltype, haskey, get, start, next, done, iteratorsize

immutable TargetSet end

targets() = TargetSet()

eltype(::TargetSet) = Target

function haskey(::TargetSet, name::String)
    return API.LLVMGetTargetFromName(name) != C_NULL
end

function get(::TargetSet, name::String)
    objref = API.LLVMGetTargetFromName(name)
    objref == C_NULL && throw(KeyError(name))
    return Target(objref)
end

start(::TargetSet) = API.LLVMGetFirstTarget()

next(::TargetSet, state) =
    (Target(state), API.LLVMGetNextTarget(state))

done(::TargetSet, state) = state == C_NULL

iteratorsize(::TargetSet) = Base.SizeUnknown()
