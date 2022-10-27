" 前戏
    if bufname() !~ 'txt'  | finish  | en
    if exists("b:did_ftplugin")  | finish  | en
    let b:did_ftplugin = 1

    let s:cpo_save = &cpo  | set cpo&vim
    let b:undo_ftplugin = "setl fo< tw< cole< cocu< keywordprg<"


" set options
    "\ 'tags'
        "\ string  (default "./tags;,tags")
        "\ set   tags=.tag  "\
        "\ set   tags=./.tag
        "\ setl  tags=./.help_tag  "\ ?


    setl  textwidth=140
          " 长行手动换行吧
          " 配合后续的gq或者自动format?
    setl  tabstop=4  shiftwidth=4  shiftround
    setl  formatoptions+=tcroql
    setl  expandtab
          " 不把原本的tab换成space了, 但自己输的tab, 还是会被换成space
    setl  modifiable  noreadonly
    setl  buflisted
    setl  nomodeline

    setl  keywordprg=:help
        " Prefer Vim help instead of manpages.

    setl  formatexpr=Split_line()
        " todo
        " buggy
        " 不用非得涉及v:lnum?
        " set formatexpr=Split_line(v:lnum, v:lnum+v:count-1)

    " echom '我是help.vim的Help_opt' ..   '  时间:' .. strftime("%X")


" DIY开始:
    let a_modeline =  'DIY_2  vim:ft=help:'
    if getline(line('$')) == 'DIY_2  vim:filetype=help:syntax=help:'
                            "\ 加这行 是为了删掉之前写入的¿syntax=help:¿
        call setline(line('$'), a_modeline)
    el
        if getline(line('$')) != a_modeline
            call help#Help_leo_DIY()
            call setline(line('$')+1, a_modeline)
            " call setline(line('$')+2, 'Leo改过')
                                " +2不行
        en
    en

    "\ 关于autocmd设置filetype和syntax:
        "\ $VIMRUNTIME/filetype.vim 里有
            "\ "\ au BufNewFile,BufRead $VIMRUNTIME/doc/*.txt    setf help
            "\ 和  "\
            "\ au BufNewFile,BufRead   *.txt
            "\                 \  if getline('$') !~ 'vim:.*ft=help'
            "\                 \|   setf text
            "\                 \| endif
            "\ 所以要让help文档最后一行含有vim:.*ft=help, (我此前写的是filetype=help)
        "\ 另外, 双保险
            "\ /home/wf/dotF/cfg/nvim/filetype.vim里有:
                "\ au! BufNewFile,BufRead     $HOME/PL/*/doc/*.txt    setf help
                "\ au! BufNewFile,BufRead     $HOME/PL/help_me/vim9/*.txt    setf help


" 补充DIY (无视文末的mode里的已DIY标记)
    let Line_lasT_2 =  'DIY_again'
    if getline(line('$')-1) != Line_lasT_2
        let my_poS = getpos('.')

        " 这导致TOC找不到标题, 算了
            " let _lowed =  'all UPPER converted to Lower'
            " if getline(line('$')-1) != _lowed
            "     exec 'silent % sub #' .. '\v^\s{0,4}[A-Z]\zs[-A-Z0-9._ ]*[A-Z0-9]\ze($|\s+\*)'   .. '#\L\0#ge'
            "     call setline(line('$')-1, a_modeline)
            "     " call setline(line('$')+2, 'Leo改过')
            "                           " +2不行
            " endif

        " 把行末的tag换到下一行
        " 算了, 有的换后会破坏原有的缩进,
                " exec 'silent! % sub #' .. '\v^\s{0,4}[A-Z][-A-Z0-9._ ]*[A-Z0-9]\zs\s+\ze\*'   .. '#\r#gc'

        exec 'silent! % sub #' .. '\VType |gO| to see the table of contents.'   .. '##ge'
        exec 'silent! % sub #^\s*VIM REFERENCE MANUAL    by Bram Moolenaar$##ge'
        exec 'silent! % sub #' .. 'ctrl-'   .. '#\L\0#ge'
        exec 'silent! % sub #' .. 'ctrl-\u' .. '#\L\0#ge'


        call setline(line('$')-1, Line_lasT_2)

        call histdel('search', -4,)
                  " 清掉本函数内的搜索历史
        call setpos('.', my_poS)
            " 之前忘了加这个,导致光标老是在 filetype detect后跑开
    en


" map
    nno <cr>  <Cmd>call To_help_tagS()<cr>
        func! To_help_tagS()
            let isk_  = &isk
            setl  iskeyword=!-~,^34,^42,^124,192-255
                " setl  iskeyword&
                " 会变成vim的default, 而非help的
                " 之前能用setl  iskeyword&, 因为是在autocmd FileType help call ...
                      "

                " 失败记录:
                    " exe 'setl  iskeyword=!-~,^34,^42,^124,192-255'
                    " 不能直接这么设,(特殊符号)
                    " 要escape?
                    " setl  iskeyword=!-~,^*,^|,^",192-255

                    " 哪一行错了? (我记得这样用是没问题的: set isk-=a)
                        " setl  iskeyword=!-~
                        " setl  iskeyword-=*
                        " setl  iskeyword-=\|
                        " setl  iskeyword-=\"
                        "
                        " setl  iskeyword+=192-255

            exe "norm!  \<c-]>"
                " special character in ¿:normal¿ command:   use exe
                " fail trial
                    " exe 'normal'  '<c-f>'
                    " exe 'normal'  '<c-]>'
                    " exe 'normal'  '<lt>c-]>'   这导致dedent
                    "      normal    <c-]>

                    " normal "tyw
                    " let aa = @t
                    " exe 'tag' aa
                    " exe 'tag' @t
                    " 报错: tag i_ctrl-^

            exe 'setl isk='..&isk
        endf
             " \<cmd>setl iskeyword=@,48-57,-,_<cr>
             " 官方的ftplugin或syntax目录的help.vim, 都没有找到isk, 只在:help 'isk'里有提到

    nno  <buffer> <silent> zh /\v\*.+\*$<cr>
    vno  <buffer> <silent> zh /\v\*.+\*$<cr>
            " 找出helptag
            " 不用了, <leader>ol  折叠非helptag?
    nno  <buffer> <silent>         go <Cmd>call help#TOC_all_in_1()<cr>
    nno  <buffer> <silent>  <Space>ol <cmd>call Help_outlinE()<cr>
                                   " ol: outline
                                    fun! Help_outlinE()
                                        call funcS#Out_linE('\v(\*.+\*|\~)$')
                                    endf

        " 用<buffer> 如何传到help buffer? (这样就不用autocmd了)
                            " &buftype在BufAdd之后才更新, 导致这些autocmd滞后一次?
                            " 要敲:help才能设置buftype为help, 用if  &buftype=help 有些bug?
                            " 先不用&buftype


    nno <silent> <buffer>  wo  <Cmd>call Option_iS()<cr>
                           " want option
    vno <silent> <buffer>  wo "oy<cmd>exe 'Verbose set' @o..'?'<cr>


au AG  BufWritePost <buffer> sil! helptags ALL


let &cpo = s:cpo_save  | unlet s:cpo_save
