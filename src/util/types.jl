# Defining types in the LLVM type hierarchy

# llvm.org/docs/doxygen/html/group__LLVMCSupportTypes.html

struct Bug <: Exception
    msg::AbstractString
end

function Base.showerror(io::IO, err::Bug)
    @printf(io, "%s; this is probably a bug, please file an issue", err.msg)
end

bug(msgs...) = throw(Bug(join(msgs...)))

# traits
reftype(t::Type) = bug("No reference type defined for $t")

# abstract implementations
ref(obj) = obj.ref
identify(::Type{T}, ref) where {T} = T(ref)
@inline function check(::Type, ref::Ptr)
    ref==C_NULL && throw(UndefRefError())
end

# macro that adds an inner constructor to a type definition,
# calling `check` on the ref field argument
macro checked(typedef)
    # decode structure definition
    if typedef.head == :macrocall
        # handle `@compat` prefixing 0.6-style type declarations
        typedef = macroexpand(typedef)
    end
    if typedef.head == :struct
        structure = typedef.args[2]
        body = typedef.args[3]
    else
        error("argument is not a structure definition")
    end
    if isa(structure, Symbol)
        # basic type definition
        typename = structure
    elseif isa(structure, Expr) && structure.head == :<:
        # typename <: parentname
        all(e->isa(e,Symbol), structure.args) ||
            error("typedef should consist of plain types, ie. not parametric ones")
        typename = structure.args[1]
    else
        error("malformed type definition: cannot decode type name")
    end

    # decode fields
    field_names = Symbol[]
    field_defs = Union{Symbol,Expr}[]
    for arg in body.args
        if isa(arg, LineNumberNode)
            continue
        elseif isa(arg, Symbol)
            push!(field_names, arg)
            push!(field_defs, arg)
        elseif arg.head == :(::)
            push!(field_names, arg.args[1])
            push!(field_defs, arg)
        end
    end
    :ref in field_names || error("structure definition should contain 'ref' field")

    # insert checked constructor
    push!(body.args, :(
        $typename($(field_defs...)) = (check($typename, ref); new($(field_names...)))
    ))

    return esc(typedef)
end
