# Utilities for working with LLVM source code

## cloning

export clone_into!, clone

type_mapper_callback(typ, type_mapper) =
    Base.unsafe_convert(API.LLVMTypeRef, type_mapper[](LLVMType(typ)))
function materializer_callback(val, materializer)
    new_val = materializer[](Value(val))
    if new_val === nothing
        return Base.unsafe_convert(API.LLVMValueRef, C_NULL)
    else
        return Base.unsafe_convert(API.LLVMValueRef, new_val)
    end
end

function clone_into!(new::Function, old::Function;
                     value_map::Dict{Value,Value}=Dict{Value,Value}(),
                     changes=API.LLVMCloneFunctionChangeTypeLocalChangesOnly,
                     suffix::String="", type_mapper=nothing, materializer=nothing)
    value_map_array = Value[]
    for (src, dest) in value_map
        push!(value_map_array, src)
        push!(value_map_array, dest)
    end
    if type_mapper === nothing
        type_mapper_ptr = C_NULL
        type_mapper_data = C_NULL
    else
        type_mapper_ptr = @cfunction(type_mapper_callback, API.LLVMTypeRef, (API.LLVMTypeRef,Any))
        type_mapper_data = Ref(type_mapper)
    end
    if materializer === nothing
        materializer_ptr = C_NULL
        materializer_data = C_NULL
    else
        materializer_ptr = @cfunction(materializer_callback, API.LLVMValueRef, (API.LLVMValueRef,Any))
        materializer_data = Ref(materializer)
    end
    API.LLVMCloneFunctionInto(new, old, value_map_array, length(value_map), changes, suffix,
                              type_mapper_ptr, type_mapper_data,
                              materializer_ptr, materializer_data)
end

function clone(f::Function; value_map::Dict{Value,Value}=Dict{Value,Value}())
    argtypes = LLVMType[]

    # The user might be deleting arguments to the function by specifying them in
    # the VMap. If so, we need to not add the arguments to the arg ty vector
    for arg in parameters(f)
        if !in(arg, keys(value_map))    # Haven't mapped the argument to anything yet?
            push!(argtypes, value_type(arg))
        end
    end

    # Create a new function type...
    oldfty = function_type(f)
    vararg = isvararg(oldfty)
    fty = FunctionType(return_type(oldfty), argtypes; vararg)

    # Create the new function...
    new_f = Function(parent(f), name(f), fty)
    linkage!(new_f, linkage(f))
    # TODO: address space

    # Loop over the arguments, copying the names of the mapped arguments over...
    for (arg, new_arg) in zip(parameters(f), parameters(new_f))
        if !in(arg, keys(value_map))    # Is this argument preserved?
            name!(new_arg, name(arg))   # Copy the name over...
            value_map[arg] = new_arg    # Add mapping to VMap
        end
    end

    clone_into!(new_f, f;
                value_map, changes=API.LLVMCloneFunctionChangeTypeLocalChangesOnly)

   return new_f
end

"""
    clone(bb::BasicBlock]; dest=parent(bb), suffix="", value_map=Dict{Value,Value})

Clone a basic block `bb` by copying all instructions. The new block is inserted at the end
of the parent function; this can be altered by setting `dest` to a different function, or to
`nothing` to create a detached block. The `suffix` is appended to the name of the cloned
basic block.

!!! warn

    This function only remaps values that are defined in the cloned basic block. Values
    defined outside the basic block (e.g. function arguments) are not remapped by default.
    This means that the cloned basic block can generally only be used within the same
    function that it was cloned from, unless you manually remap other values.
    This can be done passing a `value_map` dictionary.
"""
function clone(bb::BasicBlock; dest::Union{Nothing,Function}=parent(bb), suffix::String="",
               value_map::Dict{Value,Value}=Dict{Value,Value}())
    value_map_array = Value[]
    for (src, dest) in value_map
        push!(value_map_array, src)
        push!(value_map_array, dest)
    end
    BasicBlock(API.LLVMCloneBasicBlock(bb, suffix, value_map_array, length(value_map),
                                       something(dest, C_NULL)))
end
