" 废了它:
" /home/linuxbrew/.linuxbrew/Cellar/neovim/0.6.1/share/nvim/runtime/autoload/man.vim

if exists('s:loaded_man')
    finish
endif

let s:loaded_man = 1
     " 官方的很多autoload  都是用g:loaded_某某
     " 但官方的本文件用s:loaded_man, 而非g:
     " 因为有plugin/man.vim里有这个定义:
        " command! -bang Man
        " (要让任何buffer里都能用:Man, 所以放在在plugin/ 而非ftplugin/)

    " 如果这里用g:loaded_man, 导致非man的buffer里, plugin/man.vim会finish:
        " if exists('g:loaded_man')
        "   finish
        " endif
        " let g:loaded_man = 1

     " 这个文件改了后, 要重启nvim才生效
     " 但这就导致在ReloaD()里用 Runtime /home/wf/dotF/cfg/nvim/autoload/man.vim 无效
     "
     " 或者手动unlet s:let s:loaded_man = 1 ?



let s:find_arg = '-w'
let s:localfile_arg = v:true    " Always use -l if possible. #6683
let s:section_arg = '-S'

fu! man#init() abort
    try
        " Check for -l support.
        call s:get_page(s:get_path('', 'man'))
    catch /command error .*/
        let s:localfile_arg = v:false
    endtry

    endf

fu! man#open_page(count, mods, ...) abort
    if a:0 > 2
        call s:error('too many arguments')
        return
    elseif a:0 == 0
        let ref =    &filetype ==# 'man' ? expand('<cWORD>') : expand('<cword>')
        if empty(ref)
            call s:error('no identifier under cursor')
            return
        endif
    elseif a:0 ==# 1
        let ref = a:1
    else
        " Combine the name and sect into a manpage reference so that all
        " verification/extraction can be kept in a single fu.
        " If a:2 is a reference as well, that is fine because it is the only
        " reference that will match.
        let ref = a:2.'('.a:1.')'
    endif
    try
        let [sect, name] = s:extract_sect_and_name_ref(ref)
        if a:count >= 0
            let sect = string(a:count)
        endif
        let path = s:verify_exists(sect, name)
        let [sect, name] = s:extract_sect_and_name_path(path)
    catch
        call s:error(v:exception)
        return
    endtry

    let [l:buf, l:save_tfu] = [bufnr(), &tagfunc]
    try
        setlocal tagfunc=man#goto_tag
        let l:target = l:name . '(' . l:sect . ')'
        if a:mods !~# 'tab' && s:find_man()
            execute 'silent keepalt tag' l:target
        else
            execute 'silent keepalt' a:mods 'stag' l:target
        endif
        call s:set_options(v:false)
    finally
        call setbufvar(l:buf, '&tagfunc', l:save_tfu)
    endtry

    let b:man_sect = sect
    endf

fu! man#read_page(ref) abort
" Called when a man://   buffer is opened.
" 给他用:
    " autocmd BufReadCmd  man://*  call man#read_page(matchstr(expand('<amatch>'), 'man://\zs.*'))
    try
        let [sect, name] = s:extract_sect_and_name_ref(a:ref)
        let path = s:verify_exists(sect, name)
        let [sect, name] = s:extract_sect_and_name_path(path)
        let page = s:get_page(path)
    catch
        call s:error(v:exception)
        return
    endtry
    let b:man_sect = sect
    call s:put_page(page)
    endf

fu! s:system_handler(jobid, data, event) dict abort
" Handler for s:system() function
    if a:event is# 'stdout' || a:event is# 'stderr'
        let self[a:event] .= join(a:data, "\n")
    else
        let self.exit_code = a:data
    endif
    endf

" Run a system command and timeout after 30 seconds.
fu! s:system(cmd, ...) abort
    let opts = {
                \ 'stdout': '',
                \ 'stderr': '',
                \ 'exit_code': 0,
                \ 'on_stdout': function('s:system_handler'),
                \ 'on_stderr': function('s:system_handler'),
                \ 'on_exit': function('s:system_handler'),
                \ }
    let jobid = jobstart(a:cmd, opts)

    if jobid < 1
        throw printf('command error %d: %s', jobid, join(a:cmd))
    endif

    let res = jobwait([jobid], 30000)
    if res[0] == -1
        try
            call jobstop(jobid)
            throw printf('command timed out: %s', join(a:cmd))
        catch /^Vim(call):E900:/
        endtry
    elseif res[0] == -2
        throw printf('command interrupted: %s', join(a:cmd))
    endif
    if opts.exit_code != 0
        throw printf("command error (%d) %s: %s", jobid, join(a:cmd), substitute(opts.stderr, '\_s\+$', '', &gdefault ? '' : 'g'))
    endif

    return opts.stdout
    endf

fu! s:set_options(pager) abort
    setlocal filetype=man
    setlocal            noreadonly modifiable
    " setlocal noswapfile buftype=nofile bufhidden=hide
    " setlocal nomodified readonly nomodifiable

    if a:pager
        nnoremap <silent> <buffer> <nowait>    q :lclose<CR>:q<CR>
    endif
    endf

fu! s:get_page(path) abort
    " Disable hard-wrap by using a big $MANWIDTH (max 1000 on some systems #9065).
        " Soft-wrap: ftplugin/man.vim sets wrap/breakindent/….
        " Hard-wrap: driven by `man`.
    let manwidth = !get(g:, 'man_hardwrap', 1)
                \ ? 999
                \ : (empty($MANWIDTH)
                        \ ? winwidth(0)
                        \ : $MANWIDTH)

    " \关键一步: 像shell里那样调用  ¿man¿
    let cmd = [
        \'env',
        \'MANPAGER=cat',
            "\ Force MANPAGER=cat to ensure Vim is not recursively invoked (by man-db).
            "\ http://comments.gmane.org/gmane.editors.vim.devel/29085
        \'MANWIDTH='.manwidth,
        \'MAN_KEEP_FORMATTING=1',
            "\ Set MAN_KEEP_FORMATTING so Debian man doesn't discard backspaces.
        \'man',
        \]
    return s:system(cmd + (s:localfile_arg ? ['-l', a:path] : [a:path]))
    endf

fu! s:put_page(page) abort
    setlocal modifiable noreadonly
    silent keepjumps %delete _
    silent put =a:page
    while getline(1) =~# '^\s*$'
        silent keepjumps 1delete _
    endwhile
    " XXX: nroff justifies text by filling it with whitespace.
        " That interacts  badly with our use of $MANWIDTH=999.
        " Hack around this by using a fixed size for those whitespace regions.
    silent! keeppatterns keepjumps %s/\s\{199,}/\=repeat(' ', 10)/g
    1
    lua require("man").highlight_man_page()
    call s:set_options(v:false)
    endf
let toc_lines = []

fu! man#TOC_leo() abort
    let _bufname = bufname('%')
    " 这段删了会导致有时变慢?
    let info = getloclist(0, {'winid': 1})
    if !empty(info) && getwinvar(info.winid, 'qf_toc') ==# _bufname
        echom '进了/home/wf/dotF/cfg/nvim/autoload/man.vim的  if分支'
        lopen
        return
    else
        let toc_lines = []
        let lNum = 2
        let last_line = line('$') - 1
        while lNum >0 && lNum < last_line
            let add_text = getline(lNum)
            " if add_text =~ '\v^\s{3,4}\S.*$' || add_text =~ '\v^\S.*$'
            if add_text =~ '\v^\s{3}\S.*$' || add_text =~ '\v^\S.*$'
                                  " 空格数为3    或0      或者4空格 数字 一个点. 空格 (numbered list)
            " if add_text =~# '\v^' .. '(' .. '( {3})|' .. '|' .. '( {4}\d\. )' .. '( {4}• )' .. ')\S.*$'
                                                                                      " 字符• 太特殊 不行?
                                                                                      " 不用numbered list 就全用0吧
                let level = count(add_text, '^ ') > 0 ? 1 : 0

                let add_text = substitute(add_text, '\v\s+$', '', 'g')
                call add(  toc_lines,
                          \{
                          \'bufnr'  : bufnr('%'),
                          \'lnum'   : lNum,
                          \'text'   : '++++'->repeat(level) .. add_text,
                          "\ 单引号里的空格会被清掉,  无法缩进
                          \},
                        \)
            endif
            let lNum = nextnonblank(lNum + 1)
        endwhile

        call setloclist(0, toc_lines, ' ')
        call setloclist(0, [], 'a', {'title': 'man TOC'})
        lopen
        let w:qf_toc = _bufname
    endif
    endf


fu! s:extract_sect_and_name_ref(ref) abort
" attempt to extract the name and sect out of 'name(sect)'
    " otherwise just return the largest string of valid characters in ref

    if a:ref[0] ==# '-' " try ':Man -pandoc' with this disabled.
        throw 'manpage name cannot start with ''-'''
    endif
    let ref = matchstr(a:ref, '[^()]\+([^()]\+)')
    if empty(ref)
        let name = matchstr(a:ref, '[^()]\+')
        if empty(name)
            throw 'manpage reference cannot contain only parentheses'
        endif
        return ['', s:spaces_to_underscores(name)]
    endif
    let left = split(ref, '(')
    " see ':Man 3X curses' on why tolower.
    " TODO(nhooyr) Not sure if this is portable across OSs
    " but I have not seen a single uppercase section.
    return [tolower(split(left[1], ')')[0]), s:spaces_to_underscores(left[0])]

    endf

fu! s:spaces_to_underscores(str)
" Intended for man pages like ¿'CREATE_TABLE(7)'¿ :
" replace spaces in a man page name with underscores
    " while editing SQL source code,
    " it's nice to visually select 'CREATE TABLE'
    " and hit 'K',
    " which requires this transformation
    return substitute(a:str, ' ', '_', 'g')

    endf

fu! s:get_path(sect, name) abort
" Some man implementations (OpenBSD) return all available paths from the
" search command, so we get() the first one. #8341
    if empty(a:sect)
        return substitute(get(split(s:system(['man', s:find_arg, a:name])), 0, ''), '\n\+$', '', '')
    endif
    " '-s' flag handles:
    "       - tokens like 'printf(echo)'
    "       - sections starting with '-'
    "       - 3pcap section (found on macOS)
    "       - commas between sections (for section priority)
    return substitute(get(split(s:system(['man', s:find_arg, s:section_arg, a:sect, a:name])), 0, ''), '\n\+$', '', '')

    endf

fu! s:verify_exists(sect, name) abort
" s:verify_exists attempts to find the path to a manpage
" based on the passed section and name.

    " 1. If the passed section is empty, b:man_default_sects is used.
    " 2. If manpage could not be found with the given sect and name,
    "        then another attempt is made with b:man_default_sects.
    " 3. If it still could not be found, then we try again without a section.
    " 4. If still not found but $MANSECT is set, then we try again with $MANSECT
    "        unset.

    " This function is careful to avoid duplicating a search if a previous
    " step has already done it. i.e if we use b:man_default_sects in step 1,
    " then we don't do it again in step 2.

    let sect = a:sect
    if empty(sect)
        let sect = get(b:, 'man_default_sects', '')
    endif

    try
        return s:get_path(sect, a:name)
    catch /^command error (/
    endtry

    if !empty(get(b:, 'man_default_sects', '')) && sect !=# b:man_default_sects
        try
            return s:get_path(b:man_default_sects, a:name)
        catch /^command error (/
        endtry
    endif

    if !empty(sect)
        try
            return s:get_path('', a:name)
        catch /^command error (/
        endtry
    endif

    if !empty($MANSECT)
        try
            let MANSECT = $MANSECT
            call setenv('MANSECT', v:null)
            return s:get_path('', a:name)
        catch /^command error (/
        finally
            call setenv('MANSECT', MANSECT)
        endtry
    endif

    throw 'no manual entry for ' . a:name

    endf

fu! s:extract_sect_and_name_path(path) abort
" Extracts the name/section from the 'path/name.sect',
    " because sometimes the actual section is  more specific than what we provided to `man` (try `:Man 3 App::CLI`).
    " Also on linux, name seems to be case-insensitive.
    " So for `:Man PRIntf`, we  still want the name of the buffer to be ¿'printf'¿
    let tail = fnamemodify(a:path, ':t')
    if a:path =~# '\.\%([glx]z\|bz2\|lzma\|Z\)$' " valid extensions
        let tail = fnamemodify(tail, ':r')
    endif
    let sect = matchstr(tail, '\.\zs[^.]\+$')
    let name = matchstr(tail, '^.\+\ze\.')
    return [sect, name]
endf

fu! s:find_man() abort
    let l:win = 1
    while l:win <= winnr('$')
        let l:buf = winbufnr(l:win)
        if getbufvar(l:buf, '&filetype', '') ==# 'man'
            execute l:win.'wincmd w'
            return 1
        endif
        let l:win += 1
    endwhile
    return 0
endf

fu! s:error(msg) abort
    redraw
    echohl ErrorMsg
    echon 'man.vim: ' a:msg
    echohl None
endf

fu! man#complete(arg_lead, cmd_line, cursor_pos) abort
" see s:extract_sect_and_name_ref on why tolower(sect)
    let args = split(a:cmd_line)
    let cmd_offset = index(args, 'Man')
    if cmd_offset > 0
        " Prune all arguments up to :Man itself. Otherwise modifier commands like
        " :tab, :vertical, etc. would lead to a wrong length.
        let args = args[cmd_offset:]
    endif
    let l = len(args)
    if l > 3
        return
    elseif l ==# 1
        let name = ''
        let sect = ''
    elseif a:arg_lead =~# '^[^()]\+([^()]*$'
        " cursor (|) is at ':Man printf(|' or ':Man 1 printf(|'
        " The later is is allowed because of ':Man pri<TAB>'.
        " It will offer 'priclass.d(1m)' even though section is specified as 1.
        let tmp = split(a:arg_lead, '(')
        let name = tmp[0]
        let sect = tolower(get(tmp, 1, ''))
        return s:complete(sect, '', name)
    elseif args[1] !~# '^[^()]\+$'
        " cursor (|) is at ':Man 3() |' or ':Man (3|' or ':Man 3() pri|'
        " or ':Man 3() pri |'
        return
    elseif l ==# 2
        if empty(a:arg_lead)
            " cursor (|) is at ':Man 1 |'
            let name = ''
            let sect = tolower(args[1])
        else
            " cursor (|) is at ':Man pri|'
            if a:arg_lead =~# '\/'
                " if the name is a path, complete files
                " TODO(nhooyr) why does this complete the last one automatically
                return glob(a:arg_lead.'*', 0, 1)
            endif
            let name = a:arg_lead
            let sect = ''
        endif
    elseif a:arg_lead !~# '^[^()]\+$'
        " cursor (|) is at ':Man 3 printf |' or ':Man 3 (pr)i|'
        return
    else
        " cursor (|) is at ':Man 3 pri|'
        let name = a:arg_lead
        let sect = tolower(args[1])
    endif
    return s:complete(sect, sect, name)
endf

fu! s:get_paths(sect, name, do_fallback) abort
" callers must try-catch this, as some `man` implementations don't support `s:find_arg`
    try
        let mandirs = join(split(s:system(['man', s:find_arg]), ':\|\n'), ',')
        let paths = globpath(mandirs, 'man?/'.a:name.'*.'.a:sect.'*', 0, 1)
        try
            " Prioritize the result from verify_exists as it obeys b:man_default_sects.
            let first = s:verify_exists(a:sect, a:name)
            let paths = filter(paths, 'v:val !=# first')
            let paths = [first] + paths
        catch
        endtry
        return paths
    catch
        if !a:do_fallback
            throw v:exception
        endif

        " Fallback to a single path, with the page we're trying to find.
        try
            return [s:verify_exists(a:sect, a:name)]
        catch
            return []
        endtry
    endtry
endf

fu! s:complete(sect, psect, name) abort
    let pages = s:get_paths(a:sect, a:name, v:false)
    " We remove duplicates in case the same manpage in different languages was found.
    return uniq(sort(map(pages, 's:format_candidate(v:val, a:psect)'), 'i'))
endf

fu! s:format_candidate(path, psect) abort
    if a:path =~# '\.\%(pdf\|in\)$' " invalid extensions
        return
    endif
    let [sect, name] = s:extract_sect_and_name_path(a:path)
    if sect ==# a:psect
        return name
    elseif sect =~# a:psect.'.\+$'
        " We include the section if the user provided section is a prefix
        " of the actual section.
        return name.'('.sect.')'
    endif
endf

fu! man#init_pager() abort
" Called when
    " Nvim is invoked as $MANPAGER.
    " 或者:Man
    "     :Man!

    let og_modifiable = &modifiable
    setlocal modifiable
        " https://github.com/neovim/neovim/issues/6828

    if getline(1) =~# '^\s*$'
        silent keepjumps 1delete _
    else
        keepjumps 1
    endif
    lua require("man").highlight_man_page()
    let ref = substitute(matchstr(getline(1), '^[^)]\+)'), ' ', '_', 'g')
        " Guess the ref from the heading (which is usually uppercase,
        " so we cannot  know the correct casing, cf. `man glDrawArraysInstanced`).

    try
        let b:man_sect = s:extract_sect_and_name_ref(ref)[0]
    catch
        let b:man_sect = ''
    endtry

    if -1 == match(bufname('%'), 'man:\/\/')    " Avoid duplicate buffers, E95.
            " If there is no match,  1 is returned.

        execute 'silent file man://' . tolower(fnameescape(ref))
    endif

    call s:set_options(v:true)
    let &l:modifiable = og_modifiable
endf

fu! man#goto_tag(pattern, flags, info) abort
    let [l:sect, l:name] = s:extract_sect_and_name_ref(a:pattern)

    let l:paths = s:get_paths(l:sect, l:name, v:true)
    let l:structured = []

    for l:path in l:paths
        let [l:sect, l:name] = s:extract_sect_and_name_path(l:path)
        let l:structured += [{
                    \ 'name': l:name,
                    \ 'title': l:name . '(' . l:sect . ')'
                    \ }]
    endfor

    if &cscopetag
        " return only a single entry so we work well with :cstag (#11675)
        let l:structured = l:structured[:0]
    endif

    return map(l:structured, {
    \  _, entry -> {
    \            'name': entry.name,
    \            'filename': 'man://' . entry.title,
    \            'cmd': '1'
    \        }
    \  })
endf

call man#init()

" todo: test it
function! man#Short_maN()
    mark s
    exec '% subs#\v\S\zs  \ze\S# #ge'
                    " 行内的2个空格变1个
    silent! % sub #\v^ {1,3}\ze\S#    #ge
    silent! % sub #\v^ {5,7}\ze\S#        #ge
    silent! % sub #\v^ {9,11}\ze\S#            #ge
    silent! % sub #\v^\s*\zsnote that ##ge
    norm! `s
endfunction
