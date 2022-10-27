"\ vimIn_func_cluS用于下面这里:
    "\ syn region  vimFuncBody
        "\ .......
        "\ \ contains=@vimIn_func_cluS

syn cluster vimIn_func_cluS contains=vimAbb,
                             \vimAddress,
                             \vimAugroupKey,
                             \vimAutoCmd,
                             \vimCmplxRepeat,
                             \vimTailCmt,
                             \vimContinue,
                             \vimCtrlChar,
                             \vimEcho,
                             \vimEchoHL,
                             \vimEnvvar,
                             \vimExecute,
                             \vimFBVar,
                             \vimFunc,
                             \vimFuncDef,
                             \vimFuncVar,
                             \vimGlobal,
                             \vimHighlight,
                             \vimLet,
                             \vimLetHereDoc,
                             \vimLineCmt,
                             \vimLineCmt2,
                             \vimMap,
                             \vimMark,
                             \vimNorm,
                             \vimNotation,
                             \vimNotFunc,
                             \vimNumber,
                             \vimOper,
                             \vimOper_brackeT,
                             \vimRegion,
                             \vimRegister,
                             \vimSearch,
                             \vimSet,
                             \vimSpecFile,
                             \vimStr,
                             \vimSubst,
                             \vimSynLine,
                             \vimUnmap,
                             \vimUserCommand

"\ vimFuncDef
    syn cluster vimFuncDef_cluS
                         \  contains=vimCommand,
                            \vimFunctionError,
                            \vimFuncKey,
                            \vimFuncSID,
                            \Tag
                                " Tag is provided for those who wish to highlight tagged functions

    syn match   vimFuncDef
                \ "\<\(fu\%[nction]\)!\=\s\+\%(<[sS][iI][dD]>\|[sSgGbBwWtTlL]:\)\=\%(\i\|[#.]\|{.\{-1,}}\)*\ze\s*("
                \ contains=@vimFuncDef_cluS
                \ nextgroup=vimFuncBody

        "\ <[sS][iI][dD]> 是淘汰了的?
        "\ ref:
        "\ https://cs.github.com/Shougo/unite.vim/blob/b08814362624ded3b462addba4711647879ca308/autoload/unite/kinds/command.vim#L51

            "\ " For function.
            "\     " let prototype_name = matchstr(a:candidate.action__description,
            "\     "       \'\%(<[sS][iI][dD]>\|[sSgGbBwWtTlL]:\)\='
            "\     "       \'\%(\i\|[#.]\|{.\{-1,}}\)*\s*(\ze\%([^(]\|(.\{-})\)*$')
            "\
            "\     let prototype_name = matchstr(a:candidate.action__description,
            "\           \'\<\%(\d\+\)\?\zs\h\w*\ze!\?\|'
            "\           \'\<\%([[:digit:],[:space:]$''<>]\+\)\?\zs\h\w*\ze/.*')

    "\ leo concealed
    "\ 写个leo concealed 当作记号, 方便以后抽取所有我定义的conceal
    "\ 这个pattern来自上面的vimFuncDef, 把\ze挪到function!后
                                                 "\ sSgGbBwWtTlL匹配¿b:¿等scope
    syn match   vimFuncDef_hidE   "\<fu\%[nction]!\=\ze\s\+\%([sSgGbBwWtTlL]:\)\=\%(\i\|[#.]\|{.\{-1,}}\)*\s*("
                \ contains=@vimFuncDef_cluS
                \ nextgroup=vimFuncBody
                \ conceal cchar=£
        "\ 有点问题: function! 能被封印, function不行
        "\ 加了这行也 无济于事:
            "\ syn match   vimFuncDef_hidE   "\<fu\%[nction] .....

    "\ vim9?
    syn match   vimFuncDef
            \ "\<def!\=\ze\s*("
            \ contains=@vimFuncDef_cluS
            \ nextgroup=vimFuncBody

if  exists("g:vimsyn_folding")
\ && g:vimsyn_folding =~# 'f'
    syn region  vimFuncBody
                \ start="\ze\s*("
                    \ matchgroup=vimCommand
                    \ end="\<\(endf\|endfu\%[nction]\|enddef\)\>"
                \ contained   contains=@vimIn_func_cluS,@In_fancY
                \ fold
                    "\  下面一块只少了这个fold
el
    syn region  vimFuncBody
                \ start="\ze\s*("
                    \ matchgroup=vimCommand
                    \ end="\<\(endf\|endfu\%[nction]\|enddef\)\>"
                \ contained   contains=@vimIn_func_cluS,@In_fancY
                 "\ 没找到谁contains了vimFuncBody,  但删掉contained会导致 有的东西无法conceal
en

syn match   vimFuncVar   contained  "\va:(\K\k*|\d+)"
                             "\ ¿a:¿any_arg  a:000  a:1
syn match   vimFuncSID   contained  "\c<sid>\|\<s:"

syn keyword vimFuncKey   contained  fu[nction]
                                "\ \ conceal   cchar=£
                                "\ \ containedin=vimFuncDef,@vimFuncDef_cluS,vimFuncBody
                                  "\ 无法conceal

syn match   vimFuncBlank contained  "\s\+"

"\ 没地方用vimPattern啊
syn keyword vimPattern
                \ start
                \ skip
                \ end
                \ contained

" vimTypes : new for vim9
    syn match   vimType ":\s*\zs\<\(bool\|number\|float\|string\|blob\|list<\|dict<\|job\|channel\|func\)\>"


