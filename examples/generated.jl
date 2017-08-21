# an example using generated functions which build their own IR

using LLVM
LLVM.libllvm_system && exit() # cannot run this example if we have our own copy of LLVM

const jlctx = LLVM.Context(convert(LLVM.API.LLVMContextRef,
                                   cglobal(:jl_LLVMContext, Void)))

# pointer wrapper type for which we'll build our own low-level intrinsics
immutable CustomPtr{T}
    ptr::Ptr{T}
end

@generated function Base.unsafe_load{T}(p::CustomPtr{T}, i::Integer=1)
    # get the element type
    isboxed_ref = Ref{Bool}()
    eltyp = LLVMType(ccall(:julia_type_to_llvm, LLVM.API.LLVMTypeRef,
                           (Any, Ptr{Bool}), T, isboxed_ref))
    @assert !isboxed_ref[]

    # create a module & function
    mod = LLVM.Module("llvmcall", jlctx)
    paramtyps = [LLVM.PointerType(eltyp),
                 LLVM.IntType(sizeof(Int)*8, jlctx)]
    llvmf_typ = LLVM.FunctionType(eltyp, paramtyps)
    llvmf = LLVM.Function(mod, "unsafe_load", llvmf_typ)

    # generate IR
    Builder(jlctx) do builder
        entry = BasicBlock(llvmf, "entry", jlctx)
        position!(builder, entry)

        ptr = gep!(builder, parameters(llvmf)[1], [parameters(llvmf)[2]])
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

using Base.Test
@test unsafe_load(ptr) == a[1]
