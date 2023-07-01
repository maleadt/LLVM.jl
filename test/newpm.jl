@testset "newpm pass managers" begin

let mpm = NewPMModulePassManager()
    dispose(mpm)
end

NewPMModulePassManager() do mpm end

@test "NewPMModulePassManager didn't crash!" != ""

let cpm = NewPMCGSCCPassManager()
    dispose(cpm)
end

NewPMCGSCCPassManager() do cpm end

@test "NewPMCGSCCPassManager didn't crash!" != ""

let fpm = NewPMFunctionPassManager()
    dispose(fpm)
end

NewPMFunctionPassManager() do fpm end

@test "NewPMFunctionPassManager didn't crash!" != ""

let lpm = NewPMLoopPassManager()
    dispose(lpm)
end

NewPMLoopPassManager() do lpm end

@test "NewPMLoopPassManager didn't crash!" != ""

end # testset "newpm pass managers"

@testset "newpm pass builder" begin

let pic = PassInstrumentationCallbacks()
    dispose(pic)
end

PassInstrumentationCallbacks() do pic end

@test "PassInstrumentationCallbacks didn't crash!" != ""

StandardInstrumentationCallbacks() do pic end

@test "StandardInstrumentations didn't crash!" != ""

let pb = PassBuilder()
    dispose(pb)
end

PassBuilder() do pb end

host_triple = triple()
host_t = Target(triple=host_triple)

TargetMachine(host_t, host_triple) do tm
    PassBuilder(tm) do pb end

    PassInstrumentationCallbacks() do pic
        PassBuilder(tm, pic) do pb end
    end
end

@test "PassBuilder didn't crash!" != ""

end # testset "newpm pass builder"

@testset "newpm analysis managers" begin

let mpm = ModuleAnalysisManager()
    dispose(mpm)
end

ModuleAnalysisManager() do mam end

@test "ModuleAnalysisManager didn't crash!" != ""

let cam = CGSCCAnalysisManager()
    dispose(cam)
end

CGSCCAnalysisManager() do cam end

@test "CGSCCAnalysisManager didn't crash!" != ""

let fam = FunctionAnalysisManager()
    dispose(fam)
end

FunctionAnalysisManager() do fam end

@test "FunctionAnalysisManager didn't crash!" != ""

let lam = LoopAnalysisManager()
    dispose(lam)
end

LoopAnalysisManager() do lam end

@test "LoopAnalysisManager didn't crash!" != ""

end # testset "newpm analysis managers"

@testset "newpm analysis registration" begin

host_triple = triple()
host_t = Target(triple=host_triple)

@dispose tm=TargetMachine(host_t, host_triple) pic=PassInstrumentationCallbacks() pb=PassBuilder(tm, pic) begin
    analysis_managers() do lam, fam, cam, mam
        register!(pb, lam, fam, cam, mam)
    end
end

@test "Successfully registered all analysis managers!" != ""

end # testset "newpm analysis registration"

@testset "newpm passes" begin

host_triple = triple()
host_t = Target(triple=host_triple)

@dispose tm=TargetMachine(host_t, host_triple) pic=StandardInstrumentationCallbacks() pb=PassBuilder(tm, pic) begin
    analysis_managers() do lam, fam, cam, mam
        register!(pb, lam, fam, cam, mam)

        NewPMModulePassManager(pb) do mpm
            for pass in filter(is_module_pass, subtypes(NewPMLLVMPass))
                add!(mpm, pass())
            end
        end
        @test "Successfully added all module passes!" != ""

        NewPMModulePassManager(pb) do mpm
            add!(mpm, NewPMCGSCCPassManager) do cgpm
                for pass in filter(is_cgscc_pass, subtypes(NewPMLLVMPass))
                    add!(cgpm, pass())
                end
            end
        end

        @test "Successfully added all CGSCC passes!" != ""

        NewPMModulePassManager(pb) do mpm
            add!(mpm, NewPMFunctionPassManager) do fpm
                for pass in filter(is_function_pass, subtypes(NewPMLLVMPass))
                    add!(fpm, pass())
                end
            end
        end

        @test "Successfully added all function passes!" != ""

        NewPMModulePassManager(pb) do mpm
            add!(mpm, NewPMFunctionPassManager) do fpm
                add!(fpm, NewPMLoopPassManager) do lpm
                    for pass in filter(is_loop_pass, subtypes(NewPMLLVMPass))
                        add!(lpm, pass())
                    end
                end
            end
        end

        @test "Successfully added all loop passes!" != ""
    end
end

end # testset "newpm passes"

@testset "newpm custom passes" begin

host_triple = triple()
host_t = Target(triple=host_triple)

@dispose tm=TargetMachine(host_t, host_triple) pic=StandardInstrumentationCallbacks() pb=PassBuilder(tm, pic) begin
    analysis_managers() do lam, fam, cam, mam
        register!(pb, lam, fam, cam, mam)

        observed_modules = 0
        observed_functions = 0

        NewPMModulePassManager(pb) do mpm
            add!(mpm) do mod, mam
                observed_modules += 1
                all_analyses_preserved()
            end
            add!(mpm, NewPMFunctionPassManager) do fpm
                add!(fpm) do fun, fam
                    observed_functions += 1
                    all_analyses_preserved()
                end
            end

            @test "Successfully added custom module and function passes!" != ""
    
            @dispose ctx=Context() builder=IRBuilder() mod=LLVM.Module("test") begin
                pa = run!(mpm, mod, mam)
                @test observed_modules == 1
                @test observed_functions == 0
                @test are_all_preserved(pa)
    
                
                ft = LLVM.FunctionType(LLVM.VoidType())
                fn = LLVM.Function(mod, "SomeFunction", ft)
    
                entry = BasicBlock(fn, "entry")
                position!(builder, entry)
    
                ret!(builder)
    
                pa = run!(mpm, mod, mam)
                @test observed_modules == 2
                @test observed_functions == 1
                @test are_all_preserved(pa)
            end
        end
    end
end

end # testset "newpm custom passes"
