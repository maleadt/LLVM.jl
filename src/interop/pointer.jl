# pointer intrinsics

# TODO: can we use constant propagation instead of passing the alignment as a Val?

using Core: LLVMPtr

function tbaa_make_child(name::String, constant::Bool=false; ctx::LLVM.Context=JuliaContext())
    tbaa_root = MDNode([MDString("custom_tbaa", ctx)], ctx)
    tbaa_struct_type =
        MDNode([MDString("custom_tbaa_$name", ctx),
                tbaa_root,
                LLVM.ConstantInt(0, ctx)], ctx)
    tbaa_access_tag =
        MDNode([tbaa_struct_type,
                tbaa_struct_type,
                LLVM.ConstantInt(0, ctx),
                LLVM.ConstantInt(constant ? 1 : 0, ctx)], ctx)

    return tbaa_access_tag
end

tbaa_addrspace(as) = tbaa_make_child("addrspace($(as))")

@generated function pointerref(ptr::LLVMPtr{T,A}, i::Int, ::Val{align}) where {T,A,align}
    sizeof(T) == 0 && return T.instance
    eltyp = convert(LLVMType, T)

    T_int = convert(LLVMType, Int)
    T_ptr = convert(LLVMType, ptr)

    T_typed_ptr = LLVM.PointerType(eltyp, A)

    # create a function
    param_types = [T_ptr, T_int]
    llvm_f, _ = create_function(eltyp, param_types)

    # generate IR
    Builder(JuliaContext()) do builder
        entry = BasicBlock(llvm_f, "entry", JuliaContext())
        position!(builder, entry)

        typed_ptr = bitcast!(builder, parameters(llvm_f)[1], T_typed_ptr)
        typed_ptr = gep!(builder, typed_ptr, [parameters(llvm_f)[2]])
        ld = load!(builder, typed_ptr)

        if A != 0
            metadata(ld)[LLVM.MD_tbaa] = tbaa_addrspace(A)
        end
        alignment!(ld, align)

        ret!(builder, ld)
    end

    call_function(llvm_f, T, Tuple{LLVMPtr{T,A}, Int}, :((ptr, Int(i-one(i)))))
end

@generated function pointerset(ptr::LLVMPtr{T,A}, x::T, i::Int, ::Val{align}) where {T,A,align}
    sizeof(T) == 0 && return
    eltyp = convert(LLVMType, T)

    T_int = convert(LLVMType, Int)
    T_ptr = convert(LLVMType, ptr)

    T_typed_ptr = LLVM.PointerType(eltyp, A)

    # create a function
    param_types = [T_ptr, eltyp, T_int]
    llvm_f, _ = create_function(LLVM.VoidType(JuliaContext()), param_types)

    # generate IR
    Builder(JuliaContext()) do builder
        entry = BasicBlock(llvm_f, "entry", JuliaContext())
        position!(builder, entry)

        typed_ptr = bitcast!(builder, parameters(llvm_f)[1], T_typed_ptr)
        typed_ptr = gep!(builder, typed_ptr, [parameters(llvm_f)[3]])
        val = parameters(llvm_f)[2]
        st = store!(builder, val, typed_ptr)

        if A != 0
            metadata(st)[LLVM.MD_tbaa] = tbaa_addrspace(A)
        end
        alignment!(st, align)

        ret!(builder)
    end

    call_function(llvm_f, Cvoid, Tuple{LLVMPtr{T,A}, T, Int},
                  :((ptr, convert(T,x), Int(i-one(i)))))
end

Base.unsafe_load(ptr::Core.LLVMPtr, i::Integer=1, align::Val=Val(1)) =
    pointerref(ptr, Int(i), align)

Base.unsafe_store!(ptr::Core.LLVMPtr{T}, x, i::Integer=1, align::Val=Val(1)) where {T} =
    pointerset(ptr, convert(T, x), Int(i), align)
