export PreservedAnalyses

export no_analyses_preserved, all_analyses_preserved, cfg_analyses_preserved, are_all_preserved, are_cfg_preserved, dispose

@checked struct PreservedAnalyses
    ref::API.LLVMPreservedAnalysesRef
end

Base.unsafe_convert(::Type{API.LLVMPreservedAnalysesRef}, pa::PreservedAnalyses) = pa.ref

no_analyses_preserved() = PreservedAnalyses(API.LLVMCreatePreservedAnalysesNone())

all_analyses_preserved() = PreservedAnalyses(API.LLVMCreatePreservedAnalysesAll())

cfg_analyses_preserved() = PreservedAnalyses(API.LLVMCreatePreservedAnalysesCFG())

dispose(pa::PreservedAnalyses) = API.LLVMDisposePreservedAnalyses(pa)

are_all_preserved(pa::PreservedAnalyses) = API.LLVMAreAllAnalysesPreserved(pa)

are_cfg_preserved(pa::PreservedAnalyses) = API.LLVMAreCFGAnalysesPreserved(pa)

# No do-block syntax is provided for preserved analyses because
# it is not meant to be used with limited scope.

function unsafe_run(f::Core.Function)
    try
        return f()
    catch e
        # Throwing exceptions in the pass pipeline is very unsafe
        # and will result in undefined behavior immediately. This
        # try-catch just tries to report the error so that the
        # issue is at least debuggable.
        io = IOBuffer()
        Base.showerror(io, e)
        error_msg = String(take!(io))
        @error error_msg
    end
end
