var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#LLVM.jl-1",
    "page": "Home",
    "title": "LLVM.jl",
    "category": "section",
    "text": "A Julia wrapper for the LLVM C API.This package provides a shallow wrapper around the LLVM C API. The entire API, wrapped by means of Clang.jl, is available in the LLVM.API submodule. Higher-level wrappers are part of the LLVM top-level module, and are added as the need arises (see COVERAGE.md for a list of wrapped functions)."
},

{
    "location": "index.html#Installation-1",
    "page": "Home",
    "title": "Installation",
    "category": "section",
    "text": "Requirements:LLVM 3.9 or higher, in full (ie. not only libLLVM.so, but also llvm-config, headers, etc)\nJulia 0.5 or higher\nC++ compiler, and possibly some development headers (like libz1, zlib1g-dev on many popular Linux distributions)Pkg.add(\"LLVM\")\nusing LLVM\n\n# optionally\nPkg.test(\"LLVM\")The build step (executed by Pkg.add) detects available LLVM installations and builds a library with additional API functions. The best matching installation of LLVM will be selected, but any version can be forced by setting the LLVM_VER environment variable at build time. The script will only load LLVM libraries bundled with Julia, but that can be overridden by defining USE_SYSTEM_LLVM. However, that option is experimental and likely to break. Your best bet is to build Julia from source, and run it from the build tree without running make install. Binary versions of Julia are not compatible with LLVM.jl.If installation fails, re-run the failing steps with the DEBUG environment variable set to 1 and attach that output to a bug report:$ DEBUG=1 julia\njulia> Pkg.build(\"LLVM\")\n...Even if the build fails, LLVM.jl should always be loadable. This simplifies use by downstream packages, until there is proper language support for conditional modules. You can check whether the package has been built properly by inspecting the LLVM.configured global variable."
},

{
    "location": "index.html#System-provided-LLVM-1",
    "page": "Home",
    "title": "System-provided LLVM",
    "category": "section",
    "text": "Loading LLVM.jl with a system-provided LLVM library is an experimental option, only supported on Linux, and partially cripples functionality of this package. The problem stems from how loading multiple copies of LLVM makes global symbols clash (despite using RTLD_LOCAL|RTLD_DEEPBIND), corrupting the state of either library when performing certain calls like LLVMShutdown.On Linux, we have dlmopen to load the LLVM library in a separate library namespace [apple]. However, this newly created namespace is completely empty, and does not include libjulia either. As a result, we cannot call back into the compiler, breaking functionality such as the Julia-callbacks for LLVM passes.[apple]: This is supposed to work on macOS too, but I haven't been able to get it working. Certain lookups resolve across libraries, despite using RTLD_DEEPBIND:frame 0: libsystem_malloc.dylib  malloc_error_break\nframe 1: libsystem_malloc.dylib  free\nframe 2: libLLVM-3.7.dylib       llvm::DenseMapBase<...>*)\nframe 3: libLLVM-3.7.dylib       unsigned int llvm::DFSPass<...>::NodeType*, unsigned int)\nframe 4: libLLVM-3.7.dylib       void llvm::Calculate<...>&, llvm::Function&)\nframe 5: libLLVM.dylib           (anonymous namespace)::Verifier::verify(llvm::Function const&)\nframe 6: libLLVM.dylib           llvm::verifyModule(llvm::Module const&, llvm::raw_ostream*, bool*)\nframe 7: libLLVM.dylib           LLVMVerifyModule"
},

{
    "location": "man/usage.html#",
    "page": "Usage",
    "title": "Usage",
    "category": "page",
    "text": ""
},

{
    "location": "man/usage.html#Usage-1",
    "page": "Usage",
    "title": "Usage",
    "category": "section",
    "text": "WIP"
},

{
    "location": "man/troubleshooting.html#",
    "page": "Troubleshooting",
    "title": "Troubleshooting",
    "category": "page",
    "text": ""
},

{
    "location": "man/troubleshooting.html#Troubleshooting-1",
    "page": "Troubleshooting",
    "title": "Troubleshooting",
    "category": "section",
    "text": "You can enable verbose logging using two environment variables:DEBUG: if set, enable additional (possibly costly) run-time checks, and some more verbose output\nTRACE: if set, the DEBUG level will be activated, in addition with a trace of every call to the underlying libraryIn order to avoid run-time cost for checking the log level, these flags are implemented by means of global constants. As a result, you need to run Julia with precompilation disabled if you want to modify these flags:$ TRACE=1 julia --compilecache=no examples/sum.jl 1 2\nTRACE: LLVM.jl is running in trace mode, this will generate a lot of additional output\n...Enabling colors with --color=yes is also recommended as it color-codes the output."
},

{
    "location": "man/troubleshooting.html#Building-llvm-extra-fails-due-to-C11-ABI-issues-1",
    "page": "Troubleshooting",
    "title": "Building llvm-extra fails due to C++11 ABI issues",
    "category": "section",
    "text": "The build step might fail at building the llvm-extra wrapper with errors like the following:IR/Pass.o:(.data.rel.ro._ZTVN4llvm15JuliaModulePassE[_ZTVN4llvm15JuliaModulePassE]+0x40): undefined reference to `llvm::ModulePass::createPrinterPass(llvm::raw_ostream&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) const'\nIR/Pass.o:(.data.rel.ro._ZTVN4llvm17JuliaFunctionPassE[_ZTVN4llvm17JuliaFunctionPassE]+0x40): undefined reference to `llvm::FunctionPass::createPrinterPass(llvm::raw_ostream&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) const'\nIR/Pass.o:(.data.rel.ro._ZTVN4llvm19JuliaBasicBlockPassE[_ZTVN4llvm19JuliaBasicBlockPassE]+0x40): undefined reference to `llvm::BasicBlockPass::createPrinterPass(llvm::raw_ostream&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) const'\ncollect2: error: ld returned 1 exit statusIR/Pass.o:(.data.rel.ro._ZTVN4llvm15JuliaModulePassE[_ZTVN4llvm15JuliaModulePassE]+0x40): undefined reference to `llvm::ModulePass::createPrinterPass(llvm::raw_ostream&, std::string const&) const'\nIR/Pass.o:(.data.rel.ro._ZTVN4llvm17JuliaFunctionPassE[_ZTVN4llvm17JuliaFunctionPassE]+0x40): undefined reference to `llvm::FunctionPass::createPrinterPass(llvm::raw_ostream&, std::string const&) const'\nIR/Pass.o:(.data.rel.ro._ZTVN4llvm19JuliaBasicBlockPassE[_ZTVN4llvm19JuliaBasicBlockPassE]+0x40): undefined reference to `llvm::BasicBlockPass::createPrinterPass(llvm::raw_ostream&, std::string const&) const'\ncollect2: error: ld returned 1 exit statusThese indicate a mismatch between the C++ ABI of the LLVM library (more specifically, caused by the C++11 ABI change), and what your compiler selects by default. The Makefile in this package tries to detect any C++11 ABI symbols in the selected LLVM library and configures GLIBC accordingly, but this detection might fail when objdump is not available on your system, or might not help if the target compiler doesn't support said ABI.Most if these issues can be fixed by using the same compiler LLVM was build with to compile llvm-extra. You can override the selected compiler by defining the CC and CXX environment variables, eg. CC=clang CXX=clang++ julia -e 'Pkg.build(\"LLVM\")'."
},

{
    "location": "lib/api.html#",
    "page": "API wrappers",
    "title": "API wrappers",
    "category": "page",
    "text": ""
},

{
    "location": "lib/api.html#API-wrappers-1",
    "page": "API wrappers",
    "title": "API wrappers",
    "category": "section",
    "text": "This section lists the package's public functionality that directly corresponds to functionality of the LLVM C API. In general, the abstractions stay close to those of the LLVM APIs, so for more information on certain library calls you can consult the LLVM C API reference.The documentation is grouped according to the modules of the driver API.WIP"
},

]}
