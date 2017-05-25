##################################
## HELPER FUNCTIONS
##################################

# capture std output of cmd
function capture(cmd)
    (out, pc) = open(cmd, "r")
    stdoutstr = readchomp(out)
    if !success(pc)
        Base.wait_close(out)
        println(stdoutstr) # print this with error color
        pc !== nothing && Base.pipeline_error(pc)
    end
    stdoutstr
end

function _dirwalk(A, path::AbstractString)
  for c in readdir(path)
    p = joinpath(path, c)
    if isdir(p)
      _dirwalk(A, p)
    elseif isfile(p)
      push!(A, p)
    end
  end
end

# Return all files recursively from path
dirwalk(path::AbstractString) = (filenames = String[]; _dirwalk(filenames, path); filenames)

# Search for a compiler to link sys.o into sys.dl_ext.  Honor LD environment variable.
function find_system_compiler()
    if haskey(ENV, "CPP")
        if !success(`$(ENV["CPP"]) -v`)
            warn("Using compiler override $(ENV["CPP"]), but unable to run `$(ENV["CPP"]) -v`.")
        end
        return ENV["CPP"]
    end
    if is_windows() # On Windows, check to see if WinRPM is installed, and if so, see if gcc is installed
        try
            eval(Main, :(using WinRPM))
            winrpmgcc = joinpath(WinRPM.installdir, "usr", "$(Sys.ARCH)-w64-mingw32", "sys-root", "mingw", "bin", "g++.exe")
            if success(`$winrpmgcc --version`)
                return winrpmgcc
            else
                throw()
            end
        catch
            error("Install G++ via `Pkg.add(\"WinRPM\"); using WinRPM; WinRPM.install(\"g++\")`.")
        end
    end
    try
        if success(`g++ -v`) # see if `cc` exists
            return "g++"
        end
    end
    error("No supported compiler found; startup times will be longer.")
end

##################################
## MAKE
##################################

function build(libllvm, julia, llvmextra, cpp = find_system_compiler())

    LLVM_CONFIG = get(libllvm.config)
    LLVM_LIBRARY = libllvm.path
    JULIA_CONFIG = get(julia.config)
    JULIA_BINARY = julia.path

    CPPFLAGS = split(capture(`$LLVM_CONFIG --cppflags`))
    CXXFLAGS = split(capture(`$LLVM_CONFIG --cxxflags`))
    LDFLAGS =  split(capture(`$LLVM_CONFIG --ldflags`))
    LDLIBS =   split(capture(`$LLVM_CONFIG --system-libs`))

    push!(LDFLAGS, "-Wl,-rpath,$LLVM_LIBRARY") # needs to be quoted to work
    push!(LDLIBS, "-l:$(splitdir(LLVM_LIBRARY)[2])")

    # sanitize the cflags llvm-config provides us with
    # (removing C++ specific ones, or flags supported by only Clang or GCC)
    BADFLAGS = ["-Wcovered-switch-default", "-fcolor-diagnostics", "-Wdelete-non-virtual-dtor", "-gline-tables-only", "-Wstring-conversion"]
    CXXFLAGS = filter(flag -> !(flag in BADFLAGS) , CXXFLAGS)

    # handle RTTI flags
    HAS_RTTI= capture(`$LLVM_CONFIG --has-rtti`)
    if HAS_RTTI != "YES"
    	push!(CXXFLAGS, "-fno-rtti")
    end

    # we shouldn't use target-specific symbols unless the target is built,
    # so generate preprocessor definitions
    LLVM_TARGETS = uppercase(capture(`$LLVM_CONFIG --targets-built`))
    push!(CPPFLAGS, "-DTARGET_$LLVM_TARGETS")

    # # try to detect LLVM's C++ ABI, and configure GLIBC accordingly
    # # NOTE: this is best-effort, as the target compiler might just not support the new ABI
    # NM := $(shell command -v nm 2> /dev/null)
    # ifdef NM
    #   ifeq ($(UNAME),Linux)
    #     CXX11_SYMBOLS=$(shell $(NM) -D "$(LLVM_LIBRARY)" | grep -E "(_cxx11|B5cxx11)")
    #   endif
    #   ifeq ($(UNAME),Darwin)
    #     CXX11_SYMBOLS=$(shell $(NM) -g "$(LLVM_LIBRARY)" | grep -E "(_cxx11|B5cxx11)")
    #   endif
    #   ifeq ($(CXX11_SYMBOLS),)
    #     CPPFLAGS += -D_GLIBCXX_USE_CXX11_ABI=0
    #   else
    #     CPPFLAGS += -D_GLIBCXX_USE_CXX11_ABI=1
    #   endif
    # else
    #   $(warning nm not available, cannot detect C++11 ABI)
    # endif


    #
    # Julia flags
    #

    append!(CXXFLAGS, split(capture(`$JULIA_BINARY $JULIA_CONFIG --cflags`)))
    append!(LDFLAGS, split(capture(`$JULIA_BINARY $JULIA_CONFIG --ldflags`)))
    if is_windows()
        push!(LDFLAGS, "-lssp")
    end

    #
    # Build
    #

    TARGET  = "libLLVM_extra.$(Libdl.dlext)"
    SOURCES = filter(x -> ismatch(r".cpp$", x), dirwalk(llvmextra))
    OBJECTS = map(s -> replace(s, r".cpp$", ".$(Libdl.dlext)"), SOURCES)


    # shared-library building
    push!(CXXFLAGS, "-fPIC")


    for object in OBJECTS
        run(`$cpp $CPPFLAGS -shared $LDFLAGS $LDLIBS -o $object`)
    end

    run(`$cpp $CPPFLAGS -shared $OBJECTS $LDFLAGS $LDLIBS -o $(joinpath(llvmextra ,TARGET))`)

end
