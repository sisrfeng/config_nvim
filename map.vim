
"\ notes
    "\ 1.  Key notation pairs <Tab>/<C-I>, <CR>/<C-M>, <Esc>/<C-[> are no longer treated as the same. #17825
        " 但终端无法分辨<cr>和<c-m> ??

    "\ 2. 千万别map  hjkl  导致移动很卡



"\ 只保留~/PL/scriptV/autoload/scriptV.vim的:
        "\ nno            gh
        "\                  \  <Cmd>silent! helptags ALL<cr>
        "\                     \<Cmd>let @h = scriptV#smart_help()<cr>
        "\                    \:<C-U>-tab help <C-R>h
        "\ "\ 本来在~/PL/scriptV/autoload/scriptV.vim的
        "\     "\ func! scriptV#setup_vim() abort 里


vno gm  "myo<C-r>=<C-r>m<cr><esc>
nno gm  V"myo<C-r>=<C-r>m<cr><esc>
    "\ get math


"\ nno <Leader>ol <Cmd>call Smart_out_linE()<cr>
fun! Smart_out_linE()
    if &ft == 'xxxxx'
    "\ if &ft == 'vim'
        Denite outline
    el
        CocOutline
    en
endf

nno gw  z=
nno gn  <Cmd>try <Bar>lnext<Bar>catch<Bar>cnext<Bar>endtry<cr>
nno gN  <Cmd>try <Bar>lNext<Bar>catch<Bar>cNext<Bar>endtry<cr>
    "\ get word


nno   <Leader>w    <Cmd>call To_tex_quickfiX()<cr>


fun! To_tex_quickfiX()
    if empty(getqflist())
        echo 'getqflist为空, latex没毛病'
    el
        -tab drop ~/d/tT/wf_tex/PasS.tex
        let g:wf_vimtex_stick_to_qf = 1
        call vimtex#qf#open(1)
        let g:wf_vimtex_stick_to_qf = 0
    en
endf



nno   tl           <Cmd>-tab drop ~/d/tT/wf_tex/PasS.tex<cr>
                  \<Cmd>call vimtex#misc#reload()<cr>
                   \<Cmd>!rm -rf $HOME/d/tT/wf_tex/out扩展<cr>
                   \<Cmd>VimtexCompile<cr>

                   "\ \<Cmd>VimtexCompileSS<cr>




" 处女地

nno g<c-g>  :echo '待用'<cr>
nno g<c-a>  :echo '待用'<cr>

" skim/fzf 的keymap 尽量用<M-某>
nno <M-h>  <Cmd>Helptags<cr>
nno <Leader>F   "fyiw:Verbose func    g:<c-r>f
nno <Leader>C   "cyiw:Verbose command <c-r>c

nno <BS>  viWr |
vno <BS>     r |

vno <Leader><Leader>      r |
"\ vno <Leader>              r |

nno <Leader><Leader>   viWr |
"\ nno <Leader>           viWr |
    "\ 敲<Leader>某某时,容易错手删掉内容


"\ nno <buffer> <Leader>V  <Cmd>call View_anywhere()<cr>
"\ nno          <Leader>V  <Cmd>call View_anywhere()<cr>
    "\ if !exists("*View_anywhere")
    "\ "\ 避免: Function View_anywhere already exists, add ! to replace it
    "\     fun! View_anywhere()
    "\         if expand('%:t:e') != 'tex'
    "\             -tab drop ~/d/tT/wf_tex/PasS.tex
    "\         en
    "\         update
    "\         "\ VimtexCompile
    "\         "\ echo  '马上跑第2次VimtexCompileSS'
    "\         VimtexCompileSS
    "\         "\ \:echo  '2次VimtexCompileSS都结束了'<cr>
    "\
    "\         " 有时要有2次VimtexCompileSS
    "\
    "\         "\ \:echo 'compiling ... 开viewer 可能是旧pdf'<cr>
    "\         "\ \<Cmd>VimtexView<cr>
    "\     endf
    "\ en



nno td      <Cmd>call funcS#To_digiT()<cr>

nno <silent> <Leader>x V:<C-U>call cursor(line("'}")-1,col("'>"))<CR>`<1v``
vno <silent>          X :<C-U>call cursor(line("'}")-1,col("'>"))<CR>`<1v``
" https://vi.stackexchange.com/questions/20782/jump-to-end-of-paragraph

nno <C-3> :echom 'ctrl_3 没动静'<cr>
"\ nno     <c-a>
    "\ tmux里ctrl 3 显示 
    "\ 即<esc>, 别map
"
"
    "\ alt + CaspLocak
    "\ 1. terminal下
        "\ todo:  ahk让alt+caps 变为 <F7>?
        map     <F7>  <C-F7>
        map!    <F7>  <C-F7>

        tmap    <F7>      cd - <cr>
        tno     <C-F7>    cd - <cr>
        tno     <M-F7>    cd - <cr>
        "\ 在neovide下, ahk让alt+caps的结果 (薛定谔..)
                "\ <F7>
                "\ <C-F7>
                "\ <M-F7>
        tno     <F31>     cd - <cr>
                "\ 在windows termnial里, alt+caps是<F31>


    "\ 2.  快速查map
        func! KeymaP(mode, keys)
            if a:mode == 'A'
                exe 'verbose'          'map'     a:keys
                exe 'verbose'         ' map!'    a:keys
                exe 'verbose'         ' tmap'    a:keys
            el
                exe 'verbose'    a:mode . 'map'    a:keys
            en
        endf
                          "   mm: mark before 敲map
                                    " Verbose 主要干了:  exec 'pedit ' . temp . '| wincmd P '

        nno <C-F7>        mm:Verbose call KeymaP('A', input("查:") )<cr>
        nno <F31>         mm:Verbose call KeymaP('A', input("查:") )<cr>

        nno <C-F7>n        mm:Verbose call KeymaP('n', input("normal的:") )<cr>
        nno <F31>n         mm:Verbose call KeymaP('n', input("normal的:") )<cr>

        nno <C-F7>v        mm:Verbose call KeymaP('v', input("visual的:") )<cr>
        nno <F31>v         mm:Verbose call KeymaP('v', input("visual的:") )<cr>

        nno <C-F7>i        mm:Verbose call KeymaP('i', input("insert的:") )<cr>
        nno <F31>i         mm:Verbose call KeymaP('i', input("insert的:") )<cr>

        nno <C-F7>c        mm:Verbose call KeymaP('i', input("ex mode的:") )<cr>
        nno <F31>c         mm:Verbose call KeymaP('i', input("ex mode的:") )<cr>

        nno <C-F7><leader>       mm:vertical Verbose call KeymaP( 'A', '<leader' .. '>' .. input('空格后接:') )<cr>
        nno <F31><leader>        mm:vertical Verbose call KeymaP( 'A', '<leader' .. '>' .. input('空格后接:') )<cr>

        " todo: 想敲map后直接跳到第一个出现的定义处, 省得敲cm, 未果:
                " nno map       :Verbose call KeymaP( quickui#input#open('查找map:', '') )<cr>  "
                    " 这个无法输入ctrl c 原样输入key sequences
                " nno map       :Verbose call KeymaP( input("请输入:") )<cr>/\s\d<cr>lyiwbbgf:<C-R>"<cr>
                    "  想直接跳到第一个找到map, 失败 (无法输入, 直接跳到slash的map)
                    "  不过 don' t go to further!!!   有时候只要看map是什么 不需要编辑

                " l表示leader
            " todo:  想偷懒 每次少敲<c-c>, 但不行
                " nno map       :Verbose call KeymaP( input("请输入{left_hand_side}:<c-v>") )<cr>
                " nno map       :Verbose call KeymaP( input("请输入:")<c-v> )<cr>

            " 不行
                " command! -nargs=* Map :new<CR>:put = Vim_out('call KeymaP(input())')
            " 不行
                " :put = Vim_out("call KeymaP('ls')")
                    " getcmdpos() 是光标的起始位置, 不是输入后的位置(输入字符的长度)
                                    "
                                    "

"

" 全部使用<unique> 避免覆盖?
" map <unique> aa xxxxxxxxxxxxxxxxx
"\ nno <c-space>C   <cmd>call Conceal_0_1_2()<cr>
"\ nno <leader>C    <cmd>call Conceal_0_1_2()<cr>
"\ nno <M-C-K>      <cmd>call Conceal_0_1_2()<cr>

nno <C-K>        <cmd>call Conceal_0_1_2()<cr>
    fun! Conceal_0_1_2() abort
        if &conceallevel == 0
            let &conceallevel=2
        elseif &conceallevel == 2
            let &conceallevel=0
            hi link texDelim             Normal
            call clearmatches()  " remove conceal effect
            call nvim_buf_clear_namespace(0,-1,0,-1)
        en
    endf


    "\ fun! Conceal_0_1_2() abort
    "\     if &conceallevel == 0
    "\         let &conceallevel=1
    "\     elseif &conceallevel == 1
    "\         let &conceallevel=2
    "\
    "\         hi link texDelim             HidE
    "\         " hi texDelim guifg=none guibg=none gui=none
    "\             " 大括号的fg还受其他位置控制
    "\         hi link texMathDelim         texDelim
    "\
    "\     elseif &conceallevel == 2
    "\         let &conceallevel=0
    "\         hi link texDelim             Normal
    "\         call clearmatches()  " remove conceal effect
    "\
    "\     en
    "\ endf

nno <cr> <c-]>
" nno <cr> :call To_taG()<cr>
    " fun! To_taG()
    "     let g:Old_isK = &isk
    "     set isk+=#
    "     " exe 'normal!  \<c-]>'  单引号内, backslash can not escape?
    "     exe "normal!  \<c-]>"
    "     let isk = g:Old_isK
    "     " echo 'iskeywords:'  &isk
    "
    " endf

vno <C-CR> <c-]>
nno <C-CR> <c-]>
" windows terminal里<c-cr>识别为<c-j>
" 敲<c-m> 可以识别为回车 ,


"timeout
    set timeoutlen=450
    " 主要影响map

    set ttimeout ttimeoutlen=10
        " tty?
        "
" search
    " ms: mark as searh, 回头敲's跳回来
    " https://stackoverflow.com/a/3760486/14972148
    " 据说map了slash会影响其他插件. 不过先用着吧

    nno ? ms/\v^\s*[^ <c-r>=Char4comment()<cr>]*\zs
    "\ nno ? ms/\v^\s*[^ <c-r>=Char4comment()<cr>].*\zs
    " nno ? msgg/\v^\s*[^ <c-r>=Char4comment()<cr>].*\zs
                        "\ ¿[]¿里的是 最早出现的 非空且非delimeter字符

    " 好复杂, 先别管:
        " set commentstring 仅用于fold, 不能用于注释
        " set comments="b:#"  这表示#号后要有blank(空格等)
            " 默认(本来由逗号分开的):
                    " s1 : /*
                    " mb : *
                    " ex : */
                    "
                    "    : //
                    " b  : #
                    "    : %
                    "    : XCOMM
                    " n  : >
                    " fb : -

    "\ nno g/ mszRgg<esc>/
        " 先mark再跳走
        " 记作global search
        "\ 没方便多少

    " nmap / :silent! normal zO<cr>ms<Plug>(incsearch-forward)
            " 直接在map里用zR的话, 可能报错: no fold found啥的

        " 和gh有点对应的感觉, 有时代替*和#  (不加<>)
    nno   g/      ms"s
                 \yiw/<c-r>s
    "\ 另有:
        "\ nmap  <Right>  <Plug>ImprovedStar_*<Plug>SearchIndex
        "\ nmap  <Left>   <Plug>ImprovedStar_#<Plug>SearchIndex
        "\
        "\ vno  <Right>  "cy<esc>/<c-r>c<cr>
        "\ vno  <Left>   "cy<esc>?<c-r>c<cr>

    " nno   /       ms
    "              \<Cmd>BLines<cr>
    nno   <M-/>    ms
                  \<Cmd>BLines<cr>
    vno   <M-/>    "sy
                  \ms
                   \<Cmd>BLines<cr>

             "\ \<Cmd>let g:current_line_for_BLines = line(".")<cr>

    " nno   /    mszR/\v
        "\ 不需要very magic时, 敲¿:/¿
        " 不能incremental search
  " \ nno   /    mszR/
    "\ nno   /    /\v

    nno gg mggg
        " 先mark再跳走
        " nno gg mggg  别用,不然导致数字加gg只能跳到首行


cno <M-n> <c-g>
cno <M-p> <c-t>


nno \ <Cmd>call To_global_mark()<cr>
fun! To_global_mark()
    noswapfile -tab drop /tmp/useless.md
    exe 'normal! `' .. toupper(input("To global mark: "))
                              " 如何省下敲<cr>?
endf

" 方便高亮命令:
"   not needed now?
    " nno ch <cmd>.,$ sub  #"#`#gc<cr>
    "     " command highlight
    " nno cH <cmd>.,$ sub  #"#´#gc<cr>
    " inoreabb _acute_ ´
    "
    "     " 不行
    " " nno cH <cmd>.,$ sub  #"#´#gc<cr>
    " nno cs :silent .,$ sub #\v\*[#-)!+-~]+\*\zs\s+\ze\*[#-)!+-~]+\*(\s<bar>$)#  #gc<cr>
    "     " change star


" nno <M-A> :echom 'shift alt a'<cr>
    " 一样:
    " nno <M-S-a>
" nno <M-a> :echom 'alt a'<cr>
" nno <M-i> :echom 'alt i'<cr>


"\ p for previous, 上一处有连续空格的
no <c-p> <Cmd>call search('\v%(\s{3,})\|%(\s\s"\s)', 'be')<cr>
                                      "\ ¿\|¿ 这里表示¿或¿ 在map里bar要escape?
                                                     "\ 'b'   search Backward
                                                      "\ 'e'    move to the End of the match


vno <c-o> <esc>mv<c-o>mw`vV`w
    " behave consistently with normal mode

ino <C-U> <C-G>u<C-U>
ino <C-W> <C-G>u<C-W>
    " neovim的默认, 我挪过来, 方便自己管理


nno <M-o>  <Cmd>call Col_below()<cr>i<down>
    " 现在凑合着用吧, 如果当前行未注释, open一行后又要注释,
    "       得手动来
    " 不行
        " nno <M-o> :call Col_below()<cr>i<down><esc>:call nerdcommenter#Comment('n', 'toggle')<CR>
    func! Col_below()
        " if  in Char4comment()
        " let _part = strpart(getline('.'), col('.') - 1)  " 复制当前行 从光标所在列左边 到行末
        " return strcharpart(_part, 0, 1)

        norm! hh
        norm! mt
        exec "normal! o\<esc>`t"
    endf

nno we /example/e+1<cr>
    " want example
nno w<space> viwr<space>


nno vH v<Cmd>call First_Non_comment()<cr>
no   H   <Cmd>call First_Non_comment()<cr>
    " 大一统了:
        " nno H   <Cmd>call First_Non_comment()<cr>
        " vno H   <Cmd>call First_Non_comment()<Cr>
        " ono H   <Cmd>call First_Non_comment()<cr>

    func! First_Non_comment()
        norm! g^
        if Char_at_Cursor() == Char4comment()
            norm! w
        en
    endf
    func! Char4comment()
            let b:_pre = '"'
            let b:ext = expand('%:e')
                    " filetype.vim  里也是根据后缀名确定filetype的
        if b:ext == 'vim'
            let b:_pre = '"'
        elseif b:ext == 'lua'
            let b:_pre = '-'
            "\ let b:_pre = '--'
        elseif b:ext == 'ahk'
            let b:_pre = ';'
                " todo 装个插件
                " https://github.com/hnamikaw/vim-autohotkey
        elseif index(['zsh', 'sh', 'py', 'yml', 'yaml', 'toml', 'ini'], b:ext ) >= 0
                " https://vi.stackexchange.com/a/29471/38936
            let b:_pre = '#'
        elseif index(['zsh'], &filetype ) >= 0
            let b:_pre = '#'
        elseif index(['json', 'jsonc', 'cpp', 'conf'], b:ext) >= 0
            let b:_pre = '(//)'
        elseif index(['tex', 'bib', 'bbl'], b:ext) >= 0
            let b:_pre = '%'
        elseif index(['cpp'], &ft) >= 0
            let b:_pre = '(//)'
        el
            let b:_pre = '#";(//)'
                " vscode neovim无法识别filetype?
                " 暂时一锅乱炖
        en

        " 不行: 涉及字符串解析?
            " let _rhs = "normal!" . "msgg/\v^[^" . b:_pre . "]*"
            " let _rhs = "normal!" . "msgg/" . b:_pre . "]*"
            " exe _rhs
        return b:_pre
    endf

    " 失败
        " func! First_Non_comment_visual()
        "     normal! mh
        "     normal! g^
        "     if Char_at_Cursor() == Char4comment()
        "         normal! w
        "         normal! v'h
        "         " 只有normal mode下mark才可以跳到具体的column, 否则只能跳到行首
        "         vmap <Cmd>
        "     endif
        " endf
        " nno vH <Cmd>call First_Non_comment_visual()<cr>

         " ono H :call First_Non_comment()<cr>:echom 'hi'<cr>

    " 不太相关, 但找不到其他更合适的地方放了:
    " fisrt non-blank (no-empty) character
        " There's no shortcut to match the first non-whitespace character on a line, you have to build the pattern yourself,
        "
        " ^\s*Your_text
        " If you don't want to include the whitespace in your match, you have to use a zero-width assertion, like:
        " \v^\s*\zsYour_text
        " \v(^\s*)@<=Your_text
        "
    " &  replaced with the whole matched pattern
    " nvim -es coco.py -c "%s/^\s*\zsprint/# &/g | w"


" 整行:
      " cc
      " dd
    nno v  <cmd>hi Visual   guibg=#e3e3e0 guifg=#123456<cr>v
    vno v  <cmd>hi Visual   guibg=#e3e3e0 guifg=#123456<cr>v

    "\ vno i  <Esc>i
    "\ 坑死自己  \ viw等 废掉了

    nno vv <cmd>hi Visual   guibg=#e0e9e0 guifg=#123456<cr>V
    vno vv <cmd>hi Visual   guibg=#e0e9e0 guifg=#123456<cr>V

    nno mv <Cmd>call Mark_like_visuaL()<cr>
    vno mv 0<Cmd>call Mark_like_visuaL()<cr><esc>
        fun! Mark_like_visuaL()
            "\ let g:matched_id = matchaddpos(
            "\     \ "In_backticK",
            "\     \ [
            "\         \ line("."),
            "\         "\ \ line("v"),
            "\         "\ \ col("v"),
            "\         "\ \ abs(col(".") - col("v")),
            "\     \ ],
            "\ \ )

            let g:mark_like_visual_ns =  nvim_buf_add_highlight(
                \ 0,
                \ 0,
                \ "In_backticK",
                \ line(".") - 1,
                \ col("."),
                \ -1,
              \ )
        endf

    " 貌似重复造轮子了
            " 用于函数中. normal mode里 直接'm就好
        fun! Mark_line_col() abort
            " 用法:call cursor(g:_n_line, g:_n_col)<cr>
            let g:_n_line = line(".")
            let g:_n_col  =  col(".")
            echom  "line: "  g:_n_line  "col: " . g:_n_col
        endf
        fun! Mark_line_col_Visual() abort
            let g:_v_line = line("v")
            let g:_v_col  =  col("v")
            echom  "line: "  g:_v_line  "col: " . g:_v_col

            endf
            " vno <silent> 'm <Cmd>call cursor(g:_v_line, g:_v_col)<cr>


    nno dd  <cmd>echo "删了:" . getline('.')<CR>dd
    nno x      x:echo "删了:" . string(@")<cr>
    nno D      D:echo "删了:" . string(@")<cr>

    "\ 多余: 都visual mode了, 能看到选的是什么, 就算不小心删掉help_tag, 也没大碍
        "\ vno x   x:echo "✗✗: " . string(@")<cr>
        "\ vno d   x:echo "✗✗: " . string(@")<cr>

    " 想删除前, 先取消conceal, 但不行, 函数没执行完 不生效
        " nno dd <cmd>call Show_then_deL()<CR>
        " function Show_then_deL() abort
        "     set concealcursor= " space
        "     sleep 100m
        "
        "     set concealcursor=n
        "     echo 'hi'
        "
        " endfunction

" 到行末
      " C
      " D
    nno V v$
    nno Y y$

    " cdvy
" 剩最后一个字符，比如引号 括号
    nno cL v$hhc
    nno dL v$hhd
    nno yL v$hhy
        " nno vL v$hh
        " 长时间实践 发现习惯按这个 而非 map后的V


" nno K r<CR><UP>
vno K <esc>r<CR><UP><cr>gv

nno <M-k>   i \ <esc>
"\ nno <M-k>       <Cmd>call Split_and_align()<cr>
                func! Split_and_align()
                    let _indent = indent('.')
                    exe  'normal! i'
                        " normal! i <esc>
                            " 不行, normal!和noremap处理的方法不同
                        " normal! i| " 避免被vim删掉 要加注释
                    exe 'left' _indent
                endf


nno K        <Cmd>call Split_and_align_old()<cr>
                func! Split_and_align_old()
                    let _indent = indent('.')
                    norm! r| " 避免被vim删掉 要加注释
                    exe 'left' _indent
                endf


nno J Ji <Esc>
vno J Ji <Esc>gv

nno <bar>  Ji   <Esc>r\|
    "\ 合并为一行: if xxx | adfasdf | endif


ino jj <esc>

" ino ( (
    " 有个自动补全插件 导致(变成  选中候选，只能这样map
    " 现在不需要了

nor <Up> <C-O>
    " up在vusial mode下好像没功能
vno <Up> :<esc><C-O>
    " vno <Up> <Esc><C-O>  " 不行

nno <Down> <C-I>
    " CTRL-I 等价于<Tab>
vno <Down> :<esc><C-I>


"\ 联想数轴, 左负右正
    nno <c-a>   <c-x>
                "\ 键盘左侧
                "\ 数字减-1
    nno <c-\>   <c-a>
    "\ ctrl 4 和ctrl \一样
                "\ 数字加1

nno X :echo '"X"  留作它用'<cr>
"\ ✗nno X <C-A>✗
    " normal模式：<C-X>  数字减1
    " shift在ctrl上，加1 vs 减一，刚好

nno wb :Buffers<cr>
ino <C-F> <C-X><C-F>
ino <C-K> <C-X><C-K>
"\ 很少用ctrl-k 输入digraph,

    " <c-x> 调自带的omnicomplete
    " 有了coc 应该用不着了
    " 被coc占用了？
    "
    " normal模式：<C-X>  数字减1
    " shift在ctrl上，加1 vs 减一，刚好

"\ nno <M-u> <Cmd>cd ..<CR><Cmd>pwd<CR>
nno <S-Left> <Cmd>cd ..<CR><Cmd>pwd<CR>
" 待用的map
    nno <S-Right> :echom 'hihihihihi'<CR>
    nno <C-Left> :echom 'hihihihihi'<CR>

    cnor <C-Right> expand('<cword>')<cr>
    " 应该一样:
        " cnor <C-Right> expand('<cexpr>')<cr>
        " cnor <C-Right> <c-r><c-w><CR>

    nno <m-s-u> :echom 'hihi'<CR>
    " nno <c-m> :echom 'mmmmm'<CR>  " 它就是enter!


nno gd :vsplit<CR>md<C-]>
                 " mark definition


"\ 跳到文件
    nno   gf              "fyiW<Cmd>call   Goto_filE()<CR>
    nno   <2-LeftMouse>   "fyiW<Cmd>call   Goto_filE()<CR>
    vno   gf              "fy<cmd>call     Goto_filE()<CR>
    vno   <2-LeftMouse>   "fy<cmd>call     Goto_filE()<CR>
        " go bracket
        "\ nno   gb              "fyi{<Cmd>call   Goto_filE()<CR>
        "\ 用gf就行?
    "\ gF跳到行号
    tno   <2-LeftMouse>   <c-\><c-n>gF
    "\ tno   gf              <c-\><c-n>gF
    "\ 不行

    "\ tno   <2-LeftMouse>   <c-\><c-n>"fyiW<Cmd>call   Goto_filE()<CR>


        fun! Goto_filE() abort

        "\ 脱掉引号:
            if @f =~ '\v".*"'
                echom @f
                let @f = @f[1:-2]
                echom @f

            elseif @f =~ "'\v.*'"

            en


            if @f =~ 'png' || @f =~ 'jpg' || @f =~ 'jpeg' || @f =~ 'gif'
            " if @f =~ ".+\.png"  不行
            " if @f =~ '*.png' 不行
                exe 'AsyncRun display -resize 1200x600' @f

            elseif @f =~ 'pdf'
                exe 'AsyncRun zathura' @f

            elseif @f =~ 'sisrfeng'  " 插件
                let my_plug = @f->split('/')[-1]
                let my_plug = my_plug->substitute("'",'','')
                                                " remove a single quote
                exe 'cd ~/PL/' . my_plug
                Files

            elseif @f =~ 'https:' || @f =~ 'http:'
                exe '-tab TW3m' @f

            elseif @f =~ '\\input'
                exe 'normal! vi{"fy'
                if @f =~ '.tex'
                    " ok
                el
                    let @f = @f..'.tex'
                en
                exe '-tab drop' @f

            el
                exe '-tab drop' @f
            en
        endf

    let g:quited_files = []

        nno <Leader>f  <Cmd>call Show_quited_files()<CR>
        nno gp         <Cmd>exe '-tabe' g:quited_files[-1]<cr>
        nno gP         <Cmd>exe '-tabe' g:quited_files[-2]<cr>

        au AG BufEnter  /tmp/my_mru.txt  nmap  <buffer> <cr> gf


            fun! Show_quited_files()
                redir! >  /tmp/my_mru.txt
                    if len(g:quited_files) < 3
                        for old in v:oldfiles[:3]
                            silent echom old
                        endfor
                    en

                    for a_file in g:quited_files
                        silent echom a_file
                    endfor

                redir END

                pedit /tmp/my_mru.txt
                wincmd w
                norm G
            endf

        func!  g:Smart_qq()
            " 2个用处:
                " 1. map ss update然后call本函数
                " 2. <c-space>q等 命令, 不想保存 直接call 本函数
                "
            if  len( filter( range(1, bufnr('$')),  'bufloaded(v:val)' ) )  == 1
          \ ||  bufname() == "[Command Line]"
                " 最后一个buffer,  退出vim
                " 或者commmand line window下, :bdel等命令用不了
                quit!
            elseif  ( &previewwindow == 1 || &buftype == 'quickfix' )
                bwipe!  " 彻底干掉buffer, 避免成为unlisted buffer, 弄脏buffer list
            elseif bufname() =~ 'w3m-\d'
                bdelete
            elseif &buftype == 'terminal'
                hide

            elseif &ft == 'python'
                bdel
                "\ 方便在pudb敲i进入编辑

            "\ ✗elseif &buftype == 'help'✗  \ 改了, 视作常规文件
            "\     wq
            el
                if tabpagenr('$') == 1
                    try
                        edit #
                    catch
                        bnext
                    endtry
                    echo '最后一个buffer了'
                el
                    let f_name   =  expand("#" . bufnr() . ":p")
                    call add( g:quited_files,  f_name )
                    call add( v:oldfiles,  f_name )
                    " v:oldfiles配合skim,现在不需要quited_files?

                    if  f_name  =~ 'dotF/cfg/nvim'
                    \ || f_name =~'/PL/'
                    \ || f_name =~'.tex'

                        hide  " 常用的就hide, not bdelete
                    el
                        bdelete
                    en
                en
            en
        endf


" nno gj :tab drop <cfile><CR>
    " gj留给vscode作为wrapped line的j

" change list的移动(和undo redo类似)
    nno gu g;
    nno gr g,
    " gd只能在本文件内找
    " 先mark个d, 看完再'd

"\ vno gh "hy:-tab help <c-r>h
"\ nno gh  <cmd>silent! helptags ALL<cr>:-tab help <C-R><C-W>
    "\ ~/PL/scriptV/autoload/scriptV.vim 设了:
        " nno  <silent><buffer>   gh

nno <c-b> <C-^>
      " b: buffer
" nno gh :vertical help <C-R><C-W>
        " vim本来用K, K被我map了
    " to be used:  " select mode 是为了讨好MS word患者, 没啥用

            "                             *gV* *v_gV*
            " gV            Avoid the automatic reselection of the Visual area
            "             after a Select mode mapping or menu has finished.
            "             Put this just before the end of the mapping or menu.
            "             At least it should be after any operations on the
            "             selection.
            "
            "                             *gh*
            " gh            Start Select mode, charwise.  This is like "v",
            "             but starts Select mode instead of Visual mode.
            "             Mnemonic: "get highlighted".
            "
            "                             *gH*
            " gH            Start Select mode, linewise.  This is like "V",
            "             but starts Select mode instead of Visual mode.
            "             Mnemonic: "get Highlighted".
            "
            "                             *g_CTRL-H*
            " g CTRL-H      Start Select mode, blockwise.  This is like CTRL-V,
            "             but starts Select mode instead of Visual mode.
            "             Mnemonic: "get Highlighted".

" block模式
    " 记忆：c for block
    no <c-c> <cmd>hi Visual  guibg=#e9e0e0<cr><c-v>

            " vscode里,map <c-c> 或者<c-v>都不生效, 一直是vim本来的功能
            " windows terminal把让<c-v> 无论何时 ,都是paste
    cno <c-c> <c-v>
        " iunmap <c-v>:  加了这行,导致ctrl c不能成为i_ctrl-v
    ino  <c-c> <c-v>

    " 在windows termnial里, 不生效, 因为ctrl-v被强行变成paste
        nno <c-v> "+p
        cno <c-v> <c-r>+
        tno <c-v> <C-\><C-N>"+pa
        ino <c-v> <esc>"+pi

    " autocmd UIEnter *  call Neovide_pastE()
    " fun! Neovide_pastE()
    "     nno <c-v> ""p
    "     cno <c-v> <c-r>"
    "     tno <c-v> <C-\><C-N>""pa
    "     ino <c-v> <esc>""pi
    " endf
    "
        " ino <c-v> <c-r>+
            " 导致缩进很长


    " 加了这两行，ctrl-q还是删除到行首
    " window terminal的问题?
    " 和ctrl b有点关系
        cno <c-q> <c-v>
        ino <c-q> <c-v>

" 交换 ' `
nno ' `
nno ` '

nor <C-F5> <ESC>oimport pudb<ESC>opu.db
ino <C-F5> <ESC>oimport pudb<ESC>opu.db

nno ww <c-w>w

" 滚动
    " c-d本来是翻页，光标会动
    " 有点反直觉, 扔了吧:
            " set scrolloff=0
            " 在上下移动光标时，光标的上方或下方至少会保留显示的行数
    " 光标不再位于原来的文本处
        nno <c-d> 15<c-d>
        nno <c-u> 15<c-u>
    " ctrl-e (记作 extra lines)和ctrl-y是一对, 光标还在原来的文本处
    nno <c-e> 4<c-e>
    nno <c-y> 4<c-y>

" CapsLock 识别不了
" map <CapsLock>[ #
" map <CapsLock>] *


" vk88加a/e, 这些map留作他用
    " nno <C-a> ^
    " ino <C-a> <ESC>I

    " nno <C-e> $
    " ino <C-e> <ESC>A


" Jump to start and end of line using the home row keys
" 增强tab操作, 导致这个会有问题, 考虑换键
"nmap t o<ESC>k
"nmap T O<ESC>j


    nno  <Leader>; :new<cr>:put = Vim_out('')<left><left>
                                            " 单引号不能改为双引号
                      " 缺点: 如果不是按<leader>:, 而是通过历史找出来, 会在当前窗口append
    " 和:Verbose似乎一样, (但人家是在/tmp下建立文件, )
    nno  <Leader>: :Verbose<space>
         set verbosefile=$cache_X/nvim/leo_verbose.log
          " <C-:> 不行
          " cat后`ctrl :`   显示的是<C-[>，和真的<C-[> 以及esc绑定在一起？


" 避免在不想注释时, 多出注释
nno O O<backspace>
" 设了这个会导致k在最后一行卡顿一下 nno ko O

cnor <Up> <c-p>
cnor <Down> <c-n>

" vno i <esc>i
" vno i <esc>i
    " 别用! 导致viw vip vi( 等无法使用

" 替换/replace

    fun! ReplacE(scope, wholeWord, oldStr, ...)
        let newStr =  empty(a:000)
                    \ ? ''
                    \ : a:1
        let @" = @0
            "\ 复原unnamed register,  方便敲<c-g>粘贴

        "\ 智能地使用delimeter:
        if @f !~  '@'
                    let l:At = '@'
        el
            if @f !~ '#'
                    let l:At = '#'
            el
                if @f !~ '/'
                    let l:At = '/'
                else
                    echom '特殊符号太多!搞不定'
                en
            en
        en
        if a:wholeWord == 1
            let l:olds = '\C\<' . a:oldStr . '\>'
        else
            let l:olds =  a:oldStr
        en

        exe   a:scope . 'sub ' . l:At . l:olds .   l:At . newStr . l:At . 'gc'
    endf

    com!  -nargs=+   ReplaceWhole   call ReplacE('%' ,1  , <f-args>)
    com!  -nargs=+   ReplaceEnd     call ReplacE(',$',0  , <f-args>)
                     "\ ReplaceEnd   old_with\ space   new
                     "\ ReplaceEnd   old             \\\\two_backslash
                                                    "(不确定这样对不对)

    "\
    "\ <M-r>           方便粘贴,
        nno <M-r>    <cmd>let @o = @"<cr>
                    \"ryiw
                     \<cmd>let @" = @o<cr>
                    \:ReplaceEnd <c-r>r  <c-r>r

        vno <M-r>    <cmd>let @o = @"<cr>
                    \"ry
                     \<cmd>let @" = @o<cr>
                    \:ReplaceEnd <c-r>r  <c-r>r

        "\
    "\ <F2>
        nno <F2>    <cmd>let @o = @"<cr>"ryiw<cmd>let @" = @o<cr>
                   \:ReplaceWhole <c-r>r  <c-r>r

        vno <F2>    <cmd>let @o = @"<cr>"ry<cmd>let @" = @o<cr>
                 \  :<c-u>ReplaceWhole <c-r>r  <c-r>r



    " find and replace in multi files
        com!  -nargs=+   Fr  call Find_replacE(<f-args>)
                         "\ Fr     my_suffix  student\ model  \\\\mS
                                "\ ¿student model¿ 批量替换为¿\mS¿

            fun! Find_replacE(extra_suffixS, oldStr, ...)   abort
                let bk_wildignore = &wildignore
                set wildignore+=*leo_tools/coc/extensions*
                set wildignore+=*coc/extension*

                if len(a:0) >= 2
                    exe   'cd ' a:2
                    echom 'cd到了' .  getcwd() . '  避免被超大目录搞崩vim. 再敲一遍Fr吧'
                    "\ wfwf
                    return
                el
                    if getcwd() =~ 'cfg/nvim'
                        let where = $nV
                    elseif getcwd() =~ 'pool1D'
                        let where = '/home/wf/d/s_kaggle/input/upload-wf/pool1D'
                    el
                        let where =  systemlist( 'git rev-parse --show-toplevel' )[0]
                    en
                en

                let newStr =  empty(a:000)
                            \ ? ''
                            \ : a:1

                "\ todo:根据后缀名找不同类型的文件, 待完善
                let l:suffixS = 'md,markdown'
                          "\ 不论当前文件是什么类型, 都要搜它们
                          "\ a:extra_suffixS: 常用 但又不是必搜的 默认放在Fr命令后面, 方便在cmd编辑

                if &filetype == 'python'
                    let l:suffixS = ',py,sh,zsh'

                elseif &ft == 'vim' || &ft == 'lua'
                    let l:suffixS = ',vim,lua,py,sh,zsh'

                    let l:suffixS = ',vim,lua,py,sh,zsh'

                elseif &ft == 'tex'
                    let l:suffixS = ',tex,bib,bbl'

                elseif &ft == 'text'
                    let l:suffixS = ',rst'
                else
                    let l:suffixS = ',yml,yaml,conf'
                en

                let l:suffixS .= ',' . a:extra_suffixS

                echo 'for每种suffix, 先cd到:   ' . where
                for suf in  split(l:suffixS, ',')
                    exe 'cd' where
                    "\ 之前进了这个循环后 就没改过cwd, 导致在某些subdir下grep

                    let l:oldWord = '\C\<' . a:oldStr . '\>'
                    "\ case sensitive且必须是整个word

                    try
                        exe   'vimgrep'  '@' . l:oldWord . '@gj' '**/*.' . suf
                        "\ exe   '10 vimgrep'  '@' . a:oldStr . '@gj' '**/*.' . suf
                                             "\ @用于分隔 (delimeter), 不用#因为它有时会作为string
                               "\ 10: 限制 匹配到的str为10个, 避免进了乱七八糟的目录
                        exe   '-tab cfdo % sub @' . l:oldWord . '@' . newStr . '@gc  | update '
                    catch
                    endtry
                endfor

                let wildignore  = bk_wildignore
            endf

        " PL 'brooth/far.vim'
            " 之前不能用, 貌似因为设了: set debug=throw
            " move to PL.vim if needed.
            "     " :help far-glob 和gitignore有点出入
            "     set lazyredraw            " improve scrolling performance when navigating through large results
            "     " set regexpengine=1
            "       " 1: use old regexp engine
            "       " 作者建议用old的
            "       "
            "   " 这样设,可以让 没用far时 auto set regexpengine??
            "     let g:far#mode_open= { "regex": 1, "case_sensitive": 0, "word": 0, "substitute": 1 }
            "                         " 默认就是这样
            "
            "     " let g:far#source = 'rg'  " https://github.com/brooth/far.vim/issues/121
            "                         " rg和nvim搞在一起, 比'rg'这个选项更快? 好像有点bug
            "                         " string记得加引号.  🎹set 某option=strgin🎹  才不用加
            "     " let g:far#source="ag"
            "     let g:far#source="rgnvim"
            "
            "     " let g:far#ignore_files = [ "/home/wf/dotF/cfg/rg/far_ignore.yml" ]
            "         " A list. Files of rules to ignore file during matching.
            "
            "     " far.vim find
            "         " nno <silent> <Find-Shortcut>  :Farf<cr>
            "         " vno <silent> <Find-Shortcut>  :Farf<cr>
            "
            "     "  replace
            "     nno <Leader>R  :Farr<cr>
            "     vno <Leader>R  :Farr<cr>
            "             " 进入replace window后, 敲s表示确认substitude
            "             " 为啥启动nvim后, 要敲Runtime  这2行才生效?
            "                 " 改为<Leader>A, 也一样
            "             "
            "               " 不行:
            "                 " exe 'nno <Leader>R  :Farr<cr>'
            "                 " exe 'vno <Leader>R  :Farr<cr>'
            "
            "     let g:far#enable_undo=0
            "         " 别用undo 会莫名其妙地多生成python文件,
            "         " https://github.com/brooth/far.vim/issues/30

        "\ map
                         " mI:  mark I 方便回来
            nno <F50>    mI<cmd>let @o = @"<cr>"ryiw<cmd>let @" = @o<cr>:Fr     txt     <c-r>r  <c-r>r
            nno <M-F2>   mI<cmd>let @o = @"<cr>"ryiw<cmd>let @" = @o<cr>:Fr     txt     <c-r>r  <c-r>r
                            "\ r: replace
                            "\ 别抹掉register里复制的东西

            vno <F50>    mIy:<c-u>Fr  txt     <c-r>"  <c-r>"
            vno <M-F2>   mIy:<c-u>Fr  txt     <c-r>"  <c-r>"

            "\ nno ,s    :exec  '.,$ sub' .. strtrans("\n") .. strtrans("\n") .. strtrans("\n")
            " todo: nno <F2>中换用exec?


" python
    " nno cb O'''<Esc>Go'''<Esc>
    " ino cb '''<Esc>Go'''<Esc><C-o>i

    " au AG BufNewFile,BufRead *.py ino # X<c-h>#
        " python文件中输入新行时 #号注释不切回行首

nno _p :call funcS#PrinT_N()<CR>
vno _p :call funcS#PrinT_V()<CR>

" au AG filetype cpp nno <C-c> :w <bar> !clear && g++ -std=gnu++14 -O2 % -o %:p:h/%:t:r.exe && ./%:r.exe<CR>
    " <bar> : 表示 '|' ,  to separate commands, cannot use it directly in a mapping, since it would be seen as marking the end of the mapping.
    " 百分号代表当前文件
    " bash 的  &&  是前面的命令成功了，继续执行后面的

" saving,
    ino <c-s>   <esc><Cmd>update<CR><Cmd>Runtime<CR>zv
    vno <c-s>        <Cmd>update<CR><Cmd>Runtime<CR>zv
    nno <c-s>        <Cmd>update<CR><Cmd>Runtime<CR>zv
    "\ nno <c-s>        <Cmd>update<CR><Cmd>call ReloaD()<CR><Cmd>filetype detect<CR>zv
"\ 调试vimscript:
    nno <Leader>s     <Cmd>write<CR>
                     \<Cmd>messages clear<cr>
                     \<Cmd>source %<CR>
                     \<Cmd>echom '跑完了'<cr>
                     \<Cmd>Messages<cr>
    "\ nno <Leader>s     <Cmd>update<CR><Cmd>source %<CR>
                           "\ update在遇到未write过的buffer时, 不干活?

    au AG BufEnter *.Vnote  nno <buffer>   <c-s> <Cmd>update<CR>
                        \ | vno <buffer>   <c-s> <Cmd>update<CR>
                        \ | ino <buffer>   <c-s> <esc><Cmd>update<CR>

    " 应该不必了, (在scriptV里面改了):
    " au AG BufEnter ~/.local/share/nvim/plugged/*/doc/*.txt
    "             \ nno  <buffer> <c-s>  <Cmd>update<CR> |
    "             \ ino <buffer>  <C-S>   <esc><Cmd>update<CR> |
    "             \ vno <buffer>  <C-S>       <Cmd>update<CR>
" vim-plug
    nno <silent> <Leader>pw      <Cmd>update<CR>
                                \<Cmd>call ReloaD()<CR>
                                 \<Cmd>PlugInstall<CR>
                                "\ 网络不好时 无法执行完,  导致后续报错
                                        "\ <Cmd>PlugUpdate<cr>

                 " want Plug
    nno <silent> <Leader>pu :update<CR>:PlugUpdate<Cr>

                                    "\ <Leader>pw 现在有点问题, (先报错 再正常安装)
                                     "\ 这也一样:
                                         "\ \<Cmd>PlugInstall --sync <Bar> q<CR>
                                     "\ cnoreabbrev也一样:
                                        "\ \ pw  : 'update \| call ReloaD() \| PlugClean \| PlugInstall'  ,
                                    "\ 单独敲PlugInstall   就没问题


    "\ nno <silent> <Leader>pw      <Cmd>update<CR>
    "\                             \<Cmd>PlugClean<CR>
    "\                              \<Cmd>PlugInstall<CR>

                                        "\

" 之前用过的mswin.vim里 有用的内容都在这里
    ino <C-Z> <C-O>u
        " CTRL-Z is Undo

    " ino <C-R> <C-O>u
    "<C-R>:    Insert the contents of a register

    " CTRL-Y is Redo (although not repeat)
    " nno <C-Y> <C-R>  <c-y>还是用于scroll吧
    " ino <C-Y> <C-O><C-R>
    ino <C-Y> <Esc><C-R>a

" fold
" m: middle
" 保护小指, 逗号刚好在中指的位置  go to middle

nno <F1> <Cmd>call funcS#RuN()<CR>

if hostname() == 'redmi14-leo'
    nno <C-Right>  viW"wy<esc><Cmd>call To_term()<cr>w3m '<C-\><C-N>"wp<Esc>a'<cr>
    vno <C-Right>     "wy<esc><Cmd>call To_term()<cr>w3m '<C-\><C-N>"wp<Esc>a'<cr>
el
    nno <C-Right>  viW"+y:TW3m <C-r>+<cr>
    vno <C-Right>     "+y:TW3m <C-r>+<cr>
en

