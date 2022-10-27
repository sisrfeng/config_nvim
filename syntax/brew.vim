" Language:   Homebrew Formula
" URL:	      https://github.com/xu-cheng/brew.vim

if exists("b:current_syntax")
    finish
en

" Load ruby syntax
source $VIMRUNTIME/syntax/ruby.vim
unlet b:current_syntax

" Load git syntax into @Git
syn include @Git $VIMRUNTIME/syntax/git.vim

" Link __END__ block to git syntax
syn region brewPatch matchgroup=rubyDataDirective start="^__END__$" end="\%$" contains=@Git, brewPatch fold

let b:current_syntax = "brew"

