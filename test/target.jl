@testset "target" begin
    @test_throws LLVMException Target("invalid")

    host_triple = triple()
    host_t = Target(host_triple)

    host_name = name(host_t)
    description(host_t)

    @test hasjit(host_t)
    @test hastargetmachine(host_t)
    @test hasasmparser(host_t)

    # target iteration
    let ts = targets()
        @test haskey(ts, host_name)
        @test get(ts, host_name) == host_t

        @test !haskey(ts, "invalid")
        @test_throws KeyError get(ts, "invalid")

        @test eltype(ts) == Target

        first(ts)

        for t in ts
            # ...
        end

        @test any(t -> t == host_t, collect(ts))
    end
end
