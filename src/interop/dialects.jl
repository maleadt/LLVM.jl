# interfacing with the Julia dialect of LLVM IR
#
# The Julia compiler emits IR containing target-specific pseudo-intrinsics (GC frame
# management, allocation, safepoints, ...) that are specified as a dialect of LLVM IR and
# lowered by Julia's custom pipeline. The functionality in this file wraps the C API
# exported by libjulia-codegen for creating and verifying such IR.
#
# Julia IR uses the following address spaces:
# - 10: Tracked      (pointers to GC-managed objects)
# - 11: Derived      (pointers derived from a tracked pointer)
# - 12: CalleeRooted (pointers rooted by the callee)
# - 13: Loaded       (interior pointers associated with a GC base object)

import ..LLVM: @checked, refcheck, mark_alloc, mark_use, mark_dispose, unsafe_message
import ..LLVM: dispose

export has_julia_dialects, JuliaDialectContext, verify_dialects, gc_alloc_bytes_size_type,
       get_pgcstack!, get_pgcstack_or_new!, gc_loaded!, new_gc_frame!, push_gc_frame!,
       pop_gc_frame!, get_gc_frame_slot!, gc_alloc_bytes!, queue_gc_root!, safepoint!

"""
    has_julia_dialects() -> Bool

Check whether the running Julia session exports the Julia dialect C API, i.e., whether
the functionality in this file is available.
"""
function has_julia_dialects()
    cached = _julia_dialects[]
    cached === nothing || return cached::Bool
    available = try
        cglobal(:JLDialectsAttachContext) != C_NULL
    catch
        false
    end
    _julia_dialects[] = available
    return available
end
const _julia_dialects = Ref{Union{Nothing,Bool}}(nothing)

function check_julia_dialects()
    has_julia_dialects() ||
        throw(ErrorException("This version of Julia does not export the Julia dialect C API. Use a newer version of Julia, or check `has_julia_dialects()` before calling this functionality."))
    return
end


## dialect context

"""
    JuliaDialectContext(ctx::Context=context())

Attach the Julia dialects to the LLVM context `ctx`, enabling the use of the builder
functions and [`verify_dialects`](@ref) with modules in that context.

This object needs to be disposed of using [`dispose`](@ref), before the underlying
LLVM context is.
"""
@checked struct JuliaDialectContext
    ref::API.JLDialectContextRef
end

Base.unsafe_convert(::Type{API.JLDialectContextRef}, dialect_ctx::JuliaDialectContext) =
    mark_use(dialect_ctx).ref

function JuliaDialectContext(ctx::Context)
    check_julia_dialects()
    dialect_ctx = JuliaDialectContext(API.JLDialectsAttachContext(ctx))
    mark_alloc(dialect_ctx)
end

function JuliaDialectContext()
    # check availability before querying the active context, for a better error message
    check_julia_dialects()
    JuliaDialectContext(context())
end

function JuliaDialectContext(f::Core.Function, args...; kwargs...)
    dialect_ctx = JuliaDialectContext(args...; kwargs...)
    try
        f(dialect_ctx)
    finally
        dispose(dialect_ctx)
    end
end

dispose(dialect_ctx::JuliaDialectContext) =
    mark_dispose(API.JLDialectsDisposeContext, dialect_ctx)


## queries

"""
    verify_dialects(mod::Module)

Verify that the Julia dialect operations in `mod` are well-formed, in addition to running
the regular LLVM module verifier. If verification fails, an [`LLVMException`](@ref) is
thrown containing the verifier diagnostics.
"""
function verify_dialects(mod::LLVM.Module)
    check_julia_dialects()
    out_error = Ref{Cstring}()
    status = API.JLDialectsVerifyModule(mod, out_error) |> Bool
    error = unsafe_message(out_error[])

    if status
        throw(LLVMException(error))
    end
    return
end

"""
    gc_alloc_bytes_size_type(mod::Module) -> LLVMType

Return the integer type expected for the size and type-tag arguments of
`julia.gc_alloc_bytes` (see [`gc_alloc_bytes!`](@ref)), i.e., the pointer-sized integer
type according to the data layout of `mod`.
"""
function gc_alloc_bytes_size_type(mod::LLVM.Module)
    check_julia_dialects()
    LLVMType(API.JLDialectsGCAllocBytesSizeType(mod))
end


## builders

"""
    get_pgcstack!(builder::IRBuilder)

Create a `julia.get_pgcstack` operation, returning the current task's GC stack pointer.
"""
function get_pgcstack!(builder::IRBuilder)
    check_julia_dialects()
    Instruction(API.JLBuildGetPGCStack(builder))
end

"""
    get_pgcstack_or_new!(builder::IRBuilder)

Create a `julia.get_pgcstack_or_new` operation, returning the current task's GC stack
pointer, adopting the thread into the Julia runtime if needed.
"""
function get_pgcstack_or_new!(builder::IRBuilder)
    check_julia_dialects()
    Instruction(API.JLBuildGetPGCStackOrNew(builder))
end

"""
    gc_loaded!(builder::IRBuilder, base::Value, tracked::Value)

Create a `julia.gc_loaded` operation, associating the interior pointer `tracked` with the
GC-managed object `base` and returning it in the `Loaded` address space.
"""
function gc_loaded!(builder::IRBuilder, base::Value, tracked::Value)
    check_julia_dialects()
    Instruction(API.JLBuildGCLoaded(builder, base, tracked))
end

"""
    new_gc_frame!(builder::IRBuilder, size::Value)

Create a `julia.new_gc_frame` operation, allocating a new GC frame with `size` root slots.
"""
function new_gc_frame!(builder::IRBuilder, size::Value)
    check_julia_dialects()
    Instruction(API.JLBuildNewGCFrame(builder, size))
end

"""
    push_gc_frame!(builder::IRBuilder, frame::Value, size::Value)

Create a `julia.push_gc_frame` operation, registering the GC frame `frame` with `size`
root slots with the runtime.
"""
function push_gc_frame!(builder::IRBuilder, frame::Value, size::Value)
    check_julia_dialects()
    Instruction(API.JLBuildPushGCFrame(builder, frame, size))
end

"""
    pop_gc_frame!(builder::IRBuilder, frame::Value)

Create a `julia.pop_gc_frame` operation, unregistering the GC frame `frame`.
"""
function pop_gc_frame!(builder::IRBuilder, frame::Value)
    check_julia_dialects()
    Instruction(API.JLBuildPopGCFrame(builder, frame))
end

"""
    get_gc_frame_slot!(builder::IRBuilder, frame::Value, index::Value)

Create a `julia.get_gc_frame_slot` operation, returning the address of root slot `index`
in the GC frame `frame`.
"""
function get_gc_frame_slot!(builder::IRBuilder, frame::Value, index::Value)
    check_julia_dialects()
    Instruction(API.JLBuildGetGCFrameSlot(builder, frame, index))
end

"""
    gc_alloc_bytes!(builder::IRBuilder, ptls::Value, size::Value, type::Value)

Create a `julia.gc_alloc_bytes` operation, allocating a GC-managed object of `size` bytes
with type tag `type`. The `size` and `type` arguments are expected to be of the integer
type returned by [`gc_alloc_bytes_size_type`](@ref).
"""
function gc_alloc_bytes!(builder::IRBuilder, ptls::Value, size::Value, type::Value)
    check_julia_dialects()
    Instruction(API.JLBuildGCAllocBytes(builder, ptls, size, type))
end

"""
    queue_gc_root!(builder::IRBuilder, root::Value)

Create a `julia.queue_gc_root` operation, re-queueing the old object `root` for GC
scanning (write barrier slow path).
"""
function queue_gc_root!(builder::IRBuilder, root::Value)
    check_julia_dialects()
    Instruction(API.JLBuildQueueGCRoot(builder, root))
end

"""
    safepoint!(builder::IRBuilder, signal_page::Value)

Create a `julia.safepoint` operation, loading from the GC signal page `signal_page` to
allow stopping the world at this point.
"""
function safepoint!(builder::IRBuilder, signal_page::Value)
    check_julia_dialects()
    Instruction(API.JLBuildSafepoint(builder, signal_page))
end
