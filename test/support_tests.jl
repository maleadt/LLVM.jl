@testitem "support" begin

@testset "command-line options" begin

code = """
    using LLVM
    LLVM.clopts("-version")
"""

out = Pipe()
cmd = `$(Base.julia_cmd()) --project=$(Base.active_project())`
run(pipeline(`$cmd -e $code`, stdout=out, stderr=out))
close(out.in)

@test occursin("LLVM (http://llvm.org/)", read(out, String))

end

end
