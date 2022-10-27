" Last Change:  2017 Sep 29

" Initialization
" quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
en

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

" Keywords
syn keyword bibType contained   article book booklet conference inbook
syn keyword bibType contained   incollection inproceedings manual
syn keyword bibType contained   mastersthesis misc phdthesis
syn keyword bibType contained   proceedings techreport unpublished
syn keyword bibType contained   string preamble

syn keyword bibEntryKw contained     address annote        author    booktitle   chapter
                                     \ crossref              edition   editor      howpublished
                                     \ institution           journal   key         month    note
                                     \ number organization   pages     publisher
                                     \ school series         title     type        volume   year

" biblatex keywords, cf. http://mirrors.ctan.org/macros/latex/contrib/biblatex/doc/biblatex.pdf
syn keyword bibType contained   mvbook bookinbook suppbook collection mvcollection suppcollection
                                \ online patent periodical suppperiodical mvproceedings reference
                                \ mvreference inreference report set thesis xdata customa customb
                                \ customc customd custome customf electronic www artwork audio bibnote
                                \ commentary image jurisdiction legislation legal letter movie music
                                \ performance review software standard video

syn keyword bibEntryKw contained        abstract isbn issn keywords url
                                      \ addendum afterwordannotation annotation annotator authortype
                                      \ bookauthor bookpagination booksubtitle booktitleaddon
                                      \ commentator date doi editora editorb editorc editortype
                                      \ editoratype editorbtype editorctype eid entrysubtype
                                      \ eprint eprintclass eprinttype eventdate eventtitle
                                      \ eventtitleaddon file foreword holder indextitle
                                      \ introduction isan ismn isrn issue issuesubtitle
                                      \ issuetitle iswc journalsubtitle journaltitle label
                                      \ language library location mainsubtitle maintitle
                                      \ maintitleaddon nameaddon origdate origlanguage
                                      \ origlocation origpublisher origtitle pagetotal
                                      \ pagination part pubstate reprinttitle shortauthor
                                      \ shorteditor shorthand shorthandintro shortjournal
                                      \ shortseries shorttitle subtitle titleaddon translator
                                      \ urldate venue version volumes entryset execute gender
                                      \ langid langidopts ids indexsorttitle options presort
                                      \ related relatedoptions relatedtype relatedstring
                                      \ sortkey sortname sortshorthand sorttitle sortyear xdata
                                      \ xref namea nameb namec nameatype namebtype namectype
                                      \ lista listb listc listd liste listf usera userb userc
                                      \ userd usere userf verba verbb verbc archiveprefix pdf
                                      \ primaryclass

" Non-standard:
" AMS mref http://www.ams.org/mref
syn keyword bibNSEntryKw contained      mrclass mrnumber mrreviewer fjournal coden

" Clusters
" ========
syn cluster bibVarContents      contains=bibUnescapedSpecial,bibBrace,bibParen,bibMath
" This cluster is empty but things can be added externally:
"syn cluster bibCommentContents

" Matches
" =======
syn match bibUnescapedSpecial   contained   /[^\\][%&]/hs=s+1
syn match bibKey                contained   #\s*[^ \t}="]\+,#hs=s,he=e-1    nextgroup=bibField
    "\ The citekey is the name that is used to uniquely identify the BibTeX entry.
    "\ It can be any combination of letters and digits(还可以有其他符号)
    "\ and follows immediately after the opening bracket

syn match bibVariable           contained   /[^{}," \t=]/

syn region bibComment start=/./ end=/^\s*@/me=e-1 contains=@bibCommentContents nextgroup=bibEntry
syn region bibMath contained start=/\(\\\)\@<!\$/ end=/\$/ skip=/\(\\\$\)/
syn region bibQuote contained start=/"/ end=/"/ skip=/\(\\"\)/ contains=@bibVarContents
syn region bibBrace contained start=/{/ end=/}/ skip=/\(\\[{}]\)/ contains=@bibVarContents
syn region bibParen contained start=/(/ end=/)/ skip=/\(\\[()]\)/ contains=@bibVarContents
syn region bibField contained start="\S\+\s*=\s*" end=/[}),]/me=e-1 contains=bibEntryKw,bibNSEntryKw,bibBrace,bibParen,bibQuote,bibVariable

syn region bibEntryData   contained  start=#[{(]#ms=e+1
                                   \ end=#[})]#me=e-1
                                   \ contains=bibKey,bibField,bibComment3


" Actually, 5.8 <= Vim < 6.0 would ignore the `fold' keyword anyway,
" but Vim<5.8 would produce  an error,
" so we explicitly distinguish versions with and without folding functionality:

syn region bibEntry    start=#@\S\+\s*[{(]#
                     \ end=#^\s*[})]#
                     \ transparent
                     \ fold
                     \ nextgroup=bibComment
                     \ contains=bibType,bibEntryData

syn region bibComment2 start=/@Comment\s*[{(]/ end=/^\s*[})]/me=e-1 contains=@bibCommentContents nextgroup=bibEntry
" biblatex style comments inside a bibEntry
syn match bibComment3 "%.*"

" Synchronization
" ===============
syn sync match All grouphere bibEntry /^\s*@/
syn sync maxlines=200
syn sync minlines=50

" Highlighting defaults
" Only when an item doesn't have highlighting yet

hi   def   link   bibType               Identifier
hi   def   link   bibEntryKw            Statement
hi   def   link   bibNSEntryKw          PreProc
hi   def   link   bibKey                Special
hi   def   link   bibVariable           Constant
hi   def   link   bibUnescapedSpecial   Error
hi   def   link   bibComment            Comment
hi   def   link   bibComment2           Comment
hi   def   link   bibComment3           Comment

let b:current_syntax = "bib"

let &cpo = s:cpo_save
unlet s:cpo_save
