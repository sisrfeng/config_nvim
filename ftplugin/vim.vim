" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2021 Apr 11

if exists("b:did_ftplugin")
    finish
en

" Don't load another plugin for this buffer
let b:did_ftplugin = 1



" 官方没有提供autoload/vim.vim  那就把本应放在autoload的内容放这里吧

if !exists('*VimFtpluginUndo')
    func VimFtpluginUndo()
        setl fo< isk< com< textwidth< commentstring< keywordprg<
        if exists('b:did_add_maps')
            silent! nunmap <buffer> [[
            silent! vunmap <buffer> [[
            silent! nunmap <buffer> ]]
            silent! vunmap <buffer> ]]
            silent! nunmap <buffer> []
            silent! vunmap <buffer> []
            silent! nunmap <buffer> ][
            silent! vunmap <buffer> ][
            silent! nunmap <buffer> ]"
            silent! vunmap <buffer> ]"
            silent! nunmap <buffer> ["
            silent! vunmap <buffer> ["
         en
        unlet! b:match_ignorecase b:match_words b:match_skip b:did_add_maps
    endfunc
en

let b:undo_ftplugin = "call VimFtpluginUndo()"

" formatoptions
    setl  formatoptions-=c
        " Set 'formatoptions' to break comment lines
    setl  formatoptions-=t
        " Set 'formatoptions'    not break  other lines,
    setl  formatoptions+=crql

" Use :help to lookup the keyword under the cursor with K.
setl     keywordprg=:help

if "\n" .. join(getline(1, 10), "\n") =~#  '\n\s*vim9\%[script]\>'
    " Set 'comments' to format dashed lists in comments
    setl     com=sO:#\ -,mO:#\ \ ,eO:##,:#
    " Comments starts with # in Vim9 script
    setl     commentstring=#%s
el
    setl     com=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"
    " Comments starts with a double quote in legacy script
    setl     commentstring=\"%s
en


" Format comments to be up to 78 characters long
if &tw == 0
    setl     tw=78
en

" Prefer Vim help instead of manpages.
setl     keywordprg=:help

if !exists("no_plugin_maps") && !exists("no_vim_maps")
    let b:did_add_maps = 1

    " Move around functions.
        nno      <silent><buffer> [[ m':call search('^\s*\(fu\%[nction]\\|def\)\>', "bW")<CR>
        vno      <silent><buffer> [[ m':<C-U>exe "normal! gv"<Bar>call search('^\s*\(fu\%[nction]\\|def\)\>', "bW")<CR>
        nno      <silent><buffer> ]] m':call search('^\s*\(fu\%[nction]\\|def\)\>', "W")<CR>
        vno      <silent><buffer> ]] m':<C-U>exe "normal! gv"<Bar>call search('^\s*\(fu\%[nction]\\|def\)\>', "W")<CR>
        nno      <silent><buffer> [] m':call search('^\s*end\(f\%[unction]\\|def\)\>', "bW")<CR>
        vno      <silent><buffer> [] m':<C-U>exe "normal! gv"<Bar>call search('^\s*end\(f\%[unction]\\|def\)\>', "bW")<CR>
        nno      <silent><buffer> ][ m':call search('^\s*end\(f\%[unction]\\|def\)\>', "W")<CR>
        vno      <silent><buffer> ][ m':<C-U>exe "normal! gv"<Bar>call search('^\s*end\(f\%[unction]\\|def\)\>', "W")<CR>

    " Move around comments
        nno      <silent><buffer> ]" :call search('^\(\s*".*\n\)\@<!\(\s*"\)', "W")<CR>
        vno      <silent><buffer> ]" :<C-U>exe "normal! gv"<Bar>call search('^\(\s*".*\n\)\@<!\(\s*"\)', "W")<CR>
        nno      <silent><buffer> [" :call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")<CR>
        vno      <silent><buffer> [" :<C-U>exe "normal! gv"<Bar>call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")<CR>


    nno <buffer>  gd    <Cmd>setl isk+=#<cr>
                       \<Cmd>vsplit<cr>
                       \md<C-]>
                       \<Cmd>setl isk-=#<cr>
            " To allow tag lookup via CTRL-] for autoload functions,
            " '#' must be a  keyword character.  E.g., for netrw#Nread().


    en

" Let the matchit plugin know what items can be matched.
if exists("loaded_matchit")
    let b:match_ignorecase = 0
    " "func" can also be used as a type:
    "   var Ref: func
    " or to list functions:
    "   func name
    " require a parenthesis following, then there can be an "endfunc".
    let b:match_words =
    \ '\<\%(fu\%[nction]\|def\)!\=\s\+\S\+(:\%(\%(^\||\)\s*\)\@<=\<retu\%[rn]\>:\%(\%(^\||\)\s*\)\@<=\<\%(endf\%[unction]\|enddef\)\>,' .
    \ '\<\(wh\%[ile]\|for\)\>:\%(\%(^\||\)\s*\)\@<=\<brea\%[k]\>:\%(\%(^\||\)\s*\)\@<=\<con\%[tinue]\>:\%(\%(^\||\)\s*\)\@<=\<end\(w\%[hile]\|fo\%[r]\)\>,' .
    \ '\<if\>:\%(\%(^\||\)\s*\)\@<=\<el\%[seif]\>:\%(\%(^\||\)\s*\)\@<=\<en\%[dif]\>,' .
    \ '{:},' .
    \ '\<try\>:\%(\%(^\||\)\s*\)\@<=\<cat\%[ch]\>:\%(\%(^\||\)\s*\)\@<=\<fina\%[lly]\>:\%(\%(^\||\)\s*\)\@<=\<endt\%[ry]\>,' .
    \ '\<aug\%[roup]\s\+\%(END\>\)\@!\S:\<aug\%[roup]\s\+END\>,'
    " Ignore syntax region commands and settings, any 'en*' would clobber
    " if-endif.
    " - set spl=de,en
    " - au! FileType javascript syntax region foldBraces start=/{/ end=/}/ …
    let b:match_skip = 'synIDattr(synID(line("."),col("."),1),"name")
                \ =~? "comment\\|string\\|vimSyn_Reg_SSE\\|vimSet"'
en


if expand('%:p') !~ 'dotF/cfg/nvim'
    setl modifiable
    % sub #" {{{\v[123]+$##gce
    % sub #" }}}\v[123]+$##gce
en

