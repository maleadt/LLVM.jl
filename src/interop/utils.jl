export tbaa_make_child, tbaa_addrspace

function tbaa_make_child(name::String; constant::Bool=false)
    tbaa_root = MDNode([MDString("custom_tbaa")])
    tbaa_struct_type =
        MDNode([MDString("custom_tbaa_$name"),
                tbaa_root,
                ConstantInt(0)])
    tbaa_access_tag =
        MDNode([tbaa_struct_type,
                tbaa_struct_type,
                ConstantInt(0),
                ConstantInt(constant ? 1 : 0)])

    return tbaa_access_tag
end

tbaa_addrspace(as) = tbaa_make_child("addrspace($(as))")
