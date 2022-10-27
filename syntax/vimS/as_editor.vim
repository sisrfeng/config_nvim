" Special Filenames, Modifiers, Extension Removal:
    syn match   vimSpecFile      "<c\(word\|WORD\)>"
                                \ nextgroup=vimSpecFileMod,vimSubst

    syn match   vimSpecFile     "<\([acs]file\|amatch\|abuf\)>"
                                    \ nextgroup=vimSpecFileMod,vimSubst

    syn match   vimSpecFile     "\s%[ \t:]"
                                \ms=s+1,
                                \me=e-1
                                    \ nextgroup=vimSpecFileMod,vimSubst

    syn match   vimSpecFile     "\s%$"
                                \ms=s+1
                                    \ nextgroup=vimSpecFileMod,vimSubst

    syn match   vimSpecFile     "\s%<"
                                \ms=s+1,
                                \me=e-1
                                    \ nextgroup=vimSpecFileMod,vimSubst

    syn match   vimSpecFile     "#\d\+\|[#%]<\>"
                                    \ nextgroup=vimSpecFileMod,vimSubst

    syn match   vimSpecFileMod  "\(:[phtre]\)\+"    contained

" User-Specified Commands:
so $nV/syntax/vimS/cmd.vim

" Lower Priority Comments: after some vim commands(行末注释?)
    syn match   vimTailCmt  excludenl
                        \ '\s"[^\-:.%#=*].*$'
                            \lc=1
                            \ contains=@IN_fancY,@vimCmts,vimCmt_Str,

                        " lc=1排除掉行末? 和excludenl重复了?
                        " 排除掉这些, why??
                                "\ "\
                                "\ "-
                                "\ ":
                                "\ ".
                                "\ "%
                                "\ "#
                                "\ "=
                                "\ "*

                                "\ 长这样: ¿endif "xxxx注释¿
    syn match   vimTailCmt  #\<endif\s\+".*$#
                                        \lc=5
                                    \ contains=@vimCmts,
                                            \vimCmt_Str,
                                            \@In_fancY

    syn match   vimTailCmt  #\<else\s\+".*$#
                                    \lc=4
                                    \ contains=@vimCmts,
                                                \vimCmt_Str,
                                                \@In_fancY
                                            "\ 长这样: ¿else "xxxx注释¿

    syn region  vimCmt_Str    contained
                                    \ oneline
                                        \ start=#\v\S\s+"#ms=e
                                        \ end=#"#


" Environment Variables:
    syn match   vimEnvvar   "\$\I\i*"
    syn match   vimEnvvar   "\${\I\i*}"

" In-String Specials:
    " If nothing else matches
    "      try to catch strings
    " (therefore it must precede the others!)
    "\ 为了让后续的syn定义覆盖它
    "\ 放在本文件的靠前部分

    "  vimEscapeBrace 对付 ¿["]¿ 和 ¿[]"]¿
    "   (ie. ¿"s¿ don't terminate string inside [])
    syn region  vimEscapeBrace
                        \ contained
                        \ transparent
                        \ oneline
                                \ start="[^\\]\(\\\\\)*\[\zs\^\=\]\="
                                \ skip="\\\\\|\\\]"
                                \ end="]"me=e-1

    syn match   vimBar          "\\|"   contained
    syn match   vimTwoBs       "\\\\"   contained
                "\ 2 backslash
    syn match   vimRightParen       "\\)"   contained
    syn region  vimInParen
                            \ oneline
                            \ matchgroup=vimPatSepZ
                                \ start="\\%\=\ze("
                                \ skip="\\\\"
                                \ end="\\)\|[^\\]['"]"
                                            "\ 注释?
                            \ contained   contains=@vimStr_cluS

        "\ z表示可以用\z(XXXX)
    syn region  vimInParen_z
                        \ oneline
                        \ transparent
                        \ matchgroup=vimPatSepR
                            \ start="\\[z%]\=("
                            \ end="\\)"
                        \ contained   contains=@vimSubs_cluS


    syn cluster vimStr_cluS  contains=vimEscapeBrace,
                                  \vimBar,
                                  \vimTwoBs,
                                  \vimRightParen,
                                  \vimInParen,
                                  \@Spell

    syn region  vimStr
                    \ oneline
                    \ keepend
                    \ start=#[^a-zA-Z>!\\@]"#lc=1
                            \ skip=#\\\\\|\\"#
                    \ end=#"#
                    \ matchgroup=vimStrEnd
                    \ contains=@vimStr_cluS

    syn region  vimStr
                \ oneline
                \ keepend
                \ start=#[^a-zA-Z>!\\@]'#lc=1
                \ end=#'#

    syn region  vimStr
                \ oneline
                \ start=+=!+lc=1
                    \ skip=#\\\\\|\\!#
                \ end=#!#
                \ contains=@vimStr_cluS

    syn region  vimStr
                \ oneline
                \ start=#=+#lc=1
                    \ skip=#\\\\\|\\+#
                \ end=#+#
                \ contains=@vimStr_cluS

    " syn region vimStr   oneline start="\s/\s*\A"lc=1 skip="\\\\\|\\+" end="/"   contains=@vimStr_cluS
                " see tst45.vim
    syn match   vimStr
                \ #"[^"]*\\$#
                \ contained
                \ skipnl
                \ nextgroup=vimStrConti

    syn match   vimStrConti   contained   #\(\\\\\|.\)\{-}[^\\]"#

" :sub/ Substitutions
    syn cluster vimSubs_cluS    contains=vimBar,
                                        \vimInParen_z,
                                        \vimRightParen,
                                        \vimSubs2BS,
                                        \vimSubsRange,
                                        \vimNotation

    syn cluster vimSubsRepList contains=vimSubs129,
                                \vimSubs2BS,
                                \vimNotation

    syn match   vimSubst
                \ "\(:\+\s*\|^\s*\||\s*\)\<\%(\<s\%[ubstitute]\>\|\<sm\%[agic]\>\|\<sno\%[magic]\>\)[:#[:alpha:]]\@!"
                \ nextgroup=vimSubs_old

    syn match   vimSubst
                \ "\%(^\|[^\\\"']\)\<s\%[ubstitute]\>[:#[:alpha:]\"']\@!"
                \ contained
                \ nextgroup=vimSubs_old

    syn match   vimSubs   "/\zs\<s\%[ubstitute]\>\ze/"        nextgroup=vimSubs_old
    syn match   vimSubs   "\(:\+\s*\|^\s*\)s\ze#.\{-}#.\{-}#"     nextgroup=vimSubs_old
    syn match   vimSubs1  #\<s\%[ubstitute]\>#  contained        nextgroup=vimSubs_old
    syn match   vimSubs2  #s\%[ubstitute]\>#   contained       nextgroup=vimSubs_old

    syn region  vimSubs_old
        \ contained   contains=@vimSubs_cluS
        \ oneline
        \ matchgroup=vimSubsDelim
        \     start="\z([^a-zA-Z( \t[\]&]\)"rs=s+1
        \     skip=#\\\\\|\\\z1#
        \     end=#\z1#re=e-1,me=e-1
        \ nextgroup=vimSubs_new

        syn region  vimSubs_new
                \ contained  contains=@vimSubsRepList
            \     oneline
                \ matchgroup=vimSubsDelim
                \     start="\z(.\)"
                \     skip="\\\\\|\\\z1"
                \     end="\z1"
                \ matchgroup=vimNotation
                \     end="<[cC][rR]>"
                \ nextgroup=vimSubsFlagErr

                syn match   vimSubsFlagErr
                                        \ "[^< \t\r|]\+"
                                        \ contained   contains=vimSubsFlags

    syn cluster vimSubs_cluS    add=vimCollection
    syn region  vimCollection
        \ start="\\\@<!\["
        \ skip="\\\["
        \ end="\]"
            \ transparent
            \ contained
            \ contains=vimCollClass

            syn match   vimCollClass
                    \ "\%#=1\[:\(alnum\|alpha\|blank\|cntrl\|digit\|graph\|lower\|print\|punct\|space\|upper\|xdigit\|return\|tab\|escape\|backspace\):\]"
                        \ contained
                        \ transparent

    syn   match   vimCollClassErr   "\[:.\{-\}:\]"      contained

    syn   match   vimSubs019     "\\z\=\d"           contained
                                    "\ 类似:  \0 \1 \2 ... \9 ,  \z1
                                    "\ 所以叫019
    syn   match   vimSubs2BS      "\\\\"              contained
    syn   match   vimSubsFlags      "[&cegiIlnpr#]\+"   contained

" 'String'
"\ 放在Substitute后面是怕被覆盖?
    syn match   vimStr   #[^(,]'[^']\{-}\zs'#


"\ Marks, Registers, Addresses, Filters:
    syn match   vimMark "'[a-zA-Z0-9]\ze[-+,!]" nextgroup=vimFilter,
                                                            \vimMarkNumber,
                                                            \vimSubst
    syn match   vimMark "'[<>]\ze[-+,!]"        nextgroup=vimFilter,
                                                            \vimMarkNumber,
                                                            \vimSubst
    syn match   vimMark ",\zs'[<>]\ze"      nextgroup=vimFilter,
                                                        \vimMarkNumber,
                                                        \vimSubst
    syn match   vimMark "[!,:]\zs'[a-zA-Z0-9]"  nextgroup=vimFilter,
                                                            \vimMarkNumber,
                                                            \vimSubst
    syn match   vimMark "\<norm\%[al]\s\zs'[a-zA-Z0-9]" nextgroup=vimFilter,
                                                                    \vimMarkNumber,
                                                                    \vimSubst
    syn match   vimMarkNumber   "[-+]\d\+"      contained contains=vimOper nextgroup=vimSubs2
    syn match   vimPlainMark contained  "'[a-zA-Z0-9]"
    syn match   vimRange    "[`'][a-zA-Z0-9],[`'][a-zA-Z0-9]"   contains=vimMark    skipwhite nextgroup=vimFilter

    syn match   vimRegister '[^,;[{: \t]\zs"[a-zA-Z0-9.%#:_\-/]\ze[^a-zA-Z_":0-9]'
    syn match   vimRegister '\<norm\s\+\zs"[a-zA-Z0-9]'
    syn match   vimRegister '\<normal\s\+\zs"[a-zA-Z0-9]'
    syn match   vimRegister '@"'
    syn match   vimPlainRegister contained  '"[a-zA-Z0-9\-:.%#*+=]'

    syn match   vimAddress  ",\zs[.$]"  skipwhite nextgroup=vimSubs1
    syn match   vimAddress  "%\ze\a"    skipwhite nextgroup=vimStr,vimSubs1

    syn match   vimFilter       "^!!\=[^"]\{-}\(|\|\ze\"\|$\)"  contains=vimOper,vimSpecFile
    syn match   vimFilter    contained  "!!\=[^"]\{-}\(|\|\ze\"\|$\)"   contains=vimOper,vimSpecFile
    syn match   vimComFilter contained  "|!!\=[^"]\{-}\(|\|\ze\"\|$\)"      contains=vimOper,vimSpecFile

" Complex Repeats: (:h complex-repeat)
    syn match   vimCmplxRepeat  '[^a-zA-Z_/\\()]q[0-9a-zA-Z"]\>'lc=1
    syn match   vimCmplxRepeat  '@[0-9a-z".=@:]\ze\($\|[^a-zA-Z]\>\)'

" ¿Set¿ command and
" associated set-¿options¿
    " with comment
    syn region  vimSet
                    \ matchgroup=vimCommand
                        \ start="\<\%(setl\%[ocal]\|setg\%[lobal]\|se\%[t]\)\>" skip="\%(\\\\\)*\\.\n\@!"
                        \ end="$"
                        \ end="|"
                    \ matchgroup=vimNotation
                        \ end="<[cC][rR]>"
                    \ keepend
                    \ contains=vimSetEqual,
                                \vimOption,
                                \vimErrSetting,
                                \vimTailCmt,
                                \vimSetString,
                                \vimSetMod

    syn region  vimSetEqual
                            \ contained
                            \ start="[=:]\|[-+^]="
                            \ skip="\\\\\|\\\s"
                            \ end="[| \t]"me=e-1
                            \ end="$"
                            \ contains=vimCtrlChar,vimSetSep,vimNotation,vimEnvvar
    syn region  vimSetString
                                \ contained
                                \ start=+="+hs=s+1
                                \ skip=+\\\\\|\\"+
                                \ end=+"+
                                \ contains=vimCtrlChar
    syn match   vimSetSep   contained   "[,:]"
    syn match   vimSetMod   contained   "&vim\=\|[!&?<]\|all&"



" Set up folding commands
" 下面的syn keyword Let 用到Vimfoldh
    if exists("g:vimsyn_folding") && g:vimsyn_folding =~# '[afhlmpPrt]'
        if g:vimsyn_folding =~# 'a'
            com! -nargs=* VimFolda <args> fold
        el
            com! -nargs=* VimFolda <args>
        en

        if g:vimsyn_folding =~# 'f'
            com! -nargs=* VimFoldf <args> fold
        el
            com! -nargs=* VimFoldf <args>
        en

        if g:vimsyn_folding =~# 'h'
            com! -nargs=* VimFoldh <args> fold
        el
            com! -nargs=* VimFoldh <args>
        en

        if g:vimsyn_folding =~# 'l'
            com! -nargs=* VimFoldl <args> fold
        el
            com! -nargs=* VimFoldl <args>
        en

        if g:vimsyn_folding =~# 'm'
            com! -nargs=* VimFoldm <args> fold
        el
            com! -nargs=* VimFoldm <args>
        en
        if g:vimsyn_folding =~# 'p'
            com! -nargs=* VimFoldp <args> fold
        el
            com! -nargs=* VimFoldp <args>
        en
        if g:vimsyn_folding =~# 'P'
            com! -nargs=* VimFoldP <args> fold
        el
            com! -nargs=* VimFoldP <args>
        en
        if g:vimsyn_folding =~# 'r'
            com! -nargs=* VimFoldr <args> fold
        el
            com! -nargs=* VimFoldr <args>
        en
        if g:vimsyn_folding =~# 't'
            com! -nargs=* VimFoldt <args> fold
        el
            com! -nargs=* VimFoldt <args>
        en
    el
    "\ 原封不动
        com! -nargs=*   VimFolda    <args>
        com! -nargs=*   VimFoldf    <args>
        com! -nargs=*   VimFoldh    <args>
        com! -nargs=*   VimFoldl    <args>
        com! -nargs=*   VimFoldm    <args>
        com! -nargs=*   VimFoldp    <args>
        com! -nargs=*   VimFoldP    <args>
        com! -nargs=*   VimFoldr    <args>
        com! -nargs=*   VimFoldt    <args>
    en


" Let:
    syn keyword vimLet
            \ let
            \ unl[et]
            \ skipwhite  nextgroup=vimVar,vimFuncVar,vimLetHereDoc

    VimFoldh syn region vimLetHereDoc
                        \ matchgroup=vimLetHereDocStart
                        \ start='=<<\s\+\%(trim\>\)\=\s*\z(\L\S*\)'
                        \ matchgroup=vimLetHereDocStop
                        \ end='^\s*\z1\s*$'

" Autocmd:
    " =======
    syn match   vimAutoEventList
                    \ contained
                    \ "\(!\s\+\)\=\(\a\+,\)*\a\+"
                    \ contains=vimAutoEvent,nvimAutoEvent
                    \ nextgroup=vimAutoCmdSpace

    syn match   vimAutoCmdSpace
                    \ contained
                    \ "\s\+"
                    \ nextgroup=vimAutoCmdSfxList

    syn match   vimAutoCmdSfxList
                    \ contained
                    \ "\S*"
                    \ skipwhite nextgroup=vimAutoCmdMod

    syn keyword vimAutoCmd
                \ au[tocmd]
                \ do[autocmd]
                \ doautoa[ll]
                \ skipwhite nextgroup=vimAutoEventList

    syn match   vimAutoCmdMod   "\(++\)\=\(once\|nested\)"

" Echo and Execute: -- prefer strings!
    syn region  vimEcho oneline excludenl matchgroup=vimCommand start="\<ec\%[ho]\>" skip="\(\\\\\)*\\|" end="$\||" contains=vimFunc,vimFuncVar,vimStr,vimVar

    syn region  vimExecute
            \ oneline
            \ excludenl
            \ matchgroup=vimCommand
            \ start="\<exe\%[cute]\>"
            \ skip="\(\\\\\)*\\|"
            \ end="$\||\|<[cC][rR]>"
            \ contains=vimFuncVar,vimIsCommand,vimOper,vimNotation,vimOper_brackeT,vimStr,vimVar

    syn match   vimEchoHL   "echohl\="
                    \ skipwhite
                    \ nextgroup=vimGroup,
                                \vimHLGroup,
                                \vimEchoHLNone,
                                \vimOnlyHLGroup,
                                \nvimHLGroup

    syn case ignore
    syn keyword vimEchoHLNone   none
    syn case match

so $nV/syntax/vimS/map_menu_abbr.vim

" Angle-Bracket Notation
    syn case ignore
    syn match   vimNotation
                \ "\%#=1\(\\\|<lt>\)\=<\([scamd]-\)\{0,4}x\=\(f\d\{1,2}\|[^ \t:]\|cmd\|cr\|lf\|linefeed\|return\|enter\|k\=del\%[ete]\|bs\|backspace\|tab\|esc\|right\|left\|help\|undo\|insert\|ins\|mouse\|k\=home\|k\=end\|kplus\|kminus\|kdivide\|kmultiply\|kenter\|kpoint\|space\|k\=\(page\)\=\(\|down\|up\|k\d\>\)\)>" contains=vimBracket

    syn match   vimNotation
        \ "\%#=1\(\\\|<lt>\)\=<\([scam2-4]-\)\{0,4}\(right\|left\|middle\)\(mouse\)\=\(drag\|release\)\=>"
        \ contains=vimBracket

    syn match   vimNotation
        \ "\%#=1\(\\\|<lt>\)\=<\(bslash\|plug\|sid\|space\|bar\|nop\|nul\|lt\)>"
        \ contains=vimBracket

    syn match   vimNotation
        \ '\(\\\|<lt>\)\=<C-R>[0-9a-z"%#:.\-=]'he=e-1
        \ contains=vimBracket

    syn match   vimNotation
        \ '\%#=1\(\\\|<lt>\)\=<\%(q-\)\=\(line[12]\|count\|bang\|reg\|args\|mods\|f-args\|f-mods\|lt\)>'
        \ contains=vimBracket

    syn match   vimNotation
        \ "\%#=1\(\\\|<lt>\)\=<\([cas]file\|abuf\|amatch\|cword\|cWORD\|client\)>"
        \ contains=vimBracket

    syn match   vimBracket
                \ contained
                \ "[\\<>]"

    syn case match

" User Function Highlighting:
    " (following Gautam Iyer's suggestion)
    syn match vimFunc
        \ "\%(\%([sSgGbBwWtTlL]:\|<[sS][iI][dD]>\)\=\%(\w\+\.\)*\I[a-zA-Z0-9_.]*\)\ze\s*("
        \ contains=vimCommand,
          \vimFuncEcho,
          \vimFuncName,
          \vimUserFunc,
          \vimExecute

    syn match vimUserFunc
        \ contained
        \ "\%(\%([sSgGbBwWtTlL]:\|<[sS][iI][dD]>\)\=\%(\w\+\.\)*\I[a-zA-Z0-9_.]*\)\|\<\u[a-zA-Z0-9.]*\>\|\<if\>"
        \ contains=vimCommand,vimNotation

    syn keyword vimFuncEcho contained   ec ech echo

" User Command Highlighting:
    "syn match vimUsrCmd    '^\s*\zs\u\w*.*$'
    syn match vimUsrCmd '^\s*\zs\u\%(\w*\)\@>\%([(#[]\|\s\+\%([-+*/%]\=\|\.\.\)=\)\@!'

" Errors And Warnings:
    if !exists("g:vimsyn_noerror") && !exists("g:vimsyn_novimfunctionerror")
        syn match   vimFunctionError
                            \ '\s\zs[a-z0-9]\i\{-}\ze\s*('
                            \ contained contains=vimFuncKey,vimFuncBlank
        syn match   vimFunctionError
                            \ '\s\zs\%(<[sS][iI][dD]>\|[sSgGbBwWtTlL]:\)\d\i\{-}\ze\s*('
                            \ contained contains=vimFuncKey,vimFuncBlank

        syn match   vimElseIfErr    "\<else\s\+if\>"
        syn match   vimBufnrWarn    /\<bufnr\s*(\s*["']\.['"]\s*)/
    en

hi  def  link   vimNotFunc              vimCommand
syn match vimNotFunc
    \ "\<if\>\|\<el\%[seif]\>\|\<return\>\|\<while\>"
    \ skipwhite
    \ nextgroup=vimOper,vimOper_brackeT,vimVar,vimFunc,vimNotation

" Norm:
    " ====
    syn match   vimNorm     "\<norm\%[al]!\=" skipwhite nextgroup=vimNormCmds
    syn match   vimNormCmds contained   ".*$"



" Additional IsCommand:
" 考虑到precedence , 放这里
    syn match   vimIsCommand
                        \ "<Bar>\s*\a\+"
                        \ transparent
                        \ contains=vimCommand,vimNotation

