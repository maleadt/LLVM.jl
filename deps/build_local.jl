# Invoke with
# `julia --project=deps deps/build_local.jl`

# the pre-built LLVMExtra_jll might not be loadable on this platform
LLVMExtra_jll = Base.UUID("dad2f222-ce93-54a1-a47d-0025e8a3acab")

using Pkg, Scratch, Preferences, Libdl, CMake_jll

# 1. Ensure that an appropriate LLVM_full_jll is installed
Pkg.activate(; temp=true)
llvm_assertions = try
    cglobal((:_ZN4llvm24DisableABIBreakingChecksE, Base.libllvm_path()), Cvoid)
    false
catch
    true
end
LLVM = if llvm_assertions
    Pkg.add(name="LLVM_full_assert_jll", version=Base.libllvm_version)
    using LLVM_full_assert_jll
    LLVM_full_assert_jll
else
    Pkg.add(name="LLVM_full_jll", version=Base.libllvm_version)
    using LLVM_full_jll
    LLVM_full_jll
end
LLVM_DIR = joinpath(LLVM.artifact_dir, "lib", "cmake", "llvm")

# 2. Get a scratch directory
scratch_dir = get_scratch!(LLVMExtra_jll, "build")
isdir(scratch_dir) && rm(scratch_dir; recursive=true)
source_dir = joinpath(@__DIR__, "LLVMExtra")

# Build!
@info "Building" source_dir scratch_dir LLVM_DIR
run(`$(cmake()) -DLLVM_DIR=$(LLVM_DIR) -B$(scratch_dir) -S$(source_dir)`)
run(`$(cmake()) --build $(scratch_dir)`)

# Discover built libraries
built_libs = filter(readdir(joinpath(scratch_dir, "lib"))) do file
    endswith(file, ".$(Libdl.dlext)")
end
lib_path = joinpath(scratch_dir, "lib", only(built_libs))
isfile(lib_path) || error("Could not find library $lib_path in build directory")

# Tell LLVMExtra_jll to load our library instead of the default artifact one
set_preferences!(
    joinpath(dirname(@__DIR__), "LocalPreferences.toml"),
    "LLVMExtra_jll",
    "libLLVMExtra_path" => lib_path;
    force=true,
)
