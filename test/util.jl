function julia_cmd(cmd)
    return `
        $(Base.julia_cmd())
        --color=$(Base.have_color ? "yes" : "no")
        --compilecache=$(Bool(Base.JLOptions().use_compilecache) ? "yes" : "no")
        --history-file=no
        --startup-file=$(Base.JLOptions().startupfile != 2 ? "yes" : "no")
        --code-coverage=$(["none", "user", "all"][1+Base.JLOptions().code_coverage])
        $cmd
    `
end

macro check_ir(inst, str)
    quote
        @test contains(string($(esc(inst))), $(esc(str)))
    end
end
