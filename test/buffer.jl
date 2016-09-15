let
    membuf = MemoryBuffer("SomeContents", "SomeBuffer")
    dispose(membuf)
end

@test_throws LLVMException MemoryBufferFile("nonexisting")

MemoryBuffer("SomeContents", "SomeBuffer") do membuf
    @test size(membuf) == length("SomeContents")
    @test unsafe_string(start(membuf)) == "SomeContents"
end

mktemp() do path, _
    let
        membuf = MemoryBufferFile(path)
        dispose(membuf)
    end

    MemoryBufferFile(path) do membuf
    end
end