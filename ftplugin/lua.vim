" Maintainer:       Doug Kearns <dougkearns@gmail.com>
" Last Change:          2021 Nov 15

if exists("b:did_ftplugin")  | finish  | endif   |let b:did_ftplugin = 1

let s:cpo_save = &cpo  | set cpo&vim

setlocal formatoptions-=t formatoptions+=croql
    " Set 'formatoptions' to break comment lines but not other lines,
    " and insert  the comment leader when hitting <CR> or using "o".

setlocal comments=:--
setlocal commentstring=--%s
setlocal suffixesadd=.lua

let b:undo_ftplugin = "setlocal fo< com< cms< sua<"

if exists("loaded_matchit") && !exists("b:match_words")
    let b:match_ignorecase = 0
    let b:match_words =
                \ '\<\%(do\|function\|if\)\>:' .
                \ '\<\%(return\|else\|elseif\)\>:' .
                \ '\<end\>,' .
                \ '\<repeat\>:\<until\>,' .
                \ '\%(--\)\=\[\(=*\)\[:]\1]'
    let b:undo_ftplugin .= " | unlet! b:match_words b:match_ignorecase"
endif

if (has("gui_win32") || has("gui_gtk")) && !exists("b:browsefilter")
    let b:browsefilter = "Lua Source Files (*.lua)\t*.lua\n" .
        \              "All Files (*.*)\t*.*\n"
    let b:undo_ftplugin .= " | unlet! b:browsefilter"
endif

let &cpo = s:cpo_save  | unlet s:cpo_save
