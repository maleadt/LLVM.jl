# generate LLVM wrappers

using LLVM_full_jll

using Clang.Generators
import Clang

cd(@__DIR__)

@add_def off_t

function main()
    options = load_options(joinpath(@__DIR__, "wrap_llvmextra.toml"))

    includedir = LLVM_full_jll.llvm_config() do config
        readchomp(`$config --includedir`)
    end
    cppflags = LLVM_full_jll.llvm_config() do config
        split(readchomp(`$config --cppflags`))
    end

    args = get_default_args("x86_64-linux-gnu")
    push!(args, "-Isystem$includedir")
    append!(args, cppflags)

    header_files = detect_headers(realpath(joinpath(@__DIR__, "..", "deps", "LLVMExtra", "include")), args)

    ctx = create_context(header_files, args, options)

    build!(ctx, BUILDSTAGE_NO_PRINTING)

    # custom rewriter
    function rewrite!(dag::ExprDAG)
        replace!(get_nodes(dag)) do node
            filename = normpath(Clang.get_filename(node.cursor))
            if !contains(filename, "LLVMExtra")
                return ExprNode(node.id, Generators.Skip(), node.cursor, Expr[], node.adj)
            end
            return node
        end
    end

    rewrite!(ctx.dag)

    # print
    build!(ctx, BUILDSTAGE_PRINTING_ONLY)

end

isinteractive() || main()
