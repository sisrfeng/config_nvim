" Maintainer: Anmol Sethi <hi@nhooyr.io>
" 让任何buffer里都能用:Man, 所以要在plugin/ 而非ftplugin/

if exists('g:loaded_man')
  finish
endif
let g:loaded_man = 1

command! -bang -bar -addr=other -complete=customlist,man#complete -nargs=*
        \ Man
        \ if <bang>0
            \| call man#init_pager()
        \| else
            \| call man#open_page(<count>, <q-mods>, <f-args>)
        \| endif

augroup man
  autocmd!
  autocmd BufReadCmd  man://*
      \ call man#read_page(matchstr(expand('<amatch>'), 'man://\zs.*'))
      \| echom "/home/wf/dotF/cfg/nvim/plugin/man.vim"
augroup END
