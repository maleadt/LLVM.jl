# utilities

function unsafe_message(ptr, args...)
    str = unsafe_string(ptr, args...)
    API.LLVMDisposeMessage(ptr)
    str
end


## defining types in the LLVM type hierarchy

# llvm.org/docs/doxygen/html/group__LLVMCSupportTypes.html

# traits
reftype(t::Type) = error("No reference type defined for $t")

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
    if Meta.isexpr(typedef, :macrocall)
        # handle `@compat` prefixing 0.6-style type declarations
        typedef = macroexpand(typedef)
    end
    if Meta.isexpr(typedef, :struct)
        structure = typedef.args[2]
        body = typedef.args[3]
    else
        error("argument is not a structure definition")
    end
    if isa(structure, Symbol)
        # basic type definition
        typename = structure
    elseif Meta.isexpr(structure, :<:)
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
        elseif Meta.isexpr(arg, :(::))
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


## runtime ccall wrapper

"""
    @runtime_ccall((function_name, library), returntype, (argtype1, ...), argvalue1, ...)

Extension of `ccall` that performs the lookup of `function_name` in `library` at run time.
This is useful in the case that `library` might not be available, in which case a function
that performs a `ccall` to that library would fail to compile.

After a slower first call to load the library and look up the function, no additional
overhead is expected compared to regular `ccall`.
"""
macro runtime_ccall(target, args...)
    # decode ccall function/library target
    Meta.isexpr(target, :tuple) || error("Expected (function_name, library) tuple")
    function_name, library = target.args

    # global const ref to hold the function pointer
    @gensym fptr_cache
    @eval __module__ begin
        # uses atomics (release store, acquire load) for thread safety.
        # see https://github.com/JuliaGPU/CUDAapi.jl/issues/106 for details
        const $fptr_cache = Threads.Atomic{Int}(0)
    end

    return quote
        # use a closure to hold the lookup and avoid code bloat in the caller
        @noinline function cache_fptr!()
            library = Libdl.dlopen($(esc(library)))
            $(esc(fptr_cache))[] = Libdl.dlsym(library, $(esc(function_name)))

            $(esc(fptr_cache))[]
        end

        fptr = $(esc(fptr_cache))[]
        if fptr == 0        # folded into the null check performed by ccall
            fptr = cache_fptr!()
        end

        ccall(reinterpret(Ptr{Cvoid}, fptr), $(map(esc, args)...))
    end

    return
end
