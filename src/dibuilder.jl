export DILocation

function DILocation(ctx, line, col, scope=nothing, inlined_at=nothing)
    Metadata(API.LLVMDIBuilderCreateDebugLocation(ctx, line, col,
                                                  something(scope, C_NULL),
                                                  something(inlined_at, C_NULL)))
end
