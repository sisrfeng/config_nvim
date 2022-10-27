" Language:		Text
" Maintainer:		David Barnett <daviebdawg+vim@gmail.com>
" Last Change:		2019 Jan 10

if exists('b:did_ftplugin')
    finish
endif


" 弃疗了:
" ========================================================================
" au AG BufEnter ~/PL/*/doc/*.txt  setlocal syntax=help filetype=help
" finish
"
"
"
"
" source $VIMRUNTIME/ftplugin/help.vim
" finish
"
"
"
" " echom 'txt文件出问题来这里______force text to be treated as help file'
" " unlet b:did_ftplugin  " 会报错
" " setl syntax=help | echom 'hhhhhhhhhhhhhhhhh'
" "    这样设了还是不行
" "
" " setl filetype=help  buftype=help
"
" " unlet b:did_ftplugin  加了也无法使得syntax=help
"
" let b:undo_ftplugin = 'setlocal comments< commentstring<'
"
" " 官方的
"     " " We intentionally don't set formatoptions-=t since text should wrap as text.
"     "
"     " " Pseudo comment leaders
"     " " to indent bulleted lists with '-' and '*'.
"     " " And allow for Mail quoted text with '>'.
"     " setlocal comments=fb:-,fb:*,n:>
"     " setlocal commentstring=
