"\ todo: nvim08更新了
" Original Author:	David Bustos <bustos@caltech.edu>
" Last Change:		2021 Sep 26

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
en
let b:did_indent = 1

" Some preliminary settings
setl   nolisp		" Make sure lisp indenting doesn't supersede us
setl   autoindent	" indentexpr isn't much help otherwise

setl   indentkeys=except,
                  \=elif,
                  \=<:>,
                  " 冒号

setl  indentexpr=python#GetIndent(v:lnum)
    "\ sil! setl     indentexpr=GetPythonIndent(v:lnum)
    " ✗silent! 避免下面的dummy导致报错✗ (现在dummy没了)

let b:undo_indent = "setl ai< inde< indk< lisp<"


" Only define the function once.
if exists("*GetPythonIndent")
    finish
endif

"\ 目前用人调用它
" Keep this for backward compatibility,
" new scripts should use  python#GetIndent()
function GetPythonIndent(lnum)
    return python#GetIndent(a:lnum)
endfunction


