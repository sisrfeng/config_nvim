" Support for Python indenting, see runtime/indent/python.vim

if exists('g:loaded_python')
    finish
endif


let g:loaded_python = 1

let s:keepcpo = &cpo  | set cpo&vim

" need to inspect some old g:pyindent_* variables to be backward compatible
let g:python_indent = extend( get(g:, 'python_indent', {}),
                       \#{
                        \ closed_paren_align_last_line  : v:true,
                        \ open_paren                    : get(g:, 'pyindent_open_paren', ' shiftwidth()* 2'),
                        \ nested_paren                  : get(g:, 'pyindent_nested_paren', 'shiftwidth()'),
                        \ continue                      : get(g:, 'pyindent_continue', 'shiftwidth() * 2'),
                        \ searchpair_timeout            : get(g:, 'pyindent_searchpair_timeout', 150),
                          "\ searchpair() can be slow, limit the time, 毫秒
                        \ disable_parentheses_indenting : get(g:, 'pyindent_disable_parentheses_indenting', v:false),
                          "\ Identing inside parentheses can be very slow,
                              "\ regardless of the searchpair() timeout,
                              "\ so let the user disable this feature if he doesn't need it
                        \ },
                        \ 'keep'
                        \)

"\ 旧版的内容, 原在indent/python.vim------


    "\ " Come here when loading the script the first time.
    "\
    "\ let s:maxoff = 50      " maximum number of lines to look backwards for ()
    "\
    "\ " See if the specified line is already user-dedented from the expected value.
    "\ function s:Dedented(lnum, expected)
    "\     return indent(a:lnum) <= a:expected - shiftwidth()
    "\ endf
    "\
    "\
    "\ function GetPythonIndent(lnum)
    "\     " If this line is explicitly joined:
    "\         " If the previous line was also joined,
    "\         " line it up with that one,
    "\         " otherwise add two 'shiftwidth'
    "\     if getline(a:lnum - 1) =~ '\\$'
    "\         if a:lnum > 1 && getline(a:lnum - 2) =~ '\\$'
    "\             return indent(a:lnum - 1)
    "\         en
    "\         return indent(a:lnum - 1) + (exists("g:pyindent_continue") ? eval(g:pyindent_continue) : (shiftwidth() * 2))
    "\     en
    "\
    "\     " If the start of the line is in a string
    "\     " don't change the indent.
    "\     if has('syntax_items')
    "\     \ && synIDattr(synID(a:lnum, 1, 1), "name") =~ "String$"
    "\         return -1
    "\     en
    "\
    "\     " Search backwards for the previous non-empty line.
    "\     let plnum = prevnonblank(v:lnum - 1)
    "\     " previous line number?
    "\
    "\     if plnum == 0
    "\         " This is the first non-empty line, use zero indent.
    "\         return 0
    "\     en
    "\
    "\     call cursor(plnum, 1)
    "\
    "\     " Identing inside parentheses can be very slow,
    "\     " regardless of the searchpair()
    "\                     " timeout,
    "\     " so let the user disable this feature if he doesn't need it
    "\     let disable_parentheses_indenting = get(g:, "pyindent_disable_parentheses_indenting", 0)
    "\
    "\     if disable_parentheses_indenting == 1
    "\         let plindent   =  indent(plnum)
    "\         let plnumstart =  plnum
    "\     el
    "\         " searchpair() can be slow sometimes,
    "\         " limit the time to 150 msec or what is  put in g:pyindent_searchpair_timeout
    "\         let searchpair_stopline =  0
    "\         let searchpair_timeout  =  get(g:, 'pyindent_searchpair_timeout' , 150)
    "\
    "\         " If the previous line is inside parenthesis,
    "\             " use the indent of the starting  line.
    "\         " Trick:
    "\         " use the non-existing "dummy" variable to break out of the loop (searchpair要loop?)
    "\         " when  going too far back.
    "\
    "\                 " searchpair({start}, {middle}, {end} [, {flags} [, {skip}
    "\                 "                 [, {stopline} [, {timeout}]]]])
    "\
    "\                                     " (  [  {
    "\         sil! let parlnum = searchpair('(\|{\|\[',
    "\                                 \ '',
    "\                                 \ ')\|}\|\]',
    "\                                 \ 'nbW',
    "\                                 \ "line('.') < "..(plnum - s:maxoff).. " ?
    "\                                         \ dummy
    "\                                         \ :  "
    "\                                             \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
    "\                                             \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
    "\                                 \ searchpair_stopline,
    "\                                 \ searchpair_timeout
    "\                                 \ )
    "\
    "\                         " b: backwark
    "\                         " s:maxoff <  plnum -  line('.')
    "\                         " {skip}为:
    "\                             " \ "line('.') < "..(plnum - s:maxoff).. " ?   dummy  :  "
    "\                             "                                                       \ .." synIDattr(synID(line('.'), col('.'), 1), 'name')"
    "\                             "                                                       \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
    "\
    "\
    "\
    "\         if parlnum > 0
    "\             let plindent = indent(parlnum)
    "\             let plnumstart = parlnum
    "\         el
    "\             let plindent = indent(plnum)
    "\             let plnumstart = plnum
    "\         en
    "\
    "\         " When inside parenthesis: If at the first line below the parenthesis add
    "\         " two 'shiftwidth', otherwise same as previous line.
    "\         " i = (a
    "\         "       + b
    "\         "       + c)
    "\         call cursor(a:lnum, 1)
    "\         sil! let p = searchpair('(\|{\|\[', '', ')\|}\|\]', 'bW',
    "\                         \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
    "\                         \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
    "\                         \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
    "\                         \ searchpair_stopline, searchpair_timeout)
    "\         if p > 0
    "\             if p == plnum
    "\                 " When the start is inside parenthesis, only indent one 'shiftwidth'.
    "\                 let pp = searchpair('(\|{\|\[', '', ')\|}\|\]', 'bW',
    "\                         \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
    "\                         \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
    "\                         \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
    "\                         \ searchpair_stopline, searchpair_timeout)
    "\                 if pp > 0
    "\                     return indent(plnum) + (exists("g:pyindent_nested_paren") ? eval(g:pyindent_nested_paren) : shiftwidth())
    "\                 en
    "\                 return indent(plnum) + (exists("g:pyindent_open_paren") ? eval(g:pyindent_open_paren) : (shiftwidth() * 2))
    "\             en
    "\             if plnumstart == p
    "\                 return indent(plnum)
    "\             en
    "\             return plindent
    "\         en
    "\
    "\     en
    "\
    "\
    "\     " Get the line and remove a trailing comment.
    "\     " Use syntax highlighting attributes when possible.
    "\     let pline = getline(plnum)
    "\     let pline_len = strlen(pline)
    "\     if has('syntax_items')
    "\         " If the last character in the line is a comment, do a binary search for
    "\         " the start of the comment.  synID() is slow, a linear search would take
    "\         " too long on a long line.
    "\         if synIDattr(synID(plnum, pline_len, 1), "name") =~ "\\(Comment\\|Todo\\)$"
    "\             let min = 1
    "\             let max = pline_len
    "\             while min < max
    "\     let col = (min + max) / 2
    "\     if synIDattr(synID(plnum, col, 1), "name") =~ "\\(Comment\\|Todo\\)$"
    "\         let max = col
    "\     el
    "\         let min = col + 1
    "\     en
    "\             endwhile
    "\             let pline = strpart(pline, 0, min - 1)
    "\         en
    "\     el
    "\         let col = 0
    "\         while col < pline_len
    "\             if pline[col] == '#'
    "\     let pline = strpart(pline, 0, col)
    "\     break
    "\             en
    "\             let col = col + 1
    "\         endwhile
    "\     en
    "\
    "\     " If the previous line ended with a colon, indent this line
    "\     if pline =~ ':\s*$'
    "\         return plindent + shiftwidth()
    "\     en
    "\
    "\     " If the previous line was a stop-execution statement...
    "\     if getline(plnum) =~ '^\s*\(break\|continue\|raise\|return\|pass\)\>'
    "\         " See if the user has already dedented
    "\         if s:Dedented(a:lnum, indent(plnum))
    "\             " If so, trust the user
    "\             return -1
    "\         en
    "\         " If not, recommend one dedent
    "\         return indent(plnum) - shiftwidth()
    "\     en
    "\
    "\     " If the current line begins with a keyword that lines up with "try"
    "\     if getline(a:lnum) =~ '^\s*\(except\|finally\)\>'
    "\         let lnum = a:lnum - 1
    "\         while lnum >= 1
    "\             if getline(lnum) =~ '^\s*\(try\|except\)\>'
    "\     let ind = indent(lnum)
    "\     if ind >= indent(a:lnum)
    "\         return -1	" indent is already less than this
    "\     en
    "\     return ind	" line up with previous try or except
    "\             en
    "\             let lnum = lnum - 1
    "\         endwhile
    "\         return -1		" no matching "try"!
    "\     en
    "\
    "\     " If the current line begins with a header keyword, dedent
    "\     if getline(a:lnum) =~ '^\s*\(elif\|else\)\>'
    "\
    "\         " Unless the previous line was a one-liner
    "\         if getline(plnumstart) =~ '^\s*\(for\|if\|elif\|try\)\>'
    "\             return plindent
    "\         en
    "\
    "\         " Or the user has already dedented
    "\         if s:Dedented(a:lnum, plindent)
    "\             return -1
    "\         en
    "\
    "\         return plindent - shiftwidth()
    "\     en
    "\
    "\     " When after a () construct we probably want to go back to the start line.
    "\     " a = (b
    "\     "       + c)
    "\     " here
    "\     if parlnum > 0
    "\         " ...unless the user has already dedented
    "\         if s:Dedented(a:lnum, plindent)
    "\                 return -1
    "\         el
    "\                 return plindent
    "\         en
    "\     en
    "\
    "\     return -1
    "\
    "\ endf
    "\
    "\ let &cpo = s:keepcpo
    "\ unlet s:keepcpo

"\ 旧版的内容, 原在indent/python.vim------


let s:maxoff = 50       " maximum number of lines to look backwards for ¿()¿

function s:SearchBracket(fromlnum, flags)
    return searchpairpos('[[({]',
                  \ '',
                  \ '[])}]',
                  \ a:flags,
                    "\ 下面是searchpairpos()的参数skip.   用了lambda, 且该函数参数为空, 别和method混了
                  \ {  -> synstack('.', col('.'))
                        \   ->map( { _, id   ->  synIDattr(id, 'name') } )
                            \   ->match( '\%(Comment\|Todo\|String\)$' ) >= 0
                  \ },
                 \  max( [0,  a:fromlnum - s:maxoff] ),
                  \ g:python_indent.searchpair_timeout
                   \)
endf

" See if the specified line
" is already user-dedented from the expected value.
function s:Dedented(lnum, expected)
    return indent(a:lnum) <= a:expected - shiftwidth()
endf

" Some other filetypes which embed Python have slightly different indent  rules (e.g. bitbake).
"\ bitbake:
    "\ BitBake is a generic task execution engine that
    "\ allows shell and Python tasks to be run efficiently
    "\ and in parallel while working within complex inter-task dependency constraints.
    "\ One of BitBake's main users,
    "\ OpenEmbedded,
    "\ takes this core and
    "\ builds embedded Linux software stacks using a task-oriented approach.
    "\ Conceptually,
    "\ BitBake is similar to GNU Make in some regards but has significant differences:

" Those filetypes can pass an extra funcref to this  function
    " which is evaluated below.
"\ 原本的fun没加叹号
fun! python#GetIndent(lnum, ...)
    let ExtraFunc = a:0 > 0 ? a:1 : 0

    " If this line is explicitly joined:
        " If the previous line was also joined,
            " line it up with that one,
        " otherwise add two 'shiftwidth'
    if getline(a:lnum - 1) =~ '\\$'
        if a:lnum > 1 && getline(a:lnum - 2) =~ '\\$'
            return indent(a:lnum - 1)
        en
        return indent(a:lnum - 1) + get(g:, 'pyindent_continue', g:python_indent.continue)->eval()
    en

    " If the start of the line is in a string
    " don't change the indent.
    if has('syntax_items')
        \ && synIDattr(synID(a:lnum, 1, 1), "name") =~ "String$"
        return -1
    en

    " Search backwards for the previous non-empty line.
    let plnum = prevnonblank(v:lnum - 1)

    if plnum == 0
        " This is the first non-empty line, use zero indent.
        return 0
    en

    if g:python_indent.disable_parentheses_indenting == 1
        let plindent = indent(plnum)
        let plnumstart = plnum
    el
        " Indent inside parens.
        " Align with the open paren unless it is at the end of the line.
        " E.g.
        "     open_paren_not_at_EOL(100,
        "                           (200,
        "                            300),
        "                           400)
        "     open_paren_at_EOL(
        "         100, 200, 300, 400)
        call cursor(a:lnum, 1)
        let [parlnum, parcol] = s:SearchBracket(a:lnum, 'nbW')
        if parlnum > 0
            if parcol != col([parlnum, '$']) - 1
                return parcol
            elseif getline(a:lnum) =~ '^\s*[])}]' && !g:python_indent.closed_paren_align_last_line
                return indent(parlnum)
            en
        en

        call cursor(plnum, 1)

        " If the previous line is inside parenthesis, use the indent of the starting
        " line.
        let [parlnum, _] = s:SearchBracket(plnum, 'nbW')
        if parlnum > 0
            if a:0 > 0 && ExtraFunc(parlnum)
                " We may have found the opening brace of a bitbake Python task, e.g. 'python do_task {'
                " If so, ignore it here - it will be handled later.
                let parlnum = 0
                let plindent = indent(plnum)
                let plnumstart = plnum
            el
                let plindent = indent(parlnum)
                let plnumstart = parlnum
            en
        el
            let plindent = indent(plnum)
            let plnumstart = plnum
        en

        " When inside parenthesis: If at the first line below the parenthesis add
        " two 'shiftwidth', otherwise same as previous line.
        " i = (a
        "       + b
        "       + c)
        call cursor(a:lnum, 1)
        let [p, _] = s:SearchBracket(a:lnum, 'bW')
        if p > 0
            if a:0 > 0 && ExtraFunc(p)
                " Currently only used by bitbake
                " Handle first non-empty line inside a bitbake Python task
                if p == plnum
                    return shiftwidth()
                en

                " Handle the user actually trying to close a bitbake Python task
                let line = getline(a:lnum)
                if line =~ '^\s*}'
                    return -2
                en

                " Otherwise ignore the brace
                let p = 0
            el
                if p == plnum
                    " When the start is inside parenthesis, only indent one 'shiftwidth'.
                    let [pp, _] = s:SearchBracket(a:lnum, 'bW')
                    if pp > 0
                        return indent(plnum)
                            \ + get(g:, 'pyindent_nested_paren', g:python_indent.nested_paren)->eval()
                    en
                    return indent(plnum)
                        \ + get(g:, 'pyindent_open_paren', g:python_indent.open_paren)->eval()
                en
                if plnumstart == p
                    return indent(plnum)
                en
                return plindent
            en
        en
    en


    " Get the line and remove a trailing comment.
    " Use syntax highlighting attributes when possible.
    let pline = getline(plnum)
    let pline_len = strlen(pline)
    if has('syntax_items')
        " If the last character in the line is a comment, do a binary search for
        " the start of the comment.  synID() is slow, a linear search would take
        " too long on a long line.
        if synstack(plnum, pline_len)
        \ ->map({_, id -> id->synIDattr('name')})
        \ ->match('\%(Comment\|Todo\)$') >= 0
            let min = 1
            let max = pline_len
            while min < max
        let col = (min + max) / 2
                if synstack(plnum, col)
                \ ->map({_, id -> id->synIDattr('name')})
                \ ->match('\%(Comment\|Todo\)$') >= 0
            let max = col
        el
            let min = col + 1
        en
            endwhile
            let pline = strpart(pline, 0, min - 1)
        en
    el
        let col = 0
        while col < pline_len
            if pline[col] == '#'
        let pline = strpart(pline, 0, col)
        break
            en
            let col = col + 1
        endwhile
    en

    " If the previous line ended with a colon, indent this line
    if pline =~ ':\s*$'
        return plindent + shiftwidth()
    en

    " If the previous line was a stop-execution statement...
    if getline(plnum) =~ '^\s*\(break\|continue\|raise\|return\|pass\)\>'
        " See if the user has already dedented
        if s:Dedented(a:lnum, indent(plnum))
            " If so, trust the user
            return -1
        en
        " If not, recommend one dedent
        return indent(plnum) - shiftwidth()
    en

    " If the current line begins with a keyword that lines up with "try"
    if getline(a:lnum) =~ '^\s*\(except\|finally\)\>'
        let lnum = a:lnum - 1
        while lnum >= 1
            if getline(lnum) =~ '^\s*\(try\|except\)\>'
        let ind = indent(lnum)
        if ind >= indent(a:lnum)
            return -1 " indent is already less than this
        en
        return ind  " line up with previous try or except
            en
            let lnum = lnum - 1
        endwhile
        return -1       " no matching "try"!
    en

    " If the current line begins with a header keyword, dedent
    if getline(a:lnum) =~ '^\s*\(elif\|else\)\>'

        " Unless the previous line was a one-liner
        if getline(plnumstart) =~ '^\s*\(for\|if\|elif\|try\)\>'
            return plindent
        en

        " Or the user has already dedented
        if s:Dedented(a:lnum, plindent)
            return -1
        en

        return plindent - shiftwidth()
    en

    " When after a () construct we probably want to go back to the start line.
    " a = (b
    "       + c)
    " here
    if parlnum > 0
        " ...unless the user has already dedented
        if s:Dedented(a:lnum, plindent)
                return -1
        el
                return plindent
        en
    en

    return -1
endf

let &cpo = s:keepcpo
unlet s:keepcpo
