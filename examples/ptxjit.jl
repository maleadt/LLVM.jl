using LLVM
using CUDAdrv, CUDAnative
using Base.Test

dev = CuDevice(0)
cap = capability(dev)

# helper methods for querying version DBs
# (tool::VersionNumber => devices::Vector{VersionNumber})
flatten(vecvec) = vcat(vecvec...)
search(db, predicate) = Set(flatten(valvec for (key,valvec) in db if predicate(key)))

# figure out which devices this LLVM library supports
const llvm_db = [
    v"3.2" => [v"2.0", v"2.1", v"3.0", v"3.5"],
    v"3.5" => [v"5.0"],
    v"3.7" => [v"3.2", v"3.7", v"5.2", v"5.3"],
    v"3.9" => [v"6.0", v"6.1", v"6.2"]
]
llvm_ver = LLVM.version()
llvm_support = search(llvm_db, ver -> ver <= llvm_ver)
isempty(llvm_support) && error("LLVM library $llvm_ver does not support any compatible device")

# figure out which devices this CUDA toolkit supports
const cuda_db = [
    v"4.0" => [v"2.0", v"2.1"],
    v"4.2" => [v"3.0"],
    v"5.0" => [v"3.5"],
    v"6.0" => [v"3.2", v"5.0"],
    v"6.5" => [v"3.7"],
    v"7.0" => [v"5.2"],
    v"7.5" => [v"5.3"],
    v"8.0" => [v"6.0", v"6.1"]  # NOTE: 6.2 should be supported, but `ptxas` complains
]
cuda_ver = CUDAdrv.version()
cuda_support = search(cuda_db, ver -> ver <= cuda_ver)
isempty(cuda_support) && error("CUDA toolkit $cuda_ver does not support any compatible device")

# select a target
target = maximum(llvm_support ∩ cuda_support)
cpu = "sm_$(target.major)$(target.minor)"

# figure out which libdevice versions are compatible with the selected target
const libdevice_db = [v"2.0", v"3.0", v"3.5"]
libdevice_compat = Set(ver for ver in libdevice_db if ver <= target)
isempty(libdevice_compat) && error("No compatible CUDA device library available")
libdevice_ver = maximum(libdevice_compat)
libdevice_fn = "libdevice.compute_$(libdevice_ver.major)$(libdevice_ver.minor).10.bc"


## irgen

# check if Julia's LLVM version matches ours
jl_llvm_ver = VersionNumber(Base.libllvm_version)
if jl_llvm_ver != llvm_ver
    error("LLVM library $llvm_ver incompatible with Julia's LLVM $jl_llvm_ver")
end

mod = LLVM.Module("vadd")
# TODO: why doesn't the datalayout match datalayout(tm)?
if is(Int,Int64)
    triple!(mod, "nvptx64-nvidia-cuda")
    datalayout!(mod, "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v32:32:32-v64:64:64-v128:128:128-n16:32:64")
else
    triple!(mod, "nvptx-nvidia-cuda")
    datalayout!(mod, "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v32:32:32-v64:64:64-v128:128:128-n16:32:64")
end
# TODO: get this IR by calling into Julia
entry = "julia_kernel_vadd_64943"
ir = readstring(joinpath(@__DIR__, "ptxjit.ll"))
let irmod = parse(LLVM.Module, ir)
    name!(irmod, "parsed")

    triple!(irmod, triple(mod))
    datalayout!(irmod, datalayout(mod))

    link!(mod, irmod)
    
    verify(mod)
end


## linking

# libdevice

if haskey(ENV, "NVVMIR_LIBRARY_DIR")
    libdevice_dirs = [ENV["NVVMIR_LIBRARY_DIR"]]
else
    libdevice_dirs = ["/usr/lib/nvidia-cuda-toolkit/libdevice",
                      "/usr/local/cuda/nvvm/libdevice",
                      "/opt/cuda/nvvm/libdevice"]
end
any(d->isdir(d), libdevice_dirs) ||
    error("CUDA device library path not found -- specify using NVVMIR_LIBRARY_DIR")

libdevice_paths = filter(p->isfile(p), map(d->joinpath(d,libdevice_fn), libdevice_dirs))
isempty(libdevice_paths) && error("CUDA device library $libdevice_fn not found")
libdevice_path = first(libdevice_paths)

open(libdevice_path) do libdevice
    let libdevice_mod = parse(LLVM.Module, read(libdevice))
        name!(libdevice_mod, "libdevice")

        # override libdevice's triple and datalayout to avoid warnings
        triple!(libdevice_mod, triple(mod))
        datalayout!(libdevice_mod, datalayout(mod))

        # 1. Save list of external functions
        exports = map(f->LLVM.name(f), functions(mod))
        filter!(fn->!haskey(functions(libdevice_mod), fn), exports)

        # 2. Link with libdevice
        link!(mod, libdevice_mod)

        ModulePassManager() do pm
            # 3. Internalize all functions not in list from (1)
            internalize!(pm, exports)

            # 4. Eliminate all unused internal functions
            global_optimizer!(pm)
            global_dce!(pm)
            strip_dead_prototypes!(pm)

            # 5. Run NVVMReflect pass
            nvvm_reflect!(pm, Dict("__CUDA_FTZ" => 1))

            # 6. Run standard optimization pipeline
            always_inliner!(pm)

            run!(pm, mod)
        end
    end
end

# kernel metadata

fn = get(functions(mod), entry)

push!(metadata(mod), "nvvm.annotations",
      MDNode([fn, MDString("kernel"),  ConstantInt(LLVM.Int32Type(), 1)]))


## optimize & mcgen

InitializeNVPTXTarget()
InitializeNVPTXTargetInfo()
t = Target(triple(mod))

InitializeNVPTXTargetMC()
tm = TargetMachine(t, triple(mod), cpu)

ModulePassManager() do pm
    # invoke Julia's custom passes
    tbaa_gcframe = MDNode(ccall(:jl_get_tbaa_gcframe, LLVM.API.LLVMValueRef, ()))
    ccall(:LLVMAddLowerGCFramePass, Void,
          (LLVM.API.LLVMPassManagerRef, LLVM.API.LLVMValueRef),
          LLVM.ref(pm), LLVM.ref(tbaa_gcframe))
    ccall(:LLVMAddLowerPTLSPass, Void,
          (LLVM.API.LLVMPassManagerRef, LLVM.API.LLVMValueRef, Cint),
          LLVM.ref(pm), LLVM.ref(tbaa_gcframe), 0)

    populate!(pm, tm)

    PassManagerBuilder() do pmb
        populate!(pm, pmb)
    end

    run!(pm, mod)
end

InitializeNVPTXAsmPrinter()
asm = convert(String, emit(tm, mod, LLVM.API.LLVMAssemblyFile))


## execution

ctx = CuContext(dev)

cuda_mod = CuModule(asm)
vadd = CuFunction(cuda_mod, entry)

dims = (3,4)
a = round.(rand(Float32, dims) * 100)
b = round.(rand(Float32, dims) * 100)

d_a = CuArray(a)
d_b = CuArray(b)
d_c = CuArray(Float32, dims)

len = prod(dims)
@cuda (1,len) vadd(d_a.ptr, d_b.ptr, d_c.ptr)
c = Array(d_c)
@test a+b ≈ c

destroy(ctx)
