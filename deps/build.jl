using Compat
import Compat.String

# Returns locations of a llvm-config binary
function find_config(name)
    paths = String[]

    # new build location, in usr/tools
    let
        config = joinpath(JULIA_HOME, "..", "tools", name)
        ispath(config) && push!(paths, config)
    end

    # old build location, in usr/bin
    let
        config = joinpath(JULIA_HOME, name)
        ispath(config) && push!(paths, config)
    end

    try
        config = readchomp(pipeline(`which $name`, stderr=DevNull))
        ispath(config) && push!(paths, config)
    end

    return paths
end

function verstr(version)
    return "$(version.major).$(version.minor)"
end

# check if the user specifically requested a version
requested_version = Nullable{VersionNumber}()
if haskey(ENV, "LLVM_VERSION")
    requested_version = Nullable(VersionNumber(ENV["LLVM_VERSION"]))
end

# list of valid llvm-config binary names, in descending priority
config_names = ["llvm-config"]
if isnull(requested_version)
    unshift!(config_names, "llvm-config-" * Base.libllvm_version)
else
    unshift!(config_names, "llvm-config-" * verstr(get(requested_version)))
end
if haskey(ENV, "LLVM_CONFIG")
    ispath(ENV["LLVM_CONFIG"]) || error("specified llvm-config does not exist")
    config_names = String[ENV["LLVM_CONFIG"]]
end

# look for all llvm-config candidate names
configs = String[]
for config_name in config_names
    append!(configs, find_config(config_name))
end

# if we requested a specific LLVM version, filter on that
# NOTE/TODO: this discards the patch version, as we cannot discern
#            the case where patch=0 vs not specifying it
if !isnull(requested_version)
    configs = filter(config -> begin
                        version = VersionNumber(readchomp(`$config --version`))
                        return version.major == get(requested_version).major &&
                               version.minor == get(requested_version).minor
                     end, configs)
end

# select a final llvm-config
isempty(configs) && error("could not find any satisfying LLVM installation")
config = first(configs)

version = VersionNumber(readchomp(`$config --version`))
root = readchomp(`$config --obj-root`)
info("Tuning for LLVM $version at $root")

# find the library
# NOTE: we can't use Libdl.find_library because we require RTLD_DEEPBIND
#       in order to avoid different LLVM libraries trampling over one another
#       (we rely on ccall using JL_RTLD_DEFAULT=RTLD_LAZY|RTLD_DEEPBIND)
libdir = readchomp(`$config --libdir`)
libname = "libLLVM-$(verstr(version)).so"
libllvm = joinpath(libdir, libname)
if !ispath(libllvm)
    libllvm = libname
end

# wrap the library, if necessary
wrapped_libdir = joinpath(dirname(@__FILE__), "..", "lib", verstr(version))
if !isdir(wrapped_libdir)
    include("wrap.jl")
    wrap(config, wrapped_libdir)
end

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
