"\ set debug=throw 害惨我了, 导致bufnr('asdfasdf')等return -1的情况, 会报错


"\ todo: 更新了0.8, 看一下这个往后的change
:"\ https://github.com/neovim/neovim/issues/14090#issuecomment-1176727016

"\ https://github.com/neovim/neovim/releases/tag/v0.8.0



"\ You may disable this provider (and warning) by adding `let g:loaded_perl_provider = 0` to your init.vim
"\ checkhealth里:
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0

set backupext=vim_bk
set matchpairs+=<:>
set write

" 1. 文件路径
    "\ let $nV = $cfg_X . "/nvim"
        "\ 在敲brew edit开nvim时, nV无法识别
        "\ 改为在/home/wf/dotF/zsh/zshenv.zsh定义

    if exists('g:vscode')
        let $MYVIMRC =  $nV.."/init.vim"
    en
    let $has_vscode = $nV.."/has_vscode.vim"
    let $no_vscode =  $nV.."/no_vscode.vim"


    " 每次调用nvim,
        " 都会先执行某python环境下的site-package目录下的一些文件
        " 比如
        " /home/wf/.local/lib/python3.10/site-packages/usercustomize.py"
        " 里面有import pretty_errors
            " try:
            "     import sys
            "     #  print(sys.path)  加了这个print, 导致Prompt string里的git提示报错
            "     import pretty_errors
            " except ImportError:
            "     print('进入usercustomize文件')
        "  如果没装, 会有except


" 2. 让配置变更立即生效
so $nV/ReloaD.vim

let mapleader = " "
    " 要放在leaderf等插件前, 不然它们认为leader键是backslash?

" 3. options
    set confirm
"
" 自动切nvim到当前文件所在路径, 避免leaderF每个命令前都要敲一下 :pwd.
    " 代替autochdir:  Switch to the directory of the current file unless it breaks something.
    au AG BufEnter * call AutoDiR()
    func! AutoDiR()
        " Don't mess with vim on startup.
        let should_cd = (!exists("v:vim_did_enter") || v:vim_did_enter)
                                                  " 或
                                " v:vim_did_enter :
                                "     0 during startup
                                "     1 just before VimEnter.
        "  forbid for some filetypes
            " let should_cd = should_cd && david#init#find_ft_match(['help', 'dirvish', 'qf']) < 0
        " Only change to real files:
        let should_cd = should_cd && filereadable(expand("%"))
                                    " filereadable()
                                            " The result is a Number, which is |TRUE| when a file with the
                                            " name {file} exists, and can be read.
        if should_cd
            silent! cd %:p:h
        en
    endf

    " cdh:   cd here
    nno cd :cd %:p:h<cr><cmd>pwd<cr><cmd>let g:Lf_WorkingDirectory=getcwd()<cr><cmd>echo "Lf目录:"..g:Lf_WorkingDirectory<cr>
    " nno cdh
    cnorea <expr> cdh ( getcmdtype() == ":" && getcmdline() == 'cdh') ?
                      \ 'cd %:p:h<cr>  :pwd<cr>'
                      \ :  'cdh'


    " 方法2: 不好使? 要敲一次pwd触发?
        " au AG VimEnter * set autochdir | pwd | echom '设置了autochdir'
                                " Note: When this option is on,  some plugins may not work.
    " 貌似不行:
        " Plug 'https://github.com/airblade/vim-rooter'


    " 对于vscode-nvim
        " vscode用wsl的nvim作为bin时,pwd永远是Microsoft VS Code.  等邮件通知更新吧. 其实不影响使用?
        " 我的笔记: https://github.com/vscode-neovim/vscode-neovim/issues/520#issuecomment-1013853745
        "
        "  这个也不行:
        " au AG BufEnter * silent! lcd %:p:h
                " lcd: local window cd ?
                "      Like |:cd|, but only set the current directory for the  current window.

source $nV/begin_PL_end.vim

lua require('my_cfg')
"\ 这行要在vim-plug启动后, 因为my_cfg.lua有插件的配置
    "\ 之前在ReloaD里, 是放错了?


" search:  不搜注释内容
    set incsearch  " INCremental searching
    set ignorecase smartcase
                " \c: 不分大小写
                " \C: 分
        " set smartcase applies only when set ignorecase is already active


    fun! Char_at_Cursor()
        let substr = strpart(getline('.'),   col('.') - 1)  " 复制当前行 从光标所在列左边 到行末
        return  strcharpart(substr, 0, 1)
    endf

    func! Echo_char()
        let _char = Char_at_Cursor()
        if _char == ' '
            let show = '空格'
        elseif  _char == ''
            "\ let show = '没有字符'
            echo  '无字符'
            return
        elseif  _char == '	'
            let show = '<Tab>'
        elseif  _char == ''
            let show = '\e (escape)'
        elseif  _char == ''
            let show = '^M 即\r 即 回车'
        " elseif  _char == '^ @\'\'
            " let show = 'Null'
            " 不行, ¿/\n¿能高亮出换行符, 但在那位置执行本函数, 显示"没有字符"
    "                   这里^ @本来是插入Nul, 但导致rg搜不到本文件的内容
        elseif  _char == ''
            let show = '\b  backspace'

        elseif  _char == ''
            let show = '^K 即\v, 垂直制表符'
        elseif  _char == ''
            let show = '^L  即\f, form feed'
            " <F1>等, 在打开的文本里, 以<F1>等的形式存在, 而非等caret形式
            " 所以这无效:
            " elseif  _char == '\x1b[11~'
            "     let show = 'F1'
        el
            let show = _char
        en

        let c_num = char2nr(_char)
        " if c_num > 128
        if c_num > -1
            echo 'code point: '
            echohl   In_Double_QuotE
                echo     c_num
            echohl   None
        en

        echo '字符是:'
        echohl   Stand_ouT
            echo  show
        echohl None
    endf

    " todo:
    " 将奇怪的空格转为ASCII的
    fun! Space_Unicode2ASCII(_char)
        if nr2char(a:_char) range(8192,8202)
            return ' '
        el
            return a:_char
        en
    endf

    fun! Echo_keyworD()

        if !exists(@k)
            if !exists('$' . @k)
                " echom '变量 或 环境变量' .  @k . ' 都不存在'
                if  exists('g:' . @k)
                   exe 'echom g:' . @k
                   return
                   " 自己手动在cmd里敲 echom any_var_var 不用加g:
                el
                   echom '变量 或 环境变量' .  @k . ' 都不存在, 加上g:也不存在'
                   return
                en
            el
                let @k = '$' . @k
                echom '环境变量'
            en
        en
        echom   @k . ' 是: '
        " todo: printf的用法待研究, 现在@o 和@k一样
            "\ let @o = printf('%10S', @k)
            " o for out
        exe 'echom' @k

        silent let @/ = "echom @k  |  exe 'echom'    @k  "
            " 方便往上翻历史,
            " ¿:¿寄存器是只读的, 用@/
                " silent let @/ = "echom @0  |  exe 'echom'   '"  "' .  @0  "
                                                        " 双引号里套双引号:失败
                " 直接在cmdline敲这个是可以的:
                    " ¿echom @0  |  exe 'echom'   '"  "' .  @0¿
                " silent let @/ = "exe 'echom'   @0 . '是: '  @0"
                                        " echom @0 '是:'  @0

    endf

    " want the character(发音k)
    nno <silent> wk    :call Echo_char()<cr>

                 " K: 记作keyword
    vno          wk   "ky:<c-u>call Echo_keyworD()<cr>
    vno          wK   "ky:<c-u>call Echo_keyworD()<cr>
    nno          wK      "kyiW:call Echo_keyworD()<cr>



    " ctrl and shift
        " map <c-s-a>
        " map <s-c-a>
            " 暂不支持
            " https://stackoverflow.com/a/47656794/14972148


" Handling files
    set autowrite

    au AG BufRead * if &fileformat != 'unix' | setl stl='dos格式_小心EOL' | en


    " 保存文件时删除多余空格
        func! g:End_whitE()
                let l = line(".")
                let c = col(".")
                %s/\s\+$//e
                call cursor(l, c)
        endf
        au AG FileType help,
                      \yaml,
                      \c,
                      \cpp,
                      \javascript,
                      \python,
                      \vim,
                      \sh,
                      \zsh,
                      \tex,
                      \latex,
                      \conf
            \  au AG BufWritePre <buffer> :call End_whitE()



             " terminal的filetype为空
             "                         如果改了插件的配置, 在plug_wf.vim里敲:Runtime还是不生效, 重启vim就行



    " Return to last edit position when opening files
    " https://askubuntu.com/questions/202075/how-do-i-get-vim-to-remember-the-line-i-was-on-when-i-reopen-a-file
    "                        ¿`"¿ last position before exit
    "                        ¿'"¿ last position before exit
    "                        adsfasdf

                            "\ ¿\"¿ :双引号套双引号 要escape
    au AG BufReadPost,BufEnter *
            \ let _last = line("`\"")
            \| if _last > 0 &&
                 \_last <= line("$")
            \|  exe 'normal! g`"'
            \| endif

            " \| echom '回去'




" 基础设置 options
    set title  " change the terminal's title
    set mouse=a  " enable mouse for n,v,i,c mode
    set mousehide  " Hide the mouse cursor while typing
    set selectmode=mouse

    set backspace=indent,eol,start
        " allow backspacing 删除:
                " indent   autoindent
                " eol      line breaks (join lines)
                " start    the start of insert; CTRL-W and CTRL-U stop once at the start of insert.

    set history=4000  " history存储容量

    set autoread  " 文件修改之后自动载入
                    " Generally after executing an ¿external¿ command


        " Triger `autoread` when files changes on disk
            au AG    FocusGained,BufEnter,CursorHold,CursorHoldI   *
            \       if mode() !~  '\v(c|r.?|!|t)'
                  \ &&  getcmdwintype() == ''
                    \|   checktime
                    \| endif

        " Notification after handling a file changed  on disk
        "\ 有点annoying:
            "\ au  AG    FileChangedShellPost
            "\   \  echohl WarningMsg
            "\   \|     echo "File changed by 其他程序or另一个buffer. Buffer reloaded."
            "\   \| echohl None

    " shortmess: short messages, 简略提示
    set shortmess=filnxToO
        set shortmess+=I  " 启动的时候不显示多余提示, 要看版本敲:version
        set shortmess+=t
        set shortmess+=F  " F don't give the file info when editing a file, like :silent


    " 自动判断编码时，依次尝试以下编码：
        set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1,big5,eu
        set fencs=utf8,gbk,gb2312,gb18030


" swap file
    "\ source $nV/noswapsuck.vim
        "\ 没啥用, 我已经把不需要swapfile的文件都设置好了

    " PL 'gioele/vim-autoswap'
        " 装了没啥变化，neovim本身就可以实现：多个窗口编辑同一个文件时，只要一个窗口保存了，
        " 跳到另一个窗口，会看到变化

    "

" share data
        set shada='300
        "\ 会导致慢?
        "\ 方便使用:History
        "         " This parameter must always be included when  'shada' is non-empty.
        "
        "         " 使得 the |jumplist|
        "         " and the  |changelist| are stored in the shada file.
        "             " 单引号 对应mark
        "             " Maximum number of previously edited files for which
        "             " the marks  are remembered.
        " " 默认  记录所有A-Z和0-9 marks  (它们是global marks, 又叫file marks?)
        " set shada+=!
        " set shada+=h
        " set shada+=<200
        "         "   Maximum number of lines saved for each register.
        "         "   太大会导致启动慢
        " set shada+=s100
        "             " s: size 有点复杂 KiB
        " set shada+=%30
        "             " buffer list里的最大文件数
        "                "  If Vim is started without a file name argument,
        "                "  the  buffer list is restored from the shada file
        "
        " set shada+=r/tmp
        " set shada+=r~/.t/tmp.vim

" mksession
" Views and Sessions are a nice addition to ShaDa files
    set sessionoptions+=terminal
    set sessionoptions+=winpos
    set sessionoptions-=curdir
    set sessionoptions-=folds
                          "\ 缺点:
                          "\ changes in the file between saving and loading the view
                          "\     will mess it up.
                      " 其他的选项应该没啥用

    nno <M-s> <Cmd>wa
             \<Bar>exe "mksession! $cache_X/nvim/sess_leo.vim"<CR>
             \:qa


"\ set updatetime=300  \ 之前设这么小, 不太好?
    " longer updatetime (default is 4000 ms )
    " leads to  delays and poor user experience.


" :call func! funcS#Conceal_tmp()


set isprint=@,161-255  " 默认值
    " set isprint+=9  " 9代表tab，设了会导致排版错乱
    " set isprint=1-255  " 设了屏幕会很乱  " Stack Overflow有个傻逼回答，别信


source  $nV/term.vim
source  $nV/cmdline.vim    " command.vim  cmd.vim

" source各种文件
" begin_PL_end.vim早点source, 便于覆盖?
" todo: 改成Runtime? 只会source第一个找到的文件, 但好像改了文件后 :Runtime不更新内容
" 我的map
" (分插件相关的, 且较短的, 在PL.vim)
    source $nV/map.vim
    source $nV/b_map.vim
    source $nV/clipboard_regis.vim
    source $nV/look外观.vim


    " 涉及quickfix
    " set errorformat='leo_says__this_take_effect'
    " " set errorformat='%f' let &errorformat = '[%m]%*[ ][%t%*[A-Z]]%*[ ][%n]%*[ ][%f:%l]'
        " It's a relatively unpleasant thing to parse with errorformat to be sure,
        " but you can do if you insist.
        " One possible approach:
        " https://stackoverflow.com/questions/41738081/vim-how-to-set-errorformat-in-my-specified-error-message-format


au AG BufRead,BufNewFile *.{zz,z} setfiletype zsh


if !exists('g:vscode')
    source $no_vscode
el
    source $has_vscode
en



"\ -----------------
"\ 我删掉了多余的help tag

" 避免去官方的help文件里的help tag 在tag的补全时冒出来,
" 删掉了官方的doc
"\ 然后   set helpfile=~/PL/help_me/doc/help.txt
"\ 失败:  E484: Can't open file ~/PL/help_me/syntax/syntax.vim

"\ workaround:
    "\ ~/PL/help_me/doc/help.txt   链到了原官方路径 (官方doc只剩这个soft link和自动生成的tags)
