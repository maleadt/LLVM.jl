@testset "support" begin

@testset "command-line options" begin

code = """
    using LLVM
    LLVM.clopts("-version")
"""

out = Pipe()
cmd = Base.julia_cmd()
if Base.JLOptions().project != C_NULL
    cmd = `$cmd --project=$(unsafe_string(Base.JLOptions().project))`
end
run(pipeline(`$cmd -e $code`, stdout=out, stderr=out))
close(out.in)

@test occursin("LLVM (http://llvm.org/)", read(out, String))

end

end
