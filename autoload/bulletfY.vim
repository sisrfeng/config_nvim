" Vim global plugin for list format translations
" https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup
" https://github.com/snaewe/Instantly_Better_Vim_2013/blob/master/Notes.pdf

if exists("loaded_bulletfY")
    finish
endif
let loaded_bulletfY = 1

let s:save_cpo = &cpo
set cpo&vim

" Useful constants...
    let g:List_Conjunc = 'and'
    let g:ConjuncS  = [
    \   'and\s\+not', 'and', 'plus', 'with',
    \   'or\s\+else', 'or\s\+otherwise',
    \   'or', 'nor', 'but\s\+not', 'but',
    \   'else', 'otherwise'
    \]

" between A and B
" A or B
        " let g:split_inside .= '<between.{-}\zs \zeand>|'
        "
        " let g:split_inside .= '<\w+ .{-}\zs \zeor>|'


" Build the pattern...
    let s:Conj_Pat = join(g:ConjuncS, '\|')

fu! bulletfY#ConverT (...) range
    " Copy the target text...
        if a:0
            silent normal! gvy
        else
            silent normal! vipy
        endif
        let text = getreg("")

    " Remember the indent and any bullet...
        let [match, indent, bullet; etc] = matchlist(text, '\v^(\s*)([^A-Za-z \t]*\s*)')
                                                                      " 刨掉空格和字母的字符, 剩下标点?
                                  "´;´后的变量, 此处是etc
                                  "        A list of the remaining items is assigned to {lastname}.
        echom "match"   match
        echom "indent"  indent
        echom "bullet"  bullet
        echom "etc"     etc


    if strlen(bullet) > 0  " bullet = '-'吧
        " If it starts with a bullet(减号), are there more bullets?
        let items = split(substitute(text, '^\s*\V' .. bullet, '',''),
                        \ '\n\s*\V' .. bullet)
        call map(items, 'substitute(v:val,''[[:space:]]\+''," ","g")')
        call map(items, 'substitute(v:val,''[[:space:]]$'',"","")')
        exec 'silent % sub #' .. '\v^\s*.{2,10}\zs,$'   .. '##ge'

        " If two or more bulleted items, convert  bullet list --> text list
        if len(items) >= 2
            " Infer the correct conjunction...
            let has_conj = matchlist(items[-2], '^\(\_.\{-}\)[,;]\?\s*\('.s:Conj_Pat.'\)\s*$')
            let [items[-2], conj] = len(has_conj) ?
                                  \ has_conj[1:2]  :
                                  \ [items[-2], g:List_Conjunc]

            " Conjoin the various items (using Oxford rules)...
            "  Oxford rules:
                    " Use a comma between items in a list.
                            " I have nothing to offer but blood, toil, tears and sweat.
                        " There is no comma between the
                            " penultimate item in a list and  ‘and’/‘or’,
                        " Exception:
                            " comma can prevent ambiguity/confusion
                                " I ate fish and chips, bread and jam, and ice cream.
                                " We studied George III, William and Mary, and Henry VIII.
                                "                                      这叫做 ´Oxford comma´

                            " Those who oppose the Oxford comma argue that
                            "     rephrasing an already unclear sentence can solve the same problems that using the Oxford comma does.
                            "     For example:

                                "        I love my parents, Lady Gaga and Humpty Dumpty.
                                "     could be rewritten as:
                                "       I love Lady Gaga, Humpty Dumpty and my parents.
            if len(items) == 2
                let sep  = len(filter(copy(items), 'v:val =~ ","')) ?
                          \ ', '
                          \: ' '
                let reformatted_text = indent .. join(items,  sep..conj..' ')
            else
                let sep  = len(filter(copy(items), 'v:val =~ ","'))
                          \ ? '; '
                          \ : ', '
                let reformatted_text = indent . join(items[0:-2], sep)
                                   \ . sep . conj . ' '
                                   \ . items[-1]
            endif

            " Paste back into buffer in place of original...
            call setreg("", reformatted_text, mode())
            silent normal! gv""p
            return
        endif

    else
    " Otherwise, convert text list --> bullet list...

        " Identify and remove initial indent...
        let [match, indent, text; etc] = matchlist(text, '^\(\s*\)\(\_.*\)')

        " Minimize whitespace...
        let text = substitute(text,'[[:space:]]\+'," ",'g')
        let text = substitute(text,'[[:space:]]\+$','','')

        " Identify most likely separator...
        let sep = text =~ ';' ? '\s*;\s*'
              \ : text =~ ',' ? '\s*,\s*'
              \ :               '\s\+\(' . s:Conj_Pat . '\)\s\+'

        " Separate...
        let items = split(text, sep)

        " Check for an extra conjunction in the last item...
        let last_item = remove(items, -1)
        let last_sep = matchstr(last_item, '^\s*\(' . s:Conj_Pat . '\)\>\s*')
        if strlen(last_sep)
            let [last_item] = split(last_item, '\s*\(' . s:Conj_Pat . '\)\s\+')
            if last_sep !~ '^\s*\(and\|plus\)'
                let items[-1] .= ', ' . last_sep
            endif
        endif
        let items += [last_item]

        " Rejoin and paste back into buffer in place of original...
        let reformatted_text = join(map(items, 'indent."- ".v:val."\n"'), "")
        call setreg("", reformatted_text, mode())
        silent normal! gv""p
    endif

endf

let &cpo = s:save_cpo
