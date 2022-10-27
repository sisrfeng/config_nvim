" 和系统粘贴板打通(但隔着ssh, 到不了本地), 有了tmux_好像不用了
    " 我的飞书笔记:https://cmb-d3-ocr.feishu.cn/docs/doccnSbue41vpDkdPAtYDWrxaNc#
    "
    nno <Leader>y  "+y
    nno <Leader>yy "+yy

    vno y ygv<esc>
    "\ snor y y<esc>ii
    "\ snor y y<esc>i

    vno <leader>y "+ygv<esc>
        " 让光标停在复制结束时的位置

    no <Leader>Y "+Y
    " no <Leader>P "+p
        " 没有ctrl v 那么快
        " (ctrl v 被windows terminal的接管了, 永远起粘贴的作用. 可以自己改掉, 但这导致粘贴系统的粘贴板内容不方便)
        " nno <Leader>p i<c-v><esc>
                " 这里的ctrl v是显示特殊字符


    " inor <c-r><c-r> <c-r>"
    " cnor <c-r><c-r> <c-r>"
    " tno <c-r><c-r> <c-r>"
    nno  <c-g>  <cmd>hi Visual  guibg=#e0e9e0<cr>`[v`]
        " 选中并高亮最后一次插入的内容
        " 有时和gv的区域一样
    nno <Leader>v  <Cmd>hi Visual  guibg=#e0e9e0<CR>`[v`]


    "\ cno <c-g>      <cmd>  let _cmd = @" <bar>
    cno <c-d>      <cmd>  let _cmd = @" <bar>
                         \ call histadd("cmd", substitute(_cmd, "\n","","") )
                         "\ call histadd("cmd", _cmd)  这样 没把行末的^@(NL)去掉
                   \<cr>
                   \<c-r>"

        " - Only commands that are typed are remembered.
          " Ones that completely come from  mappings are not put in the history.
        " https://stackoverflow.com/a/26437446/14972148

    ino <c-d>           <c-r>"

    tno <C-d>   <C-\><C-N>p<esc>a
    "\ tno <C-d>      <C-\><C-N><c-r>"a  " 貌似不行
        " To simulate |i_CTRL-R| in terminal-mode:
        "\ tno <expr> <C-d> '<C-\><C-N>"' . nr2char(getchar()). 'pi'
                                                        " getchar() 等用户敲一个键, 获取其ascii码
                                                " nr2char ascii码转为字符

    cnor <C-Right>  <c-r><c-w>

    " todo:  https://vi.stackexchange.com/questions/7449/how-can-i-use-tmux-for-copying-if-i-cant-access-the-system-clipboard
         " nno <silent> yy yy:call system('tmux set-buffer -b vim ' . shellescape(@"))<CR>
         " nno <silent> p :let @" = system('tmux show-buffer -b vim')<cr>p$x




" The presence of a working `clipboard tool`    implicitly enables the '+' and '*' registers.
  " Nvim looks for these clipboard tools, in order of priority:

            "  |g:clipboard|  we can custom xclip by set g:clipboard
            "  xclip (if $DISPLAY is set)
            "  etc.....




        if hostname() == 'redmi14-leo'  " 这不行: if has('win32')
            let g:clipboard = {
                            \  'name': 'wf-win32yank-wsl',
                            \  'copy': {
                            \     '+': '/mnt/d/win32yank.exe -i --crlf',
                                        "\ wsl和windows的clipboard是一个东西?
                            \     '*': '/mnt/d/win32yank.exe -i --crlf',
                            \   },
                            \  'paste': {
                            \     '+': '/mnt/d/win32yank.exe -o --lf',
                            \     '*': '/mnt/d/win32yank.exe -o --lf',
                            \  },
                            \   'cache_enabled': 0,
                            \ }
                            " windows的+和*, 本来是一样的, 但这里可以改掉.
        el
        " todo: 参考:https://searchcode.com/file/189000618/vim/cfg/features/clipboard.vim/

            let g:clipboard = {
                \   'name': 'ClipboarD-linux',
                \   'copy':  {
                \             '+': 'xclip -selection clipboard -in -silent -loops 2',
                \             '*': 'xclip -selection clipboard -in -silent -loops 2',
                \            },
                \   'paste': {
                \            '+': 'xclip -selection clipboard -out',
                \            '*': 'xclip -selection clipboard -out',
                \            },
                \   'cache_enabled': 1,
                \ }
            " 这样定义星号寄存器, 写法不起作用, 而且导致粘贴很慢: '*': '"by',
            " 只这样定义加号寄存器, 隔着ssh也很快:
                      "       '+': 'xclip -selection clipboard -in -silent -loops 2'
            " primary对应鼠标中键, 都用鼠标了, 那就别占了星号寄存器
                " help里的写法: ['tmux', 'load-buffer', '-'],

            " todo:
            " https://github.com/ms-jpq/isomorphic_copy
                " 这个不是vim的插件,
                " 号称可以无限套娃, 需要x11转发?

            set clipboard=
            " :help clipboard
                " 等号右边为空, 意思是 不把系统的clipboard和unnamed绑定在一起?
                " set clipboard=unamedplus,unnamed 里面的unamedplus又是什么鬼名字?
        en

nno gl           <Cmd>call Get_file_locatioN()<cr>
nno wl   iechom '来啦, '<esc><Cmd>call Get_file_locatioN()<cr>hp
    fun! Get_file_locatioN()
        if &buftype == 'terminal'
            let @" = getcwd()
        else
            let @" = fnameescape( expand("%:p") )
        en

        let @+ = @"

        echom @"
    endf


    " yl: yank location
    " 不好敲, 还是get location好


" 快速viw caw等
    nno vp viwp
    nno vw viw
    nno vW viW
        " 想选到单词末尾, 用ye


    nno dm  %v%d
    nno vm  %lv%h
    nno cm  %lv%hc
    nno ym  %lv%hy
         "\ m for matchup
            "\ 先跳到一端


    " no x "_x
        " 别用,会导致(专治typo的)xp无法使用
    vno p "_dP
        " paste in visual mode without updating the default register

    nno p P
        " p and P affect the position of the insert with respect to the surrounding text.
        " they don't affect the position of the cursor itself which is always at the same position relative to the inserted text.
    " nno p <left>P 要是到了行首 就无法粘贴


    " ✗p: paragraph  看哪个好用✗
    " 还是直接vip吧, vP留作它用
        " nno vP Vip


    nno P v$<left>"0P
        " 类似于Y D C等，到行末
        " nno P v$<left>P 不好
        " 加上"0 避免连续粘贴时, 被删掉的内容污染



    " todo: `omap`代替下面的有点重复的各种operator的map
        " omap ' i'
        " omap " vi"
        " omap ( i(
        " omap ) i)
        " omap [ i[
        " omap ] i]
        " omap { i{
        " omap } i}
        " omap } i}
        " omap ' i'



    nno v\| vi\|
        " bar要escape
    " 没必要: 有个pair啥的插件 v<space>就行?   |adf adsfadsf|

    nno v" vi"
    nno v( vi(
    nno v) vi)
    nno v[ vi[
    nno v] vi]
    nno v{ vi{
    nno v} vi}
    nno v} vi}

    nno yp mtyyp`tj
    nno yw yiwj

    nno <leader>yw "+yiwwh
    nno y' yi'
    nno <leader>y' yi'
    nno y" yi"
    nno <leader>y" yi"
    nno y` yi`
    nno <leader>y` yi`


    nno cu cib
    nno yu yib
    nno du dab
    nno diu dib
    nno vu vib
    " vno iu ib
    " (adfasdf)
        " 因为vk88加u是小括号

    nno ck ci[
    nno yk yi[
    nno dk da[
    nno vk vi[

        " 中指   对应中括号
    nno cb  ci{
    nno cib ci{
    " vno ib i{
    nno vib vi{
    nno dib di{
    nno db  di{
    nno yb  yi{
        " 大拇指
        " 或者记作brace


    nno y( yi(
    nno <leader>y( yi(
    nno y[ yi[
    nno <leader>y[ yi[
    nno y{ yi{
    nno <leader>y{ yi{
    nno y< yi<
    nno <leader>y< yi<

    " 貌似因为装了插件, 这些都可以:
        " yi,
        " yi.


    nno cw ciw
    nno cW ciW
    " nno cp cip
    " 很少用


    nno c( ci(
    nno c) ci)
    nno c[ ci[
    nno c] ci]
    nno c{ ci{
    nno c} ci}

    nno dp dip

    nno dw diw
    nno dW diW
    nno d" da"
    " nno d( da(
    " nno d) da)
    " nno d[ da[
    " nno d] da]
    " nno d{ da{
    " nno d} da}



    " inor cb '''<Esc>Go'''<Esc><C-o>i
    " change a block  " 百分号 能自动跳到配对的符号
    " ono      b %ib
    " nno cb %cib
    " nno vb %vib
    " nno yb %yib

    " db:  往回删
    nno dB %dab

        "默认:
            " "dib"	delete inner '(' ')' block
            " "dab"	delete a '(' ')' block
            " "dip"	delete inner paragraph
            " "dap"	delete a paragraph
            " "diB"	delete inner '{' '}' block
            " "daB"	delete a '{' '}' block

    "   "1p... is basically equivalent to "1p"2p"3p"4p.
    " You can use this to reverse-order a handful of lines: dddddddddd"1p....
    " 往register w的中间插入内容
            " :let @w='<Ctrl-r w>其他命令'
            " https://www.brianstorti.com/vim-registers/

	nno yf  mt
           \ggyG
           \`t<cmd>let @+ = @"<cr>

    nno <Leader>yf   mt
                    \gg"+yG
                    \`t

    nno vf ggVGp:echo"已粘贴之前复制的内容"<CR>
    nno df ggdG
        " p后面一般没有参数，所以pf不好。选中全文，一般只是为了替换。所以vf选中后，多了p这一步
    " inor yf <Esc>ggyG<C-O>
        " vscode里不行，vscode外也别试了, 保持一致

    " 进了paste mode会导致cnoreabbr失效, 而且手动改很麻烦

   nno <Leader>gc :Denite register<cr>
   vno <Leader>gc :Denite register<cr>
              " get clipboard
              " gr被占用了: go redo


" bracketed paste mode 代替set paste
" 在ctrl v粘贴时 没有乱缩进了
" 但ctrl G (map成<C-R>") 还是乱缩进
    " Code from:
        "    http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x
        "    http://www.xfree86.org/current/ctlseqs.html
    " Docs on mapping fast escape codes in vim
              " http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
            "    https://coderwall.com/p/if9mda
            "    https://github.com/aaronjensen/vimfiles/blob/59a7019b1f2d08c70c28a41ef4e2612470ea0549/plugin/terminaltweaks.vim
            "        to fix the escape time problem with insert mode.


    " 作者为了把这功能 封装为插件, 才需要这几行?
        " if exists("g:loaded_bracketed_paste")
        "     finish
        " endif
        " let g:loaded_bracketed_paste = 1
        "

    " let &t_ti .= "hhhhhhhhhhhh"
        " 为了兼容, 设了这个变量, nvim也不报错?
        " let &aaaaaaaaaa .= "hhhhhhhhhhhh"
        " || E355: Unknown option: aaaaaaaaaa
        " 但是:
        "      set t_ti?  报错

        " Nvim does not have special `t_XX` options
        " no <t_XX> keycodes to configure  terminal capabilities.
        " Instead Nvim treats the terminal as gui?


    fun! XTermPaste(ret)
        set pastetoggle=<f29>
        set paste
        return a:ret
    endfunc

    exe     "set <f28>=\<Esc>[200~"
    map  <expr> <f28> XTermPasteBegin("i")
    imap <expr> <f28> XTermPasteBegin("")
    vmap <expr> <f28> XTermPasteBegin("c")
    cmap <f28>  <nop>

    exe     "set <f29>=\<Esc>[201~"
    cmap <f29>  <nop>

    " 我之前的不太好的方案
        " inor <F9> <esc>:call  Paste_toggle()<cr>i
        "
        " func! Paste_toggle()
        "     set paste!
        "     if &paste == 0
        "         echo '不是paste mode'
        "     else
        "         echo '进了paste mode, 放心按ctrl v吧'
        "     endif
        " endfunc

            " vim(而非nvim)里 不用设set paste也不会乱缩进.
                " (但手动敲 还是不会缩进, 因为vim没开语法提示?)
            " set paste后, cabbrv不生效.
            " windows terminal默认开了bracketed paste mode?
            " 但还是要set paste
            " https://github.com/microsoft/terminal/issues/9364
