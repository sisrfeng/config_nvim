if exists("b:did_indent")  | finish  | endif

let b:did_indent = 1

setlocal autoindent nosmartindent

let b:undo_indent = "setl ai< si<"

" URL:		 http://sites.google.com/site/khorser/opensource/vim
" Last Change:	2012 Jan 10

