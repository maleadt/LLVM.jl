# deprecated methods

import Base: convert

@deprecate convert(::Type{LLVMType}, typ::Type, allow_boxed::Core.Bool) convert(LLVMType, typ; allow_boxed=allow_boxed)
