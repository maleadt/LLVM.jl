# Invoke with
# `julia -e 'using Pkg; pkg"activate --temp"; pkg"add Pkg Scratch Preferences LLVMExtra_jll"' -L build_local.jl`

using Pkg, Scratch, Preferences, LLVMExtra_jll

# 1. Ensure that LLVM_full_jll is installed
Pkg.add(name="LLVM_full_jll", version=Base.libllvm_version)
using LLVM_full_jll
LLVM_DIR = joinpath(LLVM_full_jll.artifact_dir, "lib", "cmake", "llvm")

# 2. Get a scratch directory
scratch_dir = get_scratch!(LLVMExtra_jll, "build")
source_dir = joinpath(@__DIR__, "LLVMExtra")

@info "Building" source_dir scratch_dir LLVM_DIR

run(`cmake -DLLVM_DIR=$(LLVM_DIR) -B$(scratch_dir) -S$(source_dir)`)
run(`cmake --build $(scratch_dir)`)

lib_path = joinpath(scratch_dir, "lib", basename(LLVMExtra_jll.libLLVMExtra_path))

if !isfile(lib_path)
    error("Could not find library $lib_path in build directory")
end

# Tell LLVMExtra_jll to load our library instead of the default artifact one
set_preferences!(
    joinpath(dirname(@__DIR__), "LocalPreferences.toml"),
    "LLVMExtra_jll",
    "libLLVMExtra_path" => lib_path;
    force=true,
)

set_preferences!(
    joinpath(dirname(@__DIR__), "test", "LocalPreferences.toml"),
    "LLVMExtra_jll",
    "libLLVMExtra_path" => lib_path;
    force=true,
)
