call plug#begin( '$HOME/PL' )
"\ call plug#begin(stdpath('data') . '/PL')
    source $nV/PL.vim
call plug#end()

" 这行只能出现一次,
" 如果多次出现, 会让registered的插件可以plugclean, (被视为invalid plugins)

" update &runtimepath and initialize plugin system
" Automatically executes:
    " syntax on
    " filetype plugin indent on



" auto install the ¿missing plugins¿, (must after plug#end() ?? )
"\ 启动时自动安装缺失的插件
    " https://github.com/junegunn/vim-plug/wiki/extra
    au AG VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall  | q
            \| endif

    "\   PlugInstall --sync
    "\ sync: block the control until the update/install is finished
    "\ 和async相反
    "\ 导致无法连接github时卡死


" 有些插件的设置,要在plug#end()后

" Define:
    au AG FileType denite call s:denite_my_settings()
    func! s:denite_my_settings() abort
        nno <silent><buffer><expr>   q        denite#do_map('quit')
        nno <silent><buffer><expr>   <CR>     denite#do_map('do_action')
        nno <silent><buffer><expr>   d        denite#do_map('do_action', 'delete')
        nno <silent><buffer><expr>   p        denite#do_map('do_action', 'preview')
        nno <silent><buffer><expr>   i        denite#do_map('open_filter_buffer')
        nno <silent><buffer><expr>   <Space>  denite#do_map('toggle_select').'j'
    endf

    au FileType denite-filter call s:denite_filter_my_settings()
    func! s:denite_filter_my_settings() abort
        imap <silent><buffer>      <C-o>    <Plug>(denite_filter_quit)
    endf

    " For ripgrep
    call denite#custom#var('file/rec', 'command',
                        \ ['rg', '--files', '--glob', '!.git', '--color', 'never'])

    " For python script scantree.py
    " Read bellow on this file to learn more about scantree.py
    call denite#custom#var('file/rec', 'command',
                        \ ['scantree.py', '--path', ':directory'])


" 高亮todo/ 特殊单词高亮

" 有插件教人用EOF, 但感觉怪怪的, 不怕引起冲突?
" EOF属于lua,而非vimL的语法? 作用和shell里一样?
" :help lua-heredoc

    " vim-sandwich的设置
        let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
        let g:operator_sandwich_no_default_key_mappings =  1
        let          g:sandwich_no_default_key_mappings =  1

        call operator#sandwich#set('add', 'char', 'cursor', 'tail')
                                    " cursor will jump to the end of added pair

        " add spaces inside bracket
        " ${ ENV }会报错, 这个括号别加空格
        " 要多加空格? 先敲空格再敲括号 或者敲另一半括号
        let g:sandwich#recipes += [
            \  #{buns : ['(',  ')'] , nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: ['(']},
            \  #{buns : ['[',  ']'] , nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: ['[']},
            \  #{buns : ['{',  '}'] , nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: ['{']},
            \
            \  #{buns : ['( ', ' )'], nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: [' (']},
            \  #{buns : ['[ ', ' ]'], nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: [' [']},
            \  #{buns : ['{ ', ' }'], nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: [' {']},
            \
            \  #{buns : ['( ', ' )'], nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: [')']},
            \  #{buns : ['[ ', ' ]'], nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: [']']},
            \  #{buns : ['{ ', ' }'], nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: ['}']},
            \
            \  #{buns : ['⛅', '⛅'], nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: ['c']},
            \  #{buns : ['🔋', '🔋'], nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: ['b']},
            \  #{buns : ['💛', '💛'], nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: ['h']},
            \  #{buns : ['📁', '📁'], nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: ['f']},
            \  #{buns : ['🎵', '🎵'], nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: ['m']},
            \  #{buns : ['♀', '♀'], nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: ['k']},
            \  #{buns : ['💦', '💦'], nesting: 1, match_syntax: 1, kind: ['add', 'replace'], action: ['add'], input: ['d']},
            \
            \
            \  #{buns: ['{\s*', '\s*}']   , nesting: 1, regex: 1, match_syntax: 1, kind: ['delete', 'replace', 'textobj'], action: ['delete'], input: ['{']},
            \  #{buns: ['(\s*', '\s*)']   , nesting: 1, regex: 1, match_syntax: 1, kind: ['delete', 'replace', 'textobj'], action: ['delete'], input: ['(']},
            \  #{buns: ['\[\s*', '\s*\]'] , nesting: 1, regex: 1, match_syntax: 1, kind: ['delete', 'replace', 'textobj'], action: ['delete'], input: ['[']},
            \ ]
            " NOTE: 这种dict的key不能含某些符号: #{}

        " emoji有时不能简单复制, 要点专用的复制链接, 不然显示有问题?
        " 只在注释里用比较稳妥
            " 有点问题, 导致错行 或者错一个字符的位置:
            " \   {'buns' : ['▶️', '↙️'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input':  ['p']},

        " 不需要了, 放着, 避免重复被坑
        " : To prevent unintended operation
            " nmap s <Nop>
                "搞死了前面这个 nmap s <Plug>(easymotion-f)
            " xmap s <Nop>
            " xmap creates a mapping for just Visual mode
                " <NOP>    do nothing (useful in mappings)

        " vim的"操作公式"是(方括号表示可选)   [number]<command>[text object or motion]

        " 用p表示pairs? 不好, p默认表示paragraph
        " t: 记作tag, 成对符号
            "  这些操作后面加i, 会interactive 可以在head和tail加不同的符号, 方便加`某某'?
            "  似乎viusal mode比normal mode下的操作更直观, 不怕选错

            vmap tw <Plug>(operator-sandwich-add)¿
            nmap tw viw<Plug>(operator-sandwich-add)¿

            vmap tp <Plug>(operator-sandwich-replace)#
            nmap tp vaq<Plug>(operator-sandwich-replace)#

            vmap ts <Plug>(operator-sandwich-add)✗
            nmap ts viW<Plug>(operator-sandwich-add)✗
                    " strike

            " 看哪个好用:
                nmap t( viw<Plug>(operator-sandwich-add)(
                vmap t( <Plug>(operator-sandwich-add)(

                nmap tu viw<Plug>(operator-sandwich-add)(
                vmap tu <Plug>(operator-sandwich-add)(

            " 看哪个好用:
                nmap t) viW<Plug>(operator-sandwich-add)(
                vmap t) loh<Plug>(operator-sandwich-add)(
                        " loh移动光标
                nmap ti viW<Plug>(operator-sandwich-add)(
                vmap ti loh<Plug>(operator-sandwich-add)(

            nmap t. viW<Plug>(operator-sandwich-add)*
            vmap t. loh<Plug>(operator-sandwich-add)*

            nmap tb viW<Plug>(operator-sandwich-add){
            vmap tb loh<Plug>(operator-sandwich-add){
                    " b: brace


            nmap tl viW<Plug>(operator-sandwich-add)¡
            vmap tl loh<Plug>(operator-sandwich-add)¡

            nmap t[ viw<Plug>(operator-sandwich-add)[
            vmap t[ <Plug>(operator-sandwich-add)[

            nmap t] viW<Plug>(operator-sandwich-add)[
            vmap t] loh<Plug>(operator-sandwich-add)]

            nmap t{ viw<Plug>(operator-sandwich-add){
            vmap t{ <Plug>(operator-sandwich-add){

            nmap t} viW<Plug>(operator-sandwich-add)}
            vmap t} loh<Plug>(operator-sandwich-add)}

            nmap t' viw<Plug>(operator-sandwich-add)'
            vmap t' <Plug>(operator-sandwich-add)'

            nmap t` viw<Plug>(operator-sandwich-add)`
            vmap t` <Plug>(operator-sandwich-add)`

            nmap t" viw<Plug>(operator-sandwich-add)"
            vmap t" <Plug>(operator-sandwich-add)"

            nmap ta <Plug>(operator-sandwich-add)
            vmap ta <Plug>(operator-sandwich-add)

            nmap td <Plug>(operator-sandwich-delete)
            vmap td <Plug>(operator-sandwich-delete)

            nmap tr <Plug>(operator-sandwich-replace)
            vmap tr <Plug>(operator-sandwich-replace)

            vmap th <Plug>(operator-sandwich-replace)´
                    " tag highlight
                    " 不行:
                    " vmap tr´ <Plug>(operator-sandwich-replace)´

            nmap t\| viw<Plug>(operator-sandwich-add)\|
            vmap t\| <Plug>(operator-sandwich-add)\|
                    " bar要escape
            nmap t\ viw<Plug>(operator-sandwich-add)\|
            vmap t\ <Plug>(operator-sandwich-add)\|

" 处理注释
    " set formatoptions -=o  还是别去掉0, 没有的话, 缩进不智能
                           " 但不去掉, 老是会插入注释符 烦

    " nerdcommenter
        let g:NERDCreateDefaultMappings = 0    " 别用默认的键位
        let g:NERDSpaceDelims           = 1   " Add spaces after comment delimiters
        let g:NERDAltDelims_python      = 1

        let g:NERDCompactSexyComs  =  1   " Use compact syntax for  multi-line comments
        let g:NERDDefaultAlign     =  'left'
            " Align line-wise comment delimiters
            " flush left instead of following code indentation

        nmap   <c-_>  <plug>NERDCommenterAltDelims<esc>
                     \<Plug>NERDCommenterToggle<Esc>
                     \<plug>NERDCommenterAltDelims


       " 不加2个gv, 会跳到last visual area

        vmap   <c-_>  <Cmd>call nerdcommenter#SwitchToAlternativeDelimiters(1)<CR>
                     \gv
                     \<Cmd>call nerdcommenter#Comment('v', 'toggle')<CR>
                     \<Cmd>call nerdcommenter#SwitchToAlternativeDelimiters(1)<CR>
                     \gv

        "\ fail
        "\     vno    <c-_> <cmd>call Vim_line_commenT()<cr>
        "\     fun! Vim_line_commenT()
        "\          call nerdcommenter#SwitchToAlternativeDelimiters(0)
        "\          normal  <lt>Plug>NERDCommenterToggle
        "\          call nerdcommenter#SwitchToAlternativeDelimiters(0)
        "\     endf




        " Add your own custom formats or override the defaults
        " 插件里有:
            " if exists('g:NERDCustomDelimiters')
            "     call extend(s:delimiterMap, g:NERDCustomDelimiters)
            " endif
        let g:NERDCustomDelimiters =
        \#{ zsh      :{ 'left': '#' }                   ,
         \  gitconfig:{ 'left': '#' }                  ,
         \  python   :{ 'left': '#' }                  ,
         \  jsonc    :{ 'left': '//' }                 ,
         \  help     :{ 'left': '"', 'leftAlt': '"\' } ,
         \  vim      :{ 'left': '"\', 'leftAlt': '"' } ,
         "\ \  vim      :{ 'left': '"', 'leftAlt': '"\' } ,双引号容易错误匹配, 用"\ 会把不该连在一起的行连起来?
             "\ ¿"\¿ 作为默认, 容易把不相干的连起来?
          \ ruby     :{ 'left': '#', 'leftAlt': 'Any_thing', 'rightAlt': 'BAR' },
         \}

                                   "\ vim      :{ 'left': '"', 'leftAlt': '"\' },

        let g:NERDCommentEmptyLines      =  1  " Allow commenting and inverting empty lines (useful when commenting a region)
        let g:NERDTrimTrailingWhitespace =  1 " Enable trimming of trailing whitespace when uncommenting
        let g:NERDToggleCheckAllLines    =  1 " check all selected lines is commented or not


        " nerdcommenter#Comment是该plugin所有功能的入口:
            " 如果要用函数 ,而非command:
            " nno <silent> <C-_>   :call nerdcommenter#Comment('n', 'toggle')<CR>j


        " toggle:
            " If the topmost selected  line is commented,
            "     all selected lines are uncommented and vice versa.
        " invert:
            " 逐行判断 取反

            " neovide下的表示形式
                nmap  <c-F12>         <plug>NERDCommenterToggle<esc>j
                vmap  <c-F12>         <plug>NERDCommenterToggle<esc>:echo '考虑手动用block模式吧'<CR>
                imap  <c-F12>         <esc><plug>NERDCommenterToggle<esc>j

            " windows terminal的表示形式
                nmap  <F36>              <plug>NERDCommenterToggle<esc>j
                vmap  <F36>         <plug>NERDCommenterToggle<esc>:echo '考虑手动用block模式吧'<CR>
                imap  <F36>         <esc><plug>NERDCommenterToggle<esc>j

            " :help ctrl-/
            " 别用这个:
                " nmap  <C-/>              <plug>NERDCommenterToggle<esc>j
                " imap  <C-/>         <esc><plug>NERDCommenterToggle<esc>j
                      " <C-_>
                      " <c-_>

        nmap  <silent> !     i<space><esc><plug>NERDCommenterToEOL<esc>j
        imap  <silent> <M-/>  <space><esc><plug>NERDCommenterToEOL<esc>j

        " " 遇到同一行被注释了多次的情况,都不好使:
            vno   <M-?>    <esc>:call nerdcommenter#Comment('x', 'Uncomment')<CR>:echom '手动用visual block mode?'<CR>
                            " ´<esc>:´换成<Cmd>  会导致 作用于 上一次的viusal区域
            vmap   <F36>    <plug>NERDCommenterToggle<esc>:echom '考虑手动用block模式吧'<CR>gv
                " vno <M-?> <esc><Plug>NERDCommenterInvert<esc>gv  不能删掉多个注释delimeter

                " vim comments are so fucking stupid!!
                " Why the hell do they have comment  delimiters that are used elsewhere in the syntax?!?!
                " We need to check  some conditions especially for vim
                " 这是导致这个问题的原因?

                "
                " visual mode下, 如果包括下面的这行:  ´" " 习惯了注释后进normal mode´
                "                                      因为有多个delimeter, 不能toggle, 只能一味加delimeter
                "                                      完整例子:
                                                                  " " asdfasdf
                                                                  "     " aaaaaa
                                                                        " " 习惯了注释后进normal mode
                                                                  "     " bbbbbbbb

        nno  <M-?>    mtyy<Cmd>call nerdcommenter#Comment('n', 'toggle')<CR>P`tk


