# This script looks for LLVM installations and selects one based on the compatibility with
# available wrappers.
#
# This is somewhat convoluted, as we can find LLVM in a variety of places using different
# mechanisms, while version matching needs to consider API compatibility.
#
# Environment variables influencing this process:
#   DEBUG=1                     print debug information
#   LLVM_VERSION=$MAJOR.$MINOR  only consider using a specific LLVM version
#                               (which still needs to be compatible)

using Compat
import Compat.String

include("common.jl")
include(joinpath(@__DIR__, "..", "src", "logging.jl"))

const libext = is_apple() ? "dylib" : "so"

function libname(version::VersionNumber)
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

immutable Toolchain
    path::String
    version::VersionNumber
    config::Nullable{String}
end


#
# Versions
#

# LLVM versions to look for.
#
# Note that this list can be incomplete, as we'll still look for unversioned llvm-config
# binaries which may yield different versions.
acceptable_versions = [VersionNumber(Base.libllvm_version),
                       v"4.0",
                       v"3.9.0",
                       v"3.8.1", v"3.8.0"]
sort!(acceptable_versions)

if haskey(ENV, "LLVM_VERSION")
    ismatch(r"^\d.\d$", ENV["LLVM_VERSION"]) ||
        error("invalid version requested (should be MAJOR.MINOR)")
    requested_version = Nullable(VersionNumber(ENV["LLVM_VERSION"]))

    # NOTE: even though we'll only consider the requested version,
    #       still look for others as it may be useful for debugging purposes
    push!(acceptable_versions, get(requested_version))
else
    requested_version = Nullable{VersionNumber}()
end

debug("Acceptable LLVM versions: ", join(acceptable_versions, ", "))



#
# LLVM discovery
#
llvms = Vector{Toolchain}()

# returns vector of Tuple{path::String, VersionNumber}
function find_libllvm(dir::String, versions::Vector{VersionNumber})
    debug("Looking for libLLVM in $dir")
    libraries = Vector{Tuple{String, VersionNumber}}()
    for version in versions, name in libname(version)
        lib = joinpath(dir, name)
        if ispath(lib)
            debug("- v$version at $lib")
            push!(libraries, tuple(lib, version))
        end
    end

    return libraries
end

# returns vector of Tuple{path::String, VersionNumber}
function find_llvmconfig(dir::String)
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

# check for versioned LLVM libraries in known locations
libdirs = [joinpath(JULIA_HOME, "..", "lib", "julia")]
for libdir in libdirs
    libraries = find_libllvm(libdir, acceptable_versions)

    for (library, version) in libraries
        push!(llvms, Toolchain(library, version, Nullable{String}()))
    end
end

# check for llvm-config binaries in known locations
configdirs = [JULIA_HOME, joinpath(JULIA_HOME, "..", "tools"), split(ENV["PATH"], ':')...]
for dir in unique(configdirs)
    isdir(dir) || continue
    configs = find_llvmconfig(dir)

    # look for libraries in the reported library directory
    for (config, version) in configs
        libdir = readchomp(`$config --libdir`)
        libraries = find_libllvm(libdir, [version])

        for (library, _) in libraries
            push!(llvms, Toolchain(library, version, config))
        end
    end
end

# prune
llvms = unique(x -> realpath(x.path), llvms)

info("Found $(length(llvms)) unique LLVM installations")


#
# LLVM selection
#

# First consider installations with a major and minor version matching wrapped headers (see
# the `lib` folder) are considered first. If no such installation have been found, consider
# probably-compatible versions (ie. for which we have an older set of wrapped headers).
#
# If the user requested a specific version, only ever consider that version.

vercmp_match  = (a,b) -> a.major==b.major &&  a.minor==b.minor
vercmp_compat = (a,b) -> a.major>b.major  || (a.major==b.major && a.minor>=b.minor)

if !isnull(requested_version)
    info("Overriding selection to match v$(get(requested_version))")
    llvms = filter(t->vercmp_match(t.version,get(requested_version)), llvms)
end

# versions wrapped
wrapped_versions = map(dir->VersionNumber(dir),
                       filter(path->isdir(joinpath(@__DIR__, "..", "lib", path)),
                              readdir(joinpath(@__DIR__, "..", "lib"))))

# select wrapper
matching_llvms   = filter(t -> any(v -> vercmp_match(t.version,v), wrapped_versions), llvms)
compatible_llvms = filter(t -> !in(t, matching_llvms) && 
                               any(v -> vercmp_compat(t.version,v), wrapped_versions), llvms)

if isempty(matching_llvms)
    if isempty(compatible_llvms)
        error("could not find a compatible LLVM installation")
    else
        warn("could not find a matching LLVM installation, falling back on probably-compatible ones")
        llvms = compatible_llvms
    end
else
    llvms = [matching_llvms; compatible_llvms]
end


#
# Julia discovery
#

julia_cmd = Base.julia_cmd()
julia = Toolchain(julia_cmd.exec[1], Base.VERSION,
                  joinpath(JULIA_HOME, "..", "share", "julia", "julia-config.jl"))
isfile(julia.path) || error("could not find Julia binary from command $julia_cmd")
isfile(get(julia.config)) || error("could not find julia-config.jl relative to $(JULIA_HOME) (note that in-source builds are only supported on Julia 0.6+)")


#
# Build
#

# at this point, we require `llvm-config` for building
filter!(x->!isnull(x.config), llvms)
isempty(llvms) && error("could not find LLVM installation providing llvm-config (required to build libLLVM_extra)")

# pick the first version and run with it (we should be able to build with all of them)
llvm = first(llvms)
info("Building for LLVM v$(llvm.version) at $(llvm.path) using $(get(llvm.config))")

# build library with extra functions
libllvm_extra = joinpath(@__DIR__, "llvm-extra", "libLLVM_extra-$(verstr(llvm.version))@$(verstr(julia.version)).$libext")
cd(joinpath(@__DIR__, "llvm-extra")) do
    withenv("LLVM_CONFIG" => get(llvm.config),
            "LLVM_LIBRARY" => llvm.path, "LLVM_VERSION" => verstr(llvm.version),
            "JULIA_CONFIG" => get(julia.config),
            "JULIA_BINARY" => julia.path, "JULIA_VERSION" => verstr(julia.version)) do
        # force a rebuild as the LLVM installation might have changed, undetectably
        run(`make clean`)
        run(`make -j$(Sys.CPU_CORES+1)`)
    end
end

# sanity check: open the library
debug("Opening wrapper library")
Libdl.dlopen(libllvm_extra)


#
# Finishing up
#

# gather libLLVM information
llvm_targets = Symbol.(split(readstring(`$(get(llvm.config)) --targets-built`)))
llvm_library_mtime = stat(llvm.path).mtime

# select a wrapper
if llvm.version in wrapped_versions
    wrapper_version = llvm.version
else
    compatible_wrappers = filter(v->vercmp_compat(llvm.version, v), wrapped_versions)
    wrapper_version = last(compatible_wrappers)
    debug("Will be using wrapper v$(verstr(wrapper_version)) for libLLVM v$(llvm.version)")
end
wrapped_libdir = joinpath(@__DIR__, "..", "lib", verstr(wrapper_version))
@assert isdir(wrapped_libdir)

# gather wrapper information
libllvm_wrapper_common = joinpath(wrapped_libdir, "libLLVM_common.jl")
libllvm_wrapper = joinpath(wrapped_libdir, "libLLVM_h.jl")
libllvm_extra_wrapper = joinpath(wrapped_libdir, "..", "libLLVM_extra.jl")

# write ext.jl
open(joinpath(@__DIR__, "ext.jl"), "w") do fh
    write(fh, """
        # LLVM library properties
        const libllvm_version = v"$(llvm.version)"
        const libllvm_path = "$(llvm.path)"
        const libllvm_mtime = $llvm_library_mtime

        # wrapper properties
        const wrapper_version = v"$wrapper_version"

        # installation properties
        const targets = $llvm_targets

        # library loading
        const libllvm = "$libllvm_extra"
        include("$libllvm_wrapper_common")
        include("$libllvm_wrapper")
        include("$libllvm_extra_wrapper")
        """)
end
