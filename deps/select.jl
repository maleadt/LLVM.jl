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

function select_llvm(llvms, wrappers)
    debug("Selecting LLVM from libraries $(join(llvms, ", ")) and wrappers $(join(wrappers, ", "))")
    # type selection (bundled or not)
    if !use_system_llvm
        filter!(t->t.props[:bundled] == true, llvms)

        # a bundled LLVM should already match base_llvm_version,
        # but there might be multiple built LLVM libraries present
        filter!(t->vercmp_match(t.version,base_llvm_version), llvms)
    else
        filter!(t->t.props[:bundled] == false, llvms)
    end

    # version selection
    if !isnull(override_llvm_version)
        warn("Forcing LLVM version at $(get(override_llvm_version))")
        filter!(t->vercmp_match(t.version,get(override_llvm_version)), llvms)
    end

    # select wrapper
    matching_llvms   = filter(t -> any(v -> vercmp_match(t.version,v), wrappers), llvms)
    compatible_llvms = filter(t -> !in(t, matching_llvms) && 
                                   any(v -> vercmp_compat(t.version,v), wrappers), llvms)

    llvms = [matching_llvms; compatible_llvms]

    # we will require `llvm-config` for building
    filter!(x->!isnull(x.config), llvms)
    isempty(llvms) && error("could not find LLVM installation providing llvm-config; did you build Julia from source?")

    # pick the first version and run with it (we should be able to build with all of them)
    llvm = first(llvms)
    debug("Selected LLVM $llvm")
    llvm in matching_llvms || warn("Selected LLVM version v$(llvm.version) is unsupported")

    return llvm
end


#
# Wrapper selection
#

function select_wrapper(llvm, wrappers)
    debug("Selecting wrapper for $llvm out of wrappers $(join(wrappers, ", "))")

    if llvm.version in wrappers
        wrapper = llvm.version
    else
        compatible_wrappers = filter(v->vercmp_compat(llvm.version, v), wrappers)
        wrapper = last(compatible_wrappers)
    end
    debug("Selected wrapper $(verstr(wrapper)) for LLVM $llvm")

    return verstr(wrapper)
end


#
# Main
#

function select()
    llvms, wrappers, julia = discover()

    llvm = select_llvm(llvms, wrappers)

    return llvm, select_wrapper(llvm, wrappers)
end

if realpath(joinpath(pwd(), PROGRAM_FILE)) == realpath(@__FILE__)
    llvm, wrapper = select()

    println("LLVM toolchain: $llvm")
    println("LLVM wrapper: $wrapper")
end
