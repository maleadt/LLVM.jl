# Auxiliary functionality for the LLVM.jl package, not part of the LLVM API itself

# llvm.org/docs/doxygen/html/group__LLVMCSupportTypes.html

# LLVM uses a polymorphic type hierarchy which C cannot represent, therefore parameters must
# be passed as base types.
#
# Despite the declared types, most of the functions provided operate only on branches of the
# type hierarchy. The declared parameter names are descriptive and specify which type is
# required. Additionally, each type hierarchy is documented along with the functions that
# operate upon it. For more detail, refer to LLVM's C++ code. If in doubt, refer to
# Core.cpp, which performs parameter downcasts in the form unwrap<RequiredType>(Param).
#
# The following is used to wrap the flattened type hierarchy of the LLVM C API in richer
# Julia types.
const reftypes = Dict{Symbol,Symbol}()
const discriminators = Dict{Symbol, Symbol}()
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
    argtype = Nullable{Symbol}()
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
            @gensym discriminator
            discriminators[typename] = discriminator

            append!(code.args, (quote
                const $discriminator = Dict{Cuint, Type}()
                function identify(::Type{$(typename)}, id::Cuint)
                    haskey($discriminator, id) ||
                        error($(string(value)) * " $(Int(id)) has not been registered")
                    return $discriminator[id]
                end
            end).args)
        end

        # kind: populate parent's discriminator cache
        if key == :kind
            @assert !isnull(argtype)
            discriminator = discriminators[get(argtype)]
            push!(code.args, :( $discriminator[API.$value] = $(typename) ))
        end

        # argtype: via which type's ref this object is passed to the API
        if key == :argtype
            @assert isnull(argtype)
            argtype = Nullable(value)
        end

        # reftype: how this type is referenced in the API (also generates an argtype)
        if key == :reftype
            reftypes[typename] = value
            @assert isnull(argtype)
            argtype = Nullable(typename)
        end
    end

    # if we're dealing with a concrete type, make it usable
    if typedef.head == :type
        # add `ref` field containing an opaque pointer
        unshift!(typedef.args[3].args, :( ref::Ptr{Void} ))

        # handle usage of that ref (ie. converting to and from)
        if isnull(argtype)
            error("no reftype or argtype specified for type $(typename)")
        else
            if !haskey(reftypes, get(argtype))
                error("cannot reference $(typename) via $(get(argtype)) which has no reference type")
            end
            reftype = reftypes[get(argtype)]

            # define a constructor accepting this reftype
            unshift!(typedef.args[3].args, :( $(typename)(ref::API.$reftype) = new(ref) ))

            # define a `ref` method for extracting this reftype
            append!(code.args, (quote
                ref(::Type{$(get(argtype))}, obj::$(typename)) =
                    convert(API.$reftype, obj.ref)
                end).args)
        end

        # define a `null` method for creating an NULL object
        append!(code.args, (quote
            null(::Type{$typename}) = $(typename)(nullref($typename))
            end).args)
    end

    # define a `nullref` method for creating an NULL ref
    if !isnull(argtype)
        reftype = reftypes[get(argtype)]
        append!(code.args, (quote
            nullref(::Type{$typename}) = convert(API.$reftype, C_NULL)
            end).args)
    end

    return esc(code)
end
