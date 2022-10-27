"\ todo:
    "\ runtime/lua/vim/treesitter/highlighter.lua
        "\ conceal = metadata.conceal

    "\ 例子
    "\ ~/PL/org_mode_lua/lua/orgmode/colors/markup_highlighter.lua
        "\ vim.api.nvim_buf_set_extmark(bufnr,
        "\                              namespace,
        "\                              range.from.start.line,
        "\                              range.from.start.character,
        "\                              {  end_col = range.from['end'].character,
        "\                                 ephemeral = true,
        "\                                 conceal = ''
        "\                              }
        "\                             )

syntax on
au AG BufEnter * filetype detect

set lazyredraw
set conceallevel=2 concealcursor=n
set synmaxcol=260
set redrawtime=800
let g:vimsyn_maxlines = 180  " 默认60
let g:vimsyn_minlines = 100

au My_syn BufLeave * call clearmatches()
" ms
" set synmaxcol=140


" helper
    nno <Leader>ht   viw<cmd>TSCaptureUnderCursor<cr>
    "\ nno <Leader>ht   viw<cmd>TSCaptureUnderCursor<cr><esc>
    vno <Leader>ht      <cmd>TSCaptureUnderCursor<cr>

    nno <Leader>o  <cmd>call Syn_stack_herE()<cr>
    vno <Leader>o  <cmd>call Syn_stack_herE()<cr>

        func! Syn_stack_herE()
            let _syntax_ = &syntax
            let g_name = []
            for id in synstack( line("."), col(".") )
                call add( g_name, synIDattr( id, "name" ) )
            endfor

            let depth = len(g_name)
            if  depth == 0
                echo '不属于任何syntax group'
            el
                "\ let ver_file     = &verbosefile
                let g:f_tmp      = '/tmp/preview即用即弃' . '.vim'
                "\ let g:f_tmp      = tempname() . '.vim'
                                    "\ 会写到上一次的tempname(), set option要在函数结束才生效?
                                    "\ 用下面的代替let &也不行:
                                    "\ exe 'set verbosefile=' . g:f_tmp

                "\ let &verbosefile = g:f_tmp
                silent! call writefile([''] , g:f_tmp,'')  " 清空旧文件

                "\ 还是不能auto wrap:
                    setl formatoptions+=t
                    setl textwidth=90  " 150快到尽头了


                "\ 放syn list前, 导致显示不全:
                    "\ exe 'pedit' g:f_tmp . '|wincmd P'


                for i in range(depth)
                    let _name = remove(g_name, -1)
                    exe 'redir >>' g:f_tmp
                        silent exe 'syn list' _name  ' |  echo "  "'
                    redir END
                endfor

                exe 'pedit!' g:f_tmp  '| wincmd P | norm gg'
                "\ ✗好处是随时丢弃, 不会提醒保存, 不像这个:✗
                "\ ✗exe 'split' g:f_tmp✗
                "\ 随时丢弃 要靠这行? :
                sil! setl buftype=nowrite

                let g:tmp_match_id =  matchadd('Conceal', _syntax_ . '\ze\u', 99)
                sil! % sub # \zsxxx\ze #   #ge

                "\ /变为#, 方便conceal, 但可能buggy
                sil! % sub @\v(\=|\s)\zs\/\ze\S@#@ge
                sil! % sub @\S\zs\/\ze\s@#@ge
                sil! % sub @\S\zs\/\ze\s@#@ge
                sil! % sub @links to @\r    链到@ge

                norm! ggdd

                let in_dent = ' ' ->repeat(4)
                "\ let in_dent = ' ' ->repeat( col('.') - 1 )
                mark t
                sil! exe  "'t,$ sub#" . '[^ \\]\zs \+\ze\S' . '#' . ' \r' . in_dent . '\\ '  . '#ge'

                norm! `t
                sil! norm  zL

                "\ call Comma_dowN()
            en
        endf
            "\ au AG   BufLeave /tmp/preview即用即弃.vim    call matchdelete(g:tmp_match_id, 如何上一个)

            "\ 避免逗号后一大串, (失败...)
                "\ au AG   BufEnter /tmp/preview即用即弃.vim    call Beautify_tmp_filE()
                "\     fun! Beautify_tmp_filE()
                "\         sil! exe "norm! /\\v\contains\zs\=\ze(\\w|\\@)+,(\\w|\\@)\<cr>h"
                "\         let in_dent = ' ' ->repeat( col('.') - 8 )   "\ contains用一个符号显示了
                "\         sil! exe  '.,$ sub#' . '\v(\w|\@|\.\*)\zs,\ze(\w|\@)' . '#' . ',\r' . in_dent . '\\'  . '#ge'
                "\     endf

"\ nno gh
    " 改成buffer specific的吧,
    " vim的详见:
        "\ func! scriptV#synnames(...) abort

" hide
    au My_syn Syntax * hi HidE      guifg=#fdf6e3   guibg=none gui=none
    nno  ,h "hyiw<esc>:let a_id = matchadd('HidE', @h, 99, -1)<cr>
    vno  ,h "hy<esc>:  let a_id = matchadd('HidE', @h, 99, -1)<cr>
                                                        " 非Conceal这个group,
                                                        " 加了  {'conceal':'☾'}
                                                        " 也没用
" c: conceal
" conceal 太长, 以后用xX代替? x像封条

    nno  ,r  <Cmd>call matchdelete(g:a_id)<cr>
    nno  ,R  <Cmd>call clearmatches()<cr>

    nno  ,c "cyiw<esc>:let g:a_id = matchadd('Conceal', @c, 300, -1, {'conceal':'☾'})<cr>

    " e和r紧挨着
    " 强行记忆: e for :  expression?
    vno  ,E  <Cmd>call Concel_thiS("")<cr>
    vno  ,e  <Cmd>call Concel_thiS()<cr>
        fun! Concel_thiS(c_char='')
            norm "cy
            let @c = @c ->substitute(
                              \ '\.',
                              \ '\\.',
                               \ '',
                              \ )

            "\ 不行
            "\ let @c = @c ->substitute(
            "\                   \ '\',
            "\                   \ '\\',
            "\                    \ '',
            "\                   \ )
           echom  @c
           let g:a_id = matchadd('Conceal', @c, 100, -1, {'conceal':a:c_char})
        endf
    vno  ,E  <Cmd>call Concel_thiS("")<cr>
    " vno  ,c "cy<esc>:let a_id = matchadd('Conceal', @c, 100, -1, {'conceal':'☾'})<cr>



" matchadd比syn match 慢?
" todo:

fun! g:Match_xX( v_regex, cchar) abort
    exe "call matchadd('Conceal', '\\v"  . a:v_regex . "', 130, -1, {'conceal': '" . a:cchar . "'})"
                                    " pattern要用单引号包裹
    "\ 之前在这里用
    "\ exe 'autocmd My_syn Syntax' a:lan call matchadd('Conceal', '\\v" . a:v_regex . "', 130, -1, {'conceal': '" . a:cchar . "'})"
    "\ 导致ReloaD慢死
endf

au My_syn Syntax perl call Match_xX('# ', '')
"\ 不生效:
"\ au My_syn Syntax perl syn match  perl_com_delI     "# "    contained  containedin=perlComment



au My_syn Syntax *  call Bye_alL()
" au My_syn Syntax [^{/home/wf/dotF/cfg/nvim/coc-settings.json}]* call Bye_alL()
            " exclude specific file pattern
            "\ 失败....

        fun! Bye_alL()


            let all_byE = {
                \ '!\=(\?|#)?'                       :  '≠'           ,
                  "\ 不等号 考虑大小写的处理
                \ 'between (<\w\w{-}> )+\zsand\ze \w'  :  '⇔'         ,
                \ '<etc>\.'                            :  '⋯'         ,
                \ '%(^| )\zsreturn\ze%( |$)'           :  '↵'         ,
                \ '<note that\ze\s'                    :  ''          ,
                \ 'e\.g\.,'                    :  '例'                ,
                \ '<note:\ze\s'                        :  ''          ,
                "\ \ '\~\ze\/'                        :  '·'          ,
                "\ \ '\~\/'                        :  '·'             ,
                "\ 导致对不齐
                "\ \ 'byte'                             :  '♪'           ,
                \ '\<kbd>'   :  ''                                    ,
                "\ 对付html(另外, markdown会用html的语法)
                \ 'https?:\/\/%(github.com\/%(sisrfeng\/))'   :  '♂'  ,
                \ 'https?:\/\/%(github.com\/sisrfeng)@!.{18,}'  :  '.' ,
                \}
                    "\ 隐藏url:
                        " 从mdInlineURL改过来
                            "\ 这个来自markdown的mdInlineURL, 太复杂 太严谨了:
                        "\ call matchadd(
                        "\ \ 'Conceal'         ,
                        "\ \ 'https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z0-9][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?[^] \t]*'  ,


            for [r,c] in items(all_byE)
                call Match_xX(r, c)
            endfor
        endf

" 导致进入terminal 会弹出echo窗口
    " au My_syn Syntax *
    "     \ | if &syntax != 'vim'
    "     \ |   call Bye_all_not_viM()
    "     \ | endif

au My_syn Syntax python,zsh    call Bye_all_not_viM()
    fun! Bye_all_not_viM()
            let all_not_vim_byE = {
                \  '\s+\zs\\$'                    :'↙️' ,
                \}

            for [r,c] in items(all_not_vim_byE)
                call Match_xX(r, c)
            endfor
    endf
"
"
"
"\ language specific
       "\ call matchadd('Conceal', "\\v\\~\\\\ref\\{.{-}}", 100, -1, {'conceal':' '})
                   " au My_syn Syntax tex call matchadd('Conceal', '\v\~\\ref\{.{-}}', 100, -1, {'conceal':' '})
                                                          " 单引号vs双引号:
                                                          " 这个不行

      " au My_syn Syntax tex call Bye_teX()
        " 挪到了  /home/wf/dotF/cfg/nvim/after/syntax/tex.vim


    "\ vim

      " help
         au My_syn Syntax help call matchadd('Conceal', '\v^\s*\zsif>' , 99, -1, {'conceal':'▸'})
"
     " " python
     au My_syn Syntax python call Bye_pythoN()
         fun! Bye_pythoN()
             let py_byE = {
                     \  '^\s*\zsif>'     :  '▷'  ,
                         "\ todo: 可能有false positive: ifXXXX
                     \  '^\s*\zselif'   :  '▶'  ,
                     \  '^\s*\zselse ?:'    :  '▫'  ,
                     "\ \  '<os\.path\.join'    :'𝔍' ,
                     "\ \  '^\s*\zselse:':'▪'  ,
                     \
                     \  '^\s*\zsfor>'               :'∀'  ,
                     \  '^\s*\zsdef\ze {-}\w+\(' : '£'  ,
                     "\ \  '^\s*\zsdef\ze {-}\w+\(.{-}\)' : '£'  ,  \ 要是函数跨行,就可能无法conceal
                     \  ":$"                 : '',
                     \}
     "
             for [r,c] in items(py_byE)
                 call Match_xX(r, c)
             endfor

            syn match  pyMeth   #:meth:#  conceal contained containedin=pyQuotes_3x2
            "\ syn match  rstTilde   #:meth:`\zs\~#  conceal
            "\ 还得是matchadd来暴力封印
            call matchadd('Conceal', '\v:\w+:`\zs\~', 100, -1, {'conceal':''})

            syn region  rstDouble_BackTick  concealends matchgroup=conceal  start=/``/ end=/``/
            hi link rstDouble_BackTick String

         endf

    "\ rst和(经常含rst的)python
    "还是放回after/syntax/rst.vim吧, python里好像复杂些
    "\ au My_syn Syntax python call Bye_rst_py()
        "\ fun! Bye_rst_py()
        "\     syn match  rstMeth   #:meth:#  conceal
        "\     "\ syn match  rstTilde   #:meth:`\zs\~#  conceal
        "\     "\ 还得是matchadd来暴力封印
        "\     call matchadd('Conceal', ':meth:`\zs\~', 100, -1, {'conceal':''})
        "\     if &ft == 'rst'
        "\         call matchadd('Conceal', '\*\*', 100, -1, {'conceal':''})
        "\     en
        "\
        "\     syn region  rstDouble_BackTick
        "\         \ concealends
        "\         \ matchgroup=conceal
        "\         \ start=#``#
        "\         \ end=#``#
        "\     hi link rstDouble_BackTick String
        "\     "\ syn region  rstDouble_BackTick  concealends   start=#``# end=#``#
        "\     "\ syn region  rstDouble_BackTick concealends matchgroup=conceal  start=#``# end=#``#
        "\     "\ conceal contained containedin=rstInlineLiteral
        "\     "\ syn match  rstDouble_BackTick   #``#  conceal contained containedin=rstCruft
        "\ endf


    " zsh
    au My_syn Syntax zsh call Bye_zsH()
         fun! Bye_zsH()
             let zsh_byE = {
                         \  '^\s*\zsif>'                 : '▷' ,
                         \  '^\s*\zselif>'               : '▶' ,
                         \  '^\s*\zselse>'               : '▫' ,
                         \  '^\s*\zsfi>'                 : '◁' ,
                         \
                         \  '^\s*\zsfor>\ze.{-}in'       : '∀' ,
                         \  '^\s*\zsdone>'               : '↥' ,
                         \
                         \  '[^ ]\zs\=\ze[^ ]'           : '←' ,
                         \  '\zsnn \ze\w\w{-}[^ ]\=[^ ]' : ''  ,
                         \  'local\ze:'                     :'𝕃' ,
                         "\ \  'nn \w{-}\zs\=\ze[^ ]'   :''  ,
                       \}

             au My_syn Syntax
                       \ zsh
                       \ call matchadd(
                                        \ 'Conceal',
                                        \ '\v^\s*\zsif>',
                                        \ 99,
                                        \ -1,
                                        \ {'conceal':'▸'},
                                    \ )

             for [r,c] in items(zsh_byE)
                 call Match_xX(r, c)
             endfor
         endf

    au My_syn  Syntax   lua  call Bye_lua()
        fun! Bye_lua()
            let lua_byE = {
                    \ '<end>'         :  '◁' ,
                    \ 'if.{-}\zs<then>'  :  ''  ,
                    \}

            for [r,c] in items(lua_byE)  | call Match_xX(r, c)  | endfor
        endf
"
"
"
func! g:Hi_paiR()
    syn cluster In_fancY     contains=In_VictoR,
                                 \In_AcutE,
                                 \In_Underline,
                                 \In_BackticK,
                                 \In_StrikE

                            "\ 这导致comment里太多高亮:
                                 "\ \In_Double_QuotE,
                                 "\ \In_Single_quotE

      "   cluster不能用这个argument:   containedin=pythonRawString


    hi In_VictoR guibg=#d0e0da
        syn match In_VictoR   "\v¿[^¿]+¿"hs=s+1,he=e-1  contains=VictoR containedin=mdCode
                                                                        " containedin=all  "  导致包裹区域被conceal
        syn match VictoR     "¿"  contained  conceal


    " au My_syn BufRead * if expand('%:p')  !=  '/home/wf/dotF/cfg/nvim/conceal_fast.vim'
    "                 \ | setl modifiable
    "                 \ | % sub  #¿#¿#ge
    "                 \ | call histdel('search',-2,)
    "                 \ | endif
                        " coc设置时 会报错,  它在搞鬼:
                        " 忽略即可
                                    " coc_nvim  BufEnter
                                    "     *         call s:Autocmd('BufEnter', +expand('<abuf>'))
                                    "     Last set from ~/PL/coc/plugin/coc.vim line 338




    hi In_AcutE guibg=#d0e0da
        syn match In_AcutE     contains=AcutE      "\v´[^´]+´"hs=s+1,he=e-1
        syn match In_AcutE     contains=AcutE     "\v(^|[^a-z\"[])\zs´[^´]+´"hs=s+1,he=e-1
        syn match In_AcutE     contains=AcutE      "\(^\|[^a-z"[]\)\zs´[^´]\+´\ze\([^a-z\t."']\|$\)"hs=s+1,he=e-1

        syn match AcutE     "´" contained  conceal
            " echom 'acute______________'  能echom, 但为啥不生效?

        " call matchadd('leoHight', '`[^` \t]\+', 1, -1, {"conceal":1} )
        " 用作method为啥不行?
        "  leoHight->matchadd('`[^` \t]\+')
        " 没加let吧?
        "

    hi In_Underline guifg=none gui=underline
        syn match In_Underline   contains=Exclam_up_down    "\v \zs¡[-_a-zA-Z0-9'"*+/:%#=[\]<>.,]+¡"
                                                             " ¡包裹的
        syn match Exclam_up_down   '¡' contained conceal

    " hi  In_StrikE  ✗gui=italic,inverse✗ guifg=gray  guibg=none
    hi  In_StrikE  gui=none guifg=#bbbbbb  guibg=none
        syn match In_StrikE        contains=StrikE  "\v✗[^✗]+✗"
        syn match StrikE    '✗'  contained "  conceal
                            " ctrl-k Y-


    syn match Double_quotE   #"\v"@<!# contained conceal         containedin=In_Double_quotE
                            "\ 双引号后 如果紧贴双引号, 则为Empty_stR
    "\ syn match Double_quotE   '"' contained conceal cchar=  containedin=vimStr
        hi In_Double_quotE guifg=#af5f00 guibg=#eeeee0 gui=none
        syn match In_Double_quotE      '\v \zs"[^"]{1,80}"'
                                  \ containedin=vimStr,pyStr
                                  "\ \ transparent
                                          "\ 要手动加每种语言吗zshStr..

        " hi In_Double_quotE_short guifg=#903a9a gui=none
        "     " 太短 所以颜色要明显一些 不然看不出来  "     算了 长的也明显些吧
        "     syn match In_Double_quotE_short   contains=Double_quotE    '\v^\s*[^:]{-}\zs"[^"]{1,6}"'
                                                              " not end with star

    syn match Single_quotE   #'\v'@<!#  contained   containedin=vimStr conceal
                            "\ 单引号后 如果紧贴单引号, 则为Empty_stR
    "\ syn match Single_quotE   #'# containedin=vimStr contained cchar=  conceal
                                 "\ containedin=String  " 没有String这个syntax group, 它只是highlight group
                                 "\ containedin=PyStr  " 不行



    syn match Space_stR   #'\s\+'#  contains=Single_quotE  containedin=vimStr,@vimCmts
    syn match Space_stR   #"\s\+"#  contains=Double_quotE  containedin=vimStr,@vimCmts
    hi  link Space_stR    In_VictoR

    syn match Empty_stR   #\v''@<!'#   containedin=vimStr,@vimCmts
    "\ syn match Empty_stR   #""#   containedin=vimStr,@vimCmts
    syn match Empty_stR   #\v""@<!"#   containedin=vimStr,@vimCmts
                           "\ @<!"解决上面那行的问题: python的docstring的开头 被当作Empty_stR
    "\ syn match Empty_stR   # \zs""\ze #   containedin=vimStr,@vimCmts
    hi  link  Empty_stR    In_VictoR
    "
        hi In_Single_quotE guifg=#508a9a gui=none
            " syn match In_Single_quotE   contains=Single_quotE    #\v \zs'[^']{3,80}'#
            syn match In_Single_quotE   contains=Single_quotE
                                      \ #\v%(^|\W)\zs'[^']{3,80}'#


        hi link Short_optioN In_Single_quotE
            syn match Short_optioN      contains=Single_quotE    #'-\a'#  " python的命令行的-a -h等选项
        hi link RHS_of_equatioN In_Single_quotE
            syn match RHS_of_equatioN   contains=Single_quotE    #\v\= ?\zs'\k+'#  " python的命令行的-a -h等选项

        hi Single_quote_shorT guifg=#508a9a gui=none guibg=#e0e6e3
            syn match Single_quote_shorT    contains=Single_quotE    #\v \zs'[^']{1,2}'#


    " hi In_BackticK guifg=#00000 guibg=#fdf0e3 gui=none
    "\ hi In_BackticK guifg=#00000 guibg=#e0e0df gui=none
    hi In_BackticK guifg=#00000 guibg=#e8e9db gui=none

        syn match In_BackticK     contains=BackTicK,In_VictoR  "`[^` \t]\+`"hs=s+1,he=e-1
                                                                " 不高亮两头的backtick
        syn match In_BackticK     contains=BackTicK,In_VictoR  "\v \zs(^|[^a-z\"[])\zs`[^`]+`"hs=s+1,he=e-1
        syn match In_BackticK     contains=BackTicK,In_VictoR  "\(^\|[^a-z"[]\)\zs`[^`]\+`\ze\([^a-z\t."']\|$\)"hs=s+1,he=e-1
            " 貌似不能用 /变量/hs....
                " let str_HI = "\v(^|[^a-z\"[])\zs" .. "`[^`]+`"
                " let str_HI = "\v(^|[^a-z\"[])\zs" .. "`[^`]+`" .. "\ze([^a-z\t\"']|$)"
                " syn match In_BackticK     contains=BackTicK  /str_HI/hs=s+1,he=e-1
                "
        " hi  BackTicK guifg=#fdf6e3  gui=none guibg=none
        syn match BackTicK   "`"   contained conceal


endf

fun! g:Hi_markuP()
    syn match Empty_conceaL
                \ #\v \zsempty string#
                \ conceal
                \ cchar=ױ

    syn match When2iF
                \ #\v^\s*\zsWhen>#
                \ conceal
                \ containedin=ALL
                \ cchar=▷

    " 如果要用, 再加这行, (别在python里conceal square bracket, it does not mean optional):
        " syn cluster Markup_fancY   contains=In_VictoR,In_AcutE,In_Underline,In_SquarE,Short_hand

         " syntax match v_Line_Cmt   /^[ \t:]*".*$/  contains=@vimCmts,vimCmt_Str,vimCmt_Title
         " 这样comment就和正文混一起了.. .

    hi man_QuotE  guifg=#903a9a gui=none
        syn match man_QuotE
               \ contains=BackTicK,Single_quotE
               \ #\v zs``?.[^`']{1,80}'?'#
                        "   ``''
                        "   或
                        "   `'
    " todo: 生效没?
        " au My_syn Syntax   md,markdown
            "\ \   syn match VictoR    "¿"  contained  conceal  containedin=mdNonListItemBlock
            "\ \ | syn match Md_beautifY contains=VictoR      "\v¿[^¿]+¿"hs=s+1,he=e-1
        "                                 \ contained  conceal containedin=mdNonListItemBlock

    syn match BaR    "|"  contained conceal
        hi  In_BaR  guifg=#206043                         " 能匹配好多东西
            syn match In_BaR        contains=BaR  "\v\\@<!\|[!#-)+-~]+\|"
            "\ syn match In_Bar_enD    contains=BaR  "\v^\p{-}  \\@<!\|[!#-)+-~]+\|$" conceal
                                                     " 与前面隔开2个空格, 且位于行末,
                                                     " \\@<!  ¿@<!¿ 使得后续内容 的前面不能有¿\¿
                                                    "\ ^\p{-} 如果|xxx|单独成行, 不被封印
            " syn match In_BaR        contains=BaR  "\v\\@<!\|[!#-)+-~]+\|"  conceal
                                                                         " 只在markup language里conceal
                                                                         " 啊 会导致有些行内的内容不见了
                                                      " ! 双引号是34  # $ % & ' (  )  42是星号   +  ~
                                                      " 33           35            41           43 126

    syn match Bar_with_lnuM    "|"  contained
        hi  Bar_with_lnuM guifg=#f0f0e0

                    "\ |3 col 10 info|
        hi  Toc_lnum guifg=#f0f0e0
        syn match Toc_lnum   "\v\\@<!\|\s{,4}\d{1,5}\| " contains=Bar_with_lnuM  conceal
                                                          " toc的行号
        "
        " 这使得竖线不是被隐藏, 而是和背景一样的颜色, 看不见,(但还占着位置,不会少一个字符位置)
            " 代替了:
            " syn match BaR    "|"  contained  conceal    |  hi def  BaR gui=underline
                                                               " conceal后, hi def BaR 被覆盖
                                    " contained让竖\1线不会被单独匹配
                                                  " conceal作为一个flag, 让竖线(bar)在被匹配时, 会被conceal
            " hi def  BaR  guibg=#ff0000
            " 1.  有hi def link
            "   但hi def 某个颜色 很少见, 如果用了,
            "   得先hi clear再hi def不生效
            "
            " 2. hi  BaR guifg=bg_wf
            "    在leo_light.vim里 guifg=bg_wf 明明可以, 这里却不生效(但不报错)

                " 这是为了排除掉包含bar的这几种情况?
                    syn match helpNormal                "|.*====*|"
                    syn match helpNormal                "|||"
                    syn match helpNormal                ":|vim:|"       " for :help modeline

        hi In_SquarE guifg=#b0b0b0
            syn match In_SquarE     contains=left_squarE,righ_squarE  "\v\s\[[-a-zA-Z0-9_]+]"
                syn match left_squarE        "\["  contained conceal
                syn match righ_squarE         "]"  contained conceal
                " help.vim里有可以匹配[count]等的这个:
                "   syn match helpSpecial         "\v\s\[[-a-z^A-Z0-9_]{2,}]"ms=s+1
                "   所以In_SquarE被helpSpecial覆盖了?

          " 处理缩写,比如 b[uffer]
          hi Short_hand guifg=#b0b0b0
              syn match Short_hand    contains=left_squarE,righ_squarE "\v\w\zs\[(\w+|!)\]"
                  " g[lobal]里面的中括号, 表示缩写,不表示option,
                  " 不在helpOptional这个组里
                  " 我用正则 可以匹配g[lobal]

    " {大括号包裹} In_BracE
    hi In_CurlY guifg=#446655 gui=bold
                      " 若有似无的暗绿色
        syn match In_CurlY   contains=CurlY_1,CurlY_2      "\v[^{]\zs\{[-_a-zA-Z0-9'"*+/:%#=[\]<>.,]+}"
                                                                     " 长这样:   {至少一个[]里的字符}
                                                          " vim的help里的regex, markdown等不一定适用
        syn match CurlY_1   '{' contained conceal
        " syn match CurlY_1   '{' contained conceal  cchar=⋅
        syn match CurlY_2   '}' contained conceal


    " au My_syn Syntax * echom 'afile:'  expand('<afile>:p') | echom ' '
    " au My_syn Syntax * echom 'amatch:' expand('<amatch>:p') | echom ' '
    "                                      " amatch显示~/dotF/cfg/nvim下的文件(扔掉.vim)

    " :help syntax-loading
        "   Any other user installed FileType or Syntax autocommands are triggered.
        "   This can be used to change the highlighting for a specific syntax.
endf

"
au My_syn Syntax   *                        call Hi_paiR()
au My_syn Syntax   help,man,nroff,w3m       call Hi_markuP()
"\ au My_syn Syntax   help,man,nroff,w3m,tex   call Hi_markuP()

au My_syn Syntax   vim,help,lua    source $nV/after/syntax/vim.vim

"
au My_syn Syntax   * call Few_wordS()
"\ au My_syn FileType *
        "\ 好像不行:
    fun! g:Few_wordS() abort
        syn match FeW  #\v%(less|smaller) than#                       conceal cchar=≺

        syn match FeW  #\v\%(more|bigger|greater)\s+than\ze( or)@!#         conceal cchar=≻

        syn match FeW  #at most#                                                 conceal cchar=≤
        syn match FeW  #\v%(small|less)%(%(-| )?than)? or equal to#        conceal cchar=≤
        syn match FeW  #up to#                                                 conceal cchar=≤

        syn match FeW  #\v(at least|no smaller than)#                        conceal cchar=≥
        syn match FeW  #\v%(greater|more)%(%(-| )?than)? or equal to#        conceal cchar=≥
                                "\ more than 或者more-than
    endf

" au My_syn Syntax   help                     call Hi_helP()
" 放回help.vim里
    " fun! Hi_helP()
    " endf
"

au My_syn Syntax   javascript     syn match js_com_delI '\/\/ '
                                    \ contained  containedin=jsLineComment conceal

au My_syn Syntax   scheme     syn match scheme_com_delI '; '
                                    \ contained  containedin=schemeComment conceal


    "\ au My_syn Syntax   python       syn match pyCmt_delI '\v\zs# = =\ze\p'   contained  containedin=pyComment  conceal
    "\ au My_syn Syntax   python       syn match pyCmt_delI '# *$'          contained  containedin=pyComment  conceal  "
                                                          " 处理一行里只有井号的情况
            "\ 放在文件里也不行: /home/wf/dotF/cfg/nvim/syntax/python.vim


au My_syn Syntax   c          syn match c_com_delI '\/\/ '
                                    \ contained  containedin=cCommentL conceal

au My_syn Syntax   c          syn match c_com_delI2 '\/\/\/ '
                                    \ contained  containedin=cCommentL conceal


au My_syn Syntax   conf     syn match conf_com_delI '\v%(^|\s+)\zs#%( |$)'
      \ contained conceal containedin=confComment
      \ | hi link conf_com_delI Vim_com_delI


au My_syn Syntax   zsh     syn match Zsh_com_delI '\v%(^|\s+)\zs#%( |$)'
      \ contained conceal containedin=zshComment
      \ | hi link Zsh_com_delI Vim_com_delI

"\ au My_syn Syntax   toml     syn match Toml_com_delI '\v%(^|\s+)\zs#%( |$)'
                                                    "\ 有缩进的#无法封印
au My_syn Syntax   toml     syn match Toml_com_delI '\v# '
      \ contained conceal containedin=tomlComment
      \ | hi link Toml_com_delI Vim_com_delI




au My_syn Syntax   autohotkey     syn match Ahk_com_delI  '\v%(^|\s+)\zs;%( |$)'
      \ contained conceal containedin=ahkComment
      \ | hi link Ahk_com_delI   Vim_com_delI

" hi link Fold_marK HidE
    au My_syn Syntax   *   syn match Fold_marK  #"\s*{{{\d\?$# conceal containedin=@vimCmts
    au My_syn Syntax   *   syn match Fold_marK  #"\s*}}}\d\?$# conceal containedin=@vimCmts


" ref:
    " if !has('conceal')
    "     finish
    " endif
    "
    " syntax clear cppOperator
    "
    " syntax match cppOperator "<=" conceal cchar=≤
    " syntax match cppOperator ">=" conceal cchar=≥
    "
    " syntax match cppOperator "=\@<!===\@!" conceal cchar=≡
    " syntax match cppOperator "!=" conceal cchar=≢
    "
    " syntax match cppOperator "\<or\>" conceal cchar=∨
    " syntax match cppOperator "\<and\>" conceal cchar=∧
    " syntax match cppOperator "\<not\>" conceal cchar=¬
    "
    " syntax match cppOperator "::" conceal cchar=∷
    " syntax match cppOperator "++" conceal cchar=⧺
    "
    " syntax match cppOperator "\<pi\>" conceal cchar=π
    " syntax match cppOperator "\<sqrt\>" conceal cchar=√
    "
    " syntax match cppOperator ">>" conceal cchar=»
    " syntax match cppOperator "<<" conceal cchar=«
    "
    " syntax keyword cppOperator NULL conceal cchar=⊥
    " syntax keyword cppOperator nullptr conceal cchar=⊥
    "
    " syntax keyword cppOperator bool conceal cchar=𝔹
    " syntax keyword cppOperator int conceal cchar=ℤ
    " syntax keyword cppOperator float conceal cchar=ℜ
    "
    " syntax match cppOperator "\<length\>" conceal cchar=ₗ
    " syntax match cppOperator "\<size\>" conceal cchar=ₛ
    "
    " syntax match cppOperator "\<array\>" conceal cchar=𝒜
    " syntax match cppOperator "\<list\>" conceal cchar=ℒ
    "
    " syntax keyword cppOperator void conceal cchar=⊥
    "
    " syntax keyword cppOperator false conceal cchar=𝐅
    "
    " syntax keyword cppOperator true conceal cchar=𝐓
    "
    "
    "
    " syntax keyword cppOperator function conceal cchar=λ
    " syntax keyword cppOperator return conceal cchar=↵
    "
    " hi link cppOperator Operator
    " hi! link Conceal Operator
    "
    " setl     conceallevel=1
    "
    "
    "
" ref:
    " setl     conceallevel=1
    " syntax clear cppOperator
    "
        " syntax match cppOperator "++" conceal cchar=⧺
        " syntax match cppOperator "=\@<!===\@!" conceal cchar=≖
        " syntax match cppOperator "!=" conceal cchar=≠
        " syntax match cppOperator "<=" conceal cchar=≤
        " syntax match cppOperator ">=" conceal cchar=≥
        "
        " syntax match cppOperator "<<" conceal cchar=«
        " syntax match cppOperator ">>" conceal cchar=»
        "
        " syntax match cppOperator "::" conceal cchar=∷
        " syntax match cppOperator "->" conceal cchar=→
        "
        " syntax match cppOperator "||" conceal cchar=∥
    "
