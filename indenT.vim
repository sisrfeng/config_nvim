 " Only 36 out of 2,500 programming languages in my database use indentation
" These languages use indentation:
    " ¿- makefile¿

    " ¿- markdown¿
    " ¿- org¿
    " ¿- yaml¿
    " - restructuredtext
    " - stylus
    "
    " - sass
    "
    " - xl-programming-language
    " - haskell
    " - literate-coffeescript
    " - livescript
    "

set cinkeys=
set indentkeys=
" 别自作主张给我indent

" https://superuser.com/questions/694564/indent-x-number-of-spaces-in-visual-mode-vim/1718910#1718910
set tabstop=4 shiftwidth=0
        " au AG BufEnter  * if &ft == 'lua' | set tabstop=4 | endif
                                " filetype滞后于BufEnter吧
        au AG FileType  lua,tex   setlocal tabstop=4
                    " 有些复制来的lua代码, 要加这个autocmd才能让tabstop=4
        au AG BufEnter  *.man  setlocal ft=man
                                " 没生效, 现在BufEnter *.man文件后, &ft是nroff
"\ set shiftround
set noshiftround  "\ 避免行中间的缩进被搞乱


let g:vim_indent_cont =  0
"\ let g:vim_indent_cont =  shiftwidth() +  indent( line('.') )
    " 官方help教的:
        " specifies the amount of indent for a continuation line:
            " a line that starts with a backslash

" move 4 spaces
    nno > >><esc>llll
    nno < <<<esc>hhhh

    vno < <gv
    vno ,, <gv
    " vno , <gv
    " 和normal不一致, 留作他用吧
    vno > <Cmd>silent! exe 'normal! >gv'<cr>
    " vno . <Cmd>silent! exe 'normal! >gv'<cr>
    " 和normal不一致, 留作他用吧


    " vno < <llllgv
    " vno > >hhhhgv
        " 为啥光标无法跟着走?

" move 2 spaces
" todo: 利用if mode() ~=! 'n', 合并normal和visual?
    " normal mode
        nno <M-.> <cmd>call RightN(2)<cr>
            func! RightN(n_space)
                set noshiftround

                    normal mt
                    exe 'normal I'..repeat(' ', a:n_space)
                    normal 't
                    exe 'normal! '..repeat('l', a:n_space)

                set shiftround
            endf

        nno <M-,> <cmd>call LeftN(2)<cr>
            func! LeftN(n_space)
                set backspace=start
                    " 刨掉eol,

                set noshiftround
                set tabstop=1

                    normal mt
                    exe 'normal I'..repeat('', a:n_space)
                    normal 't
                    exe 'normal! '..repeat('h', a:n_space)

                set tabstop=4
                set shiftround
                set backspace=indent,start,eol

            endf


    " visual mode
        vno <M-.> <cmd>call V_RightN(2)<cr>
            func! V_RightN(n_space)

                normal! mt
                normal! gv
                exe "'<,'>normal I"..repeat(' ', a:n_space)
                normal! gv
                normal 't
                " see:     The type  of the old area is used (character, line or blockwise).

            endf

                     "\ <c-v>  :变block-mode
                       " -2 = +2 -4
                       "\ V    :变line-mode
                       "\ 没有gv :最后会只选中第1行
        vno <M-,>   <Cmd>set noshiftround<cr>
                    \<Cmd>norm! g^<cr>
                     \<c-v>I  <esc>
                    \gvV
                     \<
                    \gv
                    \<Cmd>set shiftround<cr>


        " 有bug:
            " vno <M-,> <cmd>call V_LeftN(2)<cr>
                " func! V_LeftN(n_space)
                "     set tabstop=1   " 不加这行 一次删4空格
                "     set backspace=indent,start
                "                     " 刨掉eol, 避免删到上一行
                "                     " 但现在 最开始的一行 ,挪不动. 如果不刨掉eol, 最上面一行 没到最左边就开始挪到上一行了
                "
                "         normal! mt
                "         normal! gv
                "         exe "'<,'>normal I"..repeat('', a:n_space)
                "         normal! gv
                "         normal 't
                "
                "     set tabstop=4
                "     set backspace=indent,start,eol
                " endf

" move 1 space
      nno <M-_>    mnI <esc>`nl
                          "\ 用了mark导致屏幕位置变化
      vno <M-_>    0<c-v>I <esc>
                     \gv
                     \V

" 状态栏有时提示:
      " 3 lines <ed 1 tim
      " 3 lines >ed 1 tim

    " >ed is just short for "shifted"


set expandtab
    " Set 'tabstop' and 'shiftwidth' to whatever you prefer
    " and use 'expandtab'.
    " This way you will always insert spaces.
    " The formatting will never be messed up when 'tabstop' is changed.

" 这就是用默认的, 放这里记着:
    " set softtabstop=0
            " 如果>0,  a mix of spaces and <Tab>s is used.
            " 叫softtabstop, 因为比tabstop灵活?
            " 和wrap vs man_hardwrap里的soft和hard含义不同
            "
            " 我拒绝文件里出现tab, 所以别开这个选项
            "
    " set vartabstop=
    " set varsofttabstop=
            " 高级功能,暂时用不上
            " Return indent (all whitespace at start of a line), converted from


" 代替retab (避免行中间的缩进被搞乱)
    command! -nargs=? -range=% D2F      call ReindenT(<line1>,<line2>,1,2,4)
    command! -nargs=? -range=% F2D      call ReindenT(<line1>,<line2>,1,4,2)
    command! -nargs=* -range=% Reindent call ReindenT(<line1>,<line2>,&expandtab,<f-args>)
                                                      " 开始行号, 结束行号
                        " 用例:
                            " :Reindent 4 2
                            " :Reindent 2 4
fun! IndenT(ori_indent, expandTab_01, stop_Old, stop_New)
    let spaces_old = ' '->repeat(a:stop_Old)
    let spaces_new = ' '->repeat(a:stop_New)
    " space变成tab:
    let new_indent = a:ori_indent->substitute(
                                            \spaces_old,
                                            \'\t',
                                            \'g' )
    " 把挨着tab的空格去掉:
    let new_indent = new_indent->substitute(
                                    \'\v +\ze\t',
                                    \'',
                                    \'g' )
    " Tab变空格
    if a:expandTab_01 == 1
        let new_indent = new_indent->substitute(
                                        \'\t',
                                        \spaces_new,
                                        \'g' )
    en

    return new_indent
endf

fun! ReindenT(line1, line2, expandTab_01, stop_Old, stop_New)
                    " 开始行, 结束行
    let my_poS = getpos('.')
        " The cursor position is restored, but
            " when the number of characters in the indent of the line is changed.
            " the cursor will be in a different  column

    let stop_Old =  empty(a:stop_Old) ?
                    \ &tabstop :
                    \a:stop_Old

    let stop_New =  empty(a:stop_New) ?
                    \ &tabstop :
                    \a:stop_New

    execute a:line1 .. ',' .. a:line2 ..
                \ 'sub' ..
                \ '#\v^\s+' ..
                \ '#\=IndenT(submatch(0), a:expandTab_01, stop_Old, stop_New)' ..
                \ '#e'

    call histdel('search', -1)
                " 清掉本函数内的搜索历史
    call setpos('.', my_poS)
endf

        " 我的老办法:
            " set list
            " set noexpandtab
            " %sub #  #    #gc
            " set tabstop=2
            " set expandtab
            " retab! 4
            " echom "Tab变成4空格"


" python
    " let g:pyindent_disable_parentheses_indenting = 1

    " Indent after an open paren:
        let g:pyindent_open_paren = 'shiftwidth() * 2'

    " Indent after a nested paren:
        let g:pyindent_nested_paren = 'shiftwidth()'

    " Indent for a continuation line:
        let g:pyindent_continue = 'shiftwidth() * 2'

    "
    " The method uses |searchpair()| to look back for unclosed parentheses.
    " This can sometimes be slow,
    " thus it timeouts after 150 msec.

    " If you notice the indenting isn't correct,
    " you can set a larger timeout in msec:

        let g:pyindent_searchpair_timeout = 500


