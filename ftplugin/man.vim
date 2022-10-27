" au AG BufEnter  *.man  setl     ft=man 没生效

if exists('b:did_ftplugin') || &filetype !=# 'man'
"\ 这用这样基本就够了?:
"\ if exists('b:did_ftplugin')
    finish
en
let b:did_ftplugin = 1

" lua require("man").highlight_man_page()

" 刚进入.man文件时,&ft是nroff,
" 再次进入其buffer时, &ft变为man:
    " echom 'ftplugin/man.vim里显示: &ft &syntax是:'
    " echom &ft &syntax
    " echom 'ftplugin/man.vim里显示: &ft &syntax是:----------'

nno <silent> <buffer> go  :call man#TOC_leo()<cr>:call docS#Toc_beautify()<CR>

nno <silent> <buffer>          <2-LeftMouse> :Man<CR>
nno <silent> <buffer> <nowait> q             :lclose<CR><C-W>c
nno <buffer>                   si             <cmd>call man#Short_maN()<cr>


" setl     iskeyword=@-@,:,a-z,A-Z,48-57,_,.,-,(,)
    " Parentheses and '-' for references like `git-ls-files(1)`;
    " '@' for systemd  pages;
    " ':' for Perl and C++ pages.
    " Here, I intentionally omit the locale  specific characters matched by `@`.

" setl     tagfunc=man#goto_tag

" slow down vim:
    " setl     foldenable
    " setl     foldmethod=indent
    " setl     foldnestmax=4  " 默认的是1, 防止太慢?
    " setl     ts=4

let b:undo_ftplugin = ''

au AG BufModifiedSet *.man silent! write!
                          " 这个避免每次要敲Yes

                                    " 我diy后, 打开.man文件就会修改,
                                    " 所以换buffer前要保存文件
                                    " 因为在其他地方设了set confirm (不设confirm,就会保存失败 导致换buffer失败?)
                                    " 每次打开都提示wirte or not
                                    "

    " 这几个会触发很多次
    " au AG FileType                man silent! write! | echom 'asdfasdf'
    " au AG BufRead,BufNewFile     *.man  silent! write!
