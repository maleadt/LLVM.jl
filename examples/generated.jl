# an example using generated functions which build their own IR

using LLVM
using LLVM.Interop

# pointer wrapper type for which we'll build our own low-level intrinsics
struct CustomPtr{T}
    ptr::Ptr{T}
end

@generated function Base.unsafe_load(p::CustomPtr{T}, i::Integer=1) where T
    JuliaContext() do ctx
        # get the element type
        eltyp = convert(LLVMType, T, ctx)

        T_int = LLVM.IntType(sizeof(Int)*8, ctx)
        T_ptr = LLVM.PointerType(eltyp)

        # create a function
        if VERSION >= v"0.7.0-DEV.1704"
            paramtyps = [T_int, T_int]
        else
            paramtyps = [T_ptr, T_int]
        end
        llvmf, _ = create_function(eltyp, paramtyps)

        # generate IR
        Builder(ctx) do builder
            entry = BasicBlock(llvmf, "entry", ctx)
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

        call_function(llvmf, T, Tuple{Ptr{T}, Int}, :(p.ptr, Int(i-1)))
    end
end

a = [42]
ptr = CustomPtr{Int}(pointer(a))

using Test

@test unsafe_load(ptr) == a[1]
