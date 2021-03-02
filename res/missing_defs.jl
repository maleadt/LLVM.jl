@static if VERSION >= v"1.6.0"
    @static if Sys.islinux() && Sys.ARCH === :aarch64 && !occursin("musl", Base.BUILD_TRIPLET)
        const __off_t = Clong
        const off_t = __off_t
    elseif Sys.islinux() && Sys.ARCH === :aarch64 && occursin("musl", Base.BUILD_TRIPLET)
        const off_t = Clong
    elseif Sys.islinux() && startswith(string(Sys.ARCH), "arm") && !occursin("musl", Base.BUILD_TRIPLET)
        const __off_t = Clong
        const off_t = __off_t
    elseif Sys.islinux() && startswith(string(Sys.ARCH), "arm") && occursin("musl", Base.BUILD_TRIPLET)
        const off_t = Clonglong
    elseif Sys.islinux() && Sys.ARCH === :i686 && !occursin("musl", Base.BUILD_TRIPLET)
        const __off_t = Clong
        const off_t = __off_t
    elseif Sys.islinux() && Sys.ARCH === :i686 && occursin("musl", Base.BUILD_TRIPLET)
        const off_t = Clonglong
    elseif Sys.iswindows() && Sys.ARCH === :i686
        const off32_t = Clong
        const off_t = off32_t
    elseif Sys.islinux() && Sys.ARCH === :powerpc64le
        const __off_t = Clong
        const off_t = __off_t
    elseif Sys.isapple() && Sys.ARCH === :x86_64
        const __darwin_off_t = Int64
        const off_t = __darwin_off_t
    elseif Sys.islinux() && Sys.ARCH === :x86_64 && !occursin("musl", Base.BUILD_TRIPLET)
        const __off_t = Clong
        const off_t = __off_t
    elseif Sys.islinux() && Sys.ARCH === :x86_64 && occursin("musl", Base.BUILD_TRIPLET)
        const off_t = Clong
    elseif Sys.isbsd() && !Sys.isapple()
        const __off_t = Int64
        const off_t = __off_t
    elseif Sys.iswindows() && Sys.ARCH === :x86_64
        const off32_t = Clong
        const off_t = off32_t
    end
else
    const off_t = Csize_t
end
