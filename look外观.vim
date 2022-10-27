set  splitbelow  " split后的新窗口 位于下方
set  splitright


" source $nV/conceal.vim
source $nV/conceal_fast.vim

set cmdheight=1
"\ nvim08可以设为0, 但导致¿/¿搜索时很奇怪

"\ set signcolumn=no
set signcolumn=auto
    " 1到4个sign (每个sign2个字符宽度?)

" colorscheme leo_light
" 我在leo_light.vim里放了很多 不该放进colors/xxx.vim的命令, 所以别用colorscheme?
source $nV/colors/leo_light.vim

source $nV/indenT.vim


" filetype plugin indent on   " (实现了下面3行)
    " filetype on             " 检测文件类型 (被syntax on包含了)
    filetype plugin on        " 针对不同的文件类型, load不同plugin
    filetype indent on        " 针对不同的文件类型采用不同的缩进格式

" vim-plug的call plug#end() 会Automatically executes上面几行,
" 但如果reloaD, 似乎不会执行call plug#end()

" if the file type ifinds the wrong type,
" you can  add a modeline to your  file.
    " 但root用户或者vscode-neovim使得modeline是off的，而且, vscode neovim无法识别filetype?
    " 所以不能靠modeline 这时要靠这行：
    " filetype detect


" filetype:  local to buffer

    au AG BufNewFile,BufRead *.Vnote           setfiletype vim

    au AG BufNewFile,BufRead *ignore *.ignore  setfiletype yml
    " au AG BufNewFile,BufRead *run_help_leo*    setfiletype zsh
    " au AG BufNewFile,BufRead,BufEnter *.zsh    setfiletype zsh


    au AG BufEnter,FileWritePost  $cache_X/saveas/*           set modifiable | filetype detect
    " au AG BufEnter                $cache_X/saveas/*           set modifiable | filetype detect
        " 解决w3m保存后unmodifiale的问题


set conceallevel=2 concealcursor=n


au AG BufEnter *.w   setl filetype=help  syntax=help  buftype=help
             " w3m
au AG Syntax markdown,md  setl tabstop< expandtab<   shiftwidth< softtabstop=0
                                                       " 不加 softtabstop< 导致缩进为8
                                                       " markdown插件搞鬼吧
                                                       "
au AG Syntax *  setl tabstop=4 expandtab shiftwidth=0

" 窗口布局

    "\ au AG BufEnter * if win_gettype() == 'loclist' |   setl winwidth=88 | endif
            " 不影响第一个window
    set scrolloff=2

    set previewheight=10
    set cmdwinheight=10
        " The command-line window is not a normal window.
        " It is not possible to move to
           " another window or edit another buffer.


    au BufWritePost * if &diff == 1 | diffupdate | endif

    " nnor cs :set cursorcolumn!<CR>
        " cs: cusor
        "
" UI / cursor
    " 防止tmux下vim的背景色显示异常
    if &term =~ '256color'
        " http://sunaku.github.io/vim-256color-bce.html
        " disable Background Color Erase (BCE) so that color schemes
        " render properly when inside 256-color tmux and GNU screen.
        set t_ut=
    en

    " tui也用这个:
    hi nCursor guibg=#88aaaa gui=bold
    set guicursor=n-v-c:block-nCursor,
               \i-ci-ve:ver20-nCursor,
                  \r-cr:hor10,
                     \o:hor50,
                    \sm:block-blinkwait175-blinkoff150-blinkon175
        " 代替了:
            " ¿let¿  $NVIM_TUI_ENABLE_CURSOR_SHAPE =1
            " mobaxterm里insert mode还是方块。vscode里是正常的

    set noemoji

    set nolist
    "\ set list
    set ambiwidth=single
    set listchars=conceal:\ ,tab:→\ ,trail:¶,nbsp:◐
    set listchars+=precedes:«,extends:»
    "              " 没见过这2个


    " gui/neovide:
        au AG VimEnter if exists('g:wf_vidE') | call s:Vim_enter_neovide() | endif
        fun! s:Vim_enter_neovide()
        "\ 下面的导致 在init.vim等文件 敲ctrl s会报错, F5不会
            "\ see /home/wf/PL/help_me/doc/channel.txt

            if exists("g:neovide")
                " Put anything you want to happen only in Neovide here
                let g:neovide_cursor_trail_length     = 0.1

                let g:neovide_cursor_animation_length = 0.13
                let g:neovide_scroll_animation_length = 0.1
                    "\ how long the scroll animation takes to complete, measured in seconds.
                "\ let g:neovide_remember_window_size    = v:true

                let g:neovide_underline_automatic_scaling = v:false

                    "\ let g:neovide_transparency=0.5  "  别装逼
                    " let g:neovide_fullscreen=v:true  导致输入法看不见等问题
            endif
        endf


        au AG UIEnter *   if exists('g:wf_vidE') | call Gui_iniT() | endif
            fun! Gui_iniT()

                " wsl和在windows下
                    " neovide用--remote
                    " 不太一样

                set guifont=Hack_Nerd_Font_Mono:h14
                    "\ 不加这行时, 打开neovide后中文会加粗
                " set guifont=JuliaMono\ Nerd\ Font:h14
                "             Hack\ NF\ Regular:h14   这个 没有icon
                    "\ 这里有几个字体
                        "\ https://github.com/ryanoasis/nerd-fonts/blob/19237f121dd209656a1a16e3299f56f5e9801d84/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf

                "\ set guifontwide=微软雅黑
                    " 和它应该没关系: set ambiwidth=single
                    "\ You can  set 'guifont' alone,
                        "\ the Nvim GUI will try to find a matching 'guifontwide' for you.

                "\ set lines=999  "\ 避免窗口底部出现 没用上的空白行 (从笔记本屏幕 切到外接时 会出现)

                "\ 谁教的?
                    "\ let g:gui = filter(
                    "\             \ nvim_list_uis(),
                    "\             \ {arg1, arg2 -> arg2.chan == v:event.chan },
                    "\           \ )[0].rgb
                    "\          " 关于[0]: 我遇到的情况, 一般只有一个UI

                "\ 如果在UIEnter时用这些: 会导致neovide卡死, (因为调用channel-id 1 ?)
                "\ see /home/wf/PL/help_me/doc/channel.txt
                    "\ let g:neovide_cursor_trail_length     = 0.1

                    "\ let g:neovide_cursor_animation_length = 0.13
                    "\ let g:neovide_scroll_animation_length = 0.1
                    "\     "\ how long the scroll animation takes to complete, measured in seconds.
                    "\ "\ let g:neovide_remember_window_size    = v:true
                    "\
                    "\ let g:neovide_underline_automatic_scaling = v:false
                    "\
                    "\     "\ let g:neovide_transparency=0.5  "  别装逼
                    "\     " let g:neovide_fullscreen=v:true  导致输入法看不见等问题

                " https://github.com/sisrfeng/gui-zoom-in
                fun! ZooM(in_out)
                    let l:font_size  = matchstr(&guifont, '\v:h\zs\d+$')
                    let l:new_size = (a:in_out == 'in'
                                    \ ? l:font_size + 1
                                    \ : l:font_size - 1
                                   \)

                    let &guifont =  substitute(
                                         \ &guifont    ,
                                         \ ':h\zs\d\+$'       ,
                                         \ l:new_size ,
                                         \ ''            ,
                                       \ )

                endf

                    nno =      <cmd>call ZooM('in' )<cr>
                    nno -      <cmd>call ZooM('out')<cr>
                    nno <M-->  <cmd>call ZooM('out')<cr>
                       "\ neovide 用不了ctrl -
            endf



" • 插件vim_current_word的设置
    let g:vim_current_word#highlight_delay                  = 1000 " 毫秒 , 避免光标一到就一堆高亮 干扰
    let g:vim_current_word#highlight_only_in_focused_window = 1
    let g:vim_current_word#highlight_current_word           = 1
    let g:vim_current_word#highlight_twins                  = 0
    let g:vim_current_word#excluded_filetypes               = [
                                                        \ 'markdown',
                                                        \ 'help',
                                                        \ 'tex',
                                                        \ 'man',
                                                        \ 'w3m',
                                                       \ ]

    " 作者教的是用BufAdd, 不合理?
        " 非也
        " 这个设为0后, no effect even you set it back to 1:  vim_current_word_disabled_in_this_buffer
    au AG BufAdd  NERD_tree_*,term://*,*.help    :let b:vim_current_word_disabled_in_this_buffer = 1
                             "term://* 没生效
                                     " *.help没生效

" • 符号提示
                 "
    " hi link Whitespace DebuG
    " hi link NonText DebuG

" • 折叠
    " todo: 进了7000行的option.txt设置过fold就会很卡, 哪怕此后set nofoldeanble


    set foldtext=MyFoldText()
            fun! MyFoldText()
                    let line = getline(v:foldstart)
                    " let sub = substitute(line, '^ ', '>', 'g')
                    " return sub .. '      ⚑'
                    let _len = len(line)
                    if _len < 50
                        return line .. repeat(' ', 50 - _len) ..'  ░'
                    el
                        return line[:49] .. '  ░'
                    en

                    " " 不能替换开头?
                    " let line = getline(v:foldstart)
                    " let line = substitute(line, '^\s4', 'aaaa')
                    " " return sub .. '      ⚑'
                    " let _len = len(line)
                    "
                    " if _len < 90
                    "     return line
                    " el
                    "     return line[:89]
                    " endif
            endf


    set foldminlines=1 " 行数太少就别fold了
    set foldcolumn=0
    set foldmethod=indent
    set foldlevelstart=3
        " 大部分fold的option, 都是local to window的, 除了他
        " start insert的时候, n层以上才折叠

    set foldcolumn=0
                  "auto":       resize to the minimum amount of folds to display.
    " set foldignore=#,;"
    set foldignore=
    set foldnestmax=10

    set fillchars=
        set fillchars+=fold:\ ,              "     filling 'foldtext', 空格要escape
        " " set fillchars+=foldsep:\ ,          " open fold middle marker (在foldopen和close中间的)
        " set fillchars+=foldopen:∨,            " mark the beginning of a fold
        " set fillchars+=foldclose:∧,           " "show a closed fold
        "
        if exists('$Nvim_sockeT')
           hi clear VertSplit
        el

            set fillchars+=vert:█
                " https://www.reddit.com/r/vim/comments/effwku/comment/fc3z9mq/?utm_source=share&utm_medium=web2x&context=3

                aug  Vertsplit_colors
                    au!
                    " Listen for VimEnter event in case no colorscheme is set.
                    au ColorScheme,VimEnter *
                        \ hi clear VertSplit |  hi VertSplit term=reverse cterm=reverse gui=reverse
                aug  END
        en

    set foldopen=block,
                \hor,
                \insert,
                \jump,
                \mark,
                \percent,
                \quickfix,
                \search,
                \tag,
                \undo


    " toggle fold
        " au AG BufEnter,BufWinEnter * if &buftype != 'terminal' |  exe 'normal! zv' | endif
        " au AG BufEnter * exe 'normal! zv'
                     " 这在terminal buffer会出错?
                                      " 上千行的文件, fold了会很卡
        "\ au AG BufRead * if line('$') < 2000 | call Fold_each_buf() | else | setl  nofoldenable | endif
            " 读进来的文件, 默认折叠1级
            " ReloaD时, 不会触发 🔑BufRead 我的配置文件🔑
                " 这两个autocmd 会进else:
                    " au AG SourcePre  * if exists('g:do_not_change_fold') | echom '不改fold'  | else | echom '进了else' | endif
                    " au AG SourcePost * if exists('g:do_not_change_fold') | echom '不改fold___post' | else  |  echom '进了else' | endif

             func! Fold_each_buf()
                 set foldenable
                 set foldlevel=2
                 let b:folded = 1
                              " zM  Close all folds: set 'foldlevel' to 0.
                              "     'foldenable' will be set.
                 " silent! normal! za
                 " echom '折叠<-'
                 " 会echo很多遍 为啥?
             endf



            func! Fold_01()
                if exists('b:folded')
                    " silent! normal! zR
                                     " R: 记作 暴力remove?
                                   " Open all folds.
                                   " This sets 'foldlevel' to highest fold level.
                                   " 不如自己设foldlevel? 懒得记zR zM啥的
                    set foldlevel=8

                    echo '展->>>'
                    unlet b:folded
                el
                    set  foldmethod=indent
                    let b:folded = 1
                    silent! normal! zM
                    silent! normal! za
                    echo '折<<-'
                en
            endf

            nnor <leader>z :call Fold_01()<cr>zz<cr>

        " todo: 进了7000行的option.txt设置过fold就会很卡, 哪怕此后set nofoldeanble
            " au AG BufEnter  * if &ft == 'help' | setl  foldexpr=VimHelp_fold() foldmethod=expr | endif
            "     function! VimHelp_fold()
            "         let thisline = getline(v:lnum)
            "         if thisline =~? '\v^\s*$'
            "             " 开头 + any number of spaces + 结尾
            "             return '-1'
            "             " use the fold level of a line before or after this line, ( 二者取min)
            "         endif
            "
            "         if thisline =~ '^========.*$'
            "             return 1
            "         else
            "             return indent(v:lnum) / &shiftwidth
            "         endif
            "     endf


    " nnor ,          :set foldmethod=indent<cr>zazz
    " vnor ,      <cmd>set foldmethod=indent<cr>zazz
    " nnor ,,          :set foldmethod=indent<cr>zazz
    " vnor ,,      <cmd>set foldmethod=indent<cr>zazz
    "
    nnor f           :set foldmethod=indent<cr>zazz
    vnor f       <cmd>set foldmethod=indent<cr>zazz

                                                   " za: a记成alter吧, 打开已折叠的 或关上未折叠的
    au AG BufEnter *.{md,markdown} nnor <buffer> <BS>   <cmd>set foldmethod=manual<cr>zazz

    " 控制foldlevel
        " less
            nnor zl zr:echo '折叠强度' &foldnestmax-&foldlevel<cr>
            nnor zL zR:echo '折叠强度' &foldnestmax-&foldlevel<cr>
            " nnor zl zr<cmd>echo &foldlevel<cr>
            " nnor zL zR<cmd>echo &foldlevel<cr>
        " more
            nnor zm zm:echo '折叠强度' &foldnestmax-&foldlevel<cr>
            nnor zM zM:echo '折叠强度' &foldnestmax-&foldlevel<cr>
            " nnor zm zm<cmd>echo &foldlevel<cr>
            " nnor zM zM<cmd>echo &foldlevel<cr>

        "\ nnor go  zM
        nnor go  <cmd>call Smart_out_linE()<cr>


            " zm: m表示more
            " zl: l表示less

                " 应该不需要了, zl zm就行:
                     " nnor <leader>,o :set foldlevel=0<cr>
                                 " o比0好敲
                                 " 啊, 中指和无名指不协调
                     " nnor <leader>,, :set foldlevel=0<cr>
                     " nnor <leader>,1 :set foldlevel=1<cr>
                     " nnor <leader>,2 :set foldlevel=2<cr>
                     " nnor <leader>,3 :set foldlevel=3<cr>



" • manpage
    let g:ft_man_folding_enable=1
               " Fold manpages with foldmethod=indent foldnestmax=1
    let g:man_hardwrap=0
    "\ let g:man_hardwrap=1
        " ⛅real reformatting of the text by inserting newline characters
        " 设置hard wrapping后的长度
            " 1. $MANWIDTH
            " 2. or window width if $MANWIDTH is empty



" • 换行 wrap
    " 每行超过 n 个字的时候 , vim 自动加上换行符
        set textwidth=150  " 150快到尽头了
               " 设大点, 避免我的输入被自作主张断行
               " 复制来特别长的文本才让vim自动断行
               " 设了textwidth, 它就没用了:  set wrapmargin=20
        au AG BufEnter * if &filetype == 'markdown' | setl  textwidth=100  tabstop=4  shiftwidth=4   | endif
                                                                                        "\ set list
    " ••  wrap
        set wrap
        set cursorlineopt=screenline
       " 有man_hardwrap选项, 其实跟textwidth 差不多? hardwrap误导人?
       " 叫做softwrap更合适? (实际没有这个option)

        " set wrapscan  " 跟spellcheck相关, 别开
        " set columns=80
             " 导致屏幕很乱, 超过80列的内容乱跑:
                " use :set nuw to see how many columns the line numbers are occupying, let's call this nuw.
                " then use :set columns=x where x = (the number of columns you want + nuw).


        " set nolinebreak
        "   这个名字很傻逼, set nolinebreak, 不是不break a line (要wrap肯定要break long line)
        "                                    而是会很死板地在最后一个字符处break line
        set linebreak
            " 换行时 只能在breakat指定的字符处切开
            " Unlike  'textwidth, this does 💛not insert <EOL>s💛 in the file,
            " set breakat="某某"
                " This option lets you choose which characters might cause a line  break if 'linebreak' is on.  Only works for ASCII characters.
                " default " ^I!@*-+;:,./?"

            set breakindent
                " break line时假装indent
                " thus preserving horizontal blocks  of text.

            set showbreak=.
                        " 记作:书接上一回
            " 即sbr
            " append '..' to indent
        set breakindentopt=shift:1,min:80,sbr
        " set breakindentopt=shift:1,min:40
            " indent by an additional <shift> characters on wrapped lines,
            " when line >= <min> characters, put 'showbreak' at start of line


    au AG BufEnter */doc/*.txt if &buftype == 'help' | setl  syntax=help modifiable | endif
                                         " 这几个不用加? filetype=help noreadonly breakindentopt=
                                         " 在 /home/wf/dotF/cfg/nvim/ftdetect/help.vim 里面设了也不行, 要在这里
            " 留作翻阅:
                " au AG BufAdd   * if &buftype == 'help'
                "                  " buftype在BufAdd之后才更新, 导致这些autocmd滞后一次?
                "                        " filetype的识别 貌似滞后于BufEnter等
                "     " reloaD如何触发BufEnter等?
                " " au AG BufEnter */doc/*.txt   if &syntax == 'text' | setl   syntax=help filetype=help nolist | echom b:current_syntax | endif
                "         " 不生效:
                "         " au AG BufEnter */doc/*.txt   if &ft == 'text' | setl   syntax=help | echom b:current_syntax | endif
                " au AG BufRead,BufNewFile */doc/*.txt    if &ft == 'text' | setl   syntax=help filetype=help nolist | echom b:current_syntax | endif

    source $nV/fmt.vim

    nnor <silent>   <leader><leader>  <Cmd>call TOC_jump()<CR><CR>
    " 现在只能在toc所在buffer用?
        fun! g:TOC_jump()
            let jump_lnum = 1
            let lnum_above = 1
            for l_num in g:TOC_line_nums
                if l_num > g:Current_Line_nuM
                    let jump_lnum = lnum_above
                    break
                el
                    let lnum_above = l_num
                en
            endfor

            norm! gg
            call search(jump_lnum)
            " Decho jump_lnum
        endf


