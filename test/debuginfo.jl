@testset "debuginfo" begin

DEBUG_METADATA_VERSION()

Context() do ctx
    mod = parse(LLVM.Module,  """
        define void @fun() !dbg !5 {
        top:
          ret void, !dbg !7
        }

        !llvm.module.flags = !{!0, !1}
        !llvm.dbg.cu = !{!2}

        !0 = !{i32 2, !"Dwarf Version", i32 4}
        !1 = !{i32 1, !"Debug Info Version", i32 3}
        !2 = distinct !DICompileUnit(language: DW_LANG_C89, file: !3, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4)
        !3 = !DIFile(filename: "REPL[1]", directory: ".")
        !4 = !{}
        !5 = distinct !DISubprogram(name: "foo", linkageName: "fun", scope: null, file: !3, line: 1, type: !6, isLocal: false, isDefinition: true, scopeLine: 1, isOptimized: true, unit: !2, variables: !4)
        !6 = !DISubroutineType(types: !4)
        !7 = !DILocation(line: 1, scope: !5)""", ctx)

    fun = functions(mod)["fun"]
    bb = entry(fun)
    inst = first(instructions(bb))

    @test !isempty(metadata(inst))
    strip_debuginfo!(mod)
    @test isempty(metadata(inst))
end

end
