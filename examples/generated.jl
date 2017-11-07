# an example using generated functions which build their own IR

using LLVM
LLVM.libllvm_system && exit() # cannot run this example if we have our own copy of LLVM

const jlctx = LLVM.Context(convert(LLVM.API.LLVMContextRef,
                                   cglobal(:jl_LLVMContext, Void)))

# pointer wrapper type for which we'll build our own low-level intrinsics
struct CustomPtr{T}
    ptr::Ptr{T}
end

@generated function Base.unsafe_load(p::CustomPtr{T}, i::Integer=1) where T
    # get the element type
    isboxed_ref = Ref{Bool}()
    eltyp = LLVMType(ccall(:julia_type_to_llvm, LLVM.API.LLVMTypeRef,
                           (Any, Ptr{Bool}), T, isboxed_ref))
    @assert !isboxed_ref[]

    T_int = LLVM.IntType(sizeof(Int)*8, jlctx)
    T_ptr = LLVM.PointerType(eltyp)

    # create a module & function
    mod = LLVM.Module("llvmcall", jlctx)
    if VERSION >= v"0.7.0-DEV.1704"
        paramtyps = [T_int, T_int]
    else
        paramtyps = [T_ptr, T_int]
    end
    llvmf_typ = LLVM.FunctionType(eltyp, paramtyps)
    llvmf = LLVM.Function(mod, "unsafe_load", llvmf_typ)

    # generate IR
    Builder(jlctx) do builder
        entry = BasicBlock(llvmf, "entry", jlctx)
        position!(builder, entry)

        if VERSION >= v"0.7.0-DEV.1704"
            ptr = inttoptr!(builder, parameters(llvmf)[1], T_ptr)
        else
            ptr = parameters(llvmf)[1]
        end

        ptr = gep!(builder, ptr, [parameters(llvmf)[2]])
        val = load!(builder, ptr)
        ret!(builder, val)
    end

    # call
    push!(function_attributes(llvmf), EnumAttribute("alwaysinline"))
    quote
        Base.@_inline_meta
        Base.llvmcall(LLVM.ref($llvmf), $T, Tuple{Ptr{$T}, Int}, p.ptr, Int(i-1))
    end
end

a = [42]
ptr = CustomPtr{Int}(pointer(a))

using Compat
using Compat.Test

@test unsafe_load(ptr) == a[1]
