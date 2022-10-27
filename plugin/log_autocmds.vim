command! LogAutocmds call s:log_autocmds_toggle()
" cnorea  l <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'LogAutocmds' : 'l')<CR>

function! s:log_autocmds_toggle()
    augroup LogAutocmd
        autocmd!
    augroup END

    let l:date = strftime('%F', localtime())
    let s:activate = get(s:, 'activate', 0) ? 0 : 1
    if !s:activate
        call s:log('结束 autocmd log (' . l:date . ')')
        return
    endif

    call s:log('开始记录 (' . l:date . ')')
    augroup LogAutocmd
        for l:au in s:aulist
            silent execute 'autocmd' l:au  ' *   call s:log(''' . l:au . ''') '
                                           " 任意pattern都触发列出的event
        endfor
    augroup END
endfunction

function! s:log(message)
    silent execute '!echo "'
                \ . strftime('%T', localtime()) . ' - ' . a:message . '"'
                \ '>> /tmp/vim_log_autocommands'
endfunction

" These are deliberately left out due to side effects
    " - SourceCmd
    " - FileAppendCmd
    " - FileWriteCmd
    " - BufWriteCmd
    " - FileReadCmd
    " - BufReadCmd
    " - FuncUndefined

let s:aulist = [
            \ 'Syntax',
            \ 'FileType',
            \ 'BufNewFile',
            \ 'BufReadPre',
            \ 'BufReadPost',
            \ 'BufWritePre',
            \ 'BufWritePost',
            \ 'BufAdd',
            \ 'BufCreate',
            \ 'BufDelete',
            \ 'BufWipeout',
            \ 'BufFilePre',
            \ 'BufFilePost',
            \
            \ 'BufEnter',
            \ 'BufLeave',
            \
            \ 'BufWinEnter',
            \ 'BufWinLeave',
            \
            \ 'BufUnload',
            \ 'BufHidden',
            \ 'BufNew',
            \
            \ 'WinLeave',
            \
            \ 'TabLeave',
            \
            \ 'CmdwinEnter',
            \ 'CmdwinLeave',
            \
            \ 'User',
            \ ]

    " 先不管:
            " \ 'FileWritePre',
            " \ 'FileWritePost',
            " \ 'FileAppendPre',
            " \ 'FileAppendPost',
            " \ 'FilterWritePre',
            " \ 'FilterWritePost',
            " \ 'SwapExists',
            " \ 'FileType',
            " \ 'Syntax',
            " \ 'EncodingChanged',
            " \ 'TermChanged',
            " \ 'VimEnter',
            " \ 'GUIEnter',
            " \ 'GUIFailed',
            " \ 'TermResponse',
            " \ 'QuitPre',
            " \ 'VimLeavePre',
            " \ 'VimLeave',
            " \ 'FileChangedShell',
            " \ 'FileChangedShellPost',
            " \ 'FileChangedRO',
            " \ 'ShellCmdPost',
            " \ 'ShellFilterPost',
            " \ 'CmdUndefined',
            " \ 'SpellFileMissing',
            " \ 'SourcePre',
            " \ 'VimResized',
            " \ 'FocusGained',
            " \ 'FocusLost',
            " \ 'CursorHold',
            " \ 'CursorHoldI',
            " \ 'CursorMoved',
            " \ 'CursorMovedI',
            " \ 'InsertEnter',
            " \ 'InsertChange',
            " \ 'InsertLeave',
            " \ 'InsertCharPre',
            " \ 'TextChanged',
            " \ 'TextChangedI',
            " \ 'ColorScheme',
            " \ 'RemoteReply',
            " \ 'QuickFixCmdPre',
            " \ 'QuickFixCmdPost',
            " \ 'SessionLoadPost',
            " \ 'MenuPopup',
            " \ 'CompleteDone',
            " "
