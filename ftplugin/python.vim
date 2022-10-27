" https://github.com/tpict/vim-ftplugin-python

if exists("b:did_ftplugin") | finish | endif  | let b:did_ftplugin = 1
let s:keepcpo= &cpo  | set cpo&vim

setl   cinkeys-=0#
setl   indentkeys-=0#
setl   include=^\\s*\\(from\\\|import\\)
setl   define=^\\s*\\(def\\\|class\\)

"\ ALEDisable
" 别lint  python了, 我基本不遵守PEP8

        " " ale lint
        "     let b:ale_python_pyright_config = {
        "         \ 'pyright': {
        "         \   'disableLanguageServices': v:true,
        "         \ },
        "         \}
        "
        "     " let b:ale_linters = ['flake8', 'pylint']
        "     let b:ale_linters_ignore = ['pyright']
        "     " let b:ale_linters_explicit = []
        "     let b:ale_linters_explicit = ['flake8']
        "          " Only running linters you asked for

"\ includeexpr
    " For imports with leading ¿..¿
        " append / and
        " replace additional ¿.¿s with ../
        let b:grandparent_match = '^\(.\.\)\(\.*\)'
        let b:grandparent_sub = '\=submatch(1)."/".repeat("../",strlen(submatch(2)))'

    " For imports with a single leading ¿.¿
    " replace it with ./
        let b:parent_match = '^\.\(\.\)\@!'
        let b:parent_sub = './'

    " Replace any ¿.¿ sandwiched between word characters
    " with /
        let b:child_match = '\(\w\)\.\(\w\)'
        let b:child_sub = '\1/\2'

    "\ setl   includeexpr=substitute(
    "\ debug
    "\ let &b:includeexpr = substitute(  \ 报错
    "\ includeexpr :  local to buffer, 不用显示声明是local的?
    let &includeexpr = substitute(
                                \ substitute(
                                            \ substitute(
                                                        \ v:fname             ,
                                                        \ b:grandparent_match ,
                                                        \ b:grandparent_sub   ,
                                                        \ ''
                                                      \ )    ,
                                            \ b:parent_match ,
                                            \ b:parent_sub   ,
                                            \ ''
                                          \ )    ,
                                 \ b:child_match ,
                                 \ b:child_sub   ,
                                 \ 'g'
                                 \)


setl   suffixesadd=.py

setl   comments=b:#,fb:-
                "\ b:# 表示
                    "\ Blank (<Space>, <Tab> or <EOL>) required after ¿#¿
setl   commentstring=#\ %s

if has('python3')
    setl     omnifunc=python3complete#Complete
elseif has('python')
    setl     omnifunc=pythoncomplete#Complete
en

set wildignore+=*.pyc


"\ Python_jump
    "\ let b:
        let b:prev_toplevel    = '\v^(class\|def\|async def)>'
        let b:next_toplevel    = '\v%$\|^(class\|def\|async def)>'

        let b:prev_endtoplevel = '\v\S.*\n+(def\|class)'
        let b:next_endtoplevel = '\v%$\|\S.*\n+(def\|class)'

        let b:prev             = '\v^\s*(class\|def\|async def)>'
        let b:next             = '\v%$\|^\s*(class\|def\|async def)>'

        let b:prev_end         = '\v\S\n*(^(\s*\n*)*(class\|def\|async def)\|^\S)'
        let b:next_end         = '\v\S\n*(%$\|^(\s*\n*)*(class\|def\|async def)\|^\S)'

    if !exists('g:no_plugin_maps') && !exists('g:no_python_maps')
        exe     "nno <silent> <buffer>   ]]   :call <SID>Python_jump('n', '". b:next_toplevel."', 'W', v:count1)<cr>"
        exe     "nno <silent> <buffer>   [[   :call <SID>Python_jump('n', '". b:prev_toplevel."', 'Wb', v:count1)<cr>"

        exe     "nno <silent> <buffer>   ][   :call <SID>Python_jump('n', '". b:next_endtoplevel."', 'W', v:count1, 0)<cr>"
        exe     "nno <silent> <buffer>   []   :call <SID>Python_jump('n', '". b:prev_endtoplevel."', 'Wb', v:count1, 0)<cr>"

        exe     "nno <silent> <buffer>   ]m   :call <SID>Python_jump('n', '". b:next."', 'W', v:count1)<cr>"
        exe     "nno <silent> <buffer>   [m   :call <SID>Python_jump('n', '". b:prev."', 'Wb', v:count1)<cr>"

        exe     "nno <silent> <buffer>   ]M   :call <SID>Python_jump('n', '". b:next_end."', 'W', v:count1, 0)<cr>"
        exe     "nno <silent> <buffer>   [M   :call <SID>Python_jump('n', '". b:prev_end."', 'Wb', v:count1, 0)<cr>"



        exe     "ono <silent> <buffer>   ]]   :call <SID>Python_jump('o', '". b:next_toplevel."', 'W', v:count1)<cr>"
        exe     "ono <silent> <buffer>   [[   :call <SID>Python_jump('o', '". b:prev_toplevel."', 'Wb', v:count1)<cr>"
        exe     "ono <silent> <buffer>   ][   :call <SID>Python_jump('o', '". b:next_endtoplevel."', 'W', v:count1, 0)<cr>"
        exe     "ono <silent> <buffer>   []   :call <SID>Python_jump('o', '". b:prev_endtoplevel."', 'Wb', v:count1, 0)<cr>"
        exe     "ono <silent> <buffer>   ]m   :call <SID>Python_jump('o', '". b:next."', 'W', v:count1)<cr>"
        exe     "ono <silent> <buffer>   [m   :call <SID>Python_jump('o', '". b:prev."', 'Wb', v:count1)<cr>"
        exe     "ono <silent> <buffer>   ]M   :call <SID>Python_jump('o', '". b:next_end."', 'W', v:count1, 0)<cr>"
        exe     "ono <silent> <buffer>   [M   :call <SID>Python_jump('o', '". b:prev_end."', 'Wb', v:count1, 0)<cr>"


        exe     "xno <silent> <buffer>   ]]   :call <SID>Python_jump('x', '". b:next_toplevel."', 'W', v:count1)<cr>"
        exe     "xno <silent> <buffer>   [[   :call <SID>Python_jump('x', '". b:prev_toplevel."', 'Wb', v:count1)<cr>"
        exe     "xno <silent> <buffer>   ][   :call <SID>Python_jump('x', '". b:next_endtoplevel."', 'W', v:count1, 0)<cr>"
        exe     "xno <silent> <buffer>   []   :call <SID>Python_jump('x', '". b:prev_endtoplevel."', 'Wb', v:count1, 0)<cr>"
        exe     "xno <silent> <buffer>   ]m   :call <SID>Python_jump('x', '". b:next."', 'W', v:count1)<cr>"
        exe     "xno <silent> <buffer>   [m   :call <SID>Python_jump('x', '". b:prev."', 'Wb', v:count1)<cr>"
        exe     "xno <silent> <buffer>   ]M   :call <SID>Python_jump('x', '". b:next_end."', 'W', v:count1, 0)<cr>"
        exe     "xno <silent> <buffer>   [M   :call <SID>Python_jump('x', '". b:prev_end."', 'Wb', v:count1, 0)<cr>"
    en

    if !exists('*<SID>Python_jump')
        fun! <SID>Python_jump(mode, motion, flags, count, ...) range
            let l:startofline = ( a:0 >= 1)
                            \ ? a:1
                            \ : 1
            if a:mode == 'x'
                norm! gv
            en

            if l:startofline == 1
                norm! 0
            en

            let cnt = a:count
            mark '
            while cnt > 0
                call search(a:motion, a:flags)
                let cnt = cnt - 1
            endwhile

            if l:startofline == 1
                    norm! ^
            en
        endfun
    en

"\ 只对win32的gui有用?
if has("browsefilter") && !exists("b:browsefilter")
    let b:browsefilter = "Python Files (*.py)\t*.py\n" .
                    \ "All Files (*.*)\t*.*\n"
en

if !exists("g:python_recommended_style") || g:python_recommended_style != 0
    " As suggested by PEP8.
    setl  expandtab tabstop=4 softtabstop=4 shiftwidth=4
    "\ setl  list
en

" Use pydoc for keywordprg.
    if executable('python3')
        setl     keywordprg=python3\ -m\ pydoc
    elseif executable('python')
        setl     keywordprg=python\ -m\ pydoc
    en
    " Unix users preferentially get pydoc3, then pydoc2.
    " Windows doesn't have a standalone pydoc executable in $PATH by default,
    " nor  does it have separate python2/3 executables,
    " so Windows users just get  whichever version corresponds to their installed Python version.

" Script for filetype switching to undo the local stuff we may have changed
let b:undo_ftplugin = 'setl  cinkeys<'
             \ . '|setl  comments<'
             \ . '|setl  commentstring<'
             \ . '|setl  expandtab<'
             \ . '|setl  include<'
             \ . '|setl  includeexpr<'
             \ . '|setl  indentkeys<'
             \ . '|setl  keywordprg<'
             \ . '|setl  omnifunc<'
             \ . '|setl  shiftwidth<'
             \ . '|setl  softtabstop<'
             \ . '|setl  suffixesadd<'
             \ . '|setl  tabstop<'
             \ . '|silent! nunmap <buffer> [M'
             \ . '|silent! nunmap <buffer> [['
             \ . '|silent! nunmap <buffer> []'
             \ . '|silent! nunmap <buffer> [m'
             \ . '|silent! nunmap <buffer> ]M'
             \ . '|silent! nunmap <buffer> ]['
             \ . '|silent! nunmap <buffer> ]]'
             \ . '|silent! nunmap <buffer> ]m'
             \ . '|silent! ounmap <buffer> [M'
             \ . '|silent! ounmap <buffer> [['
             \ . '|silent! ounmap <buffer> []'
             \ . '|silent! ounmap <buffer> [m'
             \ . '|silent! ounmap <buffer> ]M'
             \ . '|silent! ounmap <buffer> ]['
             \ . '|silent! ounmap <buffer> ]]'
             \ . '|silent! ounmap <buffer> ]m'
             \ . '|silent! xunmap <buffer> [M'
             \ . '|silent! xunmap <buffer> [['
             \ . '|silent! xunmap <buffer> []'
             \ . '|silent! xunmap <buffer> [m'
             \ . '|silent! xunmap <buffer> ]M'
             \ . '|silent! xunmap <buffer> ]['
             \ . '|silent! xunmap <buffer> ]]'
             \ . '|silent! xunmap <buffer> ]m'
             \ . '|unlet! b:browsefilter'
             \ . '|unlet! b:child_match'
             \ . '|unlet! b:child_sub'
             \ . '|unlet! b:grandparent_match'
             \ . '|unlet! b:grandparent_sub'
             \ . '|unlet! b:next'
             \ . '|unlet! b:next_end'
             \ . '|unlet! b:next_endtoplevel'
             \ . '|unlet! b:next_toplevel'
             \ . '|unlet! b:parent_match'
             \ . '|unlet! b:parent_sub'
             \ . '|unlet! b:prev'
             \ . '|unlet! b:prev_end'
             \ . '|unlet! b:prev_endtoplevel'
             \ . '|unlet! b:prev_toplevel'
             \ . '|unlet! b:undo_ftplugin'

let &cpo = s:keepcpo  | unlet s:keepcpo
