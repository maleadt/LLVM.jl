# This script discovers available LLVM toolchains, selects suitable ones based on API
# compatibility with available wrappers, and builds a library with additional API functions.

# Several environment variables can change the behavior of this script:
#
# from logging.jl: define DEBUG or TRACE to enable verbose output
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

using Compat

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

const ext = joinpath(pwd(), "ext.jl")
try
    #
    # Auxiliary
    #

    include("common.jl")
    include(joinpath(pwd(), "..", "src", "util", "logging.jl"))

    # possible names for libLLVM given a LLVM version number
    function llvm_libnames(version::VersionNumber)
        if is_linux()
            # Linux DSO's aren't versioned, so only use versioned filenames
            return ["libLLVM-$(version.major).$(version.minor).$(version.patch).so",
                    "libLLVM-$(version.major).$(version.minor).$(version.patch)svn.so",
                    "libLLVM-$(version.major).$(version.minor).so",
                    "libLLVM-$(version.major).$(version.minor)svn.so"]
        elseif is_apple()
            # macOS are versioned
            return ["libLLVM.dylib"]
        elseif is_windows()
            # windows are versioned
            return ["LLVM.dll"]
        else
            error("Unknown OS")
        end
    end

    # name for libLLVM_extra
    llvmextra_libname = "libLLVM_extra.$(Libdl.dlext)"

    verbose_run(cmd) = (println(cmd); run(cmd))

    const base_llvm_version = VersionNumber(Base.libllvm_version)


    #
    # LLVM discovery
    #

    libllvms = Vector{Toolchain}()

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

    # check for bundled LLVM libraries
    # NOTE: as we only build the extras library from source, these libraries will never be used,
    #       but leave this code here as it may be used if we figure out how to provide bindeps
    libdirs = if is_windows()
        [JULIA_HOME]
    else
        [joinpath(JULIA_HOME, "..", "lib", "julia")]
    end
    for libdir in libdirs
        libraries = find_libllvm(libdir, [base_llvm_version])

        for (library, version) in libraries
            push!(libllvms, Toolchain(library, version))
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
                push!(libllvms, Toolchain(library, version, config))
            end
        end
    end

    # prune
    libllvms = unique(x -> realpath(x.path), libllvms)

    info("Found $(length(libllvms)) unique LLVM installations")


    #
    # LLVM selection
    #

    # First consider installations with a major and minor version matching wrapped headers
    # (see the `lib` folder). If no such installation have been found, consider
    # probably-compatible versions (ie. for which we have an older set of wrapped headers).
    #
    # If the user requested a specific version, only ever consider that version.

    vercmp_match  = (a,b) -> a.major==b.major &&  a.minor==b.minor
    vercmp_compat = (a,b) -> a.major>b.major  || (a.major==b.major && a.minor>=b.minor)

    if !isnull(override_llvm_version)
        warn("Forcing LLVM version at $(get(override_llvm_version))")
        libllvms = filter(t->vercmp_match(t.version,get(override_llvm_version)), libllvms)
    elseif !use_system_llvm
        # NOTE: only match versions here, as `!use_system_llvm` implies we've only searched
        #       bundled directories
        warn("Only considering bundled LLVM v$base_llvm_version (define USE_SYSTEM_LLVM=1 to override)")
        libllvms = filter(t->vercmp_match(t.version,base_llvm_version), libllvms)
    end

    # versions wrapped
    wrapped_versions = map(dir->VersionNumber(dir),
                           filter(path->isdir(joinpath(pwd(), "..", "lib", path)),
                                  readdir(joinpath(pwd(), "..", "lib"))))

    # select wrapper
    matching_llvms   = filter(t -> any(v -> vercmp_match(t.version,v), wrapped_versions), libllvms)
    compatible_llvms = filter(t -> !in(t, matching_llvms) &&
                                   any(v -> vercmp_compat(t.version,v), wrapped_versions), libllvms)

    libllvms = [matching_llvms; compatible_llvms]

    # we will require `llvm-config` for building
    filter!(x->!isnull(x.config), libllvms)
    isempty(libllvms) && error("could not find LLVM installation providing llvm-config")

    # pick the first version and run with it (we should be able to build with all of them)
    libllvm = first(libllvms)


    #
    # Julia discovery
    #

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


    #
    # Wrapper selection
    #

    # select a wrapper
    libllvm in matching_llvms || warn("Selected LLVM version v$(libllvm.version) is unsupported")
    if libllvm.version in wrapped_versions
        wrapper_version = libllvm.version
    else
        compatible_wrappers = filter(v->vercmp_compat(libllvm.version, v), wrapped_versions)
        wrapper_version = last(compatible_wrappers)
        debug("Will be using wrapper v$(verstr(wrapper_version)) for libLLVM v$(libllvm.version)")
    end
    llvmjl_wrapper = verstr(wrapper_version)


    #
    # Detect changes
    #

    # gather libLLVM information
    libllvm_targets = Symbol.(split(readstring(`$(get(libllvm.config)) --targets-built`)))

    # gather LLVM.jl information
    llvmjl_hash =
        try
            cd(joinpath(pwd(), "..")) do
                chomp(readstring(`git rev-parse HEAD`))
            end
        catch e
            warning("could not find package git hash")
            # NOTE: we don't explicitly check for llvmjl_hash==nothing, because
            #       it will imply that llvmjl_dirty=true, making us rebuild anyway
            nothing
        end
    llvmjl_dirty =
        try
            cd(joinpath(pwd(), "..")) do
                length(chomp(readstring(`git diff --shortstat`))) > 0
            end
        catch e
            warning("could not find package git status")
            true
        end

    # check if anything has changed (to prevent unnecessary recompilation)
    if llvmjl_dirty
        debug("Package is dirty, rebuilding")
    elseif isfile(ext)
        debug("Checking validity of existing ext.jl...")
        @eval module Previous; include($ext); end
        if  isdefined(Previous, :libllvm_version) && Previous.libllvm_version == libllvm.version &&
            isdefined(Previous, :libllvm_path)    && Previous.libllvm_path == libllvm.path &&
            isdefined(Previous, :libllvm_mtime)   && Previous.libllvm_mtime == libllvm.mtime &&
            isdefined(Previous, :libllvm_targets) && Previous.libllvm_targets == libllvm_targets &&
            isdefined(Previous, :llvmjl_wrapper)  && Previous.llvmjl_wrapper == llvmjl_wrapper &&
            isdefined(Previous, :llvmjl_hash)     && Previous.llvmjl_hash == llvmjl_hash
            info("LLVM.jl has already been built for this toolchain, no need to rebuild")
            return
        end
    end


    #
    # Build extras library
    #

    info("Performing source build of LLVM extras library")
    debug("Building for LLVM v$(libllvm.version) at $(libllvm.path) using $(get(libllvm.config))")

    libllvm_extra = joinpath(pwd(), "llvm-extra", llvmextra_libname)

    include("make.jl")
    build(libllvm, julia, joinpath(pwd(), "llvm-extra"))

    # sanity check: in the case of a bundled LLVM the library should be loaded by Julia already,
    #               while a system-provided LLVM shouldn't
    libllvm_exclusive = Libdl.dlopen_e(libllvm.path, Libdl.RTLD_NOLOAD) == C_NULL
    if use_system_llvm != libllvm_exclusive
        @assert(Libdl.dlopen_e(libllvm.path, Libdl.RTLD_NOLOAD) == C_NULL,
                "exclusive access mode does not match requested type of LLVM library (run with TRACE=1 and file an issue)")
    end

    # sanity check: open the library
    debug("Opening $libllvm_extra")
    Libdl.dlopen(libllvm_extra, Libdl.RTLD_LOCAL | Libdl.RTLD_DEEPBIND | Libdl.RTLD_NOW)


    #
    # Finishing up
    #

    # write ext.jl
    open(ext, "w") do fh
        write(fh, """
            # LLVM library properties
            const libllvm_version = v"$(libllvm.version)"
            const libllvm_path = "$(escape_string(libllvm.path))"
            const libllvm_mtime = $(libllvm.mtime)
            const libllvm_exclusive = $libllvm_exclusive
            const libllvm_targets = $libllvm_targets

            # LLVM extras library properties
            const libllvm_extra_path = "$(escape_string(libllvm_extra))"

            # package properties
            const llvmjl_wrapper = "$llvmjl_wrapper"
            const llvmjl_hash = "$llvmjl_hash"
            """)
    end
catch ex
    # if anything goes wrong, wipe the existing ext.jl to prevent the package from loading
    rm(ext; force=true)
    rethrow(ex)
end
