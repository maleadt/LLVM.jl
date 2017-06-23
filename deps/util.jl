# common utility functions

using Compat

include(joinpath(@__DIR__, "..", "src", "util", "logging.jl"))

const base_llvm_version = VersionNumber(Base.libllvm_version)

function verstr(version::VersionNumber)
    return "$(version.major).$(version.minor)"
end


#
# Environment variables
#

# from logging.jl: define DEBUG or TRACE to enable verbose output
# set LLVM_VER to force an LLVM version (still needs to be discoverable and compatible)
const override_llvm_version = Nullable{VersionNumber}(get(ENV, "LLVM_VER", nothing))

# define USE_SYSTEM_LLVM to use non-bundled versions of LLVM instead
const use_system_llvm = haskey(ENV, "USE_SYSTEM_LLVM")


#
# Toolchain type
#

immutable Toolchain
    path::String
    version::VersionNumber
    config::Nullable{String}
    mtime::Float64

    Toolchain(path, version) =
        new(path, version, Nullable{String}(), stat(path).mtime)
    Toolchain(path, version, config) =
        new(path, version, Nullable{String}(config), stat(path).mtime)
end

function shortpath(path)
    paths = [path, abspath(path), relpath(path)]
    first(sort(paths, by=length))
end

function Base.show(io::IO, toolchain::Toolchain)
    print(io, toolchain.version, " at ", shortpath(toolchain.path))
end
