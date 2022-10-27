"\ 没啥用, 我已经把不需要swapfile的文件都设置好了


" g:Ns_Debug:
"\ Prints messages in the command area when the 'swapfile' option is enabled or
"\ disabled.
"\ Clear for development / testing,
"\ but can be a little disruptive.


let g:Ns_Debug = get(g:, 'Ns_Debug', 0)

" Unsetting swapfile at startup is useful to prevent the initial message
"Setting NO swapfile" from triggering a "Press ENTER to continue" message
"\ every time you start Vim.
"
" Alternative solutions are to increase 'cmdheight',
" or to disable one of the options.

if g:Ns_Debug
    set noswapfile
en


aug  Ns
    au!


    " Turn swapfile on when opening a file.
    "\ This is needed if we want Vim to check if a swapfile exists in this moment.
  "
    au BufReadPre *  set swapfile

    " Turn swapfile off by default,
    " for any newly opened buffer.
    "
    au BufReadPost * call s:Set_noswaP()

    " It can be rather disruptive to enable the swapfile when we enter Insert  mode,
    " because if an existing swapfile is found,
    " editing will be interrupted while Vim asks what to do next.
    "
    " (There is also a danger that the user will be typing characters to insert,
    " and these will get passed to the swapfile recovery prompt.)
    " (Although it seems the recover prompt does not show when we are in insert
    " mode, although it does interrupt the user a little!)
    "
    " But this is less of an issue since we started using CheckSwapfileOnLoad,
    " so we now enable it by default.
    "
    " Previously we only checked on InsertLeave,
    " and never on InsertEnter.
    " The  disadvantage with that was that you might make a significant edit before
    " discovering the swapfile contains a more recent version of the file.
    "
    au InsertEnter * call s:Set_swaP(1)

    " Or, turn swapfile on
    " *shortly after* we have started editing.
    "
    " Unlike InsertEnter,
    " this won't disturb your typing
    " if Vim discovers than  an old swapfile is present.
    " But that is actually even more annoying,
    " because you then have to deal with the swapfile *after* having entered  some new text!
    "
    "autocmd CursorHoldI * if g:Ns_CreateSwapfileOnInsert | call s:Set_swaP() | endif

    " We always check when leaving Insert mode.
    "
    " If the buffer was modified,
    " a swapfile will be created.
    "
    au InsertLeave * call s:Set_swaP()

    " We also need to check on CursorHold, because editing can be made without
    " ever entering Insert mode!
    "
    au CursorHold * call s:Set_swaP()

    au BufWritePost *  call s:Set_noswaP()

    " If for some reason we didn't want to close the swapfile immediately after  writing
    " (with BufWritePost) then we could do it shortly after instead.
    "
    " But we don't want to always do this,
    " or it would destroy and recreate the  swapfile during a normal edit-save-edit-save workflow.
    "
    "autocmd CursorHold *   if g:Ns_CloseSwapfileOnWrite | call s:Set_noswaP() | endif

    " Since 'swapfile' is a global,
    " we have to keep switching it on/off when we
    " switch between buffers/windows.
    "
    au WinEnter * call s:Set_swaP()
    au WinLeave * call s:Set_noswaP()

    au BufEnter * call s:Set_swaP()
    au BufLeave * call s:Set_noswaP()

aug  END

fun! s:Set_noswaP()
    if &swapfile && !&modified
        if g:Ns_Debug | echom "Setting NO swapfile" | endif
        setl  noswapfile
    en
endf

fun! s:Set_swaP(...)
    let about_to_be_modified = a:0 ? a:1 : 0
    if  !&swapfile
  \ && ( &modified || about_to_be_modified )
  \ &&  get(b:, 'Ns_NoSwapfile', 0)
        if g:Ns_Debug | echom "Setting swapfile" | endif
        setl  swapfile
    en
endf



