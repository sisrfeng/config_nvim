if exists('b:did_indent')
    finish
en

if !get(g:, 'vimtex_indent_bib_enabled', 1) | finish | endif

let b:did_indent = 1

let s:cpo_save = &cpo
set cpo&vim

setl  autoindent
setl  indentexpr=VimtexIndentBib()

fun! VimtexIndentBib() abort
    " Find first non-blank line above the current line
    let lnum = prevnonblank(v:lnum - 1)
    if lnum == 0
        return 0
    en

    " Get some initial conditions
    let ind   = indent(lnum)
    let line  = getline(lnum)
    let cline = getline(v:lnum)
    let g:test = 1

    " Zero indent for first line of each entry
    if cline =~# '^\s*@'
        return 0
    en

    " Title line of entry
    if line =~# '^@'
        if cline =~# '^\s*}'
            return 0
        el
            return &sw
        en
    en

    if line =~# '='
        " Indent continued bib info entries
        if s:count('{', line) - s:count('}', line) > 0
            let match = searchpos('.*=\s*{','bcne')
            return match[1]
        elseif cline =~# '^\s*}'
            return 0
        en
    elseif s:count('{', line) - s:count('}', line) < 0
        if s:count('{', cline) - s:count('}', cline) < 0
            return 0
        el
            return &sw
        en
    en

    return ind
endf

fun! s:count(pattern, line) abort " {{{1
    let sum = 0
    let indx = match(a:line, a:pattern)
    while indx >= 0
        let sum += 1
        let indx += 1
        let indx = match(a:line, a:pattern, indx)
    endwhile
    return sum
endf


let &cpo = s:cpo_save
unlet s:cpo_save
