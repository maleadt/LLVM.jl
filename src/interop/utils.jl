export tbaa_make_child, tbaa_addrspace

function tbaa_make_child(name::String, ctx::LLVM.Context=Context(); constant::Bool=false)
    tbaa_root = MDNode([MDString("custom_tbaa", ctx)], ctx)
    tbaa_struct_type =
        MDNode(Metadata[MDString("custom_tbaa_$name", ctx),
                        tbaa_root,
                        Metadata(ConstantInt(0, ctx))], ctx)
    tbaa_access_tag =
        MDNode(Metadata[tbaa_struct_type,
                        tbaa_struct_type,
                        Metadata(ConstantInt(0, ctx)),
                        Metadata(ConstantInt(constant ? 1 : 0, ctx))], ctx)

    return tbaa_access_tag
end

tbaa_addrspace(as, ctx::LLVM.Context=Context()) = tbaa_make_child("addrspace($(as))", ctx)
