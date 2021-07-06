export tbaa_make_child, tbaa_addrspace

function tbaa_make_child(name::String; constant::Bool=false, ctx::LLVM.Context)
    tbaa_root = MDNode([MDString("custom_tbaa"; ctx)]; ctx)
    tbaa_struct_type =
        MDNode([MDString("custom_tbaa_$name"; ctx),
                tbaa_root,
                ConstantInt(0; ctx)]; ctx)
    tbaa_access_tag =
        MDNode([tbaa_struct_type,
                tbaa_struct_type,
                ConstantInt(0; ctx),
                ConstantInt(constant ? 1 : 0; ctx)]; ctx)

    return tbaa_access_tag
end

tbaa_addrspace(as; ctx::LLVM.Context) = tbaa_make_child("addrspace($(as))"; ctx)
