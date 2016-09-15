let
    membuf = MemoryBuffer("SomeContents", "SomeBuffer")
    dispose(membuf)
end

@test_throws LLVMException MemoryBufferFile("nonexisting")

MemoryBuffer("SomeContents", "SomeBuffer") do membuf
    @test length(membuf) == length("SomeContents")
    @test String(convert(Vector{UInt8}, membuf)) == "SomeContents"
end

mktemp() do path, _
    let
        membuf = MemoryBufferFile(path)
        dispose(membuf)
    end

    MemoryBufferFile(path) do membuf
    end
end
