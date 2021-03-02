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

    args = get_default_args("x86_64-linux-gnu")
    push!(args, "-I$includedir")
    append!(args, cppflags)

    header_files = detect_headers(joinpath(includedir, "llvm-c"), args)

    ctx = create_context(header_files, args, options)

    build!(ctx, BUILDSTAGE_NO_PRINTING)

    rewriter!(ctx)

    build!(ctx, BUILDSTAGE_PRINTING_ONLY)
end

isinteractive() || main()
