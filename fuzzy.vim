" search/ fuzzy search模糊搜索

fun! g:Get_git_rooT()
    let g_root = split(system('git rev-parse --show-toplevel'), '\n')[0]
    return v:shell_error
     \ ? ''
     \ : g_root
endf


PL 'https://github.com/sisrfeng/match-id'  " searchindex
    nmap  <Right>  <Plug>ImprovedStar_*<Plug>SearchIndex
    nmap  <Left>   <Plug>ImprovedStar_#<Plug>SearchIndex

    vno  <Right>  "cy<esc>/<c-r>c<cr>
    vno  <Left>   "cy<esc>?<c-r>c<cr>

    " nno #
    " nno *

    " searchindex is much simpler and faster than
        " https://github.com/osyo-manga/vim-anzu,
        " PL 'https://github.com/sisrfeng/next-match'  " anzu
                " " PL 'https://github.com/sisrfeng/next-match'  " anzu
                "         nmap <Right> <Plug>(anzu-star-with-echo)
                "         nmap <Left> <Plug>(anzu-sharp-with-echo)
                "             " todo:
                "                 " https://vi.stackexchange.com/questions/4054/case-sensitive-with-ignorecase-on
                "                 " 或者
                "                 " PL 'https://github.com/idbrii/vim-searchsavvy'
                "
                "         " nmap n <Plug>(anzu-n-with-echo)h
                "                                     " 导致永远止步不前
                "         nmap n <Plug>(anzu-n-with-echo)
                "         nmap N <Plug>(anzu-N-with-echo)
                "         " 如果用regex, echo的可能是上一次search的内容, 但不影响实际search的效果
                "         " plug ''
        "
        " And can replace it?
        " PL 'https://github.com/sisrfeng/sharp-asterisk'  " haya14busa/vim-asterisk'
    "         " - It uses not only 'ignorecase' but also 'smartcase'
    "         "  是vim本来就这样
    "               " unlike  default |star|.  (default: 傻逼不分大小写, 让长得相似变量名难以区分:)
    "               "
    "         " -  Search selected text.
    "         " - "z" prefixed mappings doesn't move the cursor.
    "
                    "     " map <Right>   <Plug>(asterisk-*)
                    "     " map <Left>    <Plug>(asterisk-#)
                    "     " map g<Right>  <Plug>(asterisk-gz*)
                    "     " map g<Left>   <Plug>(asterisk-gz#)
                    "
                    "     " 导致新开终端时, 有时会输入is-nohl
                    "     " map <Right>   <Plug>(asterisk-*)<Plug>(is-nohl-1)
                    "     " map <Left>    <Plug>(asterisk-#)<Plug>(is-nohl-1)
                    "     " map g<Right>  <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
                    "     " map g<Left>   <Plug>(asterisk-gz#)<Plug>(is-nohl-1)
                    "
                    "     " map g*        <Plug>(asterisk-gz*)
                    "
                    "
                    "     " map z*  <Plug>(asterisk-z*)
                    "     " map gz* <Plug>(asterisk-gz*)
                    "     " map z#  <Plug>(asterisk-z#)
                    "     " map gz# <Plug>(asterisk-gz#)
                    "
                    "     " let g:asterisk#keeppos = 1    用一个另外颜色的光标选择match, 原光标不动
                    "     " let g:asterisk#keeppos = 0

PL 'https://github.com/sisrfeng/tele'
    "\ PL 'https://github.com/nvim-telescope/telescope.nvim'
    PL 'https://github.com/nvim-telescope/telescope-fzy-native.nvim'

PL 'https://github.com/sisrfeng/sk'
    PL 'https://github.com/sisrfeng/skim' ,
          \ {
           \ 'dir': $LEO_TOOL . '/skim',
           \ 'do': './install',
          \ }
    " /data2/wf2/leo_tools/skim/plugin/sk.vim
    " 挪到了
    "\ ~/PL/sk/plugin/sk.vim

    " :SK  调用 fun! sk#run(...),
        " 调用sk#exec
        " 调用 " let command = prefix.(use_tmux ? s:skim_tmux(dict) : skim_exec).' '.optstr.' > '.temps.result
        " 再给:
                " fun! s:execute_term(dict, command, temps) abort

    let g:skim_buffers_jump = 1
    let g:skim_history_dir = "$cache_X/nvim/skim_history"

    " tab split: 新开一个tab打开所选文件
    " tab split只是workaround, 先让本buffer多占一个tab, 后续用:buffer等命令
    let g:sk_editCmd = {
      "\ \ 'enter'  : '-tab drop', 报错  Vim(drop):E471: Argument required: silent -tab drop
      \ 'enter'  : '-tab split',
      \ 'ctrl-t' : '-tab split',
      \ 'ctrl-e' : 'edit',
      \ 'ctrl-v' : 'vsplit'
      \ }

    " 在这里设颜色:
        " /home/wf/dotF/cfg/nvim/colors/leo_light.vim
        " let g:skim_colors

    " ino <c-x><c-k>   <Plug>(-fzf-complete-trigger)


    " 没啥动静
    " ino   <expr> <c-x><c-k>   sk_funs#complete('cat /usr/share/dict/words')

    " ctrl-x后 等底栏有提示再ctrl l 才不会闪退
    " Global line completion (not just open buffers. ripgrep required.)


    fun! s:make_sentence(lines)
      return substitute(
          \ join(a:lines),
          \ '^.',
          \ '\=toupper(submatch(0))',
          \ '',
         \ )..'.'
    endf


    com!     -bang -nargs=*      GGrep
        \ call sk_funs#grep(
            \'git grep --line-number -- '.shellescape(<q-args>),
            \ 0,
            \ sk_funs#with_preview( {'dir': systemlist( 'git rev-parse --show-toplevel' )[0]} ),
            \ <bang>0,
            \ )


    " 为了map <Leader>F:
        " 目前要手动敲ctrl-g  to paste your query string

        " nnor <M-f>  <cmd>cd ..<cr><cmd>call Lf_cwD("Files")<cr>

        " 不跳到git的root
        " 留作它用吧, 容易记混
        " nnor <leader>f   :Rg<cr>

        " nno <leader>f :Lines<cr>

        " vmap  <M-f>       <Plug>LeaderfRgVisualLiteralNoBoundary<cr>
        " nmap  <M-f>       <Plug>LeaderfRgCwordLiteralNoBoundary<cr>
        " changing to git_root_dir
        vno <c-f>      y<Cmd>call Rg_livE()<cr>
        nno <c-f>    yiw<Cmd>call Rg_livE()<cr>

            fun! Rg_livE()
                " 一定要先运行git rev-parse, 再传给dir?
                let g_root = Get_git_rooT()

                if empty(g_root)
               \|| g_root =~ '/arxivs'
              \ || ( g_root =~ '/dotF' &&   g_root !~  'dotF/cfg/nvim' )
                    let g_root = getcwd()
                    " 别跳走
                en


                call chansend(g:term_jobS[-1], 'cd ' . g_root . "  \<cr>" )
                call chansend(g:term_jobS[-1],  @" )
                exe "norm \<c-j>"
            endf
            "

                "\ exe 'cd ' g_root
                "\ Telescope live_grep

                "\ let rg_cmd = '\rg                --color=always ' . get(g:, 'rg_opts', '') . ' "{}" ' . g_root
                "\ " let rg_cmd = 'rg  --line-number --color=always  . get(g:, 'rg_opts', '')..' "{}" '..'wF' .. dir
                "\                                                                             " can not use as query regex
                "\
            "\ 这只能找文件名
                "\ call sk_funs#grep(
                "\     \ rg_cmd                 ,
                "\     \ 1                      ,
                "\     \ sk_funs#with_preview() ,
                "\     \ 0                ,
                "\     \ )

                "\ return call(
                "\     \ 'sk_funs#grep_interactive',
                "\     \  [
                "\          \ rg_cmd,
                "\          \ 0,
                "\     \  ],
                "\     \ )

                        "\ 这样才有preview
                        "\ 又没了..
                        "\ \ sk_funs#with_preview( {'dir': systemlist( 'git rev-parse --show-toplevel' )[0]} ),


                " 试错笔记:
                    " return call(
                    "             \ 'sk_funs#grep_interactive',
                    "             \ [
                    "                 \ rg_cmd,
                    "                 \ 0,
                    "                 "\ 0: 不显示匹配字符所在column,   下面的是grep_interactive的a:000:
                    "                 \ sk_funs#with_preview(
                    "                                           \'right:50%:hidden',
                    "                                           \'alt-h',
                    "                                      \),
                    "                 "\ \ '--cmd-prompt','hhhhhhwfwf' 不行
                    "             \ ],
                    "             "\ 多了这个逗号报错:  ,
                    "          \ )


            " fun! Rg_rooT()
            "     let tmp_git_Root =  systemlist( 'git rev-parse --show-toplevel')[0]
            "      call sk_funs#rg_interactive(
            "                                   \tmp_git_Root,
            "                                   \sk_funs#with_preview(
            "                                                         \'right:50%:hidden',
            "                                                         \'alt-h',
            "                                                       \)
            "                                 \)
            " endf



                                      " 这一块不行
    "\ \ call sk_funs#rg_interactive( ¿shellescape(systemlist( 'git rev-parse --show-toplevel' )[0] )¿),
    " git 要run before rg?
    " 这样才行:
    " let tmp_git_Root = systemlist( 'git rev-parse --show-toplevel')[0] | exe 'Rg' tmp_git_Root
    " cnorea R_g_wf  let tmp_git_Root =
    "             \ systemlist( 'git rev-parse --show-toplevel')[0] \|
    "             \ exe 'Rg' tmp_git_Root
                                      " cnoreabbrev 里 ¿|¿ 要escape为 ¿\|¿
        " 定义为command, 失败 (闪退)
        " com!  Rr   let tmp_git_Root = systemlist( 'git rev-parse --show-toplevel')[0] <Bar> let @t = 'exe "Rg" tmp_git_Root'


                            " 第一个参数是搜索路径
    com!  -bang -nargs=* Rg
        \ call sk_funs#rg_interactive(
                                \<q-args>,
                                \sk_funs#with_preview(
                                                      \'right:50%:hidden',
                                                      \'alt-h',
                                                    \)
                               \)


              " fun! sk_funs#rg_interactive(dir, ...)
            "       let dir = empty(a:dir) ? '.' : a:dir
            "       let command = 'rg --column --line-number --color=always '.get(g:, 'rg_opts', '').' "{}" ' . dir
            "       return call('sk_funs#grep_interactive', extend([command, 1], a:000))
              " endf






    " 闪退:
    " https://github.com/lotabout/skim.vim/issues/18#issuecomment-943590875
        " com!     -nargs=* -bang     RG
            " \ call RipgrepFzf(<q-args>, <bang>0)
            "
            "     fun! RipgrepFzf(query, fullscreen)
            "         let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
            "         let initial_command = printf(command_fmt, shellescape(a:query))
            "         let reload_command = printf(command_fmt, '{q}')
            "         let spec = {'options': [
            "                             \ '--phony',
            "                             \ '--query',
            "                             \ a:query,
            "                             \ '--bind',
            "                             \ 'change:reload:'.reload_command,
            "                         \ ]
            "                   \}
            "
            "         call sk_funs#grep(
            "                         \ initial_command,
            "                         \ 1,
            "                         \ sk_funs#with_preview(spec),
            "                         \ a:fullscreen,
            "                        \ )
            "     endf


        "\ com!     -nargs=* -bang     Rr
            "\ \ call RipgrepFzf(<q-args>, <bang>0)
            "\
            "\     fun! RipgrepFzf(query, fullscreen)
            "\         let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
            "\         let initial_command = printf(command_fmt, shellescape(a:query))
            "\         let reload_command = printf(command_fmt, '{q}')
            "\         let spec = {'options': [
            "\                             \ '--phony',
            "\                             \ '--query',
            "\                             \ a:query,
            "\                             \ '--bind',
            "\                             \ 'change:reload:'.reload_command,
            "\                         \ ]
            "\                   \}
            "\
            "\         call sk_funs#grep(
            "\                     \ initial_command,
            "\                     \ 1,
            "\                     \ sk_funs#with_preview(spec),
            "\                     \ a:fullscreen,
            "\                    \ )
            "\     endf
            "\
            "\
            "\

    " Grep the Python files only,
    " exclude the unit tests folder/files.
        com!  -nargs=* -bang RG
                      \ call Rg_wF(
                            \ <q-args>,
                            \ sk_funs#with_preview('right:60%'),
                           \ )

        " fun! Rg_wF(q_str, dir,  ...)
            " 参数都是传给rg的
        fun! Rg_wF(q_str,  ...)
            let dir =  systemlist( 'git rev-parse --show-toplevel' )[0]
                           " echom a:q_str
            " echom a:dir
            " let dir = empty(a:dir) ?
            "       \ systemlist( 'git rev-parse --show-toplevel' )[0]
            "       \ : a:dir
            " let Cmd = 'rg --type py --glob "!**/tests/**" --column --line-number --color=always '
            let Cmd = 'rg --column --line-number --color=always '
                        \..get(g:, 'rg_opts', '')
                        \..' "{}" '
                        "\ 后面有些options会自动插入¿{}¿里面
                        \..shellescape(a:q_str)
                        \.." "
                        \.. dir
              " Verbose echom  extend([Cmd, 1], a:000)


            return call(
              \ 'sk_funs#grep_interactive',
              \ extend([Cmd, 1], a:000),
             \ )
        endf




    cno <m-;> <c-u>History:<cr>
    nno <m-;> <Cmd>History:<cr>
    " cnor <m-;> <esc>:History\/<cr>  " 不行


    " sk.vim的配置(大部分是默认的)
        " Mapping selecting mappings
        " 只能看 不能跳过去 没啥用
            " nmap <leader><tab> <plug>(fzf-maps-n)
            " xmap <leader><tab> <plug>(fzf-maps-x)
            " omap <leader><tab> <plug>(fzf-maps-o)


        " Insert mode completion
        " 导致copilot用不了?
            " imap <c-x><c-k> <plug>(fzf-complete-word)
            " imap <c-x><c-f> <plug>(fzf-complete-path)
            " imap <c-x><c-l> <plug>(fzf-complete-line)

            " ino   <expr> <c-x><c-l>
            "       \ sk_funs#complete(sk#wrap({  'prefix': '^.*$',
            "                                     \ 'source': 'rg -n ^ --color always',
            "                                     \ 'options': '--ansi --delimiter : --nth 3..',
            "                                     \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') },
            "                                     \ })
            "                        \)
            "
            " " 来自fzf.vim的readme
            " " Custom completion
            "     " ### Reducer example
            "
            " ino      <expr> <c-x><c-s>
            "         \ sk_funs#complete({
            "                             \ 'source':  'cat /usr/share/dict/words',
            "                             \ 'reducer': function('<sid>make_sentence'),
            "                             \ 'options': '--multi --reverse --margin 15%,0',
            "                             \ 'left':    20
            "                         \})
            "


        " An action can be a reference to a function that
        " processes selected lines
        fun! s:build_quickfix_list(lines)
            call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
            copen
            cc
        endf

        let g:fzf_action = {
            \ 'ctrl-q': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }


        " Customize fzf colors to match your color scheme
        " - fzf#wrap translates this to a set of `--color` options
        "   貌似没了这选项
            " let g:fzf_colors
            " let g:fzf_layout

        let g:fzf_history_dir = '~/.local/share/fzf-history'
            " Enable per-command history
            " - History files will be stored in the specified directory
            " - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
            "   'previous-history' instead of 'down' and 'up'.

        autocmd! User FzfStatusLine call <SID>fzf_statusline()
            fun! s:fzf_statusline()
                " Override statusline as you like
                hi link  fzf1 DebuG
                hi link  fzf2 DebuG
                hi link  fzf3 DebuG
                setl   statusline+=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
            endf
    "

    " 不习惯lua, 别用:
        " PL 'https://github.com/ibhagwan/fzf-lua'
        " set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
                                    " 貌似大一统了telescope, fzf.vim, nvim-fzf等
                                    " 淘汰leaderF?
                                    " An asynchronous Lua API for using fzf in Neovim (>= 0.5).
                                    " Allows for full asynchronicity for UI speed and usability.


"\ PL 'https://github.com/sisrfeng/ui_tool'  "\   ddu  \ 代替denite? 才开发了一年, 几百star
PL 'https://github.com/sisrfeng/f-ui'  , { 'do': ':UpdateRemotePlugins'  }   "\  'Shougo/denite.nvim',
    "\ 处理搜索(find)的ui
    "\ 比fzf慢, 但功能更多?

"\ 貌似用sk的history 就不再需要了:
    "\ PL 'https://github.com/sisrfeng/ui-mru'  "\  neomru  \ 用skim的history更好? skim可以设置文件的优先级?
    "\ PL 'https://github.com/sisrfeng/mru'
    " PL 'https://github.com/sisrfeng/mru-fzf'

PL 'https://github.com/sisrfeng/leaderF'
    let g:Lf_RootMarkers = [ '.git' ]

    let g:Lf_PreviewResult = {
            \ 'File'        : 0 ,
            \ 'Buffer'      : 0 ,
            \ 'Mru'         : 1 ,
            \ 'Tag'         : 0 ,
            \ 'BufTag'      : 1 ,
            \ 'Function'    : 1 ,
            \ 'Line'        : 0 ,
            \ 'Colorscheme' : 0 ,
            \ 'Rg'          : 0 ,
            \ 'Gtags'       : 1
            \}


    " 这是彻底不管?
    " Specify the files and directories you want to exclude while indexing.
    let g:Lf_WildIgnore = {
            "\ \ 'dir': ['.svn','.git','.hg'],
            \ 'file': [
                \ '*.sw?',
                \ '*.bak',
                \ '*.exe',
                \ '*.o',
                \ '*.so',
                \ '*.py[co]',
                \ ]
            \}

    " 这是只让mru不管?
    let g:Lf_MruFileExclude = [
        \ 'init.vim',
        \ 'fuzzy.vim',
        \ 'PL.vim',
        \ 'alias.zsh',
        \ ]



    let g:Lf_MruWildIgnore = {
            \ 'dir': [],
            \ 'file': []
            \}

    let g:Lf_MruMaxFiles = 200





        " let g:Lf_WorkingDirectory = getcwd()  " 应该不行, 这会导致load本文时,
    au AG DirChanged  window,tabpage,global,auto
        \ let g:Lf_WorkingDirectory = getcwd()
        " 还不太智能, 不对时就用我定义的map 🎹cd🎹 吧
        " workingDir被固定死?
        " DirChanged   After the |current-directory| was changed.
        "   The pattern can be:
        "           "window"  to trigger on `:lcd`
        "           "tabpage" to trigger on `:tcd`
        "           "global"  to trigger on `:cd`
        "           "auto"    to trigger on 'autochdir'.

    let g:Lf_TabpagePosition = 1
        "     1 - put the newly opened tab page before the current one.
        "     2 - put the newly opened tab page after the current one.
        "     Default value is 2.
    let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
    " let g:Lf_StlSeparator = { 'left': "\ue0b0",   'right': "\ue0b2",   'font': "DejaVu Sans Mono for Powerline" }
    " let g:Lf_StlSeparator = { 'left': "| ",   'right': " | ",   'font': "DejaVu Sans Mono for Powerline" }
    let g:Lf_WindowPosition = 'bottom'
        " popup mode
        " todo: 颜色有时会变成和背景一样, 不好区分
        " let g:Lf_WindowPosition = 'popup'
        " let g:Lf_PreviewInPopup = 1
            " popup window是vim的叫法
            " nvim里有popup menu, 没有popup window (叫floating window)
            "

    let g:Lf_HideHelp = 1
            " don't show the help in normal mode
    let g:Lf_UseCache = 0
        " 设为1, 可以避免reindex, 但可能更新不及时?
    let g:Lf_CacheDirectory = $cache_X
    let g:Lf_WorkingDirectoryMode = 'f'  " current working file
    let g:Lf_UseVersionControlTool = 0
    let g:Lf_IgnoreCurrentBufferName = 0

    let g:Lf_CommandMap = {'<tab>':[ '<ESC>' ],
                        \'<c-t>':[ '<cr>'  ]}   "leaderf的弹窗的insert模式下, 让enter在new tab打开
                        " '旧键位' : ['新键位1', 新键位2' ]
        "
        " 不行...还是要按t才能在new tab是打开
    let g:Lf_NormalMap = {
        \ "_":   [
        \            ['t', '<cr>'],
        \        ],
        \}
    " 在rg_cfg.zsh  里设了glob的忽略规则, 所有调用rg的地方都能生效?

    " let g:Lf_GtagsfilesCmd = {
    "         \ '.git': 'git ls-files --recurse-submodules',
    "         \ 'default': 'rg --no-messages --files'
    "         \}
            " use command `git ls-files --recurse-submodules` for git  repository
            " use `rg --no-messages --files`  otherwise.
            " 这是为了更好地处理ignore?


    " 和zsh下按ctrl f 作用一致
    let g:Lf_ShortcutF = "<M-F>"  " 要想快点弹出窗口，按下f后，马上输出字符

    " mru: most recently used file
        " 想避免v:oldfiles有时被清空,
        " 但没生效:
            au AG VimLeavePre  wshada $cache_X/nvim/wf_mru.vim
            au AG VimLeave     wshada $cache_X/nvim/wf_mru.vim
        "\ 在这里生效了:/home/wf/dotF/cfg/nvim/ReloaD.vim

        nor   <M-M>                    :<c-u> Leaderf mru<CR>
        tnor  <M-M>          <c-\><c-n>:<c-u> Leaderf mru<CR>
        nor!  <M-M>               <esc>:<c-u> Leaderf mru<CR>
            " 文件的顺序有时不合心意, 用Denite file_mru 代替? (但没有图标和高亮)

        nor   <M-m>                    :<c-u> History<CR>
        tnor  <M-m>          <c-\><c-n>:<c-u> History<CR>
        nor!  <M-m>               <esc>:<c-u> History<CR>


        nnor  <leader>m     <Cmd>Marks<cr>
        " tnor <leader>m :<c-u> tab <C-R>=printf("Leaderf! mru %s", "")<CR><CR>
        "    这样map了终端里就用不了空格啊

        "\ nnor <leader>/   :<c-u> -tab <C-R>=printf("LeaderfLineAll %s", "")<CR><CR>
        "\ nnor <c-b>     :<c-u> -tab <C-R>=printf("Leaderf! rg --current-buffer %s ", expand("<cword>"))<CR><CR>
                                        "  LeaderfFunction! 叹号版本直接打开 normal 模式，并且定位到对应位置
        nno   <M-b> :Buffers<cr>
        "\ 待用:
        nno   __    :Buffers<cr>
        nno   _    :Buffers<cr>


        func! Lf_cwD(_cmd)
            let g:Lf_WorkingDirectory=getcwd()
            echom "Lf目录:" . g:Lf_WorkingDirectory
            exe a:_cmd
        endf

        " com!   -bang -nargs=? -complete=dir Files
        "     \ call sk_funs#files(
        "                         \ <q-args>,
        "                         \ sk_funs#with_preview(),
        "                         \ <bang>0,
        "                       \ )

        " Files和GFiles都有个zsh: not found啥的不碍事的错误, 因为没source rc.zsh?
        nnor <M-f>  <Cmd>call Files_smarT()<cr>
        fun! Files_smarT()
            let g_root = Get_git_rooT()

            if empty(g_root)
                Files
            else
                if g_root =~ 'tbsi_final'
             \ || g_root =~ 'final'
             \ || g_root =~ '/dotF'
             \ || g_root =~ '/tT'
                    Files
                el  "\  从git项目的root搜
                    exe 'Files' g_root
                    "\ GFiles  不好, git ls-files的exclude/ignore规则 感觉不适合这个用途
                en
            en
        endf


        " nnor <c-f>  :call Lf_cwD("Files")<cr>
            " nnor <c-f>  :call Lf_cwD("LeaderfFile")<cr>  慢 卡死
            " nnor <c-f>  :call Lf_cwD("Telescope fd")<cr>
                " insert mode会莫名切到normal mode
            " nnor <M-f>  <cmd>cd ..<cr><cmd>call Lf_cwD("LeaderfFile")<cr>.vim<esc>
                                " usually want to open file in plugin/../autoload/.vim
                                " and invert

        " nnor <leader>F :call Lf_cwD('')<cr>
        "       \:tab <C-R>=printf("Leaderf rg  %s ", expand("<cword>") )<CR><CR>
        "                                      " -e, --regexp PATTERN ...
        "                                      "     This option can be provided multiple
        "                                      "     times, where all patterns given are searched. Lines matching at
        "                                      "     least one of the provided patterns are printed.
        "                                      "
        "                                      "     This flag can also  be used when searching for patterns that start with a dash.
        "                                      "
        "                                      "     For example, to search for the literal -foo, you can use this flag:
        "                                      "         rg -e -foo
        "                                      "
        "                                      "     equivalent to the  above:
        "                                        "         rg -- -foo


        " todo
            " 用得到?
            " search visually selected text literally
            " xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
            " nor go :<C-U>Leaderf! rg --recall<CR>
                " ctrl u是为了在omap vmap等情况下,  清除选定的范围

            " should use `Leaderf gtags --update` first
            let g:Lf_GtagsAutoGenerate = 0
            let g:Lf_Gtagslabel = 'native-pygments'
            " nor <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
            " nor <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
            " nor <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
            " nor <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
            " nor <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

            au AG BufWritePost,FileWritePost frogNet/*.py :silent! !ctags -R -o /data2/wf2/frogNet/tags /data2/wf2/frogNet
                " tags相关:(和leaderF关系不大, 先扔这里吧)
                " todo debug buggy/ 出问题来这里
                " 这会很慢?

" " 和leaderF比, ctrlp的star数更多. 但比较老, 但被skywind吐槽过. 貌似不能search file by content
            " PL 'ctrlpvim/ctrlp.vim'
            "     let g:ctrlp_match_window = 'bottom,order:btt,min:80,max:80,results:10'
            "     let g:ctrlp_switch_buffer = 'ET'




