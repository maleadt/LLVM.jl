@testset "utils" begin

@testset "cloning" begin
    @dispose ctx=Context() begin
        # set-up
        mod = LLVM.Module("my_module"; ctx)

        param_types = [LLVM.Int32Type(ctx), LLVM.Int32Type(ctx)]
        ret_type = LLVM.Int32Type(ctx)
        fun_type = LLVM.FunctionType(ret_type, param_types)
        f = LLVM.Function(mod, "f", fun_type)

        # generate IR
        @dispose builder=Builder(ctx) begin
            entry = BasicBlock(f, "entry"; ctx)
            position!(builder, entry)
            ptr = const_inttoptr(
                ConstantInt(0xdeadbeef%UInt; ctx),
                LLVM.PointerType(LLVM.Int32Type(ctx)))
            tmp = add!(builder, parameters(f)[1], parameters(f)[2], "tmp")
            tmp2 = load!(builder, LLVM.Int32Type(ctx), ptr)
            tmp3 = add!(builder, tmp, tmp2)
            ret!(builder, tmp3)

            verify(mod)
        end

        # basic clone
        let new_f = clone(f)
            @test new_f != f
            @test llvmtype(new_f) == llvmtype(f)
            for (bb1, bb2) in zip(blocks(f), blocks(new_f))
                for (inst1, inst2) in zip(instructions(bb2), instructions(bb2))
                    @test inst1 == inst2
                end
            end
        end

        # clone into, testing the value mapper (adding an argument)
        let
            new_param_types = [LLVM.Int32Type(ctx), LLVM.Int32Type(ctx), LLVM.Int32Type(ctx)]
            new_fun_type = LLVM.FunctionType(ret_type, new_param_types)
            new_f = LLVM.Function(mod, "new", new_fun_type)

            value_map = Dict{LLVM.Value, LLVM.Value}(
                parameters(f)[1] => parameters(new_f)[2],
                parameters(f)[2] => parameters(new_f)[3]
            )
            clone_into!(new_f, f; value_map)

            # operands of the add instruction should have been remapped
            add = first(instructions(first(blocks(new_f))))
            @test operands(add)[1] == parameters(new_f)[2]
            @test operands(add)[2] == parameters(new_f)[3]
        end

        # clone into, testing the type remapper (changing precision)
        let
            new_param_types = [LLVM.Int64Type(ctx), LLVM.Int64Type(ctx)]
            new_ret_type = LLVM.Int64Type(ctx)
            new_fun_type = LLVM.FunctionType(new_ret_type, new_param_types)
            new_f = LLVM.Function(mod, "new", new_fun_type)

            # we always need to map all arguments
            value_map = Dict{LLVM.Value, LLVM.Value}(
                old_param => new_param for (old_param, new_param) in
                                            zip(parameters(f), parameters(new_f)))

            function type_mapper(typ)
                if typ == LLVM.Int32Type(ctx)
                    LLVM.Int64Type(ctx)
                else
                    typ
                end
            end
            function materializer(val)
                if val isa Union{LLVM.ConstantExpr, ConstantInt}
                    # test that we can return nothing
                    return nothing
                end
                # not needed here
                error("")
            end
            clone_into!(new_f, f; value_map, type_mapper, materializer)

            # the add should now be a 64-bit addition
            add = first(instructions(first(blocks(new_f))))
            @test llvmtype(operands(add)[1]) == LLVM.Int64Type(ctx)
            @test llvmtype(operands(add)[2]) == LLVM.Int64Type(ctx)
            @test llvmtype(add) == LLVM.Int64Type(ctx)
        end
    end
end

end
