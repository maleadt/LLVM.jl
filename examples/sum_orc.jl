# same as `sum.jl`, but using the OrcJIT to compile the code and executing it via ccall.

using Test

using LLVM

if length(ARGS) == 2
    x, y = parse.([Int32], ARGS[1:2])
else
    x = Int32(1)
    y = Int32(2)
end

function codegen!(mod::LLVM.Module, name, tm)
    param_types = [LLVM.Int32Type(), LLVM.Int32Type()]
    ret_type = LLVM.Int32Type()

    triple!(mod, triple(tm))

    ft = LLVM.FunctionType(ret_type, param_types)
    sum = LLVM.Function(mod, name, ft)

    # generate IR
    @dispose builder=IRBuilder() begin
        entry = BasicBlock(sum, "entry")
        position!(builder, entry)

        tmp = add!(builder, parameters(sum)[1], parameters(sum)[2], "tmp")
        ret!(builder, tmp)
    end

    verify(mod)

    @dispose pm=ModulePassManager() begin
        add_library_info!(pm, triple(mod))
        add_transform_info!(pm, tm)
        run!(pm, mod)
    end

    verify(mod)
end

tm = JITTargetMachine()
if LLVM.has_orc_v2()
    # XXX: LLJIT calls TargetMachineBuilder which disposes the TargetMachine
    jit = LLJIT(; tm=JITTargetMachine())

    @dispose ts_ctx=ThreadSafeContext() begin
        ts_mod = ThreadSafeModule("jit")
        name = "sum_orc.jl"
        ts_mod() do mod
            codegen!(mod, name, tm)
        end

        jd = JITDylib(jit)
        add!(jit, jd, ts_mod)
        addr = lookup(jit, name)

        @eval call_sum(x, y) = ccall($(pointer(addr)), Int32, (Int32, Int32), x, y)
    end
else
    jit = OrcJIT(tm)
    register!(jit, GDBRegistrationListener())

    @dispose ctx=Context() begin
        mod = LLVM.Module("jit")
        name = mangle(jit, "sum_orc.jl")
        codegen!(mod, name, tm)

        # For debugging:
        #   asm = String(convert(Vector{UInt8}, emit(tm, mod, LLVM.API.LLVMAssemblyFile)))
        #   write(stdout, asm)

        jitted_mod = compile!(jit, mod)

        addr = address(jit, name)
        addr2 = addressin(jit, jitted_mod, name)
        @test addr == addr2
        @test addr.ptr != 0

        # For debugging:
        #   ccall(:jl_breakpoint, Cvoid, (Any,), pointer(addr))
        # Then in GDB
        #   b *(*(uint64_t*)v)
        @eval call_sum(x, y) = ccall($(pointer(addr)), Int32, (Int32, Int32), x, y)
    end

    unregister!(jit, GDBRegistrationListener())
end

@test call_sum(x, y) == x + y
LLVM.dispose(jit)
LLVM.dispose(tm)
