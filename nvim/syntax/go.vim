" Vim syntax file
" Language:     Go
" Maintainer:   Vim Community / Updated from original by David Daub
" Last Change:  2024 Mar [Based on modern Go Spec]
" Version:      1.0 (Modernized)
" URL:          https://go.dev/ref/spec

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case match

" === Keywords ===

syn keyword     goPackage           package
syn keyword     goImport            import    contained
syn keyword     goDeclaration       var const type func

hi def link     goPackage           Statement
hi def link     goImport            Include  " Use Include for import
hi def link     goDeclaration       Keyword

" Control Flow / Statements
syn keyword     goStatement         defer go goto return break continue fallthrough
syn keyword     goConditional       if else switch select
syn keyword     goLabel             case default
syn keyword     goRepeat            for range

hi def link     goStatement         Statement
hi def link     goConditional       Conditional
hi def link     goLabel             Label
hi def link     goRepeat            Repeat

" === Predeclared Identifiers ===

" Types
syn keyword     goType              bool byte complex64 complex128 error float32 float64
syn keyword     goType              int int8 int16 int32 int64 rune string
syn keyword     goType              uint uint8 uint16 uint32 uint64 uintptr
syn keyword     goType              any comparable " Added in Go 1.18
syn keyword     goTypeKind          chan map struct interface " Used in declarations

hi def link     goType              Type
hi def link     goTypeKind          Keyword " Often used like keywords

" Constants
syn keyword     goBoolean           true false
syn keyword     goPredeclaredId     nil iota

hi def link     goBoolean           Boolean
hi def link     goPredefinedId      Constant " Highlight nil/iota as Constant

" Builtin Functions
syn keyword     goBuiltins          append cap clear close complex copy delete imag len make
syn keyword     goBuiltins          max min new panic print println real recover " Added clear, max, min

hi def link     goBuiltins          Function

" === Comments ===
syn keyword     goTodo              contained TODO FIXME XXX BUG NOTE
syn cluster     goCommentGroup      contains=goTodo,@Spell
syn region      goComment           start="/\*" end="\*/" contains=@goCommentGroup fold
syn match       goLineComment       "//.*" contains=@Spell,goTodo,goGenerateDirective
syn match       goGenerateDirective contained "^\s*//go:[a-z]\+" containedin=goLineComment " Match //go: directives

hi def link     goComment           Comment
hi def link     goLineComment       Comment
hi def link     goTodo              Todo
hi def link     goGenerateDirective PreProc

" === Literals ===

" --- Strings ---
" Go escapes need careful handling within strings and runes
syn match       goEscapeOctal       display contained "\\[0-7]\{1,3}"
syn match       goEscapeC           display contained +\\[abfnrtv\\'"]+
syn match       goEscapeX           display contained "\\x\x\{2}"
syn match       goEscapeU           display contained "\\u\x\{4}"
syn match       goEscapeBigU        display contained "\\U\x\{8}"
syn match       goEscapeError       display contained +\\[^0-7xuUabfnrtv\\'"]+

hi def link     goEscapeOctal       goSpecialString
hi def link     goEscapeC           goSpecialString
hi def link     goEscapeX           goSpecialString
hi def link     goEscapeU           goSpecialString
hi def link     goEscapeBigU        goSpecialString
hi def link     goSpecialString     SpecialChar " Use SpecialChar for escapes
hi def link     goEscapeError       Error

syn cluster     goStringGroup       contains=goEscapeOctal,goEscapeC,goEscapeX,goEscapeU,goEscapeBigU,goEscapeError
syn region      goString            start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@goStringGroup,@Spell
syn region      goRawString         start=+`+ end=+`+ contains=@Spell " Raw strings don't interpret escapes

hi def link     goString            String
hi def link     goRawString         String

" --- Runes (Characters) ---
syn cluster     goCharacterGroup    contains=goEscapeOctal,goEscapeC,goEscapeX,goEscapeU,goEscapeBigU,goEscapeError
syn region      goCharacter         start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@goCharacterGroup

hi def link     goCharacter         Character

" --- Numbers ---
" Order matters: Match floats before ints if they overlap prefix

" Imaginary (must be matched first as they contain full float/int specs + 'i')
" Imaginary Floats
syn match       goImaginaryFloat    display "\%(?:\d\+\(?:_\d\+\)*\.\d*\|\.\d\+\(?:_\d\+\)*\)\(?:[eE][+-]\?\d\+\(?:_\d\+\)*\)\?i"
syn match       goImaginaryFloat    display "\d\+\(?:_\d\+\)*[eE][+-]\?\d\+\(?:_\d\+\)*i"
syn match       goImaginaryHexFloat display "0[xX]\(?:[\da-fA-F]\+\(?:_[\da-fA-F]\+\)*\.\?[\da-fA-F]*\|\.[\da-fA-F]\+\(?:_[\da-fA-F]\+\)*\)[pP][+-]\?\d\+\(?:_\d\+\)*i"
" Imaginary Integers
syn match       goImaginaryInt      display "\d\+\(?:_\d\+\)*i"
syn match       goImaginaryHex      display "0[xX][\da-fA-F]\+\(?:_[\da-fA-F]\+\)*i"
syn match       goImaginaryOct      display "0[oO]\?[0-7]\+\(?:_[0-7]\+\)*i"  " Handles modern 0o and legacy 0 prefix
syn match       goImaginaryBin      display "0[bB][01]\+\(?:_[01]\+\)*i"

hi def link     goImaginaryFloat    Float
hi def link     goImaginaryHexFloat Float
hi def link     goImaginaryInt      Number
hi def link     goImaginaryHex      Number
hi def link     goImaginaryOct      Number
hi def link     goImaginaryBin      Number

" Floats (Hexadecimal) - must come before hex int
syn match       goHexadecimalFloat  display "\<0[xX]\(?:[\da-fA-F]\+\(?:_[\da-fA-F]\+\)*\.\?[\da-fA-F]*\|\.[\da-fA-F]\+\(?:_[\da-fA-F]\+\)*\)[pP][+-]\?\d\+\(?:_\d\+\)*\>"

" Floats (Decimal) - must come before decimal int
syn match       goFloat             display "\<\%(?:\d\+\(?:_\d\+\)*\.\d*\|\.\d\+\(?:_\d\+\)*\)\(?:[eE][+-]\?\d\+\(?:_\d\+\)*\)\?\>"
syn match       goFloat             display "\<\d\+\(?:_\d\+\)*[eE][+-]\?\d\+\(?:_\d\+\)*\>"

hi def link     goFloat             Float
hi def link     goHexadecimalFloat  Float

" Integers (Hexadecimal)
syn match       goHexadecimalInt    display "\<0[xX][\da-fA-F]\+\(?:_[\da-fA-F]\+\)*\>"

" Integers (Octal - modern 0o and legacy 0 prefix)
syn match       goOctalInt          display "\<0[oO]\?[0-7]\+\(?:_[0-7]\+\)*\>"

" Integers (Binary)
syn match       goBinaryInt         display "\<0[bB][01]\+\(?:_[01]\+\)*\>"

" Integers (Decimal) - must be last int type
syn match       goDecimalInt        display "\<\d\+\(?:_\d\+\)*\>"

hi def link     goDecimalInt        Number
hi def link     goHexadecimalInt    Number
hi def link     goOctalInt          Number
hi def link     goBinaryInt         Number

" === Operators ===
"syn match       goOperator          display "\%([-+*/%&|^\!]\|<<\|>>\|&^\|<-\|++\|--\|:=\|&&\|||\)" " Multi-char ops first
"syn match       goOperator          display "=" " Assignment needs careful ordering or context
"syn match       goOperator          display "\.\.\." " Variadic
"syn match       goComparison        display "[=!]=?\|[<>]=?" " == != < <= > >=
"syn match       goPointerOperator   display "[*&]" " Pointer ops often highlighted differently
"syn match       goParenOperator     display "[()\[\]{}]" " Delimiters
"syn match       goSeparator         display "[,.;:]"
"
"hi def link     goOperator          Operator
"hi def link     goComparison        Operator
"hi def link     goPointerOperator   Operator  " Or link to Type or Special if preferred
"hi def link     goParenOperator     Delimiter
"hi def link     goSeparator         Delimiter

" === Function Calls and Composite Literals (Heuristic) ===
syn match       goFunctionCall      /\w\+(/hs=s,he=e-1 contains=goBuiltins,goType
syn match       goStructLiteral     /\w\+\s*{/hs=s,he=e-1 contains=goType

hi def link     goFunctionCall      Function  " Highlight the name part as function
hi def link     goStructLiteral     Type      " Highlight the type name part

" === Syncing ===
" Basic syncing, might need adjustment for very large files
syn sync minlines=200
" More precise syncing (can be slower):
" syn sync match goSync grouphere NONE /^\%(package\|import\|const\|var\|type\|func\)\>/
" syn sync maxlines=50

let b:current_syntax = "go"

" vim: sw=2 ts=2 et
