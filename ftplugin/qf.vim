if exists("b:did_ftplugin")
    finish
en

let b:did_ftplugin = 1

"\ statusline
    let b:undo_ftplugin = "set stl<"
    " Display the command that produced the list in the quickfix window:
        "\ setl   stl=%1*第%l行
        "\ setl   stl+=\ 第%v列
        "\ 需要再set number

        setl   stl=%#Hi_status_2#
        setl   stl+=%{exists('w:quickfix_title')?\ w:quickfix_title\[:90]\ :\ ''}
        "\ setl   stl+=\ qf\ \|
    " setl     stl+=\ %=%-15(%l,%c%V%)\ %P
                     " -   Left justify the item.
                     "     The default is right justified  when minwid is larger than the length of the item.

"\ setl
    "\ buftype和win_gettype():
        "\ copen后, setl buftype?      显示quickfix,
        "\         echo win_gettype()  显示 quickfix

        "\ 再set buftype=nofile
        "\         echo win_gettype() 显示空白

    setl modifiable
    setl nowinfixheight

    setl concealcursor=n
    setl winwidth=40
        "\ au AG WinEnter * if &buftype == 'quickfix' | setl winwidth=60 | endif
        "\ au AG WinEnter * if win_gettype() == 'loclist' || win_gettype() == 'quickfix'
        "\                 \|   setl winwidth=88
        "\                 \| endif

        "\ au AG WinLeave * if win_gettype() == 'loclist' || win_gettype() == 'quickfix'
        "\                 au! AG WinEnter

"\ map
    nno <buffer>  <cr>   <cr>
        " 覆盖全局的这个:  " nno <CR> <c-]>
    nno <buffer>  go    <cmd>bdelete!<cr>
    nno <buffer>  q     <cmd>bdelete!<cr>

"\ autocmd
    fun! s:setup_toc() abort
        if get(w:, 'quickfix_title') !~? '\<toc$' || &syntax != 'qf'
            return
        en

        let a_list = getloclist(0)
                    "\ qflist呢? toc只用loclist?


        if empty(a_list)  | return  | en

        let buf_Num = a_list[0].bufnr
        silent %delete _
            " 把quickfix buffer的内容清空
        let a_list_copy = deepcopy(a_list)
        " 过滤a_list:
            " map用作method
                " 这里用lambda表达式作为map的参数,
                " 2个输出变量名随意
        " 不加silent, 会echo  a_list的定义和内容
        silent let a_list ->map( {key_not_changed,
                                \ a_line_in_list ->
                                \ "|" . printf('%4d', a_line_in_list.lnum) . "| " . a_line_in_list.text
                                \ }
                            \ )
        " let a_list ->map({key_not_changed, a_line_in_list ->
        "             \ "|" .. printf('%4d', a_line_in_list.lnum) .. "| " .. a_line_in_list.text } )
        " echo a_list

        call setline(1, a_list)


        setl  nomodified
        "\ setl  nomodifiable nomodified
        let &syntax = getbufvar(buf_Num, '&syntax')
                " 让quickfix的buffer的syntax与所存内容的syntax一致

        " extract all line_numbers
    return a_list_copy ->map({
                            \ key_uselss,
                            \ a_line_in_list ->a_line_in_list.lnum
                      \ })
                            "\ \ a_line_in_list ->a_line_in_list.lnum,
                                                                    "\ 这个逗号会导致出错
    endf

    fun! s:Clean_qF()
        setl modifiable  "\ 不加这行会报错(哪怕本文件前半部分 有setl modifiable)
        if w:quickfix_title == ':Messages' || w:quickfix_title == ':Quickfix'
            sil % sub #\v^.{-}\d+ changes?; before .\d+\s+.*\n##ge
            sil % sub #\v^.{-}\d+ change?; after .\d+\s+.*\n##ge
            sil % sub #\v^.{-}\d+ fewer lines.*\n##ge
            sil % sub #\v^.{-}\d+ more lines.*\n##ge
            sil % sub #\v^.{-}\d+ substitutions on.*\n##ge

            sil % sub #\v^.{-}\d+L, \d+B.*\n##ge
            sil % sub #\v^.{-}\d+L, \d+B.*\n##ge

            "\ sil % sub #\v^$\r^$\n##gce
            sil % sub #\v^.*Error detected while processing function\n##ge
            sil % sub #\v^.*Error detected while processing\n##ge

            sil % sub #\v^.*\d+ lines --\d+\%--.*\n##ge
                    "\ 显示文件信息

            sil % sub #\v^.{-}Already at %(new|old)est change\n##ge
            sil % sub #\v^.{-}"\f+" \d+L, \d+B written$\n##ge
            sil % sub #\v^.{-}search hit BOTTOM, continuing at TOP\n##ge
            sil % sub #\v^.{-}replace with .{-} \(y\/n\/a\/q\/l\/\^E\/\^Y\)\?\n##ge
        en
    endf

    aug  qf_AutocmD
        au!
        " ✗http✗s://www.reddit.com/r/vim/comments/8ofith/comment/e0cj2pr/?utm_source=share&utm_medium=web2x&context=3
        au BufEnter        *    if (winnr('$') == 1 && &buftype ==# 'quickfix' ) | bdelete! | endif
                                "\ tab里只有1个window
        au Syntax   <buffer>    exe 'let g:TOC_line_nums=s:setup_toc()'
                                    "\ 如果不用autocmd 导致help的toc的行号对不齐
        au BufRead         *    if exists('w:quickfix_title') | call s:Clean_qF() | endif
    aug  END


"\ Maintainer:   Lech Lorens <Lech.Lorens@gmail.com>  Last Change:  2019 Jul 15
