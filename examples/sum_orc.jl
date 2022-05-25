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
    ctx = context(mod)
    param_types = [LLVM.Int32Type(ctx), LLVM.Int32Type(ctx)]
    ret_type = LLVM.Int32Type(ctx)

    triple!(mod, triple(tm))

    ft = LLVM.FunctionType(ret_type, param_types)
    sum = LLVM.Function(mod, name, ft)

    # generate IR
    @dispose builder=Builder(ctx) begin
        entry = BasicBlock(sum, "entry"; ctx)
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

JIT = nothing

if LLVM.has_orc_v2()
    lljit = LLJIT(;tm=JITTargetMachine())

    ts_mod = ThreadSafeModule("jit")
    name = "sum_orc.jl"
    tm = JITTargetMachine()
    ts_mod(m->codegen!(m, name, tm))
    dispose(tm)

    jd = JITDylib(lljit)
    add!(lljit, jd, ts_mod)
    addr = lookup(lljit, name)

    @eval call_sum(x, y) = ccall($(pointer(addr)), Int32, (Int32, Int32), x, y)

    finalizer(LLVM.dispose, lljit)
    JIT = lljit
else
    @dispose ctx=Context() begin
        # Setup jit
        tm = JITTargetMachine()

        orc = OrcJIT(tm)
        register!(orc, GDBRegistrationListener())

        mod = LLVM.Module("jit"; ctx)
        name = mangle(orc, "sum_orc.jl")
        codegen!(mod, name, tm)

        # For debugging:
        #   asm = String(convert(Vector{UInt8}, emit(tm, mod, LLVM.API.LLVMAssemblyFile)))
        #   write(stdout, asm)

        jitted_mod = compile!(orc, mod)

        addr = address(orc, name)
        addr2 = addressin(orc, jitted_mod, name)
        @test addr == addr2
        @test addr.ptr != 0

        unregister!(orc, GDBRegistrationListener())

        # For debugging:
        #   ccall(:jl_breakpoint, Cvoid, (Any,), pointer(addr))
        # Then in GDB
        #   b *(*(uint64_t*)v)
        @eval call_sum(x, y) = ccall($(pointer(addr)), Int32, (Int32, Int32), x, y)

        JIT = orc
    end
end

GC.@preserve JIT begin
    @test call_sum(x, y) == x + y
end
