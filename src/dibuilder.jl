function DILocation(ctx, line, col, scope=nothing, inlined_at=nothing)
    DILocation(API.LLVMDIBuilderCreateDebugLocation(ctx, line, col,
                                                    something(scope, C_NULL),
                                                    something(inlined_at, C_NULL)))
end
