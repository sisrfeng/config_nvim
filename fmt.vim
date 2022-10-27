"\ fun! Capitalize()
"\ :% sub#\vsection\{.*\zs<(.)(\w*)#\u\1\L\2#gc
"\ :% sub#\vsection\{.*\zs<(.)(\w*)#\u\1\L\2#gc
"\ endf

" https://github.com/ikamensh/flynt
    " pip install flynt
    " 会直接覆盖
    " flynt 文件
" https://github.com/supernlogn/f-string-deconverter


"\ easy align
    "\ If a delimiter is in a highlight group whose name matches
        "\ any of the followings,
        " it will be ignored.
    " Default:
        "\ let g:easy_align_ignore_groups = ['Comment', 'String']

    vmap <Enter>         :EasyAlign |"加个空格 免得手动敲

    vmap <Enter>\         :EasyAlign -1 \\<cr>
    vmap <Enter>_         :EasyAlign -1 _<cr>
       "\
    vno  <Enter><Enter>    <esc>:silent!
                                        \ '< , '>     EasyAlign  /\v^\s*\zs"?\\/<cr>
                                       \: '< , '>     EasyAlign  1 / : /<cr>
                                       \: '< , '>     EasyAlign  1  /: /<cr>
                                       \: '< , '>     EasyAlign -1 =<cr>
                                       \: '<,  '>     EasyAlign -1 ,<cr>gv
                                       "\ \: '<,  '>     call SpaceOperSapce()<cr>
                                       "\ 会把路径的¿/¿当作除号 切开路径

    vno  <Enter>o    <esc>:silent!  '<,  '>     call SpaceOperSapce()<cr>

    fun! SpaceOperSapce()
        sub @\S\zs+\ze\S@ + @ge
        sub @\S\zs-\ze\S@ - @ge
        sub @\S\zs\*\*\ze\S@ ** @ge
        sub #\v[^ *]\zs\*\ze[^ *]# * #ge
        "\ sub @\S*\S@ * @g  "\ 会搞乱**kwarg
        sub @\S\zs/\ze\S@ / @ge
        sub @\S\zs%\ze\S@ % @ge
    endf

    nmap <M-CR>          <Plug>(EasyAlign)
    vmap <M-CR>          <Plug>(EasyAlign)

        " Start interactive EasyAlign for a motion/text object (e.g. gaip)
        "  还是先选中 再:EasyAlign吧

    " wf_align  \ easyaling configuration  \ easyaling diy  \ diy align
        " 小心对齐后 字符串里多出来的空格
        let g:easy_align_delimiters = {
            \  '$': #{ pattern : "$" },
            \  '"': #{ pattern : '"' },
            \  '_': #{ pattern : 'to_be_used_先放着' },
            \  '+': #{ pattern : "+" },
            \  '<': #{ pattern : "<" },
            \  '.': #{ pattern : "\." },
            \  '|': #{ pattern : "|\s*" },
            \  ',': #{ pattern : "," },
            \  'i': #{ pattern : "import" },
            \  ':': #{ pattern : ":" , left_margin: 1 , stick_to_left:0 , right_margin: 1 }  ,
            \  '=': #{ pattern : "="  , left_margin: 1 , stick_to_left:0 , right_margin: 1  } ,
            \  '2': #{ pattern : "@"  , left_margin: 2 , stick_to_left:0 , right_margin: 0  } ,
            \  "'": #{ pattern : "'$" },
            \  '?': #{ pattern : '?' },
            \  '~': #{ pattern : '\~/__危险_万一多出空格_把HOME目录删了就麻烦了_别这么设' },
            \  '\': #{
            \        pattern          : '\v' . '%(\\$)' . '|' . '%(^\s*"?\\)',
            \        delimiter_align  : 'l',
            \        left_margin      : 2,
            \        right_margin     : 0,
            \      },
            \  'd': #{
               "\ digit
            \        pattern       : '\v\s+\zs\d+\ze\s',
            \        left_margin   : 0,
            \        right_margin  : 0
            \       },
            "\ \  'e': #{
            "\    "\ equal
            "\ \        pattern       : '\v (\S+\s*[;=])@=',
            "\ "\ \        pattern       : ' \(\S\+\s*[;=]\)\@=',
            "\ \        left_margin   : 0,
            "\ \        right_margin  : 0
            "\ \       },
            \  'e': #{
                    \ pattern        :  '\v\<\=\>|(\&\&|\|\||\<\<|\>\>)\=|\=\~[#\?]' ,
                    \ left_margin    :  1                                                                            ,
                    \ right_margin   :  1                                                                            ,
                    \ stick_to_left  :  0                                                                            ,
               \ },
            "\ 敲\\, 而非\, 才能用这个pattern, 现在map成 <cr>_了
            "\ 下面的是作者教的
                    \  '>': #{ pattern : '\v'..'>>|\=>|>' },
                    \
                    \  ']': #{
                    \         pattern        : '[[\]]',
                                                "\ 中括号(左或右?)
                    \         left_margin    : 0,
                    \         right_margin   : 0,
                    \         stick_to_left  : 0
                     \       },
                    \
                    \  ')': #{
                    \         pattern        : '[()]',
                    \         left_margin    : 0,
                    \         right_margin   : 0,
                    \         stick_to_left  : 0
                        \    },
                    \
                    \  '/': #{
                    \          pattern          : '//\+\|/\*\|\*/',
                    "\                       匹配: // /*  */
                    \          delimiter_align  : 'l',
                    \          ignore_groups    : ['!Comment']
                                                "\ 排除非注释区域( 只处理注释 )
                     \       },
        \}

        let g:easy_align_delimiter_align = 'l'
        let g:easy_align_ignore_comment  = 1

    vno   <cr>,       : EasyAlign -1  ,<cr>gv
    vno   <cr><space> : EasyAlign  *   / /<left>

" n: newline
    nno <Leader>n     V<Cmd>call One_arg_per_linE()<cr>
                     \:EasyAlign -1 \\<cr>
                     \:'[ , '] EasyAlign -1 ','<cr>
                     \:call search('(')<cr>l
                     \:ArgWrap<cr>

    vno <Leader>n      <Cmd>call One_arg_per_linE()<cr>
                      \:EasyAlign -1 \\<cr>
                      \:'[ , '] EasyAlign -1 ','<cr>
                      \:call search('(')<cr>l
                      \:ArgWrap<cr>

        fun! One_arg_per_linE()
            mark b
            let _indent = indent('.') - 1
            let _indent2 = indent('.') + 4
            echom _indent
            " 在等号处断开
            sub #=#\\\r=#e
            exe "left" _indent2
            normal k
            sub  #,#\=",\\\r" . repeat(' ' , _indent)#g

                " exe "'<,'> left" _indent
            " '< , '>   call easy_align#align(0, 0, 'command', '-1 \\')
            " call search('(')
            " normal l
            " ArgWrap
        endf


" bulletfY
    nno <silent> ;l  :call bulletfY#ConverT()<CR>f
    xno <silent> ;l  :call bulletfY#ConverT('visual')<CR>f

    " 被bulletfY取代了?:
        " func! g:Bullet_it()
        "     " 专治   >=2个 + 1个and
        "     " 例如:
        "         " SumatraPDF is a PDF viewer for windows that is  powerful, small, portable and  starts up very fast.
        "
        "     " 1.  把" and"变为","
        "     let g:commaX2 = '\w+>,\s{1,2}(\w+>){1,4},' | exec 'subs #\v' . g:commaX2 . ' \zs(and|or)' . '##gc'
        "     let g:comma_A = '\w+>,\s{1,2}(\w+>){1,4}' | exec 'subs #\v' . g:comma_A . '\zs (and|or)' . '##gc'
        "               " 有时候并列的是phrase, 我只处理1到4个单词的phrase
        "     " 2. 空格+逗号变换行
        "     exec 'subs #\v\w+>\zs,\s{1,2}\ze(\w+>){1,4},\s{1,2}' . ',' . '#\r#ge'
        " endf
        "

"\ comma go down 1 line
    nno ,d <Cmd>call Comma_dowN()<cr>
        fun! Comma_dowN()
            "\ setl form
            if &syntax == 'vim'
                try
                    "norm! /\\v\(contains|containedin)\=\\ze(\\w|\\@)+,(\\w|\\@)\<cr>h"
                    " 光标挪到 `contains=` 或者`contained=`
                    "\ exe "norm! /\\v\\=\\ze(\\w|\\@)+,(\\w|\\@)\<cr>h"
                    "\ norm! /\v(\w|\@)\zs,\ze(\w|\@)  这样写 看起来清爽些?
                catch /.*/
                endtry
                let in_dent = ' ' ->repeat( col('.') - 8 )   "\ contains用一个符号显示了
                "\ let in_dent = ' ' ->repeat( col('.') )
                exe  '.,$ sub#' . '\v(\w|\@|\.\*)\zs,\ze(\w|\@)' . '#' . ',\r' . in_dent . '\\'  . '#gec'

            "\ elseif &syntax == 'help'
            else
                norm! /v(,|<or>)Bh
                          "\ 到逗号前一个word的首字母
                      "\
                let in_dent = ' ' ->repeat( col('.') )
                exe  '.,$ sub#\v *(,|<or>) *#\r' .  in_dent  . '#gec'
            en
        endf

    nno <Leader>d <Cmd>call Space_dowN()<cr>
    nno sd        <Cmd>call Space_dowN()<cr>
        fun! Space_dowN()
            let in_dent = ' ' ->repeat( col('.') - 1 )
            mark t
            exe  "'t,$ sub#" . '[^ \\]\zs \+\ze\S' . '#' . ' \r' . in_dent . '\\ '  . '#gec'
                 "\ mark不生效

                 "\ 报错:  `t,$
                 "\ 从光标位置开始替换
        endf


" Title Case
    nno  <silent> <Leader>,  :call Tex_title_casE()<cr>
    nno  <silent> gc         viw:<C-u>call Title_casE()<CR>
    vno  <silent> gc         :<C-u>call Title_casE()<CR>

    fun! Tex_title_casE()
        norm k
        call search('\v\\(To_be_added_keep_it_HERE|%(sub)*section>\{)', 'e')
        "\ call search('\v\\((item)|%(sub)*section>\{)', 'e')
        norm vv
        exe "norm \<esc>"
        call Title_casE()
        exe "norm \<esc>"
        norm j
    endf


    fun! Title_casE()
    " Title Case -- 空格后的字母大写

        norm gv
        " Hack: fix Vim's gv proclivity to add a line when at line end
        if virtcol(".") == 1
            norm '>
            " line select
            norm gV
            " up one line
            norm k
            " back to char select
            norm gV
            """" back up one char
            """normal h
        en

        " yank
        norm "xy

        " lower case entire string
        let @x = tolower(@x)
        " capitalize first in series of word chars
        let @x = substitute(@x, '\w\+', '\u&', 'g')
        " lowercase a few words we always want lower
        let @x = substitute(@x, '\<A\>', 'a', 'g')
        let @x = substitute(@x, '\<An\>', 'an', 'g')
        let @x = substitute(@x, '\<And\>', 'and', 'g')
        let @x = substitute(@x, '\<In\>', 'in', 'g')
        let @x = substitute(@x, '\<The\>', 'the', 'g')
        " lowercase apostrophe s
        let @x = substitute(@x, "'S", "'s", 'g')

        " fix first word again
        let @x = substitute(@x, '^.', '\u&', 'g')
        " fix last word again
        let str = matchstr(@x, '[[:alnum:]]\+[^[:alnum:]]*$')
        let @x = substitute(@x, str . '$', '\u&', 'g')

        "\ "" optional lowercase...
                "\ let n = confirm(
                "\     \ "Lowercase additional conjunctions, adpositions, articles, and forms of \"to be\"?\n" .
                "\     \ "\n", "&Ok\n&Cancel", 2, "Info")
                let n = 1
                if n == 1
                    " lowercase conjunctions
                    let @x = substitute(@x , '\<After\>'    , 'after'    , 'g')
                    let @x = substitute(@x , '\<Although\>' , 'although' , 'g')
                    let @x = substitute(@x , '\<And\>'      , 'and'      , 'g')
                    let @x = substitute(@x , '\<Because\>'  , 'because'  , 'g')
                    let @x = substitute(@x , '\<Both\>'     , 'both'     , 'g')
                    let @x = substitute(@x , '\<But\>'      , 'but'      , 'g')
                    let @x = substitute(@x , '\<Either\>'   , 'either'   , 'g')
                    let @x = substitute(@x , '\<For\>'      , 'for'      , 'g')
                    let @x = substitute(@x , '\<If\>'       , 'if'       , 'g')
                    let @x = substitute(@x , '\<Neither\>'  , 'neither'  , 'g')
                    let @x = substitute(@x , '\<Nor\>'      , 'nor'      , 'g')
                    let @x = substitute(@x , '\<Or\>'       , 'or'       , 'g')
                    let @x = substitute(@x , '\<So\>'       , 'so'       , 'g')
                    let @x = substitute(@x , '\<Unless\>'   , 'unless'   , 'g')
                    let @x = substitute(@x , '\<When\>'     , 'when'     , 'g')
                    let @x = substitute(@x , '\<While\>'    , 'while'    , 'g')
                    let @x = substitute(@x , '\<Yet\>'      , 'yet'      , 'g')

                    " lowercase adpositions
                    let @x = substitute(@x , '\<As\>'   , 'as'   , 'g')
                    let @x = substitute(@x , '\<At\>'   , 'at'   , 'g')
                    let @x = substitute(@x , '\<By\>'   , 'by'   , 'g')
                    let @x = substitute(@x , '\<For\>'  , 'for'  , 'g')
                    let @x = substitute(@x , '\<From\>' , 'from' , 'g')
                    let @x = substitute(@x , '\<In\>'   , 'in'   , 'g')
                    let @x = substitute(@x , '\<Of\>'   , 'of'   , 'g')
                    let @x = substitute(@x , '\<On\>'   , 'on'   , 'g')
                    let @x = substitute(@x , '\<Over\>' , 'over' , 'g')
                    let @x = substitute(@x , '\<To\>'   , 'to'   , 'g')
                    let @x = substitute(@x , '\<With\>' , 'with' , 'g')

                    " lowercase articles
                    let @x = substitute(@x , '\<A\>'   , 'a'   , 'g')
                    let @x = substitute(@x , '\<An\>'  , 'an'  , 'g')
                    let @x = substitute(@x , '\<The\>' , 'the' , 'g')

                    " lowercase forms of to be
                    let @x = substitute(@x , '\<Be\>'      , 'be'    , 'g')
                    let @x = substitute(@x , '\<To\> \<Be\>' , 'to be' , 'g')
                    let @x = substitute(@x , '\<To\> \<Do\>' , 'to do' , 'g')
                    " lowercase prepositions
                    " lowercase conjunctions

                    let @x = substitute(@x , '\<Item\>'          , 'item'          , 'g')
                    let @x = substitute(@x , '\<Section\>'       , 'section'       , 'g')
                    let @x = substitute(@x , '\<Subsection\>'    , 'subsection'    , 'g')
                    let @x = substitute(@x , '\<Subsubsection\>' , 'subsubsection' , 'g')


                    let @x = substitute(@x, '\<Ab\>', 'aB', 'g')


                en

        " reselect
        norm gv


        " replacing selection
        norm "xP

        "
        norm gv
    endf



source  $nV/split.vim

