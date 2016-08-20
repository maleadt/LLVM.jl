# The bulk of LLVM's object model consists of values, which comprise a very rich type
# hierarchy.

immutable Value
    handle::API.LLVMValueRef
end


#
# General APIs
#