# generate LLVM wrappers

using LLVM_full_jll

using Clang.Generators

cd(@__DIR__)

@add_def off_t

# replace `ccall` with `@runtime_ccall`
function rewriter!(ctx)
    for node in get_nodes(ctx.dag)
        Generators.is_function(node) || continue
        if !Generators.is_variadic_function(node)
            expr = node.exprs[1]
            call_expr = expr.args[2].args[1]
            call_expr.head = :macrocall
            call_expr.args[1] = Symbol("@runtime_ccall")
            insert!(call_expr.args, 2, nothing)
        end
    end
end

function main()
    options = load_options(joinpath(@__DIR__, "wrap.toml"))

    includedir = LLVM_full_jll.llvm_config() do config
        readchomp(`$config --includedir`)
    end
    cppflags = LLVM_full_jll.llvm_config() do config
        split(readchomp(`$config --cppflags`))
    end

    # FIXME: Clang.jl doesn't properly detect system headers
    @static if Sys.islinux()
        push!(cppflags, "-I/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include")
    end

    # Recursively discover LLVM C API headers (files ending in .h)
    header_dirs = String[joinpath(includedir, "llvm-c")]
    header_files = String[]
    while !isempty(header_dirs)
        parent = pop!(header_dirs)
        children = readdir(parent)
        for child in children
            path = joinpath(parent, child)
            if isdir(path)
                push!(header_dirs, path)
            elseif isfile(path) && endswith(path, ".h")
                push!(header_files, path)
            end
        end
    end

    ctx = create_context(header_files, convert(Vector{String}, cppflags), options)

    build!(ctx, BUILDSTAGE_NO_PRINTING)

    rewriter!(ctx)

    build!(ctx, BUILDSTAGE_PRINTING_ONLY)
end

isinteractive() || main()
