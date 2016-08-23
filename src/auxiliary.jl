# Auxiliary functionality for the LLVM.jl package, not part of the LLVM API itself

const discriminators = Dict{Type, Dict{Cuint, Type}}()

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

# Overly-complex macro to deal with type definitions of LLVM API types.
# It performs the following tasks:
# - add a `ref` field to concrete types to contain the API reference pointer
# - define constructors from and converts to each of the API reference types
#   this type can be represented by
# - detect API enums identifying objects in flattened object trees,
#   and provide an `identify` method to get the corresponding Julia type
macro llvmtype(typedef)
    if typedef.head == :abstract
        structure = typedef.args[1]
    elseif typedef.head == :type
        structure = typedef.args[2]
    else
        error("argument is not a type definition")
    end

    code = Expr(:block)
    push!(code.args, typedef)

    # extract name of the type and its parents, if any
    hierarchy = Symbol[]
    if isa(structure, Symbol)
        # basic type definition
        push!(hierarchy, structure)
        typename = structure
    elseif isa(structure, Expr) && structure.head == :<:
        # typename <: parentname
        all(e->isa(e,Symbol), structure.args) ||
            error("typedef should consist of plain types, ie. not parametric ones")
        (typename, parentname) = structure.args
        push!(hierarchy, typename)

        isdefined(LLVM, parentname) || error("unknown parent type $parentname")
        parenttype = @eval $parentname
        while parenttype != Any
            push!(hierarchy, Symbol(parenttype.name.name))
            parenttype = supertype(parenttype)
        end
    else
        error("malformed type definition: cannot decode type name")
    end

    # figure out counterpart LLVM typenames
    function get_api_typename(name::Symbol, tail::Symbol, head=:LLVM)
        # some types start with LLVM in order to avoid clashes with Core (eg. Type, Module)
        if startswith(string(name), "LLVM")
            api_name = Symbol(string(name)[5:end])
        else
            api_name = name
        end

        return Symbol(head, api_name, tail)
    end
    apireftypes = Dict{Symbol,Symbol}()
    for link in hierarchy
        apireftype =  get_api_typename(link, :Ref)
        if isdefined(API, apireftype)
            apireftypes[link] = apireftype
        end
    end

    # if we're dealing with a concrete type, make it usable
    if typedef.head == :type
        # add `ref` field containing an opaque pointer
        unshift!(typedef.args[3].args, :( ref::Ptr{Void} ))

        # handle usage of that ref (ie. converting to and from)
        #
        # sometimes a type is referred to by one or more of its parent API ref types,
        # eg. ConstantInt is represented by a ValueRef (one of its supertypes),
        # while BasicBlock can be represented by both BasicBlockRef and ValueRef
        api_hierarchy = filter(t->haskey(apireftypes,t), hierarchy)
        isempty(api_hierarchy) &&
            error("no type in $typename's hierarchy ($(join(hierarchy, ", "))) exists in the LLVM API")
        for api_typename in api_hierarchy
            apireftype = apireftypes[api_typename]

            # define a constructor accepting this reftype
            unshift!(typedef.args[3].args, :( $typename(ref::API.$apireftype) = new(ref) ))

            # generate a convert method for extracting this reftype
            append!(code.args, (quote
                import Base: convert
                convert(::Type{API.$apireftype}, obj::$typename) =
                    convert(API.$apireftype, obj.ref)
                end).args)
        end
    end

    # check if there exists an enum to differentiate child types from their common parent
    # and use it to generate a `identify` method for identifying references
    for parentname in hierarchy[2:end]  # eg. LLVMStructTypeKind::StructType->CompositeType->Type
        # parent needs to have a valid ref type
        haskey(apireftypes, parentname) || continue
        parenttype = @eval $parentname

        # try and map a type to its API enum kind value. this isn't always straightforward,
        # eg. FunctionType -> LLVMFunctionTypeKind vs Integer -> LLVMIntegerTypeKind
        apikind = get_api_typename(typename, :Kind)
        # NOTE: we don't check for existence of the parent enum,
        #       but rather check for the child kind
        if !isdefined(API, apikind)
            parent_tag = Symbol(string(parentname)[5:end])
            apikind = get_api_typename(Symbol(typename,
                                       get_api_typename(parentname, Symbol(), Symbol())),
                                       :Kind)
        end
        isdefined(API, apikind) || continue

        # first time encountering a `kind` for this parent type
        # --> populate the discriminator cache and define a convert method
        global discriminators
        if !haskey(discriminators, parenttype)
            # first occurrence of a discriminator for the parent type,
            # so define the `identify` method
            apireftype = apireftypes[parentname]
            append!(code.args, (quote
                function identify(::API.$apireftype, id::Cuint)
                    haskey(discriminators[$parenttype], id) ||
                        error($(string(apireftype)) * " kind $(Int(id)) has not been registered")
                    return discriminators[$parenttype][id]
                end
            end).args)

            discriminators[parenttype] = Dict{Cuint, Type}()
        end

        # save this enum kind in the discriminator cache
        push!(code.args, :( discriminators[$parentname][API.$apikind] = $typename ))
    end

    return esc(code)
end
