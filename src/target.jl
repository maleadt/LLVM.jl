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

struct TargetSet end

targets() = TargetSet()

Base.eltype(::TargetSet) = Target

function Base.haskey(::TargetSet, name::String)
    return API.LLVMGetTargetFromName(name) != C_NULL
end

function Base.get(::TargetSet, name::String)
    objref = API.LLVMGetTargetFromName(name)
    objref == C_NULL && throw(KeyError(name))
    return Target(objref)
end

Base.start(::TargetSet) = API.LLVMGetFirstTarget()

Base.next(::TargetSet, state) =
    (Target(state), API.LLVMGetNextTarget(state))

Base.done(::TargetSet, state) = state == C_NULL

IteratorSize(::TargetSet) = Base.SizeUnknown()
