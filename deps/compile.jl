# compilation of extras library

include("select.jl")

# name for libLLVM_extra
const libext = is_apple() ? "dylib" : "so"
const extras_name = "libLLVM_extra.$libext"

verbose_run(cmd) = (println(cmd); run(cmd))

function compile_extras(llvm, julia)
    debug("Compiling extras library for LLVM $llvm and Julia $julia")

    extras_dir = joinpath(@__DIR__, "llvm-extra")
    extras_path = joinpath(extras_dir, extras_name)

    cd(extras_dir) do
        withenv("LLVM_CONFIG"  => get(llvm.config),  "LLVM_LIBRARY" => llvm.path,
                "JULIA_CONFIG" => get(julia.config), "JULIA_BINARY" => julia.path) do
            # force a rebuild as the LLVM installation might have changed, undetectably
            verbose_run(`make clean`)
            verbose_run(`make -j$(Sys.CPU_CORES+1)`)
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

    return extras_path
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
