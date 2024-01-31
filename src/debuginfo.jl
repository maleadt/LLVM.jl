## location information

export DILocation

@checked struct DILocation <: MDNode
    ref::API.LLVMMetadataRef
end
register(DILocation, API.LLVMDILocationMetadataKind)

line(location::DILocation) = Int(API.LLVMDILocationGetLine(location))
column(location::DILocation) = Int(API.LLVMDILocationGetColumn(location))

function scope(location::DILocation)
    ref = API.LLVMDILocationGetScope(location)
    ref == C_NULL ? nothing : Metadata(ref)::DIScope
end

function inlined_at(location::DILocation)
    ref = API.LLVMDILocationGetInlinedAt(location)
    ref == C_NULL ? nothing : Metadata(ref)::DILocation
end


## nodes

export DINode

abstract type DINode <: MDNode end


## variables

export DIVariable

abstract type DIVariable <: DINode end

for var in (:Local, :Global)
    var_name = Symbol("DI$(var)Variable")
    var_kind = Symbol("LLVM$(var_name)MetadataKind")
    @eval begin
        @checked struct $var_name <: DIVariable
            ref::API.LLVMMetadataRef
        end
        register($var_name, API.$var_kind)
    end
end

function file(var::DIVariable)
    ref = API.LLVMDIVariableGetFile(var)
    ref == C_NULL ? nothing : Metadata(ref)::DIFile
end

function scope(var::DIVariable)
    ref = API.LLVMDIVariableGetScope(var)
    ref == C_NULL ? nothing : Metadata(ref)::DIScope
end

line(var::DIVariable) = Int(API.LLVMDIVariableGetLine(var))


## scopes

export DIScope, DILocalScope

abstract type DIScope <: DINode end

file(scope::DIScope) = DIFile(API.LLVMDIScopeGetFile(scope))

function name(scope::DIScope)
    len = Ref{Cuint}()
    data = API.LLVMDIScopeGetName(scope, len)
    data == C_NULL && return nothing
    unsafe_string(convert(Ptr{Int8}, data), len[])
end

abstract type DILocalScope <: DIScope end


## file

export DIFile

@checked struct DIFile <: DIScope
    ref::API.LLVMMetadataRef
end
register(DIFile, API.LLVMDIFileMetadataKind)

function directory(file::DIFile)
    len = Ref{Cuint}()
    data = API.LLVMDIFileGetDirectory(file, len)
    data == C_NULL && return nothing
    unsafe_string(convert(Ptr{Int8}, data), len[])
end

function filename(file::DIFile)
    len = Ref{Cuint}()
    data = API.LLVMDIFileGetFilename(file, len)
    data == C_NULL && return nothing
    unsafe_string(convert(Ptr{Int8}, data), len[])
end

function source(file::DIFile)
    len = Ref{Cuint}()
    data = API.LLVMDIFileGetSource(file, len)
    data == C_NULL && return nothing
    unsafe_string(convert(Ptr{Int8}, data), len[])
end


## type

export DIType

abstract type DIType <: DIScope end

for typ in (:Basic, :Derived, :Composite, :Subroutine)
    typ_name = Symbol("DI$(typ)Type")
    typ_kind = Symbol("LLVM$(typ_name)MetadataKind")
    @eval begin
        @checked struct $typ_name <: DIType
            ref::API.LLVMMetadataRef
        end
        register($typ_name, API.$typ_kind)
    end
end

function name(typ::DIType)
    len = Ref{Csize_t}()
    data = API.LLVMDITypeGetName(typ, len)
    data == C_NULL && return nothing
    unsafe_string(convert(Ptr{Int8}, data), len[])
end

Base.sizeof(typ::DIType) = 8*Int(API.LLVMDITypeGetSizeInBits(typ))
offset(typ::DIType) = Int(API.LLVMDITypeGetOffsetInBits(typ))
line(typ::DIType) = Int(API.LLVMDITypeGetLine(typ))
flags(typ::DIType) = API.LLVMDITypeGetFlags(typ)


## subprogram

export DISubProgram

@checked struct DISubProgram <: DIScope
    ref::API.LLVMMetadataRef
end
register(DISubProgram, API.LLVMDISubprogramMetadataKind)

line(subprogram::DISubProgram) = Int(API.LLVMDISubprogramGetLine(subprogram))


## compile unit

export DICompileUnit

@checked struct DICompileUnit <: DIScope
    ref::API.LLVMMetadataRef
end
register(DICompileUnit, API.LLVMDICompileUnitMetadataKind)


## other

export DEBUG_METADATA_VERSION, strip_debuginfo!

DEBUG_METADATA_VERSION() = API.LLVMDebugMetadataVersion()

strip_debuginfo!(mod::Module) = API.LLVMStripModuleDebugInfo(mod)

function get_subprogram(func::Function)
    ref = API.LLVMGetSubprogram(func)
    ref==C_NULL ? nothing : Metadata(ref)::DISubProgram
end
set_subprogram!(func::Function, sp::DISubProgram) = API.LLVMSetSubprogram(func, sp)
