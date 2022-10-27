" URL:          http://www.fleiner.com/vim/syntax/javascript.vim
" Last Change:  2021 Mar 30

" tuning parameters:
" unlet javaScript_fold

if !exists("main_syntax")
    " quit when a syntax file was already loaded
    if exists("b:current_syntax")
        finish
    en
    let main_syntax = 'javascript'
elseif exists("b:current_syntax") && b:current_syntax == "javascript"
    finish
en

let s:cpo_save = &cpo
set cpo&vim


syn keyword jsCommentTodo      TODO FIXME XXX TBD contained

syn match   jsLineComment      #\/\/.*#               contains=@Spell,jsCommentTodo

syn match   jsCommentSkip      #^[ \t]*\*\($\|[ \t]\+\)#
syn region  jsBlockComment          start="/\*"  end="\*/" contains=@Spell,jsCommentTodo
syn cluster jsComment   contains=jsLineComment,jsBlockComment

syn match   jsSpecial          "\\\d\d\d\|\\."
syn region  jsStringD          start=#"#  skip=#\\\\\|\\"#  end=#"\|$#  contains=jsSpecial,@htmlPreproc
syn region  jsStringS          start=#'#  skip=#\\\\\|\\'#  end=#'\|$#  contains=jsSpecial,@htmlPreproc
syn region  jsStringT          start=#`#  skip=#\\\\\|\\`#  end=#`#    contains=jsSpecial,jsEmbed,@htmlPreproc

syn region  jsEmbed            start=#${#  end=#}#      contains=@jsEmbededExpr

syn match   jsSpecialCharacter "'\\.'"
syn match   jsNumber           "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn match   jsNumber           "-\=\<\d\+\%(_\d\+\)*\>"
syn region  jsRegexpString     start=+[,(=+]\s*/[^/*]+ms=e-1,me=e-1 skip=+\\\\\|\\/+ end=+/[gimuys]\{0,2\}\s*$+ end=+/[gimuys]\{0,2\}\s*[+;.,)\]}]+me=e-1 end=+/[gimuys]\{0,2\}\s\+\/+me=e-1 contains=@htmlPreproc,jsBlockComment oneline

syn keyword jsConditional       if else switch
syn keyword jsRepeat            while for do in
syn keyword jsBranch            break continue
syn keyword jsException         try catch finally throw
syn keyword jsOperator          new delete instanceof typeof
syn keyword jsType              Array Boolean Date Function Number Object String RegExp
syn keyword jsStatement         return with await
syn keyword jsBoolean           true false
syn keyword jsNull              null undefined
syn keyword jsIdentifier        arguments this var let
syn keyword jsLabel             case default
syn keyword jsMessage           alert confirm prompt status
syn keyword jsGlobal            self window top parent
syn keyword jsMember            document event location
syn keyword jsDeprecated        escape unescape
syn keyword jsReserved          abstract
                                \ boolean
                                \ byte
                                \ char
                                \ class
                                \ const
                                \ debugger
                                \ double
                                \ enum
                                \ export
                                \ extends
                                \ final
                                \ float
                                \ goto
                                \ implements
                                \ import
                                \ int
                                \ interface
                                \ long
                                \ native
                                \ package
                                \ private
                                \ protected
                                \ public
                                \ short
                                \ static
                                \ super
                                \ synchronized
                                \ throws
                                \ transient
                                \ volatile
                                \ async

syn cluster  jsEmbededExpr      contains=jsBoolean,jsNull,jsIdentifier,jsStringD,jsStringS,jsStringT

if exists("javaScript_fold")
    syn match       jsFunction      "\<function\>"
    syn region      jsFunctionFold  start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    syn sync match jsSync   grouphere jsFunctionFold "\<function\>"
    syn sync match jsSync   grouphere NONE "^}"

    setl  foldmethod=syntax
    setl  foldtext=getline(v:foldstart)
el
    syn keyword jsFunction  function
    syn match       jsBraces           "[{}\[\]]"
    syn match       jsParens           "[()]"
en

if main_syntax == "javascript"
    syn sync fromstart
    syn sync maxlines=100

    syn sync ccomment jsBlockComment
en

" Define the default highlighting.
    hi   def   link   jsBlockComment            Comment
    hi   def   link   jsLineComment        Comment
    hi   def   link   jsCommentTodo        Todo
    hi   def   link   jsSpecial            Special
    hi   def   link   jsStringS            String
    hi   def   link   jsStringD            String
    hi   def   link   jsStringT            String
    hi   def   link   jsCharacter          Character
    hi   def   link   jsSpecialCharacter   jsSpecial
    hi   def   link   jsNumber             jsValue
    hi   def   link   jsConditional        Conditional
    hi   def   link   jsRepeat             Repeat
    hi   def   link   jsBranch             Conditional
    hi   def   link   jsOperator           Operator
    hi   def   link   jsType               Type
    hi   def   link   jsStatement          Statement
    hi   def   link   jsFunction           Function
    hi   def   link   jsBraces             Function
    hi   def   link   jsError              Error
    hi   def   link   javaScrParenError    jsError
    hi   def   link   jsNull               Keyword
    hi   def   link   jsBoolean            Boolean
    hi   def   link   jsRegexpString       String

    hi   def   link   jsIdentifier         Identifier
    hi   def   link   jsLabel              Label
    hi   def   link   jsException          Exception
    hi   def   link   jsMessage            Keyword
    hi   def   link   jsGlobal             Keyword
    hi   def   link   jsMember             Keyword
    hi   def   link   jsDeprecated         Exception
    hi   def   link   jsReserved           Keyword
    hi   def   link   jsDebug              Debug
    hi   def   link   jsConstant           Label
    hi   def   link   jsEmbed              Special



let b:current_syntax = "javascript"
if main_syntax == 'javascript'  | unlet main_syntax  | en
let &cpo = s:cpo_save
unlet s:cpo_save


