export DIBuilder, DICompileUnit, DILexicalBlock, DIFunction

@checked struct DIBuilder
    ref::API.LLVMDIBuilderRef
end
reftype(::Type{DIBuilder}) = API.DILLVMDIBuilderRef

# LLVMCreateDIBuilderDisallowUnresolved
DIBuilder(mod::Module) = DIBuilder(API.LLVMCreateDIBuilder(ref(mod)))

dispose(builder::DIBuilder) = API.LLVMDisposeDIBuilder(ref(builder))
finalize(builder::DIBuilder) = API.LLVMDIBuilderFinalize(ref(builder))

struct DICompileUnit
    file::String
    dir::String
    language::API.LLVMDWARFSourceLanguage
    producer::String
    flags::String
    optimized::Core.Bool
    version::Int
end

function compileunit!(builder::DIBuilder, cu::DICompileUnit)
    file = file!(builder, cu.file, cu.dir)
    md = API.LLVMDIBuilderCreateCompileUnit(
        ref(builder),
        cu.language,
        ref(file),
        cu.producer, convert(Csize_t, length(cu.producer)),
        cu.optimized ? LLVM.True : LLVM.False,
        cu.flags, convert(Csize_t, length(cu.flags)),
        convert(Cuint, cu.version),
        #=SplitName=# C_NULL, 0,
        API.LLVMDWARFEmissionFull,
        #=DWOId=# 0,
        #=SplitDebugInlining=# LLVM.True,
        #=DebugInfoForProfiling=# LLVM.False,
    )
    return Metadata(md)
end

function file!(builder::DIBuilder, filename, directory)
    md = API.LLVMDIBuilderCreateFile(
        ref(builder),
        filename, convert(Csize_t, length(filename)),
        directory, convert(Csize_t, length(directory))
    )
    return Metadata(md)
end

struct DILexicalBlock
    file::Metadata
    line::Int
    column::Int
end

function lexicalblock!(builder::DIBuilder, scope::Metadata, block::DILexicalBlock)
    md = API.LLVMDIBuilerCreateLexicalBlock(
        ref(builder),
        ref(scope),
        ref(block.file),
        convert(Cuint, block.line),
        convert(Cuint, block.column)
    )
    Metadata(md)
end

function lexicalblock!(builder::DIBuilder, scope::Metadata, file::Metadata, discriminator)
    md = API.LLVMDIBuilderCreateLexicalBlockFile(
        ref(builder),
        ref(scope),
        ref(file),
        convert(Cuint, discriminator)
    )
    Metadata(md)
end

struct DIFunction
    name::String
    linkageName::String
    file::Metadata
    line::Int
    type::Metadata
    localToUnit::Core.Bool
    isDefinition::Core.Bool
    scopeLine::Int
    flags::LLVM.API.LLVMDIFlags
    optimized::Core.Bool
end

function subprogram!(builder::DIBuilder, scope::Metadata, f::DIFunction)
    md = API.LLVMDIBuilderCreateFunction(
        ref(builder),
        ref(scope),
        f.name, convert(Csize_t, length(f.name)),
        f.linkageName, convert(Csize_t, length(f.linkageName)),
        ref(f.file),
        f.line,
        ref(f.type),
        f.localToUnit ? LLVM.True : LLVM.False,
        f.isDefinition ? LLVM.True : LLVM.False,
        convert(Cuint, f.scopeLine),
        f.flags,
        f.optimized ? LLVM.True : LLVM.False
    )
    Metadata(md)
end

# TODO: Variables

function basictype!(builder::DIBuilder, name, size, encoding)
    md = LLVM.API.LLVMDIBuilderCreateBasicType(
        ref(builder),
        name,
        convert(Csize_t, length(name)),
        convert(UInt64, size),
        encoding,
        LLVM.API.LLVMDIFlagZero
    )
    Metadata(md)
end

function pointertype!(builder::DIBuilder, pointee::Metadata, size, as, align=0, name="")
    md = LLVM.API.LLVMDIBuilderCreatePointerType(
        ref(builder),
        ref(pointee),
        convert(UInt64, size),
        convert(UInt32, align),
        convert(Cuint, as),
        name,
        convert(Csize_t, length(name)),
    )
    Metadata(md)
end

function subroutinetype!(builder::DIBuilder, file::Metadata, rettype, paramtypes...)
    params = collect(ref(x) for x in (rettype, paramtypes...))
    md = LLVM.API.LLVMDIBuilderCreateSubroutineType(
        ref(builder),
        ref(file),
        params,
        length(params),
        LLVM.API.LLVMDIFlagZero
    )
    Metadata(md)
end

# TODO: Types
