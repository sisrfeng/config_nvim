" Homepage:    https://github.com/cespare/vim-toml

if exists('b:did_ftplugin')  | finish  | endif  | let b:did_ftplugin = 1

let s:save_cpo = &cpo  | set cpo&vim
let b:undo_ftplugin = 'setlocal commentstring< comments<'

setlocal commentstring=#\ %s

setlocal comments=:#
"\ setlocal comments=b:#
                  "\ b表示 井号后面要有blank


let &cpo = s:save_cpo  | unlet s:save_cpo
