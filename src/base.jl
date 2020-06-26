# Basic library functionality

export version

version() = Base.libllvm_version

function runtime_version()
    # FIXME: add a proper C API to LLVM
    version_print = unsafe_string(
        @runtime_ccall((:_ZN4llvm16LTOCodeGenerator16getVersionStringEv, libllvm[]), Cstring, ()))
    m = match(r"LLVM version (?<version>.+)", version_print)
    m === nothing && error("Unrecognized version string: '$version_print'")
    if endswith(m[:version], "jl")
        # strip the "jl" SONAME suffix (JuliaLang/julia#33058)
        # (LLVM does never report a prerelease version anyway)
        VersionNumber(m[:version][1:end-2])
    else
        VersionNumber(m[:version])
    end
end
