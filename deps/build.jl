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

function configname(version::VersionNumber)
    return "llvm-config-" * verstr(version)
end

# This script looks for LLVM installations in a variety of places, and choses one (adhering
# to LLVM_VERSION, if specified) in the following descending order of priority:
# - shipped LLVM libraries (only versioned)
# - system-wide LLVM libraries (only versioned)
# - shipped llvm-config binaries (first versioned, then unversioned)
# - system-wide llvm-config binaries (first versioned, then unversioned)
#
# Unversioned LLVM libraries are not considered, as the API doesn't seem to provide a way to
# detect the LLVM version, and thus we can't select the appropriate wrapper.

# versions to consider
if haskey(ENV, "LLVM_VERSION")
    debug("Overriding LLVM version requirement to v", ENV["LLVM_VERSION"])
    ismatch(r"^\d.\d$", ENV["LLVM_VERSION"]) || error("invalid version requested (should be MAJOR.MINOR)")
    versions = [VersionNumber(ENV["LLVM_VERSION"])]
else
    versions = map(lib -> VersionNumber(lib),
                   readdir(joinpath(dirname(@__FILE__), "..", "lib")))
    debug("Acceptable LLVM versions: ", join(versions, ", "))
end

libraries = Vector{Tuple{String, VersionNumber}}()

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
for version in versions, name in libname(version)
    debug("Searching for library $name")
    lib = Libdl.dlopen_e(name)
    if lib != C_NULL
        path = Libdl.dlpath(lib)
        debug("- found v$version at $path")
        push!(libraries, tuple(path, version))
    end
end

# check llvm-for config binaries in known locations
configversions = [map(v->Nullable(v), versions)..., Nullable{VersionNumber}()]
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
            debug("- reports LLVM v$config_version")
        else
            config_version = get(version)
        end

        # check for libraries
        libdir = readchomp(`$config --libdir`)
        debug("- contains libraries in $libdir")
        for name in [libname(config_version); libname()]
            lib = joinpath(libdir, name)
            if ispath(lib)
                debug("- found v$config_version at $lib")
                push!(libraries, tuple(lib, config_version))
            end
        end
    end
end

# select a compatible library
vercmp = (a,b) -> a.major==b.major && a.minor==b.minor
compat_libraries = filter(t -> any(v -> vercmp(t[2],v), versions), libraries)
isempty(compat_libraries) && error("could not find a compatible LLVM installation")
(libllvm, version) = first(compat_libraries)
info("Tuning for libLLVM v$version at $(realpath(libllvm))")

# check if the library is wrapped
wrapped_libdir = joinpath(dirname(@__FILE__), "..", "lib", verstr(version))
isdir(wrapped_libdir) || error("LLVM v$version is not supported, please file an issue")

# write ext.jl
wrapper_common = joinpath(wrapped_libdir, "libLLVM_common.jl")
wrapper_header = joinpath(wrapped_libdir, "libLLVM_h.jl")
open(joinpath(dirname(@__FILE__), "ext.jl"), "w") do fh
    write(fh, """
        const libllvm = "$libllvm"
        const libllvm_version = v"$version"
        include("$wrapper_common")
        include("$wrapper_header")""")
end
