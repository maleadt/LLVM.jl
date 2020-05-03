macro check_ir(inst, str)
    quote
        @test occursin($(esc(str)), string($(esc(inst))))
    end
end
