@testset "buffer" begin

data = convert(Vector{UInt8}, "SomeData")

let
    membuf = MemoryBuffer(data)
    dispose(membuf)
end

@test_throws LLVMException MemoryBufferFile("nonexisting")

MemoryBuffer(data) do membuf
    @test pointer(data) != pointer(membuf)
    @test length(membuf) == length(data)
    @test convert(Vector{UInt8}, membuf) == data
end

MemoryBuffer(data, "SomeBuffer", false) do membuf
    @test pointer(data) == pointer(membuf)
end

mktemp() do path, _
    let
        membuf = MemoryBufferFile(path)
        dispose(membuf)
    end

    MemoryBufferFile(path) do membuf
    end
end

end
