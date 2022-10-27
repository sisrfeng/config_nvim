" Language:   Homebrew Formula
" URL:	      https://github.com/xu-cheng/brew.vim

fun! s:isFormula()
    for i in range(1, line('$'))
        if !empty(matchstr(getline(i), 'class \S\+ *< *Formula'))
            return 1
        en
    endfor
    return 0
endf

fun! s:setFileType()
    set filetype=ruby
    if s:isFormula()
        set syntax=brew
    en
endf

aug  brew_formula_file_detect
    au!
    au BufNewFile,BufRead *.rb call s:setFileType()
aug  END

