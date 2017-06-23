# entry point for the buildbot: builds the extras library for deployment purposes

include("compile.jl")

if length(ARGS) == 0
    error("Usage: compile.jl TARGET_DIR")
end

const target = ARGS[1]
isdir(target) || mkdir(target)

libllvms = discover_llvm()
llvmjl_wrappers = discover_wrappers()
julia = discover_julia()

libllvm = select_llvm(libllvms, llvmjl_wrappers)

libllvm_extra_path = compile_extras(libllvm, julia)

mv(libllvm_extra_path, joinpath(target, libllvm_extra_name))
