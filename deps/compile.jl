# compilation of extras library

include("select.jl")

# name for libLLVM_extra
const libext = is_apple() ? "dylib" : "so"
const libllvm_extra_name = "libLLVM_extra.$libext"

verbose_run(cmd) = (println(cmd); run(cmd))

function compile_extras(libllvm, julia)
    info("Performing source build of LLVM extras library")
    debug("Building for LLVM v$(libllvm.version) at $(libllvm.path) using $(get(libllvm.config))")

    libllvm_extra = joinpath(@__DIR__, "llvm-extra", libllvm_extra_name)
    libllvm_extra_dir = joinpath(@__DIR__, "llvm-extra")
    libllvm_extra_path = joinpath(libllvm_extra_dir, libllvm_extra)

    cd(libllvm_extra_dir) do
        withenv("LLVM_CONFIG" => get(libllvm.config), "LLVM_LIBRARY" => libllvm.path,
                "JULIA_CONFIG" => get(julia.config), "JULIA_BINARY" => julia.path,) do
            # force a rebuild as the LLVM installation might have changed, undetectably
            verbose_run(`make clean`)
            verbose_run(`make -j$(Sys.CPU_CORES+1)`)
        end
    end

    # sanity check: in the case of a bundled LLVM the library should be loaded by Julia already,
    #               while a system-provided LLVM shouldn't
    libllvm_exclusive = Libdl.dlopen_e(libllvm.path, Libdl.RTLD_NOLOAD) == C_NULL
    if use_system_llvm != libllvm_exclusive
        @assert(Libdl.dlopen_e(libllvm.path, Libdl.RTLD_NOLOAD) == C_NULL,
                "exclusive access mode does not match requested type of LLVM library (run with TRACE=1 and file an issue)")
    end

    return libllvm_extra_path
end


#
# Main
#

function compile()
    libllvms, llvmjl_wrappers, julia = discover()
    libllvm = select_llvm(libllvms, llvmjl_wrappers)

    compile_extras(libllvm, julia)
end

if realpath(joinpath(pwd(), PROGRAM_FILE)) == realpath(@__FILE__)
    compile()
end
