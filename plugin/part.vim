if exists('g:loaded_xtract')  | finish  | endif  | let g:loaded_xtract = 1

" Import strings
let g:part_ImportStr = {
    \ "javascript" :  "import %s from './%s'",
    \ }

" Extracts the current selection into a new file.
"     :<range>Part <newfile> <n_HeadLines: optional>
"
" For example:
"
"     :6,8Part newfile
"
com!  -range -bang -nargs=*
    \ Part
    \ :<line1>,<line2>call s:Part(<bang>0,<f-args>)

com!  -range -bang -nargs=*
    \ X
    \ :<line1>,<line2>call s:Part(<bang>0,<f-args>)


fun! s:Part(bang, newFile, ...) range abort
    let n_HeadLines = get(a:, '1')

    let newFile       = s:add_suffix(a:newFile, expand('%:e') )
    " Expand the full newFile path
    if newFile[:1] == '~/'
        let newFile = expand(newFile)
    elseif newFile[0] != '/'
        let newFile = expand('%:h') . '/' .newFile
    en

    if filereadable(newFile) && !a:bang
        return s:error('加!覆盖吧: ' . newFile)
    en

    if n_HeadLines
        silent exe '1,' . n_HeadLines . 'yank x'
    en

    " Capture the indent of the first selected line
    " before the selected lines are removed
    let _indent = s:get_indent(a:firstline)

    " Remove block
    silent exe a:firstline . ',' . a:lastline   . 'del'

    " Keep track of the original line where the content was extracted from
    let ori_line = a:firstline

    " Insert import statement at the end of the header
    " (if n_HeadLines was specified
      " and we have an appropriate import template)
    if n_HeadLines
        let _import = s:get_ImportStr()

        if _import != -1
            let _import = substitute(_import, '%s', a:newFile, 'g')

            " Insert the import statement
            call append(n_HeadLines - 1,   s:get_indent(n_HeadLines - 1) . _import)

            " Advance the original line reference due to the paste
            let ori_line += 1
        en
    en

    " Build a placeHolder comment that refers to the new file that was created
    let placeHolder = s:Comment(&commentstring, newFile)

    " Insert at  where the text was removed
    call append(ori_line - 1, _indent . placeHolder)

    " Place the cursor on the line with the placeHolder comment
    silent exe ori_line . '|'

    " Open newFile buffer
    " and paste the extracted block at the end
    call s:open_buffer(newFile)
    call s:paste_append()

    if n_HeadLines
        " Insert the header
        silent put! x
    en

    " Create the newFile directory if it doesn't already exist
    if !isdirectory( fnamemodify(newFile, ':h') )
        call mkdir(fnamemodify(newFile, ':h'), 'p')
    en

    " Put the cursor at the top of the new buffer
    silent 1

    " Briefly switch to the original window to
    " center the view
    noautocmd wincmd p
    silent exe 'norm! z.'
    noautocmd wincmd p

    " Output message
    let num_lines = a:lastline - a:firstline + 1
    redraw
    echomsg num_lines . '行  挪到了 ' . newFile
endf

"\ helper
    " Open buffer in a split window or focus it if it's already open
    fun! s:open_buffer(name)
        let bufinfo = getbufinfo(a:name)

        if len(bufinfo) > 0
            let bufinfo = bufinfo[0]

            if len(bufinfo.windows) > 0
                call win_gotoid(bufinfo.windows[0])
                return
            en
        en

        silent exe 'split '.a:name
    endf

    fun! s:paste_append()
        let bufwasempty = line('$') == 1 && getline(1) == ''

        " Paste at the end of the buffer
        silent $put

        " If the buffer was empty, delete the residual empty line at the top of the buffer (without taking a register)
        if bufwasempty
            silent 1delete _
        en
    endf

    fun! s:add_suffix(path, ext)
        return a:ext != ''
          \&& fnamemodify(a:path, ':e') == ''
              \? a:path . '.' . a:ext
              \: a:path
    endf

    fun! s:get_indent(line)
        return matchstr(getline(a:line), '^\s*')
    endf

    fun! s:get_ImportStr()
        return get(g:part_ImportStr, &filetype, -1)
    endf

    "
    " from tpope/commentary.vim
    fun! s:Comment(commentString, text)
        " If comment string is empty,
            " start with an %s placeHolder
        "\ (if  makes sense)
            " Pad placeHolder on the left
            " Pad placeHolder on the right
        " Insert comment
        return
            \ substitute(
                        \ substitute(
                                    \ substitute(
                                               \ substitute(a:commentString, '^$', '%s', '') ,
                                               \ '\S\zs%s'                                   ,
                                               \ ' %s'                                       ,
                                               \ ''                                          ,
                                              \ ) ,
                                    \ '%s\ze\S'   ,
                                    \ '%s '       ,
                                    \ ''          ,
                                  \ ) ,
                        \ '%s'        ,
                        \ a:text      ,
                        \ ''          ,
                       \ )
    endf

    "
    " Shows an error message
    "
    fun! s:error(str)
        echohl ErrorMsg
        echomsg a:str
        echohl None
        let v:errmsg = a:str
        return ''
    endf
