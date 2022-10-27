"\ 这个文件应该没什么用了.

" 虽然man的内容由groff/nroff处理, 但我基本不直接写nroff


"\ ========================================

if exists("b:did_ftplugin")  | finish  | endif


"\ au AG BufEnter  *.man  setlocal ft=man
    "\ 这行导致  /home/wf/dotF/cfg/nvim/ftplugin/man.vim 里的
    "\ au AG BufModifiedSet *.man silent! write!
    "\ 会造出上百个同样的autocmd?



"\ /home/linuxbrew/.linuxbrew/Cellar/neovim/0.7.2_1/share/nvim/runtime/filetype.vim
"\ 里面有:
    "\ " Manpage
    "\ au BufNewFile,BufRead *.man			setf nroff
    "\
    "\ " Man config
    "\ au BufNewFile,BufRead */etc/man.conf,man.config	setf manconf

finish


" 下面的应该都没用了
" let b:did_ftplugin = 1

" .man文件的&ft是nroff
" 敲:Man后 &ft才是man
        " echom 'nroff 文件里:&ft &syntax是:'
        " echom &ft &syntax
        " echom 'nroff 文件里:&ft &syntax是----'


" 下面是从  /home/wf/dotF/cfg/nvim/ftplugin/man.vim 复制来的有效部分

    nnor <silent> <buffer> go  :call man#TOC_leo()<cr>:call docS#Toc_beautify()<CR>
    nnor <silent> <buffer> q   q
                                              " 默认的设置是:按q退出
    exec '% subs#\v\S\zs  \ze\S# #ge'
        " 2个空格变1个


    " 官方的ftplugin/man.vim有用的部分:

        setlocal iskeyword=@-@,:,a-z,A-Z,48-57,_,.,-,(,)
          " Parentheses and '-' for references like `git-ls-files(1)`; '@' for systemd
          " pages; ':' for Perl and C++ pages.  Here, I intentionally omit the locale
          " specific characters matched by `@`.


        setlocal tagfunc=man#goto_tag

        if !exists('g:no_plugin_maps') && !exists('g:no_man_maps')
          nnoremap <silent> <buffer> <2-LeftMouse> :Man<CR>
          nnoremap <silent> <buffer> <nowait> q :lclose<CR><C-W>c
        endif

        if get(g:, 'ft_man_folding_enable', 0)
          setlocal foldenable
          setlocal foldmethod=indent
          setlocal foldnestmax=1
        endif

        let b:undo_ftplugin = ''
