# generate LLVM wrappers

using LLVM_full_jll

using Clang.Generators

cd(@__DIR__)

@add_def off_t

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

    build!(ctx)
end

isinteractive() || main()
