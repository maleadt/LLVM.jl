## target

export Target,
       name, description,
       hasjit, hastargetmachine, hasasmparser

@checked struct Target
    ref::API.LLVMTargetRef
end
reftype(::Type{Target}) = API.LLVMTargetRef

function Target(triple::String)
    out_ref = Ref{API.LLVMTargetRef}()
    out_error = Ref{Cstring}()
    status = convert(Core.Bool, API.LLVMGetTargetFromTriple(triple, out_ref, out_error))

    if status
        error = unsafe_message(out_error[])
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

struct TargetSet end

targets() = TargetSet()

Base.eltype(::TargetSet) = Target

function Base.haskey(::TargetSet, name::String)
    return API.LLVMGetTargetFromName(name) != C_NULL
end

function Base.get(::TargetSet, name::String, default)
    objref = API.LLVMGetTargetFromName(name)
    return objref == C_NULL ? default : Target(objref)
end

function Base.getindex(targetset::TargetSet, name::String)
    f = get(targetset, name, nothing)
    return f == nothing ? throw(KeyError(name)) : f
end

function Base.iterate(iter::TargetSet, state=API.LLVMGetFirstTarget())
    state == C_NULL ? nothing : (Target(state), API.LLVMGetNextTarget(state))
end

Base.IteratorSize(::TargetSet) = Base.SizeUnknown()
