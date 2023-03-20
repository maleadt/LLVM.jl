macro check_ir(inst, str)
    quote
        inst = string($(esc(inst)))
        @test occursin($(str), inst)
    end
end

const supports_typed_ptrs = begin
    @dispose ctx=Context() begin
        LLVM.supports_typed_pointers(ctx)
    end
end