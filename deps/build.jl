# This script looks for LLVM installations and selects one based on the compatibility with
# available wrappers.
#
# This is somewhat convoluted, as we can find libLLVM in a variety of places using different
# mechanisms, while version matching needs to consider ABI compatibility.
#
# Environment variables influencing this process:
#   DEBUG=1                     print debug information
#   LLVM_VERSION=$MAJOR.$MINOR  only consider using a specific LLVM version
#                               (which still needs to be compatible)

using Compat
import Compat.String

const DEBUG = haskey(ENV, "DEBUG")

include("common.jl")
include(joinpath(dirname(@__FILE__), "..", "src", "logging.jl"))

libname() = return ["libLLVM.so"]

function libname(version::VersionNumber)
    return ["libLLVM-$(version.major).$(version.minor).so",
            "libLLVM-$(version.major).$(version.minor).$(version.patch).so"]
end


#
# Discovery
#

# Discover LLVM installations and their contained libraries, in the following order of
# preference:
# - shipped LLVM libraries (only versioned)
# - system-wide LLVM libraries (only versioned)
# - shipped llvm-config binaries (first versioned, then unversioned)
# - system-wide llvm-config binaries (first versioned, then unversioned)
#
# Unversioned LLVM libraries are not considered, as the API doesn't seem to provide a way to
# detect the LLVM version (which we need to select an wrapper, or switch behavior).

libraries = Vector{Tuple{String, VersionNumber}}()

# LLVM versions to look for.
#
# Note that this list can be incomplete, as we'll still look for unversioned llvm-config
# binaries which may yield different versions.
acceptable_versions = [VersionNumber(Base.libllvm_version),
                       v"4.0",
                       v"3.9.0",
                       v"3.8.1", v"3.8.0"]

if haskey(ENV, "LLVM_VERSION")
    ismatch(r"^\d.\d$", ENV["LLVM_VERSION"]) || error("invalid version requested (should be MAJOR.MINOR)")
    requested_version = Nullable(VersionNumber(ENV["LLVM_VERSION"]))

    # NOTE: even though we'll only care about the requested version, still look for others
    #       as it may be useful for debugging purposes
    push!(acceptable_versions, get(requested_version))
else
    requested_version = Nullable{VersionNumber}()
end

debug("Acceptable LLVM versions: ", join(acceptable_versions, ", "))

# NOTE: we do manual library detection (ie. no find_librari, dlopen) for two reasons:
# - ability to detect libraries of unknown versions (by scanning libdirs and regex matching)
# - find_library doesn't work because it doesn't RTLD_DEEPBIND (I know, we could dlopen_e)

# check for versioned libraries in known locations
libdirs = [( isdefined(Base, :LIBDIR) ? joinpath(JULIA_HOME, Base.LIBDIR)
                                      : joinpath(JULIA_HOME, "..", "lib") ),
           get(ENV, "LD_LIBRARY_PATH", ""), "/usr", "/usr/lib"]
for dir in unique(libdirs)
    isdir(dir) || continue
    debug("Searching for libraries in $dir")

    # discover libraries directly
    for file in readdir(dir), re in [r"libLLVM-(\d).(\d).(\d).so", r"libLLVM-(\d).(\d).so"]
        m = match(re, file)
        if m != nothing
            path = joinpath(dir, file)
            version = VersionNumber(map(s->parse(Int,s), m.captures)...)
            debug("- found v$version at $path")
            push!(libraries, tuple(path, version))
        end
    end
end

# guess for versioned libraries (as the user might have configured ld.so differently)
for version in acceptable_versions, name in libname(version)
    debug("Searching for library $name")
    lib = Libdl.dlopen_e(name)
    if lib != C_NULL
        path = Libdl.dlpath(lib)
        debug("- found v$version at $path")
        push!(libraries, tuple(path, version))
    end
end

# check llvm-for config binaries in known locations
configdirs = [JULIA_HOME, joinpath(JULIA_HOME, "..", "tools"), split(ENV["PATH"], ':')...]
for dir in unique(configdirs)
    isdir(dir) || continue
    debug("Searching for config binaries in $dir")

    # first discover llvm-config binaries
    configs = Vector{Tuple{String, Nullable{VersionNumber}}}()
    for file in readdir(dir), re in [r"llvm-config-(\d).(\d).(\d)", r"llvm-config-(\d).(\d)"]
        m = match(re, file)
        if m != nothing
            path = joinpath(dir, file)
            version = VersionNumber(map(s->parse(Int,s), m.captures)...)
            debug("- found llvm-config at $path")
            push!(configs, tuple(path, Nullable(version)))
        end
    end
    config = joinpath(dir, "llvm-config")
    ispath(config) && push!(configs, tuple(config, Nullable{VersionNumber}()))

    # then discover libraries
    for (config, version) in configs
        debug("Searching for libraries using $config")
        # deal with unversioned llvm-config binaries
        if isnull(version)
            config_version = VersionNumber(readchomp(`$config --version`))
            debug("... reports LLVM v$config_version")
        else
            config_version = get(version)
        end

        # check for libraries
        libdir = readchomp(`$config --libdir`)
        debug("... contains libraries in $libdir")
        for name in [libname(config_version); libname()]
            lib = joinpath(libdir, name)
            if ispath(lib)
                debug("- found v$config_version at $lib")
                push!(libraries, tuple(lib, config_version))
            end
        end
    end
end

info("Found $(length(libraries)) LLVM libraries, providing $(length(unique(map(t->t[2],libraries)))) different versions")


#
# Selection
#

# First consider installations with a major and minor version matching wrapped headers (see
# the `lib` folder) are considered first. If no such libraries have been found, consider
# probably-compatible versions (ie. for which we have an older set of wrapped headers).
#
# If the user requested a specific version, only ever consider that version.

vercmp_match = (a,b) -> a.major==b.major && a.minor==b.minor
vercmp_compat = (a,b) -> a.major>b.major || (a.major==b.major && a.minor>=b.minor)

if !isnull(requested_version)
    info("Overriding selection to match v$(get(requested_version))")
    libraries = filter(t->vercmp_match(t[2],get(requested_version)), libraries)
end

# versions wrapped
wrapped_versions = map(lib -> VersionNumber(lib),
                       readdir(joinpath(dirname(@__FILE__), "..", "lib")))

# select matching libraries
matching_libraries = filter(t -> any(v -> vercmp_match(t[2],v), wrapped_versions), libraries)

# select probably compatible libraries
compatible_libraries = filter(t -> any(v -> vercmp_compat(t[2],v), wrapped_versions), libraries)

# select a compatible library
if !isempty(matching_libraries)
    (libllvm, libllvm_version) = first(matching_libraries)
elseif !isempty(compatible_libraries)
    (libllvm, libllvm_version) = first(compatible_libraries)
    warn("could not find a matching LLVM installation, but did find a v$libllvm_version installation which is probably compatible...")
else
    error("could not find a compatible LLVM installation")
end
info("Selected LLVM v$libllvm_version at $(realpath(libllvm))")

# check if the library is wrapped
wrapped_libdir = joinpath(dirname(@__FILE__), "..", "lib", verstr(libllvm_version))
if isdir(wrapped_libdir)
    wrapper_version = libllvm_version
else
    # the selected version is not supported, check for compatible (ie. older) wrapped
    # headers which are probably compatible (there's no real ABI guarantee though)...
    debug("No wrapped headers for v$libllvm_version found")
    compatible_wrappers = filter(v->vercmp_compat(libllvm_version, v), wrapped_versions)
    if !isempty(compatible_wrappers)
        wrapper_version = last(compatible_wrappers)
        warn("LLVM v$libllvm_version is not supported, falling back to support for v$wrapper_version (file an issue if there's incompatibilities)")
        wrapped_libdir = joinpath(dirname(@__FILE__), "..", "lib", verstr(wrapper_version))
    end
end
isdir(wrapped_libdir) || error("LLVM v$libllvm_version is not supported")


#
# Finishing up
#

# write ext.jl
wrapper_common = joinpath(wrapped_libdir, "libLLVM_common.jl")
wrapper_header = joinpath(wrapped_libdir, "libLLVM_h.jl")
open(joinpath(dirname(@__FILE__), "ext.jl"), "w") do fh
    write(fh, """
        const libllvm = "$libllvm"
        const libllvm_version = v"$libllvm_version"
        const wrapper_version = v"$wrapper_version"
        include("$wrapper_common")
        include("$wrapper_header")""")
end
