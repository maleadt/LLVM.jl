# generate LLVM wrappers

using LLVM_full_jll

using Clang

function wrap()
    includedir = LLVM_full_jll.llvm_config() do config
        readchomp(`$config --includedir`)
    end
    cppflags = LLVM_full_jll.llvm_config() do config
        split(readchomp(`$config --cppflags`))
    end

    # Set-up arguments to clang
    clang_includes  = map(x->x[3:end], filter( x->startswith(x,"-I"), cppflags))
    clang_extraargs =                  filter(x->!startswith(x,"-I"), cppflags)

    # FIXME: Clang.jl doesn't properly detect system headers
    push!(clang_extraargs, "-I/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include")

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

    context = init(;
                    headers = header_files,
                    output_file = "libLLVM_h.jl",
                    common_file = "libLLVM_common.jl",
                    clang_includes = convert(Vector{String}, clang_includes),
                    clang_args = convert(Vector{String}, clang_extraargs),
                    header_library = x->"libllvm",
                    header_wrapped = (top,cursor)->occursin("include/llvm", cursor)
                  )

    run(context)
end

function main()
    cd(joinpath(dirname(@__DIR__), "lib")) do
        wrap()
    end
end

isinteractive() || main()

# Manual clean-up:
# - remove build-host details (LLVM_DEFAULT_TARGET_TRIPLE etc) in libLLVM_common.jl
# - remove "# Skipping ..." comments by Clang.jl
# - replace `const (LLVMOpaque.*) = Cvoid` with `struct $1 end`
# - use `gawk -i inplace '/^[[:blank:]]*$/ { print; next; }; {cur = seen[$0]; if(!seen[$0]++ || (/^end$/ && !prev) || /^.*Clang.*$/) print $0; prev=cur}' libLLVM_h.jl` to remove duplicates
# - use `cat -s` to remove duplicate empty lines
