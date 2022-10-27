" 初始化terminal
    au AG BufEnter   *
            \ if &buftype != 'terminal'
            \ |    stopinsert
            \ | else
            \ |    startinsert
            \ | endif
            " 光在下面几行加它, 不行:
            " au AG BufLeave term://*    stopinsert


    au AG BufEnter term://*   call Term_buf_enteR()
        fun! Term_buf_enteR()
            nno <buffer> / ms?
            " 之前这么写, 导致?后的空格也被map了 :
                " au AG BufEnter term://*   if XXXX |  nno <buffer> / ms? | endif

            nno <buffer> <c-c><c-c> i<c-c>
            vno <buffer> <c-c><c-c> <esc>i<c-c>
                                                 " 最后的ctrl-c: 扔掉zsh的输入  au AG BufEnter term://*
            vno <buffer> ii <esc>i
                " au AG BufEnter        *   vno <buffer> ii <esc>i
                "                          导致vii不能选中indent


            nno <buffer>  gj     / ;;  \d\+$<cr>
                                \$"lyiw
                                  "\ "l: line number
                                \bb
                                \"fyiW
                                 "\ "f:  file
                                 \<Cmd>stopinsert<CR>
                                 "\ 避免terminal mode里出错
                                \:-tab drop <c-r>f<CR>
                                \:<c-r>l<cr>

            "\ nno gf :-tab drop <cfile><CR>
            "\ nno gf    gF  \ 不能用-tab drop

            "\ map.vim里有:
                "\ tno   <2-LeftMouse>   <c-\><c-n>gF

        endf


    " 后面的覆盖前面的
    au AG BufLeave term://*    stopinsert
                               " 避免在文件里进入insert模式

    " let g:terminal_color_4 = '442200'
        " 放到/home/wf/dotF/cfg/nvim/colors/leo_light.vim


" # 终端下的cwd自动跟从zsh:
    " https://vi.stackexchange.com/a/21813/38936
   "  its name must start with Tapi_
    func! Tapi_lcd(buf, cwd) abort
        exe 'lcd' a:cwd
        return ''
    endf




nno <c-j>   <Cmd>call    To_term()<cr>
" ctrl+j  ctrl+alt+j  记住最近的terminal
    tno              <c-j>  <C-\><C-N><Cmd>execute '-tab drop' g:last_buffeR<CR>

    au AG BufEnter  term://*
     \ nno <buffer>  <c-j>            <Cmd>execute '-tab drop' g:last_buffeR<CR>


    if !exists('g:term_nameS')
        let g:term_nameS = []
    en

    if !exists('g:term_jobS')
        let g:term_jobS = []
    en


    " • TermOpen/TermClose
                            " if fnameescape(bufname() ) !~ 'SKIM':  专治fzf/skim打开的terminal的丑八怪bufname:
                               " 不加fnameescape会报错


        "\ au AG TermOpen *   if fnameescape(bufname() ) !~ 'SKIM' &&  exists( b:terminal_job_id )
        au AG TermOpen *   if fnameescape(bufname() ) !~ 'SKIM' &&  fnameescape(bufname() )  !~ 'dap-terminal'
                        \|     call add( g:term_nameS,  fnameescape( bufname() ) )
                        \|     call add( g:term_jobS,  b:terminal_job_id )
                        \|     startinsert
                        \| endif
                            " ~/PL/sk/bin/preview.sh
                            " 用了这个后, 切到termnial会有bug, 所以要排除

                " :sk开的terminal的bufname()
                            " term://~/dotF/cfg/nvim//1387242:( none )  |'sk'
                            " '--color=current:#444444,
                            "     info             : #20a780,
                            " 一大串


        "\ au AG TermClose * execute 'bdelete! ' . expand('<abuf>')
            "\ https://github.com/neovim/neovim/issues/14986#issuecomment-902705190
            "\ https://github.com/voldikss/vim-floaterm/issues/315
        "\ 同上:
        "\ au AG TermClose * if !v:event.status | exe 'bdelete! ' .. expand('<abuf>') | endif
            "\ /home/wf/PL/help_me/doc/nvim_terminal_emulator.txt

        au AG  TermClose * if fnameescape(bufname() ) !~ 'SKIM'
                                \| try
                                    \| call remove(g:term_nameS, -1)
                                \| catch /*/
                                \| endtry
                                \| try
                                    \| call remove(g:term_jobS, -1)
                                \| catch /*/
                                \| endtry
                        \| endif

                        "\ \| exec 'bdelete '

                        "\ \| exec 'bdelete! ' . expand('<abuf>')
                            "\ 导致skim的float window关闭时出问题




    fun! To_term()
        " 记下旧信息:
            let g:last_buffeR = fnameescape( expand('%:p') )

        if len(g:term_nameS) == 0
            -tabedit term://zsh
        el
            exe "-tab drop" g:term_nameS[-1]
        en
    endf

    fun! To_term_cwD()
        let workdir = (expand('%') == '')?  getcwd() : expand('%:p:h')
        call chansend(g:term_jobS[-1], 'cd ' . fnameescape(workdir) . "  \<cr>" )
        call To_term()
    endf

        if exists('g:wf_vidE')
        "\ 刚进neovide时,
        "\ ReloaD 前,  exists('g:wf_vidE') 是1
        "\ 但if里的不生效
        "\ ReloaD才生效
            nno <C-F9>   <Cmd>call   To_term_cwD()<cr>
            tno <C-F11>  <F1>
        el
            nno <F33>   <Cmd>call    To_term_cwD()<cr>
            tno <F35>   <F1>
                " ahk 让capslock+f变为了<F35>
                " /home/wf/dotF/zsh/bind.zsh里 bind "$KeY[F1]"  forward-word
        en


    au AG BufWritePost
                \ /home/wf/dotF/zsh/*.{zsh,zz}
                \ call chansend(g:term_jobS[-1], 'zsh     ' . "  \<cr>" )
                "\ \ call chansend(g:term_jobS[-1], 'echo "改了zsh配置" ;  zsh     ' . "  \<cr>" )
                "                                'source ' . '~/dotF/zsh/rc.zsh'
                                                " zsh的bug, 别source, 新开zsh



" 其他tnoremap

    tno <M-s>   <c-\><c-n>:wa<Bar>
                    \exe "mksession! $cache_X/nvim/sess_leo.vim"<CR>
                    \:qa



" 仿照tmux的prefix键  <c-space>系列:
    " tno <c-w> <c-w>
    "         " 不map的话, 是vim的window系列的prefix键
    "         " map了可以用 ,但有点慢


    nor! <c-space>c              <esc>:-tabedit term://zsh<cr>
    nor  <c-space>c                   :-tabedit term://zsh<cr>
    tno  <c-space>c         <c-\><c-n>:-tabedit term://zsh<cr>
                                          " 加上减号, 再当前tab前(而非后面)新建tab, 方便退出此tab会回到原tab
            " tno <c-space>c
            " \  <c-\><c-n>:-tabedit term://zsh<cr> auto_conda cle<BS>
                                        " 以结尾, 会和NL一起 被当做CRNL换行 自动转换为NL)
                                        " 所以加上BS, 比<space>好, 不会影响终端的输入
                                        " 这样可以在terminal里输入空格
            " 隔了一次函数return, 报错
                    " func Ashell()
                    "     term://zsh<cr> auto_condacle<BS>
                    " endf
                    " tno <c-space>c         <c-\><c-n>:call Ashell()<cr>

    " split/vsplit
        nor  <c-space><space>              :split  term://zsh<cr>
        nor! <c-space><space>         <esc>:split  term://zsh<cr>
        tno <c-space><space>    <c-\><c-n>:split  term://zsh<cr>

    " 方便重开zsh
        tno <c-space><c-n>     <c-\><c-n>:q!<cr><c-\><c-n>:split term://zsh<cr>

        nor  <c-space>\                    :vsplit term://zsh<cr>
        nor! <c-space>\               <esc>:vsplit term://zsh<cr>
        tno <c-space>\          <c-\><c-n>:vsplit term://zsh<cr>



    " hjkl窗口跳转
    " hjkl窗口跳转

        tno <c-space>h          <c-\><c-n><c-w>h
        tno <c-space>l          <c-\><c-n><c-w>l
        tno <c-space>j          <c-\><c-n><c-w>j
        tno <c-space>k          <c-\><c-n><c-w>k

        nor  <c-space>h               <esc><C-w>h
        nor  <c-space>l               <esc><C-w>l
        nor  <c-space>j               <esc><C-w>j
        nor  <c-space>k               <esc><C-w>k

        nor! <c-space>h               <esc><C-w>h
        nor! <c-space>l               <esc><C-w>l
        nor! <c-space>j               <esc><C-w>j
        nor! <c-space>k               <esc><C-w>k

        nno  <c-space>f               :lua Kill_popUP()<cr>

    " extract/单独的tab
        nor  <c-space>e                    <c-w><S-t>
        nor! <c-space>e               <esc><c-w><S-t>
        tno <c-space>e          <c-\><c-n><c-w><S-t>


    " tab左右切换
        nor  <c-h>                         <cmd>tabprev<cr>
        nor! <c-h>                    <esc><cmd>tabprev<cr>
        tno <c-h>               <c-\><c-n><cmd>tabprev<cr>

        nor  <c-l>                         <cmd>tabnext<cr>
        nor! <c-l>                    <esc><cmd>tabnext<cr>
        tno <c-l>               <c-\><c-n><cmd>tabnext<cr>


        tno <c-space><c-space>  <c-\><c-n>
        tno <c-space>           <c-\><c-n>
                                        " 这样要等timeout, 有点慢
        tno <c-space>a          <c-\><c-n><cmd>echo '待用'<CR>

        tmap <c-space>g          <c-\><c-n><esc><plug>(easymotion-k)

        imap <c-space>g                    <esc><plug>(easymotion-k)
        nmap <c-space>g                         <plug>(easymotion-k)
        vmap <c-space>g                    <esc><plug>(easymotion-k)

        tno <expr> <M-C-R> '<C-\><C-N>"' .. nr2char(getchar()) .. 'pi'
                    " 来自:/home/wf/.local/share/nvim/plugged/vim_help/doc/nvim_terminal_emulator.txt

    " quit:
        tno <c-space>q            <c-\><c-n><Cmd>hide<cr>
        no  <c-space>q            <Cmd>call Smart_qq()<cr>
        no! <c-space>q           <esc>:call Smart_qq()<cr>

        " tno qq                   <c-\><c-n><Cmd>hide<cr>  " 会导致terminal 里q无法输入吧
        nno  qq                   <Cmd>call Smart_qq()<cr>
        vno  qq                   <Cmd>call Smart_qq()<cr>

        nno <c-q>  q
        nno  q  q:
        " nno  q  :
             " 避免按错?


        tno <c-space>n         <c-\><c-n><c-w>L
        no  <c-space>n                   <c-w>L
        no! <c-space>n              <esc>:<c-w>L


