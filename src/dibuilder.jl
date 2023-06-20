function DILocation(line, col, scope=nothing, inlined_at=nothing)
    # XXX: are null scopes valid? they crash LLVM:
    #      DILocation(Context(), 1, 2).scope
    DILocation(API.LLVMDIBuilderCreateDebugLocation(context(), line, col,
                                                    something(scope, C_NULL),
                                                    something(inlined_at, C_NULL)))
end
