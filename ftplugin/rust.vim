" Maintainer:	Chris Morgan <me@chrismorgan.info>
" Maintainer:	Kevin Ballard <kevin@sb.org>
" Last Change:	June 08, 2016
" For bugs, patches and license go to https://github.com/rust-lang/rust.vim

if exists("b:did_ftplugin")
    finish
en
let b:did_ftplugin = 1

let s:save_cpo = &cpo  | set cpo&vim

aug  rust.vim
au!

" Variables {{{1

if exists("g:rust_bang_comment_leader")
\ && g:rust_bang_comment_leader != 0
" The rust source code at present seems to typically
        " omit a leader on /*!  comments,
        " so we'll use that as our default,
        " but make it easy to switch.
        " This does not affect indentation at all
        " (I tested it with and without  leader),
        " merely whether a leader is inserted by default or not.

	setl  comments=s1:/*,mb:*,ex:*/,s0:/*,mb:\ ,ex:*/,:///,://!,://
        " Why is the `,s0:/*,mb:\ ,ex:*/` there,
        " I don't understand why,
        " but without it,
        " */ gets indented one space even if there were no  leaders.
            " I'm fairly sure that's a Vim bug.
el
	setl  comments=s0:/*!,m:\ ,ex:*/,s1:/*,mb:*,ex:*/,:///,://!,://
en
setl  commentstring=//%s
setl  formatoptions-=t formatoptions+=croqnl
" j was only added in 7.3.541,
" so stop complaints about its nonexistence
silent! setl  formatoptions+=j

" smartindent will be overridden by
" indentexpr if filetype indent is on,
" but  otherwise it's better than nothing.
setl  smartindent nocindent

if !exists("g:rust_recommended_style")
\ || g:rust_recommended_style != 0
	setl  tabstop=4 shiftwidth=4 softtabstop=4 expandtab
	setl  textwidth=99
en

" This includeexpr isn't perfect, but it's a good start
setl  includeexpr=substitute(v:fname,'::','/','g')

setl  suffixesadd=.rs

if exists("g:ftplugin_rust_source_path")
    let &l:path=g:ftplugin_rust_source_path . ',' . &l:path
en

if exists("g:loaded_delimitMate")
	if exists("b:delimitMate_excluded_regions")
		let b:rust_original_delimitMate_excluded_regions = b:delimitMate_excluded_regions
	en

	let s:delimitMate_extra_excluded_regions = ',rustLifetimeCandidate,rustGenericLifetimeCandidate'

	" For this buffer,
    " when delimitMate issues
    " the `User delimitMate_map`  event in the autocommand system,
    " add the above-defined extra excluded  regions to delimitMate's state,
    " if they have not already been added.
	au User <buffer>
		\ if expand('<afile>') ==# 'delimitMate_map'
          \ && match( delimitMate#Get("excluded_regions"),
                \     s:delimitMate_extra_excluded_regions
                  \ ) == -1
		\|  let b:delimitMate_excluded_regions =
		\	delimitMate#Get("excluded_regions")
		\	. s:delimitMate_extra_excluded_regions
		\|endif

	" For this buffer,
    " when delimitMate issues the `User delimitMate_unmap`
	" event in the autocommand system,
    " delete the above-defined extra excluded  regions from delimitMate's state
    " (the deletion being idempotent and  having no effect
    " if the extra excluded regions are not present in the  targeted part of delimitMate's state).
	au User <buffer>
		\ if expand('<afile>') ==# 'delimitMate_unmap'
		\|  let b:delimitMate_excluded_regions = substitute(
		\	delimitMate#Get("excluded_regions"),
		\	'\C\V' . s:delimitMate_extra_excluded_regions,
		\	'', 'g')
		\|endif
en

if has("folding")
\ && exists('g:rust_fold')
\ && g:rust_fold != 0
	let b:rust_set_foldmethod=1
	setl  foldmethod=syntax
	if g:rust_fold == 2
		setl  foldlevel<
	el
		setl  foldlevel=99
	en
en

if has('conceal')
\ && exists('g:rust_conceal')
\ && g:rust_conceal != 0
	let b:rust_set_conceallevel=1
	setl  conceallevel=2
en


" Bind motion commands to support hanging indents
nno  <silent> <buffer> [[ :call rust#Jump('n', 'Back')<CR>
nno  <silent> <buffer> ]] :call rust#Jump('n', 'Forward')<CR>
xno  <silent> <buffer> [[ :call rust#Jump('v', 'Back')<CR>
xno  <silent> <buffer> ]] :call rust#Jump('v', 'Forward')<CR>
ono  <silent> <buffer> [[ :call rust#Jump('o', 'Back')<CR>
ono  <silent> <buffer> ]] :call rust#Jump('o', 'Forward')<CR>

" Commands {{{1

" See |:RustRun| for docs
com!  -nargs=* -complete=file -bang -buffer
  \ RustRun
  \ call rust#Run(<bang>0, <q-args>)

" See |:RustExpand| for docs
com!  -nargs=* -complete=customlist,rust#CompleteExpand -bang -buffer
  \ RustExpand
  \ call rust#Expand(<bang>0, <q-args>)

" See |:RustEmitIr| for docs
com!  -nargs=* -buffer RustEmitIr call rust#Emit("llvm-ir", <q-args>)

" See |:RustEmitAsm| for docs
com!  -nargs=* -buffer RustEmitAsm call rust#Emit("asm", <q-args>)

" See |:RustPlay| for docs
com!  -range=% RustPlay :call rust#Play(<count>, <line1>, <line2>, <f-args>)

" See |:RustFmt| for docs
com!  -buffer RustFmt call rustfmt#Format()

" See |:RustFmtRange| for docs
com!  -range -buffer RustFmtRange call rustfmt#FormatRange(<line1>, <line2>)

" Mappings {{{1

" Bind ⌘R in MacVim to :RustRun
nno  <silent> <buffer> <D-r> :RustRun<CR>
" Bind ⌘⇧R in MacVim to :RustRun! pre-filled with the last args
nno  <buffer> <D-R> :RustRun! <C-r>=join(b:rust_last_rustc_args)<CR><C-\>erust#AppendCmdLine(' -- ' . join(b:rust_last_args))<CR>

if !exists("b:rust_last_rustc_args")
\ || !exists("b:rust_last_args")
	let b:rust_last_rustc_args = []
	let b:rust_last_args = []
en

" Cleanup {{{1

let b:undo_ftplugin = "
		\ setl  formatoptions< comments< commentstring< includeexpr< suffixesadd<
		\|setl  tabstop< shiftwidth< softtabstop< expandtab< textwidth<
		\|if exists('b:rust_original_delimitMate_excluded_regions')
		  \|let b:delimitMate_excluded_regions = b:rust_original_delimitMate_excluded_regions
		  \|unlet b:rust_original_delimitMate_excluded_regions
		\|else
		  \|unlet! b:delimitMate_excluded_regions
		\|endif
		\|if exists('b:rust_set_foldmethod')
		  \|setl  foldmethod< foldlevel<
		  \|unlet b:rust_set_foldmethod
		\|endif
		\|if exists('b:rust_set_conceallevel')
		  \|setl  conceallevel<
		  \|unlet b:rust_set_conceallevel
		\|endif
		\|unlet! b:rust_last_rustc_args b:rust_last_args
		\|delcommand RustRun
		\|delcommand RustExpand
		\|delcommand RustEmitIr
		\|delcommand RustEmitAsm
		\|delcommand RustPlay
		\|nunmap <buffer> <D-r>
		\|nunmap <buffer> <D-R>
		\|nunmap <buffer> [[
		\|nunmap <buffer> ]]
		\|xunmap <buffer> [[
		\|xunmap <buffer> ]]
		\|ounmap <buffer> [[
		\|ounmap <buffer> ]]
		\|set matchpairs-=<:>
		\"



" Code formatting on save
if get(g:, "rustfmt_autosave", 0)
	au BufWritePre *.rs silent! call rustfmt#Format()
en

aug  END

let &cpo = s:save_cpo  | unlet s:save_cpo

