# Auxiliary functionality for the LLVM.jl package, not part of the LLVM API itself

const DEBUG = haskey(ENV, "DEBUG")
"Display a debug message. Only results in actual printing if the TRACE or DEBUG environment
variable is set."
@inline function debug(io::IO, msg...; prefix="DEBUG: ", line=true)
    @static if DEBUG
        Base.print_with_color(:green, io, prefix, chomp(string(msg...)))
        if line
            println(io)
        end
    end
end
@inline debug(msg...; kwargs...) = debug(STDERR, msg...; kwargs...)

# Macro to deal with type definitions of LLVM API types.
const apitypes = Dict{Symbol,Symbol}()
const discriminators = Dict{Type, Dict{Cuint, Type}}()
macro reftypedef(args...)
    # extract arguments
    kwargs = args[1:end-1]
    typedef = args[end]

    # decode type definition
    if typedef.head == :abstract
        structure = typedef.args[1]
    elseif typedef.head == :type
        structure = typedef.args[2]
    else
        error("argument is not a type definition")
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

    code = Expr(:block)
    push!(code.args, typedef)

    # decode keyword arguments
    refs = Symbol[]
    for kwarg in kwargs
        if !isa(kwarg, Expr) || kwarg.head != :(=)
            error("malformed keyword arguments before type definition")
        end
        @assert length(kwarg.args) == 2
        (key, value) = kwarg.args
        if !isa(key, Symbol) || !isa(value, Symbol)
            error("key and value in keyword argument should be plain symbols")
        end

        # enum: define an initial `identify` method
        if key == :enum && !haskey(discriminators, typename)
            append!(code.args, (quote
                discriminators[$(typename)] = Dict{Cuint, Type}()  # TODO: gensym
                function identify(::Type{$(typename)}, id::Cuint)
                    haskey(LLVM.discriminators[$(typename)], id) ||
                        error($(string(value)) * " $(Int(id)) has not been registered")
                    return LLVM.discriminators[$(typename)][id]
                end
            end).args)
        end

        # kind: populate parent's discriminator cache
        if key == :kind
            # NOTE: this assumes the parent for which this enum kind is relevant
            #       is the last ref we processed
            push!(code.args, :( discriminators[$(last(refs))][API.$value] = $(typename) ))
        end

        # ref: how this object can be referenced
        if key == :ref
            push!(refs, value)
        end

        # apitype: how this type is referred to in the API (also generates a ref)
        if key == :apitype
            apitypes[typename] = value
            push!(refs, typename)
        end
    end

    # if we're dealing with a concrete type, make it usable
    if typedef.head == :type
        # add `ref` field containing an opaque pointer
        unshift!(typedef.args[3].args, :( ref::Ptr{Void} ))

        # handle usage of that ref (ie. converting to and from)
        if isempty(refs)
            error("no refs specified for type $(typename)")
        end
        for ref in refs
            if !haskey(apitypes, ref)
                error("cannot reference $(typename) via $ref which has no registered API type")
            end
            apitype = apitypes[ref]

            # define a constructor accepting this reftype
            unshift!(typedef.args[3].args, :( $(typename)(ref::API.$apitype) = new(ref) ))

            # generate a `ref` method for extracting this reftype
            append!(code.args, (quote
                ref(::Type{$ref}, obj::$(typename)) =
                    convert(API.$apitype, obj.ref)
                end).args)
        end
    end

    return esc(code)
end
