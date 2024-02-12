# Version management

export version

version() = libllvm_version

function runtime_version()
    # FIXME: add a proper C API to LLVM
    version_print = unsafe_string(
        ccall((:_ZN4llvm16LTOCodeGenerator16getVersionStringEv, libllvm), Cstring, ()))
    m = match(r"LLVM version (?<version>.+)", version_print)
    m === nothing && error("Unrecognized version string: '$version_print'")
    version = m[:version]::AbstractString
    if endswith(version, "jl")
        # strip the "jl" SONAME suffix (JuliaLang/julia#33058)
        # (LLVM does never report a prerelease version anyway)
        VersionNumber(version[1:end-2])
    else
        VersionNumber(version)
    end
end

function is_asserts()
    Libdl.dlopen(libllvm) do handle
        @assert !isnothing(handle)
        Libdl.dlsym(handle, "_ZN4llvm23EnableABIBreakingChecksE"; throw_error=false) !== nothing
    end
end
