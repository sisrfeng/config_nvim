syn match   vimGroups  #@\?[^ \t,]*#     contained   contains=vimGROUP,vimBar
syn match   vimGroups  #@\?[^ \t,]*,#    contained   contains=vimGROUP,vimBar   nextgroup=vimGroups

syn keyword vimGROUP
            \ contained
                \ ALL
                \ ALLBUT
                \ CONTAINED
                \ TOP

if !exists("g:vimsyn_noerror")
"\ 不属于其他group的此类pattern, 一概视作error?
    syn match   vimSynError contained   #\i\+#
    syn match   vimSynError contained   #\i\+=# nextgroup=vimGroups
en

syn   match   vimSyn_contain   #contained#     contained   conceal   cchar=♀   nextgroup=vimGroups
syn   match   vimSyn_contain   #\<contains=#    contained   conceal   cchar=⊇   nextgroup=vimGroups
syn match   vimSyn_containedin  #\<containedin=#        contained  nextgroup=vimGroups
syn match   vimSyn_nextgroup    #nextgroup=#           contained  nextgroup=vimGroups

syn match   vimSyntax   #\<sy\%[ntax]\> \+#
                            \ contains=vimCommand
                            \ skipwhite   nextgroup=vimSynType,vimTailCmt
                            \ conceal

syn match   vimAuSyntax   #\s+sy\%[ntax]#
                            \ contained
                            \ contains=vimCommand
                            \ skipwhite
                            \ nextgroup=vimSynType,vimTailCmt

syn cluster vimIn_func_cluS   add=vimSyntax


" syn-case
    syn keyword   vimSynType   case
                                \ contained
                                \ skipwhite
                                \ nextgroup=vimSynCase,vimSynCaseError

    syn cluster vimIn_func_cluS   add=vimSynType

    if !exists("g:vimsyn_noerror") && !exists("g:vimsyn_novimsyncaseerror")
        syn match   vimSynCaseError contained   "\i\+"
    en
    syn keyword vimSynCase  ignore  match  contained

" syn-clear
    syn keyword vimSynType  clear
                            \ contained
                            \ skipwhite
                            \ nextgroup=vimGroups

    syn cluster vimIn_func_cluS   add=vimSynType  "\ 每次改了SynType, 都要加这行?

" syn-cluster
    syn keyword vimSynType   cluster
                            \ contained
                            \ skipwhite   nextgroup=vimClusterName

    syn match  vimClusterName
                    \ "\h\w*"
                    \ contained
                    \ skipwhite   nextgroup=vimClus_Area

    "\ vimGroupname第一次出现就在这里
    hi   def   link   vimGroupName            vimGroup
    hi   def   link   vimClus_Area_end      Delimiter
    syn region  vimClus_Area
                    \ matchgroup=vimGroupName
                    \ start="\h\w*"
                        \ skip="\\\\\|\\|"
                    \ matchgroup=vimClus_Area_end
                    \ end="|\|$"
                    \ contained   contains=vimGroupAdd,
                                  \vimGroupRm,
                                  \vimSyn_contain,
                                  \vimSynError

    syn match   vimGroupAdd  'add='
                                \ contained
                                \ nextgroup=vimGroups

    syn match   vimGroupRm  'remove='
                                \ contained
                                \ nextgroup=vimGroups

    syn cluster vimIn_func_cluS add=vimSynType,
                                    \vimGroupAdd,
                                    \vimGroupRm

" syn-iskeyword
    syn keyword vimSynType   iskeyword
                                        \ contained
                                        \ skipwhite
                                        \ nextgroup=vimIskList

    syn match   vimIskList  '\S\+'
                                \ contained
                                \ contains=vimIskSep

    syn match   vimIskSep   contained   ','

" syn-include
    syn keyword vimSynType   include
                            \ contained
                            \ skipwhite
                            \ nextgroup=vimGroups

    syn cluster vimIn_func_cluS add=vimSynType


" syn-off and on
    syn keyword vimSynType  contained
                            \ enable
                            \ on
                            \ reset
                            \ manual
                            \ off
                            \ list


"\ 3种syntax类型
    " syn-keyword
        syn cluster vimSynKeyGroup  contains=vimSyn_nextgroup,
                                            \vimSynKeyOpt,
                                            \vimSyn_containedin

        syn keyword vimSynType   keyword
            \ contained
            \ skipwhite
            \ nextgroup=vimSynKey_Names

            hi def  link   vimKey_Names_end        Delimiter
            syn region  vimSynKey_Names
                            \ contained
                            \ keepend
                            \ oneline
                                \ matchgroup=vimGroupName
                                \ start="\h\w*"
                            \ skip="\\\\\|\\|"
                                \ matchgroup=vimKey_Names_end
                                \ end="|\|$"
                            \ contains=@vimSynKeyGroup


        syn match   vimSynKeyOpt
                \  "\%#=1\<\(conceal\|contained\|transparent\|skipempty\|skipwhite\|skipnl\)\>"
                \ contained

        syn cluster vimIn_func_cluS add=vimSynType

    " syn-match
        syn keyword vimSynType   match
                            \ contained
                            \ skipwhite  nextgroup=vimSynMatch_Gname

        syn cluster vimSynMatch_cluS
                    \ contains=vimMatchComment,
                    \vimSyn_contain,
                    \vimSynError,
                    \vimSyn_MatchOpt,
                    \vimSyn_nextgroup,
                    \vimNotation

                    "\ 之前这个cluster里 放了vimSynRegionPat, 放错了吧, 现在删了


        hi def link  vimSynMatch_Gname  vimGroupName
        syn match  vimSynMatch_Gname #\h\w*#
                                \ skipwhite   nextgroup=vimSynMatchOpt
                                \ contained
                                "\ 不加contained导致很多都被匹配为vimSynMatch_Gname

        "\ hi def  link   vimMatch_end        DebuG

        "\ 用于syn cluster  Have_regeX里:
        syn region  vimSynMatch_Area
                        \ contained  contains=@vimSynMatch_cluS
                            \ keepend
                            \ matchgroup=vimGroupName
                                \ start="\h\w*"
                            \ matchgroup=vimMatch_end
                                \ end="|\|$"
                                "\ 为啥以¿|¿分隔?
                                "\ groupname还可以有多个?
                                    "\ \ ¿end=" "¿ 导致contained等被识别为iscommand

        syn cluster vimIn_func_cluS add=@vimSynMatch_cluS


        syn match   vimSynMatchOpt
                        \ contained
                        \ "\%#=1\<\(conceal\|
                                \transparent\|
                                \contained\|
                                \excludenl\|
                                \keepend\|
                                \skipempty\|
                                \skipwhite\|
                                \display\|
                                \extend\|
                                \skipnl\|
                                \fold\)\>"

        syn match   vimSynMatchOpt  #\<cchar=#
                                \ contained
                                \ nextgroup=vimSynMatch_cchar

                                    syn match   vimSynMatch_cchar  contained   '\S'


    " syn-region
        syn keyword vimSynType    region
            \ contained
            \ skipwhite
            \ nextgroup=vimSynRegion_Name

            "\ syn region  vimSynRegion_Name 依赖于它:
            syn cluster vimSynRegion_Group  contains=vimSyn_contain,
                                                \vimSyn_nextgroup,
                                                \vimSynRegionOpt,
                                                \vimSynRegion_SSE,
                                                \vimSynMatchGrp

            syn region  vimSynRegion_Name
                    \ contained
                    \ contains=@vimSynRegion_Group
                    \ keepend
                    \ matchgroup=vimGroupName
                        \ start="\h\w*"
                            \ skip="\\\\\|\\|"
                        \ end="|\|$"

                            "\ 这个没在end前另外指定matchgroup, 但SynMatch等有, 为啥?

        "\ matchgroup用于:syntax region, 控制start和end的highlight
        " 而非:syntax match
        hi   def   link   vimSynMatchGrp           vimSynOption
        hi   def   link   vimSynMatchOpt           vimSynOption
        hi   def   link   vimSyn_nextgroup         vimSynOption

        syn match   vimSynMatchGrp      "matchgroup="
                                        \ contained
                                        \ nextgroup=vimGroup,
                                                    \vimHLGroup,
                                                    \vimOnlyHLGroup,
                                                    \nvimHLGroup


        hi   def   link   vimSynRegionOpt            vimSynOption
        syn match   vimSynRegionOpt    contained
        \ "\%#=1\<\(conceal\(ends\)\=\|
                \transparent\|
                \contained\|
                \excludenl\|
                \skipempty\|
                \skipwhite\|
                \display\|
                \keepend\|
                \oneline\|
                \extend\|
                \skipnl\|
                \fold\)\>"

                "\ Start Skip End
        syn match   vimSynRegion_SSE   "\(start\|skip\|end\)="he=e-1
                                    \ contained
                                    \ nextgroup=vimSynRegionPat

        hi   def   link   vimSynRegion_SSE               Type

        syn cluster vimSynRegionPat_cluS   contains=vimBar,
                                            \vimSynPatRange,
                                            \vimSynNotPatRange,
                                            \vimRightParen,
                                            \vimNotation
                                            "\ 这几个是?
                                            \vimSubs129,
                                            \vimTwoBs,
                                            \vimInParen_z,

                "\ 原名SynRegPat
        syn region  vimSynRegionPat
                        \ contained  contains=@vimSynRegionPat_cluS
                        \ extend
                        \ start="\z([-`~!@#$%^&*_=+;:'",./?]\)"
                        "\ \ start=|\z([-`~!@#$%^&*_=+;:'",./?]\)|  , 官方用的是双引号 包裹这串字符(双引号包着双引号, 不用escape?)
                            \ skip=#\\\\\|\\\z1#
                        \ end=#\z1#
                        \ skipwhite   nextgroup=vimSynPat_offset,vimSynRegion_SSE
                "\ 之前, syn cluster vimSynMatch_cluS 放了vimSynRegionPat,
                                "\ 导致如果这里不加 oneline
                                "\ SynRegionPat可能横跨多行
                                "\ (表现为很多地方高亮为string)
                "\ syn cluster vimSynMatch_cluS 里去掉了vimSynRegionPat, 这里就不用加oneline?



        hi   def   link   vimSynRegionPat            vimStr

        syn match   vimSynPat_offset    contained
                            \ "\%#=1\(hs\|ms\|me\|hs\|he\|rs\|re\)=[se]\([-+]\d\+\)\="
                                    "\ 为啥2个hs?
                                                                                    "\ 差了个逗号
        syn match   vimSynPat_offset    contained
                            \ "\%#=1\(hs\|ms\|me\|hs\|he\|rs\|re\)=[se]\([-+]\d\+\)\=,"
                            \ nextgroup=vimSynPat_offset

        "\ lc: Leading context, 被淘汰了
            syn match   vimSynPat_offset    contained   "lc=\d\+"
            syn match   vimSynPat_offset    contained   "lc=\d\+," nextgroup=vimSynPat_offset

        syn region  vimSynPatRange
                                    \ contained
                                \ start="\["
                                \ skip="\\\\\|\\]"
                                \ end="]"

        syn match   vimSynNotPatRange    "\\\\\|\\\["       contained
        syn match   vimMatchComment       #"[^"]\+$#     contained


"\ syn-sync
    syn keyword vimSynType   sync
                            \ contained
                            \ skipwhite  nextgroup=vimSyncC,
                                                    \vimSyncLines,
                                                    \vimSyncMatch,
                                                    \vimSyncError,
                                                    \vimSyncLinebreak,
                                                    \vimSyncLinecont,
                                                    \vimSyncRegion

    if !exists("g:vimsyn_noerror") && !exists("g:vimsyn_novimsyncerror")
        syn match  vimSyncError   contained   "\i\+"
                                                " identifier
    en
    syn keyword vimSyncMatch     match       contained    skipwhite   nextgroup=vimSyncGroupName
    syn keyword vimSyncRegion    region      contained    skipwhite   nextgroup=vimSynRegion_SSE
    syn keyword vimSyncC         ccomment   clear   fromstart  contained

    syn match   vimSyncLinebreak  "\<linebreaks="      contained       skipwhite   nextgroup=vimNumber
    syn keyword vimSyncLinecont   linecont            contained       skipwhite   nextgroup=vimSynRegionPat
    syn match   vimSyncLines      "\(min\|max\)\=lines="  contained                   nextgroup=vimNumber

    syn match   vimSyncGroupName contained    "\h\w*"                     skipwhite   nextgroup=vimSyncKey
    syn match   vimSyncKey       contained    "\<groupthere\|grouphere\>" skipwhite   nextgroup=vimSyncGroup
    syn match   vimSyncGroup     contained    "\h\w*"                     skipwhite   nextgroup=vimSynRegionPat,vimSyncNone
    syn keyword vimSyncNone      contained    NONE


