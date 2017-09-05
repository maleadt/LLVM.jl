# entry point for the buildbot: builds the extras library for deployment purposes

using BinDeps2
using SHA

include("compile.jl")

# Our build products will go into ./products
out_path = joinpath(pwd(), "products")
rm(out_path; force=true, recursive=true)
mkpath(out_path)

# Build for all supported platforms
products = Dict()
for platform in supported_platforms()
    target = platform_triplet(platform)

    # We build in a platform-specific directory
    build_path = joinpath(pwd(), "build", target)
    try mkpath(build_path) end

    cd(build_path) do
        # For each build, create a temporary prefix we'll install into, then package up
        temp_prefix() do prefix
            # Unpack the source into our build directory
            unpack(src_path, build_path; verbose=true)

            # We expect these outputs from our build steps
            libllvm_extra = LibraryResult(joinpath(libdir(prefix), "libLLVM_extra"))

            # We build using the typical autoconf incantation
            steps = [
                # We pass `--host=$(target)` to tell configure we want to cross-compile
                # We pass `--prefix=/` because BinDeps2 has already set the `$DESTDIR`
                # environment variable, so we don't need to tell configure where to install
                `./nettle-$(src_vers)/configure --host=$(target) --prefix=/`,
                `make -j$(min(Sys.CPU_CORES + 1,8))`,
                `make install`
            ]

            dep = Dependency(src_name, [libnettle], steps, platform, prefix)
            build(dep; verbose=true)

            # Once we're built up, go ahead and package this prefix out
            tarball_path = package(prefix, joinpath(out_path, src_name); platform=platform, verbose=true)
            tarball_hash = open(tarball_path, "r") do f
                return bytes2hex(sha256(f))
            end
            products[target] = (basename(tarball_path), tarball_hash)
        end
    end

    # Finally, destroy the build_path
    rm(build_path; recursive=true)
end

# In the end, dump an informative message telling the user how to download/install these
info("Hash/filename pairings:")
for target in keys(products)
    filename, hash = products[target]
    println("    :$(platform_key(target)) => (\"\$bin_prefix/$(filename)\", \"$(hash)\"),")
end
