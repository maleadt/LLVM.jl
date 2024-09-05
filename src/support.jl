## support routines

"""
    clopts(opts...)

Parse the given arguments using the LLVM command-line parser.

Note that this function modifies the global state of the LLVM library. It is also not safe
to rely on the stability of the command-line options between different versions of LLVM.
"""
function clopts(opts...)
    args = ["", opts...]
    API.LLVMParseCommandLineOptions(length(args), args, C_NULL)
end

# Permanently add the symbol `name` with the value `ptr`. These symbols are searched
# before any libraries.
add_symbol(name, ptr) = API.LLVMAddSymbol(name, ptr)

# Permanently load the dynamic library at the given path. It is safe to call this function
# multiple times for the same library.
load_library_permanently(path) = API.LLVMLoadLibraryPermanently(path)

# Search the global symbols for `name` and return the pointer to it.
find_symbol(name) = API.LLVMSearchForAddressOfSymbol(name)
