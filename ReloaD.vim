if !exists("*ReloaD") "   *这样表示函数名*
    " " Avoid infinite loops
    " https://stackoverflow.com/a/47308851/14972148
    " 函数ReloaD改了后,
    " 重新加载的 还是改之前的, 要在重开整个nvim才行
    func! ReloaD()
        messages clear

        if &buftype == 'tex'  "\ 之前没加这行, 导致每次ReloaD, 都会运行vimtex的autoload里的文件
            try
                call vimtex#misc#reload()
                echo 'call vimtex#misc#reload()成功'
            catch
            endtry
        en


        "\ 有时导致卡死

            "\ 清空buffer内的var
            "\ for k in keys(b:) | unlet s:[k] | endfor

            "\ echom "清空script内的var"
            "\ for k in keys(s:) |  unlet s:[k] |  endfor

        lua require('reLoad').ReLua()
        "\ doautocmd VimLeavePre
        "\ doautocmd VimLeave
        "\ vimleave会触发neovide的:   call rpcnotify(1, 'neovide.quit', v:exiting)
        "\ 目前其余的vimleave的autocmd只有2个:
            wshada    $cache_X/nvim/wf_mru.vim
            "\ if get(g:, 'coc_process_pid', 0) | call system('kill -9 -' . g:coc_process_pid) | endif

        source $nV/init.vim
            " source <sfile>
                " 在script里, <sfile>被替换为本文件
                " 但在函数里, 被替换成了function ReloaD
                    " Error detected while processing function:
                    " E484: Can't open file function ReloaD

            "\ 优化: 只source改过的文件?
            " 其实很多vim的script, 开头都有if ... loaded ... finish
        doautocmd VimEnter
        "\ doautocmd UIEnter
            "\ 别用这行

        "\ if exists('g:wf_vidE')  | set guifont=Hack_Nerd_Font_Mono  | en
        "\ 导致guifont里的:h没了
        "\     "\ 有时字体会双倍bold, 重新设一下就好
            "\ 这行在Gui_iniT()里, call ReloaD()时进不去, 因为:
                " au AG UIEnter *   if exists('g:wf_vidE') | call Gui_iniT() | endif

        "\ call clearmatches()
            "\ remove conceal effect   需要时敲<c-k>

        set nohlsearch


        redraw!

        if &buftype != 'termianl'
            Runtime %
            exe  'norm! zv'
        el
            setl  statusline=%9*--
        en

        " bufdo filetype detect
            " 只能detec当前buffer

            " 代替了它?
            " if &buftype == 'help' | setl     syntax=help modifiable | endif
                " 使得reload后 如果当前buffer是help类型, 能保证语法高亮完全如我所愿
                " 这2个都不行:
                    " if exists(' b:current_filetype')
                    "     unlet b:current_filetype
                    "     echom "unlet b:current_filetype"
                    " endif
                    " if exists(' b:current_syntax')
                    "     echom "unlet b:current_syntax"
                    "     unlet b:current_syntax
                    " endif

                " 无法解决doc/*.txt识别为ft=text的问题
                    " if expand('%:p') =~  '~/PL/*/doc/*.txt'
                    "    " echom expand('%:p') 是/home/wf/dotF/cfg/nvim/init.vim
                    "
                    "     echom '进入文档'
                    "     set ft=help
                    " endif
    endf
en

" 管理autocmd
"\ todo :现在reload后, autocmd总数一直上涨
" 之前发现, ReloaD后, autocmd从9k条 降低至4k?

    au! User
    "\ aug User
        "\ User不是group 只是event

         " AG : 我的autogroup
    aug  AG
        au!

    aug  VimTeX
        au!

    aug My_syn
        au!

    aug TeX
        "\ 有这个group?
        au!

    aug  wf_tex_autogroup
        au!


au AG BufWritePost
    \ ~/dotF/cfg/nvim/coc-settings.json
    \ ++nested
    \ CocRestart

"\ 跳到最近修改的位置:
au AG BufReadPost  *
    \ if &modifiable |  exec "norm u\<c-r>"  | en

" 关于ReloaD的map
    " 为了展开光标所在的fold...  还是别了, 光标位置会跑到行末
        " nor <c-space>r                    :call ReloaD()<cr> | startinsert!
        " 不行:
            " nor <c-space>r                    :call ReloaD()<cr> | startinsert! | stopinsert
            " nor <c-space>r                    :call ReloaD()<cr> | startinsert! | normal <esc>

    nno          <F5>                   :call ReloaD()<cr><cmd>filetype detect<cr>
            "\ # nvim里call ReloaD()后, PS1有2处有块奇怪的浅色块, 不是PS1的锅, 是这里的问题?

    vno          <F5>                   :call ReloaD()<cr><cmd>filetype detect<cr>
                                                               " this is for conceal
    ino          <F5>              <esc>:call ReloaD()<cr>i
    tno          <F5>         <c-\><c-n>:source $nV/init.vim<CR>i
    " cnor  其实很少这样reload, 要用再开吧

