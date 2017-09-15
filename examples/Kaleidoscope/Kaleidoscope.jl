module Kaleidoscope

import LLVM

include("lexer.jl")
include("ast.jl")
include("scope.jl")
include("codegen.jl")
include("run.jl")
include("utilities.jl")

end # module
