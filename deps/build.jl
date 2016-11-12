# This script looks for LLVM installations and selects one based on the compatibility with
# available wrappers. This is somewhat convoluted, as we can find LLVM in a variety of
# places using different mechanisms, while version matching needs to consider API
# compatibility. In addition, we need to build an extras library with additional functions,
# which we also try to download a precompiled version of.
#
# Several environment variables can change the behavior of this script:

# from logging.jl: define DEBUG to enable debug output

# set FORCE_LLVM_VERSION to force an LLVM version to use
# (still needs to be discoverable and compatible)
const force_llvm_version = Nullable{VersionNumber}(get(ENV, "FORCE_LLVM_VERSION", nothing))

# set FORCE_RELEASE to force a certain release tag to be used
# (for downloading binary assets from GitHub)
const force_release = Nullable{String}(get(ENV, "FORCE_RELEASE", nothing))

# define FORCE_BUILD to force a source build of the LLVM extras library
const force_build = haskey(ENV, "FORCE_BUILD")

# define USE_SYSTEM_LLVM to allow using non-bundled versions of LLVM
const use_system_llvm = haskey(ENV, "USE_SYSTEM_LLVM")



#
# Auxiliary
#

using Compat
import Compat.String

using JSON

using ZipFile

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

# name of the binary asset package
function bindeps_filename(llvm::Toolchain, julia::Toolchain)
    return "bindeps_llvm$(verstr(llvm.version))_julia$(verstr(julia.version)).zip"
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

if !isnull(force_llvm_version)
    warn("Forcing LLVM version at $(get(force_llvm_version))")
    llvms = filter(t->vercmp_match(t.version,get(force_llvm_version)), llvms)
elseif !use_system_llvm
    warn("Only considering bundled LLVM v$base_llvm_version")
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
# Build extra library
#

# after this step, we'll have decided on a LLVM toolchain to use,
# and have a built and linked extras library
llvm = nothing
llvmextra = joinpath(@__DIR__, "llvm-extra", llvmextra_libname)

function link(src::String, llvm)
    debug("Finalizing $src")
    srcdir, srcfile = splitdir(src)

    debug("- linking against $(llvm.path)")
    if is_apple()
        # macOS dylibs are versioned already
        ld_libname = "LLVM"
    else
        # specify the versioned library name to make sure we pick up the correct one
        ld_libname = ":$(basename(llvm.path))"
    end
    ld_dir = dirname(llvm.path)

    dst = joinpath(srcdir, "linked-" * srcfile)
    verbose_run(`ld -o $dst -shared $src -rpath $ld_dir -L $ld_dir -l$ld_libname`)

    debug("- opening the library")
    Libdl.dlopen(dst)

    return dst
end

function create_bindeps(llvm::Toolchain, julia::Toolchain)
    name = bindeps_filename(llvm, julia)
    w = ZipFile.Writer(joinpath(@__DIR__, name))
    f = ZipFile.addfile(w, llvmextra_libname)
    write(f, read(llvmextra))
    close(w)
end

function extract_bindeps(name::String)
    r = ZipFile.Reader(name)
    for f in r.files
        if f.name == llvmextra_libname
            write(llvmextra, read(f))
        else
            error("Unknown file in bindeps archive: $(f.name)")
        end
    end
    close(r)
end


## download binary release

info("Looking for precompiled version of LLVM extras library")

# find out the current release tag
function pkg_tag()
    if !isnull(force_release)
        tag = get(force_release)
        warn("Forcing release tag to $tag")
    else
        dir = joinpath(@__DIR__, "..")
        commit = readchomp(`git -C $dir rev-parse HEAD`)
        tag = readchomp(`git -C $dir name-rev --tags --name-only $commit`)
        debug("Detected release tag $tag (at commit $commit)")
        tag == "undefined" && error("could not find current tag")
    end

    return tag
end

# download the list of GitHub releases for this package
pkg_releases() =
    download("https://api.github.com/repos/maleadt/LLVM.jl/releases") |> readstring |> JSON.parse

# download the list of assets linked to a GitHub release (identified by its tag)
function pkg_assets(tag)
    releases = pkg_releases()
    filter!(r->r["tag_name"] == tag, releases)
    length(releases) == 0 && throw("could not find release $tag")
    @assert length(releases) == 1

    assets = releases[1]["assets"]
    isempty(assets) && throw("release $tag does not have any assets")

    return Dict(map(a->a["name"] => a["browser_download_url"], assets))
end

# get the link for a compatible bindeps package
function get_bindeps()
    assets = pkg_assets(pkg_tag())

    usable_assets = Vector{Tuple{Toolchain,String}}()
    for (name,url) in assets, llvm in llvms
        if name == bindeps_filename(llvm,julia)
            push!(usable_assets, tuple(llvm,url))
        end
    end

    isempty(usable_assets) && error("could not find matching bindeps package")
    @assert length(usable_assets) == 1
    return usable_assets[1]
end

if force_build
    warn("Forcing source build of LLVM extras library")
else
    try
        (llvm, url) = get_bindeps()
        debug("Downloading $url")

        archive = download(url)
        extract_bindeps(archive)
        llvmextra = link(llvmextra, llvm)
    catch e
        msg = sprint(io->showerror(io, e))
        warn("could not use precompiled version of LLVM extras library: $msg")
        llvm = nothing
    end
end


## source build

if !isfile(llvmextra) || llvm == nothing
    info("Performing source build of LLVM extras library")

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

    create_bindeps(llvm, julia)
    llvmextra = link(llvmextra, llvm)
end

@assert llvm != nothing
@assert isfile(llvmextra)



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
