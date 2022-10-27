" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2022 Mar 01

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
en
let b:did_indent = 1

setl     indentexpr=GetVimIndent()
" *cinkeys-format*  *indentkeys-format*
" 'cinkeys' 'cink'

setl     indentkeys=
setl     indentkeys+=0\\,
                   \=try,
                   \=endf,
                   \=en,
                   \=endif,
                   \=endfor,
                   \=endwh,
                   \=endtry,
                   "\ \=enddef,
                   "\ 这是作者写错了? 还是为了在vim里套其他语言
                   "\ \=},
                   \=el,
                   "\ \=else,
                   \=cat,
                   \=finall,
                   \=END,
                   \0=\"\\
            " 输出是: ¿0="\¿

setl     indentkeys-=0#
setl     indentkeys-=:

let b:undo_indent = "setl indentkeys< indentexpr<"

" Only define the function once.
if exists("*GetVimIndent")
    finish
en
let s:keepcpo= &cpo
set cpo&vim

function GetVimIndent()
    let ignorecase_save = &ignorecase
    try
        let &ignorecase = 0
        return Get_IndenT()
    finally
        " 这有啥会exception的?
        let &ignorecase = ignorecase_save
    endtry
endfunc

                        " ¿\¿或¿"\ ¿
let s:lineContPat = '\v^\s*(\\|"\\ )'


function Get_IndenT()
    " Find a non-blank line above the current line.
    let lnum = prevnonblank(v:lnum - 1)

    " The previous line, ignoring line continuation
    let prev_text_end = lnum > 0 ?
                    \ getline(lnum)
                    \ : ''

    let cur_text = getline(v:lnum)
    if cur_text  !~  s:lineContPat
    " If the current line doesn't start with '\' or ¿"\ ¿ and
    " below a line that  starts with '\' or '"\ ',
    " use the indent of ¿the line above it¿.
        while lnum > 0 &&
                      \ getline(lnum) =~  s:lineContPat
            let lnum = lnum - 1
        endwhile
    en

    if lnum == 0
    " At the start of the file
        " use zero indent.
        return 0
    en

    " the start of the previous line,
    " skipping over line continuation
    let prev_text  = getline(lnum)
    let found_cont = 0

    " Add a 'shiftwidth' after
        " :if, :while, :try, :catch, :finally, :function  a :else.
    " Add it three times for
        " a line that
            " starts with '\' or '"\ '
            " after a line that doesn't (or g:vim_indent_cont if it exists).
    let ind = indent(lnum)

    " In heredoc
        " indenting works completely differently.
        if has('syntax_items')
            let syn_here = synIDattr(
                \ synID(v:lnum, 1, 1),
                \ "name",
               \ )
            if syn_here =~ 'vimLetHereDocStop'
                " End of heredoc:
                " use indent of matching start line
                let lnum = v:lnum - 1
                while lnum > 0
                    let attr = synIDattr(
                                    \ synID(lnum, 1, 1),
                                    \ "name",
                                   \ )
                    if attr != '' &&
                                \ attr !~ 'vimLetHereDoc'
                        return indent(lnum)
                    en
                    let lnum -= 1
                endwhile
                return 0
            en
            if syn_here =~ 'vimLetHereDoc'
                if synIDattr(synID(lnum, 1, 1), "name") !~ 'vimLetHereDoc'
                    " First line in heredoc: increase indent
                    return ind + shiftwidth()
                en
                " Heredoc continues: no change in indent
                return ind
            en
        en

    if cur_text =~ s:lineContPat && v:lnum > 1 && prev_text !~ s:lineContPat
        let found_cont = 1
        if exists("g:vim_indent_cont")
            let ind = ind + g:vim_indent_cont
        el
            let ind = ind + shiftwidth() * 3
        en
    elseif prev_text =~ '^\s*aug\%[roup]\s\+' && prev_text !~ '^\s*aug\%[roup]\s\+[eE][nN][dD]\>'
        let ind = ind + shiftwidth()
    el
        " A line starting with :au does not increment/decrement indent.
        " A { may start a block or a dict.  Assume that when a } follows it's a
        " terminated dict.
        " ":function" starts a block but "function(" doesn't.
        if prev_text !~ '^\s*au\%[tocmd]' && prev_text !~ '^\s*{.*}'
            let i = match(prev_text, '\(^\||\)\s*\(export\s\+\)\?\({\|\(if\|wh\%[ile]\|for\|try\|cat\%[ch]\|fina\|finall\%[y]\|def\|el\%[seif]\)\>\|fu\%[nction][! ]\)')
            if i >= 0
                let ind += shiftwidth()
    if strpart(prev_text, i, 1) == '|' && has('syntax_items')
                \ && synIDattr(synID(lnum, i, 1), "name") =~ '\(Comment\|String\|PatSep\)$'
        let ind -= shiftwidth()
    en
            en
        en
    en

    " If the previous line contains an "end" after a pipe, but not in an ":au"
    " command.  And not when there is a backslash before the pipe.
    " And when syntax HL is enabled avoid a match inside a string.
    let i = match(prev_text, '[^\\]|\s*\(ene\@!\)')
    if i > 0 && prev_text !~ '^\s*au\%[tocmd]'
        if !has('syntax_items') || synIDattr(synID(lnum, i + 2, 1), "name") !~ '\(Comment\|String\)$'
            let ind = ind - shiftwidth()
        en
    en

    " For a line starting with "}" find the matching "{".  If it is at the start
    " of the line align with it, probably end of a block.
    " Use the mapped "%" from matchit to find the match, otherwise we may match
    " a { inside a comment or string.
    if cur_text =~ '^\s*}'
        if maparg('%') != ''
            exe v:lnum
            silent! normal %
            if line('.') < v:lnum && getline('.') =~ '^\s*{'
    let ind = indent('.')
            en
        el
            " todo: use searchpair() to find a match
        en
    en

    " Below a line starting with "}" find the matching "{".  If it is at the
    " end of the line we must be below the end of a dictionary.
    if prev_text =~ '^\s*}'
        if maparg('%') != ''
            exe lnum
            silent! normal %
            if line('.') == lnum || getline('.') !~ '^\s*{'
    let ind = ind - shiftwidth()
            en
        el
            " todo: use searchpair() to find a match
        en
    en

    " Below a line starting with "]" we must be below the end of a list.
    " Include a "}" and "},} in case a dictionary ends too.
    if prev_text_end =~ '^\s*\(},\=\s*\)\=]'
        let ind = ind - shiftwidth()
    en

    let ends_in_comment = has('syntax_items')
    \ && synIDattr(synID(lnum, len(getline(lnum)), 1), "name") =~ '\(Comment\|String\)$'

    " A line ending in "{" or "[" is most likely the start of a dict/list literal,
    " indent the next line more.  Not for a continuation line or {{{.
    if !ends_in_comment && prev_text_end =~ '\s[{[]\s*$' && !found_cont
        let ind = ind + shiftwidth()
    en

    " Subtract a 'shiftwidth' on a :endif, :endwhile, :endfor, :catch, :finally,
    " :endtry, :endfun, :enddef, :else and :augroup END.
    " Although ":en" would be enough
    " only match short command names as in  'indentkeys'.
    if cur_text =~ '\v^\s*(endif|endwh|endtry|endf|enddef|cat|finall|el|else|
                        \aug%[roup]\s+[eE][nN][dD])'
                         " augroup end
        let ind = ind - shiftwidth()
        echom '缩回去________________'
        if ind < 0
            let ind = 0
        en
    en

    return ind
endf

let &cpo = s:keepcpo
unlet s:keepcpo

