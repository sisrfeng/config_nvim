"\ comments
    syn keyword vimTodo
        \ contained
        \ COMBAK
        \ FIXME
        \ TODO
        \ XXX
    "\ 放着方便搜索:   vimComment/ vimLineComment
    syn cluster vimCmts
                \ contains=vimTodo,
                    \@Spell,
                  \vimTailCmt,
                  \vimLineCmt,
                  \vimLineCmt2


" Special and plugin vim commands
    syn match   vimCommand     contained    "\<z[-+^.=]\=\>"
    syn keyword vimOnlyCommand contained    fix[del] op[en] sh[ell] P[rint]
    syn keyword vimStdPlugin   contained    DiffOrig Man N[ext] S TOhtml XMLent XMLns




" Special Vim Highlighting (not automatic)

" commands not picked up by the ¿generator¿ (due to non-standard format)
    syn keyword vimCommand contained    py3

" Numbers
    syn match vimNumber '\<\d\+\%(\.\d\+\%([eE][+-]\=\d\+\)\=\)\=' skipwhite   nextgroup=
        \vimGlobal,vimSubst,vimCommand,vimTailCmt

    syn match vimNumber '-\d\+\%(\.\d\+\%([eE][+-]\=\d\+\)\=\)\='  skipwhite   nextgroup=
        \vimGlobal,vimSubst,vimCommand,vimTailCmt

    syn match vimNumber '\<0[xX]\x\+'    skipwhite   nextgroup=
        \vimGlobal,vimSubst,vimCommand,vimTailCmt

    syn match vimNumber '\%(^\|\A\)\zs#\x\{6}'                     skipwhite nextgroup=
        \vimGlobal,vimSubst,vimCommand,vimTailCmt

    syn match vimNumber '\<0[zZ][a-zA-Z0-9.]\+'                    skipwhite nextgroup=
        \vimGlobal,vimSubst,vimCommand,vimTailCmt

    syn match vimNumber '0[0-7]\+'             skipwhite nextgroup=vimGlobal,vimSubst,vimCommand,vimTailCmt

    syn match vimNumber '0[bB][01]\+'              skipwhite nextgroup=vimGlobal,vimSubst,vimCommand,vimTailCmt

    syn match vimCmdSep "[:|]\+"    skipwhite nextgroup=vimAddress,
                                                        \vimAutoCmd,
                                                        \vimEcho,
                                                        \vimIsCommand,
                                                        \vimExtCmd,
                                                        \vimFilter,
                                                        \vimLet,
                                                        \vimMap,
                                                        \vimMark,
                                                        \vimSet,
                                                        \vimSyntax,
                                                        \vimUserCmd
    syn match vimIsCommand  "\v<\h\w*>"   contains=vimCommand
                                "\ \h: head of word character, (排除掉\w里的数字等)

    syn match vimVar          contained "\<\h[a-zA-Z0-9#_]*\>"
    syn match vimVar        "\<[bwglstav]:\h[a-zA-Z0-9#_]*\>"
    syn match vimVar            "\s\zs&\a\+\>"
    syn match vimFBVar      contained   "\<[bwglstav]:\h[a-zA-Z0-9#_]*\>"

    syn keyword vimCommand   contained   in

"
if &buftype != 'nofile'
"   (buftype != nofile  avoids having append, change, insert show up in the command window)
    syn region vimInsert    matchgroup=vimCommand start="^[: \t]*\(\d\+\(,\d\+\)\=\)\=a\%[ppend]$"  end="^\.$""     matchgroup=vimCommand
    syn region vimInsert    matchgroup=vimCommand start="^[: \t]*\(\d\+\(,\d\+\)\=\)\=c\%[hange]$"  end="^\.$""     matchgroup=vimCommand
    syn region vimInsert    matchgroup=vimCommand start="^[: \t]*\(\d\+\(,\d\+\)\=\)\=i\%[nsert]$"  end="^\.$""     matchgroup=vimCommand
en

" Behave!
    syn match   vimBehave
                        \ "\<be\%[have]\>"
                        \ skipwhite
                        \ nextgroup=vimBehaveModel,vimBehaveError

    syn keyword vimBehaveModel
                            \ contained
                            \ mswin
                            \ xterm

    if  !exists("g:vimsyn_noerror")
  \ && !exists("g:vimsyn_nobehaveerror")
        syn match   vimBehaveError contained     #\s\+#
    en

" Filetypes
    syn match   vimFiletype
        \ "\<filet\%[ype]\(\s\+\I\i*\)*"
        \ skipwhite
        \ contains=vimFTCmd,vimFTOption,vimFTError

    if  !exists("g:vimsyn_noerror")
  \ && !exists("g:vimsyn_vimFTError")
        syn match   vimFTError  contained   "\I\i*"
    en
    syn keyword vimFTCmd    contained   filet[ype]
    syn keyword vimFTOption contained   detect indent off on plugin

" Augroup : vimAugroupError removed because
         " long augroups caused sync'ing problems.
    " Trade-off:
        " Increasing synclines with slower editing
        " vs
        " augroup END error checking.
    syn cluster vimAugroupList  contains=vimAugroup,
                                        \vimIsCommand,
                                        \vimUserCmd,
                                        \vimExecute,
                                        \vimNotFunc,
                                        \vimFuncName,
                                        \vimFuncDef,
                                        \vimFunctionError,
                                        \vimLineCmt,
                                        \vimLineCmt2,
                                        \vimNotFunc,
                                        \vimMap,
                                        \vimSpecFile,
                                        \vimOper,
                                        \vimNumber,
                                        \vimOper_brackeT,
                                        \vimStr,
                                        \vimSubst,
                                        \vimMark,
                                        \vimRegister,
                                        \vimAddress,
                                        \vimFilter,
                                        \vimCmplxRepeat,
                                        \vimTailCmt,
                                        \vimLet,
                                        \vimSet,
                                        \vimAutoCmd,
                                        \vimRegion,
                                        \vimSynLine,
                                        \vimNotation,
                                        \vimCtrlChar,
                                        \vimFuncVar,
                                        \vimContinue,
                                        \vimSetEqual,
                                        \vimOption

    if exists("g:vimsyn_folding") && g:vimsyn_folding =~# 'a'
        syn region  vimAugroup
            \ fold
            \ matchgroup=vimAugroupKey
                \ start="\<aug\%[roup]\>\ze\s\+\K\k*"
                \ end="\<aug\%[roup]\>\ze\s\+[eE][nN][dD]\>"
            \ contains=vimAutoCmd,@vimAugroupList
    el
        syn region  vimAugroup
         \ matchgroup=vimAugroupKey
         \ start="\<aug\%[roup]\>\ze\s\+\K\k*"
         \ end="\<aug\%[roup]\>\ze\s\+[eE][nN][dD]\>"
            \ contains=vimAutoCmd,@vimAugroupList
    en

    syn match   vimAugroup  "aug\%[roup]!"  contains=vimAugroupKey

    if !exists("g:vimsyn_noerror") && !exists("g:vimsyn_noaugrouperror")
        syn match   vimAugroupError "\<aug\%[roup]\>\s\+[eE][nN][dD]\>"
    en
    syn keyword vimAugroupKey contained aug[roup]

