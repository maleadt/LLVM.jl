## support routines

function clopts(opts...)
    args = ["", opts...]
    API.LLVMParseCommandLineOptions(length(args), args, C_NULL)
end
