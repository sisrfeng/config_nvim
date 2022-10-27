" Control Characters:
    syn match   vimCtrlChar #[--]#

" Patterns with ^
    syn match   vimContinue #^\s*\zs\\#
                " ¿\¿换行
    syn match   vimCmt_TitleLeader   #\v"\s+#
                                      \ms=s+1  contained

    syn match   vimCmt_Title   '\v"\s*%([sS]:|\h\w*#)=\u\w*(\s+\u\w*)*:'hs=s+1   contained
                                \ contains=vimCmt_TitleLeader,
                                  \vimTodo,
                                   \@vimCmts

    syn region  vimStr
            \ keepend
            \ start=#^\s*\\\z(['"]\)#
                \  skip=#\\\\\|\\\z1#
            \ end=#\z1#
            \ oneline
            \ contains=@vimStr_cluS,vimContinue
            "\ 行首:"any string行末 (冒号被视为注释的一部分, 很少见)
            "\ 行首 "any string行末
            "\ 行首    "any string行末

"\ linecomment:从行首开始的注释
    " syn match   vimLineCmt
    "              \ #^[ \t:]*".*$#
    "              \ contains=@vimCmts,vimCmt_Str,vimCmt_Title,@In_fancY
    " 区分2种注释:
    " hi  vimLineCmt guifg=#9f9f80 guibg=none  gui=none
    syn match     vimLineCmt
                    \  #^[ \t:]*"[^\\]*$#
                    \ contains=@vimCmts,vimCmt_Str,vimCmt_Title,@In_fancY


    hi def link   vimTailCmt      Comment
    hi  def link     vimLineCmt       vimTailCmt
    hi def link   vimLineCmt2      vimTailCmt

    syn match   vimLineCmt2
                    \ #^[ \t:]*"\\ .*$#
                    \ contains=@vimCmts,
                       \@In_fancY,
                       \vimCmt_Str,
                       \vimCmt_Title


    "\ 导致注释五颜六色:
        "\ syn match   vimLineCmt2
        "\                 \ #^[ \t:]*"\\ .*$#
        "\                 \ contains=ALL,

        "\ syn match   vimLineCmt2
        "\                 \ #^[ \t:]*"\\ .*$#
        "\                 \ contains=TOP



"\ let a = 1
    " syn region vimAssign matchgroup=DebuG  concealends  oneline start='let' end='='me=e-1  conceal
    " syn match  vimLet_m '\vlet.{-}\='  conceal
    " hi link vimAssign visual

" Searches And Globals:
    syn match   vimSearch   #^\s*[/?].*#        contains=vimSearchDelim
    syn match   vimSearchDelim
                    \ #^\s*\zs[/?]\|[/?]$#
                    \ contained

    syn region  vimGlobal
                    \ matchgroup=Statement
                    \ start='\<g\%[lobal]!\=/'
                        \ skip='\\.'
                    \ end='/'
                    \ skipwhite   nextgroup=vimSubst

    syn region  vimGlobal
                    \ matchgroup=Statement
                    \ start='\<v\%[global]!\=/'
                        \ skip='\\.'
                    \ end='/'
                    \ skipwhite   nextgroup=vimSubst


