module Kaleidoscope

using Unicode
import LLVM

include("lexer.jl")
include("ast.jl")
include("scope.jl")
include("codegen.jl")
include("run.jl")

end # module
