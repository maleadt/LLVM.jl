# entry point for the buildbot: builds the extras library for deployment purposes

using BinDeps2
using SHA

mkpath(joinpath(pwd(), "downloads"))

# Define what sources we're dealing with
src_path = joinpath(pwd(), "downloads")
julia_repo = "https://github.com/JuliaLang/julia"
julia_commit = Base.GIT_VERSION_INFO.commit
llvm_src = joinpath(@__DIR__, "llvm-extra")

# First, download the Julia source, store it in ./downloads/julia/
info("Fetching Julia")
julia_path = joinpath(src_path, "julia")
# julia_repo = LibGit2.clone(julia_repo, julia_path)
# LibGit2.checkout!(julia_repo, julia_commit)

# Then, copy the libLLVM-extra sources to ./downloads/llvm-extra/
info("Fetching libLLVM-extra")
llvm_path = joinpath(src_path, "llvm-extra")
# cp(llvm_src, llvm_path)

# Our build products will go into ./products
out_path = joinpath(pwd(), "products")
rm(out_path; force=true, recursive=true)
mkpath(out_path)

# Build for all supported platforms
products = Dict()
for platform in supported_platforms()
    target = platform_triplet(platform)
    info("Building for $target")

    # We build in a platform-specific directory
    mkpath(joinpath(pwd(), "build"))
    build_path = joinpath(pwd(), "build", target)
    run(`cp -a $src_path $build_path`) # JuliaLang/julia#20925

    cd(build_path) do
        # For each build, create a temporary prefix we'll install into, then package up
        temp_prefix() do prefix
            # We expect these outputs from our build steps
            libllvm_extra = LibraryResult(joinpath(libdir(prefix), "libLLVM_extra"))

            # We build using the typical autoconf incantation
            steps = [
                `make -C julia/deps install-llvm -j$(min(Sys.CPU_CORES + 1,8))`
            ]

            dep = Dependency("libLLVM-extra", [libllvm_extra], steps, platform, prefix)
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
