# compilation of extras library

include("select.jl")

const libext = is_apple() ? "dylib" : "so"

# properties of the final location of llvm-extra
const extras_name = "LLVM_extras.$libext"
const extras_dir = joinpath(Pkg.Dir._pkgroot(), "lib", "v$(VERSION.major).$(VERSION.minor)")
const extras_path = joinpath(extras_dir, extras_name)

verbose_run(cmd) = (println(cmd); run(cmd))

function compile_extras(llvm, julia)
    debug("Compiling extras library for LLVM $llvm and Julia $julia")

    # properties of the in-tree build of llvm-extra
    extras_src_dir = joinpath(@__DIR__, "llvm-extra")
    extras_src_path = joinpath(extras_src_dir, "libLLVM_extra.$libext")

    cd(extras_src_dir) do
        withenv("LLVM_CONFIG"  => get(llvm.config),  "LLVM_LIBRARY" => llvm.path,
                "JULIA_CONFIG" => get(julia.config), "JULIA_BINARY" => julia.path) do
            try
                verbose_run(`make -j$(Sys.CPU_CORES+1)`)
                mv(extras_src_path, extras_path; remove_destination=true)
            finally
                verbose_run(`make clean`)
            end
        end
    end

    # sanity check: in the case of a bundled LLVM the library should be loaded by Julia already,
    #               while a system-provided LLVM shouldn't
    libllvm_exclusive = Libdl.dlopen_e(llvm.path, Libdl.RTLD_NOLOAD) == C_NULL
    if use_system_llvm != libllvm_exclusive
        @assert(Libdl.dlopen_e(llvm.path, Libdl.RTLD_NOLOAD) == C_NULL,
                "exclusive access mode does not match requested type of LLVM library (run with TRACE=1 and file an issue)")
    end

    debug("Compiled extra library at $extras_path")
end


#
# Main
#

function compile()
    llvms, wrappers, julia = discover()
    llvm = select_llvm(llvms, wrappers)

    compile_extras(llvm, julia)
end

if realpath(joinpath(pwd(), PROGRAM_FILE)) == realpath(@__FILE__)
    compile()
end
