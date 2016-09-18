module LLVM

using Compat
import Compat.String

module API
ext = joinpath(dirname(@__FILE__), "..", "deps", "ext.jl")
isfile(ext) || error("Unable to load $ext\n\nPlease re-run Pkg.build(\"LLVM\"), and restart Julia.")
include(ext)
end


include("logging.jl")
include("auxiliary.jl")

# forward declarations
@reftypedef ref=LLVMTypeRef enum=LLVMTypeKind abstract LLVMType
@reftypedef ref=LLVMValueRef enum=LLVMValueKind abstract Value
@reftypedef ref=LLVMModuleRef immutable Module end
@reftypedef ref=LLVMTargetDataRef immutable DataLayout end

include("support.jl")
include("passregistry.jl")
include("init.jl")
include("core.jl")
include("linker.jl")
include("irbuilder.jl")
include("analysis.jl")
include("moduleprovider.jl")
include("passmanager.jl")
include("execution.jl")
include("buffer.jl")
include("target.jl")
include("targetmachine.jl")
include("datalayout.jl")
include("ir.jl")
include("bitcode.jl")
include("transform.jl")

end
