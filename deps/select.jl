# selection of LLVM library and wrapper based on best compatibility and user requests

include("discover.jl")

vercmp_match(a,b)  = a.major==b.major &&  a.minor==b.minor
vercmp_compat(a,b) = a.major>b.major  || (a.major==b.major && a.minor>=b.minor)


#
# LLVM selection
#

# First consider installations with a major and minor version matching wrapped headers
# (see the `lib` folder). If no such installation have been found, consider
# probably-compatible versions (ie. for which we have an older set of wrapped headers).
#
# If the user requested a specific version, only ever consider that version.

function select_llvm(libllvms, wrapped_versions)
    # version selection
    if !isnull(override_llvm_version)
        warn("Forcing LLVM version at $(get(override_llvm_version))")
        filter!(t->vercmp_match(t.version,get(override_llvm_version)), libllvms)
    elseif !use_system_llvm
        # a bundled LLVM should already match base_llvm_version,
        # but there might be multiple built LLVM libraries present
        filter!(t->vercmp_match(t.version,base_llvm_version), libllvms)
    end

    # select wrapper
    matching_llvms   = filter(t -> any(v -> vercmp_match(t.version,v), wrapped_versions), libllvms)
    compatible_llvms = filter(t -> !in(t, matching_llvms) && 
                                   any(v -> vercmp_compat(t.version,v), wrapped_versions), libllvms)

    libllvms = [matching_llvms; compatible_llvms]

    # we will require `llvm-config` for building
    filter!(x->!isnull(x.config), libllvms)
    isempty(libllvms) && error("could not find LLVM installation providing llvm-config")

    # pick the first version and run with it (we should be able to build with all of them)
    libllvm = first(libllvms)
    libllvm in matching_llvms || warn("Selected LLVM version v$(libllvm.version) is unsupported")

    return libllvm
end


#
# Wrapper selection
#

function select_wrapper(libllvm, wrapped_versions)
    if libllvm.version in wrapped_versions
        wrapper_version = libllvm.version
    else
        compatible_wrappers = filter(v->vercmp_compat(libllvm.version, v), wrapped_versions)
        wrapper_version = last(compatible_wrappers)
        debug("Will be using wrapper v$(verstr(wrapper_version)) for libLLVM v$(libllvm.version)")
    end

    return verstr(wrapper_version)
end


#
# Main
#

function select()
    libllvms, llvmjl_wrappers, julia = discover()

    libllvm = select_llvm(libllvms, llvmjl_wrappers)

    return libllvm, select_wrapper(libllvm, llvmjl_wrappers)
end

if realpath(joinpath(pwd(), PROGRAM_FILE)) == realpath(@__FILE__)
    libllvm, llvmjl_wrapper = select()

    println("LLVM library: $libllvm")
    println("LLVM wrapper: $llvmjl_wrapper")
end
