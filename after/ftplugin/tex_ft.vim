" Maintainer: Karl Yngve Lervåg
" 从vimtex里剪切过来的

" 改了此文件要重启 因为
" let b:did_ftplugin_vimtex = 1太靠后?

" Some checK

    if !get(g:, 'vimtex_enabled', 1)
        " *g:vimtex_enabled*
            " Set to 0 to disable VimTeX.
            " Default value: Undefined.
        " 默认情况, 不会在这里finish
        finish
    endif


    if exists('b:did_ftplugin_vimtex')
        " b:did_ftplugin常见, 加_vimtex等形式 独此一家
        " 因为是在after目录, 如果不加'_vimtex', 会被前面/Tex/ftplugin/tex.vim挡住吧
        finish
    endif
    let b:did_ftplugin_vimtex = 1
        " 避免同一个.tex里反复source此文件吧

        " 覆盖插件vimtex里的同名文件?
        "   不
        "   $nV的after目录 在插件的after之后 才被source
          " 插件vimtex里的同名文件的  let b:did_ftplugin_vimtex = 1
          " 会'挡住'此文件

    " Check for plugin clashes.
    " Note: This duplicates the code in health/vimtex.vim:s:check_plugin_clash()
    let s:scriptnames = vimtex#util#command('scriptnames')


    let s:latexbox = !empty(filter(copy(s:scriptnames), "v:val =~# 'latex-box'"))
    if s:latexbox
        call vimtex#log#warning([
                    \ 'Conflicting plugin detected: LaTeX-Box',
                    \ 'VimTeX does not work as expected when LaTeX-Box is installed!',
                    \ 'Please disable or remove it to use VimTeX!',
                    \])
    endif


" 我自己的内容, 放到了 /home/wf/dotF/cfg/nvim/after/syntax/tex.vim
" syntax文件可以放any Ex command


