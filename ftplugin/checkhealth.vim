" Language:     Neovim checkhealth buffer
" Last Change:  2021 Dec 15

if exists("b:did_ftplugin")  | finish  | endif

runtime! ftplugin/markdown.vim  ftplugin/markdown_*.vim   ftplugin/markdown/*.vim

setl  wrap breakindent linebreak
setl  conceallevel=2 concealcursor=nc
setl  keywordprg=:help
let &l:iskeyword='!-~,^*,^|,^",192-255'

if exists("b:undo_ftplugin")
    let b:undo_ftplugin .= "|setl wrap< bri< lbr< cole< cocu< kp< isk<"
el
    let b:undo_ftplugin = "setl wrap< bri< lbr< cole< cocu< kp< isk<"
en
