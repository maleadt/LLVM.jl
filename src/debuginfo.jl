## location information

export DILocation

@checked struct DILocation <: MDNode
    ref::API.LLVMMetadataRef
end
identify(::Type{Metadata}, ::Val{API.LLVMDILocationMetadataKind}) = DILocation

function Base.getproperty(location::DILocation, property::Symbol)
    if property == :line
        Int(API.LLVMDILocationGetLine(location))
    elseif property == :column
        Int(API.LLVMDILocationGetColumn(location))
    elseif property === :scope
        ref = API.LLVMDILocationGetScope(location)
        ref == C_NULL ? nothing : Metadata(ref)::DIScope
    elseif property === :inlined_at
        ref = API.LLVMDILocationGetInlinedAt(location)
        ref == C_NULL ? nothing : Metadata(ref)::DIScope
    else
        getfield(location, property)
    end
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
        identify(::Type{Metadata}, ::Val{API.$var_kind}) = $var_name
    end
end

function Base.getproperty(var::DIVariable, property::Symbol)
    if property == :file
        ref = API.LLVMDIVariableGetFile(var)
        ref == C_NULL ? nothing : Metadata(ref)::DIFile
    elseif property === :scope
        ref = API.LLVMDIVariableGetScope(var)
        ref == C_NULL ? nothing : Metadata(ref)::DIScope
    elseif property == :line
        Int(API.LLVMDIVariableGetLine(var))
    else
        getfield(var, property)
    end
end


## scopes

export DIScope, DILocalScope

abstract type DIScope <: DINode end

abstract type DILocalScope <: DIScope end


## file

export DIFile

@checked struct DIFile <: DIScope
    ref::API.LLVMMetadataRef
end
identify(::Type{Metadata}, ::Val{API.LLVMDIFileMetadataKind}) = DIFile

function Base.getproperty(file::DIFile, property::Symbol)
    if property == :directory
        len = Ref{Cuint}()
        data = API.LLVMDIFileGetDirectory(file, len)
        unsafe_string(convert(Ptr{Int8}, data), len[])
    elseif property == :filename
        len = Ref{Cuint}()
        data = API.LLVMDIFileGetFilename(file, len)
        unsafe_string(convert(Ptr{Int8}, data), len[])
    elseif property == :source
        len = Ref{Cuint}()
        data = API.LLVMDIFileGetSource(file, len)
        unsafe_string(convert(Ptr{Int8}, data), len[])
    else
        getfield(file, property)
    end
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
        identify(::Type{Metadata}, ::Val{API.$typ_kind}) = $typ_name
    end
end

function Base.getproperty(typ::DIType, property::Symbol)
    if property == :name
        len = Ref{Csize_t}()
        data = API.LLVMDITypeGetName(typ, len)
        unsafe_string(convert(Ptr{Int8}, data), len[])
    elseif property == :size
        API.LLVMDITypeGetSizeInBits(typ)
    elseif property == :offset
        API.LLVMDITypeGetOffsetInBits(typ)
    elseif property == :alignment
        API.LLVMDITypeGetAlignInBits(typ)
    elseif property == :line
        API.LLVMDITypeGetLine(typ)
    elseif property == :flags
        API.LLVMDITypeGetFlags(typ)
    else
        getfield(typ, property)
    end
end


## subprogram

export DISubProgram

@checked struct DISubProgram <: DIScope
    ref::API.LLVMMetadataRef
end
identify(::Type{Metadata}, ::Val{API.LLVMDISubprogramMetadataKind}) = DISubProgram

function Base.getproperty(subprogram::DISubProgram, property::Symbol)
    if property == :line
        API.LLVMDITypeGetLine(subprogram)
    else
        getfield(subprogram, property)
    end
end


## other

export DEBUG_METADATA_VERSION, strip_debuginfo!

DEBUG_METADATA_VERSION() = API.LLVMDebugMetadataVersion()

strip_debuginfo!(mod::Module) = API.LLVMStripModuleDebugInfo(mod)

function get_subprogram(func::Function)
    ref = API.LLVMGetSubprogram(func)
    ref==C_NULL ? nothing : Metadata(ref)::DISubProgram
end
set_subprogram!(func::Function, sp::DISubProgram) = API.LLVMSetSubprogram(func, sp)
