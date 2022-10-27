syn cluster vimIn_Oper_cluS    contains=vimEnvvar,
                                \vimFunc,
                                \vimFuncVar,
                                \vimOper,
                                \vimOper_brackeT,
                                \vimNumber,
                                \vimStr,
                                \vimType,
                                \vimRegister,
                                \vimContinue,
                                \vimVar,
                                \vimContinue,
                                \vimTailCmt,
                                \vimLineCmt,
                                \vimLineCmt2,
                                \Vim_com_delI
"\ vimOper
                     "\     " \zs||\|&&\|[-+.!]\ze "  前后多出来空格
    syn match    vimOper        "||\|&&\|[-+.!]"
                        \ skipwhite   nextgroup=vimStr,vimSpecFile

    syn match    vimOper       "\%#=1\(==\|!=\|>=\|<=\|=\~\|!\~\|>\|<\|=\|!\~#\)[?#]\{0,2}"
                        \ skipwhite  nextgroup=vimStr,vimSpecFile

    syn match    vimOper      "\v(<is|<isnot)[?#]{0,2}>"
                        \ skipwhite   nextgroup=vimStr,vimSpecFile

"\ ()和{}
    hi  def  link vimParenSep   Delimiter
    syn region  vimOper_brackeT
                    \ matchgroup=vimParenSep
                    \ start="("
                      \ end=")"
                    \ keepend
                    \ contains=vimoperStar,@vimIn_Oper_cluS
                              "\ 它自己也在vimIn_Oper_cluS里
                              "\ 可以递归?

    syn match vimComma_in_Oper  #,$#  conceal

    hi def link   vimDict_sep  Delimiter
    syn region   vimOper_brackeT
                    \ matchgroup=vimDict_sep
                    \ start="#\?{"
                      \ end="}"
                    \ nextgroup=vimVar,vimFuncVar
                    \ contains=@vimIn_Oper_cluS,vimComma_in_Oper

    if  !exists("g:vimsyn_noerror")
    \ && !exists("g:vimsyn_noopererror")
        syn match  vimOperError    ")"
    en

