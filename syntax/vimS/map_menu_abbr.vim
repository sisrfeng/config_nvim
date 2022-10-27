" Maps:
    " ====
    syn match   vimMap
        \ "\<map\>!\=\ze\s*[^(]"
        \ skipwhite nextgroup=vimMapMod,vimMapLhs

    syn keyword vimMap
        \ cm[ap]
        \ cno[remap]
        \ im[ap]
        \ ino[remap]
        \ lm[ap]
        \ ln[oremap]
        \ nm[ap]
        \ nn[oremap]
        \ no[remap]
        \ om[ap]
        \ ono[remap]
        \ smap
        \ snor[emap]
        \ tno[remap]
        \ tm[ap]
        \ vm[ap]
        \ vmapc[lear]
        \ vn[oremap]
        \ xm[ap]
        \ xn[oremap]
        \ skipwhite nextgroup=vimMapBang,vimMapMod,vimMapLhs

    syn keyword nvimMap
        \ tn[oremap]
        \ tm[ap]
        \ skipwhite nextgroup=vimMapBang,vimMapMod,vimMapLhs

    syn keyword vimMap
        \ mapc[lear]
        \ smapc[lear]

    syn keyword vimUnmap
            \ cu[nmap]
            \ iu[nmap]
            \ lu[nmap]
            \ nun[map]
            \ ou[nmap]
            \ sunm[ap]
            \ unm[ap]
            \ unm[ap]
            \ vu[nmap]
            \ xu[nmap]
            \ skipwhite nextgroup=vimMapBang,vimMapMod,vimMapLhs

    syn keyword nvimUnmap
        \ tunm[ap]
        \ skipwhite nextgroup=vimMapBang,vimMapMod,vimMapLhs

    syn match   vimMapLhs
                \ contained
                \ "\S\+"
                \ contains=vimNotation,vimCtrlChar
                \ skipwhite nextgroup=vimMapRhs

    syn match   vimMapBang
                \ contained
                \ "!"
                \ skipwhite nextgroup=vimMapMod,vimMapLhs

    syn case ignore
    syn keyword vimMapModKey contained
                        \ buffer
                        \ expr
                        \ leader
                        \ localleader
                        \ nowait
                        \ plug
                        \ script
                        \ sid
                        \ silent
                        \ unique
    syn case match

    "\ 搞个map 或者cnoabbr, 方便toggle?
    let g:conceal_map_mod = 1

    if g:conceal_map_mod == 1
        syn match   vimMapMod
                    \ contained
                    \ "%#=1\v\c\<(expr|(local)=leader|nowait|plug|script|sid|unique|silent)+\>"
                    \ contains=vimMapModKey,vimMapModErr
                    \ skipwhite nextgroup=vimMapMod,vimMapLhs
    el
        syn match   vimMapMod
                    \ "%#=1\v\c\<(expr|(local)=leader|nowait|plug|script|sid|unique|silent)+\>"
                    \ contains=vimMapModKey,vimMapModErr
                    \ skipwhite nextgroup=vimMapMod,vimMapLhs
                    \ contained  conceal
    en



    syn match   vimMapRhs
                \ contained
                \ ".*"
                \ contains=vimNotation,vimCtrlChar
                \ skipnl
                \ nextgroup=vimMapRhsExtend

    syn match   vimMapRhsExtend
                    \ contained
                    \ "^\s*\\.*$"
                    \ contains=vimContinue

" Abbreviations:
    syn keyword vimAbb
            \ ab[breviate]
            \ ca[bbrev]
            \ inorea[bbrev]
            \ cnorea[bbrev]
            \ norea[bbrev]
            \ ia[bbrev]
            \ skipwhite nextgroup=vimMapMod,vimMapLhs

" Menus:
    syn cluster vimMenuList
        \ contains=vimMenuBang,vimMenuPriority,vimMenuName,vimMenuMod
    syn keyword vimCommand
        \ am[enu]
        \ an[oremenu]
        \ aun[menu]
        \ cme[nu]
        \ cnoreme[nu]
        \ cunme[nu]
        \ ime[nu]
        \ inoreme[nu]
        \ iunme[nu]
        \ me[nu]
        \ nme[nu]
        \ nnoreme[nu]
        \ noreme[nu]
        \ nunme[nu]
        \ ome[nu]
        \ onoreme[nu]
        \ ounme[nu]
        \ unme[nu]
        \ vme[nu]
        \ vnoreme[nu]
        \ vunme[nu]
        \ skipwhite nextgroup=@vimMenuList
    syn match   vimMenuName
                    \ "[^ \t\\<]\+"
                    \ contained nextgroup=vimMenuNameMore,vimMenuMap
    syn match   vimMenuPriority
                    \ "\d\+\(\.\d\+\)*"
                    \ contained
                    \ skipwhite nextgroup=vimMenuName
    syn match   vimMenuNameMore
                    \ "\c\\\s\|<tab>\|\\\."
                    \ contained
                    \ nextgroup=vimMenuName,vimMenuNameMore
                    \ contains=vimNotation

    syn match   vimMenuMod
            \ contained
            \ "\c<\(script\|silent\)\+>"
            \ skipwhite
            \ contains=vimMapModKey,vimMapModErr
            \ nextgroup=@vimMenuList

    syn match   vimMenuMap  "\s"    contained skipwhite nextgroup=vimMenuRhs
    syn match   vimMenuRhs  ".*$"   contained contains=vimStr,vimTailCmt,vimIsCommand
    syn match   vimMenuBang "!" contained skipwhite nextgroup=@vimMenuList

