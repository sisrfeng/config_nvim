" Vim syntax file
  " Language:         JSONC (JSON with Comments)
  " Original Author:  Izhak Jakov <izhak724@gmail.com>
  " Acknowledgement:  Based off of vim-jsonc maintained by Kevin Locke <kevin@kevinlocke.name>
  "                   https://github.com/kevinoid/vim-jsonc
  " License:          MIT
  " Last Change:      2021-07-01
  " Version:          0.1.0

" Ensure syntax is loaded once, unless nested inside another (main) syntax

" main_syntax
    " Some syntax scripts support being imported into another syntax via :syntax include,
    " e.g.
    " javascript inside html.
    " The main_syntax variable keeps track which
    " syntax was actually set by the user / filetype;
    " included syntax scripts then ✌omit the clearing of existing syntax✌ items when this variable is set.
    " (Whereas syntax scripts are supposed to :finish without any actions if b:current_syntax is set.)
    " Another difference to b:current_syntax is that
    " main_syntax is only defined during the actual syntax loading process,
    "   whereas the other persists.
    "
    " TL;DR:
    " If you support including / include other syntaxes yourself,
    " copy the conditional boilerplate from an existing syntax,
    " e.g.
    " $VIMRUNTIME /syntax/html.vim;
    " if not,
    " you can ignore this.

    " There's no explicit documentation,
    " but several syntaxes that ship with Vim use main_syntax.
    " As most syntax authors base their syntaxes on those,
    " it's a strong convention,
    " and probably also supported by Bram.
    " If you think this should be documented,
    " please submit a doc patch!


if !exists('g:main_syntax')
    if exists('b:current_syntax') && b:current_syntax ==# 'jsonc'
        finish
    en
    let g:main_syntax = 'jsonc'
en

" Based on vim-json syntax
runtime! syntax/json.vim

" Remove syntax group for comments treated as errors
if !exists("g:vim_json_warnings") || g:vim_json_warnings
    syn clear jsonCommentError
en

syn match jsonStringMatch /"\([^"]\|\\\"\)\+"\ze\(\_s*\/\/.*\_s*\)*[}\]]/ contains=jsonString
syn match jsonStringMatch /"\([^"]\|\\\"\)\+"\ze\_s*\/\*\_.*\*\/\_s*[}\]]/ contains=jsonString
syn match jsonTrailingCommaError /\(,\)\+\ze\(\_s*\/\/.*\_s*\)*[}\]]/
syn match jsonTrailingCommaError /\(,\)\+\ze\_s*\/\*\_.*\*\/\_s*[}\]]/

" Define syntax matching comments and their contents
syn keyword jsonCommentTodo  FIXME NOTE TBD TODO XXX
syn region  jsonLineComment  start=+\/\/+ end=+$+   contains=@Spell,jsonCommentTodo keepend
syn region  jsonComment      start='/\*'  end='\*/' contains=@Spell,jsonCommentTodo fold

" Link comment syntax comment to highlighting
hi! def link jsonLineComment    Comment
hi! def link jsonComment        Comment

" Set/Unset syntax to avoid duplicate inclusion and correctly handle nesting
let b:current_syntax = 'jsonc'
if g:main_syntax ==# 'jsonc'
    unlet g:main_syntax
en
