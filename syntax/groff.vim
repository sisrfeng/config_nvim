" Maintainer:	John Marshall <jmarshall@hey.com>
" Last Change:	2003-05-08-12:41:13 GMT-5.

"\ 这个文件应该没什么用了.
" 虽然man的内容由groff/nroff处理, 但我基本不直接写nroff
    "\ /home/wf/dotF/cfg/nvim/filetype.vim里, 注释掉了:
        "\ au BufNewFile,BufRead *.man         setf nroff

" This uses the nroff.vim syntax file.
    "\ groff比nroff先进, 但为什么没在这里定义新的syntax, 而是在
    "\ /home/wf/dotF/cfg/nvim/syntax/nroff.vim里加这些if?
            "\ if exists("b:nroff_is_groff")
            "\     syn region nroffEscRegArg matchgroup=nroffEscape start=/\[/ end=/\]/ contained oneline
            "\     syn region nroffSize matchgroup=nroffEscape start=/\[/ end=/\]/ contained
            "\ endif

let b:main_syntax = "nroff"
let b:nroff_is_groff = 1
runtime! syntax/nroff.vim
