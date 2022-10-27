let g:do_legacy_filetype = 1
"\ https://github.com/neovim/neovim/issues/14090#issuecomment-1177933661
"\ nvim0.8中的过渡方案
"\ 在nvim0.9中彻底转向filetype.lua

"\ au AG BufAdd *   不行
au AG BufEnter *
        \ if bufname() =~ 'dap-repl'
            \| nno <buffer> <c-x> <c-w>k
        \| endif

" 很多插件里都有这行,
    " if !exists('g:no_plugin_maps')  没必要吧

" Todo 全改成 形如 FileType tex ?


" au AG WinNew,BufRead,BufNew,BufEnter,BufWinEnter,BufAdd,WinNew    *
au AG WinNew    *
    \ if &buftype == 'nofile' && exists('w:kind')
    \|    if w:kind == 'close' || w:kind == 'notification'
          \ echo '又弹窗了'
          \ hide
          \| endif
    \| endif


au AG BufRead /tmp/*.vim   call Tmp_bufferS()
    fun! Tmp_bufferS()
        set noswapfile
        set bufhidden=delete

        nno <CR>   "fy<Cmd>call  g:Goto_filE()<CR>
    endf

" au AG BufEnter
"     \ *Coc\ List\ Preview*,list:*yank
"     \ nno  <silent><nowait><buffer> <esc> <esc>

    " help里说无法map <esc>


" buffer local options

    " vim的iskeyword在这里也被改动(现在应该没问题了):
        " ~/PL/scriptV/plugin/scriptV.vim
    au AG FileType python
        \ setl iskeyword=@,48-57,_

                         " 默认的help里的'iskeyword':  nearly all ASCII chars except ' ', '*', '"' and '|'
    au AG FileType zsh,txt
        \ setl iskeyword=@,48-57,_,-
                                   " 1. 若不加连字符, peco-find 就不是一个word
                                   " 2. 之前加了¿#¿, 但会导致#替换时, ctrl w多删了井号
                                   " 3. 192-255是奇奇怪怪的西文, 我用不着
                                   " 4. 如果中英文挨在一起  会被当做一个word, 不便于删除单词
    au AG FileType help
        \ setl iskeyword=@,48-57,_,-
                                 "\ 如果不加-, 敲gh时 无法复制整个tag

    au AG FileType vim
        \ setl iskeyword=@,48-57,_
                                  "\ 加¿-¿会导致¿XXX-¿被当作一个word?
                                        "\ set XXX-=yyyyy

" python
    " 手动触发
    "\ (容易漏掉某些文件 忘记加我的diy)
        " nno <Leader>P    <Cmd>call funcS#Py_wf()<cr>
                    " p: python

                    "\ import leo啥的

    " 需要再临时取消注释, 避免modify too many files, make git history dirty!!!
    " ps:修改后不会自动update

        "\ au AG BufNewFile,BufRead  *.py
        "\                         \ if hostname() != 'redmi14-leo'
        "\                         \ && bufname() !~ 'leo_base.py' && bufname() !~ '__init__.py'
        "\                         \ |   call  funcS#Py_wf()
        "\                         \ | endif

        " :E **/*.py
        " arg list的文件, 一定在buffer list上, 但可能没有load? 所以不触发上述autocmd?
        " :argdo update 也无法上上述autocmd生效
        " :argdo write  也许可以

" preview
    " au AG BufLeave * if &previewwindow == 1 | bdelete | endif
                      " E441: There is no preview window

    au AG BufEnter *log_TeX    call g:Need_jumP()
        fun! g:Need_jumP()
            nno <buffer>  gj     /\v\S +:\d+$<cr>
                                \$"lyiw
                                \bb
                                \"fyiW
                                \:-tab drop <c-r>f<CR>
                                \:<c-r>l<cr>
        endf


    au AG BufEnter /tmp/*
        \ if &previewwindow
            \| call Short_previeW()
                \| if g:keyword_can_be_used == 1 | echom '键位可用' | endif
          \| endif

        fun! Short_previeW()
            let g:keyword_can_be_used = 0
            "\ if search('No mapping found')
                "\ silent! bdelete
                "\ 这导致 本想在 /tmp/啥啥 的buffer里执行的 :sub  在本文件执行
                "\ let g:keyword_can_be_used = 1
                "\ return
            "\ endif

            set modifiable

            nno <buffer>  gj     /\sline\s\d\+$<cr>
                                \$"lyiw
                                  "\ "l: line number
                                \bb
                                \"fyiW
                                 "\ "f:  file
                                 \<Cmd>q<CR>
                                 \<Cmd>stopinsert<CR>
                                 "\ 避免terminal mode里出错
                                \:-tab drop <c-r>f<CR>
                                \:<c-r>l<cr>


            if search('last set from')

                sil % sub #\v\d+\zs$#\r\r#ge
                                "\ 换行
                let a_str = repeat(' ', 20)
                sil % sub #\v\s*last set from#\=a_str#ge
                sil % sub #\vlast set from#\=repeat('', 15)#ge
                sil % sub #no mapping found##ge
                sil % sub #\v.{15,18}\zs\*?\&?\@?##ge
                         "\ *号出现在16列 或被<space>等往后推几列
                 norm! gg
                 "\ norm! ggdd
            elseif  search('--- Syntax items ---')
                sil % sub #--- Syntax items ---##ge
            en
        endf



" json系
    au AG BufNewFile,BufRead *  if &ft =='jsonc'
        \| ino <buffer> ' "
        \| ino <buffer>  " '
        \| en
    au AG BufNewFile,BufRead *  if &ft =='json'  | ino <buffer> ' " | ino <buffer>  " ' | en

" markdown
    au AG FileType markdown  nno <buffer> go   <Cmd>Toc<cr>

" tex
    au AG BufRead  *.tex  call Tex_reaD()
          " bufread 不宜放到ftplugin/某某.vim?
    fun! Tex_reaD()
        call funcS#Out_linE('\v\\(sub)?section\{.{-}}$')
        norm! 2zl
            " fun! Tex_outlinE()
            "     call funcS#Out_linE('\v\\(sub)?section\{.{-}}$')
            " endf
            " call Tex_outlinE()

        " echo '如果觉得莫名多一处undo,来这里看看'
        % sub #\Vbegin{document}#begin{document}#e
    endf

" vim系
    fun! g:Option_iS() abort
        exe 'normal! "oyiw'
        let @o = substitute(@o, "'", '','g')
        " echom '@o是'
        " echom @o
        " echom '@o是'

        exe 'let @" = &' .. @o
                " 寄存器" 放着option的值, 方便paste
        exe 'Verbose set' @o .. '?'
    endf

    " help
    " 搬到help.vim了

    " vim
        au AG FileType vim,help     call Vim_maP()
        fun! Vim_maP()
            nno <silent> <buffer>  wo         <Cmd>call Option_iS()<cr>
            vno <silent> <buffer>  wo        "oy<cmd>exe 'Verbose set' @o..'?'<cr>

            nno <buffer>           si         <cmd>call vim#Short_iT()<cr>
            nno <buffer>           <M-k>      i\ <esc>
            nno <buffer>           <M-Bslash>   <Cmd>call Short_linE()<cr>
            nno <buffer>           <cr>       <Cmd>call vim#To_taG()<cr>
                                 " 和help.vim里冲突?
        endf

        fun! Short_linE()
            mark b
            let _indent = indent('.') - 1
            let _indent2 = indent('.') + 4
            echom _indent
            norm i\
            exe "left" _indent2
            norm  k
            norm  j
        endf


        au AG FileType zsh,bash,sh     call Zsh_maP()
        fun! Zsh_maP()
            nno <buffer>           <M-k>      i\ <esc>
            nno <buffer>           <M-Bslash> i\ <esc>
        endf


            " 傻逼错误, 浪费20min:
                " au AG BufNewFile,BufRead *.vim
                "     \| vno <silent> <buffer>  wo "oy<cmd>exe 'Verbose set' @o..'?'<cr>
                "     \| nno <silent> <buffer>  wo  <Cmd>call Option_iS()<cr>

                " 之前这里用了if 换行时才用 ¿\|¿
                " au AG BufNewFile,BufRead *  if &ft =='help'
                    " \| call Help_maP() | en

                " 这里又忘了在最后一行加 竖线
                " au AG BufNewFile,BufRead *.vim
                "     \ vno <silent> <buffer>  wo "oy<cmd>exe 'Verbose set' @o..'?'<cr>
                "     \ nno <silent> <buffer>  wo  <Cmd>call Option_iS()<cr>

" w3m
    au AG BufWriteCmd *w3m*  write | set modifiable | echom 'lllllllllllllllllll__w3m'
