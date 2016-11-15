# This script discovers available LLVM toolchains, selects suitable ones based on API
# compatibility with available wrappers, and builds a library with additional API functions.
#
# Several environment variables can change the behavior of this script:

# from logging.jl: define DEBUG to enable debug output

# set LLVM_VER to force an LLVM version (still needs to be discoverable and compatible)
const override_llvm_version = Nullable{VersionNumber}(get(ENV, "LLVM_VER", nothing))

# define USE_SYSTEM_LLVM to allow using non-bundled versions of LLVM
const use_system_llvm = haskey(ENV, "USE_SYSTEM_LLVM")
if use_system_llvm && is_apple()
    # on macOS, some lookups from the system libLLVM resolve in the libLLVM loaded by Julia
    # (shouldn't RTLD_DEEPBIND prevent this?), which obviously messes up things:
    #
    # frame 0: libsystem_malloc.dylib  malloc_error_break
    # frame 1: libsystem_malloc.dylib  free
    # frame 2: libLLVM-3.7.dylib       llvm::DenseMapBase<...>*)
    # frame 3: libLLVM-3.7.dylib       unsigned int llvm::DFSPass<...>::NodeType*, unsigned int)
    # frame 4: libLLVM-3.7.dylib       void llvm::Calculate<...>&, llvm::Function&)
    # frame 5: libLLVM.dylib           (anonymous namespace)::Verifier::verify(llvm::Function const&)
    # frame 6: libLLVM.dylib           llvm::verifyModule(llvm::Module const&, llvm::raw_ostream*, bool*)
    # frame 7: libLLVM.dylib           LLVMVerifyModule
    error("USE_SYSTEM_LLVM is not supported on macOS")
end


#
# Auxiliary
#

using Compat
import Compat.String

include("common.jl")
include(joinpath(@__DIR__, "..", "src", "logging.jl"))

const libext = is_apple() ? "dylib" : "so"

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

# name for libLLVM_extra
llvmextra_libname = "libLLVM_extra.$libext"

immutable Toolchain
    path::String
    version::VersionNumber
    config::Nullable{String}
end

verbose_run(cmd) = (println(cmd); run(cmd))

const base_llvm_version = VersionNumber(Base.libllvm_version)


#
# LLVM discovery
#

llvms = Vector{Toolchain}()

# returns vector of Tuple{path::String, VersionNumber}
function find_libllvm(dir::String, versions::Vector{VersionNumber})
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

# check for bundled LLVM libraries
# NOTE: as we only build the extras library from source, these libraries will never be used,
#       but leave this code here as it may be used if we figure out how to provide bindeps
libdirs = [joinpath(JULIA_HOME, "..", "lib", "julia")]
for libdir in libdirs
    libraries = find_libllvm(libdir, [base_llvm_version])

    for (library, version) in libraries
        push!(llvms, Toolchain(library, version, Nullable{String}()))
    end
end

# check for llvm-config binaries in known locations
configdirs = [JULIA_HOME, joinpath(JULIA_HOME, "..", "tools")]
if use_system_llvm
    append!(configdirs, [split(ENV["PATH"], ':')...])
end
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

if !isnull(override_llvm_version)
    warn("Forcing LLVM version at $(get(override_llvm_version))")
    llvms = filter(t->vercmp_match(t.version,get(override_llvm_version)), llvms)
elseif !use_system_llvm
    # NOTE: only match versions here, as `!use_system_llvm` implies we've only searched
    #       bundled directories
    warn("Only considering bundled LLVM v$base_llvm_version (define USE_SYSTEM_LLVM=1 to override)")
    llvms = filter(t->vercmp_match(t.version,base_llvm_version), llvms)
end

# versions wrapped
wrapped_versions = map(dir->VersionNumber(dir),
                       filter(path->isdir(joinpath(@__DIR__, "..", "lib", path)),
                              readdir(joinpath(@__DIR__, "..", "lib"))))

# select wrapper
matching_llvms   = filter(t -> any(v -> vercmp_match(t.version,v), wrapped_versions), llvms)
compatible_llvms = filter(t -> !in(t, matching_llvms) && 
                               any(v -> vercmp_compat(t.version,v), wrapped_versions), llvms)

llvms = [matching_llvms; compatible_llvms]


#
# Julia discovery
#

julia_cmd = Base.julia_cmd()
julia = Toolchain(julia_cmd.exec[1], Base.VERSION,
                  joinpath(JULIA_HOME, "..", "share", "julia", "julia-config.jl"))
isfile(julia.path) || error("could not find Julia binary from command $julia_cmd")
isfile(get(julia.config)) ||
    error("could not find julia-config.jl relative to $(JULIA_HOME) (note that in-source builds are only supported on Julia 0.6+)")


#
# Build extras library
#

info("Performing source build of LLVM extras library")

llvmextra = joinpath(@__DIR__, "llvm-extra", llvmextra_libname)

# at this point, we require `llvm-config` for building
filter!(x->!isnull(x.config), llvms)
isempty(llvms) && error("could not find LLVM installation providing llvm-config")

# pick the first version and run with it (we should be able to build with all of them)
llvm = first(llvms)
debug("Building for LLVM v$(llvm.version) at $(llvm.path) using $(get(llvm.config))")

# build library with extra functions
cd(joinpath(@__DIR__, "llvm-extra")) do
    withenv("LLVM_CONFIG" => get(llvm.config), "LLVM_LIBRARY" => llvm.path,
            "JULIA_CONFIG" => get(julia.config), "JULIA_BINARY" => julia.path,) do
        # force a rebuild as the LLVM installation might have changed, undetectably
        verbose_run(`make clean`)
        verbose_run(`make -j$(Sys.CPU_CORES+1)`)
    end
end

# sanity check: see if LLVM is opened already
if !use_system_llvm
    @assert(Libdl.dlopen_e(llvm.path, Libdl.RTLD_NOLOAD) != C_NULL,
            "supposedly-bundled LLVM should have been loaded already (run with TRACE=1 and file an issue)")
end

# sanity check: open the library
debug("Opening $llvmextra")
Libdl.dlopen(llvmextra, Libdl.RTLD_LOCAL | Libdl.RTLD_DEEPBIND | Libdl.RTLD_NOW)


#
# Finishing up
#

llvm in matching_llvms || warn("Selected LLVM version v$(llvm.version) is unsupported")

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
llvmextra_wrapper = joinpath(wrapped_libdir, "..", "libLLVM_extra.jl")

# write ext.jl
open(joinpath(@__DIR__, "ext.jl"), "w") do fh
    write(fh, """
        # LLVM library properties
        const libllvm_version = v"$(llvm.version)"
        const libllvm_path = "$(llvm.path)"
        const libllvm_mtime = $llvm_library_mtime

        # LLVM extras library properties
        const libllvm_extra_path = "$llvmextra"

        # wrapper properties
        const wrapper_version = v"$wrapper_version"

        # installation properties
        const targets = $llvm_targets

        # library loading
        include("$libllvm_wrapper_common")
        include("$libllvm_wrapper")
        include("$llvmextra_wrapper")
        """)
end
