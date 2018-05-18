##########
# Tokens #
##########

module Kinds
@enum(Kind,
    EOF,
    IDENTIFIER,
    NUMBER,
    begin_keywords,
        DEF,
        EXTERN,
        IF,
        THEN,
        ELSE,
        FOR,
        VAR,
    end_keywords,
    begin_operators,
        PLUS,
        MINUS,
        SLASH,
        STAR,
    end_operators,
    begin_comparisons,
        LESS,
        GREATER,
        EQUAL,
    end_comparisons,
    begin_delimiters,
        LPAR,
        RPAR,
        SEMICOLON,
        COMMA,
        LBRACE,
        RBRACE,
    end_delimiters,
    )
end

# Lookup-table for keywords
const KEYWORD_KINDS = Dict{String, Kinds.Kind}()
for kind in instances(Kinds.Kind)
    if Kinds.begin_keywords < kind < Kinds.end_keywords
        KEYWORD_KINDS[lowercase(string(kind))] = kind
    end
end

struct Token
    kind::Kinds.Kind
    val::String
end
Token(k::Kinds.Kind) = Token(k, "")

function Base.show(io::IO, t::Token)
    print(io, string(t.kind))
    if !isempty(t.val)
        print(io, ": ", t.val)
    end
end


#########
# Lexer #
#########

mutable struct Lexer{IO_t <: IO}
    io::IO_t
    last_char::Char
    buffer_scratch::IOBuffer
end

Lexer(io::IO) = Lexer(io, EOF_CHAR, IOBuffer())
Lexer(str::String) = Lexer(IOBuffer(str))

# Useful for debugging
function Base.collect(l::Lexer)
    tokens = Token[]
    while true
        t = gettok(l)
        push!(tokens, t)
        t.kind == Kinds.EOF && break
    end
    return tokens
end

const EOF_CHAR = convert(Char,typemax(UInt16))

# Reading
readchar(io::IO) = eof(io) ? EOF_CHAR : read(io, Char)
function readchar(l::Lexer, dowrite = true)
    if l.last_char != EOF_CHAR
        c = l.last_char
        l.last_char = EOF_CHAR
    else
        c = readchar(l.io)
    end
    dowrite && write(l.buffer_scratch, c)
    return c
end
discardchar(l::Lexer) = readchar(l, false)

function readwhile(f, l::Lexer, dowrite=true)
    while true
        c = readchar(l, false)
        if !f(c)
            l.last_char = c
            break
        end
        dowrite && write(l.buffer_scratch, c)
    end
end
discardwhile(f, l::Lexer) = readwhile(f, l, false)

function gettok(l::Lexer)::Token
    t = _gettok(l)
    seek(l.buffer_scratch, 0)
    return t
end

function _gettok(l::Lexer)::Token
    discardwhile(isspace, l)
    if l.last_char == '#'
        discardwhile(x -> (x == 'r' || x == '\n'), l)
        discardchar(l) # discard the new line
    end
    c = readchar(l)
    if c == EOF_CHAR; return Token(Kinds.EOF)
    elseif isletter(c); return lex_alpha(l)
    # number
    elseif (c == '.' || isdigit(c)); return lex_number(l)
    # delimiters
    elseif c == '('; return Token(Kinds.LPAR)
    elseif c == ')'; return Token(Kinds.RPAR)
    elseif c == '{'; return Token(Kinds.LBRACE)
    elseif c == '}'; return Token(Kinds.RBRACE)
    elseif c == ';'; return Token(Kinds.SEMICOLON)
    elseif c == ','; return Token(Kinds.COMMA)
    # comparisons
    elseif c == '<'; return Token(Kinds.LESS)
    elseif c == '>'; return Token(Kinds.GREATER)
    elseif c == '='; return Token(Kinds.EQUAL)
    # operators
    elseif c == '+'; return Token(Kinds.PLUS)
    elseif c == '-'; return Token(Kinds.MINUS)
    elseif c == '/'; return Token(Kinds.SLASH)
    elseif c == '*'; return Token(Kinds.STAR)
    else error("failed to handle character $c in lexer")
    end
end

function lex_alpha(l::Lexer)
    isvalididentifier(x) = isletter(x) || isdigit(x)
    readwhile(isvalididentifier, l)
    str = String(take!(l.buffer_scratch))
    if haskey(KEYWORD_KINDS, str)
        return Token(KEYWORD_KINDS[str])
    else
        return Token(Kinds.IDENTIFIER, str)
    end
end

# TODO: Better lexing of numbers
function lex_number(l)
    isvalid_digit = x -> isdigit(x) || x == '.' 
    readwhile(isvalid_digit, l)
    num = String(take!(l.buffer_scratch))
    return Token(Kinds.NUMBER, num)
end
