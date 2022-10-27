if exists('b:did_ftplugin')  | finish  | endif

let s:cpo = &cpo  | set cpo&vim

setl lisp
setl comments=:;;;;,:;;;,:;;,:;,sr:#\|,mb:\|,ex:\|#
setl commentstring=;%s
setl define=^\\s*(def\\k*
setl iskeyword=33,35-39,42-43,45-58,60-90,94,95,97-122,126

let b:undo_ftplugin = 'setl lisp< comments< commentstring< define< iskeyword<'

"\ 影响indent
setl lispwords+=case,
               \define,
               \define-record-type,
               \define-syntax,
               \define-values,
               \do,
               \guard,
               \lambda,
               \let,
               \let*,
               \let*-values,
               \let-syntax,
               \let-values,
               \letrec,
               \letrec*,
               \letrec-syntax,
               \parameterize,
               \set!,
               \syntax-rules,
               \unless,
                \when

let b:undo_ftplugin = b:undo_ftplugin . ' lispwords<'

let b:did_scheme_ftplugin = 1

if exists('b:is_chicken') || exists('g:is_chicken')
  runtime! ftplugin/chicken.vim
endif

unlet b:did_scheme_ftplugin
let b:did_ftplugin = 1

let &cpo = s:cpo  | unlet s:cpo

" Language: Scheme (R7RS)
" Last Change: 2019-11-19
" Author: Evan Hanson <evhan@foldling.org>
" Repository: https://git.foldling.org/vim-scheme.git
" URL: https://foldling.org/vim/ftplugin/scheme.vim


