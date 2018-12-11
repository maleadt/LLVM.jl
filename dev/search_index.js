var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "#LLVM.jl-1",
    "page": "Home",
    "title": "LLVM.jl",
    "category": "section",
    "text": "A Julia wrapper for the LLVM C API.This package provides a shallow wrapper around the LLVM C API. The entire API, wrapped by means of Clang.jl, is available in the LLVM.API submodule. Higher-level wrappers are part of the LLVM top-level module, and are added as the need arises (see COVERAGE.md for a list of wrapped functions)."
},

{
    "location": "#Installation-1",
    "page": "Home",
    "title": "Installation",
    "category": "section",
    "text": "Requirements:Julia 0.7 or higherPkg.add(\"LLVM\")\nusing LLVM\n\n# optionally\nPkg.test(\"LLVM\")The package uses the LLVM library bundled with Julia. This is only possible when the LLVM library is built dynamically (USE_LLVM_SHLIB=1), which has been the default since Julia 0.5. Use of the system LLVM library is not possible; this functionality has been removed from LLVM.jl starting with v1.0."
},

{
    "location": "man/usage/#",
    "page": "Usage",
    "title": "Usage",
    "category": "page",
    "text": ""
},

{
    "location": "man/usage/#Usage-1",
    "page": "Usage",
    "title": "Usage",
    "category": "section",
    "text": "To enable debug logging, launch Julia with the JULIA_DEBUG environment variable set to LLVM.WIP"
},

{
    "location": "man/troubleshooting/#",
    "page": "Troubleshooting",
    "title": "Troubleshooting",
    "category": "page",
    "text": ""
},

{
    "location": "man/troubleshooting/#Troubleshooting-1",
    "page": "Troubleshooting",
    "title": "Troubleshooting",
    "category": "section",
    "text": "You can enable verbose logging using two environment variables:DEBUG: if set, enable additional (possibly costly) run-time checks, and some more verbose output\nTRACE: if set, the DEBUG level will be activated, in addition with a trace of every call to the underlying libraryIn order to avoid run-time cost for checking the log level, these flags are implemented by means of global constants. As a result, you need to run Julia with precompilation disabled if you want to modify these flags:$ TRACE=1 julia --compilecache=no examples/sum.jl 1 2\nTRACE: LLVM.jl is running in trace mode, this will generate a lot of additional output\n...Enabling colors with --color=yes is also recommended as it color-codes the output."
},

{
    "location": "man/troubleshooting/#Building-llvm-extra-fails-due-to-C11-ABI-issues-1",
    "page": "Troubleshooting",
    "title": "Building llvm-extra fails due to C++11 ABI issues",
    "category": "section",
    "text": "The build step might fail at building the llvm-extra wrapper with errors like the following:IR/Pass.o:(.data.rel.ro._ZTVN4llvm15JuliaModulePassE[_ZTVN4llvm15JuliaModulePassE]+0x40): undefined reference to `llvm::ModulePass::createPrinterPass(llvm::raw_ostream&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) const\'\nIR/Pass.o:(.data.rel.ro._ZTVN4llvm17JuliaFunctionPassE[_ZTVN4llvm17JuliaFunctionPassE]+0x40): undefined reference to `llvm::FunctionPass::createPrinterPass(llvm::raw_ostream&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) const\'\nIR/Pass.o:(.data.rel.ro._ZTVN4llvm19JuliaBasicBlockPassE[_ZTVN4llvm19JuliaBasicBlockPassE]+0x40): undefined reference to `llvm::BasicBlockPass::createPrinterPass(llvm::raw_ostream&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) const\'\ncollect2: error: ld returned 1 exit statusIR/Pass.o:(.data.rel.ro._ZTVN4llvm15JuliaModulePassE[_ZTVN4llvm15JuliaModulePassE]+0x40): undefined reference to `llvm::ModulePass::createPrinterPass(llvm::raw_ostream&, std::string const&) const\'\nIR/Pass.o:(.data.rel.ro._ZTVN4llvm17JuliaFunctionPassE[_ZTVN4llvm17JuliaFunctionPassE]+0x40): undefined reference to `llvm::FunctionPass::createPrinterPass(llvm::raw_ostream&, std::string const&) const\'\nIR/Pass.o:(.data.rel.ro._ZTVN4llvm19JuliaBasicBlockPassE[_ZTVN4llvm19JuliaBasicBlockPassE]+0x40): undefined reference to `llvm::BasicBlockPass::createPrinterPass(llvm::raw_ostream&, std::string const&) const\'\ncollect2: error: ld returned 1 exit statusThese indicate a mismatch between the C++ ABI of the LLVM library (more specifically, caused by the C++11 ABI change), and what your compiler selects by default. The Makefile in this package tries to detect any C++11 ABI symbols in the selected LLVM library and configures GLIBC accordingly, but this detection might fail when objdump is not available on your system, or might not help if the target compiler doesn\'t support said ABI.Most if these issues can be fixed by using the same compiler LLVM was build with to compile llvm-extra. You can override the selected compiler by defining the CC and CXX environment variables, eg. CC=clang CXX=clang++ julia -e \'Pkg.build(\"LLVM\")\'."
},

{
    "location": "lib/api/#",
    "page": "API wrappers",
    "title": "API wrappers",
    "category": "page",
    "text": ""
},

{
    "location": "lib/api/#API-wrappers-1",
    "page": "API wrappers",
    "title": "API wrappers",
    "category": "section",
    "text": "This section lists the package\'s public functionality that directly corresponds to functionality of the LLVM C API. In general, the abstractions stay close to those of the LLVM APIs, so for more information on certain library calls you can consult the LLVM C API reference.The documentation is grouped according to the modules of the driver API.WIP"
},

{
    "location": "lib/interop/#",
    "page": "Julia/LLVM interop",
    "title": "Julia/LLVM interop",
    "category": "page",
    "text": ""
},

{
    "location": "lib/interop/#Julia/LLVM-interop-1",
    "page": "Julia/LLVM interop",
    "title": "Julia/LLVM interop",
    "category": "section",
    "text": "This section lists functionality for connecting Julia with LLVM.jl, e.g. emitting code for the Julia JIT or creating types that are compatible with Julia\'s global state."
},

{
    "location": "lib/interop/#LLVM.Interop.JuliaContext",
    "page": "Julia/LLVM interop",
    "title": "LLVM.Interop.JuliaContext",
    "category": "function",
    "text": "JuliaContext()\n\nReturns the (session-bound) LLVM context used by the Julia compiler.\n\n\n\n\n\n"
},

{
    "location": "lib/interop/#Base.convert-Tuple{Type{LLVMType},Type}",
    "page": "Julia/LLVM interop",
    "title": "Base.convert",
    "category": "method",
    "text": "convert(LLVMType, typ::Type)\n\nConvert a Julia type typ to its LLVM representation. Fails if the type would be boxed.\n\n\n\n\n\n"
},

{
    "location": "lib/interop/#LLVM.Interop.create_function",
    "page": "Julia/LLVM interop",
    "title": "LLVM.Interop.create_function",
    "category": "function",
    "text": "create_function(rettyp::LLVMType, argtyp::Vector{LLVMType}, [name::String])\n\nCreate an LLVM function, given its return type rettyp and a vector of argument types argtyp. The function is marked for inlining, to be embedded in the caller\'s body. Returns both the newly created function, and its type.\n\n\n\n\n\n"
},

{
    "location": "lib/interop/#LLVM.Interop.call_function",
    "page": "Julia/LLVM interop",
    "title": "LLVM.Interop.call_function",
    "category": "function",
    "text": "call_function(f::LLVM.Function, rettyp::Type, argtyp::Type, args::Expr)\n\nGenerate a call to an LLVM function f, given its return type rettyp and a tuple-type for the arguments. The arguments should be passed as an expression yielding a tuple of the argument values (eg. :((1,2))), which will be splatted into the call to the function.\n\n\n\n\n\n"
},

{
    "location": "lib/interop/#Base-functionality-1",
    "page": "Julia/LLVM interop",
    "title": "Base functionality",
    "category": "section",
    "text": "LLVM.Interop.JuliaContext\nBase.convert(::Type{LLVMType}, ::Type)\nLLVM.Interop.create_function\nLLVM.Interop.call_function"
},

{
    "location": "lib/interop/#LLVM.Interop.@asmcall",
    "page": "Julia/LLVM interop",
    "title": "LLVM.Interop.@asmcall",
    "category": "macro",
    "text": "@asmcall asm::String [constraints::String] [side_effects::Bool=false]\n         rettyp=Nothing argtyp=Tuple{} args...\n\nCall some inline assembly asm, optionally constrained by constraints and denoting other side effects in side_effects, specifying the return type in rettyp and types of arguments as a tuple-type in argtyp.\n\n\n\n\n\n"
},

{
    "location": "lib/interop/#Inline-assembly-1",
    "page": "Julia/LLVM interop",
    "title": "Inline assembly",
    "category": "section",
    "text": "LLVM.Interop.@asmcall"
},

]}
