export @asmcall

# we can't pass asm strings via Val (typevars need to be isbits),
# so use a global cache indexed by the hash of the source location
const asmcache = Dict{UInt, Tuple{String,String}}()

@generated function _asmcall(::Val{key}, ::Val{side_effects},
                             ::Val{rettyp}, ::Val{argtyp}, args...) where
                            {key, side_effects, rettyp, argtyp}
    asm, constraints = asmcache[key]

    # create a function
    llvm_rettyp = convert(LLVMType, rettyp)
    llvm_argtyp = LLVMType[convert.(LLVMType, [argtyp.parameters...])...]
    llvm_f, llvm_ft = create_function(llvm_rettyp, llvm_argtyp)

    inline_asm = InlineAsm(llvm_ft, asm, constraints, side_effects)

    # generate IR
    Builder(JuliaContext()) do builder
        entry = BasicBlock(llvm_f, "entry", JuliaContext())
        position!(builder, entry)

        val = call!(builder, inline_asm, collect(parameters(llvm_f)))
        if rettyp == Void
            ret!(builder)
        else
            ret!(builder, val)
        end
    end

    call_function(llvm_f, rettyp, argtyp,
                  Expr(:tuple, (:(args[$i]) for i in 1:length(args))...))
end

macro asmcall(asm::String, constraints::String, side_effects::Bool,
              rettyp::Symbol=:(Void), argtyp::Expr=:(Tuple{}), args...)
    key = hash((asm, constraints))
    asmcache[key] = (asm, constraints)
    return esc(:(LLVM.Interop._asmcall(Val{$key}(), Val{$side_effects}(),
                               Val{$rettyp}(), Val{$argtyp}(),
                               $(args...))))
end

# shorthand: no side_effects
macro asmcall(asm::String, constraints::String,
              rettyp::Symbol=:(Void), argtyp::Expr=:(Tuple{}), args...)
    esc(:(LLVM.Interop.@asmcall $asm $constraints false $rettyp $argtyp $(args...)))
end

# shorthand: no side_effects or constraints
macro asmcall(asm::String,
              rettyp::Symbol=:(Void), argtyp::Expr=:(Tuple{}), args...)
    esc(:(LLVM.Interop.@asmcall $asm "" $rettyp $argtyp $(args...)))
end
