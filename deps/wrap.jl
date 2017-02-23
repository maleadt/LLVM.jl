using Clang.cindex
using Clang.wrap_c

using Compat
import Compat.String

include("common.jl")

function wrap(config, destdir)
    info("Wrapping LLVM C API at $destdir")
    if !isdir(destdir)
        mkdir(destdir)
    end

    includedir = readchomp(`$config --includedir`)
    cppflags = split(readchomp(`$config --cppflags`))

    # TODO: this should really be taken care of by Clang.jl...
    haskey(ENV, "LLVM_CONFIG") || error("please provide the llvm-config Clang.jl was build with using LLVM_CONFIG")
    clang_config = ENV["LLVM_CONFIG"]
    clang_libdir = readchomp(`$clang_config --libdir`)
    clang_version = readchomp(`$clang_config --version`)

    # Set-up arguments to clang
    clang_includes = map(x->x[3:end], filter( x->startswith(x,"-I"), cppflags))
    push!(clang_includes, "$clang_libdir/clang/$clang_version/include")
    clang_extraargs =                 filter(x->!startswith(x,"-I"), cppflags)

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
            else isfile(path) && endswith(path, ".h")
                push!(header_files, path)
            end
        end
    end

    context = wrap_c.init(;
                          output_file = "$destdir/libLLVM_h.jl",
                          common_file = "$destdir/libLLVM_common.jl",
                          clang_includes = convert(Vector{Compat.ASCIIString}, clang_includes),
                          clang_args = convert(Vector{Compat.ASCIIString}, clang_extraargs),
                          header_library = x->:libllvm,
                          header_wrapped = (top,cursor)->contains(cursor, "include/llvm") )

    context.headers = header_files
    run(context)
end

length(ARGS) == 1 || error("Usage: wrap.jl /path/to/llvm-config")
config = first(ARGS)
ispath(config) || error("llvm-config at $config is't a valid path")

version = VersionNumber(readchomp(`$config --version`))
wrapped_libdir = joinpath(@__DIR__, "..", "lib", verstr(version))

wrap(config, wrapped_libdir)
