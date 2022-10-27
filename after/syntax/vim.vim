hi vimStr guibg=#e9e9e0   guifg=#111111


"\ 之前放在一个叫 Bye_viM()的函数里
    if expand('%:p') =~ 'autoload'
        " pre表示  函数名前一部分
        let pre = substitute(
                        \ matchstr(expand('%:p'),  'autoload/\zs.*\ze.vim'),
                        \ '[/\\]',
                        \ '#',
                        \ 'g',
                      \ ) . '#'
        let g:auto_id = matchadd('Conceal', pre,  100, -1, {'conceal':''} )
    en

    if expand('%:p') =~ 'plugin'
        let PL_pre = substitute(
                        \ matchstr(expand('%:p'),  'plugin/\zs.*\ze.vim'),
                        \ '[/\\]',
                        \ '#',
                        \ 'g',
                      \ ) . '#'
        let g:plugin_id = matchadd('Conceal', PL_pre,  100, -1, {'conceal':''} )
    en

    let vim_byE = {
                "\ \ varible scope/ global / script / arg
                 \ '<a:\ze\a'                  :  ''    ,
                 \ '<abort>'                  :  ''    ,
                 \ '<a:0>'                  :  '𝄰'    ,
                 \ '<a:000>'                  :  '⋯'    ,
                 \ '<l:\ze\a'                  :  ''    ,
                 \ '<s:\ze\a'                  :  ''    ,
                 \ '<g:\ze\a'                  :  ''    ,
                "\ 藏起a:arg_of_a_func
                 \ '<l\ze:\a'                  :  ''   ,
                 "\ \ '<l\ze:\a'                  :  '𝕃'   ,
                 \ '<l\zs:\ze\a'               :  ''   ,
                "\ \  '^\s*\zs\\'              :  '↗'   ,
                "\ \  '^\s*\zs\\ ' 多加一个空格导致出现2个cchar
                "\ 在syntax/vim.vim里设置了 (在这里设了 有时不生效)
                 \
                 \ '<let\s+\ze\p{-}\= '         : ''  ,
                 \ '<let>.{-} \zs\=\ze '        : '←' ,
                "\ \  '<let>.{-} \zs\.\ = \ze ' : '↙️' ,
                "\ 会出现2个cchar
                 \
                 \ '\(\) \zsabort'               :  ''    ,
                 \ '\(\S\+\) \zsabort'           :  ''    ,
                "\ \  ' \. '                   :  'ߙ'   , 会出现3个cchar
                 \ ' \zs\.\.=\ze '                   :  'ߙ'   ,
                 \ '"\zs\.\.=\ze '                   :  'ߙ'   ,
                 \ ' \zs\.\.=\ze"'                   :  'ߙ'   ,
                 \ '"\zs\.\.=\ze"'                   :  'ߙ'   ,
                 "\ \ "\'\zs\.\ze "                   :  'ߙ'   ,
                 "\ \ '''\zs\.\ze '                   :  'ߙ'   ,   \ 有单引号就报错, g:Match_xX好复杂, 待完善
                 \
                 \ 'no\zs +\<silent\>\<buffer\>'  :  ' '    ,
                 \ '\<plug\>\(\ze\p\p{-}\)'           :  ''    ,
                 \ '\<plug\>\(\p\p{-}\zs\)'           :  ''    ,
                "\ \  '(^|\A)\zscall '                :  ''  ,  \ 为啥有\A啊, 本来想表示\u 吗
                \}

                "\ 单引号不好搞:
                 "\ \ ¿' \zs\.\ze'''¿                :  'ߙ'        ,


        for [r,c] in items(vim_byE)
            call Match_xX(r, c)
        endfor

    let vim_bye_heaD = {
            \ 'if>'                   :  '▷'  ,
            \ 'elseif>'               :  '▶'  ,
            \ 'el%[se]>'              :  '▫'  ,
            \ 'endif>'                :  '◁'  ,
            \ 'endif$'                :  '◁'  ,
            \ 'en>'                   :  '◁'  ,
            \
            \  'for>\ze.{-}in '       :  '∀'  ,
            \  'endfor>'              :  '↥'  ,
            \
            \  'endf>'                :  '♩'  ,
            \  'endfunction>'         :  '♩' ,
             \ 'call\s\ze\h\w*.{-}(.{-})'                :  ''   ,
            \ }
            "\ 会出现2个cchar:
            "\ $nV/syntax/vimS/func.vim里设了vimFuncDef_hidE, 则只有一个cchar
            "\ \  'fu%[nction]>!\ze \w'  :  '£'  ,
            "\ \  'fu%[nction]>!\ze \h\w+\(.{-}\)' : '£'  ,
            "\ \  'fun!\ze \w\p+\(.{-}\)'          : '£'  ,

                "\                              'ヿ'

        for [r,c] in items(vim_bye_heaD)
            "\ let r =  '<' . r
            let r =  '(^\s*| \| +)\zs' . r
                          "\ 匹配项前面 只有空格或遇到¿|¿
            call Match_xX(r, c)
        endfor


    syn match myContinue   '\v^\s*\zs\\\ze.+$'   containedin=ALL
    hi link myContinue	Half_tranS
    let s:hide_contiue = 1
    " let g:backslash_iD = matchadd(
    "                         \ 'Half_tranS',
    "                         \ '\v^\s*\zs\\\ze.+$',
    "                         \ 200,
    "                         \ )

    nno <buffer>   ,b    <Cmd>call Hide_backslash_01()<cr>
                    " b: backslash
        fun! Hide_backslash_01()
            if s:hide_contiue == 1
                " echo '要被delete掉的g:backslash_iD是 ' .   g:backslash_iD
                " call matchdelete( g:backslash_iD )
                hi link myContinue	Ignore
                let s:hide_contiue = 0
            el
                hi link myContinue	Half_tranS
                let s:hide_contiue = 1
            en
                                "\ 一行里只有'\'一个字符的, 不隐藏, 避免不小心删错
        endf


    syn cluster  Have_regeX   contains=vimSynRegionPat,
                                  \vimSynMatch_Area,
                                  \String,
                                  \vimStr,
                                  \In_sharP,
                                  \@vimCmts


    "\ 专治syntax文件里的pattern
        "\ syn match Sharp_heaD   ' \zs#\ze\p'  contained  cchar=  conceal   containedin=@Have_regeX
        "\ syn match Sharp_enD   '\p\zs#\ze\ '  contained  cchar=  conceal   containedin=@Have_regeX
        "\ 他们导致¿#¿不能被conceal:
            "\ syn match Match_as_m   #syn match#    conceal cchar=ʍ  containedin=@Have_regeX
            "\ syn match Region_as_r   #syn region#   conceal cchar=ᗃ  containedin=@Have_regeX



        "\ syn match SharP   '#'  contained  cchar=  conceal   containedin=@Have_regeX
            "\ 这会让单个#消失掉
        "\ syn match SharP   '#'  contained  cchar=  conceal   containedin=In_sharP

        hi  Sharp_at_endS  guifg=#5f9000 guibg=#f0f0e0 gui=none
        hi  In_sharP       guifg=#5f9000 guibg=#f0f0e0 gui=none
        hi  link  vimSynMatchRegion  In_sharP
        hi  link  vimSynRegPat       In_sharP
        hi  link  vimSynKeyRegion    In_sharP

        syn region In_sharP
              \  oneline
                 "\ 不加oneline导致: 如果pattern里只有一个¿#¿, 会一直找下一个¿#¿
               \ keepend
               \ matchgroup=Sharp_at_endS concealends
                 \ start='#'
                   \ end='#'
               \ cchar=
             \   contained   containedin=@Have_regeX,
                      \vimIn_func_cluS
                      \vimFuncBody,

       "\ 不行?
       "\ syn region In_sharP
               "\         \ start='syn\s+match\s+\w+ \zs#'
               "\         \ end='#'
               "\         \ oneline
               "\         \ containedin=@Have_regeX
               "\         \ cchar= " 空格


        "\ 如果不设In_sharp_transparenT,
            "\ 类似下面例子中的¿#¿ 会被封印 :
            "\ call wrapA#hooks#execute(.....)
                "\ (~/PL/ArgWrap/autoload/wrapA.vim里的)
        syn region In_sharp_transparenT
              \  oneline
               \ keepend
               \ transparent
                 "\ 感觉加了transparent会更好, 但现在加不加都一样
               \ matchgroup=Sharp_at_ends_transparenT
               \ start='\vcall .{-}\w\zs#'
                 \ end='#\ze\h'
             \   containedin=vimFuncBody,vimIn_func_cluS,@vimCmts


    " 避免函数里的Faaa(...)被合并
    syn match Dot3  "\V..."  contained  containedin=vimOper



    "\ string concate
    " syn match Str_concatE  #\.#
    "\ syn match Str_concatE  #\v("|'| |\a)\zs\.\ze("|'| |\a)#
                                     "\ \a导致 vim.fn.等被搞乱
    syn match Str_concatE  #\v("|'| )\zs\.\ze("|'| |\a)#
                            \ conceal
                            \ contained
                            \ cchar=ߙ
                            \ containedin=vimExecute,
                              \vimFuncBody,
                              \vimOper,
                              \vimOper_brackeT,
                              \vimVar
                            \ nextgroup=vimStr,vimSpecFile skipwhite  "


    " ~/PL/TeX/autoload/vimtex/complete/tools/symbols-generated
    syn match Self_doT #\v<self>\.# conceal cchar=↺
                            \ containedin=vimOper,
                              \vimOper_brackeT,
                              \vimComment,
                              \vimFuncBody

    syn match Empty_conceaL  #\v \zsempty# conceal cchar=ױ
                            \ containedin=vimComment,
                              \vimFunc,
                              \vimFuncBody,
                              \vimFuncName



    syn match Empty_as_1 #\v \zs!empty# conceal cchar=𝟙
                            \ containedin=vimComment,
                              \vimFunc,
                              \vimFuncBody,
                              \vimFuncName




        syn match Double_backslasH   #\\\\#
                                \ conceal
                                \ cchar=╲
                                \ containedin=@Have_regeX

        syn match Escape_SlasH   #\\/#
                                \ conceal
                                \ cchar=⧸
                                \ containedin=@Have_regeX



        syn match A_doT          #\\\.#
                                \ conceal
                                \ cchar=｡
                                \ containedin=@Have_regeX

        syn match Zero_width_aT          #\\@#
                                \ conceal
                                \ cchar=ɵ
                                \ containedin=@Have_regeX

        syn match PrintablE          #\S\zs\\p#
                                \ conceal
                                \ cchar=𝕡
                                \ containedin=@Have_regeX

        syn match Upper_casE         #\S\zs\\u#
                                \ conceal
                                \ cchar=𝕦
                                \ containedin=@Have_regeX


        syn match Word_chaR          #\S\zs\\h#
                                \ conceal
                                \ cchar=𝕙
                                \ containedin=@Have_regeX

        syn match Word_chaR          #\\w#
                                \ conceal
                                \ cchar=ա
                                \ containedin=@Have_regeX

        syn match AlphabeT          #\\a#
                                \ conceal
                                \ cchar=𝕒
                                \ containedin=@Have_regeX

        syn match Digit_chaR          #\S\zs\\d#
                                \ conceal
                                \ cchar=𝕕
                                \ containedin=@Have_regeX

        syn match Zero_or_onE          #\\?#
                                \ conceal
                                \ cchar=ॽ
                                \ containedin=@Have_regeX


        " gothic
                " \   ['b', '𝕓'],
                " \   ['c', '𝕔'],
                " \   ['e', '𝕖'],
                " \   ['f', '𝕗'],
                " \   ['g', '𝕘'],
                " \   ['h', '𝕙'],
                " \   ['i', '𝕚'],
                " \   ['j', '𝕛'],
                " \   ['k', '𝕜'],
                " \   ['l', '𝕝'],
                " \   ['m', '𝕞'],
                " \   ['n', '𝕟'],
                " \   ['o', '𝕠'],
                " \   ['p', '𝕡'],
                " \   ['q', '𝕢'],
                " \   ['r', '𝕣'],
                " \   ['s', '𝕤'],
                " \   ['t', '𝕥'],
                " \   ['u', '𝕦'],
                " \   ['v', '𝕧'],
                " \   ['w', '𝕨'],
                " \   ['x', '𝕩'],
                " \   ['y', '𝕪'],
                " \   ['z', '𝕫'],




        syn cluster A_fancY  contains=Zero_starT,
                                     \Zero_enD,
                                     \SpacE,
                                     \And_escapE,
                                     \Belong_tO,
                                     \Not_belong_tO,
                                     \Plus_escapE
                                     \Vertical_baR,
                                     \Brace_escapE,
                                     \EscapE,
                                     \Hi_linK


            syn match Zero_starT      '\\zs'
                                    \ conceal
                                    \ cchar=◸
                                    \ containedin=@Have_regeX

            syn match Zero_enD      '\\ze'
                                    \ conceal
                                    \ cchar=◹
                                    \ containedin=@Have_regeX

            syn match SpacE         '\S\zs\\s'
                                    \ conceal
                                    \ cchar=   containedin=@Have_regeX

            syn match And_escapE      '\\&'
                                    \ conceal
                                    \ cchar=ձ
                                    \ containedin=@Have_regeX

            syn match Belong_tO       '\v \zs\=\~(#|\?)?\ze '
                                    \ conceal  cchar=∋
                                    \ containedin=@Have_regeX,
                                      \vimOper,
                                      \vimOper_brackeT,
                                      \vimFuncBody

                                      "\  这里加了vimFuncBody才能conceal
                                       "\ @vimIn_func_cluS 加不加都一样

            syn match Not_belong_tO   '\v \zs!\~(#|\?)?\ze '
                                    \ conceal  cchar=∌
                                    \ containedin=@Have_regeX,
                                      \vimOper,
                                      \vimOper_brackeT,
                                      \vimFuncBody

            syn match Plus_escapE      '\\+'
                                    \ conceal
                                    \ cchar=ⵜ
                                    \ containedin=@Have_regeX

            "\ 为了方便在\v里用:
                "\ 这些符号代表的是对应符号的literal
                "\ 毕竟适应了[{(|的特殊含义
            syn match Vertical_baR      '\\|'
                                    \ conceal
                                    \ cchar=⫿
                                    \ containedin=@Have_regeX

            syn match Brace_escapE      '\\{'
                                    \ conceal
                                    \ cchar=⦃
                                    \ containedin=@Have_regeX

            syn match EscapE      '\\('
                                    \ conceal
                                    \ cchar=⦗
                                    \ containedin=@Have_regeX

            syn match EscapE      '\\)'
                                    \ conceal
                                    \ cchar=⟯
                                    \ containedin=@Have_regeX

            " (^\s*)@<!  排除\换行的情况
            syn match EscapE      '\v(^\s*)@<!\\\='
                                    \ conceal
                                    \ cchar=≏
                                    \ containedin=@Have_regeX



            syn match EscapE      '\\\~'
                                    \ conceal
                                    \ cchar=∽
                                    \ containedin=@Have_regeX

                                    "\ Reversed tilde



            syn match EscapE      '\\\*'
                                    \ conceal
                                    \ cchar=∗
                                    \ containedin=@Have_regeX

            syn match EscapE      '\\<'
                                    \ conceal
                                    \ cchar=<
                                    \ containedin=@Have_regeX

            syn match EscapE      '\\>'
                                    \ conceal
                                    \ cchar=>
                                    \ containedin=@Have_regeX

            syn match EscapE      '\\%'
                                    \ conceal
                                    \ cchar=%
                                    \ containedin=@Have_regeX

            syn match Hi_linK     'hi \+\%[def ] *link *\ze \w'
                                    \ cchar=🜺   conceal


         " 让regex里的\v藏起来
            hi link Very_magiC   SpecialChar
                    " conceal以后,它highlight就不生效了

            syn match Very_magiC   #\S\zs\\v#
                \ contained
                \ conceal
                "\ \ cchar=ⱽ
                \ cchar=ᵥ
                "\ \ cchar=ѵ
                "\ \ cchar=𝓥
                \ containedin=@Have_regeX,
                   \In_sharP,
                   \Comment,vimLineCmt,vimCmtStr,
                   \String,vimStr

            "\ syn match Has_VeryMagiC
            "\                     \ contains=VeryMagiC
            "\                     \ #\v "\zs\\v\ze.{1,80}"#
            "\                     \ containedin=In_sharP,vimSynRegPat,vimSynMatchRegion



            " ╲ : Box drawings light diagonal upper left to lower right
            " ৲ : Bengali rupee mark


    hi link Vim_com_delI Ignore
    "\ 区分2种注释: ¿" 和 "\¿

        syn match Vim_com_delI   #\v"%( |$)#
            \ contained
            \ conceal
            \ containedin=@vimCmts

        syn match Vim_com_delI   #\v"\\%( |$)#
            \ contained
            \ conceal
            \ containedin=@vimCmts



                            "\ 官方定义了:
                            "\ syn match vimLineCmt
                                "\ /^[ \t:]*".*$/
                                " \ contains=@vimCmts,
                                      "\ \vimCmt_Str,
                                      "\ \vimCmt_Title


        syn match Vim_com_delI2   '\v^\s*\zs"\\%( |$)'
            \ contained
            \ containedin=v_Line_Cmt2,
            \ conceal
                         \vimTailCmt,
                         \vimStr,
                         \vimOper_brackeT

        "\ todo, 和 "\ $nV/syntax/vimS/syn_itself.vim 里的vimSyn_contain合并吧
            syn match vimDef_syn_conceaL   #contained#
                                    \ containedin=vimSyn_MatchOpt,vimSynRegOpt,vimClus_Area
                                    \ conceal   cchar=♀
                                                "\ cchar=⊋

            syn match vimDef_syn_conceaL   #containedin=#
                                    \ conceal   cchar=⊆
                                    \ containedin=vimSyn_MatchOpt,vimSynRegOpt,vimClus_Area
                                                              "\ 加了vimClus_Area还是不能封印
                                                              "\ 让¿containedin=¿换行后才行
            syn match vimDef_syn_conceaL   #contains=#
                                    \ conceal   cchar=⊇
                                    \ containedin=vimSyn_MatchOpt,vimSynRegOpt,vimClus_Area



au AG BufEnter */syntax/*.vim    call matchadd('Conceal', expand('<afile>:t:r') . '\ze\u', 99, -1)
au AG BufEnter */syntax/python.vim    call matchadd('Conceal', '\<py\ze\u', 99, -1)
au AG BufEnter */syntax/vimS/*.vim  call matchadd('Conceal', 'vim' . '\ze\u', 99, -1)
"\ au AG BufEnter */syntax/vim/*.vim  call matchadd('Conceal', 'Vim' . '\ze\u', 99, -1)

"\ leo concealed
"\ 写个leo concealed 当作记号, 方便以后抽取所有我定义的conceal
"\ 这个pattern来自上面的vimFuncDef, 把\ze挪到function!后
                                             "\ sSgGbBwWtTlL匹配¿b:¿等scope
syn match   vimFuncDef_hidE   "\<fu\%[nction]!\ze\s\+\%([sSgGbBwWtTlL]:\)\=\%(\i\|[#.]\|{.\{-1,}}\)*\s*("
            \ contains=@vimFuncDef_cluS
            \ nextgroup=vimFuncBody
            \ conceal cchar=£


