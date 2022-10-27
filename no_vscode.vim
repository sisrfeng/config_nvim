imap <F2> <C-O>:let save_ve = &virtualedit<CR>
                \<C-O>:set virtualedit=all<CR>
                \<C-O>:echo col(".") . "\n" <Bar>
                \let &virtualedit = save_ve<CR>

" iabbrev
" 触发： space, Escape, or Enter.

    " 不要和my_cfg.lua里的重复了
    " 有了snippet, inorea还是有用 tab在expand时, 不像空格那么"自然"
    "

    " to consume the space  typed after an abbreviation: >
        func! Eatchar(pat)
          let c = nr2char(getchar(0))
          return (c =~ a:pat) ? '' : c
        endf

    inorea cno cnoremap
    inorea exis exists('')<Left><Left>
    inorea cz exists('')<Left><Left>
    inorea ali alias
    inorea bbb import pudb; pu.db
    inorea mpa map
    inorea ali alias
    inorea al alias
    inorea df ~/dotF/
    inorea HO $HOME/
    inorea ture true
    inorea ,,, •
    " inorea hrt 💛

    inorea ttt ⤴
         " the the the
    inorea upup ⤴
    inorea uuu ⤴
    inorea serach search
    inorea PAHT PATH
    inorea paht path
    inorea tpye type
    inorea TPYE TYPE
    inorea _tpye _type
    inorea _TPYE _TYPE
    inorea  noraml normal
    inorea  plug Plug ''<Left>
    inorea  Plug Plug ''<Left>
        " 不行
        " inorea  Plug Plug ''<Left><Left><Right>
    " inorea  func func!()<Left><Left>
    " 用snippet吧
    " inorea  fu   func!()<Left><Left>
    " inorea  endf endf
        " 大胆用endf表示endfunction吧, endfor就不用简写(基本没用过endfor)


    " todo:如何在这里使用正则? snippet貌似也不是万能

" cnor s/ s/\v
" vscode里，用了camp时，必须在光标后有字符才能正常map


" noremap
    cnor <C-a> <Home>
    cnor <C-e> <End>


    nno ss <Cmd>update!<CR><Cmd>call Smart_qq()<cr>
                " 加叹号: read-only的文件照样update
    vno ss <Cmd>update!<CR><Cmd>call Smart_qq()<cr>

    " inoremap qq <ESC>:wq<CR>  别这么干，容易在编辑时敲错


    "  可能导致插件出bug
    set virtualedit=all


    no j gj
    no k gk

    no 0 g0
    no <Home> g0
    " no L g$
     no L g_
    vno L $

    nno <End> g$
    vno <End> g$

    ono <silent> j gj
    ono <silent> k gk
    " nno dd g^dg$i<BS><Esc>
    " nno yy g^yg$
    " nno cc g^cg$


    nno A g_a
    nno I g^i

    " nno gm g$
    " nno M

    "\ nno <c-x>   <c-w>j
    nno <c-x> <Cmd>call Jump_to_repl()<cr>
        fun! Jump_to_repl()
            sbuffer  \[dap-repl]
            call nvim_win_set_height(0,10)
        endf

    nno <c-w>\  <c-w>v
    nno <c-w>-  <c-w>s
    " nno gd g<C-]>
        " <C-]>只能在本文件内跳转

    "\ 放错位置了?
        " ¿<C-\><C-N>¿ can be used to go to  Normal mode
        " from any other mode.  (包括terminal-mode)
        " This can be used to make sure Vim is in
        " Normal mode,
        " without causing a beep like <Esc> would.
        " However, this does not  work in Ex mode.
        " When used after a command that takes an argument,
        " such as

if &diff
    " 反应变慢，不好
    " map ] ]c
    " map [ [c
    endif
    " map 默认是recursive的


" 行号
    set  nonumber norelativenumber
    func! HideNumber()
        if(&relativenumber == &number)
            " 叹号或者加inv：表示toggle
            set invrelativenumber invnumber
        elseif(&number)
            set invnumber
        else
            set relativenumber!
        endif
    endfunc
    nno <Leader>nu :call HideNumber()<CR>

    set wrap    " vscode里, 要在setting.json设置warp


" tab /indent
    " 有了它 Plug 'https://github.com/tpope/vim-sleuth'
    "     " My goal is that by installing this plugin, you can remove all indenting related configuration from your vimrc.
    "
    "
    "
    " " vscode上有插件自动处理，不用加这些:
    "     set expandtab " 将Tab自动转化成空格()[需要输入真正的Tab键时，使用 Ctrl + C + Tab]
    "     set tabstop=4 " 设置Tab键等同的空格数
    "
    "     set shiftwidth=4 " 每一次缩进对应的空格数
    "     set shiftround " 用shiftwidth的整数倍， when indenting with '<' and '>'
    "     " set smarttab " insert tabs on the start of a line according to shiftwidth
    "     " 如果要仅对python有效：  autocmd Filetype python set 上面那堆
    "     "不太好用 set softtabstop=4 " 按退格键时可以一次删掉 4 个空格 (不利于删1-3个空格)
    "     set softtabstop=0  " 设了也不生效, 进入visuanl mode 选中再敲c吧
    "
    "     " `各种indent方法`
    "     " 只是对c语言家族而言？
    "     " 'autoindent'    uses the indent from the previous line.
    "     " 'smartindent'    is like 'autoindent' but also recognizes some C syntax to
    "     "                 increase/reduce the indent where appropriate.
    "     " 'cindent'        Works more cleverly than the other two and is configurable to
    "     "               different indenting styles.
    "     " 'indentexpr'   The most flexible of all: Evaluates an expression to compute
    "             "       the indent of a line.  When non-empty this method overrides
    "             "       the other ones.  See |indent-expression|.
    " " set cindent  " 老是自作主张给我缩进?
    " " set autoindent
    " " set indentexpr  " 完全DIY?
    " " 插件在管着indent?
    "     " let b:sh_indent_options = []
    "     " let b:sh_indent_options['default'] = 4
    "     " let b:sh_indent_options['continuation-line'] = 8
    " "
    " " 考虑用谷歌的规范？
    "     " https://github.com/google/styleguide/blob/gh-pages/google_python_style.vim
    "     " set indentexpr=GetGooglePythonIndent(v:lnum)


" vscode里不行
    " cnor q1 q!
        " Quickly close the current window



" 已经设置了 let g:NERDCreateDefaultMappings = 0  " 之前设为1，导致vscode用不了nerdcommenter?
nno ce    A<space><space><Esc>o/<Esc><Esc>:call nerdcommenter#Comment("n", "Comment")<CR>kJA<BS>
    " 有缩进时，有时会把开头的注释符号删掉，别完美主义吧
