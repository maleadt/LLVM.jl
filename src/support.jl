## support routines

function clopts(opts...)
    args = ["", opts...]
    LLVM.API.LLVMParseCommandLineOptions(Int32(length(args)),
        [Base.unsafe_convert(Cstring, arg) for arg in args], C_NULL)
end
