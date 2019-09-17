# generate LLVM wrappers

using Clang

function wrap(config, destdir)
    @info("Wrapping LLVM C API at $destdir")
    if !isdir(destdir)
        mkdir(destdir)
    end

    includedir = readchomp(`$config --includedir`)
    cppflags = split(readchomp(`$config --cppflags`))

    # TODO: this should really be taken care of by Clang.jl...
    if haskey(ENV, "LLVM_CONFIG")
        clang_config = ENV["LLVM_CONFIG"]
    else
        clang_config = joinpath(dirname(pathof(Clang)), "..", "deps", "usr", "tools", "llvm-config")
    end
    clang_libdir = readchomp(`$clang_config --libdir`)
    clang_version = readchomp(`$clang_config --version`)

    # Set-up arguments to clang
    clang_includes  = map(x->x[3:end], filter( x->startswith(x,"-I"), cppflags))
    push!(clang_includes, "$clang_libdir/clang/$clang_version/include")
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
                    output_file = "$destdir/libLLVM_h.jl",
                    common_file = "$destdir/libLLVM_common.jl",
                    clang_includes = convert(Vector{String}, clang_includes),
                    clang_args = convert(Vector{String}, clang_extraargs),
                    header_library = x->"libllvm",
                    header_wrapped = (top,cursor)->occursin("include/llvm", cursor)
                  )

    run(context)
end

length(ARGS) == 2 || error("Usage: wrap.jl /path/to/llvm-config target")
config = ARGS[1]
ispath(config) || error("llvm-config at $config is't a valid path")

# Manual clean-up:
# - remove build-host details (HAVE_INTTYPES_H, LLVM_DEFAULT_TARGET_TRIPLE etc) in libLLVM_common.jl
# - remove LLVMInitializeAll and LLVMInitializeNative wrappers (these are macros)
# - remove "# Skipping ..." comments by Clang.jl
# - replace `ccall\(\((:.+), libllvm\), (.*)\)` with `@apicall($1, $2)`
# - replace `const (LLVMOpaque.*) = Cvoid` with `struct $1 end`
# - use `awk '/^[[:blank:]]*$/ { print; next; }; {cur = seen[$0]; if(!seen[$0]++ || (/^end$/ && !prev) || /^.*Clang.*$/) print $0; prev=cur}' libLLVM_h.jl > libLLVM_g.jl` to remove duplicates
# - use `cat -s` to remove duplicate empty lines

target = ARGS[2]
wrap(config, target)
