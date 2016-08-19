using Compat
import Compat.String

# Returns path to `llvm-config`, or throws
function find_llvm()
    if haskey(ENV, "TRAVIS")
        return readchomp(`which llvm-config-3.4`)
    end

    # old build location, in usr/bin
    config = joinpath(JULIA_HOME, "llvm-config")
    isfile(config) && return config

    # new build location, in usr/tools
    config = joinpath(JULIA_HOME, "..", "tools", "llvm-config")
    isfile(config) && return config

    try
        config = readchomp(`which llvm-config`)
    end
    isfile(config) && return config

    error("No useable llvm-config found")
end

config = get(ENV, "LLVM_CONFIG", find_llvm())

version = VersionNumber(readchomp(`$config --version`))
root = readchomp(`$config --obj-root`)
info("Building for LLVM $version at $root")
destdir = joinpath(dirname(@__FILE__), "..", "lib", string(version))
libdir = readchomp(`$config --libdir`)
libllvm = joinpath(libdir, "libLLVM.so")
ispath(libllvm) || error("Could not find libllvm at $libdir, please verify your LLVM installation")

# Check if the library is wrapped already
if !isdir(destdir)
    include("wrap.jl")
    wrap(config, destdir)
end

# Write ext.jl
wrapper_common = joinpath(destdir, "libLLVM_common.jl")
wrapper_header = joinpath(destdir, "libLLVM_h.jl")
open(joinpath(dirname(@__FILE__), "ext.jl"), "w") do fh
    write(fh, """
        const libllvm = "$libllvm"
        include("$wrapper_common")
        include("$wrapper_header")""")
end