
" Synchronize (speed)
    " 接收并重命名 某些Deprecated variable options
    "\ 新版的全是vimsyn_xxxx
    if exists("g:vim_minlines")  | let g:vimsyn_minlines= g:vim_minlines  | en
                      if exists("g:vimsyn_minlines")  | exe "syn sync minlines=" . g:vimsyn_minlines  | en

    if exists("g:vim_maxlines")
        let g:vimsyn_maxlines = g:vim_maxlines
        " Variable options
        let s:vimsyn_maxlines = g:vim_maxlines
    el
        let s:vimsyn_maxlines = 60
    en
    exe  "syn sync maxlines=" . s:vimsyn_maxlines

    if exists("g:vimsyntax_noerror")  | let g:vimsyn_noerror= g:vimsyntax_noerror  | en

    syn   sync linecont "^\s\+\\"
    syn   sync match vimAugroupSyncA
                     \ groupthere
                     \ NONE
                     \ #\<aug\%[roup]\>\s\+[eE][nN][dD]#


" Highlighting:
    syn cluster vimHi_Clus     contains=vimHiLink,
                                    \vimHiClear,
                                    \vimHiKeyList,
                                    \vimTailCmt

    if !exists("g:vimsyn_noerror") && !exists("g:vimsyn_novimhictermerror")
        syn match   vimHiCtermError contained   "\D\i*"
    en

    syn match   vimHighlight
        \ #\<hi\%[ghlight]\> \+#
        \ skipwhite   nextgroup=vimHiBang,@vimHi_Clus
        \ conceal

    syn match   vimHiBang
        \ #!#
        \ contained
        \ skipwhite   nextgroup=@vimHi_Clus

    hi def link vimHiGroup              vimGroupName
    syn match   vimHiGroup  contained   #\i\+#
    syn case ignore
    syn keyword vimHiAttrib
       \ contained
       \ none
       \ bold
       \ inverse
       \ italic
       \ nocombine
       \ reverse
       \ standout
       \ strikethrough
       \ underline
       \ underlineline
       \ undercurl
       \ underdot
       \ underdash
    syn keyword vimFgBgAttrib
       \ contained
       \ none
       \ bg
       \ background
       \ fg
       \ foreground
    syn case match

    syn match   vimHiAttribList contained   "\i\+"  contains=vimHiAttrib
    syn match   vimHiAttribList contained   "\i\+,"he=e-1
                                                \ contains=vimHiAttrib
                                                \ nextgroup=vimHiAttribList

    syn case ignore
    syn keyword vimHiCtermColor
            \ contained
            \ black
            \ blue
            \ brown
            \ cyan
            \ darkblue
            \ darkcyan
            \ darkgray
            \ darkgreen
            \ darkgrey
            \ darkmagenta
            \ darkred
            \ darkyellow
            \ gray
            \ green
            \ grey
            \ grey40
            \ grey50
            \ grey90
            \ lightblue
            \ lightcyan
            \ lightgray
            \ lightgreen
            \ lightgrey
            \ lightmagenta
            \ lightred
            \ lightyellow
            \ magenta
            \ red
            \ seagreen
            \ white
            \ yellow

    syn match   vimHiCtermColor contained   "\<color\d\{1,3}\>"

    syn case match
    syn   match   vimHiFontname      contained   #[a-zA-Z\-*]\+#
    syn   match   vimHiGuiFontname   contained   #'[a-zA-Z\-*   ]\+'#
    syn   match   vimHiGuiRgb        contained   "#\x\{6}"

" Highlighting: hi group key=arg ...
    syn cluster vimHi_Area
                        \ contains=vimGroup,
                          \vimHiBlend,
                          \vimHiGroup,
                          \vimHiTerm,
                          \vimHiCTerm,
                          \vimHiStartStop,
                          \vimHiCtermFgBg,
                          \vimHiCtermul,
                          \vimHiGui,
                          \vimHiGuiFont,
                          \vimHiGuiFgBg,
                          \vimHiKeyError,
                          \vimNotation

    syn region  vimHiKeyList
                        \ contained
                        \ contains=@vimHi_Area
                        \ start=#\i\+#
                            \ skip=#\\\\\|\\|#
                        \ end=#$\||#
                        \ oneline

    if !exists("g:vimsyn_noerror") && !exists("g:vimsyn_vimhikeyerror")
        syn match   vimHiKeyError   contained   "\i\+="he=e-1
    en

    syn   match   vimHiTerm        contained   #\cterm=#he=e-1              nextgroup=vimHiAttribList
    syn   match   vimHiStartStop   contained   #\c\(start\|stop\)=#he=e-1      nextgroup=vimHiTermcap,vimOption
    syn   match   vimHiCTerm       contained   #\ccterm=#he=e-1             nextgroup=vimHiAttribList

    syn   match   vimHiCtermFgBg   contained   #\ccterm[fb]g=#he=e-1        nextgroup=vimHiNmbr,
                                                                            \vimHiCtermColor,
                                                                            \vimFgBgAttrib,
                                                                            \vimHiCtermError

    syn   match   vimHiCtermul     contained   #\cctermul=#he=e-1           nextgroup=vimHiNmbr,
                                                                            \vimHiCtermColor,
                                                                            \vimFgBgAttrib,
                                                                            \vimHiCtermError

    syn   match   vimHiGui         contained   #\cgui=#he=e-1               nextgroup=vimHiAttribList
    syn   match   vimHiGuiFont     contained   #\cfont=#he=e-1              nextgroup=vimHiFontname

    syn   match   vimHiGuiFgBg    contained   #\cgui\%([fb]g\|sp\)=#he=e-1    nextgroup=vimHiGroup,
                                                                          \vimHiGuiFontname,
                                                                          \vimHiGuiRgb,
                                                                          \vimFgBgAttrib
    syn   match   vimHiTermcap   contained   #\S\+#             contains=vimNotation
    syn   match   vimHiBlend     contained   #\cblend=#he=e-1   nextgroup=vimHiNmbr
    syn   match   vimHiNmbr      contained   #\d\+#

" Highlight: clear
    syn   keyword  vimHiClear  contained   clear   nextgroup=vimHiGroup

" Highlight: link
    " see tst24 (hi def vs hi) (Jul 06, 2018)
    "\ syn region vimHiLink   contained oneline matchgroup=vimCommand start="\(\<hi\%[ghlight]\s\+\)\@<=\(\(def\%[ault]\s\+\)\=link\>\|\<def\>\)" end="$" contains=vimHiGroup,vimGroup,vimHLGroup,vimNotation


    "\
    syn  region   vimHiLink
                \ contained  contains=@vimHi_Area
                \ oneline
                \ matchgroup=vimHiLink_start
                    \ start=#\(\<hi\%[ghlight]\s\+\)\@<=\(\(def\%[ault]\s\+\)\=link\>\|\<def\>\)#
                    \ end="$"

    "\ 想用这些封印hi def link, 失败
        "\ syn match  vimHiLink_start
        "\     \ #\(\<hi\%[ghlight]\s\+\)\@<=\(\(def\%[ault]\s\+\)\=link\>\|\<def\>\)#
        "\ "\       "\ 这行就是下面的start
        "\     \ contained   containedin=vimHiLink
        "\     \ conceal cchar=🜺


        "\ concealends配合ccahr不生效
        "\ syn  region   vimHiLink
        "\             \ contained  contains=@vimHi_Area
        "\             \ oneline
        "\             \ concealends cchar=🜺
        "\             \ matchgroup=vimHiLink_start
        "\                 \ start=#\(\<hi\%[ghlight]\s\+\)\@<=\(\(def\%[ault]\s\+\)\=link\>\|\<def\>\)#
        "\                 \ end="$"

    syn cluster vimIn_func_cluS add=vimHiLink
