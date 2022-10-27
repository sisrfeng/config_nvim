PL 'https://github.com/sisrfeng/pluger'
" 分场合使用vim-plug
    func! VimPlugConds(arg1, ...)
        " Lazy loading,
        " my preferred way, as you can have both [避免被PlugClean删除没启动的插件]
        " https://github.com/junegunn/vim-plug/wiki/tips
        " leo改过

        " a: 表示argument
        " You must prefix a parameter name with "a:" (argument).
            " a:0  等于 len(a:000)),
            " a:1 first unnamed parameters, and so on.  `a:1` is the same as "a:000[0]".
        " A function cannot change a parameter

                " To avoid an error for an invalid index use the get() function
                " get(list, idx, default)
        let leo_opts = get(a:000, 0, {})  "  a:000 (list of all parameters), 获得该list的第一个元素
        " Borrowed from the C language is the conditional expression:
        " a ? b : c
        " If "a" evaluates to true, "b" is used
        let out = (a:arg1 ? leo_opts : extend(leo_opts, { 'on': [], 'for': [] }))  " 括号不能换行
        " an empty `on` or `for` option : plugin is registered but not loaded by default depending on the condition.
        return  out
    endfunc

"\ PL 'https://github.com/sisrfeng/test-vimL'
    "\ vim-plug作者搞的test framework

if !exists('g:vscode')
    "\ PL 'https://github.com/sisrfeng/pencil'  "\ 智能处理缩进, 需要再研究
    PL 'https://github.com/sisrfeng/markdown'
        let g:vim_markdown_toc_autofit = 1
        "\ let g:vim_markdown_math = 1    导致 syn include @tex syntax/tex.vim
                                "会source  /home/wf/dotF/cfg/nvim/after/syntax/tex.vim
        let g:vim_markdown_auto_insert_bullets = 0
        let g:vim_markdown_new_list_item_indent = 0


    PL 'https://github.com/godlygeek/tabular'
    " 不及vim-easy-align? 看着没多啥功能  " 但vim-markdown依赖于它
          "\ let g:tabular_loaded = 1
          "     inor <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
          "
          "
          "     func! s:align()
          "       let p = '^\s*|\s.*\s|\s*$'
          "       if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
          "         let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
          "         let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
          "         Tabularize/|/l1
          "         normal! 0
          "         call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
          "       endif
          "     endfunction


    "\ PL 'APZelos/blamer.nvim'
        "\ inspired by VS Code's GitLens plugin

    " todo:
        " 号称强于nerdtree
        " 先看说明再用, 应该真的快, 号称fast as fuck等coq.vim的作者出的
        " PL 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

    PL 'preservim/nerdtree'
        " move (rename) / delete file, 代替netrw
        " nnor <c-t> :NERDTreeFind<CR>

        " PL 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }  " 会报错

        " 自动进nerdtree
            " au AG StdinReadPre * let s:std_in=1
            " au AG VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

    PL 'https://github.com/sisrfeng/git-vim'  "  /tpope/vim-fugitive'
    PL 'https://github.com/sisrfeng/git-vim_lens'
        let g:blamer_date_format = '%y年%m月%d日'

    PL 'https://github.com/sisrfeng/jupytext'
        let g:jupytext_print_debug_msgs = 1

    PL 'https://github.com/sisrfeng/csv'

    "\ todo:
    "\ PL 'https://github.com/sisrfeng/git_hub-vim'
    PL 'https://github.com/sisrfeng/v-shell'  "\  tpope/vim-eunuch (太监)

    PL 'https://github.com/sisrfeng/conceal-er'  " 随时interactive conceal
    PL 'https://github.com/sisrfeng/lib-of-ikk'

    PL 'https://github.com/sisrfeng/tags-er'  " gutentags
        let g:gutentags_ctags_tagfile = '.tags-er'

    PL 'https://github.com/sisrfeng/to-definition'  " misterbuckley/vim-definitive
                " Languages currently supported by default:
                                                " Python
                                                " Vimscript
                                                " Shell scripts
                                                " Javascript
                                                " Typescript
                                                " JSX
                                                " PHP
                                                " Ruby
                                                " Elixir
                                                " Scala
        vno wl "ly:FindDefinition <c-r>l<CR>
          " want location

    "\ PL 'https://github.com/sisrfeng/org-mode'
    "\ PL 'https://github.com/sisrfeng/org_mode_lua'
    PL 'https://github.com/sisrfeng/n-org'


    " 奇怪了: 先进入官方的syntax/tex.vim, 再进插件的
    PL 'https://github.com/sisrfeng/vimtex', {'as':'TeX'}
        source $nV/tex插件cfg.vim

    "\ PL 'https://github.com/sisrfeng/rst'


    "\ PL 'https://github.com/sisrfeng/debugS'  \ 对nvim不友好, vim友好
        "\ fork of 'vimspector'
    "\ todo: 代替pudb? (pudb里的语法高亮很差)
    PL 'https://github.com/sisrfeng/DebugAP'    "\ lua写的
        "\ todo: 开始debug才map
        nno  <silent> <M-c>         <Cmd> lua require'dap'.continue()<CR>
        nno  <silent> <M-l>         <Cmd> lua require'dap'.step_over()<CR>
                         "\ l leap 跳跃

        "\               <C-i>   不是说能区分ctrl i和tab了吗, 为啥还是不行, 问题出在tmux?
        "\               <F10>
        nno  <silent> <M-i>        <Cmd> lua require'dap'.step_into()<CR>
        nno  <silent> <M-u>        <Cmd> lua require'dap'.step_out()<CR>
                         "\ u: up,  <M-o>被用了


        nno  <silent> <Leader>B    <Cmd> lua require'dap'.toggle_breakpoint()<CR>

        "\ nno  <silent> <Leader>B    <Cmd> lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
        "\ nno  <silent> <Leader>lp   <Cmd> lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>

        "\ nno  <silent> <C-x>   <Cmd> lua require'dap'.repl.open()<CR>  \ 用了debugAP-ui, 不需要手动开
        "\ nno  <silent> <Leader>dl   <Cmd> lua require'dap'.run_last()<CR>

        PL 'https://github.com/sisrfeng/debugAP-ui'
            nn   <F29>     : lua require("dapui").toggle()<cr>
            nn   <c-F5>     : lua require("dapui").toggle()<cr>
            vno  <M-k>      <Cmd>lua require("dapui").eval()<CR>

        PL 'https://github.com/sisrfeng/py-debugAP'  "\ 依赖于pip install debugpy  (github.com/microsoft/debugpy)


    " PL 'https://github.com/python-mode/python-mode'
    "                                           用到quickfix list
    "plug 'https://github.com/tonyxty/quickfix.py'
    "
    " 另外:
    " 有:help compiler-pyunit
      " setl     makeprg=./alltests.py " Run a testsuite
      " setl     makeprg=python\ %:S   " Run a single testcase

      source $nV/comE.vim
                  " come on,   COMplete Expand
en


PL 'https://github.com/sisrfeng/abbr'
    " " 貌似只有insert mode 的abbr, 没有cnoreabb?
    " nno <silent> <f3> :amLoad nt_en<CR>
                                  " nt: nature language

PL 'https://github.com/sisrfeng/vista'

" language specific
    " Plug 'https://github.com/goerz/jupytext.vim'
    "
PL 'https://github.com/sisrfeng/mk-session'  "\ obsession

" lua support and plugins
    "todo: 如何科学管理lua写的插件?
        " packer: lua版的plugin manager
            "\ :h packages
            " 别managing some plugins with packer and some with another plugin manager
            "\ packer 还不完善
            "\ https://jdhao.github.io/2021/07/11/from_vim_plug_to_packer/

    " 没啥特别功能
    "\ Plug 'https://github.com/bfredl/nvim-luadev'
        " nnor gl <Plug>(Luadev-RunLine)
        "    " go lua
        " nnor wl   <Plug>(Luadev-RunWord)
        "    " what in lua
    "
    PL 'https://github.com/sisrfeng/lua-funcs'  "\ PL 'nvim-lua/plenary.nvim', {'as':'plenary'}
                                "\ 先用我做过笔记的
                                "\ 这插件目前天天更新, 先不跟
                                "\ 没有help, 只有readme.md
                                    "\ plenary: 完全的
                                    "\ All the lua functions I don't want to write twice.

        PL 'https://github.com/sisrfeng/reLoad'
            " todo: https://github.com/ibhagwan/nvim-lua/blob/main/lua/plugins/nvim-reload/init.lua
            " https://www.reddit.com/r/neovim/comments/tkkj2v/comment/i3foyve/?utm_source=share&utm_medium=web2x&context=3

        " todo: 尝试这几个
            " https://github.com/Konfekt/FastFold
                                                " 貌似要求foldmethod设为manaul
            " PL 'https://github.com/tmhedberg/SimpylFold'
                                              " 专门处理python, 不折叠for while
            PL 'https://github.com/sisrfeng/no-brace'
            "\ todo: 这插进很智能?
            " au AG FileType python,txt   BracelessEnable +indent +fold
                " for indent language, like python
                " 处理fold和indent等
                " 但貌似要求foldmethod设为manaul

                "
            " PL 'https://github.com/embear/vim-foldsearch'
            " PL 'https://github.com/pseewald/vim-anyfold'
            "

            " 处理大文档时, 把某部分单独拎出来
            " PL 'https://github.com/chrisbra/NrrwRgn'


            " https://github.com/kana/vim-smartinput
            "
        " PL 'https://github.com/romainl/vim-cool'

        " PL 'https://github.com/dense-analysis/ale'

    " treesitter依赖于:
        "\ PL 'https://github.com/MunifTanjim/nui.nvim'
        PL 'https://github.com/sisrfeng/nUI'
        "
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    "\ PL 'https://github.com/sisrfeng/TS', {'do': ':TSUpdate'}
        " 改颜色 :h hl-TSBoolean
                               " :TSUpdate
                                " make sure that
                                " all installed parsers
                                " are updated to the latest version via
                    " https://github.com/nvim-treesitter/nvim-treesitter/issues/484
                    " https://github.com/neoclide/coc.nvim/issues/3345
      "  :TSinstall query regex typescript
        " set foldmethod=expr
        " set foldexpr=nvim_treesitter#foldexpr()
        " This will respect your foldminlines and foldnestmax settings.

        PL 'https://github.com/sisrfeng/play-TS'   "\ PL 'nvim-treesitter/playground'  仅用于开发colorscheme等
        " PL 'https://github.com/p00f/nvim-ts-rainbow'  " 有点鸡肋




PL 'sisrfeng/toggle-bool'

" leaderf里有这个keybind，我这里覆盖掉
nor <leader>b :ToggleBool<CR>

" 貌似比gundo和mundo好

PL 'https://github.com/sisrfeng/undotree'

    nno  U :UndotreeToggle<CR>
         " U is seldom useful in practice,
    let g:undotree_DiffCommand        = 'diff'

    " persistent undo (unload buffer后还能undo)
        "\ 用nvim默认的路径, 别设下面的了 (尽管undotree插件作者说, 喜欢自己diy这个路径. 但还是听nvim官方的比较好)
            "\ let path_undo = expand('$cache_X/.undo_nvim')
            "\ if !isdirectory(path_undo)
            "\     call mkdir(path_undo, "p", 0700) " create the directory and any parent directories
            "\ en
            "\
            "\ let &undodir = path_undo
            "\        " 因为path_undo是变量，所以要用&undodir, 不能直接set undodir
        set undofile

     " layout:
         if !exists('g:undotree_WindowLayout')
             let g:undotree_WindowLayout = 4
         en

         " " e.g. using 'd' instead of 'days' to save some space.
         if !exists('g:undotree_ShortIndicators')
             let g:undotree_ShortIndicators = 1
         en

         " undotree window width
         if !exists('g:undotree_SplitWidth')
             if g:undotree_ShortIndicators == 1
                 let g:undotree_SplitWidth = 24
             el
                 let g:undotree_SplitWidth = 30
             en
         en

         " diff window height
             let g:undotree_DiffpanelHeight = 5

         " auto open diff window
             let g:undotree_DiffAutoOpen = 0

         " if set, let undotree window get focus after being opened,
         " otherwise  focus will stay in current window.
             let g:undotree_SetFocusWhenToggle = 1

             let g:undotree_TreeNodeShape = '·'
             "\ let g:undotree_TreeVertShape = '|'

             let g:undotree_DiffCommand = "diff"

             let g:undotree_RelativeTimestamp    = 1

             let g:undotree_HighlightChangedText = 1

         " Highlight changed text using signs in the gutter
             let g:undotree_HighlightChangedWithSign = 1

         " Highlight linked syntax type.
         " You may chose your favorite through ":hi" command
             let g:undotree_HighlightSyntaxAdd    = "DiffAdd"
             let g:undotree_HighlightSyntaxChange = "DiffChange"
             let g:undotree_HighlightSyntaxDel    = "DiffDelete"

         if exists('g:undotree_SplitLocation')
             echo "g:undotree_SplitLocation is deprecated,
                         \ please use g:undotree_WindowLayout instead."
         en

             let g:undotree_HelpLine   = 0
             let g:undotree_CursorLine = 1


" todo:https://github.com/kevinhwang91/nvim-bqf

    " :cd {path to root directory}

PL 'AndrewRadev/linediff.vim'
PL 'https://github.com/rickhowe/diffchar.vim'
" https://github.com/powerman/vim-plugin-viewdoc  " 能看man/help/markdown/latex
PL 'https://gitee.com/llwwff/vim_help', {'do': ':helptags ALL', 'as':'help_me'}
                                                          " ALL
                                                          " " all ´doc´ ´directories´ in 'runtimepath' will be used.
        " 优先找这里的help, 没有再到nvim0.7.0的官方help里找

" vim的terminal
" 好像不需要那么多功能, 我现在有term.vim

    PL 'https://github.com/sisrfeng/internal-term'  "   :h terminal_help
        " let g:terminal_key = '<M-=>'
        "      " to toggle terminal window,
        " let g:terminal_cwd = 0
        "     " initialize working dir:
        "     " 0 for unchanged,
        "     " 1 for file path
        "     " 2 for project root.
        " let g:terminal_height = 20
        "     " new terminal height

    " PL 'akinsho/toggleterm.nvim'
            " set hidden
            " lua require("toggleterm").setup{} " 没动静
            " let g:toggleterm_terminal_mapping = '<C-t>'
            " nno <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
            " ino <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

    " 不太好用, 先只用neovim-remote.
        " 只有200star, 而且有点鸡肋. 我自己的tmap差不就够用了
        " PL 'nikvdp/neomux'  " 会导致terminal退出后, 多出一个split窗口
             " let g:neomux_win_num_status='窗:%{WindowNumber()}'
             " let g:neomux_winjump_map_prefix='<M-W>'

PL 'https://github.com/sisrfeng/scriptV'  " PL 'https://github.com/tpope/vim-scriptease'
"\ todo:
    "\ 参考  "\ https://github.com/tpope/vim-pathogen
    "\ 管理runtime, (其功能可被vim官方的功能代替, :help packages)
    "\ :Vopen, :Vedit, :Vsplit, :Vvsplit, :Vtabedit, :Vpedit, and :Vread have all moved to scriptease.vim.

PL 'https://github.com/sisrfeng/dev-nvim'
    "\ 用于开发nvim的.c, 几年内你都别碰啊


" todo代替ranger?:
" PL 'https://github.com/vifm/vifm.vim'



source $nV/fuzzy.vim

" todo:
    " PL 'https://github.com/tpope/vim-unimpaired  " 参考它 管理成对/相反的map
    " PL 'kana/vim-fakeclip'


    PL 'https://github.com/sisrfeng/w3m'
        " 用chrome吧, 详见map.vim
        " nno <C-Right>  viW"wy<esc>:-tab TW3m <c-r>w<cr>
        " vno <C-Right>  "wy<esc>:-tab TW3m <c-r>w<cr>
        nmap F         <Plug>(w3m-hit-a-hint)
            " ahk把capslock+w 变成了<C-right>
        let g:w3m#hover_set_on = 1
        let g:w3m#allow_long_lines = 1  " 默认是80列每行
        " unlet g:w3m#set_hover_on  " ReloaD时容易报错
        let g:w3m#hover_delay_time = 50
            " set delay time until highlighting
        let g:w3m#external_browser = '/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe'
        " 貌似用不了external的
        let g:w3m#search_engine    = 'https://www.google.com.hk/search?q=%s'
                                                "  默认的frogfind.com更适合text browser
                                                "  但排版不时会乱
        let g:w3m#history#save_file = $cache_X . 'vim_w3m_hist'


    " PL 'https://github.com/ashisha/image.vim'  " 没用, 不如用imcat
    PL 'https://github.com/sisrfeng/match_up'
        let g:matchup_matchparen_deferred = 1
        let g:matchup_matchparen_deferred_show_delay = 150
            " 看官网的Options部分, 貌似和sandwich有些重复
                "
        let g:matchup_matchparen_offscreen = {'method': 'status'}
        " let g:matchup_matchparen_offscreen = {'method': 'popup'}  " 可能挡住底下一行代码


    " todo: 尝试这个
    " plug 'https://github.com/Galicarnax/vim-regex-syntax'

    " PL 'https://github.com/sisrfeng/vim-polyglot'  " 我把原作者的改了几行
        " 1. A collection of language packs for Vim.
        "           On top of all language packs from vim repository.
        " 2. 并且一系列称为sensible的设置 (我disable了, 避免被搞乱)
            " let g:polyglot_disabled = ['sensible']
        " 3. 其提供的autoindent号称超越了: (但tpope最近有更新, 且和vim-polyglot有冲突)
            "\ PL 'https://github.com/sisrfeng/indent-OK'  "    PL 'https://github.com/tpope/vim-sleuth'
            "\ 有时shiftwidth变成24啥的

        " au AG BufEnter * set indentexpr=
           " disable reindenting of the current line in insert mode (see vim 'indentkeys')
           " 不然乱给我缩进




    " to_do:
    "   除了is.vim 应该都可以在vscode里用?
        "   必须禁用插件(就算不启用任何keymap  还是会在终端里输入奇怪的东西)
        " PL 'https://github.com/haya14busa/is.vim'
            " let g:is#do_default_mappings=0
        " 导致新开终端时, 有时会输入is-nohl?
            " 敲到一半时可以滚屏
            " cmap <c-d> <Plug>(is-scroll-f)
            "\ cmap <c-d> echom '先别用'
            " cmap <c-y> <Plug>(is-scroll-b)
            "
            " cmap <c-j> <Plug>(is-scroll-f)
            " cmap <c-k> <Plug>(is-scroll-b)

            " Automatically clear highlight (execute |:nohlsearch|) after N cursor
            " moves or other autocmd events (InsertEnter and InsertLeave).



        " 类似:
                " todo
                " https://github.com/pechorin/any-jump.vim

                "  PL 'kkoomen/vim-doge'
                "  PL 'mattn/emmet-vim'
                "  PL 'chaoren/vim-wordmotion'

                    " 去Vnote中找:  vim眼中的一个word


    " PL 'FredKSchott/CoVim', VimPlugConds(!exists('g:vscode'))
        " 要编译python+，难搞 放弃
        " 允许多人同时编辑一个文件。避免多处打开同一个文件


    " align相关
        " PL 'https://github.com/kg8m/vim-simple-align'
        " todo:号称比easy align简单
        PL 'https://github.com/sisrfeng/align'

        " todo: autopep8一键处理, 代替wrapA?
        "
        PL 'https://github.com/sisrfeng/wrapA'
            "\ wrap Arguments
            " PL 'https://github.com/FooSoft/vim-argwrap'
                                        " one arg one line
                " 参考: 对齐得很整齐 https://gist.github.com/raymond-w-ko/4208232

            nmap <silent>    <leader>a   <Plug>(wrapA_Toggle)

            au AG BufEnter *.vim,*/doc/*.txt    let b:wrapA_line_prefix = '\ '
                  " 用FileType不行

            let g:wrapA_tail_comma         = 0
                                            " 别设为1, lua里坑过自己..
            let g:wrapA_tail_comma_braces  =  '[({'

            let g:wrapA_padded_braces      =  '[{('
            let g:wrapA_tail_indent_braces =  '[({'
                             " 只能让closing的括号和arg对齐, 不能对齐到opening的括号

    PL 'https://github.com/sisrfeng/re-dot'
        " PL 'https://github.com/tpope/vim-repeat'

    " PL 'https://github.com/chentau/marks.nvim'
            " 在lua配置里
            "
            " 老是显示mark, 有点烦人
            " 需要时敲:marks 吧

    PL 'https://github.com/sisrfeng/last-cursor'
    " PL 'easymotion/vim-easymotion',    VimPlugConds(!exists('g:vscode'))
    " todo:
    " PL 'https://github.com/sisrfeng/jumpS'
    " PL 'https://github.com/sisrfeng/global_jumplist'
        " There is one jump list shared between all windows in a vim instance
    PL 'https://github.com/sisrfeng/vim-easymotion',    VimPlugConds(!exists('g:vscode'))
        " todo:
        " https://github.com/haya14busa/vim-easyoperator-line
        " https://github.com/haya14busa/vim-easyoperator-phrase
        " haya14busa/incsearch-fuzzy.vim
        " haya14busa/incsearch-easymotion.vim
    PL 'asvetliakov/vim-easymotion',    VimPlugConds(exists('g:vscode'), { 'as': 'leo-jump' })  " as的名字随便起，
            " PL 'easymotion/vim-easymotion'
            " vscode里用裸nvim下的easymotion  千万别这么干。会把正在编辑的文件全搞乱

            " 这样可能更容易理解，没那么绕: 【an empty `on` or `for` option : plugin is registered but not loaded by default depending on the condition.】
            " PL 'easymotion/vim-easymotion',  has('g:vscode') ? { 'as': 'easymotion_ori', 'on': [] } : {'as': 'easymotion_ori'}
            " PL 'asvetliakov/vim-easymotion', has('g:vscode') ? {'as': 'easymotion_vsc'}             : { 'as': 'easymotion_vsc', 'on': [] }
            "                                                                 " 【an empty `on` or `for` option :
            "                                                                 "    not loaded by default depending on the condition.】
            "                                                                 "    but plugin is registered  防止PlugClean清掉

        let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ,./wosleidkrufj'
                                " a-z & A-Z
                                " 最好敲的放后面
        let g:EasyMotion_do_mapping = 0 " Disable default mappings  要用的话自己粘过来
        let g:EasyMotion_smartcase = 1

        map <Leader><Leader> <Plug>(easymotion-prefix)

            " 默认map:
            " {你设的prefix}j
            " {你设的prefix}s
            " {你设的prefix}w
            " ....


        " 敲小写:
            "\        <Plug>(easymotion-bd-fl)
                                    " l: current cursor line
            nmap s <Plug>(easymotion-bd-fl2)
                    " 有ss这个map, 所以敲s后 要等一会, 可以挪作它用 (不map掉s的话, 容易不小心进入insert mode)
                    " 新发现: 敲s后直接敲目标字母,不用等
                    " 但map了ss, 所以要避免找s


                   " <Plug>(easymotion-sl)
                   " <Plug>(easymotion-Fl)
                   " <Plug>(easymotion-bd-fl)
                   " <Plug>(easymotion-tl)
                   " <Plug>(easymotion-Tl)
                   " <Plug>(easymotion-bd-tl)
                   " <Plug>(easymotion-wl)
                   " <Plug>(easymotion-bl)
                   " <Plug>(easymotion-bd-wl)
                   " <Plug>(easymotion-el)
                   " <Plug>(easymotion-gel)
                   " <Plug>(easymotion-bd-el)
                   "
                   " <Plug>(easymotion-lineforward)
                   " <Plug>(easymotion-linebackward)
           nmap ,f  <Plug>(easymotion-lineanywhere)
            let g:EasyMotion_re_line_anywhere = '\v' .
                \       '(<.|^$)'        . '|' .
                \       '(.>|^$)'        . '|' .
                \       '(\l)\zs(\u)'    . '|' .
                \       '(_\zs.)'        . '|' .
                \       '[^\d001-\d127]' . '|' .
                \       '(#\zs.)'
        " 敲大写
            nmap F  <Plug>(easymotion-bd-f2)
            nmap S  <Plug>(easymotion-bd-f)


        " 会显示高亮字母后，光标到下一行
        map  <Leader><Leader>w <Plug>(easymotion-w)

        " Line motions
            map <Leader>j <Plug>(easymotion-j)
            map <Leader>k <Plug>(easymotion-k)


" 处理注释
    PL 'https://github.com/sisrfeng/nerd-comment'
        " nerdcommenter
            " 貌似当前最强, tcommenter啥的star少
        let g:NERDMenuMode = 0
            " PL 'https://github.com/sisrfeng/vim-commentary'
                " tpope大佬的? 有点老, 可以参考着改nerdcommenter
                " go: get out
                " nmap go  <Plug>Commentary
                " vmap go  <Plug>Commentary
                " nmap gl <Plug>CommentaryLine
                " nmap gll <Plug>Commentary<Plug>Commentary


" 成对符号 增/删/改  ( 方便区分, 这样命名:
    "\ dual: 2个一样的符号
    "\ pair: 2个符号 可以一样
    "\ )
    PL 'https://github.com/sisrfeng/insert-pair'  " :help autopairs
        " 自动增/删另外一半        "
        " 这个插件的文档看得差不多了
            let g:AutoPairsShortcutToggle     = '<C-M-p>'
            let g:AutoPairsShortcutJump       = '<M-n>'   " 跳到下一个配对处
            let g:AutoPairsShortcutBackInsert = '<M-b>'
            let g:AutoPairsShortcutFastWrap   = '<F35>'  " 推到后面去
                                                      " ahk里设为capslock+f了
            if exists('g:wf_vidE')
                let g:AutoPairsShortcutFastWrap = '<F11>'  " 推到后面去
                let g:AutoPairsShortcutFastWrap = '<C-F11>'  " 推到后面去
            en

            let g:AutoPairs =  {  '('  :  ')',
                          \ '['  :  ']',
                          \ '{'  :  '}',
                          \ '"'  :  '"',
                          \ "'"  :  "'",
                          \ '`'  :  '`',
                         \}

            let g:AutoPairs['<']  =  '>'


            " You can set |b:AutoPairs| before |BufEnter|:
            " todo: 还是autopairs的Jump还是会跳到注释的开头 (双引号所在)
            au Filetype vim let b:AutoPairs = { '(':')',
                                              \ '[':']',
                                              \ '{':'}',
                                              \ "'":"'",
                                              "\ vim里注释用双引号, 匹配双引号的会, AutoPairs的Jump会不爽
                                              "\ '"':'"',
                                              \ '<':'>',
                                              \ '`':'`'}


            " let g:AutoPairs["<<"]=">>"  " 不行
            let g:AutoPairsFlyMode = 0
                                    " 设为1 导致经常跳到很远 而非insert 成对符号


            PL 'https://github.com/sisrfeng/sandwich'  " vim-sandwich   代替了:  PL 'tpope/vim-surround'

            PL 'https://github.com/sisrfeng/textObj-DIY' "\    原名: kana/vim-textobj-user
                " PL 'kana/vim-textobj-indent'  " 这个9年没更新了, 这个新一点:
                PL 'https://github.com/sisrfeng/indent-Obj'
                    "\ vii: in indent
                    "\ vai

            " todo
            " PL 'kana/vim-textobj-syntax'
            " PL 'sgur/vim-textobj-parameter'
                    "let g:vim_textobj_parameter_mapping = 'a'

            " 这个是?
            " vim-doge
            "let g:doge_mapping = '<Leader>dc'

    "\ PL 'https://github.com/sisrfeng/textObj-pairs'
    PL 'https://github.com/sisrfeng/textObj-dual'
        " q通配任意quote,
        " <space>通配任意所支持的符号(叹号等, 但不支持括号. 括号2端不一样, 而¿"¿等 是一样的)

        " omap会导致dd等反应慢
        " 默认用in而非arround, 少敲一个i:
        "
            nmap cq c<Plug>Pairs_In_Quote
            nmap dq d<Plug>Pairs_In_Quote
            nmap vq v<Plug>Pairs_In_Quote
            nmap yq y<Plug>Pairs_In_Quote

            nmap c<leader> c<Plug>Pairs_In_All
            nmap d<leader> d<Plug>Pairs_In_All
            nmap v<leader> v<Plug>Pairs_In_All
            nmap y<leader> y<Plug>Pairs_In_All


            vmap cq c<Plug>Pairs_In_Quote
            vmap dq d<Plug>Pairs_In_Quote
            vmap vq v<Plug>Pairs_In_Quote
            vmap yq y<Plug>Pairs_In_Quote

            vmap c<leader> c<Plug>Pairs_In_All
            vmap d<leader> d<Plug>Pairs_In_All
            vmap v<leader> v<Plug>Pairs_In_All
            vmap y<leader> y<Plug>Pairs_In_All



" 先放着:
    " PL 'https://github.com/preservim/tagbar'
       " nmap <F8> :TagbarToggle<CR>
       " 对vim的help 无能为力

    " plug 'https://github.com/mzlogin/vim-markdown-toc'
        " 有点鸡肋



" 外观/UI/UX/美化
    " layout 布局
        " PL 'https://github.com/sisrfeng/buf_as_tab'  " 原名buftabline
        " PL  'https://github.com/sisrfeng/wintabs'
            "  有人只用一个tabpage: your viewports reflect exactly what you're thinking right now, which can change over time
            "  https://www.reddit.com/r/vim/comments/5efwi5/dont_understand_why_so_many_people_use_buffers/

    " PL 'https://github.com/chrisbra/unicode.vim'
    "\ PL 'https://github.com/sisrfeng/notes_vim'
        " vim-notes

    "\ PL 'https://github.com/sisrfeng/misc-vim'
    "\ PL 'https://github.com/sisrfeng/Colorizer'  " 似乎用lua.vim.man啥的就行?


    "todo:
    " PL 'https://github.com/sisrfeng/better-digraphs.nvim'

    " PL 'https://github.com/chrisbra/vim-sh-indent'
        " 要用吗? ale在管着indent?
    " PL 'https://github.com/junegunn/vim-emoji'  " 直接在我存好的文件里复制就行, 少加一个插件
        " %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g
        " set completefunc=emoji#complete

    " todo 待尝试:
    " PL 'https://github.com/vim-autoformat/vim-autoformat'
    "     let g:python3_host_prog='/home/linuxbrew/.linuxbrew/bin/python'
        " let g:formatterpath = ['/some/path/to/a/folder', '/home/superman/formatters']
        " au AG BufWrite * :Autoformat
        "   这行貌似导致保存vim的help文档时很慢, 且缩进严重加倍
        " au AG FileType vim,tex let b:autoformat_autoindent=0

    " todo:
    " PL 'https://github.com/bpstahlman/txtfmt'

    PL 'https://github.com/sisrfeng/cursor-word'
        " 会把 没有空格隔开的中英文一起高亮, 但vim把它们当作2个word
        " 配置在 /home/wf/dotF/cfg/nvim/colors/leo_light.vim

    " 高亮todo/特定character  " 不用插件 现在的也够用了
        " PL 'folke/todo-comments.nvim'
        "  silent! PL 'folke/todo-comments.nvim'
            " 还是经常报错 invalid buffer id
            " 下面这堆也不行, 放弃
        "  try
        "      silent! PL 'folke/todo-comments.nvim'
        "       " PL 'folke/todo-comments.nvim'
        "      " When [!] is added, error messages will also be
        "      " skipped, and commands and mappings will not be aborted
        "      " when an error is detected.  |v:errmsg| is still set.
        " " catch /^Vim\%((\a\+)\)\=:E5108/ " catch error E几几
        " " catch /.*/          " catch everything
        " " catch /Error: Invalid buffer id: 504/
        " endtry

    " 管理buffer:
        " PL 'https://github.com/ap/vim-buftabline'  搞乱terminal标签的命名
        " todo: 插件只有一个文件 仿照它 自己写


    " tab line
            " 能显示隐藏buffer, 但buffer名字有点长, 自己在tab_status_line.vim里配算了

            " PL 'romgrk/barbar.nvim'

            " nor gb <esc>:BufferNext<cr>

            "gb: go buffer
            "
            " let g:bufferline.icon_separator_inactive = '|'
            " let g:bufferline.icon_separator_active   = '||'
            "
            " let fg_target = 'red'
            "
            " let fg_current  = s:fg(['Normal'], '#efefef')
            " let fg_visible  = s:fg(['TabLineSel'], '#efefef')
            " let fg_inactive = s:fg(['TabLineFill'], '#888888')
            "
            " let fg_modified  = s:fg(['WarningMsg'], '#E5AB0E')
            " let fg_special  = s:fg(['Special'], '#599eff')
            " let fg_subtle  = s:fg(['NonText', 'Comment'], '#555555')
            "
            " let bg_current  = s:bg(['Normal'], '#000000')
            " let bg_visible  = s:bg(['TabLineSel', 'Normal'], '#000000')
            " let bg_inactive = s:bg(['TabLineFill', 'StatusLine'], '#000000')
            "
            " " Meaning of terms:
            " "
            " " format: "Buffer" + status + part
            " "
            " " status:
            " "     *Current: current buffer
            " "     *Visible: visible but not current buffer
            " "    *Inactive: invisible but not current buffer
            " "
            " " part:
            " "        *Icon: filetype icon
            " "       *Index: buffer index
            " "         *Mod: when modified
            " "        *Sign: the separator between buffers
            " "      *Target: letter in buffer-picking mode
            " "
            " " BufferTabpages: tabpage indicator
            " " BufferTabpageFill: filler after the buffer section
            " " BufferOffset: offset section, created with set_offset()


    " PL 'obcat/vim-hitspop'



    "\ 处理terminl? 不太需要
    "\ PL 'https://github.com/Shougo/deol.nvim'

    " PL 'https://github.com/ncm2/float-preview.nvim'
    "     function! Leo_float()
    "                   " 插件自己不创建float window, 只改变原有的window的位置等?
    "       call nvim_win_set_option(g:float_preview#win, 'number', v:false)
    "       call nvim_win_set_option(g:float_preview#win, 'relativenumber', v:false)
    "       call nvim_win_set_option(g:float_preview#win, 'cursorline', v:false)
    "     endfunction
    "
    "  " au[tocmd]{event} pattern匹配的文件名 {cmd}
    "     autocmd User    FloatPreviewWinOpen call Leo_float()
    "           " User是个event
    "             " Not executed automatically.
    "             " Use |:doautocmd|  to trigger this,
    "             " typically for "custom events" in a plugin.
    "             "  Example: >
    "             "     :autocmd   User MyPlugin echom 'got MyPlugin event'
    "             "     :doautocmd User MyPlugin
    "     " 此插件里有:
    "     "  doautocmd <nomodeline>      User    FloatPreviewWinOpen
    "     " :doautocmd [<nomodeline>] {event}   [fname]
    "                                         " [fname] (default: current file name)
    "
        fu! Create_float() abort

         " 创建float window:

                          " nvim_create_buf({listed}, {scratch})
                                               " scratch-buffer for temporary work
                  let opt = { 'focusable': v:true,
                              \ 'width': 80,
                              \ 'height': 20
                              \}
                      let opt.relative = 'win'
                      let opt.row = 20
                      " let opt.row = winheight - prevw_height
                      let opt.col  = 50

                  call nvim_win_set_option(
                                        \  call('nvim_open_win',
                                        \          [nvim_create_buf(0, 1),
                                        \          0,
                                        \          opt]
                                        \      ),
                                        \ 'cursorcolumn',
                                        \ v:false
                                          )
                  " doautocmd <nomodeline>      User    FloatPreviewWinOpen
        endf


    PL 'skywind3000/vim-quickui'
        " let _ui = quickui  " 用不了
        fun! SearchBox()
            let cword = expand('<cword>')
            let title = '原样查找:'
            let text = quickui#input#open(title, cword, 'search')
            if text != ''
                let text = escape(text, '[\/*~^')
                call feedkeys("\<ESC>/" . text . "\<cr>", 'n')
            en
        endfunc


        " display vim messages in the textbox
        fun! DisplayMessages()
            let x = ''
            redir => x
            sil! messages
            redir END
            let x = substitute(x, '[\n\r]\+\%$', '', 'g')
            let content = filter(split(x, "\n"), 'v:key != ""')
            let opts = {"close":"button", "title":"Vim Messages"}
            call quickui#textbox#open(content, opts)
        endfunc

        let g:quickui_color_scheme = 'solarized'
        " source $VIMRUNTIME/menu.vim
        " set wildmenu
        " set cpo-=<
        " " set wcm=<C-Z>
        " " map <F4> :emenu <C-Z>
        "
        "
        " " enable to display tips in the cmdline
        " let g:quickui_show_tip = 1
        "
        "
        " " hit space twice to open menu
        " nor <space><space> :call quickui#menu#open()<cr>



    PL 'https://github.com/sisrfeng/async-run'
        let g:asyncrun_open = 0
        "\ let g:asyncrun_open = 8  " qf窗口的height
            "\ above zero to open quickfix window at given height after command starts

        let g:asyncrun_trim = 1
        "\ let g:asyncrun_wrapper = '-tab'

    PL 'https://github.com/sisrfeng/qf_last'
        " q for quickfix.
            nno <Leader>q      <Cmd>VimscriptLastError -quickfix<cr><Cmd>copen<cr>
            " 比:Message更clean
            nno <Leader>\      <Cmd>VimscriptLastError<cr>
                                 " 直接跳过去
            " vn <Leader>q <esc>:VimscriptLastError -quickfix<cr>:copen<cr>
            " 清空quickfix  :cexpr []<cr>:



    " PL 'https://github.com/chamindra/marvim'
        " 很多年没更新
    " todo:
    " PL 'https://github.com/svermeulen/vim-macrobatics'

" vim dev/vimL"
    " PL 'https://github.com/yianwillis/vimcdoc'
        " 中文帮助
        " 没有英文直接


    PL 'https://github.com/vim-scripts/Decho'

    PL 'https://github.com/sisrfeng/regex_magic'     " :help VimRegexConverter

    " PL 'https://github.com/sisrfeng/nvim-regexplainer'
        " JavaScript regexp, 不支持vim的magic, very magic
        " 暂时不支持vimL的regex injection
        " https://github.com/vigoux/tree-sitter-viml/issues/96



" todo:
    " plug 'https://github.com/HiPhish/info.vim'

    "\ 主要用cnoreabbr:
        "\ PL 'https://github.com/sisrfeng/ambi_cmd'
        "\ PL 'https://github.com/sisrfeng/cmdalias'

    "\ 系统地管理map
        " PL 'leoatchina/vim-which-key'
        " PL 'AlexVKO/vim-mapping-manager', { 'do' : ':UpdateRemotePlugins' }

" PL 'https://github.com/sisrfeng/color_template'  " 目前在nvim上有些bug
"\ PL 'https://github.com/sisrfeng/zen'  \ 一切换window就退出zen mode, 不爽
"\ PL 'https://github.com/sisrfeng/dim'  "\ 导致光标移动卡....
PL 'https://github.com/sisrfeng/capital'
"\ 建议放在本文件末尾
PL 'https://github.com/sisrfeng/icons'  " 要用icon的插件, 必须在这行之前
"\ PL 'https://github.com/sisrfeng/icons_lua'  " 要用icon的插件, 必须在这行之前
"\ lua没有viml直观
                              " vim-devicons
          " PL 'kyazdani42/nvim-web-devicons'  "  上述的lua版

"\ emoji大部分是2字符宽度, 丑死
"\ PL 'https://github.com/sisrfeng/emoji-icon-theme'

