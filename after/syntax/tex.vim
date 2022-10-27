"\ 有些变量 要在这个文件设:
    "\ /home/wf/dotF/cfg/nvim/tex插件cfg.vim

source   <sfile>:h/complex_coneal_tex.vim

"\ 不再需要了, 有quickfix:
"\ au AG BufRead  *mk_out.log  normal! G?\v:\d+:<cr>
au AG BufRead  *VimtexMessageLog  norm G


"\ toc
    "\ nno <buffer> <silent>   go   <Cmd>update<cr>
    "\                             \<Cmd>VimtexTocToggle<cr>
    "\                             \<c-w>w

    autocmd BufRead *  if exists('w:quickfix_title')
                        \ &&  w:quickfix_title =~ 'LaTeX logfile'
                        \ | resize -999 | resize +2
                        \ | en

setl spell
let b:ale_enabled = 0
setl textwidth=120
setl isk+=-
setl isk+=.
        " 小数点


" 下面的, 之前放在 /home/wf/dotF/cfg/nvim/after/ftplugin/tex_ft.vim
" 还是统一放一个文件好管理

"\ map
    nno   <buffer>    go    <cmd>VimtexTocToggle<cr><cmd>wincmd w<cr>jjj
    nno   <buffer>    si    <Cmd>call funcS#Short_iT()<cr>
    nmap  <buffer>    t.    tb<esc>bh
                                \<cmd>let _keys = &indentkeys<cr>
                                \<cmd>set indentkeys=<cr>
                                \<cmd>norm! i<bslash>emph<cr>
                                \<cmd>let &indentkeys = _keys<cr>

                                " 在map里改indentkeys不生效?
    " recursive map容易出bug?
        " 但nno不行
        " nno <buffer>  t. <cmd>norm 'tb'<cr>norm 'i\emph'<cr>


    " 降重: decrease same..
    "\ 没用上, 可以放进同义词插件里
        nno  <buffer>  <leader>Sa    <cmd>call Same_meaninG()<cr>
        let g:old_new_list = {
            \ 'use'                                          : 'utilize'                                     ,
            \ 'To our knowledge, no prior work has'          : 'From the our best knowledge'                 ,
            \ 'used'                                         : 'utilized'                                    ,
            \ 'Please note that'                             : 'It should be figured out that'               ,
            \ 'we show that'                                 : 'from our experiment, we conclude that'       ,
            \ 'MLP'                                          : 'multilayer perceptron'                       ,
            "\ \ 'as suggested in'                              : 'following ??'                                ,
            \ 'learning signal'                              : 'supervision'                                 ,
            \ 'in other words'                               : 'put differently'                             ,
            \ 'it is important to emphasise the fact that'   : 'Importantly'                                 ,
            \ 'as a further extension, the most recent work' : 'More recently'                               ,
            \ 'not easy'                                     : 'usually difficult'                           ,
            \ 'without any bells and whistles'               : 'with few additional complex tricks or hacks' ,
            \ 'Nevertheless'                                 : 'however'                                     ,
            \ 'moreover'                                     : "what's more"                                 ,
            \ 'rather than' : 'instead of',
            \ 'difficult'   : 'formidable',
            \ 'as a result' : 'consiquently',
            \ 'orthogonal'  : 'independent'
            \ }

        "
            " a.k.a.
            "  To overcome these difficulties
            "  among other changes.
            " Furthermore,
            " It is worth noting that
            " significant   obvious
            " as since because   as the result of
            " elimination
            " Additionally
            " Despite the simplicity
            " without any bells and whistles
            " Specifically,
            " we observe that
            " by means of
            " assume that
            " reduce the occurrence of      decrease/lessen
            " Given that
            " In particular

        fun! g:Same_meaninG() abort
            for [old,new] in items(g:old_new_list)
                echom '% subs #\v<'..old..'>#'..new..'#gec'
                exe '% subs #\v<'..old..'>#'..new..'#gec'
            endfor
        endf

" 来自b_map.vim  \

    "\ au My_syn BufEnter *.aux,*.bib,*.cls,*.dtx  setl ft=tex | setl syntax=tex

                                   " ol: outline
    nno  <buffer> <silent>  <Space>ol <cmd>call Tex_outlinE()<cr>
        fun! Tex_outlinE()
            call funcS#Out_linE('\v\\(sub)?section\{.{-}}$')
        endf

    "\ 小v: 只compile当前行
    "\ vno <buffer> <Leader>v       <Cmd>update<cr>:VimtexCompileSelected<cr>

    vno <buffer> <Leader>V      <Cmd>call vimtex#misc#reload()<cr>
                               \<Cmd>update<cr>
                               \:VimtexCompileSelected<cr>

    nno <buffer> <Leader>V      <Cmd>call vimtex#misc#reload()<cr>
                               \<Cmd>update<cr>
                               \:1,$ VimtexCompileSelected<cr>


    "\ bug:
    "\ nno <buffer> <Leader>v       <Cmd>VimtexView<cr>
    "\ nno <buffer> <Leader>V  <Cmd>call View_anywaY()<cr>

    nno <buffer>     tl          <Cmd>update<cr>
                                \<Cmd>!rm -rf $HOME/d/tT/wf_tex/out扩展<cr>
                                 \<Cmd>call vimtex#misc#reload()<cr>
                                 "\ \<Cmd>let g:vimtex_quickfix_autojump = 0<cr>
                                 "\ auto jump 没啥用, 老是跳到main file
                                 \<cmd>cexpr []<cr>
                                 \<Cmd>VimtexCompileSS<cr>


    nno <buffer> <Leader>ll      <Cmd>VimtexLog<cr>G
    nno <buffer> <Leader>ls      <cmd>VimtexCompile<cr><Cmd>VimtexStatus<cr>

    nno <buffer> <Leader>lg      <Cmd>VimtexCompile<cr>
                                "\ \<Cmd>let g:vimtex_quickfix_autojump = 0<cr>


    nno <buffer> <Leader>lc      <Cmd>!rm -rf $HOME/d/tT/wf_tex/out扩展<cr>
    nno <buffer> <Leader>li      <Cmd>VimtexInfo<cr>
    nno <buffer> <Leader>lv      <Cmd>VimtexView<cr>
                                    "\ 这个只是用于forward search


    "\ nno <buffer> <Leader>w      <Cmd>VimtexErrors<cr><c-w>wG
                         "\ wrong


    "\ nno <buffer>         wp      <Cmd>AsyncRun zathura pdf.pdf<cr> 不好
                                            "如果不退出previewer就切回vim, 一直报错
    "\ nno <buffer>         wp      <Cmd>AsyncRun zathura pdf.pdf<cr>

    nno <buffer>         wp    <Cmd>call View_pdF()<cr>
        fun! View_pdF()
            "\ 没人家vimtex的智能
            if  !filereadable( expand('%:t:r') . ".pdf" )
            && !filereadable( '../PasS.pdf' )
                update
                VimtexCompileSS
            en
            "\ 等compile结束
            let tried = 0
            while tried < 20
                if filereadable( expand('%:t:r') . ".pdf" )
                    let c_m_d = 'cd ' . fnameescape(expand('%:p:h'))
                    let c_m_d .= '; zathura ' .  expand('%:t:r') . ".pdf \<cr>"
                    call chansend(g:term_jobS[-1], c_m_d)
                    break
                el
                    let tried += 1
                en
            endwhile
        endf


" highlight, 从/home/wf/dotF/cfg/nvim/colors/leo_light.vim 挪过来
    " 括号会被treesitter的rainbowcol1 到rangocol7覆盖, 把它在tex里禁了
    fun! s:Tex_hi(group, fg, bg, gui)
        if a:group =~ '^tex'
            echoerr '传参时别加tex, 函数内统一加'
        en

        let l:cmd = 'highlight tex' . a:group
        if a:fg != ''
            let l:cmd .= ' guifg=' . a:fg
        en
        if a:bg != ''
            let l:cmd .= ' guibg=' . a:bg
        en
        if a:gui != ''
            let l:cmd .= ' gui=' . a:gui
        en
        exe     l:cmd
    endf

    " def color
    " 去vscode调色:
        let _frost1 = '#8FBCBB'
        let _frost4 = '#5E81AC'

        let _dawn2  = '#E2A478'
        let _dawn4  = '#559720'
        let _dawn5  = '#A093C7'

        let BlacK  = '#123456'
        let GreeN    = '#50804a'

    " basic groups
        call s:Tex_hi('Cmd'     , BlacK , 'none' , '')
        " call s:Tex_hi('Cmd'     , '#fdf6e3' , 'none' , '')
        call s:Tex_hi('Arg'     , BlacK , '' , '')
        call s:Tex_hi('Opt'     , BlacK , '' , '')
        "\ call s:Tex_hi('Comment' , 'gray'  , '' , '')

    " sectioning
        call s:Tex_hi('CmdPart',      BlacK , '' , '')
        call s:Tex_hi('PartArgTitle', BlacK , '' , '')
        call s:Tex_hi('CmdTitle',     BlacK , '' , '')
        call s:Tex_hi('CmdAuthor',    BlacK , '' , '')
        call s:Tex_hi('TitleArg',     BlacK , '' , 'bold')
        call s:Tex_hi('AuthorArg',    BlacK , '' , '')
        call s:Tex_hi('FootnoteArg',  BlacK , '' , 'italic')

    " environments
        call s:Tex_hi('CmdEnv'     , BlacK   , '' , '')
        call s:Tex_hi('EnvArgName' , _dawn2 , '' , '')
        call s:Tex_hi('EnvOpt'     , BlacK   , '' , '')

    " math
        call s:Tex_hi('MathZoneX'      , 'none' , 'none' , 'none')
        "\ call s:Tex_hi('MathZoneX'      , GreeN , 'none' , 'bold')
        call s:Tex_hi('MathZoneXX'     , GreeN , '' , '')
        call s:Tex_hi('MathZone'       , GreeN , '' , '')
        call s:Tex_hi('MathZoneEnv'       , GreeN , '' , '')

        call s:Tex_hi('MathCmd'        , GreeN , '' , '')

        call s:Tex_hi('MathDelim'      , BlacK   , '' , '')
        call s:Tex_hi('MathDelimZone'  , BlacK   , '' , '')
        call s:Tex_hi('MathCmdEnv'     , BlacK   , '' , '')
        call s:Tex_hi('MathEnvArgName' , BlacK   , '' , '')
        " hi! link texCmdMathText texCmdMathEnv
        " hi! link texCmdMathEnv  texMathCmdEnv

    " references
        call s:Tex_hi('CmdRef' , BlacK   , '' , '')
        call s:Tex_hi('RefArg' , 'none'    , '' , '')
        call s:Tex_hi('RefOpt' , _dawn5 , '' , '')
        call s:Tex_hi('UrlArg' , _frost4  , '' , 'underline')
        " hi! link texCmdCRef     texCmdRef
        " hi! link texHrefArgLink texUrlArg
        " hi! link texHrefArgText texOpt

    " symbols
        call s:Tex_hi('Symbol',      _dawn5, '', '')
        " call s:Tex_hi('SpecialChar', __none,  '', '')
        " hi! link texDelim       texSymbol
        " hi! link texTabularChar texSymbol

    " files
        call s:Tex_hi('FileArg', _dawn5, '', '')
        call s:Tex_hi('FileOpt', BlacK,  '', '')

    " bib
        call s:Tex_hi('bibType',     _dawn2, '', '')
        call s:Tex_hi('bibKey',      _dawn4, '', '')
        call s:Tex_hi('bibEntryKw',  _frost1,  '', '')
        call s:Tex_hi('bibVariable', BlacK, '', '')

    " 其他
        call s:Tex_hi('MathStyleItal' , BlacK   , '' , 'bold')
        call s:Tex_hi('StyleItal' , BlacK   , '' , 'bold')
        call s:Tex_hi('ItalStyle' , BlacK   , '' , 'bold')
                    " 斜体看不清



"\ vimtex无法封印的, 才在这里处理

fun! Tex_xX(v_regex, cchar) abort
    exe 'syn match xX_Tex_'
        \ '"\v' . a:v_regex . '"'
         \ 'conceal'
         \ 'containedin=ALL'
          \ !empty(a:cchar)
            \ ? 'cchar=' .  a:cchar
            \ :  ' '

    "\ 如果没有containedin=ALL, {xxxx}的大括号无法封印

    " echom 'syn match texHidE'  ..............
endf
"\ now call function Tex_xX
    let tex_byE = {
               \ '(\\)@!\{\ze\p'    : ''  ,
               \  '(\\)@!}\ze\p'    : ''  ,
               \ '\\\{'            : '{' ,
              \  '\\}'            : '}' ,
              \  '\\\zelog'         : '' ,
              \  '\\\zemax'         : ''  ,
              \  '\\\zeFor'         : ''  ,
              \  '\\\zeourmethod'   : ''  ,
              \  '\\\zearg'         : ''  ,
              \  '\\mysection'      : ''  ,
              \  '\\Tilde'      : '~'  ,
              \  '\includegraphics' : '图'  ,
              \}
               "\ \ '\{\ze\p'                 : ''  ,
               "\ \  '}\ze\p'                 : ''  ,
                    "\ 它们导致中括号藏起来了, 留下backslash $X = \{X_L,X_U\}$
               " 现在用¿(\\)@!¿排除掉¿\¿
               "\ 即排除¿\{¿
                 "\     ¿\}¿

    "\ syn match tex_com_delI  '\v^\s*\zs\%\s' 画蛇添足
    syn match tex_com_delI  '% '   contained conceal containedin=texComment
    hi link tex_com_delI   Vim_com_delI




    silent let tex_byE ->extend({
              \  '^\% {1,3}!TeX' : '𐌼' ,
              \  '\\footnote'    : '𝔫' ,
              \  '\\frac'        : '÷' ,
              \  '\s*\zsif>'     : '▸' ,
              \  '\s*\zsIf>'     : '▸' ,
              \  '\\Return>'     : '↵' ,
              \  '\%$'           : ''  ,
              \  '\\mainmatter'  : '!'  ,
            \ })

              "\ \  '\\frac\ze\{'                  : '÷' ,
              "\ \  '\\frac\zs\{'                  : ' ' ,

    silent let tex_byE ->extend({
              \  '\\vspace\{-?.{-}}'       : ''  ,
               \ '<Fig%(ure|\.)\~\\ref'     : ''  ,
               \ '<Section\.?\~\\ref'       : ''  ,
              \  '<et al\.?'                : ''  ,
              \  '<e\.g\.,?'                : '˘'  ,
              \  '<etc\.?'                   : ''  ,
              \  '<i\.e\.,?'                : '˘'  ,
              \  '\\@!i\.e\.,?'                : '˘'  ,
              "\ \  "[^\\]\zse\.g\.,?"                : '˘'  ,
              \ '\~'               :  ' ' ,
              \ })


    "\ silent let tex_byE ->extend({
              "\ \  '\\vspace\{-?.{-}}'       : ''  ,
              "\  \
              "\  \ '<Fig%(ure|\.)\~\\ref'     : ''  ,
              "\  \ '<Section\.?\~\\ref'       : ''  ,
              "\  \
              "\  \ '<Specifically, '          : ''  ,
              "\  \ '<obviously, '             : ''  ,
              "\  \ '<it is worth noting that' : ' ' ,
              "\ \  '<et al\.?'                : ''  ,
              "\ \  '<e\.g\.,?'                : '˘'  ,
              "\ \  '<etc\.?'                   : ''  ,
              "\ \  '<i\.e\.,?'                : '˘'  ,
              "\ \  '\\@!i\.e\.,?'                : '˘'  ,
              "\ "\ \  "[^\\]\zse\.g\.,?"                : '˘'  ,
              "\ "\ 避免和custom_cmd啥的抢生意
              "\ \ '<For example,'    :  '˘' ,
              "\ \ '<For instance'    :  '˘' ,
              "\ \ '<We argue that '  :  ' ' ,
              "\ \
              "\ \ '\~'               :  ' ' ,
              "\ \ })

               "\ \  '^\% {1,3}!TeX'           : '𐌼' ,
                                            "\  𐌼 : magic各种语言的magic command/comment统一用它
                "\ \  '\\\zeie,'                 : ''  ,
                    "\ \ie 变 ie
                "\ \  '\\\zeg'                 : ''  ,
                    "\ 不行
                "\ \  '\\\a+\ze\{\p{-}}'        : ''  ,
                "\ \  '\\\a+\{\p{-}}'        : ''  ,
                    "\ 封印所有命令
                    "\ 不好, 太粗暴, 各级目录显示效果变成一样
                "\ \  '\~\\etal'                : ''  ,
                "\ \  '\~\ze\\cite'          : ' ' ,
                "\ \  '\\~\\\\ref\\{.{-}}'   : ''  ,
                " \~ :
                    "\ tilde: non-breaking space between the left and right tex


    let EnV = '%(align%(ed)?|equation|array|table|figure|centering|center)\*?'
    "\ let EnV = '%(align%(ed)?|equation|itemize|array|table|figure|centering|center)\*?'

    silent let tex_byE ->extend({
                                \ '\\begin\{' . EnV . '}(\[.+])?'  :  '' ,
                                \ '\\end\{'   . EnV . '}'  :  '' ,
                              \ })
                                "\ regex要用单引号!

    "\ let g:vimtex_syntax_custom_cmds = [ ] 里加了\left 导致\left [ 被封印
    "\ group为 Mathwf_LeftOpt   Mathwf_LeftArg  等
    "\ 所以加上:
    silent let tex_byE ->extend({
                                \  '\\left ?\['       : '['  ,
                                \  '\\right]'       : ']'  ,
                              \ })


    for [r,c] in items(tex_byE)
        syn case ignore
        call Tex_xX(r, c)
    endfor

"\ 应该被 bye_tex 取代了
" leo' s syntax
    syn match texConceaL    "\V{equation}"  conceal containedin=texMathZoneEnv,texEnvMArgName
    syn match texSpecial_xX "\\_"  conceal cchar=_ containedin=texMathGroup
    syn match texSOTA       "\vstate-of-the-art( methods)?"  conceal cchar=☆
    syn match texHidE       "\vet al\.?"     conceal
    syn match texHidE       "&"     conceal



"\ au User AsyncRunStop copen | wincmd p
                    "\ \| source /home/wf/dotF/cfg/nvim/conceal_fast.vim
                    "\ \| % sub #Possible spelling mistake found\.#- #ge


"\ au AG QuickFixCmdPost  make  copen  \ 被代替了?? :

"\ au   User AsyncRunPre  echom 'async PRE'

"\ au   User AsyncRunStart  echom 'async start'

"\ au   User AsyncRunStop  echom 'async stop'
            "\ \| copen
            "\ \| setl modifiable
            "\ \| source /home/wf/dotF/cfg/nvim/conceal_fast.vim
            "\ \| % sub #Possible spelling mistake found\.#- #ge


nno <buffer>    <Leader>fl      <Cmd>call Lopen_textidotE()<cr>
    fun! Lopen_textidotE()
        update
        setl spelllang=en_us
        compiler textidote
        echo '稍等, 在跑textidote'
        AsyncRun! -strip  -program=make -post=silent\ call\ Texti_posT()
    endf

    fun Texti_posT()
        copen
        source /home/wf/dotF/cfg/nvim/conceal_fast.vim
        % sub #.*Unpaired symbol: '”' seems to be miss.*$##ge
        % sub #.*Unpaired symbol: '"' seems to be miss.*$##ge
        % sub #Possible spelling mistake found\.#- #ge
        norm! gg
        echom 'texti完了'
    endf



nno <buffer>    <Leader>fj      <Cmd>call Copen_python_checK()<cr>
    fun! Copen_python_checK()
        update
        setl spelllang=en_us
        compiler vlty
        echo '在跑YaLafi'
        AsyncRun! -strip  -program=make -post=silent\ call\ Yalafi_posT()
    endf
        "\ Possible spelling mistake found.

    fun Yalafi_posT()
        copen
        source /home/wf/dotF/cfg/nvim/conceal_fast.vim

        % sub #.*Unpaired symbol: '”' seems to be miss.*$##ge
        % sub #.*Unpaired symbol: '"' seems to be miss.*$##ge
        % sub #Possible spelling mistake found\.#- #ge

        norm! gg
        echom 'YaLafi完了=============='
    endf




    "\ com!  -bang -nargs=* -complete=file   Lmake
    "\             \ AsyncRun<bang> -strip  -auto=lmake -program=make
    "\               "\ after this,  copen works, lopen does not work
    "\               "\ 不涉及:lmake,  把&makeprg 传给shell, 新开process去跑?
"\ echom '来啦, /home/wf/dotF/cfg/nvim/after/syntax/tex.vim'

