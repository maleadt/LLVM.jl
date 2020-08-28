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
                    output_file = "libLLVM.jl",
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
# - remove build-host details (HAVE_INTTYPES_H, LLVM_DEFAULT_TARGET_TRIPLE etc) in libLLVM_common.jl
# - remove LLVMInitializeAll and LLVMInitializeNative wrappers (these are macros)
# - remove "# Skipping ..." comments by Clang.jl
# - replace `ccall\(\((:.+), libllvm\), (.*)\)` with `@runtime_ccall($1, $2)`
# - replace `const (LLVMOpaque.*) = Cvoid` with `struct $1 end`
# - use `gawk -i inplace '/^[[:blank:]]*$/ { print; next; }; {cur = seen[$0]; if(!seen[$0]++ || (/^end$/ && !prev) || /^.*Clang.*$/) print $0; prev=cur}' libLLVM_h.jl` to remove duplicates
# - use `cat -s` to remove duplicate empty lines
