" Language: reStructuredText documentation format
    " Website: https://github.com/marshallward/vim-restructuredtext
    " Latest Revision: 2020-03-31

    "\ rst: widely used in the Python community

    "\ pip install docutils
        "\ For input Docutils supports reStructuredText, an easy-to-read, what-you-see-is-what-you-get plaintext markup syntax.
        "\ for General- and Special-Purpose Use

    "\ sphinx 斯芬克斯 狮身人面像
    "\ pip install -U sphinx
                   "\ python documentation generators
                   "\ ¿s¿tructure ¿p¿ython ?? 我瞎想的


    "\ vs markdown:
        " It should be noted that Commonmark doesn’t support a lot of the concepts that
            " RST lets you represent.
            "\ In particular, there is no standardized way in Commonmark to represent inline or block levels constructs.
            "\ So things like the toctree directive and :ref: markup don’t have an analog."

        "\ https://docs.typo3.org/m/typo3/docs-how-to-document/main/en-us/GeneralConventions/Format.html
        "\ 缺点:
            "\ indenting is important
            "\ new lines are important, for example before, after and between bullet lists

            "\ some people simply hate it


    "\ Read the Docs is built on top of Sphinx,
        " which has always relied on reStructuredText as an input mechanism.
        " We have long heard from folks that they want to write documentation in Markdown, as well as RST.
        "\ Today we are announcing that this is now possible.
        "\ Intended Usage
            "\ We think that Sphinx’s power to reference code and other programming concepts is quite powerful. However, all content doesn’t need this ability. When you’re writing content that just needs to have basic text formatting and links, Commonmark is a great option for this.
            "\
            "\ We imagine that
            " API reference documentation will continue to be
            " authored in RST for quite some time.
            " Also index pages and other reference heavy content will continue to be RST.
            " FAQ’s, blog posts, and other less reference heavy content is a great candidate for writing in Commonmark.

"\ Restructured text                       *rst.vim*  *ft-rst-syntax*
    "\ Syntax highlighting is enabled for
    "\ code blocks within the document for a  select number of file types.
    "\ See $VIMRUNTIME/syntax/rst.vim for the default  syntax list.
    "\
    "\ To set a user-defined list of code block syntax highlighting:
    "\     let rst_syntax_code_list = ['vim', 'lisp', ...]
    "\
    "\ To assign multiple code block types to a single syntax,
    "\ define  `rst_syntax_code_list` as a mapping:
    "\         let rst_syntax_code_list = {
    "\                 \ 'cpp': ['cpp', 'c++'],
    "\                 \ 'bash': ['bash', 'sh'],
    "\                 ...
    "\         \ }
    "\
    "\ To use color highlighting for emphasis text:
    "\         let rst_use_emphasis_colors = 1
    "\
    "\ To enable folding of sections:
    "\         let rst_fold_enabled = 1
    "\
    "\ Folding can cause performance issues on some platforms.
    "\

if exists("b:current_syntax")  | finish  | endif

let s:cpo_save = &cpo  | set cpo&vim

syn case ignore

syn match   rstTransition  /^[=`:.'"~^_*+#-]\{4,}\s*$/

"\ 不整齐的部分
syn cluster rstCruft                contains=rstEmphasis,
                                     \rstStrongEmphasis,
                                     \rstInterpretedText,
                                     \rstInlineLiteral,
                                     \rstSubstitutionReference,
                                     \rstInlineInternalTargets,
                                     \rstFootnoteReference,
                                     \rstHyperlinkReference
                            "\ \ conceal

syn region  rstLiteralBlock
                    \ matchgroup=rstDelimiter
                    \ start='\(^\z(\s*\).*\)\@<=::\n\s*\n'
                    \ skip='^\s*$'
                    \ end='^\(\z1\s\+\)\@!'
                    \ contains=@NoSpell

syn region  rstQuotedLiteralBlock
        \ matchgroup=rstDelimiter
        \ start="::\_s*\n\ze\z([!\"#$%&'()*+,-./:;<=>?@[\]^_`{|}~]\)"
        \ end='^\z1\@!'
        \ contains=@NoSpell

syn region  rstDoctestBlock         oneline display matchgroup=rstDelimiter
      \ start='^>>>\s' end='^$'

syn region  rstTable                transparent start='^\n\s*+[-=+]\+' end='^$'
      \ contains=rstTableLines,@rstCruft

syn match   rstTableLines           contained display '|\|+\%(=\+\|-\+\)\='

syn region  rstSimpleTable          transparent
      \ start='^\n\%(\s*\)\@>\%(\%(=\+\)\@>\%(\s\+\)\@>\)\%(\%(\%(=\+\)\@>\%(\s*\)\@>\)\+\)\@>$'
      \ end='^$'
      \ contains=rstSimpleTableLines,@rstCruft

syn match   rstSimpleTableLines     contained display
      \ '^\%(\s*\)\@>\%(\%(=\+\)\@>\%(\s\+\)\@>\)\%(\%(\%(=\+\)\@>\%(\s*\)\@>\)\+\)\@>$'
syn match   rstSimpleTableLines     contained display
      \ '^\%(\s*\)\@>\%(\%(-\+\)\@>\%(\s\+\)\@>\)\%(\%(\%(-\+\)\@>\%(\s*\)\@>\)\+\)\@>$'

syn cluster rstDirectives           contains=rstFootnote,rstCitation,
      \ rstHyperlinkTarget,rstExDirective

syn match   rstExplicitMarkup       '^\s*\.\.\_s'
      \ nextgroup=@rstDirectives,rstComment,rstSubstitutionDefinition

" Simple reference names are
    " single words consisting of alphanumerics plus
    " isolated (no two adjacent) internal
        " hyphens, underscores, periods, colons  and plus signs."
let s:ReferenceName = '[[:alnum:]]\%([-_.:+]\?[[:alnum:]]\+\)*'

syn keyword     rstTodo             contained FIXME TODO XXX NOTE

    exe  'syn region rstComment contained' .
        \ ' start=/.*/'
        \ ' skip=+^$+' .
        \ ' end=/^\s\@!/ contains=rstTodo'

    exe  'syn region rstFootnote    contained matchgroup=rstDirective' .
        \ ' start=+\[\%(\d\+\|#\%(' . s:ReferenceName . '\)\=\|\*\)\]\_s+' .
        \ ' skip=+^$+' .
        \ ' end=+^\s\@!+ contains=@rstCruft,@NoSpell'

    exe  'syn region rstCitation contained matchgroup=rstDirective' .
        \ ' start=+\[' . s:ReferenceName . '\]\_s+' .
        \ ' skip=+^$+' .
        \ ' end=+^\s\@!+ contains=@rstCruft,@NoSpell'


    syn region rstHyperlinkTarget contained matchgroup=rstDirective
        \ start='_\%(_\|[^:\\]*\%(\\.[^:\\]*\)*\):\_s' skip=+^$+ end=+^\s\@!+

    syn region rstHyperlinkTarget contained matchgroup=rstDirective
        \ start='_`[^`\\]*\%(\\.[^`\\]*\)*`:\_s' skip=+^$+ end=+^\s\@!+

    syn region rstHyperlinkTarget matchgroup=rstDirective
        \ start=+^__\_s+ skip=+^$+ end=+^\s\@!+

exe  'syn region rstExDirective contained matchgroup=rstDirective' .
      \ ' start=+' . s:ReferenceName . '::\_s+' .
      \ ' skip=+^$+' .
      \ ' end=+^\s\@!+ contains=@rstCruft,rstLiteralBlock'

exe  'syn match rstSubstitutionDefinition contained' .
      \ ' /|.*|\_s\+/ nextgroup=@rstDirectives'


"\ inline_markupS
    fun! s:a_inline_markup(name, start, middle, end, char_left, char_right)
        " Only escape the first char of a multichar delimiter (e.g. \* inside **)
        if a:start[0] == '\'
            let first = a:start[0:1]
        el
            let first = a:start[0]
        en


        exe  'syn match rstEscape' . a:name . ' +\\\\\|\\' . first . '+' . ' contained'

        "\ exe  'syn match rstConceal_wf' . a:name . ' +' . a:start '+' . ' conceal contained containedin=' . 'rst' . 'a:name'
        "\ exe  'syn match rstConceal_wf' . a:name . ' +' . a:end '+' . ' conceal contained containedin=' . 'rst' . 'a:name'

        exe  'syn region rst' . a:name .
                    \ ' start=+' . a:char_left . '\zs' . a:start .
                            \ '\ze[^[:space:]' . a:char_right . a:start[strlen(a:start) - 1] . ']+' .   a:middle .
                    \ ' end=+' . a:end . '\ze\%($\|\s\|[''"’)\]}>/:.,;!?\\-]\)+' .
                    \ ' contains=rstEscape' . a:name

        exe  'hi def link rstEscape' . a:name . ' Special'
    endf


    fun! s:inline_markupS(name, start, middle, end)
        let middle = a:middle != ""
                \ ?  (' skip=+\\\\\|\\' . a:middle . '\|\s' . a:middle . '+')
                \ :   ""

        "\ 引号:
        call s:a_inline_markup(a:name, a:start, middle, a:end, "'", "'")
        call s:a_inline_markup(a:name, a:start, middle, a:end, '"', '"')
        call s:a_inline_markup(a:name, a:start, middle, a:end, '’', '’')

        "\ 括号:
        call s:a_inline_markup(a:name, a:start, middle, a:end, '(', ')')
        call s:a_inline_markup(a:name, a:start, middle, a:end, '\[', '\]')
        call s:a_inline_markup(a:name, a:start, middle, a:end, '{', '}')
        call s:a_inline_markup(a:name, a:start, middle, a:end, '<', '>')
        " TODO: Additional Unicode Pd, Po, Pi, Pf, Ps characters

        call s:a_inline_markup(a:name, a:start, middle, a:end, '\%(^\|\s\|\%ua0\|[/:]\)', '')

        exe  'syn match rst' . a:name .
                    \ ' +\%(^\|\s\|\%ua0\|[''"([{</:]\)\zs' . a:start .
                    \ '[^[:space:]' . a:start[strlen(a:start) - 1] . ']'
                    \ a:end . '\ze\%($\|\s\|[''")\]}>/:.,;!?\\-]\)+'

        exe  'hi def link rst' . a:name . 'Delimiter' . ' rst' . a:name
    endf

    "\ 下面的各个a:name, 都和上述函数里的 引号及括号 组合, 6x7 种组合,
    " todo: 在这里conceal, 代替在after/syntax/rst.vim里手动搞
        call s:inline_markupS('Emphasis'                            , '\*'   , '\*' , '\*')
        call s:inline_markupS('StrongEmphasis'                      , '\*\*'  , '\*' , '\*\*')

        call s:inline_markupS('InterpretedTextOrHyperlinkReference' , '`'   , '`' , '`_\{0,2}')
                        "\ Interpreted Text  Or   Hyperlink  Reference
        call s:inline_markupS('InlineLiteral'                       , '``'   , ""   , '``')

        call s:inline_markupS('SubstitutionReference'               , '|'    , '|'  , '|_\{0,2}')
                        "\ Substitution  Reference
        call s:inline_markupS('InlineInternalTargets'               , '_`'   , '`'  , '`')

" Sections are identified through their titles,
" which are marked up with  adornment: "underlines" below the title text,
" or underlines and matching
" "overlines" above the title. An underline/overline is a single repeated
" punctuation character that begins in column 1 and forms a line extending at
" least as far as the right edge of the title text.
"
" It is difficult to count characters in a regex, but we at least special-case
" the case where the title has at least three characters to require the
" adornment to have at least three characters as well, in order to handle
" properly the case of a literal block:
"
"    this is the end of a paragraph
"    ::
"       this is a literal block
syn match   rstSections "\v^%(([=`:.'"~^_*+#-])\1+\n)?.{1,2}\n([=`:.'"~^_*+#-])\2+$"
    \ contains=@Spell
syn match   rstSections "\v^%(([=`:.'"~^_*+#-])\1{2,}\n)?.{3,}\n([=`:.'"~^_*+#-])\2{2,}$"
    \ contains=@Spell

" TODO: Can’t remember why these two can’t be defined like the ones above.
exe  'syn match rstFootnoteReference contains=@NoSpell' .
      \ ' +\%(\s\|^\)\[\%(\d\+\|#\%(' . s:ReferenceName . '\)\=\|\*\)\]_+'

exe  'syn match rstCitationReference contains=@NoSpell' .
      \ ' +\%(\s\|^\)\[' . s:ReferenceName . '\]_\ze\%($\|\s\|[''")\]}>/:.,;!?\\-]\)+'

exe  'syn match rstHyperlinkReference' .
      \ ' /\<' . s:ReferenceName . '__\=\ze\%($\|\s\|[''")\]}>/:.,;!?\\-]\)/'

syn match   rstStandaloneHyperlink  contains=@NoSpell
      \ "\<\%(\%(\%(https\=\|file\|ftp\|gopher\)://\|\%(mailto\|news\):\)[^[:space:]'\"<>]\+\|www[[:alnum:]_-]*\.[[:alnum:]_-]\+\.[^[:space:]'\"<>]\+\)[[:alnum:]/]"

syn region rstCodeBlock contained matchgroup=rstDirective
      \ start=+\%(sourcecode\|code\%(-block\)\=\)::\s*\(\S*\)\?\s*\n\%(\s*:.*:\s*.*\s*\n\)*\n\ze\z(\s\+\)+
      \ skip=+^$+
      \ end=+^\z1\@!+
      \ contains=@NoSpell
syn cluster rstDirectives add=rstCodeBlock

if !exists('g:rst_syntax_code_list')
    " A mapping from a Vim filetype to a list of alias patterns (pattern
    " branches to be specific, see ':help /pattern'). E.g. given:
    "
    "   let g:rst_syntax_code_list = {
    "       \ 'cpp': ['cpp', 'c++'],
    "       \ }
    "
    " then the respective contents of the following two rST directives:
    "
    "   .. code:: cpp
    "
    "       auto i = 42;
    "
    "   .. code:: C++
    "
    "       auto i = 42;
    "
    " will both be highlighted as C++ code. As shown by the latter block
    " pattern matching will be case-insensitive.
    let g:rst_syntax_code_list = {
        \ 'vim': ['vim'],
        \ 'java': ['java'],
        \ 'cpp': ['cpp', 'c++'],
        \ 'lisp': ['lisp'],
        \ 'php': ['php'],
        \ 'python': ['python'],
        \ 'perl': ['perl'],
        \ 'sh': ['sh'],
        \ }
elseif type(g:rst_syntax_code_list) == type([])
    " backward compatibility with former list format
    let s:old_spec = g:rst_syntax_code_list
    let g:rst_syntax_code_list = {}
    for s:elem in s:old_spec
        let g:rst_syntax_code_list[s:elem] = [s:elem]
    endfor
en

for s:filetype in keys(g:rst_syntax_code_list)
    unlet! b:current_syntax
    " guard against setting 'isk' option which might cause problems (issue #108)
    let prior_isk = &l:iskeyword
    let s:alias_pattern = ''
                \.'\%('
                \.join(g:rst_syntax_code_list[s:filetype], '\|')
                \.'\)'

    exe 'syn include @rst'.s:filetype.' syntax/'.s:filetype.'.vim'
    exe 'syn region rstDirective'.s:filetype
                \.' matchgroup=rstDirective fold'
                \.' start="\c\%(sourcecode\|code\%(-block\)\=\)::\s\+'.s:alias_pattern.'\_s*\n\ze\z(\s\+\)"'
                \.' skip=#^$#'
                \.' end=#^\z1\@!#'
                \.' contains=@NoSpell,@rst'.s:filetype
    exe 'syn cluster rstDirectives add=rstDirective'.s:filetype

    " reset 'isk' setting, if it has been changed
    if &l:iskeyword !=# prior_isk
        let &l:iskeyword = prior_isk
    en
    unlet! prior_isk
endfor

" Enable top level spell checking
syn  spell toplevel

" TODO: Use better syncing.
syn sync minlines=50 linebreaks=2

hi def link rstTodo                         Todo
    hi def link rstComment                      Comment
    hi def link rstSections                     Title
    hi def link rstTransition                   rstSections
    hi def link rstLiteralBlock                 String
    hi def link rstQuotedLiteralBlock           String
    hi def link rstDoctestBlock                 PreProc
    hi def link rstTableLines                   rstDelimiter
    hi def link rstSimpleTableLines             rstTableLines
    hi def link rstExplicitMarkup               rstDirective
    hi def link rstDirective                    Keyword
    hi def link rstFootnote                     String
    hi def link rstCitation                     String
    hi def link rstHyperlinkTarget              String
    hi def link rstExDirective                  String
    hi def link rstSubstitutionDefinition       rstDirective
    hi def link rstDelimiter                    Delimiter
    hi def link rstInterpretedTextOrHyperlinkReference  Identifier
    hi def link rstInlineLiteral                String
    hi def link rstSubstitutionReference        PreProc
    hi def link rstInlineInternalTargets        Identifier
    hi def link rstFootnoteReference            Identifier
    hi def link rstCitationReference            Identifier
    hi def link rstHyperLinkReference           Identifier
    hi def link rstStandaloneHyperlink          Identifier
    hi def link rstCodeBlock                    String

if exists('g:rst_use_emphasis_colors')
    " TODO: Less arbitrary color selection
    hi def rstEmphasis          gui=italic
    hi def rstStrongEmphasis    gui=bold,underline
el
    hi def rstEmphasis          term=italic cterm=italic gui=italic
    hi def rstStrongEmphasis    term=bold cterm=bold gui=bold
en

let b:current_syntax = "rst"   |  let &cpo = s:cpo_save  | unlet s:cpo_save
