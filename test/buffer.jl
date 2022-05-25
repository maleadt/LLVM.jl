@testset "buffer" begin

data = rand(UInt8, 8)

@test_throws LLVMException MemoryBufferFile("nonexisting")

let membuf = MemoryBuffer(data)
    @test pointer(data) != pointer(membuf)
    @test length(membuf) == length(data)
    @test convert(Vector{UInt8}, membuf) == data
end

let membuf = MemoryBuffer(data, "SomeBuffer", false)
    @test pointer(data) == pointer(membuf)
end

mktemp() do path, _
    membuf = MemoryBufferFile(path)
end

end
