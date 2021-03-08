export DIBuilder, DIFile, DICompileUnit, DILexicalBlock, DIFunction

@checked struct DIBuilder
    ref::API.LLVMDIBuilderRef
end

# LLVMCreateDIBuilderDisallowUnresolved
DIBuilder(mod::Module) = DIBuilder(API.LLVMCreateDIBuilder(mod))

dispose(builder::DIBuilder) = API.LLVMDisposeDIBuilder(builder)
finalize(builder::DIBuilder) = API.LLVMDIBuilderFinalize(builder)

Base.unsafe_convert(::Type{API.LLVMDIBuilderRef}, builder::DIBuilder) = builder.ref

struct DIFile
    file::String
    dir::String
end

struct DICompileUnit
    file::Metadata
    language::API.LLVMDWARFSourceLanguage
    producer::String
    sysroot::String
    sdk::String
    flags::String
    optimized::Core.Bool
    version::Int
end

function compileunit!(builder::DIBuilder, cu::DICompileUnit)
    md = API.LLVMDIBuilderCreateCompileUnit(
        builder,
        cu.language,
        cu.file,
        cu.producer, convert(Csize_t, length(cu.producer)),
        cu.optimized ? LLVM.True : LLVM.False,
        cu.flags, convert(Csize_t, length(cu.flags)),
        convert(Cuint, cu.version),
        #=SplitName=# C_NULL, 0,
        API.LLVMDWARFEmissionFull,
        #=DWOId=# 0,
        #=SplitDebugInlining=# LLVM.True,
        #=DebugInfoForProfiling=# LLVM.False,
        cu.sysroot, convert(Csize_t, length(cu.sysroot)),
        cu.sdk, convert(Csize_t, length(cu.sdk)),
    )
    return Metadata(md)
end

function file!(builder::DIBuilder, file::DIFile)
    md = API.LLVMDIBuilderCreateFile(
        builder,
        file.file, convert(Csize_t, length(file.file)),
        file.dir, convert(Csize_t, length(file.dir))
    )
    return Metadata(md)
end

struct DILexicalBlock
    file::Metadata
    line::Int
    column::Int
end

function lexicalblock!(builder::DIBuilder, scope::Metadata, block::DILexicalBlock)
    md = API.LLVMDIBuilderCreateLexicalBlock(
        builder,
        scope,
        block.file,
        convert(Cuint, block.line),
        convert(Cuint, block.column)
    )
    Metadata(md)
end

function lexicalblock!(builder::DIBuilder, scope::Metadata, file::Metadata, discriminator)
    md = API.LLVMDIBuilderCreateLexicalBlockFile(
        builder,
        scope,
        file,
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
        builder,
        scope,
        f.name, convert(Csize_t, length(f.name)),
        f.linkageName, convert(Csize_t, length(f.linkageName)),
        f.file,
        f.line,
        f.type,
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
        builder,
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
        builder,
        pointee,
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
        builder,
        file,
        params,
        length(params),
        LLVM.API.LLVMDIFlagZero
    )
    Metadata(md)
end

# TODO: Types
