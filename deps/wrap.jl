using Clang.cindex
using Clang.wrap_c

function wrap(config, destdir)
    info("Wrapping LLVM C API at $destdir")
    if !isdir(destdir)
        mkdir(destdir)
    end

    libdir = readchomp(`$config --libdir`)
    version = readchomp(`$config --version`)
    includedir = readchomp(`$config --includedir`)
    cppflags = split(readchomp(`$config --cppflags`))

    # Set-up arguments to clang
    clang_includes = map(x->x[3:end], filter( x->startswith(x,"-I"), cppflags))
    push!(clang_includes, "$libdir/clang/$version/include")
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
