# discovery of Julia, LLVM, and LLVM wrappers in LLVM.jl

include("util.jl")


#
# LLVM discovery
#

# possible names for libLLVM given a LLVM version number
function llvm_libnames(version::VersionNumber)
    @static if is_apple()
        # macOS dylibs are versioned already
        return ["libLLVM.dylib"]
    elseif is_linux()
        # Linux DSO's aren't versioned, so only use versioned filenames
        return ["libLLVM-$(version.major).$(version.minor).$(version.patch).so",
                "libLLVM-$(version.major).$(version.minor).$(version.patch)svn.so",
                "libLLVM-$(version.major).$(version.minor).so",
                "libLLVM-$(version.major).$(version.minor)svn.so"]
    else
        error("Unknown OS")
    end
end

# returns vector of Tuple{path::AbstractString, VersionNumber}
function find_libllvm(dir::AbstractString, versions::Vector{VersionNumber})
    debug("Looking for libLLVM in $dir")
    libraries = Vector{Tuple{String, VersionNumber}}()
    for version in versions, name in llvm_libnames(version)
        lib = joinpath(dir, name)
        if ispath(lib)
            debug("- v$version at $lib")
            push!(libraries, tuple(lib, version))
        end
    end

    return libraries
end

# returns vector of Tuple{path::AbstractString, VersionNumber}
function find_llvmconfig(dir::AbstractString)
    debug("Looking for llvm-config in $dir")
    configs = Vector{Tuple{String, VersionNumber}}()
    for file in readdir(dir)
        if startswith(file, "llvm-config")
            path = joinpath(dir, file)
            version = VersionNumber(strip(readstring(`$path --version`)))
            debug("- $version at $path")
            push!(configs, tuple(path, version))
        end
    end

    return configs
end

function discover_llvm()
    libllvms = Vector{Toolchain}()

    # check for bundled LLVM libraries
    # NOTE: as we only build the extras library from source, these libraries will never be
    #       used, but leave this code here as it may be used if we figure out how to provide
    #       bindeps
    libdirs = [joinpath(JULIA_HOME, "..", "lib", "julia")]
    for libdir in libdirs
        libraries = find_libllvm(libdir, [base_llvm_version])

        for (library, version) in libraries
            push!(libllvms, Toolchain(library, version))
        end
    end

    # check for llvm-config binaries in known locations
    if use_system_llvm
        configdirs = [split(ENV["PATH"], ':')...]
    else
        configdirs = [JULIA_HOME, joinpath(JULIA_HOME, "..", "tools")]
    end
    for dir in unique(configdirs)
        isdir(dir) || continue
        configs = find_llvmconfig(dir)

        # look for libraries in the reported library directory
        for (config, version) in configs
            libdir = readchomp(`$config --libdir`)
            libraries = find_libllvm(libdir, [version])

            for (library, _) in libraries
                push!(libllvms, Toolchain(library, version, config))
            end
        end
    end

    # prune
    libllvms = unique(x -> realpath(x.path), libllvms)

    return libllvms
end


#
# Julia discovery
#

function discover_julia()
    julia_cmd = Base.julia_cmd()
    julia = Toolchain(julia_cmd.exec[1], Base.VERSION,
                      joinpath(JULIA_HOME, "..", "share", "julia", "julia-config.jl"))
    isfile(julia.path) || error("could not find Julia binary from command $julia_cmd")
    if !isfile(get(julia.config)) && julia.version.minor == 5
        # HACK for 0.5: non-installed builds are incomplete (see JuliaLang/julia#19002)
        #               so we include those in-tree paths here
        root = joinpath(JULIA_HOME, "..", "..")
        julia = Toolchain(julia.path, julia.version, joinpath(root, "contrib", "julia-config.jl"))
        ENV["EXTRA_CXXFLAGS"] = join(
            map(dir->"-I"*joinpath(root, dir), ["src", "src/support", "usr/include"]), " ")
    end
    isfile(get(julia.config)) || error("could not find julia-config.jl relative to $(JULIA_HOME)")

    return julia
end


#
# LLVM wrapper discovery
#

function discover_wrappers()
    return map(dir->VersionNumber(dir),
               filter(path->isdir(joinpath(@__DIR__, "..", "lib", path)),
                      readdir(joinpath(@__DIR__, "..", "lib"))))
end


#
# Main
#

function discover()
    return discover_llvm(),
           discover_wrappers(),
           discover_julia()
end

if realpath(joinpath(pwd(), PROGRAM_FILE)) == realpath(@__FILE__)
    libllvms, wrappers, julia = discover()

    println("LLVM libraries:")
    for libllvm in libllvms
        println("- ", libllvm)
    end
    println()

    println("Wrapped LLVM versions:")
    for wrapper in wrappers
        println("- ", wrapper)
    end
    println()

    println("Julia: $julia")
end
