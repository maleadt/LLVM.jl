## support routines

function clopts(opts...)
    args = ["", opts...]
    API.LLVMParseCommandLineOptions(length(args), args, C_NULL)
end

"""
    add_symbol(name, ptr)

Permanently add the symbol `name` with the value `ptr`. These symbols are searched
before any libraries.
"""
add_symbol(name, ptr) = API.LLVMAddSymbol(name, ptr)

"""
    load_library_permantly(path)

This function permanently loads the dynamic library at the given path.
It is safe to call this function multiple times for the same library.
"""
load_library_permantly(path) = API.LLVMLoadLibraryPermanently(path)

"""
    find_symbol(name)

Search the global symbols for `name` and return the pointer to it.
"""
find_symbol(name) = API.LLVMSearchForAddressOfSymbol(name)
