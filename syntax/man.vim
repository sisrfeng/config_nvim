" Maintainer:          Anmol Sethi <hi@nhooyr.io>
" Previous Maintainer: SungHyun Nam <goweol@gmail.com>

if exists('b:current_syntax')
    finish
en

" define syntax
    syn    case  ignore


    syn    match manLine1         display '^\%1l.*$'
                                        " \%23l   Matches in a specific line.
    hi default link manLine1         Title

    syn    match manSectioN       display '^\S.*$'
    hi default link manSectioN Statement

    syn    match manSub_sectioN    display '^ \{3\}\S.*$'
    syn    match manSub_sectioN2    display '^ \{4\}\S.*$'
    hi default link manSub_sectioN      Function
    hi default link manSub_sectioN2     Ignore

    syn    match manOptionDesc     display '^\s\+\%(+\|-\)\S\+'
    hi default link manOptionDesc     Constant

    syn    match manReference      display '[^()[:space:]]\+(\%([0-9][a-z]*\|[nlpox]\))'
    hi default link manReference      PreProc


    hi default manUnderline gui=underline
    hi default manBold      gui=bold
    hi default manItalic    gui=italic

if &filetype != 'man'
    " May have been included by some other filetype.
    finish
en

syn match manBacktick_before_quote /`/ conceal  contained containedin=manBacktick_quotE
syn match manSingle_quote_after_backtick /'/ conceal  contained containedin=manBacktick_quotE

syn region manBacktick_quotE
    \ start=#`#
    \ end=#'#
    \ oneline
    \ keepend
    \ concealends
hi link manBacktick_quotE In_backticK

" C语言/system related
if get(b:, 'man_sect', '') =~# '^[023]'
    " section
       " 2   System calls (functions provided by the kernel)
       " 3   Library calls (functions within program libraries)
    syn    case match
    syn    include @c $VIMRUNTIME/syntax/c.vim
    syn    match manCFuncDefinition     display '\<\h\w*\>\ze\(\s\|\n\)*(' contained
    syn    match manLowerSentence /\n\s\{7}\l.\+[()]\=\%(\:\|.\|-\)[()]\=[{};]\@<!\n$/ display keepend contained contains=manReference
    syn    region manSentence start=/^\s\{7}\%(\u\|\*\)[^{}=]*/ end=/\n$/ end=/\ze\n\s\{3,7}#/ keepend contained contains=manReference
    syn    region manSynopsis start='^\%(
                                      \SYNOPSIS\|
                                      \SYNTAX\|
                                      \SINTASSI\|
                                      \書式\)$'
                \end='^\%(\S.*\)\=\S$' keepend contains=manLowerSentence,manSentence,manSectioN,@c,manCFuncDefinition
    hi default link manCFuncDefinition Function

    syn    region manExample start='^EXAMPLES\=$' end='^\%(\S.*\)\=\S$' keepend contains=manLowerSentence,manSentence,manSectioN,manSub_sectioN,@c,manCFuncDefinition

    " XXX: groupthere doesn't seem to work
    syn    sync minlines=500
    "syntax sync match manSyncExample groupthere manExample '^EXAMPLES\=$'
    "syntax sync match manSyncExample groupthere NONE '^\%(EXAMPLES\=\)\@!\%(\S.*\)\=\S$'
en

" Prevent everything else from matching the last line
exe     'syntax match manFooter display "^\%'.line('$').'l.*$"'

let b:current_syntax = 'man'
