export @asmcall

@generated function _asmcall(::Val{asm}, ::Val{constraints}, ::Val{side_effects},
                             ::Val{rettyp}, ::Val{argtyp}, args...) where
                            {asm, constraints, side_effects, rettyp, argtyp}
    # create a function
    llvm_rettyp = convert(LLVMType, rettyp)
    llvm_argtyp = LLVMType[convert.(LLVMType, [argtyp.parameters...])...]
    llvm_f, llvm_ft = create_function(llvm_rettyp, llvm_argtyp)

    inline_asm = InlineAsm(llvm_ft, String(asm), String(constraints), side_effects)

    # generate IR
    Builder(JuliaContext()) do builder
        entry = BasicBlock(llvm_f, "entry", JuliaContext())
        position!(builder, entry)

        val = call!(builder, inline_asm, collect(parameters(llvm_f)))
        if rettyp == Nothing
            ret!(builder)
        else
            ret!(builder, val)
        end
    end

    call_function(llvm_f, rettyp, argtyp,
                  Expr(:tuple, (:(args[$i]) for i in 1:length(args))...))
end

"""
    @asmcall asm::String [constraints::String] [side_effects::Bool=false]
             rettyp=Nothing argtyp=Tuple{} args...

Call some inline assembly `asm`, optionally constrained by `constraints` and denoting other
side effects in `side_effects`, specifying the return type in `rettyp` and types of
arguments as a tuple-type in `argtyp`.
"""
:(@asmcall)

macro asmcall(asm::String, constraints::String, side_effects::Bool,
              rettyp::Union{Expr,Symbol}=:(Nothing), argtyp::Expr=:(Tuple{}), args...)
    asm_val = Val{Symbol(asm)}()
    constraints_val = Val{Symbol(constraints)}()
    return esc(:(LLVM.Interop._asmcall($asm_val, $constraints_val,
                                       Val{$side_effects}(), Val{$rettyp}(), Val{$argtyp}(),
                                       $(args...))))
end

# shorthand: no side_effects
macro asmcall(asm::String, constraints::String,
              rettyp::Union{Expr,Symbol}=:(Nothing), argtyp::Expr=:(Tuple{}), args...)
    esc(:(LLVM.Interop.@asmcall $asm $constraints false $rettyp $argtyp $(args...)))
end

# shorthand: no side_effects or constraints
macro asmcall(asm::String,
              rettyp::Union{Expr,Symbol}=:(Nothing), argtyp::Expr=:(Tuple{}), args...)
    esc(:(LLVM.Interop.@asmcall $asm "" $rettyp $argtyp $(args...)))
end
